-- HUMAN-APPLIED SECURITY CHANGE — 2026-11-16.
-- Originally proposed by AI, reviewed and applied by the human owner.
-- Governed by docs/SUPABASE_SECURITY_POLICY.md: AI assistants must not execute
-- security changes, including in a branch/local database.
--
-- Current live finding (verified 2026-11-16): this internal rollback snapshot
-- is in the exposed public schema, has RLS disabled, and grants table
-- privileges to anon and authenticated. The table is not used by application
-- code; the repository's rollback script reads it under the database owner.
--
-- Intended impact: clients lose direct access to this internal snapshot.
-- RLS is enabled with no client policies. Existing owner/postgres and
-- service_role operational paths are retained. This does not alter artist
-- data or the rollback script.
--
-- Human owner: first confirm this is the intended Mangulina project and that
-- the object remains the same. Apply only the exact statements below, then
-- verify with the read-only checks in the linked audit report. Do not add a
-- client policy or restore anon/authenticated grants.

BEGIN;

REVOKE ALL PRIVILEGES ON TABLE public.artists_backup_before_urban_genre_update_20261110
  FROM PUBLIC, anon, authenticated;

ALTER TABLE public.artists_backup_before_urban_genre_update_20261110
  ENABLE ROW LEVEL SECURITY;

COMMIT;

-- Recovery guidance:
-- Do not roll back by restoring client-role grants. If an operational task
-- needs the snapshot, use the existing owner-controlled rollback path or the
-- service_role. If this proposal causes an unexpected application failure,
-- stop and have the human owner review the caller and permissions before any
-- further change; the repository search found no application caller.
