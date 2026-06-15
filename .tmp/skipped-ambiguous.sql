-- 2,049 intentionally skipped recordings (ambiguous/evidence-less)
SELECT
  a.name AS "Artist Name",
  COALESCE(rel.title, r.metadata->>'album', '(unknown)') AS "Album Name",
  r.title AS "Song Name",
  ROUND(r.duration / 1000.0, 2) AS "Duration (seconds)"
FROM public.recordings r
LEFT JOIN public.artists a ON a.id = r.artist_id
LEFT JOIN public.releases rel ON rel.id = r.release_id
WHERE r.genre_id IS NULL
ORDER BY a.name, COALESCE(rel.title, r.metadata->>'album', ''), r.title
