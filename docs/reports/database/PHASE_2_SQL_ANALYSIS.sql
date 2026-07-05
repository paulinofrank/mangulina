-- ============================================================================
-- HISTORICAL REPORT: PHASE 2 SQL Analysis Queries for Credit Model
-- ============================================================================
-- Status: Historical Snapshot (2026-07-03)
-- Purpose: Analysis queries for Phase 2 credit model review.
--
-- Current Source of Truth:
-- - docs/ARCHITECTURAL_DECISIONS.md
-- - docs/DATABASE_SCHEMA.md (when available)
--
-- Note: These queries document the state as of 2026-07-03 and may not
-- reflect current schema if changes have been made since then.
-- ============================================================================
--
-- PHASE 2: SQL Analysis Queries for Credit Model
-- ============================================================================
-- Run these read-only queries to understand current data state before refactoring.
-- These will help answer key architectural questions.
-- ============================================================================

-- ============================================================================
-- SECTION 1: TABLE EXISTENCE & SCHEMA INSPECTION
-- ============================================================================

-- Check which credit-related tables exist
SELECT
  table_name,
  (SELECT count(*) FROM information_schema.columns WHERE table_name = t.table_name) as column_count
FROM information_schema.tables t
WHERE table_schema = 'public'
  AND table_name IN ('artist_credits', 'recording_credits', 'credited_works', 'credited_work_credits', 'release_artists')
ORDER BY table_name;

-- Detailed schema: recording_credits
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'recording_credits'
ORDER BY ordinal_position;

-- Detailed schema: credited_works
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'credited_works'
ORDER BY ordinal_position;

-- Detailed schema: credited_work_credits
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'credited_work_credits'
ORDER BY ordinal_position;

-- Check if artist_credits table exists
SELECT COUNT(*) as artist_credits_exists
FROM information_schema.tables
WHERE table_schema = 'public' AND table_name = 'artist_credits';

-- ============================================================================
-- SECTION 2: DATA VOLUME & DISTRIBUTION
-- ============================================================================

-- Row counts in credit tables
SELECT
  'recording_credits' as table_name,
  COUNT(*) as row_count,
  COUNT(DISTINCT recording_id) as distinct_recordings,
  COUNT(DISTINCT artist_id) as distinct_artists,
  COUNT(DISTINCT role) as distinct_roles
FROM public.recording_credits

UNION ALL

SELECT
  'credited_works' as table_name,
  COUNT(*),
  NULL as distinct_recordings,
  NULL as distinct_artists,
  NULL as distinct_roles
FROM public.credited_works

UNION ALL

SELECT
  'credited_work_credits' as table_name,
  COUNT(*),
  NULL as distinct_recordings,
  COUNT(DISTINCT artist_id) as distinct_artists,
  COUNT(DISTINCT role) as distinct_roles
FROM public.credited_work_credits;

-- ============================================================================
-- SECTION 3: LEGACY FIELD ANALYSIS
-- ============================================================================

-- Analyze recordings.artist_id usage
WITH recording_stats AS (
  SELECT
    COUNT(*) as total_recordings,
    COUNT(artist_id) as with_artist_id,
    COUNT(CASE WHEN artist_id IS NULL THEN 1 END) as null_artist_id,
    COUNT(DISTINCT artist_id) as distinct_artist_ids
  FROM public.recordings
)
SELECT
  total_recordings,
  with_artist_id,
  null_artist_id,
  distinct_artist_ids,
  ROUND(100.0 * with_artist_id / total_recordings, 2) as pct_with_artist_id
FROM recording_stats;

-- Analyze releases.release_artist_id usage
WITH release_stats AS (
  SELECT
    COUNT(*) as total_releases,
    COUNT(release_artist_id) as with_release_artist_id,
    COUNT(CASE WHEN release_artist_id IS NULL THEN 1 END) as null_release_artist_id,
    COUNT(DISTINCT release_artist_id) as distinct_release_artist_ids
  FROM public.releases
)
SELECT
  total_releases,
  with_release_artist_id,
  null_release_artist_id,
  distinct_release_artist_ids,
  ROUND(100.0 * with_release_artist_id / total_releases, 2) as pct_with_release_artist_id
FROM release_stats;

-- ============================================================================
-- SECTION 4: DATA DUPLICATION & CONFLICT ANALYSIS
-- ============================================================================

