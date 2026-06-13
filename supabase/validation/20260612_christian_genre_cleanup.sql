-- A. Christian rows remaining in genres (expected: zero rows)
SELECT id, name, slug, parent_id, level
FROM public.genres
WHERE lower(coalesce(name, '')) LIKE '%christian%'
   OR lower(coalesce(name, '')) LIKE '%cristian%'
   OR lower(coalesce(slug, '')) LIKE '%christian%'
   OR lower(coalesce(slug, '')) LIKE '%cristian%';

-- B. Recordings pointing to deleted Christian IDs (expected: zero rows)
SELECT r.id, r.title, r.genre_id, r.subgenre_id
FROM public.recordings r
LEFT JOIN public.genres genre ON genre.id = r.genre_id
LEFT JOIN public.genres child ON child.id = r.subgenre_id
WHERE (r.genre_id IS NOT NULL AND genre.id IS NULL)
   OR (r.subgenre_id IS NOT NULL AND child.id IS NULL);

-- C. Christian-context recordings by musical genre and subgenre
SELECT genre.name AS genre_name, child.name AS subgenre_name, count(*) AS recording_count
FROM public.recordings r
LEFT JOIN public.genres genre ON genre.id = r.genre_id
LEFT JOIN public.genres child ON child.id = r.subgenre_id
WHERE r.recording_context = 'christian'
GROUP BY genre.name, child.name
ORDER BY recording_count DESC, genre.name, child.name;

-- D. Worship usage
SELECT count(*) AS worship_recording_count
FROM public.recordings r
JOIN public.genres genre ON genre.id = r.genre_id
WHERE genre.level = 0 AND lower(genre.name) = 'worship';

-- E. Invalid parent relationships (expected: zero rows)
SELECT
    r.id,
    r.title,
    r.genre_id,
    genre.name AS genre_name,
    genre.level AS genre_level,
    r.subgenre_id,
    child.name AS subgenre_name,
    child.level AS subgenre_level,
    child.parent_id
FROM public.recordings r
LEFT JOIN public.genres genre ON genre.id = r.genre_id
LEFT JOIN public.genres child ON child.id = r.subgenre_id
WHERE
    (r.genre_id IS NOT NULL AND (genre.level <> 0 OR genre.parent_id IS NOT NULL))
    OR (r.subgenre_id IS NOT NULL AND (
        child.level <> 1 OR child.parent_id IS DISTINCT FROM r.genre_id
    ));
