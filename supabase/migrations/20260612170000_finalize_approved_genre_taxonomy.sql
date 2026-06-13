BEGIN;

SELECT pg_advisory_xact_lock(hashtext('mangulina-approved-genre-taxonomy-20260612'));

-- These canonical backups are intentionally created before this migration changes
-- descriptions or ordering. Existing backup tables are never overwritten.
CREATE TABLE IF NOT EXISTS public.genres_backup_before_taxonomy_migration AS
SELECT * FROM public.genres;

CREATE TABLE IF NOT EXISTS public.genre_import_mapping_backup_before_taxonomy_migration AS
SELECT * FROM public.genre_import_mapping;

CREATE TABLE IF NOT EXISTS public.recordings_genres_backup_before_taxonomy_migration AS
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

CREATE TABLE IF NOT EXISTS public.genre_taxonomy_final_validation_20260612 (
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
    SELECT count(*) INTO actual
    FROM public.genres
    WHERE active AND level = 0 AND parent_id IS NULL
      AND name IN (
          'Worship', 'Merengue', 'Bachata', 'Urban', 'Salsa', 'Ballads', 'Pop',
          'Rock', 'Reggae', 'Jazz', 'Electronic', 'Instrumental', 'Folklore', 'Fusion'
      );
    IF actual <> 14 THEN
        RAISE EXCEPTION 'Expected all 14 approved top-level genres; found %', actual;
    END IF;

    SELECT count(*) INTO actual
    FROM public.genres
    WHERE lower(coalesce(name, '')) ~ '(christian|cristian)'
       OR lower(coalesce(slug, '')) ~ '(christian|cristian)';
    IF actual <> 0 THEN
        RAISE EXCEPTION 'Christian taxonomy rows remain: %', actual;
    END IF;

    SELECT count(*) INTO actual FROM public.genres WHERE id = 53;
    IF actual <> 0 THEN
        RAISE EXCEPTION 'Obsolete Jazz ID 53 still exists';
    END IF;

    SELECT count(*) INTO actual
    FROM public.recordings
    WHERE recording_context NOT IN ('christian', 'secular') OR recording_context IS NULL;
    IF actual <> 0 THEN
        RAISE EXCEPTION 'Invalid recording_context rows: %', actual;
    END IF;
END $$;

UPDATE public.genres
SET description = CASE id
        WHEN 9 THEN 'Instrumental, classical, orchestral, and performance music.'
        WHEN 36 THEN 'Jazz, Latin Jazz, improvisational, and jazz-influenced music.'
        WHEN 55 THEN 'Rock, alternative rock, indie rock, and related guitar-driven music.'
        WHEN 56 THEN 'Electronic, DJ, house, dance, and related electronic music.'
        WHEN 57 THEN 'Reggae, dancehall, and reggae-influenced Caribbean music.'
        WHEN 58 THEN 'Popular contemporary music including Latin Pop and crossover styles.'
        ELSE description
    END
WHERE id IN (9, 36, 55, 56, 57, 58);

UPDATE public.genres
SET sort_order = CASE name
        WHEN 'Worship' THEN 1
        WHEN 'Merengue' THEN 2
        WHEN 'Bachata' THEN 3
        WHEN 'Urban' THEN 4
        WHEN 'Salsa' THEN 5
        WHEN 'Ballads' THEN 6
        WHEN 'Pop' THEN 7
        WHEN 'Rock' THEN 8
        WHEN 'Reggae' THEN 9
        WHEN 'Jazz' THEN 10
        WHEN 'Electronic' THEN 11
        WHEN 'Instrumental' THEN 12
        WHEN 'Folklore' THEN 13
        WHEN 'Fusion' THEN 14
    END,
    display_order = CASE name
        WHEN 'Worship' THEN 1
        WHEN 'Merengue' THEN 2
        WHEN 'Bachata' THEN 3
        WHEN 'Urban' THEN 4
        WHEN 'Salsa' THEN 5
        WHEN 'Ballads' THEN 6
        WHEN 'Pop' THEN 7
        WHEN 'Rock' THEN 8
        WHEN 'Reggae' THEN 9
        WHEN 'Jazz' THEN 10
        WHEN 'Electronic' THEN 11
        WHEN 'Instrumental' THEN 12
        WHEN 'Folklore' THEN 13
        WHEN 'Fusion' THEN 14
    END,
    level = 0,
    parent_id = NULL,
    active = true
WHERE id IN (13, 1, 2, 10, 5, 7, 58, 55, 57, 36, 56, 9, 11, 12);

DO $$
DECLARE
    pop_id bigint;
    actual integer;
BEGIN
    SELECT id INTO STRICT pop_id
    FROM public.genres
    WHERE name = 'Pop' AND level = 0 AND parent_id IS NULL AND active;

    UPDATE public.genres
    SET parent_id = pop_id, level = 1, active = true
    WHERE id = 29 AND name = 'Latin Pop';

    UPDATE public.genres
    SET parent_id = 7, level = 1, active = true
    WHERE id = 51 AND name = 'Bolero';

    SELECT count(*) INTO actual
    FROM public.genres child
    JOIN public.genres parent ON parent.id = child.parent_id
    WHERE child.active AND child.level = 1
      AND child.name IN ('Jazz', 'Rock', 'Rock / Alternative', 'Electronic', 'Reggae')
      AND parent.name = 'Fusion';
    IF actual <> 0 THEN
        RAISE EXCEPTION 'Fusion still contains % promoted genre rows', actual;
    END IF;
END $$;

INSERT INTO public.genre_taxonomy_final_validation_20260612 (
    stage,
    total_recordings,
    main_genres,
    child_genres,
    christian_genre_rows,
    christian_context_recordings,
    worship_recordings,
    invalid_recording_relationships,
    invalid_mapping_relationships,
    null_genre_id,
    null_subgenre_id,
    null_recording_context,
    legacy_subgenres,
    legacy_unmatched_rows
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
    );

DO $$
DECLARE
    validation public.genre_taxonomy_final_validation_20260612%ROWTYPE;
    misplaced_rows integer;
BEGIN
    SELECT * INTO STRICT validation
    FROM public.genre_taxonomy_final_validation_20260612
    WHERE stage = 'final_before_commit';

    SELECT count(*) INTO misplaced_rows
    FROM public.genres
    WHERE (id = 29 AND parent_id IS DISTINCT FROM 58)
       OR (id = 51 AND parent_id IS DISTINCT FROM 7)
       OR (id IN (36, 55, 56, 57) AND (parent_id IS NOT NULL OR level <> 0));

    IF validation.main_genres <> 14
       OR validation.child_genres <> 35
       OR validation.christian_genre_rows <> 0
       OR validation.invalid_recording_relationships <> 0
       OR validation.invalid_mapping_relationships <> 0
       OR validation.null_recording_context <> 0
       OR validation.legacy_unmatched_rows <> 0
       OR misplaced_rows <> 0 THEN
        RAISE EXCEPTION 'Approved taxonomy validation failed: %, misplaced rows %',
            row_to_json(validation), misplaced_rows;
    END IF;
END $$;

COMMIT;
