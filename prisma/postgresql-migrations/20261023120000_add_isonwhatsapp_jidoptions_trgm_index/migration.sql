-- Trigram index for the IsOnWhatsapp number lookups in src/utils/onWhatsappCache.ts, which
-- search `jidOptions` with LIKE '%...%'. A btree index cannot serve that pattern, so every
-- message send scanned the whole table.
--
-- Idempotent: a no-op where the extension and index were already created by hand. The
-- extension may live in `public` (created manually) or in this schema (created here), so
-- the operator class is qualified with whichever schema pg_trgm is actually installed in.

-- CreateExtension
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- CreateIndex
DO $$
DECLARE
  trgm_schema text;
BEGIN
  SELECT n.nspname INTO trgm_schema
  FROM pg_extension e
  JOIN pg_namespace n ON n.oid = e.extnamespace
  WHERE e.extname = 'pg_trgm';

  EXECUTE format(
    'CREATE INDEX IF NOT EXISTS %I ON %I USING GIN (%I %I.gin_trgm_ops)',
    'IsOnWhatsapp_jidOptions_trgm_idx',
    'IsOnWhatsapp',
    'jidOptions',
    trgm_schema
  );
END $$;
