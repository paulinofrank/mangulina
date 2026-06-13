BEGIN;

SELECT pg_advisory_xact_lock(hashtext('mangulina-final-genre-taxonomy-20260612'));

CREATE TABLE IF NOT EXISTS public.genres_backup_before_top_level_promotions AS
SELECT * FROM public.genres;

CREATE TABLE IF NOT EXISTS public.recordings_genres_backup_before_top_level_promotions AS
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

CREATE TABLE IF NOT EXISTS public.genre_import_mapping_backup_before_top_level_promotions AS
SELECT * FROM public.genre_import_mapping;

CREATE TABLE IF NOT EXISTS public.genre_taxonomy_migration_validation_20260612 (
    stage text PRIMARY KEY,
    captured_at timestamptz NOT NULL DEFAULT now(),
    total_recordings integer NOT NULL,
    christian_context_recordings integer NOT NULL,
    changed_recordings integer NOT NULL,
    changed_mapping_rows integer NOT NULL,
    active_main_genres integer NOT NULL,
    active_child_genres integer NOT NULL,
    invalid_recording_relationships integer NOT NULL,
    christian_genre_rows integer NOT NULL,
    jazz_53_recording_references integer NOT NULL,
    jazz_53_mapping_references integer NOT NULL,
    pop_recordings integer NOT NULL,
    jazz_recordings integer NOT NULL,
    rock_recordings integer NOT NULL,
    electronic_recordings integer NOT NULL,
    reggae_recordings integer NOT NULL,
    bolero_recordings integer NOT NULL
);

TRUNCATE public.genre_taxonomy_migration_validation_20260612;

DO $$
DECLARE
    actual integer;
BEGIN
    SELECT count(*) INTO actual FROM public.recordings;
    IF actual <> 17398 THEN
        RAISE EXCEPTION 'Preflight failed: expected 17398 recordings, found %', actual;
    END IF;

    SELECT count(*) INTO actual
    FROM public.recordings WHERE recording_context = 'christian';
    IF actual <> 119 THEN
        RAISE EXCEPTION 'Preflight failed: expected 119 Christian-context recordings, found %', actual;
    END IF;

    SELECT count(*) INTO actual
    FROM public.genres
    WHERE lower(coalesce(name, '')) ~ '(christian|cristian)'
       OR lower(coalesce(slug, '')) ~ '(christian|cristian)';
    IF actual <> 0 THEN
        RAISE EXCEPTION 'Preflight failed: found % Christian taxonomy rows', actual;
    END IF;

    SELECT count(*) INTO actual FROM public.genres WHERE id = 53 AND name = 'Jazz';
    IF actual <> 1 THEN
        RAISE EXCEPTION 'Preflight failed: expected Jazz ID 53 to exist exactly once';
    END IF;

    SELECT count(*) INTO actual
    FROM public.recordings
    WHERE (genre_id = 7 AND subgenre_id = 29)
       OR (genre_id = 9 AND subgenre_id = 36)
       OR (genre_id = 12 AND subgenre_id IN (53, 55, 56, 57))
       OR (genre_id = 11 AND subgenre_id = 51);
    IF actual <> 385 THEN
        RAISE EXCEPTION 'Preflight failed: expected 385 recording changes, found %', actual;
    END IF;

    SELECT count(*) INTO actual
    FROM public.genre_import_mapping
    WHERE subgenre_id IN (29, 36, 51, 53, 55, 56, 57);
    IF actual <> 14 THEN
        RAISE EXCEPTION 'Preflight failed: expected 14 mapping changes, found %', actual;
    END IF;
END $$;

DO $$
DECLARE
    pop_id bigint;
