-- =========================================================================
-- Phase 2 / M3 — materialized rollups for time-windowed view stats.
--
-- Separates "Most Viewed" (all-time `views` column, unchanged) from
-- "Trending" (last 7 days) and "Rising" (emerging artists by last 7 days).
--
-- These are MATERIALIZED views with unique indexes so they can be refreshed
-- with REFRESH MATERIALIZED VIEW CONCURRENTLY on a schedule, decoupling the
-- homepage from raw event-table scans. The pre-existing plain views
-- (*_views_last_7_days, *_comparison, ...) are left intact for the admin
-- dashboard — this migration only ADDS new mv_* objects.
--
-- Does NOT touch: the dedup migration, view-recording RPCs, the `views`
-- counters, ip_hash/user_agent, page_view_events, or Vercel Analytics.
-- =========================================================================

-- ----------------------------------------------------- recordings (7d / 30d)
CREATE MATERIALIZED VIEW IF NOT EXISTS public.mv_recording_views_7d AS
SELECT recording_id, count(*)::bigint AS views_7d
FROM public.recording_view_events
WHERE viewed_at >= now() - interval '7 days'
GROUP BY recording_id;

CREATE UNIQUE INDEX IF NOT EXISTS uq_mv_recording_views_7d
ON public.mv_recording_views_7d (recording_id);

CREATE MATERIALIZED VIEW IF NOT EXISTS public.mv_recording_views_30d AS
SELECT recording_id, count(*)::bigint AS views_30d
FROM public.recording_view_events
WHERE viewed_at >= now() - interval '30 days'
GROUP BY recording_id;

CREATE UNIQUE INDEX IF NOT EXISTS uq_mv_recording_views_30d
ON public.mv_recording_views_30d (recording_id);

-- -------------------------------------------------------- artists (7d / 30d)
CREATE MATERIALIZED VIEW IF NOT EXISTS public.mv_artist_views_7d AS
SELECT artist_id, count(*)::bigint AS views_7d
FROM public.artist_view_events
WHERE viewed_at >= now() - interval '7 days'
GROUP BY artist_id;

CREATE UNIQUE INDEX IF NOT EXISTS uq_mv_artist_views_7d
ON public.mv_artist_views_7d (artist_id);

CREATE MATERIALIZED VIEW IF NOT EXISTS public.mv_artist_views_30d AS
SELECT artist_id, count(*)::bigint AS views_30d
FROM public.artist_view_events
WHERE viewed_at >= now() - interval '30 days'
GROUP BY artist_id;

CREATE UNIQUE INDEX IF NOT EXISTS uq_mv_artist_views_30d
ON public.mv_artist_views_30d (artist_id);

-- ------------------------------------------------------------ refresh status
-- Single-row table recording when the rollups were last refreshed, so the admin
-- dashboard can confirm the pg_cron job is actually running.
CREATE TABLE IF NOT EXISTS public.analytics_rollup_status (
  id           boolean PRIMARY KEY DEFAULT true CHECK (id),
  refreshed_at timestamptz NOT NULL DEFAULT now()
);
INSERT INTO public.analytics_rollup_status (id, refreshed_at)
VALUES (true, now())
ON CONFLICT (id) DO NOTHING;

-- ------------------------------------------------------------ refresh helper
-- Single entry point so the schedule (or a manual call) refreshes everything.
-- CONCURRENTLY keeps reads non-blocking and requires the unique indexes above.
CREATE OR REPLACE FUNCTION public.refresh_analytics_rollups()
RETURNS void
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_recording_views_7d;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_recording_views_30d;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_artist_views_7d;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_artist_views_30d;

  INSERT INTO public.analytics_rollup_status (id, refreshed_at)
  VALUES (true, now())
  ON CONFLICT (id) DO UPDATE SET refreshed_at = excluded.refreshed_at;
END $$;

-- ------------------------------------------------------------- permissions
-- Aggregated counts only (no per-event detail, no ip_hash/user_agent). Read
-- server-side via the service role by src/lib/analyticsRollups.ts.
GRANT SELECT ON public.mv_recording_views_7d  TO service_role;
GRANT SELECT ON public.mv_recording_views_30d TO service_role;
GRANT SELECT ON public.mv_artist_views_7d     TO service_role;
GRANT SELECT ON public.mv_artist_views_30d    TO service_role;
REVOKE ALL ON public.analytics_rollup_status FROM anon, authenticated;
GRANT SELECT ON public.analytics_rollup_status TO service_role;
REVOKE ALL ON FUNCTION public.refresh_analytics_rollups() FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.refresh_analytics_rollups() TO service_role;

-- ------------------------------------------------------------- scheduling
-- Refresh every 15 minutes via pg_cron when available; skipped without failing
-- the migration otherwise (enable pg_cron, then re-run this DO block, or call
-- public.refresh_analytics_rollups() from an external cron / edge function).
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_cron') THEN
    PERFORM cron.schedule(
      'mangulina-refresh-analytics-rollups',
      '*/15 * * * *',
      $cron$ SELECT public.refresh_analytics_rollups(); $cron$
    );
  ELSE
    RAISE NOTICE 'pg_cron not installed; rollups created but not auto-refreshed.';
  END IF;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'pg_cron scheduling skipped: %', SQLERRM;
END $$;

NOTIFY pgrst, 'reload schema';
