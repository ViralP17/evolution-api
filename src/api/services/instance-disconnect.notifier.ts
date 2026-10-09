import { WebhookUrlParserUtil } from '@api/utils/webhook-url-parser.util';
import { configService, HttpServer } from '@config/env.config';
import { Logger } from '@config/logger.config';
import axios from 'axios';

/**
 * Our custom disconnect webhook — not part of Evolution's standard event system.
 *
 * Posted unconditionally whenever an instance permanently loses its WhatsApp session. It
 * deliberately bypasses the standard webhook system, so it does not depend on the instance's
 * webhook settings or its `events` subscription list.
 *
 * Payload: the same envelope as the SQS `connection.update` message the CRM already consumes
 * (userid, dbname, event, instance, dataType, data{instance,state,statusReason}, server,
 * server_url, date_time, sender, apikey). Our extra details are added inside `data`, after
 * the standard keys, so existing parsing is unaffected.
 *
 * Target: INSTANCE_DISCONNECT_WEBHOOK_URL is posted to as-is. The `userid` and `dbname` (the CRM
 * tenant) are taken per instance from that instance's own webhook URL — the same parameters
 * WebhookUrlParserUtil extracts for SQS — and sent in the JSON body.
 *
 * Not sent for transient drops that auto-reconnect (428, 515, 440), nor for instance deletion
 * (that stays on the standard `instance.delete` event).
 *
 * The receiver is untrusted: nothing here may crash the process or slow WhatsApp. Callers never
 * await this; every async path is caught; requests have a hard total deadline, no redirects,
 * a capped response size; and in-flight deliveries are bounded.
 */

export const DISCONNECT_WEBHOOK_EVENT = 'connection.update';

export type DisconnectTrigger = 'whatsapp' | 'manual' | 'system';

export type InstanceDisconnectedInput = {
  instanceName: string;
  instanceId: string;
  ownerJid?: string | null;
  profileName?: string | null;
  apikey?: string | null;
  trigger: DisconnectTrigger;
  reasonCode?: number | null;
  reasonType?: 'MANUAL_LOGOUT' | 'DUPLICATE_NUMBER';
  // Returns the instance's own webhook URL, which carries its `userid` / `dbname`.
  resolveWebhookUrl: () => Promise<string | null | undefined>;
};

const logger = new Logger('InstanceDisconnectNotifier');

const TIMEOUT_MS = Number(process.env.INSTANCE_DISCONNECT_WEBHOOK_TIMEOUT_MS) || 15_000;
const LOOKUP_TIMEOUT_MS = 5_000;
const MAX_RESPONSE_BYTES = 64 * 1024;

// Delay before each retry: 5s, 20s, 1m, 3m, 10m — 6 attempts over ~14 minutes.
const RETRY_DELAYS_MS = [5_000, 20_000, 60_000, 180_000, 600_000];

// Upper bound on deliveries running or waiting to retry, so a dead receiver during a
// mass disconnect cannot pile up timers and sockets without limit.
const MAX_IN_FLIGHT = 200;
let inFlight = 0;

// Drops are summarised in one log line per interval instead of one line each.
const DROP_LOG_INTERVAL_MS = 30_000;
let droppedSinceLog = 0;
let lastDropLogAt = 0;

// A single disconnect can surface through more than one code path; never alert twice.
const DEDUPE_WINDOW_MS = 60_000;
const lastSentAt = new Map<string, number>();

function pruneDedupe(now: number) {
  if (lastSentAt.size < 1000) {
    return;
  }
  for (const [id, sentAt] of lastSentAt) {
    if (now - sentAt >= DEDUPE_WINDOW_MS) {
      lastSentAt.delete(id);
    }
  }
}

const http = axios.create({
  timeout: TIMEOUT_MS,
  maxRedirects: 0,
  maxContentLength: MAX_RESPONSE_BYTES,
  maxBodyLength: MAX_RESPONSE_BYTES,
  responseType: 'text',
  validateStatus: (status) => status >= 200 && status < 300,
});

