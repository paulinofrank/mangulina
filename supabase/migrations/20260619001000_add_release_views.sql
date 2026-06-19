ALTER TABLE public.releases
ADD COLUMN IF NOT EXISTS views integer NOT NULL DEFAULT 0;

CREATE INDEX IF NOT EXISTS idx_releases_views
ON public.releases(views DESC);

CREATE INDEX IF NOT EXISTS idx_releases_release_year
ON public.releases(release_year DESC);

CREATE INDEX IF NOT EXISTS idx_releases_type
ON public.releases(type);

CREATE INDEX IF NOT EXISTS idx_tracks_release_id
ON public.tracks(release_id);

CREATE INDEX IF NOT EXISTS idx_recordings_release_id
ON public.recordings(release_id);

CREATE INDEX IF NOT EXISTS idx_recordings_genre_id
ON public.recordings(genre_id);

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

REVOKE ALL ON FUNCTION public.increment_release_views(uuid) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.increment_release_views(uuid) TO service_role;