BEGIN
    SELECT id INTO pop_id
    FROM public.genres
    WHERE level = 0 AND parent_id IS NULL AND lower(name) = 'pop'
    LIMIT 1;

    IF pop_id IS NULL THEN
        INSERT INTO public.genres (
            name,
            description,
            slug,
            display_order,
            is_home_featured,
            parent_id,
            level,
            sort_order,
            active
        ) VALUES (
            'Pop',
            'Pop music connected to Dominican artists and audiences, including Latin pop and related contemporary styles.',
            'pop',
            7,
            false,
            NULL,
            0,
            7,
            true
        )
        RETURNING id INTO pop_id;
    END IF;

    UPDATE public.genres
    SET parent_id = pop_id,
        level = 1,
        slug = 'pop-latin-pop',
        sort_order = 1,
        display_order = NULL,
        is_home_featured = false,
        active = true
    WHERE id = 29;

    UPDATE public.genres
    SET parent_id = 7,
        level = 1,
        slug = 'ballads-bolero',
        sort_order = 3,
        display_order = NULL,
        is_home_featured = false,
        active = true
    WHERE id = 51;

    UPDATE public.genres
    SET parent_id = NULL,
        level = 0,
        slug = 'jazz',
        sort_order = 10,
        display_order = 10,
        is_home_featured = false,
        active = true
    WHERE id = 36;

    UPDATE public.genres
    SET name = 'Rock',
        parent_id = NULL,
        level = 0,
        slug = 'rock',
        sort_order = 8,
        display_order = 8,
        is_home_featured = false,
        active = true
    WHERE id = 55;

    UPDATE public.genres
    SET parent_id = NULL,
        level = 0,
        slug = 'electronic',
        sort_order = 11,
        display_order = 11,
        is_home_featured = false,
        active = true
    WHERE id = 56;

    UPDATE public.genres
    SET parent_id = NULL,
        level = 0,
        slug = 'reggae',
        sort_order = 9,
        display_order = 9,
        is_home_featured = false,
        active = true
    WHERE id = 57;

    UPDATE public.recordings
    SET genre_id = pop_id
    WHERE genre_id = 7 AND subgenre_id = 29;

    UPDATE public.recordings
    SET genre_id = 36, subgenre_id = NULL
    WHERE (genre_id = 9 AND subgenre_id = 36)
       OR (genre_id = 12 AND subgenre_id = 53);

    UPDATE public.recordings
    SET genre_id = 55, subgenre_id = NULL
    WHERE genre_id = 12 AND subgenre_id = 55;

    UPDATE public.recordings
    SET genre_id = 56, subgenre_id = NULL
    WHERE genre_id = 12 AND subgenre_id = 56;

    UPDATE public.recordings
    SET genre_id = 57, subgenre_id = NULL
    WHERE genre_id = 12 AND subgenre_id = 57;

    UPDATE public.recordings
    SET genre_id = 7
    WHERE genre_id = 11 AND subgenre_id = 51;

    UPDATE public.genre_import_mapping
    SET genre_id = pop_id,
        genre_name = 'Pop',
        subgenre_id = 29,
        subgenre_name = 'Latin Pop'
    WHERE subgenre_id = 29;

    UPDATE public.genre_import_mapping
    SET genre_id = 36,
        genre_name = 'Jazz',
        subgenre_id = NULL,
        subgenre_name = NULL
    WHERE subgenre_id IN (36, 53);

    UPDATE public.genre_import_mapping
    SET genre_id = 7,
        genre_name = 'Ballads',
        subgenre_id = 51,
        subgenre_name = 'Bolero'
    WHERE subgenre_id = 51;

    UPDATE public.genre_import_mapping
    SET genre_id = 55,
        genre_name = 'Rock',
        subgenre_id = NULL,
        subgenre_name = NULL
    WHERE subgenre_id = 55;

    UPDATE public.genre_import_mapping
    SET genre_id = 56,
        genre_name = 'Electronic',
        subgenre_id = NULL,
        subgenre_name = NULL
    WHERE subgenre_id = 56;

    UPDATE public.genre_import_mapping
    SET genre_id = 57,
        genre_name = 'Reggae',
        subgenre_id = NULL,
        subgenre_name = NULL
    WHERE subgenre_id = 57;
END $$;

