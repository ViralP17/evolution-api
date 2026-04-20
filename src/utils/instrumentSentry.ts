import { configService, Sentry as SentryConfig } from '@config/env.config';
import * as Sentry from '@sentry/node';

const sentryConfig = configService.get<SentryConfig>('SENTRY');
type ConsoleLogLevel = 'log' | 'warn' | 'error' | 'info' | 'debug' | 'assert' | 'trace';

const DEFAULT_CONSOLE_LOG_LEVELS: ConsoleLogLevel[] = ['log', 'warn', 'error', 'info', 'debug', 'assert', 'trace'];
const ALLOWED_CONSOLE_LOG_LEVELS = new Set<ConsoleLogLevel>(DEFAULT_CONSOLE_LOG_LEVELS);

const consoleLogLevels =
  sentryConfig.CONSOLE_LOG_LEVELS
    ?.map((level) => level.toLowerCase())
    .filter((level): level is ConsoleLogLevel => ALLOWED_CONSOLE_LOG_LEVELS.has(level as ConsoleLogLevel)) ||
  DEFAULT_CONSOLE_LOG_LEVELS;

if (sentryConfig.DSN) {
  Sentry.init({
    dsn: sentryConfig.DSN,
    enableLogs: sentryConfig.ENABLE_LOGS,
    sendDefaultPii: sentryConfig.SEND_DEFAULT_PII,
    integrations: [
      Sentry.consoleLoggingIntegration({ levels: consoleLogLevels.length ? consoleLogLevels : DEFAULT_CONSOLE_LOG_LEVELS }),
    ],
    environment: process.env.NODE_ENV || 'development',
    tracesSampleRate: 1.0,
    profilesSampleRate: 1.0,
  });
}