-- Compare recordings.artist_id with recording_credits
-- Find recordings where artist_id matches vs. conflicts with recording_credits
WITH recording_artists AS (
  SELECT DISTINCT ON (recording_id)
    recording_id,
    artist_id
  FROM public.recording_credits
  WHERE role IN ('vocal', 'singer', 'performer')  -- Likely primary vocalist
  ORDER BY recording_id, role DESC, created_at ASC
)
SELECT
  COUNT(*) as total_recordings_with_credits,
  COUNT(CASE WHEN ra.artist_id = r.artist_id THEN 1 END) as matching_artist_id,
  COUNT(CASE WHEN ra.artist_id != r.artist_id THEN 1 END) as conflicting_artist_id,
  COUNT(CASE WHEN r.artist_id IS NULL THEN 1 END) as null_artist_id_but_credits_exist,
  ROUND(100.0 * COUNT(CASE WHEN ra.artist_id = r.artist_id THEN 1 END) / COUNT(*), 2) as pct_match
FROM recording_artists ra
LEFT JOIN public.recordings r ON r.id = ra.recording_id
WHERE ra.artist_id IS NOT NULL;

-- Show specific conflicts (for manual review)
WITH recording_artists AS (
  SELECT DISTINCT ON (recording_id)
    recording_id,
    artist_id as credit_artist_id
  FROM public.recording_credits
  WHERE role IN ('vocal', 'singer', 'performer')
  ORDER BY recording_id, role DESC, created_at ASC
)
SELECT
  r.id as recording_id,
  r.title,
  r.artist_id as recordings_artist_id,
  ra.credit_artist_id as recording_credits_artist_id,
  ra.credit_artist_id != r.artist_id as is_conflict
FROM recording_artists ra
LEFT JOIN public.recordings r ON r.id = ra.recording_id
WHERE ra.artist_id IS DISTINCT FROM r.artist_id
LIMIT 20;

-- ============================================================================
-- SECTION 5: ROLE DISTRIBUTION IN RECORDING_CREDITS
-- ============================================================================

-- What roles exist in recording_credits?
SELECT
  role,
  COUNT(*) as count,
  COUNT(DISTINCT recording_id) as distinct_recordings,
  COUNT(DISTINCT artist_id) as distinct_artists
FROM public.recording_credits
WHERE role IS NOT NULL
GROUP BY role
ORDER BY count DESC;

-- ============================================================================
-- SECTION 6: CREDITED_WORKS ANALYSIS
-- ============================================================================

-- What data is in credited_works?
SELECT
  COUNT(*) as total_works,
  COUNT(performer_name) as with_performer_name,
  COUNT(release_title) as with_release_title,
  COUNT(recording_id) as with_recording_id,
  COUNT(release_id) as with_release_id,
  MIN(release_year) as min_year,
  MAX(release_year) as max_year
FROM public.credited_works;

-- Sample of credited_works data
SELECT
  id,
  title,
  performer_name,
  release_title,
  release_year,
  category,
  recording_id,
  release_id
FROM public.credited_works
LIMIT 20;

-- Categories in credited_works
SELECT
  category,
  COUNT(*) as count
FROM public.credited_works
WHERE category IS NOT NULL
GROUP BY category;

-- ============================================================================
-- SECTION 7: CREDITED_WORK_CREDITS ANALYSIS
-- ============================================================================

-- Role distribution in work credits
SELECT
  role,
  COUNT(*) as count,
  COUNT(DISTINCT work_id) as distinct_works,
  COUNT(DISTINCT artist_id) as distinct_artists
FROM public.credited_work_credits
WHERE role IS NOT NULL
GROUP BY role
ORDER BY count DESC;

-- Sample of credited_work_credits data
SELECT
  cwc.id,
  cwc.work_id,
  cw.title as work_title,
  cwc.artist_id,
  a.name as artist_name,
  cwc.role
FROM public.credited_work_credits cwc
LEFT JOIN public.credited_works cw ON cw.id = cwc.work_id
LEFT JOIN public.artists a ON a.id = cwc.artist_id
LIMIT 20;

-- ============================================================================
-- SECTION 8: FOREIGN KEY DEPENDENCY ANALYSIS
-- ============================================================================

-- All FKs referencing the main tables
SELECT
  constraint_name,
  table_name,
  column_name,
  foreign_table_name,
  foreign_column_name,
  update_rule,
  delete_rule
FROM information_schema.referential_constraints
WHERE constraint_schema = 'public'
  AND (foreign_table_name IN ('recordings', 'releases', 'credited_works', 'artists')
       OR table_name IN ('recording_credits', 'credited_work_credits', 'release_artists'))
ORDER BY table_name, constraint_name;

-- ============================================================================
-- SECTION 9: INDEXES ON CREDIT TABLES
-- ============================================================================

