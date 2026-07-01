-- =========================================================================
-- Read-only analytics health introspection for the admin dashboard.
--
-- Returns a single JSON blob describing the state of the analytics pipeline:
-- table / RPC / materialized-view existence, rollup row counts, pg_cron status,
-- last rollup refresh time, and the dedup cutoff date parsed from the dedup
-- index predicate.
--
-- STRICTLY READ-ONLY: only catalog lookups and COUNT(*) queries. It does NOT
-- modify analytics behavior, does NOT enable retention, and deletes nothing.
-- =========================================================================

CREATE OR REPLACE FUNCTION public.analytics_health()
RETURNS jsonb
LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = public, pg_catalog
AS $$
DECLARE
  v_tables  jsonb := '{}'::jsonb;
  v_rpcs    jsonb := '{}'::jsonb;
  v_mvs     jsonb := '{}'::jsonb;
  v_counts  jsonb := '{}'::jsonb;
  v_cron    jsonb;
  v_last    timestamptz;
  v_cutoff  text;
  v_name    text;
  v_count   bigint;
  v_cron_installed boolean;
  v_cron_jobs jsonb := '[]'::jsonb;
BEGIN
  -- Event-table existence
  FOREACH v_name IN ARRAY ARRAY[
    'artist_view_events','recording_view_events','release_view_events',
    'genre_view_events','search_events','platform_click_events','page_view_events'
  ] LOOP
    v_tables := v_tables || jsonb_build_object(v_name, to_regclass('public.'||v_name) IS NOT NULL);
  END LOOP;

  -- RPC existence (presence only — never invoked, so no rows are written)
  FOREACH v_name IN ARRAY ARRAY[
    'record_artist_view','record_recording_view','record_release_view',
    'record_genre_view','refresh_analytics_rollups','delete_old_analytics_events'
  ] LOOP
    v_rpcs := v_rpcs || jsonb_build_object(v_name, EXISTS(SELECT 1 FROM pg_proc WHERE proname = v_name));
  END LOOP;

  -- Materialized rollup existence + row counts
  FOREACH v_name IN ARRAY ARRAY[
    'mv_recording_views_7d','mv_recording_views_30d','mv_artist_views_7d','mv_artist_views_30d'
  ] LOOP
    IF to_regclass('public.'||v_name) IS NOT NULL THEN
      v_mvs := v_mvs || jsonb_build_object(v_name, true);
      EXECUTE format('SELECT count(*) FROM public.%I', v_name) INTO v_count;
      v_counts := v_counts || jsonb_build_object(v_name, v_count);
    ELSE
      v_mvs := v_mvs || jsonb_build_object(v_name, false);
    END IF;
  END LOOP;

  -- pg_cron status + Mangulina jobs
  v_cron_installed := EXISTS(SELECT 1 FROM pg_extension WHERE extname = 'pg_cron');
  IF v_cron_installed THEN
    BEGIN
      EXECUTE $q$
        SELECT coalesce(jsonb_agg(jsonb_build_object(
                 'jobname', jobname, 'schedule', schedule, 'active', active)), '[]'::jsonb)
        FROM cron.job
        WHERE jobname LIKE 'mangulina-%'
      $q$ INTO v_cron_jobs;
    EXCEPTION WHEN OTHERS THEN
      v_cron_jobs := '[]'::jsonb;
    END;
  END IF;
  v_cron := jsonb_build_object('installed', v_cron_installed, 'jobs', v_cron_jobs);

  -- Last rollup refresh
  IF to_regclass('public.analytics_rollup_status') IS NOT NULL THEN
    SELECT refreshed_at INTO v_last FROM public.analytics_rollup_status LIMIT 1;
  END IF;

  -- Dedup cutoff date, parsed from the artist dedup index predicate
  IF to_regclass('public.uq_artist_view_dedup') IS NOT NULL THEN
    SELECT substring(pg_get_indexdef(indexrelid) FROM 'view_day >= ''?(\d{4}-\d{2}-\d{2})')
      INTO v_cutoff
    FROM pg_index
    WHERE indexrelid = to_regclass('public.uq_artist_view_dedup');
  END IF;

  RETURN jsonb_build_object(
    'tables', v_tables,
    'rpcs', v_rpcs,
    'materialized_views', v_mvs,
    'rollup_counts', v_counts,
    'pg_cron', v_cron,
    'last_rollup_refresh', v_last,
    'dedup_cutoff', v_cutoff,
    'checked_at', now()
  );
END $$;

REVOKE ALL ON FUNCTION public.analytics_health() FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.analytics_health() TO service_role;

NOTIFY pgrst, 'reload schema';
