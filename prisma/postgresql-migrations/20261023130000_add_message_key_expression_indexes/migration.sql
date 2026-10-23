-- Indexes for the Message lookups that filter on fields inside the `key` JSON:
--   * "key"->>'id'        message status updates, the echo of sent messages, getMessage
--                         (quoted replies, WhatsApp retry requests)
--   * "key"->>'remoteJid' unread counter, mark-as-read, chat queries
-- With only the "instanceId" index, each of these read every message of the instance.
--
-- Idempotent (IF NOT EXISTS). On a large production table, create these beforehand with
-- CREATE INDEX CONCURRENTLY (no write lock); this migration then does nothing. Prisma's
-- schema cannot express expression indexes, so they live only in this migration.

-- CreateIndex
CREATE INDEX IF NOT EXISTS "Message_instanceId_keyId_idx" ON "Message" ("instanceId", ("key"->>'id'));

-- CreateIndex
CREATE INDEX IF NOT EXISTS "Message_instanceId_keyRemoteJid_idx" ON "Message" ("instanceId", ("key"->>'remoteJid'));
