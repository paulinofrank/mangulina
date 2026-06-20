-- Add missing increment function for release views
CREATE OR REPLACE FUNCTION public.increment_release_views(p_release_id uuid)
RETURNS void
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
    UPDATE public.releases
    SET views = coalesce(views, 0) + 1
    WHERE id = p_release_id;
$$;

-- Aggregation views for page_view_events
CREATE OR REPLACE VIEW public.page_views_last_7_days
WITH (security_invoker = true) AS
SELECT page_type, COUNT(*)::bigint AS views_7d, COUNT(DISTINCT entity_id) AS unique_entities
FROM public.page_view_events
WHERE created_at >= now() - interval '7 days' AND page_type IS NOT NULL
GROUP BY page_type
ORDER BY views_7d DESC;

CREATE OR REPLACE VIEW public.page_views_last_30_days
WITH (security_invoker = true) AS
SELECT page_type, COUNT(*)::bigint AS views_30d, COUNT(DISTINCT entity_id) AS unique_entities
FROM public.page_view_events
WHERE created_at >= now() - interval '30 days' AND page_type IS NOT NULL
GROUP BY page_type
ORDER BY views_30d DESC;

-- Aggregation views for genre views
CREATE OR REPLACE VIEW public.genre_views_last_7_days
WITH (security_invoker = true) AS
SELECT genre_slug, COUNT(*)::bigint AS views_7d
FROM public.genre_view_events
WHERE viewed_at >= now() - interval '7 days'
GROUP BY genre_slug
ORDER BY views_7d DESC;

CREATE OR REPLACE VIEW public.genre_views_last_30_days
WITH (security_invoker = true) AS
SELECT genre_slug, COUNT(*)::bigint AS views_30d
FROM public.genre_view_events
WHERE viewed_at >= now() - interval '30 days'
GROUP BY genre_slug
ORDER BY views_30d DESC;

-- Release views aggregations
CREATE OR REPLACE VIEW public.release_views_last_7_days
WITH (security_invoker = true) AS
SELECT release_id, COUNT(*)::bigint AS views_7d
FROM public.release_view_events
WHERE viewed_at >= now() - interval '7 days'
GROUP BY release_id
ORDER BY views_7d DESC;

CREATE OR REPLACE VIEW public.release_views_last_30_days
WITH (security_invoker = true) AS
SELECT release_id, COUNT(*)::bigint AS views_30d
FROM public.release_view_events
WHERE viewed_at >= now() - interval '30 days'
GROUP BY release_id
ORDER BY views_30d DESC;

-- Time-series views for trend data
CREATE OR REPLACE VIEW public.artist_views_by_day_last_30_days
WITH (security_invoker = true) AS
SELECT DATE(viewed_at) AS view_date, COUNT(*)::bigint AS daily_views, COUNT(DISTINCT artist_id)::bigint AS unique_artists
FROM public.artist_view_events
WHERE viewed_at >= now() - interval '30 days'
GROUP BY DATE(viewed_at)
ORDER BY view_date DESC;

CREATE OR REPLACE VIEW public.recording_views_by_day_last_30_days
WITH (security_invoker = true) AS
SELECT DATE(viewed_at) AS view_date, COUNT(*)::bigint AS daily_views, COUNT(DISTINCT recording_id)::bigint AS unique_recordings
FROM public.recording_view_events
WHERE viewed_at >= now() - interval '30 days'
GROUP BY DATE(viewed_at)
ORDER BY view_date DESC;

CREATE OR REPLACE VIEW public.search_events_by_day_last_30_days
WITH (security_invoker = true) AS
SELECT DATE(searched_at) AS search_date, COUNT(*)::bigint AS total_searches, SUM(CASE WHEN results_count = 0 THEN 1 ELSE 0 END)::bigint AS zero_result_searches
FROM public.search_events
WHERE searched_at >= now() - interval '30 days'
GROUP BY DATE(searched_at)
ORDER BY search_date DESC;

-- Unified comparison views with both 7d and 30d metrics
CREATE OR REPLACE VIEW public.artist_views_comparison
WITH (security_invoker = true) AS
SELECT
    COALESCE(a7.artist_id, a30.artist_id) AS artist_id,
    COALESCE(a7.views_7d, 0) AS views_7d,
    COALESCE(a30.views_30d, 0) AS views_30d
FROM public.artist_views_last_7_days a7
FULL OUTER JOIN public.artist_views_last_30_days a30 ON a7.artist_id = a30.artist_id
ORDER BY COALESCE(a7.views_7d, 0) DESC;

CREATE OR REPLACE VIEW public.recording_views_comparison
WITH (security_invoker = true) AS
SELECT
    COALESCE(r7.recording_id, r30.recording_id) AS recording_id,
    COALESCE(r7.views_7d, 0) AS views_7d,
    COALESCE(r30.views_30d, 0) AS views_30d
FROM public.recording_views_last_7_days r7
FULL OUTER JOIN public.recording_views_last_30_days r30 ON r7.recording_id = r30.recording_id
ORDER BY COALESCE(r7.views_7d, 0) DESC;

CREATE OR REPLACE VIEW public.genre_views_comparison
WITH (security_invoker = true) AS
SELECT
    COALESCE(g7.genre_slug, g30.genre_slug) AS genre_slug,
    COALESCE(g7.views_7d, 0) AS views_7d,
    COALESCE(g30.views_30d, 0) AS views_30d
FROM public.genre_views_last_7_days g7
FULL OUTER JOIN public.genre_views_last_30_days g30 ON g7.genre_slug = g30.genre_slug
ORDER BY COALESCE(g7.views_7d, 0) DESC;

CREATE OR REPLACE VIEW public.release_views_comparison
WITH (security_invoker = true) AS
SELECT
    COALESCE(rel7.release_id, rel30.release_id) AS release_id,
    COALESCE(rel7.views_7d, 0) AS views_7d,
    COALESCE(rel30.views_30d, 0) AS views_30d
FROM public.release_views_last_7_days rel7
FULL OUTER JOIN public.release_views_last_30_days rel30 ON rel7.release_id = rel30.release_id
ORDER BY COALESCE(rel7.views_7d, 0) DESC;

-- Grant permissions for service role
GRANT EXECUTE ON FUNCTION public.increment_release_views(uuid) TO service_role;
GRANT SELECT ON public.page_views_last_7_days TO service_role;
GRANT SELECT ON public.page_views_last_30_days TO service_role;
GRANT SELECT ON public.genre_views_last_7_days TO service_role;
GRANT SELECT ON public.genre_views_last_30_days TO service_role;
GRANT SELECT ON public.release_views_last_7_days TO service_role;
GRANT SELECT ON public.release_views_last_30_days TO service_role;
GRANT SELECT ON public.artist_views_by_day_last_30_days TO service_role;
GRANT SELECT ON public.recording_views_by_day_last_30_days TO service_role;
GRANT SELECT ON public.search_events_by_day_last_30_days TO service_role;
GRANT SELECT ON public.artist_views_comparison TO service_role;
GRANT SELECT ON public.recording_views_comparison TO service_role;
GRANT SELECT ON public.genre_views_comparison TO service_role;
GRANT SELECT ON public.release_views_comparison TO service_role;

NOTIFY pgrst, 'reload schema';
