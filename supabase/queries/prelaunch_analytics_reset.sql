-- Mangulina pre-launch analytics reset
--
-- DESTRUCTIVE: permanently deletes all analytics history and resets the three
-- RPC-maintained entity counters. This is an operational maintenance script,
-- not a migration. Execute the whole file intentionally against the confirmed
-- Mangulina production database only.
--
-- Safety properties:
--   * no CASCADE, schema drops, table drops, or catalog-row deletion
--   * no sequence reset
--   * no cron changes
--   * updated_at triggers are disabled only inside the transaction and restored
--   * materialized views and analytics_rollup_status refresh atomically
--   * any error rolls back deletes, counters, trigger states, and refreshes

BEGIN;

-- Replace this value immediately before intentional execution. The checked-in
-- placeholder makes accidental execution fail before locks or mutations.
SET LOCAL app.confirm_analytics_reset = 'REPLACE_WITH_MANGULINA_PRELAUNCH_RESET';

DO $guard$
BEGIN
  IF current_setting('app.confirm_analytics_reset', true)
       IS DISTINCT FROM 'MANGULINA_PRELAUNCH_RESET' THEN
    RAISE EXCEPTION 'Analytics reset confirmation value is missing';
  END IF;
END
$guard$;

SET LOCAL lock_timeout = '30s';
SET LOCAL statement_timeout = '120s';

-- Identity and pre-reset snapshot.
SELECT current_database() AS database_name,
       current_user AS database_user,
       current_setting('TimeZone') AS timezone,
       now() AS captured_at;

SELECT 'artist_view_events' AS object_name, count(*) AS row_count FROM public.artist_view_events
UNION ALL SELECT 'recording_view_events', count(*) FROM public.recording_view_events
UNION ALL SELECT 'release_view_events', count(*) FROM public.release_view_events
UNION ALL SELECT 'genre_view_events', count(*) FROM public.genre_view_events
UNION ALL SELECT 'search_events', count(*) FROM public.search_events
UNION ALL SELECT 'platform_click_events', count(*) FROM public.platform_click_events
UNION ALL SELECT 'page_view_events', count(*) FROM public.page_view_events
ORDER BY object_name;

SELECT 'artists' AS object_name,
       count(*) FILTER (WHERE views IS DISTINCT FROM 0) AS nonzero_entities,
       coalesce(sum(views), 0) AS total_views
FROM public.artists
UNION ALL
SELECT 'recordings', count(*) FILTER (WHERE views IS DISTINCT FROM 0), coalesce(sum(views), 0)
FROM public.recordings
UNION ALL
SELECT 'releases', count(*) FILTER (WHERE views IS DISTINCT FROM 0), coalesce(sum(views), 0)
FROM public.releases
ORDER BY object_name;

SELECT jobid, jobname, schedule, command, active, database, username
FROM cron.job
WHERE jobname ILIKE '%analytics%'
   OR command ILIKE '%analytics%'
   OR command ILIKE '%rollup%'
ORDER BY jobid;

-- Block analytics inserts and catalog counter changes for the short reset.
LOCK TABLE
  public.artist_view_events,
  public.recording_view_events,
  public.release_view_events,
  public.genre_view_events,
  public.search_events,
  public.platform_click_events,
  public.page_view_events,
  public.artists,
  public.recordings,
  public.releases
IN ACCESS EXCLUSIVE MODE;

-- Preserve catalog/editorial modification timestamps during counter reset.
ALTER TABLE public.artists DISABLE TRIGGER trg_artists_updated_at;
ALTER TABLE public.recordings DISABLE TRIGGER trg_recordings_updated_at;
ALTER TABLE public.releases DISABLE TRIGGER trg_releases_updated_at;

-- Targeted analytics source deletion.
DELETE FROM public.artist_view_events;
DELETE FROM public.recording_view_events;
DELETE FROM public.release_view_events;
DELETE FROM public.genre_view_events;
DELETE FROM public.search_events;
DELETE FROM public.platform_click_events;
DELETE FROM public.page_view_events;