INSERT INTO public.genre_taxonomy_migration_validation_20260612 (
    stage,
    total_recordings,
    christian_context_recordings,
    changed_recordings,
    changed_mapping_rows,
    active_main_genres,
    active_child_genres,
    invalid_recording_relationships,
    christian_genre_rows,
    jazz_53_recording_references,
    jazz_53_mapping_references,
    pop_recordings,
    jazz_recordings,
    rock_recordings,
    electronic_recordings,
    reggae_recordings,
    bolero_recordings
)
SELECT
    'before_jazz_53_delete',
    (SELECT count(*)::integer FROM public.recordings),
    (SELECT count(*)::integer FROM public.recordings WHERE recording_context = 'christian'),
    (
        SELECT count(*)::integer
        FROM public.recordings r
        JOIN public.recordings_genres_backup_before_top_level_promotions b ON b.id = r.id
        WHERE r.genre_id IS DISTINCT FROM b.genre_id
           OR r.subgenre_id IS DISTINCT FROM b.subgenre_id
           OR r.recording_context IS DISTINCT FROM b.recording_context
    ),
    (
        SELECT count(*)::integer
        FROM public.genre_import_mapping m
        JOIN public.genre_import_mapping_backup_before_top_level_promotions b
          ON b.source_label = m.source_label
        WHERE m.genre_id IS DISTINCT FROM b.genre_id
           OR m.subgenre_id IS DISTINCT FROM b.subgenre_id
           OR m.genre_name IS DISTINCT FROM b.genre_name
           OR m.subgenre_name IS DISTINCT FROM b.subgenre_name
           OR m.recording_context IS DISTINCT FROM b.recording_context
    ),
    (SELECT count(*)::integer FROM public.genres WHERE active AND level = 0 AND parent_id IS NULL),
    (SELECT count(*)::integer FROM public.genres WHERE active AND level = 1 AND parent_id IS NOT NULL),
    (
        SELECT count(*)::integer
        FROM public.recordings r
        LEFT JOIN public.genres g ON g.id = r.genre_id
        LEFT JOIN public.genres sg ON sg.id = r.subgenre_id
        WHERE (r.genre_id IS NOT NULL AND (g.level <> 0 OR g.parent_id IS NOT NULL OR NOT g.active))
           OR (r.subgenre_id IS NOT NULL AND (sg.level <> 1 OR sg.parent_id IS DISTINCT FROM r.genre_id OR NOT sg.active))
    ),
    (
        SELECT count(*)::integer FROM public.genres
        WHERE lower(coalesce(name, '')) ~ '(christian|cristian)'
           OR lower(coalesce(slug, '')) ~ '(christian|cristian)'
    ),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = 53 OR subgenre_id = 53),
    (SELECT count(*)::integer FROM public.genre_import_mapping WHERE genre_id = 53 OR subgenre_id = 53),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = (SELECT id FROM public.genres WHERE level = 0 AND lower(name) = 'pop' LIMIT 1)),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = 36),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = 55),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = 56),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = 57),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = 7 AND subgenre_id = 51);

DO $$
DECLARE
    validation public.genre_taxonomy_migration_validation_20260612%ROWTYPE;
BEGIN
    SELECT * INTO validation
    FROM public.genre_taxonomy_migration_validation_20260612
    WHERE stage = 'before_jazz_53_delete';

    IF validation.total_recordings <> 17398
       OR validation.christian_context_recordings <> 119
       OR validation.changed_recordings <> 385
       OR validation.changed_mapping_rows <> 14
       OR validation.active_main_genres <> 14
       OR validation.active_child_genres <> 36
       OR validation.invalid_recording_relationships <> 0
       OR validation.christian_genre_rows <> 0
       OR validation.jazz_53_recording_references <> 0
       OR validation.jazz_53_mapping_references <> 0
       OR validation.pop_recordings <> 1
       OR validation.jazz_recordings <> 83
       OR validation.rock_recordings <> 301
       OR validation.electronic_recordings <> 0
       OR validation.reggae_recordings <> 0
       OR validation.bolero_recordings <> 0 THEN
        RAISE EXCEPTION 'Pre-delete validation failed: %', row_to_json(validation);
    END IF;
END $$;

DELETE FROM public.genres WHERE id = 53;

UPDATE public.genres
SET sort_order = CASE id
        WHEN 13 THEN 1
        WHEN 1 THEN 2
        WHEN 2 THEN 3
        WHEN 10 THEN 4
        WHEN 5 THEN 5
        WHEN 7 THEN 6
        WHEN 55 THEN 8
        WHEN 57 THEN 9
        WHEN 36 THEN 10
        WHEN 56 THEN 11
        WHEN 9 THEN 12
        WHEN 11 THEN 13
        WHEN 12 THEN 14
        ELSE 7
    END,
    display_order = CASE id
        WHEN 13 THEN 1
        WHEN 1 THEN 2
        WHEN 2 THEN 3
        WHEN 10 THEN 4
        WHEN 5 THEN 5
        WHEN 7 THEN 6
        WHEN 55 THEN 8
        WHEN 57 THEN 9
        WHEN 36 THEN 10
        WHEN 56 THEN 11
        WHEN 9 THEN 12
        WHEN 11 THEN 13
        WHEN 12 THEN 14
        ELSE 7
    END
WHERE level = 0 AND parent_id IS NULL AND active;

WITH ordered AS (
    SELECT id, row_number() OVER (PARTITION BY parent_id ORDER BY sort_order, name, id)::integer AS new_order
    FROM public.genres
    WHERE level = 1 AND parent_id IS NOT NULL AND active
)
UPDATE public.genres g
SET sort_order = ordered.new_order
FROM ordered
WHERE g.id = ordered.id;

