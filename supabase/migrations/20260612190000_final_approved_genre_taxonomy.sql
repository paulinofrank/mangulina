BEGIN;

SELECT pg_advisory_xact_lock(hashtext('mangulina-final-approved-taxonomy-20260612'));

CREATE TABLE IF NOT EXISTS public.genres_backup_before_final_taxonomy AS
SELECT * FROM public.genres;

CREATE TABLE IF NOT EXISTS public.genre_import_mapping_backup_before_final_taxonomy AS
SELECT * FROM public.genre_import_mapping;

CREATE TABLE IF NOT EXISTS public.recordings_genres_backup_before_final_taxonomy AS
SELECT
    id,
    title,
    genre_id,
    subgenre_id,
    recording_context,
    ai_confidence,
    ai_reason,
    classified_at
FROM public.recordings;

CREATE TABLE IF NOT EXISTS public.genre_taxonomy_final_approved_validation_20260612 (
    stage text PRIMARY KEY,
    captured_at timestamptz NOT NULL DEFAULT now(),
    total_recordings integer NOT NULL,
    main_genres integer NOT NULL,
    child_genres integer NOT NULL,
    christian_genre_rows integer NOT NULL,
    christian_context_recordings integer NOT NULL,
    worship_recordings integer NOT NULL,
    invalid_recording_relationships integer NOT NULL,
    invalid_mapping_relationships integer NOT NULL,
    jazz_53_rows integer NOT NULL,
    jazz_53_references integer NOT NULL,
    null_genre_id integer NOT NULL,
    null_subgenre_id integer NOT NULL,
    null_recording_context integer NOT NULL,
    legacy_subgenres integer NOT NULL,
    legacy_unmatched_rows integer NOT NULL
);

DO $$
DECLARE
    actual integer;
BEGIN
    SELECT count(*) INTO actual FROM public.recordings;
    IF actual <> 17398 THEN
        RAISE EXCEPTION 'Expected 17398 recordings before migration; found %', actual;
    END IF;

    SELECT count(*) INTO actual
    FROM public.genres
    WHERE lower(coalesce(name, '')) ~ '(christian|cristian)'
       OR lower(coalesce(slug, '')) ~ '(christian|cristian)';
    IF actual <> 0 THEN
        RAISE EXCEPTION 'Christian taxonomy rows remain before finalization: %', actual;
    END IF;

    SELECT count(*) INTO actual
    FROM public.recordings
    WHERE recording_context IS NULL
       OR recording_context NOT IN ('secular', 'christian');
    IF actual <> 0 THEN
        RAISE EXCEPTION 'Invalid recording_context rows before finalization: %', actual;
    END IF;
END $$;

UPDATE public.genres
SET description = CASE id
        WHEN 58 THEN 'Popular contemporary music including Latin Pop and crossover styles.'
        WHEN 55 THEN 'Rock, alternative rock, indie rock, and related guitar-driven music.'
        WHEN 57 THEN 'Reggae, dancehall, and reggae-influenced Caribbean music.'
        WHEN 36 THEN 'Jazz, Latin Jazz, improvisational, and jazz-influenced music.'
        WHEN 56 THEN 'Electronic, DJ, house, dance, and related electronic music.'
        WHEN 9 THEN 'Instrumental, classical, orchestral, and performance music.'
        WHEN 29 THEN 'Latin pop and crossover pop styles.'
        WHEN 51 THEN 'Traditional romantic bolero music.'
        ELSE description
    END
WHERE id IN (58, 55, 57, 36, 56, 9, 29, 51);

