BEGIN;

CREATE TABLE IF NOT EXISTS public.genres_backup_before_single_table_taxonomy AS
SELECT * FROM public.genres;

CREATE TABLE IF NOT EXISTS public.subgenres_backup_before_single_table_taxonomy AS
SELECT * FROM public.subgenres;

CREATE TABLE IF NOT EXISTS public.genre_import_mapping_backup_before_single_table_taxonomy AS
SELECT * FROM public.genre_import_mapping;

CREATE TABLE IF NOT EXISTS public.recordings_genres_backup_before_single_table_taxonomy AS
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

ALTER TABLE public.genres
    ADD COLUMN IF NOT EXISTS parent_id bigint,
    ADD COLUMN IF NOT EXISTS level integer NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS sort_order integer NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS active boolean NOT NULL DEFAULT true,
    ADD COLUMN IF NOT EXISTS legacy_subgenre_id bigint;

ALTER TABLE public.genres DROP CONSTRAINT IF EXISTS genres_name_key;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'genres_parent_id_fkey'
    ) THEN
        ALTER TABLE public.genres
            ADD CONSTRAINT genres_parent_id_fkey
            FOREIGN KEY (parent_id) REFERENCES public.genres(id) ON DELETE RESTRICT;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'genres_level_parent_check'
    ) THEN
        ALTER TABLE public.genres
            ADD CONSTRAINT genres_level_parent_check
            CHECK (
                (level = 0 AND parent_id IS NULL)
                OR (level = 1 AND parent_id IS NOT NULL)
            );
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'genres_no_self_parent_check'
    ) THEN
        ALTER TABLE public.genres
            ADD CONSTRAINT genres_no_self_parent_check CHECK (parent_id IS NULL OR parent_id <> id);
    END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_genres_parent_id ON public.genres(parent_id);
CREATE INDEX IF NOT EXISTS idx_genres_slug ON public.genres(slug);
CREATE INDEX IF NOT EXISTS idx_genres_name ON public.genres(name);
CREATE UNIQUE INDEX IF NOT EXISTS idx_genres_legacy_subgenre_id
ON public.genres(legacy_subgenre_id)
WHERE legacy_subgenre_id IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS idx_genres_parent_lower_name
ON public.genres(coalesce(parent_id, 0), lower(name));

SELECT setval(
    pg_get_serial_sequence('public.genres', 'id'),
    coalesce((SELECT max(id) FROM public.genres), 1),
    true
);

UPDATE public.genres
SET
    parent_id = NULL,
    level = 0,
    sort_order = coalesce(display_order, 0),
    active = true
WHERE legacy_subgenre_id IS NULL;

WITH christian AS (
    SELECT id, display_order
    FROM public.genres
    WHERE lower(name) = 'christian' AND parent_id IS NULL
    LIMIT 1
), worship_source AS (
    SELECT s.id, s.name, s.description
    FROM public.subgenres s
    JOIN christian c ON c.id = s.genre_id
    WHERE lower(s.name) = 'worship'
    LIMIT 1
)
INSERT INTO public.genres (
    name,
    description,
    slug,
    display_order,
    is_home_featured,
    parent_id,
    level,
    sort_order,
    active,
    legacy_subgenre_id
)
SELECT
    ws.name,
    ws.description,
    'worship',
    coalesce(c.display_order, 1),
    true,
    NULL,
    0,
    coalesce(c.display_order, 1),
    true,
    ws.id
FROM worship_source ws
CROSS JOIN christian c
WHERE NOT EXISTS (
    SELECT 1 FROM public.genres g WHERE g.legacy_subgenre_id = ws.id
);

WITH source_rows AS (
    SELECT
        s.*,
        parent.slug AS parent_slug,
        parent.active AS parent_active,
        row_number() OVER (PARTITION BY s.genre_id ORDER BY s.id) AS child_order,
        christian.id AS christian_id,
        worship.id AS worship_id
    FROM public.subgenres s
    JOIN public.genres parent ON parent.id = s.genre_id
    LEFT JOIN public.genres christian
        ON lower(christian.name) = 'christian'
       AND christian.parent_id IS NULL
       AND christian.legacy_subgenre_id IS NULL
    LEFT JOIN public.genres worship
        ON lower(worship.name) = 'worship'
       AND worship.parent_id IS NULL
       AND worship.active = true
    WHERE lower(s.name) <> 'worship'
)
INSERT INTO public.genres (
    name,
    description,
    slug,
    display_order,
    is_home_featured,
    parent_id,
    level,
    sort_order,
    active,
    legacy_subgenre_id
)
SELECT
    s.name,
    s.description,
    CASE
        WHEN s.genre_id = s.christian_id AND lower(s.name) = 'gospel'
            THEN 'worship-gospel'
        ELSE s.parent_slug || '-' || trim(both '-' from regexp_replace(
            lower(translate(s.name, 'áéíóúüñ', 'aeiouun')),
            '[^a-z0-9]+',
            '-',
            'g'
        ))
    END,
    NULL,
    false,
    CASE
        WHEN s.genre_id = s.christian_id AND lower(s.name) = 'gospel'
            THEN s.worship_id
        ELSE s.genre_id
    END,
    1,
    s.child_order,
    CASE
        WHEN s.genre_id = s.christian_id AND lower(s.name) <> 'gospel'
            THEN false
        ELSE s.parent_active
    END,
    s.id
