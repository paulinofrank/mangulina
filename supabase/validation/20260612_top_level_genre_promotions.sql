-- Persisted snapshots captured inside the migration transaction.
SELECT *
FROM public.genre_taxonomy_migration_validation_20260612
ORDER BY captured_at, stage;

-- Final main genre report.
SELECT g.id, g.name, g.slug, g.sort_order, count(r.id) AS recording_count
FROM public.genres g
LEFT JOIN public.recordings r ON r.genre_id = g.id
WHERE g.active AND g.level = 0 AND g.parent_id IS NULL
GROUP BY g.id, g.name, g.slug, g.sort_order
ORDER BY g.sort_order, g.name;

-- Final parent-child hierarchy.
SELECT parent.name AS parent_genre, child.id, child.name AS child_genre, child.slug, child.sort_order
FROM public.genres child
JOIN public.genres parent ON parent.id = child.parent_id
WHERE parent.active AND child.active AND child.level = 1
ORDER BY parent.sort_order, child.sort_order, child.name;

-- Invalid relationships (expected: zero rows).
SELECT r.id, r.title, r.genre_id, g.name AS genre, r.subgenre_id, sg.name AS subgenre
FROM public.recordings r
LEFT JOIN public.genres g ON g.id = r.genre_id
LEFT JOIN public.genres sg ON sg.id = r.subgenre_id
WHERE (r.genre_id IS NOT NULL AND (g.level <> 0 OR g.parent_id IS NOT NULL OR NOT g.active))
   OR (r.subgenre_id IS NOT NULL AND (sg.level <> 1 OR sg.parent_id IS DISTINCT FROM r.genre_id OR NOT sg.active));

-- Jazz ID 53 references and row (all expected zero).
SELECT
    (SELECT count(*) FROM public.genres WHERE id = 53) AS genre_rows,
    (SELECT count(*) FROM public.recordings WHERE genre_id = 53 OR subgenre_id = 53) AS recording_references,
    (SELECT count(*) FROM public.genre_import_mapping WHERE genre_id = 53 OR subgenre_id = 53) AS mapping_references;
