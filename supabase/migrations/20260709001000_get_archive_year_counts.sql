CREATE OR REPLACE FUNCTION public.get_archive_year_counts(
  p_start_year integer,
  p_end_year integer
)
RETURNS TABLE (
  year integer,
  count bigint
)
LANGUAGE sql
STABLE
SET search_path = ''
AS $$
  SELECT
    rwi.release_year_actual::integer AS year,
    count(*)::bigint AS count
  FROM public.recordings_with_release_info AS rwi
  LEFT JOIN public.artists AS a
    ON a.id = rwi.artist_id
  WHERE rwi.release_year_actual IS NOT NULL
    AND rwi.release_year_actual >= p_start_year
    AND rwi.release_year_actual <= p_end_year
    AND (rwi.artist_id IS NULL OR a.status = 'published')
  GROUP BY rwi.release_year_actual::integer
  ORDER BY year ASC;
$$;

COMMENT ON FUNCTION public.get_archive_year_counts(integer, integer)
IS 'Returns published archive recording counts grouped by release year for archive decade/year carousels.';

GRANT EXECUTE ON FUNCTION public.get_archive_year_counts(integer, integer)
TO anon, authenticated, service_role;
