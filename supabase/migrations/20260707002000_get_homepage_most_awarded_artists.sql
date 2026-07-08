CREATE OR REPLACE FUNCTION public.get_homepage_most_awarded_artists(
  p_limit integer DEFAULT 10
)
RETURNS TABLE (
  id uuid,
  slug text,
  name text,
  province text,
  views bigint,
  award_count bigint,
  nomination_count bigint
)
LANGUAGE sql
STABLE
SECURITY INVOKER
SET search_path = public
AS $$
  WITH award_counts AS (
    SELECT
      aa.artist_id,
      COUNT(*) FILTER (WHERE aa.won IS TRUE) AS award_count,
      COUNT(*) FILTER (WHERE aa.won IS NOT TRUE) AS nomination_count
    FROM public.artist_awards aa
    WHERE aa.artist_id IS NOT NULL
    GROUP BY aa.artist_id
  )
  SELECT
    a.id,
    a.slug,
    a.name,
    a.province,
    COALESCE(a.views, 0)::bigint AS views,
    ac.award_count,
    ac.nomination_count
  FROM award_counts ac
  JOIN public.artists a ON a.id = ac.artist_id
  WHERE a.status = 'published'
  ORDER BY
    ac.award_count DESC,
    (ac.award_count + ac.nomination_count) DESC,
    COALESCE(a.views, 0) DESC,
    a.name ASC
  LIMIT LEAST(GREATEST(p_limit, 1), 50);
$$;