const WHATSAPP_REASONS: Record<number, { type: string; message: string }> = {
  401: {
    type: 'LOGGED_OUT',
    message:
      'WhatsApp logged out this session (the device was removed from Linked Devices on the phone, or WhatsApp invalidated the session).',
  },
  403: {
    type: 'FORBIDDEN',
    message: 'WhatsApp refused the connection. The number may be restricted or banned — check it in the WhatsApp app.',
  },
  408: {
    type: 'TIMED_OUT',
    message: 'The connection to WhatsApp timed out and the session was closed.',
  },
};

function describe(input: InstanceDisconnectedInput): { type: string; message: string } {
  if (input.reasonType === 'MANUAL_LOGOUT') {
    return { type: 'MANUAL_LOGOUT', message: 'The instance was disconnected through the logout API.' };
  }
  if (input.reasonType === 'DUPLICATE_NUMBER') {
    return {
      type: 'DUPLICATE_NUMBER',
      message: 'This number is already connected on another instance, so this instance was disconnected.',
    };
  }
  return (
    (input.reasonCode != null ? WHATSAPP_REASONS[input.reasonCode] : undefined) ?? {
      type: 'CLOSED_BY_WHATSAPP',
      message: `WhatsApp closed the session (code ${input.reasonCode ?? 'unknown'}).`,
    }
  );
}

function withTimeout<T>(promise: Promise<T>, ms: number): Promise<T> {
  let timer: NodeJS.Timeout;
  const deadline = new Promise<T>((_, reject) => {
    timer = setTimeout(() => reject(new Error(`timed out after ${ms}ms`)), ms);
  });
  return Promise.race([promise, deadline]).finally(() => clearTimeout(timer));
}

type Payload = ReturnType<typeof buildPayload>;

// Same shape as the SQS `connection.update` message; key order kept identical.
function buildPayload(input: InstanceDisconnectedInput, tenant: { userid?: string; dbname?: string }) {
  const reason = describe(input);
  const ownerJid = input.ownerJid || null;
  const server = configService.get<HttpServer>('SERVER');

  return {
    userid: tenant.userid ?? null,
    dbname: tenant.dbname ?? null,
    event: DISCONNECT_WEBHOOK_EVENT,
    instance: input.instanceName,
    dataType: 'json',
    data: {
      instance: input.instanceName,
      state: 'close',
      // Manual logout and duplicate-number have no WhatsApp code; logoutInstance() reports 401
      // for them in its own connection state, so the same value is used here.
      statusReason: input.reasonCode ?? 401,
      // Our additions — after the standard keys.
      instanceId: input.instanceId,
      number: ownerJid ? ownerJid.split('@')[0].split(':')[0] : null,
      profileName: input.profileName || null,
      trigger: input.trigger,
      reasonType: reason.type,
      message: `${reason.message} Scan the QR code again to reconnect.`,
    },
    server: server.NAME,
    server_url: server.URL,
    date_time: new Date().toISOString(),
    sender: ownerJid,
    apikey: input.apikey || null,
  };
}

// One per notification. `release` frees its in-flight slot exactly once, whichever path ends it.
type Job = { released: boolean };

function release(job: Job) {
  if (!job.released) {
    job.released = true;
    inFlight--;
  }
}

// HTTP Basic Auth for the receiver, if configured.
function basicAuth(): { username: string; password: string } | undefined {
  const username = process.env.INSTANCE_DISCONNECT_WEBHOOK_USERNAME;
  if (!username) {
    return undefined;
  }
  return { username, password: process.env.INSTANCE_DISCONNECT_WEBHOOK_PASSWORD ?? '' };
}

// First 500 chars of the receiver's error body (e.g. a PHP error), for the failure logs.
function responseSnippet(failure: any): string | undefined {
  const data = failure?.response?.data;
  if (data == null || data === '') {
    return undefined;
  }
  return (typeof data === 'string' ? data : JSON.stringify(data)).slice(0, 500);
}