FROM source_rows s
WHERE NOT EXISTS (
    SELECT 1 FROM public.genres g WHERE g.legacy_subgenre_id = s.id
);

UPDATE public.genres
SET active = false, is_home_featured = false
WHERE lower(name) = 'christian'
  AND parent_id IS NULL
  AND legacy_subgenre_id IS NULL;

ALTER TABLE public.recordings DROP CONSTRAINT IF EXISTS recordings_subgenre_id_fkey;

UPDATE public.recordings r
SET subgenre_id = child.id
FROM public.genres child
JOIN public.recordings_genres_backup_before_single_table_taxonomy backup
    ON backup.subgenre_id = child.legacy_subgenre_id
WHERE backup.id = r.id;

WITH taxonomy AS (
    SELECT
        max(id) FILTER (WHERE lower(name) = 'christian' AND parent_id IS NULL AND legacy_subgenre_id IS NULL) AS christian_id,
        max(id) FILTER (WHERE lower(name) = 'worship' AND parent_id IS NULL AND active) AS worship_id,
        max(id) FILTER (WHERE legacy_subgenre_id = 3) AS merengue_orquesta_id,
        max(id) FILTER (WHERE legacy_subgenre_id = 7) AS bachata_tradicional_id,
        max(id) FILTER (WHERE legacy_subgenre_id = 13) AS urban_rap_id,
        max(id) FILTER (WHERE legacy_subgenre_id = 21) AS ballads_latin_pop_id,
        max(id) FILTER (WHERE legacy_subgenre_id = 24) AS worship_gospel_id
    FROM public.genres
), parent_genres AS (
    SELECT
        max(id) FILTER (WHERE lower(name) = 'merengue' AND parent_id IS NULL) AS merengue_id,
        max(id) FILTER (WHERE lower(name) = 'bachata' AND parent_id IS NULL) AS bachata_id,
        max(id) FILTER (WHERE lower(name) = 'urban' AND parent_id IS NULL) AS urban_id,
        max(id) FILTER (WHERE lower(name) = 'ballads' AND parent_id IS NULL) AS ballads_id
    FROM public.genres
)
UPDATE public.recordings r
SET
    recording_context = 'christian',
    genre_id = CASE backup.subgenre_id
        WHEN 25 THEN parents.merengue_id
        WHEN 26 THEN parents.bachata_id
        WHEN 27 THEN parents.urban_id
        WHEN 28 THEN parents.ballads_id
        ELSE taxonomy.worship_id
    END,
    subgenre_id = CASE backup.subgenre_id
        WHEN 24 THEN taxonomy.worship_gospel_id
        WHEN 25 THEN taxonomy.merengue_orquesta_id
        WHEN 26 THEN taxonomy.bachata_tradicional_id
        WHEN 27 THEN taxonomy.urban_rap_id
        WHEN 28 THEN taxonomy.ballads_latin_pop_id
        ELSE NULL
    END
FROM public.recordings_genres_backup_before_single_table_taxonomy backup
CROSS JOIN taxonomy
CROSS JOIN parent_genres parents
WHERE backup.id = r.id
  AND backup.genre_id = taxonomy.christian_id;

ALTER TABLE public.recordings
    ADD CONSTRAINT recordings_subgenre_id_fkey
    FOREIGN KEY (subgenre_id) REFERENCES public.genres(id) ON DELETE RESTRICT;

ALTER TABLE public.genre_import_mapping
    ADD COLUMN IF NOT EXISTS normalized_label text,
    ADD COLUMN IF NOT EXISTS genre_id bigint,
    ADD COLUMN IF NOT EXISTS subgenre_id bigint,
    ADD COLUMN IF NOT EXISTS confidence numeric,
    ADD COLUMN IF NOT EXISTS notes text;

UPDATE public.genre_import_mapping
SET
    normalized_label = lower(trim(source_label)),
    confidence = coalesce(confidence, 1.0);

UPDATE public.genre_import_mapping mapping
SET genre_id = genre.id
FROM public.genres genre
WHERE genre.parent_id IS NULL
  AND genre.active
  AND lower(genre.name) = lower(
      CASE WHEN mapping.genre_name = 'Christian' THEN 'Worship' ELSE mapping.genre_name END
  );

UPDATE public.genre_import_mapping mapping
SET subgenre_id = child.id
FROM public.genres child
WHERE child.parent_id = mapping.genre_id
  AND child.level = 1
  AND child.active
  AND lower(child.name) = lower(mapping.subgenre_name)
  AND mapping.genre_name <> 'Christian';

