BEGIN;

CREATE SCHEMA IF NOT EXISTS extensions;

DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'unaccent') THEN
        ALTER EXTENSION unaccent SET SCHEMA extensions;
    END IF;
END $$;

DO $$
DECLARE
    function_name text;
    function_names text[] := ARRAY[
        'get_top_christian_artists',
        'slugify',
        'set_artist_slug',
        'get_region_counts',
        'get_top_composers',
        'get_rising_stars',
        'get_artist_profile_page',
        'get_artist_discography',
        'update_updated_at_column',
        'claim_ingest_job',
        'increment_artist_views',
        'get_pending_recordings',
        'get_artist_provinces',
        'global_search',
        'get_artists_by_day_month',
        'get_top_artists'
    ];
    function_identity text;
BEGIN
    FOREACH function_name IN ARRAY function_names LOOP
        FOR function_identity IN
            SELECT p.oid::regprocedure::text
            FROM pg_proc p
            JOIN pg_namespace n ON n.oid = p.pronamespace
            WHERE n.nspname = 'public'
              AND p.proname = function_name
        LOOP
            EXECUTE format('ALTER FUNCTION %s SET search_path = public, extensions', function_identity);
        END LOOP;
    END LOOP;
END $$;

DO $$
DECLARE
    view_name text;
    view_names text[] := ARRAY[
        'trending_recordings_mv',
        'mv_recording_views_7d',
        'mv_recording_views_30d',
        'mv_artist_views_7d',
        'mv_artist_views_30d'
    ];
BEGIN
    FOREACH view_name IN ARRAY view_names LOOP
        IF to_regclass(format('public.%I', view_name)) IS NOT NULL THEN
            EXECUTE format('REVOKE SELECT ON TABLE public.%I FROM anon, authenticated', view_name);
            EXECUTE format('GRANT SELECT ON TABLE public.%I TO service_role', view_name);
        END IF;
    END LOOP;
END $$;

DROP POLICY IF EXISTS "Allow insert artists" ON public.artists;
CREATE POLICY "Allow authenticated insert artists"
ON public.artists
FOR INSERT
TO authenticated
WITH CHECK (auth.role() = 'authenticated');

DROP POLICY IF EXISTS "Enable insert/update for all users" ON public.featured_artist;
CREATE POLICY "Allow public read featured artist"
ON public.featured_artist
FOR SELECT
TO anon, authenticated
USING (true);

CREATE POLICY "Allow authenticated write featured artist"
ON public.featured_artist
FOR ALL
TO authenticated
USING (auth.role() = 'authenticated')
WITH CHECK (auth.role() = 'authenticated');

DROP POLICY IF EXISTS "Allow authenticated users to read artist images" ON storage.objects;
DROP POLICY IF EXISTS "Allow public read artist images" ON storage.objects;
DROP POLICY IF EXISTS "Public can read contributor images" ON storage.objects;

DO $$
DECLARE
    function_identity text;
BEGIN
    FOR function_identity IN
        SELECT p.oid::regprocedure::text
        FROM pg_proc p
        JOIN pg_namespace n ON n.oid = p.pronamespace
        WHERE n.nspname = 'public'
          AND p.proname IN ('increment_artist_views', 'ai_update_recording_genre')
          AND p.prosecdef
    LOOP
        EXECUTE format('REVOKE ALL ON FUNCTION %s FROM PUBLIC, anon, authenticated', function_identity);
        EXECUTE format('GRANT EXECUTE ON FUNCTION %s TO service_role', function_identity);
    END LOOP;
END $$;

NOTIFY pgrst, 'reload schema';

COMMIT;
