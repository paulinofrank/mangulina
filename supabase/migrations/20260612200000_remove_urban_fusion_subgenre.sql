-- Removes the Urban -> Fusion child genre (id 46) per the approved taxonomy.
-- The approved hierarchy keeps Fusion only as a top-level genre; Urban keeps
-- Reggaeton, Dembow, Rap / Hip Hop, Trap, and Drill.
BEGIN;

SELECT pg_advisory_xact_lock(hashtext('mangulina-remove-urban-fusion-20260612'));

CREATE TABLE IF NOT EXISTS public.genres_backup_before_urban_fusion_removal AS
SELECT * FROM public.genres;

CREATE TABLE IF NOT EXISTS public.genre_import_mapping_backup_before_urban_fusion_removal AS
SELECT * FROM public.genre_import_mapping;

CREATE TABLE IF NOT EXISTS public.recordings_genres_backup_before_urban_fusion_removal AS
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

DO $$
DECLARE
    actual integer;
BEGIN
    SELECT count(*) INTO actual
    FROM public.genres
    WHERE id = 46 AND name = 'Fusion' AND parent_id = 10 AND level = 1;
    IF actual <> 1 THEN
        RAISE EXCEPTION 'Expected Urban Fusion (id 46) as a child of Urban; found % matching rows', actual;
    END IF;

    SELECT count(*) INTO actual
    FROM public.recordings
    WHERE genre_id = 46 OR subgenre_id = 46;
    IF actual <> 0 THEN
        RAISE EXCEPTION '% recordings still reference Urban Fusion (id 46)', actual;
    END IF;

    SELECT count(*) INTO actual
    FROM public.genre_import_mapping
    WHERE genre_id = 46 OR subgenre_id = 46;
    IF actual <> 0 THEN
        RAISE EXCEPTION '% import mappings still reference Urban Fusion (id 46)', actual;
    END IF;
END $$;

DELETE FROM public.genres WHERE id = 46;

WITH ordered AS (
    SELECT id, row_number() OVER (ORDER BY sort_order, name, id)::integer AS new_order
    FROM public.genres
    WHERE parent_id = 10 AND level = 1 AND active
)
UPDATE public.genres g
SET sort_order = ordered.new_order
FROM ordered
WHERE g.id = ordered.id;

DO $$
DECLARE
    total_recordings integer;
    christian_recordings integer;
    main_genres integer;
    child_genres integer;
    christian_genre_rows integer;
    invalid_recordings integer;
    invalid_mappings integer;
    urban_fusion_rows integer;
BEGIN
    SELECT count(*) INTO total_recordings FROM public.recordings;
    SELECT count(*) INTO christian_recordings
    FROM public.recordings WHERE recording_context = 'christian';
    SELECT count(*) INTO main_genres
    FROM public.genres WHERE active AND level = 0 AND parent_id IS NULL;
    SELECT count(*) INTO child_genres
    FROM public.genres WHERE active AND level = 1 AND parent_id IS NOT NULL;
    SELECT count(*) INTO christian_genre_rows
    FROM public.genres
    WHERE lower(coalesce(name, '')) ~ '(christian|cristian)'
       OR lower(coalesce(slug, '')) ~ '(christian|cristian)';
    SELECT count(*) INTO urban_fusion_rows
    FROM public.genres
    WHERE id = 46 OR slug = 'urban-fusion';

    SELECT count(*) INTO invalid_recordings
    FROM public.recordings r
    LEFT JOIN public.genres g ON g.id = r.genre_id
    LEFT JOIN public.genres sg ON sg.id = r.subgenre_id
    WHERE (r.genre_id IS NOT NULL AND (g.id IS NULL OR g.level <> 0 OR g.parent_id IS NOT NULL OR NOT g.active))
       OR (r.subgenre_id IS NOT NULL AND (sg.id IS NULL OR sg.level <> 1 OR sg.parent_id IS DISTINCT FROM r.genre_id OR NOT sg.active));

    SELECT count(*) INTO invalid_mappings
    FROM public.genre_import_mapping m
    LEFT JOIN public.genres g ON g.id = m.genre_id
    LEFT JOIN public.genres sg ON sg.id = m.subgenre_id
    WHERE (m.genre_id IS NOT NULL AND (g.id IS NULL OR g.level <> 0 OR g.parent_id IS NOT NULL OR NOT g.active))
       OR (m.subgenre_id IS NOT NULL AND (sg.id IS NULL OR sg.level <> 1 OR sg.parent_id IS DISTINCT FROM m.genre_id OR NOT sg.active));

    IF total_recordings <> 17398
       OR christian_recordings <> 119
       OR main_genres <> 14
       OR child_genres <> 34
       OR christian_genre_rows <> 0
       OR invalid_recordings <> 0
       OR invalid_mappings <> 0
       OR urban_fusion_rows <> 0 THEN
        RAISE EXCEPTION 'Urban Fusion removal validation failed: recordings %, christian %, main %, children %, christian rows %, invalid recordings %, invalid mappings %, urban fusion rows %',
            total_recordings, christian_recordings, main_genres, child_genres,
            christian_genre_rows, invalid_recordings, invalid_mappings, urban_fusion_rows;
    END IF;
END $$;

COMMIT;
