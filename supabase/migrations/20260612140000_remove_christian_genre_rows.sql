BEGIN;

CREATE TABLE IF NOT EXISTS public.genres_backup_before_christian_cleanup AS
SELECT * FROM public.genres;

CREATE TABLE IF NOT EXISTS public.recordings_genres_backup_before_christian_cleanup AS
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

CREATE TABLE IF NOT EXISTS public.genre_import_mapping_backup_before_christian_cleanup AS
SELECT * FROM public.genre_import_mapping;

CREATE TEMP TABLE christian_taxonomy_rows ON COMMIT DROP AS
SELECT id, name, slug, parent_id, level
FROM public.genres
WHERE
    lower(coalesce(name, '')) IN (
        'christian',
        'christian music',
        'música cristiana',
        'musica cristiana',
        'christian merengue',
        'christian bachata',
        'christian rap',
        'christian hip hop',
        'christian hip-hop',
        'christian pop'
    )
    OR lower(coalesce(slug, '')) IN (
        'christian',
        'christian-music',
        'musica-cristiana',
        'christian-merengue',
        'christian-bachata',
        'christian-rap',
        'christian-hip-hop',
        'christian-pop',
        'christian-christian-merengue',
        'christian-christian-bachata',
        'christian-christian-rap',
        'christian-christian-pop'
    );

DO $$
DECLARE
    merengue_id bigint;
    merengue_child_id bigint;
    bachata_id bigint;
    bachata_child_id bigint;
    urban_id bigint;
    rap_child_id bigint;
    pop_id bigint;
    ballads_id bigint;
    pop_child_id bigint;
    worship_id bigint;
BEGIN
    SELECT id INTO merengue_id
    FROM public.genres
    WHERE level = 0 AND active AND lower(name) = 'merengue'
    LIMIT 1;

    SELECT id INTO merengue_child_id
    FROM public.genres
    WHERE parent_id = merengue_id AND level = 1 AND active
      AND lower(name) IN ('orquesta', 'tradicional', 'perico ripiao')
    ORDER BY CASE lower(name) WHEN 'orquesta' THEN 1 WHEN 'tradicional' THEN 2 ELSE 3 END
    LIMIT 1;

    SELECT id INTO bachata_id
    FROM public.genres
    WHERE level = 0 AND active AND lower(name) = 'bachata'
    LIMIT 1;

    SELECT id INTO bachata_child_id
    FROM public.genres
    WHERE parent_id = bachata_id AND level = 1 AND active
      AND lower(name) IN ('tradicional', 'moderna')
    ORDER BY CASE lower(name) WHEN 'tradicional' THEN 1 ELSE 2 END
    LIMIT 1;

    SELECT id INTO urban_id
    FROM public.genres
    WHERE level = 0 AND active AND lower(name) IN ('urban', 'urbano')
    ORDER BY CASE lower(name) WHEN 'urban' THEN 1 ELSE 2 END
    LIMIT 1;

    SELECT id INTO rap_child_id
    FROM public.genres
    WHERE parent_id = urban_id AND level = 1 AND active
      AND lower(name) IN ('rap', 'hip hop', 'hip-hop', 'rap / hip hop')
    ORDER BY CASE lower(name) WHEN 'rap / hip hop' THEN 1 WHEN 'rap' THEN 2 ELSE 3 END
    LIMIT 1;

    SELECT id INTO pop_id
    FROM public.genres
    WHERE level = 0 AND active AND lower(name) = 'pop'
    LIMIT 1;

    SELECT id INTO ballads_id
    FROM public.genres
    WHERE level = 0 AND active AND lower(name) IN ('ballad', 'ballads')
    ORDER BY CASE lower(name) WHEN 'ballads' THEN 1 ELSE 2 END
    LIMIT 1;

    SELECT id INTO pop_child_id
    FROM public.genres
    WHERE parent_id = coalesce(pop_id, ballads_id) AND level = 1 AND active
      AND lower(name) IN ('latin pop', 'pop')
    ORDER BY CASE lower(name) WHEN 'latin pop' THEN 1 ELSE 2 END
    LIMIT 1;

    SELECT id INTO worship_id
    FROM public.genres
    WHERE level = 0 AND active AND lower(name) = 'worship'
    LIMIT 1;

    IF merengue_id IS NULL OR bachata_id IS NULL OR urban_id IS NULL
       OR coalesce(pop_id, ballads_id) IS NULL OR worship_id IS NULL THEN
        RAISE EXCEPTION 'Required musical fallback genres are missing';
    END IF;

    UPDATE public.recordings r
    SET recording_context = 'christian',
        genre_id = merengue_id,
        subgenre_id = merengue_child_id
    FROM christian_taxonomy_rows old
    WHERE (r.genre_id = old.id OR r.subgenre_id = old.id)
      AND lower(old.name) = 'christian merengue';

    UPDATE public.recordings r
    SET recording_context = 'christian',
        genre_id = bachata_id,
        subgenre_id = bachata_child_id
    FROM christian_taxonomy_rows old
    WHERE (r.genre_id = old.id OR r.subgenre_id = old.id)
      AND lower(old.name) = 'christian bachata';

    UPDATE public.recordings r
    SET recording_context = 'christian',
        genre_id = urban_id,
        subgenre_id = rap_child_id
    FROM christian_taxonomy_rows old
    WHERE (r.genre_id = old.id OR r.subgenre_id = old.id)
      AND lower(old.name) IN ('christian rap', 'christian hip hop', 'christian hip-hop');

    UPDATE public.recordings r
    SET recording_context = 'christian',
        genre_id = coalesce(pop_id, ballads_id),
        subgenre_id = pop_child_id
    FROM christian_taxonomy_rows old
    WHERE (r.genre_id = old.id OR r.subgenre_id = old.id)
      AND lower(old.name) = 'christian pop';

    UPDATE public.recordings r
    SET recording_context = 'christian',
        genre_id = worship_id,
        subgenre_id = NULL
    FROM christian_taxonomy_rows old
    WHERE (r.genre_id = old.id OR r.subgenre_id = old.id)
      AND lower(old.name) IN (
          'christian',
          'christian music',
          'música cristiana',
          'musica cristiana'
      );
