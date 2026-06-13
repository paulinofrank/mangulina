-- Persisted final validation captured inside the applied migration.
SELECT *
FROM public.genre_taxonomy_final_validation_20260612
ORDER BY captured_at, stage;

-- 1. Main genre counts.
SELECT g.name AS genre, count(r.id) AS recording_count
FROM public.genres g
LEFT JOIN public.recordings r ON r.genre_id = g.id
WHERE g.active AND g.level = 0 AND g.parent_id IS NULL
GROUP BY g.id, g.name, g.sort_order
ORDER BY g.sort_order, g.name;

-- 2. Subgenre counts.
SELECT parent.name AS parent_genre, child.name AS subgenre, count(r.id) AS recording_count
FROM public.genres child
JOIN public.genres parent ON parent.id = child.parent_id
LEFT JOIN public.recordings r ON r.subgenre_id = child.id
WHERE parent.active AND child.active AND child.level = 1
GROUP BY parent.id, parent.name, parent.sort_order, child.id, child.name, child.sort_order
ORDER BY parent.sort_order, child.sort_order, child.name;

-- 3. Christian rows remaining (expected: 0).
SELECT count(*) AS christian_rows_remaining
FROM public.genres
WHERE lower(coalesce(name, '')) ~ '(christian|cristian)'
   OR lower(coalesce(slug, '')) ~ '(christian|cristian)';

-- 4. Christian-context recordings by musical genre.
SELECT g.name AS genre, sg.name AS subgenre, count(*) AS recording_count
FROM public.recordings r
LEFT JOIN public.genres g ON g.id = r.genre_id
LEFT JOIN public.genres sg ON sg.id = r.subgenre_id
WHERE r.recording_context = 'christian'
GROUP BY g.name, sg.name
ORDER BY recording_count DESC, g.name, sg.name;

-- 5. Worship usage.
SELECT count(*) AS worship_recordings
FROM public.recordings r
JOIN public.genres g ON g.id = r.genre_id
WHERE g.name = 'Worship' AND g.level = 0 AND g.parent_id IS NULL;

-- 6. Invalid relationships (expected: zero rows).
SELECT r.id, r.title, r.genre_id, g.name AS genre, r.subgenre_id, sg.name AS subgenre
FROM public.recordings r
LEFT JOIN public.genres g ON g.id = r.genre_id
LEFT JOIN public.genres sg ON sg.id = r.subgenre_id
WHERE (r.genre_id IS NOT NULL AND (g.id IS NULL OR g.level <> 0 OR g.parent_id IS NOT NULL OR NOT g.active))
   OR (r.subgenre_id IS NOT NULL AND (sg.id IS NULL OR sg.level <> 1 OR sg.parent_id IS DISTINCT FROM r.genre_id OR NOT sg.active));

-- 7. Null classifications.
SELECT
    count(*) FILTER (WHERE genre_id IS NULL) AS genre_id_null,
    count(*) FILTER (WHERE subgenre_id IS NULL) AS subgenre_id_null,
    count(*) FILTER (WHERE recording_context IS NULL) AS recording_context_null
FROM public.recordings;

-- Legacy subgenres readiness. The sole non-direct match is the documented
-- duplicate Jazz source row consolidated into canonical Jazz ID 36.
SELECT s.id, s.genre_id, s.name, g.id AS migrated_genre_id, g.name AS migrated_name
FROM public.subgenres s
LEFT JOIN public.genres g ON g.legacy_subgenre_id = s.id
WHERE g.id IS NULL
  AND NOT (s.id = 40 AND lower(s.name) = 'jazz' AND EXISTS (
      SELECT 1 FROM public.genres canonical
      WHERE canonical.id = 36 AND canonical.name = 'Jazz'
  ));

-- Foreign keys still targeting the legacy table (expected: zero rows).
SELECT conrelid::regclass AS table_name, conname, pg_get_constraintdef(oid) AS definition
FROM pg_constraint
WHERE contype = 'f' AND confrelid = 'public.subgenres'::regclass;
