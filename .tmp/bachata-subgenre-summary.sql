-- Bachata recordings by subgenre
SELECT
  COALESCE(sg.name, '(no subgenre)') AS "Subgenre",
  COALESCE(sg.slug, '') AS "Slug",
  COUNT(r.id)::int AS "Count",
  ROUND(100.0 * COUNT(r.id) / (SELECT COUNT(*) FROM public.recordings WHERE genre_id = 2), 1) AS "Percent of Bachata (%)"
FROM public.recordings r
LEFT JOIN public.genres sg ON sg.id = r.subgenre_id
WHERE r.genre_id = 2
GROUP BY sg.id, sg.name, sg.slug
ORDER BY COUNT(r.id) DESC