WITH approved(id, name, slug, sort_order) AS (
    VALUES
        (13::bigint, 'Worship', 'worship', 1),
        (1::bigint, 'Merengue', 'merengue', 2),
        (2::bigint, 'Bachata', 'bachata', 3),
        (10::bigint, 'Urban', 'urbano', 4),
        (5::bigint, 'Salsa', 'salsa', 5),
        (7::bigint, 'Ballads', 'ballads', 6),
        (58::bigint, 'Pop', 'pop', 7),
        (55::bigint, 'Rock', 'rock', 8),
        (57::bigint, 'Reggae', 'reggae', 9),
        (36::bigint, 'Jazz', 'jazz', 10),
        (56::bigint, 'Electronic', 'electronic', 11),
        (9::bigint, 'Instrumental', 'instrumental', 12),
        (11::bigint, 'Folklore', 'folklore', 13),
        (12::bigint, 'Fusion', 'fusion', 14)
)
UPDATE public.genres g
SET name = approved.name,
    slug = approved.slug,
    parent_id = NULL,
    level = 0,
    sort_order = approved.sort_order,
    display_order = approved.sort_order,
    active = true
FROM approved
WHERE g.id = approved.id;

WITH approved(id, parent_id, name, slug, sort_order) AS (
    VALUES
        (31::bigint, 13::bigint, 'Gospel', 'worship-gospel', 1),
        (14, 1, 'Perico Ripiao', 'merengue-perico-ripiao', 1),
        (15, 1, 'Orquesta', 'merengue-orquesta', 2),
        (16, 1, 'Calle', 'merengue-calle', 3),
        (17, 1, 'Urbano', 'merengue-urbano', 4),
        (18, 1, 'House', 'merengue-house', 5),
        (19, 1, 'Pambiche', 'merengue-pambiche', 6),
        (20, 1, 'Mambo', 'merengue-mambo', 7),
        (21, 2, 'Tradicional', 'bachata-tradicional', 1),
        (22, 2, 'Moderna', 'bachata-moderna', 2),
        (23, 2, 'Urbana', 'bachata-urbana', 3),
        (24, 2, 'Romántica', 'bachata-romantica', 4),
        (41, 10, 'Reggaeton', 'urban-reggaeton', 1),
        (42, 10, 'Dembow', 'urban-dembow', 2),
        (43, 10, 'Rap / Hip Hop', 'urban-rap-hip-hop', 3),
        (44, 10, 'Trap', 'urban-trap', 4),
        (45, 10, 'Drill', 'urban-drill', 5),
        (46, 10, 'Fusion', 'urban-fusion', 6),
        (25, 5, 'Romántica', 'salsa-romantica', 1),
        (26, 5, 'Dura', 'salsa-dura', 2),
        (27, 5, 'Dominicana', 'salsa-dominicana', 3),
        (28, 7, 'Romantic', 'ballads-romantic', 1),
        (30, 7, 'Singer-Songwriter', 'ballads-singer-songwriter', 2),
        (51, 7, 'Bolero', 'ballads-bolero', 3),
        (29, 58, 'Latin Pop', 'pop-latin-pop', 1),
        (37, 9, 'Classical', 'instrumental-classical', 1),
        (38, 9, 'Orchestral', 'instrumental-orchestral', 2),
        (39, 9, 'Piano', 'instrumental-piano', 3),
        (40, 9, 'Popular', 'instrumental-popular', 4),
        (47, 11, 'Dominicano', 'folklore-dominicano', 1),
        (48, 11, 'Palos / Atabales', 'folklore-palos-atabales', 2),
        (49, 11, 'Raíz', 'folklore-raiz', 3),
        (50, 11, 'Son Dominicano', 'folklore-son-dominicano', 4),
        (52, 12, 'Tropical', 'fusion-tropical', 1),
        (54, 12, 'Afro-Caribbean', 'fusion-afro-caribbean', 2)
)
UPDATE public.genres g
SET name = approved.name,
    slug = approved.slug,
    parent_id = approved.parent_id,
    level = 1,
    sort_order = approved.sort_order,
    display_order = NULL,
    is_home_featured = false,
    active = true
FROM approved
WHERE g.id = approved.id;

UPDATE public.genre_import_mapping m
SET genre_name = g.name,
    subgenre_name = (
        SELECT sg.name FROM public.genres sg WHERE sg.id = m.subgenre_id
    )
FROM public.genres g
WHERE g.id = m.genre_id
  AND (
      m.genre_name IS DISTINCT FROM g.name
      OR m.subgenre_name IS DISTINCT FROM (
          SELECT sg.name FROM public.genres sg WHERE sg.id = m.subgenre_id
      )
  );

