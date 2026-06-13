-- Expected: zero rows.
SELECT table_schema, table_name, data_type
FROM information_schema.columns
WHERE column_name = 'cover_image_url';

-- Backup coverage.
SELECT
    (SELECT count(*) FROM public.releases) AS releases,
    (SELECT count(*) FROM public.releases_cover_image_url_backup_before_drop) AS backed_up_releases,
    (SELECT count(*) FROM public.releases_cover_image_url_backup_before_drop WHERE legacy_cover_url IS NOT NULL) AS backed_up_urls;

-- View row-count integrity.
SELECT
    (SELECT count(*) FROM public.recordings) AS recordings,
    (SELECT count(*) FROM public.recordings_with_release_info) AS recording_view_rows,
    (SELECT count(*) FROM public.artist_discography_view) AS discography_view_rows;

-- Expected: zero rows.
SELECT schemaname, viewname
FROM pg_views
WHERE definition ILIKE '%cover_image_url%';
