-- Rollback migration: 20260923040000_optimize_song_catalog_queries.sql
--
-- This script removes the optimization indexes added for song catalog queries.
-- Use only if performance regression or index issues are detected.
--
-- Note: Removing these indexes will cause the /songs directory page to timeout again.

BEGIN;

-- Drop indexes in reverse order of creation
DROP INDEX CONCURRENTLY IF EXISTS idx_releases_year_artist;
DROP INDEX CONCURRENTLY IF EXISTS idx_tracks_recording_release;
DROP INDEX CONCURRENTLY IF EXISTS idx_recordings_artist_year;
DROP INDEX CONCURRENTLY IF EXISTS idx_recordings_work_year;

-- Update table statistics
ANALYZE recordings;
ANALYZE tracks;
ANALYZE releases;
ANALYZE works;

COMMIT;

-- Note: This rollback is low-risk as it only removes indexes.
-- No data is deleted or modified.