-- Indexes on recording_credits
SELECT
  indexname,
  indexdef
FROM pg_indexes
WHERE schemaname = 'public' AND tablename = 'recording_credits'
ORDER BY indexname;

-- Indexes on credited_works
SELECT
  indexname,
  indexdef
FROM pg_indexes
WHERE schemaname = 'public' AND tablename = 'credited_works'
ORDER BY indexname;

-- Indexes on credited_work_credits
SELECT
  indexname,
  indexdef
FROM pg_indexes
WHERE schemaname = 'public' AND tablename = 'credited_work_credits'
ORDER BY indexname;

-- ============================================================================
-- SECTION 10: RLS POLICY AUDIT
-- ============================================================================

-- RLS policies on credit tables
SELECT
  tablename,
  policyname,
  permissive,
  roles,
  qual,
  with_check
FROM pg_policies
WHERE schemaname = 'public' AND tablename IN (
  'recording_credits', 'credited_works', 'credited_work_credits', 'artist_credits'
)
ORDER BY tablename, policyname;

-- ============================================================================
-- SECTION 11: STORAGE USAGE
-- ============================================================================

-- Storage footprint of credit tables
SELECT
  tablename,
  pg_size_pretty(pg_total_relation_size(format('%I.%I', schemaname, tablename))) as total_size,
  pg_size_pretty(pg_relation_size(format('%I.%I', schemaname, tablename))) as table_size,
  pg_size_pretty(pg_total_relation_size(format('%I.%I', schemaname, tablename)) - pg_relation_size(format('%I.%I', schemaname, tablename))) as indexes_size
FROM pg_tables
WHERE schemaname = 'public' AND tablename IN (
  'recording_credits', 'credited_works', 'credited_work_credits', 'artist_credits'
)
ORDER BY pg_total_relation_size(format('%I.%I', schemaname, tablename)) DESC;

-- ============================================================================
-- SECTION 12: BACKFILL READINESS FOR release_artists
-- ============================================================================

-- Preview what will be backfilled from releases.release_artist_id
SELECT
  COUNT(*) as releases_to_backfill,
  COUNT(DISTINCT release_artist_id) as distinct_artists_to_backfill,
  COUNT(CASE WHEN release_artist_id IS NULL THEN 1 END) as null_artist_ids
FROM public.releases;

-- Sample of what will be backfilled
SELECT
  id as release_id,
  title,
  release_artist_id,
  release_year
FROM public.releases
WHERE release_artist_id IS NOT NULL
LIMIT 20;

-- Check for existing release_artists (should be empty before Phase B)
SELECT COUNT(*) as existing_release_artists FROM public.release_artists;

-- ============================================================================
-- SECTION 13: QUERY PERFORMANCE BASELINE
-- ============================================================================

-- Baseline query: Get recording credits (current app method)
EXPLAIN ANALYZE
SELECT role, artist:artists!inner(id, slug, name, status)
FROM public.recording_credits
WHERE recording_id = 'YOUR_RECORDING_ID_HERE'  -- Replace with actual UUID
  AND artist.status = 'published';

-- Baseline query: Get artists from recording_credits for home trending
EXPLAIN ANALYZE
SELECT DISTINCT ON (rc.recording_id)
  rc.recording_id,
  rc.artist_id,
  a.name
FROM public.recording_credits rc
JOIN public.artists a ON a.id = rc.artist_id
WHERE rc.role IN ('vocal', 'singer', 'performer')
  AND rc.recording_id IN ('ID1', 'ID2', 'ID3')  -- Replace with actual UUIDs
LIMIT 12;

-- ============================================================================
-- SECTION 14: SUMMARY STATISTICS
-- ============================================================================

-- Overall credit data health check
WITH stats AS (
  SELECT
    (SELECT COUNT(*) FROM public.recordings) as total_recordings,
    (SELECT COUNT(artist_id) FROM public.recordings WHERE artist_id IS NOT NULL) as recordings_with_artist_id,
    (SELECT COUNT(*) FROM public.recording_credits) as total_recording_credits,
    (SELECT COUNT(DISTINCT recording_id) FROM public.recording_credits) as recordings_with_credits,
    (SELECT COUNT(*) FROM public.releases) as total_releases,
    (SELECT COUNT(release_artist_id) FROM public.releases WHERE release_artist_id IS NOT NULL) as releases_with_artist_id,
    (SELECT COUNT(*) FROM public.credited_works) as total_works,
    (SELECT COUNT(*) FROM public.credited_work_credits) as total_work_credits
)
SELECT
  total_recordings,
  recordings_with_artist_id,
  ROUND(100.0 * recordings_with_artist_id / total_recordings, 1) as pct_recordings_with_artist_id,
  total_recording_credits,
  recordings_with_credits,
  total_releases,
  releases_with_artist_id,
  ROUND(100.0 * releases_with_artist_id / total_releases, 1) as pct_releases_with_artist_id,
  total_works,
  total_work_credits
