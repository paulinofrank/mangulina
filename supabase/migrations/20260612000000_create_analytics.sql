CREATE TABLE IF NOT EXISTS public.artist_view_events (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    artist_id uuid NOT NULL REFERENCES public.artists(id) ON DELETE CASCADE,
    viewed_at timestamptz NOT NULL DEFAULT now(),
    source text,
    referrer text,
    user_agent text,
    ip_hash text
);

CREATE TABLE IF NOT EXISTS public.recording_view_events (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    recording_id uuid NOT NULL REFERENCES public.recordings(id) ON DELETE CASCADE,
    viewed_at timestamptz NOT NULL DEFAULT now(),
    source text,
    referrer text,
    user_agent text,
    ip_hash text
);

CREATE TABLE IF NOT EXISTS public.release_view_events (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    release_id uuid NOT NULL REFERENCES public.releases(id) ON DELETE CASCADE,
    viewed_at timestamptz NOT NULL DEFAULT now(),
    source text,
    referrer text,
    user_agent text,
    ip_hash text
);

CREATE TABLE IF NOT EXISTS public.genre_view_events (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    genre_slug text NOT NULL,
    viewed_at timestamptz NOT NULL DEFAULT now(),
    source text,
    referrer text,
    user_agent text,
    ip_hash text
);

CREATE TABLE IF NOT EXISTS public.search_events (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    query text NOT NULL,
    searched_at timestamptz NOT NULL DEFAULT now(),
    results_count integer NOT NULL DEFAULT 0 CHECK (results_count >= 0),
    source text,
    referrer text,
    user_agent text,
    ip_hash text
);

CREATE TABLE IF NOT EXISTS public.platform_click_events (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    recording_id uuid NOT NULL REFERENCES public.recordings(id) ON DELETE CASCADE,
    platform text NOT NULL,
    url text,
    clicked_at timestamptz NOT NULL DEFAULT now(),
    source text,
    referrer text,
    user_agent text,
    ip_hash text
);

CREATE INDEX IF NOT EXISTS idx_artist_view_events_artist_viewed_at
ON public.artist_view_events(artist_id, viewed_at DESC);
CREATE INDEX IF NOT EXISTS idx_artist_view_events_ip_hash
ON public.artist_view_events(ip_hash) WHERE ip_hash IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_recording_view_events_recording_viewed_at
ON public.recording_view_events(recording_id, viewed_at DESC);
CREATE INDEX IF NOT EXISTS idx_recording_view_events_ip_hash
ON public.recording_view_events(ip_hash) WHERE ip_hash IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_release_view_events_release_viewed_at
ON public.release_view_events(release_id, viewed_at DESC);
CREATE INDEX IF NOT EXISTS idx_release_view_events_ip_hash
ON public.release_view_events(ip_hash) WHERE ip_hash IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_genre_view_events_genre_viewed_at
ON public.genre_view_events(genre_slug, viewed_at DESC);
CREATE INDEX IF NOT EXISTS idx_genre_view_events_ip_hash
ON public.genre_view_events(ip_hash) WHERE ip_hash IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_search_events_query_searched_at
ON public.search_events(query, searched_at DESC);
CREATE INDEX IF NOT EXISTS idx_search_events_results_count
ON public.search_events(results_count);
CREATE INDEX IF NOT EXISTS idx_search_events_ip_hash
ON public.search_events(ip_hash) WHERE ip_hash IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_platform_click_events_recording_platform_clicked_at
ON public.platform_click_events(recording_id, platform, clicked_at DESC);
CREATE INDEX IF NOT EXISTS idx_platform_click_events_ip_hash
ON public.platform_click_events(ip_hash) WHERE ip_hash IS NOT NULL;

CREATE OR REPLACE FUNCTION public.increment_artist_views(p_artist_id uuid)
RETURNS void
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
    UPDATE public.artists
    SET views = coalesce(views, 0) + 1
    WHERE id = p_artist_id;
$$;

CREATE OR REPLACE FUNCTION public.increment_recording_views(p_recording_id uuid)
RETURNS void
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
    UPDATE public.recordings
    SET views = coalesce(views, 0) + 1
    WHERE id = p_recording_id;
$$;