UPDATE public.genre_import_mapping
SET
    subgenre_id = NULL,
    recording_context = 'christian',
    notes = concat_ws(' ', nullif(notes, ''), 'Christian is represented by recording_context; Worship is the fallback genre.')
WHERE genre_name = 'Christian';

ALTER TABLE public.genre_import_mapping
    ALTER COLUMN normalized_label SET NOT NULL;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'genre_import_mapping_genre_id_fkey'
    ) THEN
        ALTER TABLE public.genre_import_mapping
            ADD CONSTRAINT genre_import_mapping_genre_id_fkey
            FOREIGN KEY (genre_id) REFERENCES public.genres(id) ON DELETE RESTRICT;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'genre_import_mapping_subgenre_id_fkey'
    ) THEN
        ALTER TABLE public.genre_import_mapping
            ADD CONSTRAINT genre_import_mapping_subgenre_id_fkey
            FOREIGN KEY (subgenre_id) REFERENCES public.genres(id) ON DELETE RESTRICT;
    END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_genre_import_mapping_normalized_label
ON public.genre_import_mapping(normalized_label);
CREATE INDEX IF NOT EXISTS idx_genre_import_mapping_genre_id
ON public.genre_import_mapping(genre_id);
CREATE INDEX IF NOT EXISTS idx_genre_import_mapping_subgenre_id
ON public.genre_import_mapping(subgenre_id);

CREATE OR REPLACE FUNCTION public.validate_recording_genre_taxonomy()
RETURNS trigger
LANGUAGE plpgsql
SET search_path = public
AS $$
DECLARE
    main_genre public.genres%ROWTYPE;
    child_genre public.genres%ROWTYPE;
BEGIN
    IF NEW.genre_id IS NULL THEN
        IF NEW.subgenre_id IS NOT NULL THEN
            RAISE EXCEPTION 'subgenre_id requires genre_id';
        END IF;
        RETURN NEW;
    END IF;

    SELECT * INTO main_genre FROM public.genres WHERE id = NEW.genre_id;
    IF NOT FOUND OR main_genre.level <> 0 OR main_genre.parent_id IS NOT NULL OR NOT main_genre.active THEN
        RAISE EXCEPTION 'genre_id % must reference an active level 0 genre', NEW.genre_id;
    END IF;

    IF NEW.subgenre_id IS NOT NULL THEN
        SELECT * INTO child_genre FROM public.genres WHERE id = NEW.subgenre_id;
        IF NOT FOUND OR child_genre.level <> 1 OR NOT child_genre.active THEN
            RAISE EXCEPTION 'subgenre_id % must reference an active level 1 genre', NEW.subgenre_id;
        END IF;
        IF child_genre.parent_id <> NEW.genre_id THEN
            RAISE EXCEPTION 'subgenre_id % does not belong to genre_id %', NEW.subgenre_id, NEW.genre_id;
        END IF;
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS recordings_validate_genre_taxonomy ON public.recordings;
CREATE TRIGGER recordings_validate_genre_taxonomy
BEFORE INSERT OR UPDATE OF genre_id, subgenre_id ON public.recordings
FOR EACH ROW EXECUTE FUNCTION public.validate_recording_genre_taxonomy();

DO $$
DECLARE
    function_definition text;
    view_definition text;
BEGIN
    SELECT pg_get_functiondef(p.oid)
    INTO function_definition
    FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE n.nspname = 'public' AND p.proname = 'get_artist_discography'
    LIMIT 1;

    IF function_definition IS NOT NULL THEN
        function_definition := replace(function_definition, 'public.subgenres sg', 'public.genres sg');
        EXECUTE function_definition;
    END IF;

    SELECT definition
    INTO view_definition
    FROM pg_views
    WHERE schemaname = 'public' AND viewname = 'recordings_with_release_info';

    IF view_definition IS NOT NULL THEN
        view_definition := replace(view_definition, 'LEFT JOIN subgenres sg', 'LEFT JOIN genres sg');
        EXECUTE 'CREATE OR REPLACE VIEW public.recordings_with_release_info AS ' || view_definition;
    END IF;
END $$;

DO $$
DECLARE
    invalid_count bigint;
BEGIN
    SELECT count(*) INTO invalid_count
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

    IF invalid_count > 0 THEN
        RAISE EXCEPTION 'Migration produced % invalid genre/subgenre relationships', invalid_count;
    END IF;

    SELECT count(*) INTO invalid_count
    FROM public.recordings r
    JOIN public.genres g ON g.id = r.genre_id
    WHERE lower(g.name) = 'christian';

    IF invalid_count > 0 THEN
        RAISE EXCEPTION 'Migration left % recordings assigned to Christian as a genre', invalid_count;
    END IF;
END $$;

COMMIT;
