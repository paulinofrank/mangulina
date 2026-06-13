BEGIN;

SELECT pg_advisory_xact_lock(hashtext('mangulina-drop-cover-image-url-20260613'));

CREATE TABLE IF NOT EXISTS public.releases_cover_image_url_backup_before_drop AS
SELECT id, slug, title, cover_image_url AS legacy_cover_url
FROM public.releases;

DO $$
DECLARE
    source_count integer;
    backup_count integer;
BEGIN
    SELECT count(*) INTO source_count FROM public.releases;
    SELECT count(*) INTO backup_count FROM public.releases_cover_image_url_backup_before_drop;

    IF source_count <> backup_count THEN
        RAISE EXCEPTION 'Release cover backup mismatch: source %, backup %', source_count, backup_count;
    END IF;
END $$;

DROP VIEW public.artist_discography_view;
DROP VIEW public.recordings_with_release_info;

ALTER TABLE public.releases DROP COLUMN cover_image_url;

CREATE VIEW public.recordings_with_release_info AS
SELECT
    r.id AS recording_id,
    r.title AS recording_title,
    CASE
        WHEN (r.metadata ->> 'first-release-date') ~ '^\d{4}$'
            THEN ((r.metadata ->> 'first-release-date')::integer)::numeric
        WHEN (r.metadata ->> 'first-release-date') ~ '^\d{4}-\d{2}$'
            THEN EXTRACT(year FROM ((r.metadata ->> 'first-release-date') || '-01')::date)
        WHEN (r.metadata ->> 'first-release-date') ~ '^\d{4}-\d{2}-\d{2}$'
            THEN EXTRACT(year FROM (r.metadata ->> 'first-release-date')::date)
        ELSE NULL::numeric
    END AS recording_year,
    CASE
        WHEN (r.metadata ->> 'first-release-date') ~ '^\d{4}$'
            THEN ((r.metadata ->> 'first-release-date')::integer)::numeric
        WHEN (r.metadata ->> 'first-release-date') ~ '^\d{4}-\d{2}$'
            THEN EXTRACT(year FROM ((r.metadata ->> 'first-release-date') || '-01')::date)
        WHEN (r.metadata ->> 'first-release-date') ~ '^\d{4}-\d{2}-\d{2}$'
            THEN EXTRACT(year FROM (r.metadata ->> 'first-release-date')::date)
        ELSE NULL::numeric
    END AS year,
    r.youtube_id,
    r.duration,
    r.views,
    r.mbid,
    r.disambiguation,
    r.isrcs,
    r.metadata AS recording_metadata,
    a.id AS artist_id,
    a.name AS artist_name,
    g.id AS genre_id,
    g.name AS genre_name,
    sg.id AS subgenre_id,
    sg.name AS subgenre_name,
    rl.id AS release_id,
    rl.title AS release_title,
    rl.release_year AS release_year_actual,
    rl.label,
    rl.label_id,
    rl.country,
    rl.catalog_number,
    rl.barcode,
    rl.packaging,
    rl.status,
    rl.date,
    rl.metadata AS release_metadata
FROM public.recordings r
LEFT JOIN public.releases rl ON rl.id = r.release_id
LEFT JOIN public.artists a ON a.id = rl.release_artist_id
LEFT JOIN public.genres g ON g.id = r.genre_id
LEFT JOIN public.genres sg ON sg.id = r.subgenre_id;

CREATE VIEW public.artist_discography_view
WITH (security_invoker = true) AS
SELECT
    a.id AS artist_id,
    a.name AS artist_name,
    rel.id AS release_id,
    rel.title AS release_title,
    rel.release_year,
    rel.type AS release_type,
    rel.country AS release_country,
    rel.date AS release_date,
    t.id AS track_id,
    t.disc_number,
    t.track_number,
    COALESCE(t.title_override, r.title) AS track_title,
    t.length AS track_length,
    r.id AS recording_id,
    r.title AS recording_title,
    r.recording_year,
    r.youtube_id,
    r.duration AS recording_duration,
    r.views AS recording_views
FROM public.artists a
JOIN public.releases rel ON rel.release_artist_id = a.id
JOIN public.tracks t ON t.release_id = rel.id
JOIN public.recordings r ON r.id = t.recording_id
ORDER BY a.name, rel.release_year, rel.title, t.disc_number, t.track_number;

ALTER VIEW public.recordings_with_release_info OWNER TO postgres;
ALTER VIEW public.artist_discography_view OWNER TO postgres;

GRANT ALL ON public.recordings_with_release_info TO anon, authenticated, service_role;
GRANT ALL ON public.artist_discography_view TO anon, authenticated, service_role;

DO $$
DECLARE
    remaining_columns integer;
    release_rows integer;
    backup_rows integer;
    recording_rows integer;
    recording_view_rows integer;
BEGIN
    SELECT count(*) INTO remaining_columns
    FROM information_schema.columns
    WHERE column_name = 'cover_image_url';

    IF remaining_columns <> 0 THEN
        RAISE EXCEPTION 'cover_image_url still exists in % schema objects', remaining_columns;
    END IF;

    SELECT count(*) INTO release_rows FROM public.releases;
    SELECT count(*) INTO backup_rows FROM public.releases_cover_image_url_backup_before_drop;
    IF release_rows <> backup_rows THEN
        RAISE EXCEPTION 'Release row count does not match backup: releases %, backup %', release_rows, backup_rows;
    END IF;

    SELECT count(*) INTO recording_rows FROM public.recordings;
    SELECT count(*) INTO recording_view_rows FROM public.recordings_with_release_info;
    IF recording_view_rows <> recording_rows THEN
        RAISE EXCEPTION 'Recording view row count mismatch: recordings %, view %', recording_rows, recording_view_rows;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_class c
        WHERE c.oid = 'public.artist_discography_view'::regclass
          AND c.reloptions @> ARRAY['security_invoker=true']
    ) THEN
        RAISE EXCEPTION 'artist_discography_view lost security_invoker=true';
    END IF;
END $$;

COMMIT;
