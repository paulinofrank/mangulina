-- Follow-up to 20260909100700.
--
-- That migration gave wikidata_raw and imported_reference_table primary keys
-- but did not analyze them, so both still showed n_live_tup = 0 with
-- last_analyze and last_autoanalyze null -- the same stale-statistics state
-- 20260909100200 corrected for the four catalogue tables. Adding a column does
-- not collect statistics, and neither table takes enough writes to trigger
-- autoanalyze on its own.
--
-- Caught by an independent review of the post-remediation state, not by the
-- original audit.

ANALYZE public.wikidata_raw;
ANALYZE public.imported_reference_table;

INSERT INTO supabase_migrations.schema_migrations (version, name)
VALUES ('20260909101100', 'analyze_import_tables')
ON CONFLICT (version) DO NOTHING;

-- DOWN: not applicable. Collecting statistics has no inverse.
