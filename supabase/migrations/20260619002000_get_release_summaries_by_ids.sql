CREATE OR REPLACE FUNCTION public.get_release_summaries_by_ids(
    release_ids uuid[]
)
RETURNS TABLE (
    id uuid,
    slug text,
    title text,
    type text,
    release_year integer,
    year integer,
    label text,
    views integer,
    release_artist_id uuid,
    artist_name text,
    artist_slug text
)
LANGUAGE sql
STABLE
SET search_path = ''
AS $$
    SELECT
        r.id,
        r.slug::text,
        r.title::text,
        r.type::text,
        r.release_year::integer,
        r.year::integer,
        r.label::text,
        r.views::integer,
        r.release_artist_id,
        a.name::text AS artist_name,
        a.slug::text AS artist_slug
    FROM public.releases AS r
    LEFT JOIN public.artists AS a
        ON a.id = r.release_artist_id
    WHERE r.id = ANY(release_ids)
      AND (r.release_artist_id IS NULL OR a.status = 'published');
$$;

GRANT EXECUTE ON FUNCTION public.get_release_summaries_by_ids(uuid[])
TO anon, authenticated, service_role;