-- Targeted counters maintained by record_*_view RPCs.
UPDATE public.artists SET views = 0 WHERE views IS DISTINCT FROM 0;
UPDATE public.recordings SET views = 0 WHERE views IS DISTINCT FROM 0;
UPDATE public.releases SET views = 0 WHERE views IS DISTINCT FROM 0;

ALTER TABLE public.artists ENABLE TRIGGER trg_artists_updated_at;
ALTER TABLE public.recordings ENABLE TRIGGER trg_recordings_updated_at;
ALTER TABLE public.releases ENABLE TRIGGER trg_releases_updated_at;

-- Refreshes all four analytics materialized views and rollup status. The cron
-- job and its schedule remain unchanged.
SELECT public.refresh_analytics_rollups();

-- Abort and roll back everything unless the transactional state is clean.
DO $verify$
DECLARE
  remaining bigint;
BEGIN
  SELECT
      (SELECT count(*) FROM public.artist_view_events)
    + (SELECT count(*) FROM public.recording_view_events)
    + (SELECT count(*) FROM public.release_view_events)
    + (SELECT count(*) FROM public.genre_view_events)
    + (SELECT count(*) FROM public.search_events)
    + (SELECT count(*) FROM public.platform_click_events)
    + (SELECT count(*) FROM public.page_view_events)
    + (SELECT count(*) FROM public.artists WHERE views IS DISTINCT FROM 0)
    + (SELECT count(*) FROM public.recordings WHERE views IS DISTINCT FROM 0)
    + (SELECT count(*) FROM public.releases WHERE views IS DISTINCT FROM 0)
    + (SELECT count(*) FROM public.mv_artist_views_7d)
    + (SELECT count(*) FROM public.mv_artist_views_30d)
    + (SELECT count(*) FROM public.mv_recording_views_7d)
    + (SELECT count(*) FROM public.mv_recording_views_30d)
  INTO remaining;

  IF remaining <> 0 THEN
    RAISE EXCEPTION 'Analytics reset verification failed: % rows remain', remaining;
  END IF;
END
$verify$;

COMMIT;

-- Post-reset evidence.
SELECT 'artist_view_events' AS object_name, count(*) AS row_count FROM public.artist_view_events
UNION ALL SELECT 'recording_view_events', count(*) FROM public.recording_view_events
UNION ALL SELECT 'release_view_events', count(*) FROM public.release_view_events
UNION ALL SELECT 'genre_view_events', count(*) FROM public.genre_view_events
UNION ALL SELECT 'search_events', count(*) FROM public.search_events
UNION ALL SELECT 'platform_click_events', count(*) FROM public.platform_click_events
UNION ALL SELECT 'page_view_events', count(*) FROM public.page_view_events
UNION ALL SELECT 'mv_artist_views_7d', count(*) FROM public.mv_artist_views_7d
UNION ALL SELECT 'mv_artist_views_30d', count(*) FROM public.mv_artist_views_30d
UNION ALL SELECT 'mv_recording_views_7d', count(*) FROM public.mv_recording_views_7d
UNION ALL SELECT 'mv_recording_views_30d', count(*) FROM public.mv_recording_views_30d
ORDER BY object_name;

SELECT 'artists' AS object_name,
       count(*) FILTER (WHERE views IS DISTINCT FROM 0) AS nonzero_entities,
       coalesce(sum(views), 0) AS total_views
FROM public.artists
UNION ALL
SELECT 'recordings', count(*) FILTER (WHERE views IS DISTINCT FROM 0), coalesce(sum(views), 0)
FROM public.recordings
UNION ALL
SELECT 'releases', count(*) FILTER (WHERE views IS DISTINCT FROM 0), coalesce(sum(views), 0)
FROM public.releases
ORDER BY object_name;

SELECT public.analytics_health();
SELECT public.analytics_event_activity();

SELECT jobid, jobname, schedule, command, active, database, username
FROM cron.job
WHERE jobname ILIKE '%analytics%'
   OR command ILIKE '%analytics%'
   OR command ILIKE '%rollup%'
ORDER BY jobid;
