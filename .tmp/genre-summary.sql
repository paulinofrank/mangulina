-- Genre summary by count
SELECT
  g.id,
  g.name AS "Genre",
  g.slug,
  COUNT(r.id) AS "Count",
  ROUND(100.0 * COUNT(r.id) / (SELECT COUNT(*) FROM public.recordings), 1) AS "Percent (%)",
  ROUND(100.0 * COUNT(r.id) / (SELECT COUNT(*) FROM public.recordings WHERE genre_id IS NOT NULL), 1) AS "Percent of Assigned (%)"
FROM public.genres g
LEFT JOIN public.recordings r ON r.genre_id = g.id
WHERE g.level = 0 AND g.active
GROUP BY g.id, g.name, g.slug
ORDER BY COUNT(r.id) DESC