FROM stats;

-- ============================================================================
-- SECTION 15: DATA QUALITY CHECKS
-- ============================================================================

-- Orphaned foreign keys in recording_credits
SELECT COUNT(*) as orphaned_recording_credits
FROM public.recording_credits rc
WHERE NOT EXISTS (SELECT 1 FROM public.recordings r WHERE r.id = rc.recording_id)
   OR NOT EXISTS (SELECT 1 FROM public.artists a WHERE a.id = rc.artist_id);

-- Orphaned foreign keys in credited_work_credits
SELECT COUNT(*) as orphaned_work_credits
FROM public.credited_work_credits cwc
WHERE NOT EXISTS (SELECT 1 FROM public.credited_works cw WHERE cw.id = cwc.work_id)
   OR NOT EXISTS (SELECT 1 FROM public.artists a WHERE a.id = cwc.artist_id);

-- Invalid references in credited_works (if it has FK to recordings)
SELECT COUNT(*) as orphaned_work_recordings
FROM public.credited_works cw
WHERE cw.recording_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM public.recordings r WHERE r.id = cw.recording_id);

-- Invalid references in credited_works (if it has FK to releases)
SELECT COUNT(*) as orphaned_work_releases
FROM public.credited_works cw
WHERE cw.release_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM public.releases r WHERE r.id = cw.release_id);

-- ============================================================================
-- SECTION 16: CREDITED_AS COLUMN VALIDATION
-- ============================================================================

-- Check credited_as population
SELECT
  COUNT(*) as total_release_artists,
  COUNT(CASE WHEN credited_as IS NOT NULL THEN 1 END) as with_credited_as,
  COUNT(CASE WHEN credited_as IS NULL THEN 1 END) as null_credited_as,
  ROUND(100.0 * COUNT(CASE WHEN credited_as IS NOT NULL THEN 1 END) / COUNT(*), 2) as pct_populated
FROM public.release_artists;

-- Check if credited_as differs from artist.name (indicates custom credits)
SELECT
  COUNT(*) as total_rows,
  COUNT(CASE WHEN ra.credited_as != a.name THEN 1 END) as custom_credited_as,
  COUNT(CASE WHEN ra.credited_as = a.name THEN 1 END) as matches_artist_name
FROM public.release_artists ra
JOIN public.artists a ON a.id = ra.artist_id;

-- Sample of custom credits (credited_as differs from artist name)
SELECT
  ra.id,
  a.name as artist_name,
  ra.credited_as,
  ra.role,
  r.title as release_title
FROM public.release_artists ra
JOIN public.artists a ON a.id = ra.artist_id
JOIN public.releases r ON r.id = ra.release_id
WHERE ra.credited_as IS NOT NULL AND ra.credited_as != a.name
LIMIT 20;

-- Sample of null credited_as (backfilled only)
SELECT
  ra.id,
  a.name as artist_name,
  ra.credited_as,
  ra.role,
  r.title as release_title
FROM public.release_artists ra
JOIN public.artists a ON a.id = ra.artist_id
JOIN public.releases r ON r.id = ra.release_id
WHERE ra.credited_as IS NULL
LIMIT 20;

-- ============================================================================
-- SECTION 17: RECOMMENDATIONS POST-ANALYSIS
-- ============================================================================

-- Run this AFTER analyzing the above to prioritize next steps:

-- If >50% of recordings have artist_id, it's heavily used → migration needed
-- If recording_credits has very few rows, legacy field is the real source → different strategy
-- If conflicts exist between artist_id and credits, data sync is broken → data cleanup first
-- If credited_works is empty, it's new → can refactor before app code depends on it

-- Priority checklist:
-- [ ] Check total_recordings vs. recordings_with_artist_id (usage rate)
-- [ ] Check recording_credits row count (adoption rate)
-- [ ] Check for conflicts (artist_id != recording_credits primary)
-- [ ] Check credited_works row count (is it empty?)
-- [ ] Check for orphaned FKs (data quality)
-- [ ] Estimate backfill time for release_artists (INSERT COUNT)

-- ============================================================================
-- END OF ANALYSIS QUERIES
-- ============================================================================
-- Last updated: 2026-07-03
-- Use results to validate recommendations in PHASE_2_ARCHITECTURE_REVIEW.md
