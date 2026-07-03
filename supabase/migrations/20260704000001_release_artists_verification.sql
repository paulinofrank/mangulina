-- ============================================================================
-- Phase A Verification: release_artists table
-- ============================================================================
-- Run these queries to verify Phase A migration completed successfully.
-- These are READ-ONLY queries safe to run anytime.
-- ============================================================================

-- ============================================================================
-- SECTION 1: TABLE STRUCTURE VERIFICATION
-- ============================================================================

-- Verify table exists and has correct columns
SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'release_artists'
ORDER BY ordinal_position;

-- Verify unique constraint exists
SELECT
    constraint_name,
    constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'public' AND table_name = 'release_artists'
ORDER BY constraint_type;

-- Verify indexes exist
SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public' AND tablename = 'release_artists'
ORDER BY indexname;

-- ============================================================================
-- SECTION 2: RLS POLICY VERIFICATION
-- ============================================================================

-- Check RLS is enabled
SELECT
    tablename,
    rowsecurity
FROM pg_tables
WHERE schemaname = 'public' AND tablename = 'release_artists';

-- Check RLS policies
SELECT
    tablename,
    policyname,
    permissive,
    roles,
    qual,
    with_check
FROM pg_policies
WHERE schemaname = 'public' AND tablename = 'release_artists'
ORDER BY policyname;

-- ============================================================================
-- SECTION 3: BACKFILL VERIFICATION
-- ============================================================================

-- Count rows in release_artists
SELECT
    COUNT(*) as total_release_artists,
    COUNT(DISTINCT release_id) as distinct_releases,
    COUNT(DISTINCT artist_id) as distinct_artists,
    COUNT(CASE WHEN role = 'primary' THEN 1 END) as primary_artists
FROM public.release_artists;

-- Compare backfill with source
WITH backfilled AS (
    SELECT COUNT(*) as backfill_count
    FROM public.release_artists
    WHERE role = 'primary'
),
source AS (
    SELECT COUNT(*) as source_count
    FROM public.releases
    WHERE release_artist_id IS NOT NULL
)
SELECT
    source.source_count as releases_with_release_artist_id,
    backfilled.backfill_count as backfilled_release_artists,
    CASE
        WHEN source.source_count = backfilled.backfill_count THEN '✓ MATCH'
        ELSE '✗ MISMATCH'
    END as backfill_status
FROM source, backfilled;

-- Show sample of backfilled data
SELECT
    ra.id,
    ra.release_id,
    r.title as release_title,
    ra.artist_id,
    a.name as artist_name,
    ra.role,
    ra.credited_as,
    ra.display_order
FROM public.release_artists ra
JOIN public.releases r ON r.id = ra.release_id
JOIN public.artists a ON a.id = ra.artist_id
ORDER BY r.title
LIMIT 20;

-- ============================================================================
-- SECTION 4: DATA INTEGRITY CHECKS
-- ============================================================================

-- Check for orphaned references
SELECT COUNT(*) as orphaned_release_references
FROM public.release_artists
WHERE NOT EXISTS (SELECT 1 FROM public.releases WHERE releases.id = release_artists.release_id);

SELECT COUNT(*) as orphaned_artist_references
FROM public.release_artists
WHERE NOT EXISTS (SELECT 1 FROM public.artists WHERE artists.id = release_artists.artist_id);

-- Check for duplicates in role/artist/release combination
SELECT
    release_id,
    artist_id,
    role,
    COUNT(*) as duplicate_count
FROM public.release_artists
GROUP BY release_id, artist_id, role
HAVING COUNT(*) > 1;

-- Check credited_as vs artist.name
SELECT
    ra.id,
    a.name as artist_name,
    ra.credited_as,
    CASE
        WHEN ra.credited_as IS NULL THEN 'Uses canonical name'
        WHEN ra.credited_as = a.name THEN 'Custom credit matches canonical name'
        ELSE 'Custom credit differs from canonical name'
    END as credit_status,
    COUNT(*) as count
FROM public.release_artists ra
JOIN public.artists a ON a.id = ra.artist_id
GROUP BY ra.id, a.name, ra.credited_as
ORDER BY credit_status, count DESC;

-- ============================================================================
-- SECTION 5: BACKWARD COMPATIBILITY CHECK
-- ============================================================================

-- Verify releases.release_artist_id still exists (legacy field)
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'releases'
  AND column_name = 'release_artist_id';

-- Count releases with legacy field vs new table
WITH legacy AS (
    SELECT COUNT(*) as count
    FROM public.releases
    WHERE release_artist_id IS NOT NULL
),
new_table AS (
    SELECT COUNT(DISTINCT release_id) as count
    FROM public.release_artists
    WHERE role = 'primary'
)
SELECT
    legacy.count as releases_with_legacy_release_artist_id,
    new_table.count as releases_in_new_table,
    CASE
        WHEN legacy.count = new_table.count THEN '✓ Consistent'
        ELSE '✗ Inconsistent'
    END as consistency_status
FROM legacy, new_table;

-- ============================================================================
-- SECTION 6: PERFORMANCE BASELINE
-- ============================================================================

-- Test index effectiveness: query release artists for a specific release
EXPLAIN ANALYZE
SELECT
    ra.artist_id,
    a.name,
    ra.role,
    ra.credited_as
FROM public.release_artists ra
JOIN public.artists a ON a.id = ra.artist_id
WHERE ra.release_id = (SELECT id FROM public.releases LIMIT 1)
ORDER BY ra.display_order, ra.role;

-- Test index effectiveness: query releases for a specific artist
EXPLAIN ANALYZE
SELECT
    ra.release_id,
    r.title,
    ra.role,
    ra.credited_as
FROM public.release_artists ra
JOIN public.releases r ON r.id = ra.release_id
WHERE ra.artist_id = (SELECT id FROM public.artists LIMIT 1)
ORDER BY r.release_date DESC;

-- ============================================================================
-- SECTION 7: SUMMARY REPORT
-- ============================================================================

-- Generate summary of Phase A completion
WITH counts AS (
    SELECT
        (SELECT COUNT(*) FROM public.release_artists) as total_release_artists,
        (SELECT COUNT(DISTINCT release_id) FROM public.release_artists) as releases_with_credits,
        (SELECT COUNT(*) FROM public.releases) as total_releases,
        (SELECT COUNT(*) FROM public.artists) as total_artists
)
SELECT
    counts.total_release_artists,
    counts.releases_with_credits,
    counts.total_releases,
    ROUND(100.0 * counts.releases_with_credits / counts.total_releases, 1) as pct_releases_with_credits,
    counts.total_artists
FROM counts;

-- ============================================================================
-- END VERIFICATION QUERIES
-- ============================================================================
-- Last updated: 2026-07-04
-- Use results to validate Phase A completion before proceeding to Phase B
