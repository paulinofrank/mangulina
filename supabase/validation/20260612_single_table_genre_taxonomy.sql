-- A. Main genre counts
SELECT g.name AS genre_name, count(r.id) AS recording_count
FROM public.genres g
LEFT JOIN public.recordings r ON r.genre_id = g.id
WHERE g.level = 0 AND g.active
GROUP BY g.id, g.name, g.sort_order
ORDER BY g.sort_order, g.name;

-- B. Subgenre counts
SELECT parent.name AS parent_genre, child.name AS subgenre_name, count(r.id) AS recording_count
FROM public.genres child
JOIN public.genres parent ON parent.id = child.parent_id
LEFT JOIN public.recordings r ON r.subgenre_id = child.id
WHERE child.level = 1 AND child.active AND parent.active
GROUP BY parent.id, parent.name, parent.sort_order, child.id, child.name, child.sort_order
ORDER BY parent.sort_order, parent.name, child.sort_order, child.name;

-- C. Recordings still using the old Christian genre (expected: zero rows)
SELECT r.id, r.title, r.genre_id
FROM public.recordings r
JOIN public.genres g ON g.id = r.genre_id
WHERE lower(g.name) = 'christian';

-- D. Christian-context recordings by musical genre and subgenre
SELECT genre.name AS genre_name, child.name AS subgenre_name, count(*) AS recording_count
FROM public.recordings r
LEFT JOIN public.genres genre ON genre.id = r.genre_id
LEFT JOIN public.genres child ON child.id = r.subgenre_id
WHERE r.recording_context = 'christian'
GROUP BY genre.name, child.name
ORDER BY recording_count DESC, genre.name, child.name;

-- E. Invalid genre/subgenre relationships (expected: zero rows)
SELECT
    r.id,
    r.title,
    r.genre_id,
    genre.name AS genre_name,
    genre.level AS genre_level,
    r.subgenre_id,
    child.name AS subgenre_name,
    child.level AS subgenre_level,
    child.parent_id AS subgenre_parent_id
FROM public.recordings r
LEFT JOIN public.genres genre ON genre.id = r.genre_id
LEFT JOIN public.genres child ON child.id = r.subgenre_id
WHERE
    (r.genre_id IS NOT NULL AND (genre.level <> 0 OR genre.parent_id IS NOT NULL OR NOT genre.active))
    OR (r.subgenre_id IS NOT NULL AND (
        child.level <> 1
        OR child.parent_id IS DISTINCT FROM r.genre_id
        OR NOT child.active
    ));

-- F. Unmapped or null classifications
SELECT
    count(*) FILTER (WHERE genre_id IS NULL) AS genre_id_null,
    count(*) FILTER (WHERE subgenre_id IS NULL) AS subgenre_id_null,
    count(*) FILTER (WHERE recording_context IS NULL) AS recording_context_null
FROM public.recordings;
