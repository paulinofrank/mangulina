-- Validation script for migration: 20260923040000_optimize_song_catalog_queries.sql
--
-- This script verifies that all optimization indexes were created successfully
-- and are performing as expected.

-- Check 1: All 4 indexes exist
SELECT
  COUNT(*) as indexes_found,
  CASE WHEN COUNT(*) = 4 THEN '✓ PASS' ELSE '✗ FAIL' END as status
FROM pg_indexes
WHERE tablename IN ('recordings', 'tracks', 'releases')
  AND indexname IN (
    'idx_recordings_work_year',
    'idx_recordings_artist_year',
    'idx_tracks_recording_release',
    'idx_releases_year_artist'
  );

-- Check 2: Detailed index information
SELECT
  indexname,
  tablename,
  indexdef
FROM pg_indexes
WHERE indexname IN (
  'idx_recordings_work_year',
  'idx_recordings_artist_year',
  'idx_tracks_recording_release',
  'idx_releases_year_artist'
)
ORDER BY indexname;

-- Check 3: Index size
SELECT
  indexname,
  pg_size_pretty(pg_relation_size(indexrelid)) as index_size
FROM pg_stat_user_indexes
WHERE indexname IN (
  'idx_recordings_work_year',
  'idx_recordings_artist_year',
  'idx_tracks_recording_release',
  'idx_releases_year_artist'
)
ORDER BY pg_relation_size(indexrelid) DESC;

-- Check 4: Performance test - query that was timing out
-- Should execute in <10ms (was >5000ms before optimization)
EXPLAIN ANALYZE
SELECT COUNT(DISTINCT w.id) as unique_works
FROM works w
LEFT JOIN recordings r ON w.id = r.work_id
WHERE w.status = 'published' AND r.work_id IS NOT NULL;

-- Check 5: Artist discography performance
-- Should use idx_recordings_artist_year index
EXPLAIN ANALYZE
SELECT COUNT(DISTINCT r.id)
FROM recordings r
WHERE r.artist_id IS NOT NULL
ORDER BY r.recording_year DESC NULLS LAST
LIMIT 50;

-- Check 6: Track-to-recording performance
-- Should use idx_tracks_recording_release index
EXPLAIN ANALYZE
SELECT COUNT(DISTINCT t.recording_id)
FROM tracks t
WHERE t.recording_id IS NOT NULL
ORDER BY t.release_id;

-- Summary: All indexes should be visible in execution plans
-- and queries should complete in <50ms (average <10ms)