async function deliver(job: Job, url: string, payload: Payload, attempt: number): Promise<void> {
  let failure: any = null;
  try {
    await http.post(url, payload, {
      auth: basicAuth(),
      // `timeout` above is an idle timer; this is a hard deadline for the whole request, so a
      // receiver that trickles bytes cannot hold the socket open.
      signal: AbortSignal.timeout(TIMEOUT_MS),
      headers: {
        'Content-Type': 'application/json',
        'X-Event-Type': DISCONNECT_WEBHOOK_EVENT,
        'X-Instance-Name': payload.instance,
      },
    });
  } catch (error) {
    failure = error;
  }

  if (!failure) {
    release(job);
    logger.log({ message: 'disconnect webhook delivered', instance: payload.instance, attempt: attempt + 1 });
    return;
  }

  const delay = RETRY_DELAYS_MS[attempt];
  if (delay === undefined) {
    release(job);
    // Full payload is logged so the event can be replayed by hand.
    logger.error({
      message: `disconnect webhook delivery FAILED after ${attempt + 1} attempts`,
      url,
      error: failure?.message,
      status: failure?.response?.status,
      response: responseSnippet(failure),
      payload,
    });
    return;
  }

  logger.warn({
    message: `disconnect webhook delivery failed, retrying in ${delay / 1000}s`,
    instance: payload.instance,
    attempt: attempt + 1,
    error: failure?.message,
    status: failure?.response?.status,
    response: responseSnippet(failure),
  });
  setTimeout(() => {
    deliver(job, url, payload, attempt + 1).catch(() => release(job));
  }, delay);
}

async function run(job: Job, baseUrl: string, input: InstanceDisconnectedInput): Promise<void> {
  const webhookUrl = await withTimeout(Promise.resolve().then(input.resolveWebhookUrl), LOOKUP_TIMEOUT_MS).catch(
    (error) => {
      logger.warn({
        message: 'disconnect webhook: webhook lookup failed',
        instance: input.instanceName,
        error: error?.message,
      });
      return null;
    },
  );

  const tenant = WebhookUrlParserUtil.extractParamsFromUrl(webhookUrl ?? undefined);
  if (!tenant.dbname) {
    release(job);
    logger.warn({
      message: 'disconnect webhook NOT sent: instance webhook URL has no dbname',
      instance: input.instanceName,
      webhookUrl: webhookUrl ?? null,
    });
    return;
  }

  // `userid` / `dbname` travel in the JSON body only — the receiver reads them from there,
  // and adding them to the query string makes it fail.
  await deliver(job, baseUrl, buildPayload(input, tenant), 0);
}

/**
 * Fire-and-forget: returns immediately, never throws, never rejects.
 */
export function notifyInstanceDisconnected(input: InstanceDisconnectedInput): void {
  try {
    const baseUrl = process.env.INSTANCE_DISCONNECT_WEBHOOK_URL?.trim();
    if (!baseUrl) {
      return;
    }
    new URL(baseUrl); // reject a malformed env value up front

    const now = Date.now();
    const previous = lastSentAt.get(input.instanceId);
    if (previous && now - previous < DEDUPE_WINDOW_MS) {
      return;
    }

    if (inFlight >= MAX_IN_FLIGHT) {
      droppedSinceLog++;
      if (now - lastDropLogAt >= DROP_LOG_INTERVAL_MS) {
        logger.error({
          message: `disconnect webhook dropped ${droppedSinceLog} event(s): ${inFlight} deliveries already pending`,
          lastDroppedInstance: input.instanceName,
        });
        droppedSinceLog = 0;
        lastDropLogAt = now;
      }
      return;
    }

    pruneDedupe(now);
    lastSentAt.set(input.instanceId, now);
    inFlight++;
    const job: Job = { released: false };
    run(job, baseUrl, input).catch((error) => {
      release(job);
      logger.error({ message: 'disconnect webhook failed', instance: input.instanceName, error: error?.message });
    });
  } catch (error) {
    logger.error({ message: 'disconnect webhook could not be queued', error: error?.message });
  }
}
