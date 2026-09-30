-- Resolves the Supabase advisor lint 0008 (rls_enabled_no_policy, INFO).
--
-- 1. genre_media is read by the public site (src/lib/genreApi.ts) with the
--    anon client, but RLS had no policy, so every row was silently hidden.
--    Add the public read policy it was always meant to have.
-- 2. _supabase_migrations is internal bookkeeping; anon/authenticated held
--    full table privileges on it. Revoke them (service role is unaffected).
-- 3. The remaining tables are internal (editorial workflow, redirects,
--    lookup/credit-source tables) and are only touched with the service role.
--    They already have no anon/authenticated grants; make the deny-all intent
--    explicit with a policy so the advisor stops flagging them.
--
-- Rollback: DROP POLICY "<name>" ON public.<table> for each policy created
-- here; re-GRANT on _supabase_migrations if ever needed.

CREATE POLICY "Public read genre_media"
  ON public.genre_media
  FOR SELECT
  TO anon, authenticated
  USING (true);

REVOKE ALL ON public._supabase_migrations FROM anon, authenticated;

DO $$
DECLARE
  t text;
BEGIN
  FOREACH t IN ARRAY ARRAY[
    '_supabase_migrations',
    'artist_redirects',
    'editorial_assertion_evidence',
    'editorial_assertion_external_contributors',
    'editorial_assertion_isrcs',
    'editorial_assertion_recording_credits',
    'editorial_assertion_recording_work_targets',
    'editorial_assertion_recordings',
    'editorial_assertion_work_credits',
    'editorial_assertion_works',
    'editorial_assertions',
    'editorial_audit_events',
    'editorial_capabilities',
    'editorial_case_assertions',
    'editorial_case_isrcs',
    'editorial_case_recordings',
    'editorial_case_works',
    'editorial_cases',
    'editorial_decision_assertions',
    'editorial_decisions',
    'editorial_idempotency_keys',
    'editorial_isrc_findings',
    'editorial_role_capabilities',
    'editorial_sources',
    'external_contributors',
    'instruments',
    'recording_credit_instruments',
    'recording_isrc_sources',
    'recording_version_profiles',
    'release_credits',
    'work_credit_sources',
    'work_redirects'
  ]
  LOOP
    IF NOT EXISTS (
      SELECT 1 FROM pg_policy p
      WHERE p.polrelid = format('public.%I', t)::regclass
    ) THEN
      EXECUTE format(
        'CREATE POLICY "Internal only: deny anon and authenticated" ON public.%I FOR ALL TO anon, authenticated USING (false) WITH CHECK (false)',
        t
      );
    END IF;
  END LOOP;
END $$;
