-- =========================================================================
-- Read-only diagnostics for the Analytics Health page (polish pass).
--
-- Adds:
--   * analytics_event_activity() — per-table data-flow stats (total / today /
--     newest / oldest) so the admin can confirm events are actively flowing.
--   * analytics_health() (replaced) — pg_cron jobs now include last execution
--     time, status and duration from cron.job_run_details.
--
-- STRICTLY READ-ONLY. Catalog lookups + COUNT/MIN/MAX only. Modifies no
-- analytics behavior, refreshes nothing, schedules nothing, deletes nothing,
-- writes no events, updates no counters.
--
-- NOTE: this file deliberately avoids nested dollar-quoting (inner tags inside
-- a function body). The Supabase dashboard SQL editor mis-splits multi-line
-- nested dollar quotes (causing "unterminated dollar-quoted string"). Dynamic
-- SQL below uses plain single-quoted strings instead. Prefer applying via the
-- Supabase CLI (supabase db push).
-- =========================================================================

-- 1. Per-table activity (single scan per table: total + today + min/max).
CREATE OR REPLACE FUNCTION public.analytics_event_activity()
RETURNS jsonb
LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = public, pg_catalog
AS $$
DECLARE
  v_result jsonb := '{}'::jsonb;
  v_today  date := (now() AT TIME ZONE 'America/Santo_Domingo')::date;
  v_obj    jsonb;
  v_tables text[] := ARRAY[
    'artist_view_events','recording_view_events','release_view_events',
    'genre_view_events','search_events','platform_click_events'
  ];
  v_cols text[] := ARRAY[
    'viewed_at','viewed_at','viewed_at','viewed_at','searched_at','clicked_at'
  ];
  i int;
BEGIN
  FOR i IN 1 .. array_length(v_tables, 1) LOOP
    IF to_regclass('public.'||v_tables[i]) IS NOT NULL THEN
      -- %I/%L (no positional $-tokens) to keep the SQL editor's parser happy.
      EXECUTE format(
        'SELECT jsonb_build_object(
           ''total'',  count(*),
           ''today'',  count(*) FILTER (WHERE (%I AT TIME ZONE ''America/Santo_Domingo'')::date = %L),
           ''newest'', max(%I),
           ''oldest'', min(%I))
         FROM public.%I',
        v_cols[i], v_today, v_cols[i], v_cols[i], v_tables[i]
      ) INTO v_obj;
      v_result := v_result || jsonb_build_object(v_tables[i], v_obj);
    ELSE
      v_result := v_result || jsonb_build_object(v_tables[i], NULL);
    END IF;
  END LOOP;

  RETURN v_result;
END $$;

REVOKE ALL ON FUNCTION public.analytics_event_activity() FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.analytics_event_activity() TO service_role;

-- 2. analytics_health() — same as before, but pg_cron jobs now carry their last
--    run details (start/end/status/duration) from cron.job_run_details.
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
      EXECUTE '
        SELECT coalesce(jsonb_agg(jsonb_build_object(
                 ''jobname'',     j.jobname,
                 ''schedule'',    j.schedule,
                 ''active'',      j.active,
                 ''last_start'',  lr.start_time,
                 ''last_end'',    lr.end_time,
                 ''last_status'', lr.status,
                 ''duration_ms'', CASE
                                    WHEN lr.start_time IS NOT NULL AND lr.end_time IS NOT NULL
                                    THEN round(extract(epoch FROM (lr.end_time - lr.start_time)) * 1000)::int
                                  END
               ) ORDER BY j.jobname), ''[]''::jsonb)
        FROM cron.job j
        LEFT JOIN LATERAL (
          SELECT start_time, end_time, status
          FROM cron.job_run_details d
          WHERE d.jobid = j.jobid
          ORDER BY start_time DESC
          LIMIT 1
        ) lr ON true
        WHERE j.jobname LIKE ''mangulina-%''
      ' INTO v_cron_jobs;

      EXECUTE '
        SELECT active FROM cron.job
        WHERE jobname = ''mangulina-refresh-analytics-rollups'' LIMIT 1
      ' INTO v_refresh_active;
    EXCEPTION WHEN OTHERS THEN
      v_cron_jobs := '[]'::jsonb;
      v_refresh_active := NULL;
    END;
  END IF;
  v_cron := jsonb_build_object('installed', v_cron_installed, 'jobs', v_cron_jobs);

  IF v_refresh_active IS TRUE THEN
    v_next := date_trunc('hour', now())
      + (((floor(extract(minute FROM now()) / 15) + 1) * 15) || ' minutes')::interval;
  END IF;

  IF to_regclass('public.analytics_rollup_status') IS NOT NULL THEN
    v_last     := (SELECT refreshed_at FROM public.analytics_rollup_status LIMIT 1);
    v_duration := (SELECT duration_ms  FROM public.analytics_rollup_status LIMIT 1);
  END IF;

  IF to_regclass('public.uq_artist_view_dedup') IS NOT NULL THEN
    v_cutoff := (
      SELECT substring(pg_get_indexdef(indexrelid) FROM 'view_day >= ''?(\d{4}-\d{2}-\d{2})')
      FROM pg_index
      WHERE indexrelid = to_regclass('public.uq_artist_view_dedup')
    );
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
    'dedup_index_present', to_regclass('public.uq_artist_view_dedup') IS NOT NULL,
    'checked_at', now()
  );
END $$;

REVOKE ALL ON FUNCTION public.analytics_health() FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.analytics_health() TO service_role;

NOTIFY pgrst, 'reload schema';