INSERT INTO public.genre_taxonomy_final_approved_validation_20260612 (
    stage, total_recordings, main_genres, child_genres, christian_genre_rows,
    christian_context_recordings, worship_recordings,
    invalid_recording_relationships, invalid_mapping_relationships,
    jazz_53_rows, jazz_53_references,
    null_genre_id, null_subgenre_id, null_recording_context,
    legacy_subgenres, legacy_unmatched_rows
)
SELECT
    'final_before_commit',
    (SELECT count(*)::integer FROM public.recordings),
    (SELECT count(*)::integer FROM public.genres WHERE active AND level = 0 AND parent_id IS NULL),
    (SELECT count(*)::integer FROM public.genres WHERE active AND level = 1 AND parent_id IS NOT NULL),
    (
        SELECT count(*)::integer FROM public.genres
        WHERE lower(coalesce(name, '')) ~ '(christian|cristian)'
           OR lower(coalesce(slug, '')) ~ '(christian|cristian)'
    ),
    (SELECT count(*)::integer FROM public.recordings WHERE recording_context = 'christian'),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = 13),
    (
        SELECT count(*)::integer
        FROM public.recordings r
        LEFT JOIN public.genres g ON g.id = r.genre_id
        LEFT JOIN public.genres sg ON sg.id = r.subgenre_id
        WHERE (r.genre_id IS NOT NULL AND (g.id IS NULL OR g.level <> 0 OR g.parent_id IS NOT NULL OR NOT g.active))
           OR (r.subgenre_id IS NOT NULL AND (sg.id IS NULL OR sg.level <> 1 OR sg.parent_id IS DISTINCT FROM r.genre_id OR NOT sg.active))
    ),
    (
        SELECT count(*)::integer
        FROM public.genre_import_mapping m
        LEFT JOIN public.genres g ON g.id = m.genre_id
        LEFT JOIN public.genres sg ON sg.id = m.subgenre_id
        WHERE (m.genre_id IS NOT NULL AND (g.id IS NULL OR g.level <> 0 OR g.parent_id IS NOT NULL OR NOT g.active))
           OR (m.subgenre_id IS NOT NULL AND (sg.id IS NULL OR sg.level <> 1 OR sg.parent_id IS DISTINCT FROM m.genre_id OR NOT sg.active))
    ),
    (SELECT count(*)::integer FROM public.genres WHERE id = 53),
    (
        SELECT count(*)::integer FROM public.recordings WHERE genre_id = 53 OR subgenre_id = 53
    ) + (
        SELECT count(*)::integer FROM public.genre_import_mapping WHERE genre_id = 53 OR subgenre_id = 53
    ),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id IS NULL),
    (SELECT count(*)::integer FROM public.recordings WHERE subgenre_id IS NULL),
    (SELECT count(*)::integer FROM public.recordings WHERE recording_context IS NULL),
    (SELECT count(*)::integer FROM public.subgenres),
    (
        SELECT count(*)::integer
        FROM public.subgenres s
        LEFT JOIN public.genres g ON g.legacy_subgenre_id = s.id
        WHERE g.id IS NULL
          AND NOT (s.id = 40 AND lower(s.name) = 'jazz' AND EXISTS (
              SELECT 1 FROM public.genres canonical
              WHERE canonical.id = 36 AND canonical.name = 'Jazz'
                AND canonical.level = 0 AND canonical.parent_id IS NULL AND canonical.active
          ))
    )
ON CONFLICT (stage) DO UPDATE SET
    captured_at = now(),
    total_recordings = EXCLUDED.total_recordings,
    main_genres = EXCLUDED.main_genres,
    child_genres = EXCLUDED.child_genres,
    christian_genre_rows = EXCLUDED.christian_genre_rows,
    christian_context_recordings = EXCLUDED.christian_context_recordings,
    worship_recordings = EXCLUDED.worship_recordings,
    invalid_recording_relationships = EXCLUDED.invalid_recording_relationships,
    invalid_mapping_relationships = EXCLUDED.invalid_mapping_relationships,
    jazz_53_rows = EXCLUDED.jazz_53_rows,
    jazz_53_references = EXCLUDED.jazz_53_references,
    null_genre_id = EXCLUDED.null_genre_id,
    null_subgenre_id = EXCLUDED.null_subgenre_id,
    null_recording_context = EXCLUDED.null_recording_context,
    legacy_subgenres = EXCLUDED.legacy_subgenres,
    legacy_unmatched_rows = EXCLUDED.legacy_unmatched_rows;

