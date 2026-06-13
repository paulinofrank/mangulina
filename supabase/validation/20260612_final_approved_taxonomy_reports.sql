-- Persisted migration validation.
SELECT *
FROM public.genre_taxonomy_final_approved_validation_20260612
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

-- 3. Christian taxonomy rows (expected: 0).
SELECT count(*) AS christian_rows_remaining
FROM public.genres
WHERE lower(coalesce(name, '')) ~ '(christian|cristian)'
   OR lower(coalesce(slug, '')) ~ '(christian|cristian)';

-- 4. Christian-context recordings.
SELECT g.name AS genre, sg.name AS subgenre, count(*) AS recording_count
FROM public.recordings r
LEFT JOIN public.genres g ON g.id = r.genre_id
LEFT JOIN public.genres sg ON sg.id = r.subgenre_id
WHERE r.recording_context = 'christian'
GROUP BY g.name, sg.name
ORDER BY recording_count DESC, g.name, sg.name;

-- 5. Worship count.
SELECT g.name AS genre, count(r.id) AS recording_count
FROM public.genres g
LEFT JOIN public.recordings r ON r.genre_id = g.id
WHERE g.id = 13 AND g.name = 'Worship'
GROUP BY g.id, g.name;

-- 6. Invalid recording relationships (expected: zero rows).
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

-- Required final backup tables.
SELECT c.relname AS backup_table
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'public'
  AND c.relname IN (
      'genres_backup_before_final_taxonomy',
      'genre_import_mapping_backup_before_final_taxonomy',
      'recordings_genres_backup_before_final_taxonomy'
  )
ORDER BY c.relname;

-- Legacy subgenres table was dropped on 2026-06-12 by drop_legacy_subgenres_table.sql.
-- Expected: subgenres_table is NULL and the backup holds 39 rows.
SELECT
    to_regclass('public.subgenres')::text AS subgenres_table,
    (SELECT count(*) FROM public.subgenres_backup_before_drop) AS backup_rows;
