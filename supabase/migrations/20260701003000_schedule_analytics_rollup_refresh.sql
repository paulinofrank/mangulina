-- =========================================================================
-- Schedule the analytics rollup refresh (15-minute cadence).
--
-- The original rollups migration tried to schedule this inside a defensive
-- `IF pg_cron installed … ELSE notice / EXCEPTION … notice` block. pg_cron was
-- enabled AFTER that migration ran, so the job was never created and the skip
-- was silent. This migration creates it now (pg_cron is installed) and also
-- adds refresh timing so the admin Health page can show duration / next run.
--
-- Scope guards:
--   * Touches ONLY the rollup refresh job and its timing columns.
--   * Does NOT enable retention deletion and creates NO cleanup job.
--   * Does NOT change view-tracking behavior and deletes NO data.
-- =========================================================================

-- 1. Ensure the status table exists. It was introduced via a later edit to the
--    rollups migration, so databases that applied the original 20260701000000
--    never got it. Creating it here (idempotent) makes this migration
--    self-contained and safe on both existing and fresh databases.
CREATE TABLE IF NOT EXISTS public.analytics_rollup_status (
  id           boolean PRIMARY KEY DEFAULT true CHECK (id),
  refreshed_at timestamptz NOT NULL DEFAULT now(),
  started_at   timestamptz,
  duration_ms  integer
);

-- For databases that already had an older version of the table, add the columns.
ALTER TABLE public.analytics_rollup_status ADD COLUMN IF NOT EXISTS started_at  timestamptz;
ALTER TABLE public.analytics_rollup_status ADD COLUMN IF NOT EXISTS duration_ms integer;

REVOKE ALL ON public.analytics_rollup_status FROM anon, authenticated;
GRANT SELECT ON public.analytics_rollup_status TO service_role;

-- 2. Refresh function: same rollups as before, now also records wall-clock
--    duration of the run. (Produces identical rollup data — only adds timing.)
CREATE OR REPLACE FUNCTION public.refresh_analytics_rollups()
RETURNS void
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE
  v_start timestamptz := clock_timestamp();
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_recording_views_7d;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_recording_views_30d;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_artist_views_7d;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_artist_views_30d;

  INSERT INTO public.analytics_rollup_status (id, refreshed_at, started_at, duration_ms)
  VALUES (
    true,
    clock_timestamp(),
    v_start,
    (extract(epoch FROM (clock_timestamp() - v_start)) * 1000)::integer
  )
  ON CONFLICT (id) DO UPDATE
    SET refreshed_at = excluded.refreshed_at,
        started_at  = excluded.started_at,
        duration_ms = excluded.duration_ms;
END $$;

REVOKE ALL ON FUNCTION public.refresh_analytics_rollups() FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.refresh_analytics_rollups() TO service_role;

-- 3. Schedule the job every 15 minutes. cron.schedule() upserts by job name,
--    so this is idempotent and safe to re-run. The extension check is the only
--    guard — any real scheduling error is allowed to surface (unlike before),
--    so a failure can never again be silently swallowed.
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_cron') THEN
    PERFORM cron.schedule(
      'mangulina-refresh-analytics-rollups',
      '*/15 * * * *',
      $cron$ SELECT public.refresh_analytics_rollups(); $cron$
    );
    RAISE NOTICE 'Scheduled mangulina-refresh-analytics-rollups (every 15 min).';
  ELSE
    RAISE EXCEPTION 'pg_cron is not installed; enable it (Database > Extensions) and re-run this migration.';
  END IF;
END $$;

-- 4. Populate the rollups once now so they are not empty until the first cron
--    tick, and so "last successful refresh" reflects a real run immediately.
--    Non-critical: if it fails, cron will refresh within 15 minutes.
DO $$
BEGIN
  PERFORM public.refresh_analytics_rollups();
  RAISE NOTICE 'Initial analytics rollup refresh completed.';
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Initial rollup refresh skipped (cron will run it shortly): %', SQLERRM;
END $$;

-- 5. Extend the read-only health snapshot with refresh duration + next run.
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
  v_duration integer;
  v_next    timestamptz;
  v_cutoff  text;
  v_name    text;
  v_count   bigint;
  v_cron_installed boolean;
  v_cron_jobs jsonb := '[]'::jsonb;
  v_refresh_active boolean;
BEGIN
  FOREACH v_name IN ARRAY ARRAY[
    'artist_view_events','recording_view_events','release_view_events',
    'genre_view_events','search_events','platform_click_events','page_view_events'
  ] LOOP
    v_tables := v_tables || jsonb_build_object(v_name, to_regclass('public.'||v_name) IS NOT NULL);
  END LOOP;

  FOREACH v_name IN ARRAY ARRAY[
    'record_artist_view','record_recording_view','record_release_view',
    'record_genre_view','refresh_analytics_rollups','delete_old_analytics_events'
  ] LOOP
    v_rpcs := v_rpcs || jsonb_build_object(v_name, EXISTS(SELECT 1 FROM pg_proc WHERE proname = v_name));
  END LOOP;

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

  v_cron_installed := EXISTS(SELECT 1 FROM pg_extension WHERE extname = 'pg_cron');
  IF v_cron_installed THEN
    BEGIN
      EXECUTE $q$
        SELECT coalesce(jsonb_agg(jsonb_build_object(
                 'jobname', jobname, 'schedule', schedule, 'active', active)), '[]'::jsonb)
        FROM cron.job
        WHERE jobname LIKE 'mangulina-%'
      $q$ INTO v_cron_jobs;

      EXECUTE $q$
        SELECT active FROM cron.job
        WHERE jobname = 'mangulina-refresh-analytics-rollups' LIMIT 1
      $q$ INTO v_refresh_active;
    EXCEPTION WHEN OTHERS THEN
      v_cron_jobs := '[]'::jsonb;
      v_refresh_active := NULL;
    END;
  END IF;
  v_cron := jsonb_build_object('installed', v_cron_installed, 'jobs', v_cron_jobs);

  -- Next */15 boundary, only meaningful when the refresh job is active.
  IF v_refresh_active IS TRUE THEN
    v_next := date_trunc('hour', now())
      + (((floor(extract(minute FROM now()) / 15) + 1) * 15) || ' minutes')::interval;
  END IF;

  IF to_regclass('public.analytics_rollup_status') IS NOT NULL THEN
    SELECT refreshed_at, duration_ms INTO v_last, v_duration
    FROM public.analytics_rollup_status LIMIT 1;
  END IF;

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
    'last_rollup_duration_ms', v_duration,
    'next_rollup_refresh', v_next,
    'dedup_cutoff', v_cutoff,
    'checked_at', now()
  );
END $$;

REVOKE ALL ON FUNCTION public.analytics_health() FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.analytics_health() TO service_role;

NOTIFY pgrst, 'reload schema';
