CREATE OR REPLACE FUNCTION public.get_homepage_region_counts()
RETURNS TABLE (
  province text,
  count bigint
)
LANGUAGE sql
STABLE
SECURITY INVOKER
SET search_path = public
AS $$
  SELECT
    trim(a.province) AS province,
    COUNT(*)::bigint AS count
  FROM public.artists a
  WHERE a.status = 'published'
    AND a.province IS NOT NULL
    AND trim(a.province) <> ''
    AND lower(trim(a.province)) NOT IN ('unknown', 'no province', 'born abroad')
  GROUP BY trim(a.province)
  ORDER BY
    COUNT(*) DESC,
    trim(a.province) ASC;
$$;
