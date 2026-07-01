-- =========================================================================
-- Phase 2 / H1 — retention plan (DORMANT).
--
-- ANALYTICS.md historically claimed a nightly 90-day cleanup that never
-- existed. This migration installs the cleanup machinery but DOES NOT delete
-- any rows and DOES NOT schedule anything. Nothing here runs automatically.
--
-- Enabling deletion is a separate, explicitly-approved step (see bottom).
-- Until then this only provides:
--   1. delete_old_analytics_events(p_days)  — the function, never called here.
--   2. analytics_retention_preview          — a read-only view so you can see
--      exactly how many rows WOULD be pruned at a 90-day window before
--      approving anything.
--
-- Retention, when eventually enabled, prunes granular event rows only; the
-- all-time `views` counters are never touched, so rankings survive.
-- =========================================================================

CREATE OR REPLACE FUNCTION public.delete_old_analytics_events(p_days integer DEFAULT 90)
RETURNS void
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  DELETE FROM public.artist_view_events    WHERE viewed_at   < now() - make_interval(days => p_days);
  DELETE FROM public.recording_view_events WHERE viewed_at   < now() - make_interval(days => p_days);
  DELETE FROM public.release_view_events   WHERE viewed_at   < now() - make_interval(days => p_days);
  DELETE FROM public.genre_view_events     WHERE viewed_at   < now() - make_interval(days => p_days);
  DELETE FROM public.search_events         WHERE searched_at < now() - make_interval(days => p_days);
  DELETE FROM public.platform_click_events WHERE clicked_at  < now() - make_interval(days => p_days);
  DELETE FROM public.page_view_events      WHERE created_at  < now() - make_interval(days => p_days);
END $$;

REVOKE ALL ON FUNCTION public.delete_old_analytics_events(integer) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.delete_old_analytics_events(integer) TO service_role;

-- Impact preview — counts only, deletes nothing.
CREATE OR REPLACE VIEW public.analytics_retention_preview
WITH (security_invoker = true) AS
SELECT 'artist_view_events'    AS table_name, count(*)::bigint AS rows_older_than_90d FROM public.artist_view_events    WHERE viewed_at   < now() - interval '90 days'
UNION ALL
SELECT 'recording_view_events', count(*)::bigint FROM public.recording_view_events WHERE viewed_at   < now() - interval '90 days'
UNION ALL
SELECT 'release_view_events',   count(*)::bigint FROM public.release_view_events   WHERE viewed_at   < now() - interval '90 days'
UNION ALL
SELECT 'genre_view_events',     count(*)::bigint FROM public.genre_view_events     WHERE viewed_at   < now() - interval '90 days'
UNION ALL
SELECT 'search_events',         count(*)::bigint FROM public.search_events         WHERE searched_at < now() - interval '90 days'
UNION ALL
SELECT 'platform_click_events', count(*)::bigint FROM public.platform_click_events WHERE clicked_at  < now() - interval '90 days'
UNION ALL
SELECT 'page_view_events',      count(*)::bigint FROM public.page_view_events      WHERE created_at  < now() - interval '90 days';

REVOKE ALL ON public.analytics_retention_preview FROM anon, authenticated;
GRANT SELECT ON public.analytics_retention_preview TO service_role;

-- =========================================================================
-- TO ENABLE (only after explicit approval — do NOT run now):
--   SELECT * FROM public.analytics_retention_preview;          -- review impact
--   SELECT cron.schedule(
--     'mangulina-analytics-retention', '0 6 * * *',            -- 02:00 DR time
--     $cron$ SELECT public.delete_old_analytics_events(90); $cron$);
-- =========================================================================

NOTIFY pgrst, 'reload schema';