DO $$
DECLARE
    validation public.genre_taxonomy_final_approved_validation_20260612%ROWTYPE;
    hierarchy_mismatches integer;
    unexpected_rows integer;
BEGIN
    SELECT * INTO STRICT validation
    FROM public.genre_taxonomy_final_approved_validation_20260612
    WHERE stage = 'final_before_commit';

    WITH approved(id, parent_id, level, sort_order) AS (
        VALUES
            (13::bigint, NULL::bigint, 0, 1), (1, NULL, 0, 2), (2, NULL, 0, 3),
            (10, NULL, 0, 4), (5, NULL, 0, 5), (7, NULL, 0, 6), (58, NULL, 0, 7),
            (55, NULL, 0, 8), (57, NULL, 0, 9), (36, NULL, 0, 10), (56, NULL, 0, 11),
            (9, NULL, 0, 12), (11, NULL, 0, 13), (12, NULL, 0, 14),
            (31, 13, 1, 1), (14, 1, 1, 1), (15, 1, 1, 2), (16, 1, 1, 3),
            (17, 1, 1, 4), (18, 1, 1, 5), (19, 1, 1, 6), (20, 1, 1, 7),
            (21, 2, 1, 1), (22, 2, 1, 2), (23, 2, 1, 3), (24, 2, 1, 4),
            (41, 10, 1, 1), (42, 10, 1, 2), (43, 10, 1, 3), (44, 10, 1, 4),
            (45, 10, 1, 5), (46, 10, 1, 6), (25, 5, 1, 1), (26, 5, 1, 2),
            (27, 5, 1, 3), (28, 7, 1, 1), (30, 7, 1, 2), (51, 7, 1, 3),
            (29, 58, 1, 1), (37, 9, 1, 1), (38, 9, 1, 2), (39, 9, 1, 3),
            (40, 9, 1, 4), (47, 11, 1, 1), (48, 11, 1, 2), (49, 11, 1, 3),
            (50, 11, 1, 4), (52, 12, 1, 1), (54, 12, 1, 2)
    )
    SELECT count(*) INTO hierarchy_mismatches
    FROM approved a
    LEFT JOIN public.genres g ON g.id = a.id
    WHERE g.id IS NULL OR NOT g.active OR g.level <> a.level
       OR g.parent_id IS DISTINCT FROM a.parent_id OR g.sort_order <> a.sort_order;

    SELECT count(*) INTO unexpected_rows
    FROM public.genres
    WHERE active AND id NOT IN (
        13,1,2,10,5,7,58,55,57,36,56,9,11,12,
        31,14,15,16,17,18,19,20,21,22,23,24,41,42,43,44,45,46,
        25,26,27,28,30,51,29,37,38,39,40,47,48,49,50,52,54
    );

    IF validation.total_recordings <> 17398
       OR validation.main_genres <> 14
       OR validation.child_genres <> 35
       OR validation.christian_genre_rows <> 0
       OR validation.invalid_recording_relationships <> 0
       OR validation.invalid_mapping_relationships <> 0
       OR validation.jazz_53_rows <> 0
       OR validation.jazz_53_references <> 0
       OR validation.null_recording_context <> 0
       OR validation.legacy_unmatched_rows <> 0
       OR hierarchy_mismatches <> 0
       OR unexpected_rows <> 0 THEN
        RAISE EXCEPTION 'Final taxonomy validation failed: %, hierarchy mismatches %, unexpected active rows %',
            row_to_json(validation), hierarchy_mismatches, unexpected_rows;
    END IF;
END $$;

COMMIT;
