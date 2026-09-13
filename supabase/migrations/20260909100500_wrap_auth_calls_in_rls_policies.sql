-- Fix: 46 RLS policies called auth.role() unwrapped, so Postgres re-evaluated
-- the function once per row instead of once per query.
--
-- Wrapping the call as (select auth.role()) turns it into an InitPlan that
-- executes a single time. The predicate is logically identical.
--
-- 42 of these are the uniform "Allow service role manage <table>" policy,
-- generated from the same template. They are re-created here from that same
-- template with the wrapped call. Note these 42 are close to inert in practice
-- -- service_role carries BYPASSRLS in Supabase, so the policy rarely runs at
-- all -- but they are cheap to correct and they stop the advisor from burying
-- the four that do matter.
--
-- The four that genuinely run per row are on credited_works and
-- credited_work_credits: their policies are granted TO public, so anon and
-- authenticated evaluate them on every write attempt. Those are written out
-- explicitly below.

DO $$
DECLARE
  t text;
  tables text[] := ARRAY[
    'admin_invites','admin_members','analytics_rollup_status',
    'apple_recording_candidates','artist_awards','artist_genre_map',
    'artist_media','artist_occupations','artist_relationships',
    'artist_view_events','award_categories','awards','cover_art_ingest_log',
    'cultural_notes','expressions','genre_import_mapping','genre_view_events',
    'genres','imported_reference_table','locations','lyrics','occupations',
    'odesli_batch_progress','page_view_events','platform_click_events',
    'recording_classification_review','recording_credits','recording_editorial',
    'recording_expressions','recording_fun_facts','recording_locations',
    'recording_media','recording_platform_links','recording_relationships',
    'recording_sources','recording_view_events','release_view_events',
    'search_events','sources','sponsors','translations','wikidata_raw'
  ];
BEGIN
  FOREACH t IN ARRAY tables LOOP
    EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I',
                   'Allow service role manage ' || t, t);
    EXECUTE format(
      'CREATE POLICY %I ON public.%I AS PERMISSIVE FOR ALL TO service_role '
      'USING ((select auth.role()) = ''service_role'') '
      'WITH CHECK ((select auth.role()) = ''service_role'')',
      'Allow service role manage ' || t, t);
  END LOOP;
END $$;

-- credited_works / credited_work_credits: granted TO public, so these are the
-- four that actually re-evaluated per row for ordinary callers.
DROP POLICY IF EXISTS credited_works_insert_admin ON public.credited_works;
CREATE POLICY credited_works_insert_admin ON public.credited_works
  FOR INSERT WITH CHECK ((select auth.role()) = 'service_role');

DROP POLICY IF EXISTS credited_works_update_admin ON public.credited_works;
CREATE POLICY credited_works_update_admin ON public.credited_works
  FOR UPDATE USING ((select auth.role()) = 'service_role');

DROP POLICY IF EXISTS credited_work_credits_insert_admin ON public.credited_work_credits;
CREATE POLICY credited_work_credits_insert_admin ON public.credited_work_credits
  FOR INSERT WITH CHECK ((select auth.role()) = 'service_role');

DROP POLICY IF EXISTS credited_work_credits_update_admin ON public.credited_work_credits;
CREATE POLICY credited_work_credits_update_admin ON public.credited_work_credits
  FOR UPDATE USING ((select auth.role()) = 'service_role');

-- DOWN (manual rollback): re-run the same statements with the bare
-- auth.role() call in place of (select auth.role()).