CREATE OR REPLACE VIEW public.artist_views_last_7_days
WITH (security_invoker = true) AS
SELECT artist_id, count(*)::bigint AS views_7d
FROM public.artist_view_events
WHERE viewed_at >= now() - interval '7 days'
GROUP BY artist_id;

CREATE OR REPLACE VIEW public.artist_views_last_30_days
WITH (security_invoker = true) AS
SELECT artist_id, count(*)::bigint AS views_30d
FROM public.artist_view_events
WHERE viewed_at >= now() - interval '30 days'
GROUP BY artist_id;

CREATE OR REPLACE VIEW public.recording_views_last_7_days
WITH (security_invoker = true) AS
SELECT recording_id, count(*)::bigint AS views_7d
FROM public.recording_view_events
WHERE viewed_at >= now() - interval '7 days'
GROUP BY recording_id;

CREATE OR REPLACE VIEW public.recording_views_last_30_days
WITH (security_invoker = true) AS
SELECT recording_id, count(*)::bigint AS views_30d
FROM public.recording_view_events
WHERE viewed_at >= now() - interval '30 days'
GROUP BY recording_id;

CREATE OR REPLACE VIEW public.searches_with_no_results
WITH (security_invoker = true) AS
SELECT
    lower(trim(query)) AS query,
    count(*)::bigint AS search_count,
    max(searched_at) AS last_searched_at
FROM public.search_events
WHERE results_count = 0 AND trim(query) <> ''
GROUP BY lower(trim(query))
ORDER BY search_count DESC, last_searched_at DESC;

CREATE OR REPLACE VIEW public.platform_clicks_last_30_days
WITH (security_invoker = true) AS
SELECT platform, count(*)::bigint AS clicks_30d
FROM public.platform_click_events
WHERE clicked_at >= now() - interval '30 days'
GROUP BY platform;

ALTER TABLE public.artist_view_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.recording_view_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.release_view_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.genre_view_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.search_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.platform_click_events ENABLE ROW LEVEL SECURITY;

REVOKE ALL ON public.artist_view_events FROM anon, authenticated;
REVOKE ALL ON public.recording_view_events FROM anon, authenticated;
REVOKE ALL ON public.release_view_events FROM anon, authenticated;
REVOKE ALL ON public.genre_view_events FROM anon, authenticated;
REVOKE ALL ON public.search_events FROM anon, authenticated;
REVOKE ALL ON public.platform_click_events FROM anon, authenticated;
REVOKE ALL ON public.artist_views_last_7_days FROM anon, authenticated;
REVOKE ALL ON public.artist_views_last_30_days FROM anon, authenticated;
REVOKE ALL ON public.recording_views_last_7_days FROM anon, authenticated;
REVOKE ALL ON public.recording_views_last_30_days FROM anon, authenticated;
REVOKE ALL ON public.searches_with_no_results FROM anon, authenticated;
REVOKE ALL ON public.platform_clicks_last_30_days FROM anon, authenticated;
REVOKE ALL ON FUNCTION public.increment_artist_views(uuid) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.increment_recording_views(uuid) FROM PUBLIC, anon, authenticated;

GRANT SELECT, INSERT ON public.artist_view_events TO service_role;
GRANT SELECT, INSERT ON public.recording_view_events TO service_role;
GRANT SELECT, INSERT ON public.release_view_events TO service_role;
GRANT SELECT, INSERT ON public.genre_view_events TO service_role;
GRANT SELECT, INSERT ON public.search_events TO service_role;
GRANT SELECT, INSERT ON public.platform_click_events TO service_role;
GRANT SELECT ON public.artist_views_last_7_days TO service_role;
GRANT SELECT ON public.artist_views_last_30_days TO service_role;
GRANT SELECT ON public.recording_views_last_7_days TO service_role;
GRANT SELECT ON public.recording_views_last_30_days TO service_role;
GRANT SELECT ON public.searches_with_no_results TO service_role;
GRANT SELECT ON public.platform_clicks_last_30_days TO service_role;
GRANT EXECUTE ON FUNCTION public.increment_artist_views(uuid) TO service_role;
GRANT EXECUTE ON FUNCTION public.increment_recording_views(uuid) TO service_role;
