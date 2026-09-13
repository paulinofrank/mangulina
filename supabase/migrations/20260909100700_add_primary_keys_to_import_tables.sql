-- Fix: wikidata_raw (74 rows) and imported_reference_table (181 rows) had no
-- primary key.
--
-- Both are ingest staging tables, which is why they were created without one.
-- A table without a PK cannot be addressed row-by-row, cannot be targeted by
-- logical replication, and gives no stable identity for de-duplication -- and
-- these are exactly the tables where duplicate ingest rows show up.
--
-- Neither table has a trustworthy natural key: wikidata_raw.artist_id and
-- wikidata_raw.wikidata_id are both nullable, and imported_reference_table is
-- a flat text dump with no identifier column at all. A surrogate identity
-- column is therefore added rather than promoting an existing column, which
-- also keeps this migration non-destructive: no existing column changes type,
-- nullability, or content, and every existing query keeps working.

ALTER TABLE public.wikidata_raw
  ADD COLUMN IF NOT EXISTS id bigint GENERATED ALWAYS AS IDENTITY;

ALTER TABLE public.imported_reference_table
  ADD COLUMN IF NOT EXISTS id bigint GENERATED ALWAYS AS IDENTITY;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conrelid = 'public.wikidata_raw'::regclass AND contype = 'p'
  ) THEN
    ALTER TABLE public.wikidata_raw ADD CONSTRAINT wikidata_raw_pkey PRIMARY KEY (id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conrelid = 'public.imported_reference_table'::regclass AND contype = 'p'
  ) THEN
    ALTER TABLE public.imported_reference_table
      ADD CONSTRAINT imported_reference_table_pkey PRIMARY KEY (id);
  END IF;
END $$;

-- DOWN (manual rollback):
--   ALTER TABLE public.wikidata_raw DROP CONSTRAINT wikidata_raw_pkey, DROP COLUMN id;
--   ALTER TABLE public.imported_reference_table DROP CONSTRAINT imported_reference_table_pkey, DROP COLUMN id;
