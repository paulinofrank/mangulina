-- Apply separately only after reviewing the final taxonomy validation reports.
BEGIN;

SELECT pg_advisory_xact_lock(hashtext('mangulina-drop-legacy-subgenres'));

CREATE TABLE IF NOT EXISTS public.subgenres_backup_before_drop AS
SELECT * FROM public.subgenres;

DO $$
DECLARE
    actual integer;
    dependency record;
BEGIN
    IF to_regclass('public.subgenres') IS NULL THEN
        RAISE EXCEPTION 'public.subgenres does not exist';
    END IF;

    -- Two legacy rows intentionally have no canonical genres row:
    -- id 40 (Fusion/Jazz) was consolidated into top-level Jazz id 36, and
    -- id 16 (Urban/Fusion) was removed from the approved taxonomy.
    SELECT count(*) INTO actual
    FROM public.subgenres s
    LEFT JOIN public.genres g ON g.legacy_subgenre_id = s.id
    WHERE g.id IS NULL
      AND NOT (s.id = 40 AND lower(s.name) = 'jazz' AND EXISTS (
          SELECT 1 FROM public.genres canonical
          WHERE canonical.id = 36 AND canonical.name = 'Jazz'
            AND canonical.level = 0 AND canonical.parent_id IS NULL AND canonical.active
      ))
      AND NOT (s.id = 16 AND lower(s.name) = 'fusion' AND s.genre_id = 10 AND NOT EXISTS (
          SELECT 1 FROM public.genres removed WHERE removed.slug = 'urban-fusion'
      ));
    IF actual <> 0 THEN
        RAISE EXCEPTION '% legacy subgenres lack a canonical genres row', actual;
    END IF;

    SELECT count(*) INTO actual
    FROM public.recordings r
    LEFT JOIN public.genres g ON g.id = r.genre_id
    LEFT JOIN public.genres sg ON sg.id = r.subgenre_id
    WHERE (r.genre_id IS NOT NULL AND (g.id IS NULL OR g.level <> 0 OR g.parent_id IS NOT NULL OR NOT g.active))
       OR (r.subgenre_id IS NOT NULL AND (sg.id IS NULL OR sg.level <> 1 OR sg.parent_id IS DISTINCT FROM r.genre_id OR NOT sg.active));
    IF actual <> 0 THEN
        RAISE EXCEPTION '% recordings have invalid genres relationships', actual;
    END IF;

    SELECT count(*) INTO actual
    FROM public.genre_import_mapping m
    LEFT JOIN public.genres g ON g.id = m.genre_id
    LEFT JOIN public.genres sg ON sg.id = m.subgenre_id
    WHERE (m.genre_id IS NOT NULL AND (g.id IS NULL OR g.level <> 0 OR g.parent_id IS NOT NULL OR NOT g.active))
       OR (m.subgenre_id IS NOT NULL AND (sg.id IS NULL OR sg.level <> 1 OR sg.parent_id IS DISTINCT FROM m.genre_id OR NOT sg.active));
    IF actual <> 0 THEN
        RAISE EXCEPTION '% genre mappings have invalid genres relationships', actual;
    END IF;

    SELECT count(*) INTO actual
    FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE n.nspname = 'public' AND p.prokind IN ('f', 'p')
      AND pg_get_functiondef(p.oid) ILIKE '%subgenres%';
    IF actual <> 0 THEN
        RAISE EXCEPTION '% public functions still reference subgenres', actual;
    END IF;

    SELECT count(*) INTO actual
    FROM pg_views
    WHERE schemaname = 'public' AND definition ILIKE '%subgenres%';
    IF actual <> 0 THEN
        RAISE EXCEPTION '% public views still reference subgenres', actual;
    END IF;

    FOR dependency IN
        SELECT conrelid::regclass AS table_name, conname
        FROM pg_constraint
        WHERE contype = 'f' AND confrelid = 'public.subgenres'::regclass
    LOOP
        EXECUTE format('ALTER TABLE %s DROP CONSTRAINT %I', dependency.table_name, dependency.conname);
    END LOOP;
END $$;

DROP TABLE public.subgenres;

DO $$
BEGIN
    IF to_regclass('public.subgenres') IS NOT NULL THEN
        RAISE EXCEPTION 'public.subgenres still exists after DROP TABLE';
    END IF;
END $$;

COMMIT;