END $$;

UPDATE public.genre_import_mapping mapping
SET
    recording_context = 'christian',
    genre_name = (
        SELECT genre.name FROM public.genres genre WHERE genre.id = mapping.genre_id
    ),
    subgenre_name = (
        SELECT child.name FROM public.genres child WHERE child.id = mapping.subgenre_id
    ),
    notes = trim(concat_ws(
        ' ',
        nullif(mapping.notes, ''),
        'Christian meaning is stored only in recording_context.'
    ))
WHERE mapping.genre_id IS NOT NULL
  AND (
      lower(mapping.source_label) LIKE '%christian%'
      OR lower(mapping.source_label) LIKE '%cristian%'
      OR lower(mapping.source_label) LIKE '%worship%'
      OR lower(mapping.source_label) LIKE '%gospel%'
  );

DELETE FROM public.genres
WHERE id IN (SELECT id FROM christian_taxonomy_rows WHERE level = 1);

DELETE FROM public.genres
WHERE id IN (SELECT id FROM christian_taxonomy_rows WHERE level = 0);

DO $$
DECLARE
    invalid_count bigint;
BEGIN
    SELECT count(*) INTO invalid_count
    FROM public.genres
    WHERE
        lower(coalesce(name, '')) IN (
            'christian', 'christian music', 'música cristiana', 'musica cristiana',
            'christian merengue', 'christian bachata', 'christian rap',
            'christian hip hop', 'christian hip-hop', 'christian pop'
        )
        OR lower(coalesce(slug, '')) LIKE 'christian%'
        OR lower(coalesce(slug, '')) LIKE '%-christian-%';

    IF invalid_count > 0 THEN
        RAISE EXCEPTION 'Christian taxonomy cleanup left % prohibited genre rows', invalid_count;
    END IF;

    SELECT count(*) INTO invalid_count
    FROM public.recordings r
    LEFT JOIN public.genres genre ON genre.id = r.genre_id
    LEFT JOIN public.genres child ON child.id = r.subgenre_id
    WHERE
        (r.genre_id IS NOT NULL AND genre.id IS NULL)
        OR (r.subgenre_id IS NOT NULL AND child.id IS NULL)
        OR (r.genre_id IS NOT NULL AND (genre.level <> 0 OR genre.parent_id IS NOT NULL))
        OR (r.subgenre_id IS NOT NULL AND (
            child.level <> 1 OR child.parent_id IS DISTINCT FROM r.genre_id
        ));

    IF invalid_count > 0 THEN
        RAISE EXCEPTION 'Christian taxonomy cleanup produced % invalid recording classifications', invalid_count;
    END IF;

    SELECT count(*) INTO invalid_count
    FROM public.genre_import_mapping
    WHERE lower(coalesce(genre_name, '')) LIKE '%christian%'
       OR lower(coalesce(genre_name, '')) LIKE '%cristian%'
       OR lower(coalesce(subgenre_name, '')) LIKE '%christian%'
       OR lower(coalesce(subgenre_name, '')) LIKE '%cristian%';

    IF invalid_count > 0 THEN
        RAISE EXCEPTION 'Christian taxonomy cleanup left % mapping targets with Christian names', invalid_count;
    END IF;
END $$;

COMMIT;
