BEGIN;

DO $$
BEGIN
    IF to_regclass('public.credited_works') IS NULL
       AND to_regclass('public.works') IS NOT NULL THEN
        ALTER TABLE public.works RENAME TO credited_works;
    END IF;

    IF to_regclass('public.credited_work_credits') IS NULL
       AND to_regclass('public.work_credits') IS NOT NULL THEN
        ALTER TABLE public.work_credits RENAME TO credited_work_credits;
    END IF;
END $$;

ALTER TABLE IF EXISTS public.credited_works
    ADD COLUMN IF NOT EXISTS performer_name text,
    ADD COLUMN IF NOT EXISTS release_title text,
    ADD COLUMN IF NOT EXISTS release_type text,
    ADD COLUMN IF NOT EXISTS release_year integer,
    ADD COLUMN IF NOT EXISTS category text,
    ADD COLUMN IF NOT EXISTS country text,
    ADD COLUMN IF NOT EXISTS source_url text,
    ADD COLUMN IF NOT EXISTS notes text,
    ADD COLUMN IF NOT EXISTS recording_id uuid,
    ADD COLUMN IF NOT EXISTS release_id uuid;

DO $$
BEGIN
    IF to_regclass('public.credited_works') IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1
            FROM pg_constraint
            WHERE conname = 'credited_works_category_check'
              AND conrelid = 'public.credited_works'::regclass
        ) THEN
            ALTER TABLE public.credited_works
                ADD CONSTRAINT credited_works_category_check
                CHECK (category IS NULL OR category IN ('national', 'international'));
        END IF;

        IF NOT EXISTS (
            SELECT 1
            FROM pg_constraint
            WHERE conname = 'credited_works_release_year_check'
              AND conrelid = 'public.credited_works'::regclass
        ) THEN
            ALTER TABLE public.credited_works
                ADD CONSTRAINT credited_works_release_year_check
                CHECK (release_year IS NULL OR release_year BETWEEN 1850 AND 2100);
        END IF;

        IF NOT EXISTS (
            SELECT 1
            FROM pg_constraint
            WHERE conname = 'credited_works_recording_id_fkey'
              AND conrelid = 'public.credited_works'::regclass
        ) THEN
            ALTER TABLE public.credited_works
                ADD CONSTRAINT credited_works_recording_id_fkey
                FOREIGN KEY (recording_id) REFERENCES public.recordings(id) ON DELETE SET NULL;
        END IF;

        IF NOT EXISTS (
            SELECT 1
            FROM pg_constraint
            WHERE conname = 'credited_works_release_id_fkey'
              AND conrelid = 'public.credited_works'::regclass
        ) THEN
            ALTER TABLE public.credited_works
                ADD CONSTRAINT credited_works_release_id_fkey
                FOREIGN KEY (release_id) REFERENCES public.releases(id) ON DELETE SET NULL;
        END IF;
    END IF;

    IF to_regclass('public.credited_work_credits') IS NOT NULL
       AND to_regclass('public.credited_works') IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1
            FROM pg_constraint
            WHERE conname = 'credited_work_credits_work_id_fkey'
              AND conrelid = 'public.credited_work_credits'::regclass
        ) THEN
            ALTER TABLE public.credited_work_credits
                ADD CONSTRAINT credited_work_credits_work_id_fkey
                FOREIGN KEY (work_id) REFERENCES public.credited_works(id) ON DELETE CASCADE;
        END IF;

        IF NOT EXISTS (
            SELECT 1
            FROM pg_constraint
            WHERE conname = 'credited_work_credits_artist_id_fkey'
              AND conrelid = 'public.credited_work_credits'::regclass
        ) THEN
            ALTER TABLE public.credited_work_credits
                ADD CONSTRAINT credited_work_credits_artist_id_fkey
                FOREIGN KEY (artist_id) REFERENCES public.artists(id) ON DELETE CASCADE;
        END IF;
    END IF;
END $$;

DO $$
BEGIN
    IF to_regclass('public.credited_works') IS NOT NULL THEN
        CREATE INDEX IF NOT EXISTS idx_credited_works_title
        ON public.credited_works (title);

        CREATE INDEX IF NOT EXISTS idx_credited_works_performer_name
        ON public.credited_works (performer_name);

        CREATE INDEX IF NOT EXISTS idx_credited_works_release_title
        ON public.credited_works (release_title);

        CREATE INDEX IF NOT EXISTS idx_credited_works_release_year
        ON public.credited_works (release_year);

        CREATE INDEX IF NOT EXISTS idx_credited_works_category
        ON public.credited_works (category);

        CREATE INDEX IF NOT EXISTS idx_credited_works_recording_id
        ON public.credited_works (recording_id);

        CREATE INDEX IF NOT EXISTS idx_credited_works_release_id
        ON public.credited_works (release_id);
    END IF;

    IF to_regclass('public.credited_work_credits') IS NOT NULL THEN
        CREATE INDEX IF NOT EXISTS idx_credited_work_credits_role
        ON public.credited_work_credits (role);

        CREATE INDEX IF NOT EXISTS idx_credited_work_credits_artist_id
        ON public.credited_work_credits (artist_id);

        CREATE INDEX IF NOT EXISTS idx_credited_work_credits_work_id
        ON public.credited_work_credits (work_id);

        CREATE UNIQUE INDEX IF NOT EXISTS uq_credited_work_credits_work_artist_role
        ON public.credited_work_credits (work_id, artist_id, role);
    END IF;
END $$;

CREATE OR REPLACE FUNCTION public.get_artist_credited_works(p_artist_id uuid)
RETURNS TABLE (
    title text,
    performer_name text,
    release_title text,
    release_type text,
    release_year integer,
    category text,
    country text,
    role text,
    recording_id uuid,
    release_id uuid,
    source_url text,
    notes text
)
LANGUAGE sql
STABLE
SET search_path = public
AS $$
    SELECT
        cw.title,
        cw.performer_name,
        cw.release_title,
        cw.release_type,
        cw.release_year,
        cw.category,
        cw.country,
        cwc.role,
        cw.recording_id,
        cw.release_id,
        cw.source_url,
        cw.notes
    FROM public.credited_work_credits cwc
    JOIN public.credited_works cw ON cw.id = cwc.work_id
    WHERE cwc.artist_id = p_artist_id
    ORDER BY cw.release_year DESC NULLS LAST, cw.title ASC, cwc.role ASC;
$$;

GRANT EXECUTE ON FUNCTION public.get_artist_credited_works(uuid) TO anon, authenticated, service_role;

DO $$
DECLARE
    table_name text;
    table_names text[] := ARRAY['credited_works', 'credited_work_credits'];
BEGIN
    FOREACH table_name IN ARRAY table_names LOOP
        IF to_regclass(format('public.%I', table_name)) IS NOT NULL THEN
            EXECUTE format(
                'DROP POLICY IF EXISTS %I ON public.%I',
                'Allow public read ' || table_name,
                table_name
            );
            EXECUTE format(
                'CREATE POLICY %I ON public.%I FOR SELECT TO anon, authenticated USING (true)',
                'Allow public read ' || table_name,
                table_name
            );

            EXECUTE format(
                'DROP POLICY IF EXISTS %I ON public.%I',
                'Allow service role manage ' || table_name,
                table_name
            );
            EXECUTE format(
                'CREATE POLICY %I ON public.%I FOR ALL TO service_role USING (auth.role() = ''service_role'') WITH CHECK (auth.role() = ''service_role'')',
                'Allow service role manage ' || table_name,
                table_name
            );
        END IF;
    END LOOP;
END $$;

NOTIFY pgrst, 'reload schema';

COMMIT;
