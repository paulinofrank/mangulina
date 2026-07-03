BEGIN;

DROP TABLE IF EXISTS
    public.genre_import_mapping_backup_before_taxonomy_change,
    public.genres_backup_before_taxonomy_change,
    public.recordings_backup_after_ai_classification,
    public.recordings_genres_backup_before_taxonomy_change,
    public.subgenres_backup_before_taxonomy_change;

DO $$
DECLARE
    table_name text;
    public_read_tables text[] := ARRAY[
        'artist_awards',
        'artist_genre_map',
        'artist_media',
        'artist_occupations',
        'artist_relationships',
        'award_categories',
        'awards',
        'cultural_notes',
        'expressions',
        'genres',
        'locations',
        'lyrics',
        'occupations',
        'recording_credits',
        'recording_editorial',
        'recording_expressions',
        'recording_fun_facts',
        'recording_locations',
        'recording_media',
        'recording_platform_links',
        'recording_relationships',
        'recording_sources',
        'sources',
        'sponsors',
        'translations',
        'credited_work_credits'
    ];
    service_only_tables text[] := ARRAY[
        'admin_invites',
        'admin_members',
        'analytics_rollup_status',
        'apple_recording_candidates',
        'artist_view_events',
        'cover_art_ingest_log',
        'genre_import_mapping',
        'genre_view_events',
        'imported_reference_table',
        'odesli_batch_progress',
        'page_view_events',
        'platform_click_events',
        'recording_classification_review',
        'recording_view_events',
        'release_view_events',
        'search_events',
        'wikidata_raw'
    ];
BEGIN
    FOREACH table_name IN ARRAY public_read_tables LOOP
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

    FOREACH table_name IN ARRAY service_only_tables LOOP
        IF to_regclass(format('public.%I', table_name)) IS NOT NULL THEN
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