INSERT INTO public.genre_taxonomy_migration_validation_20260612 (
    stage,
    total_recordings,
    christian_context_recordings,
    changed_recordings,
    changed_mapping_rows,
    active_main_genres,
    active_child_genres,
    invalid_recording_relationships,
    christian_genre_rows,
    jazz_53_recording_references,
    jazz_53_mapping_references,
    pop_recordings,
    jazz_recordings,
    rock_recordings,
    electronic_recordings,
    reggae_recordings,
    bolero_recordings
)
SELECT
    'final_before_commit',
    (SELECT count(*)::integer FROM public.recordings),
    (SELECT count(*)::integer FROM public.recordings WHERE recording_context = 'christian'),
    (
        SELECT count(*)::integer
        FROM public.recordings r
        JOIN public.recordings_genres_backup_before_top_level_promotions b ON b.id = r.id
        WHERE r.genre_id IS DISTINCT FROM b.genre_id
           OR r.subgenre_id IS DISTINCT FROM b.subgenre_id
           OR r.recording_context IS DISTINCT FROM b.recording_context
    ),
    (
        SELECT count(*)::integer
        FROM public.genre_import_mapping m
        JOIN public.genre_import_mapping_backup_before_top_level_promotions b
          ON b.source_label = m.source_label
        WHERE m.genre_id IS DISTINCT FROM b.genre_id
           OR m.subgenre_id IS DISTINCT FROM b.subgenre_id
           OR m.genre_name IS DISTINCT FROM b.genre_name
           OR m.subgenre_name IS DISTINCT FROM b.subgenre_name
           OR m.recording_context IS DISTINCT FROM b.recording_context
    ),
    (SELECT count(*)::integer FROM public.genres WHERE active AND level = 0 AND parent_id IS NULL),
    (SELECT count(*)::integer FROM public.genres WHERE active AND level = 1 AND parent_id IS NOT NULL),
    (
        SELECT count(*)::integer
        FROM public.recordings r
        LEFT JOIN public.genres g ON g.id = r.genre_id
        LEFT JOIN public.genres sg ON sg.id = r.subgenre_id
        WHERE (r.genre_id IS NOT NULL AND (g.level <> 0 OR g.parent_id IS NOT NULL OR NOT g.active))
           OR (r.subgenre_id IS NOT NULL AND (sg.level <> 1 OR sg.parent_id IS DISTINCT FROM r.genre_id OR NOT sg.active))
    ),
    (
        SELECT count(*)::integer FROM public.genres
        WHERE lower(coalesce(name, '')) ~ '(christian|cristian)'
           OR lower(coalesce(slug, '')) ~ '(christian|cristian)'
    ),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = 53 OR subgenre_id = 53),
    (SELECT count(*)::integer FROM public.genre_import_mapping WHERE genre_id = 53 OR subgenre_id = 53),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = (SELECT id FROM public.genres WHERE level = 0 AND lower(name) = 'pop' LIMIT 1)),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = 36),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = 55),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = 56),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = 57),
    (SELECT count(*)::integer FROM public.recordings WHERE genre_id = 7 AND subgenre_id = 51);

DO $$
DECLARE
    validation public.genre_taxonomy_migration_validation_20260612%ROWTYPE;
    taxonomy_rows integer;
BEGIN
    SELECT * INTO validation
    FROM public.genre_taxonomy_migration_validation_20260612
    WHERE stage = 'final_before_commit';

    SELECT count(*) INTO taxonomy_rows FROM public.genres WHERE active;

    IF validation.total_recordings <> 17398
       OR validation.christian_context_recordings <> 119
       OR validation.changed_recordings <> 385
       OR validation.changed_mapping_rows <> 14
       OR validation.active_main_genres <> 14
       OR validation.active_child_genres <> 35
       OR taxonomy_rows <> 49
       OR validation.invalid_recording_relationships <> 0
       OR validation.christian_genre_rows <> 0
       OR validation.jazz_53_recording_references <> 0
       OR validation.jazz_53_mapping_references <> 0
       OR validation.pop_recordings <> 1
       OR validation.jazz_recordings <> 83
       OR validation.rock_recordings <> 301
       OR validation.electronic_recordings <> 0
       OR validation.reggae_recordings <> 0
       OR validation.bolero_recordings <> 0
       OR EXISTS (SELECT 1 FROM public.genres WHERE id = 53) THEN
        RAISE EXCEPTION 'Final validation failed: %, active taxonomy rows %', row_to_json(validation), taxonomy_rows;
    END IF;
END $$;

COMMIT;
