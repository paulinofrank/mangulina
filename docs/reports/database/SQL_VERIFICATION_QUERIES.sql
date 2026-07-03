-- ============================================================================
-- HISTORICAL REPORT: SQL Verification Queries for Database Audit
-- ============================================================================
-- Status: Historical Snapshot (2026-07-03)
-- Purpose: Read-only queries to verify findings from the Phase 1 database audit.
--
-- Current Source of Truth:
-- - docs/DATABASE_SCHEMA.md (when available)
-- - docs/DATA_GOVERNANCE.md
--
-- Note: These queries are historical and may not reflect current schema
-- if changes have been made since 2026-07-03.
--
-- These are READ-ONLY and safe to execute.
-- ============================================================================
--
-- SQL Verification Queries for Database Audit
-- ============================================================================
-- Run these queries against your Supabase PostgreSQL database to verify
-- the audit findings. These are READ-ONLY and safe to execute.
--
-- Database: Mangulina (Dominican Music Database)
-- Author: Database Audit Script
-- Date: 2026-07-03
-- ============================================================================

-- ============================================================================
-- SECTION 1: BASIC TABLE INVENTORY
-- ============================================================================

-- List all tables in the public schema with their sizes
SELECT
    tablename,
    pg_size_pretty(pg_total_relation_size(format('%I.%I', schemaname, tablename))) as total_size,
    (SELECT count(*) FROM information_schema.columns WHERE table_schema = 'public' AND table_name = t.tablename) as column_count
FROM pg_tables t
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(format('%I.%I', schemaname, tablename)) DESC;

-- ============================================================================
-- SECTION 2: ROW COUNTS FOR CRITICAL TABLES
-- ============================================================================

-- Core entity tables
SELECT 'artists' as table_name, count(*) as row_count FROM public.artists
UNION ALL
SELECT 'recordings', count(*) FROM public.recordings
UNION ALL
SELECT 'releases', count(*) FROM public.releases
UNION ALL
SELECT 'genres', count(*) FROM public.genres;

-- Editorial & content tables
SELECT 'lyrics' as table_name, count(*) as row_count FROM public.lyrics
UNION ALL
SELECT 'expressions', count(*) FROM public.expressions
UNION ALL
SELECT 'recording_expressions', count(*) FROM public.recording_expressions
UNION ALL
SELECT 'recording_editorial', count(*) FROM public.recording_editorial
UNION ALL
SELECT 'recording_fun_facts', count(*) FROM public.recording_fun_facts
UNION ALL
SELECT 'sources', count(*) FROM public.sources
UNION ALL
SELECT 'recording_sources', count(*) FROM public.recording_sources
UNION ALL
SELECT 'locations', count(*) FROM public.locations
UNION ALL
SELECT 'recording_locations', count(*) FROM public.recording_locations;

-- Credit & award tables
SELECT 'recording_credits' as table_name, count(*) as row_count FROM public.recording_credits
UNION ALL
SELECT 'credited_works', count(*) FROM public.credited_works
UNION ALL
SELECT 'credited_work_credits', count(*) FROM public.credited_work_credits
UNION ALL
SELECT 'artist_awards', count(*) FROM public.artist_awards
UNION ALL
SELECT 'artist_media', count(*) FROM public.artist_media
UNION ALL
SELECT 'artist_occupations', count(*) FROM public.artist_occupations
UNION ALL
SELECT 'awards', count(*) FROM public.awards
UNION ALL
SELECT 'award_categories', count(*) FROM public.award_categories;

-- ============================================================================
-- SECTION 3: ANALYTICS TABLES (Large Volume Expected)
-- ============================================================================

SELECT
    'artist_view_events' as table_name,
    count(*) as row_count,
    min(viewed_at) as oldest_event,
    max(viewed_at) as newest_event,
    pg_size_pretty(pg_total_relation_size('public.artist_view_events'::regclass)) as disk_size
FROM public.artist_view_events

UNION ALL

SELECT
    'recording_view_events',
    count(*),
    min(viewed_at),
    max(viewed_at),
    pg_size_pretty(pg_total_relation_size('public.recording_view_events'::regclass))
FROM public.recording_view_events

UNION ALL

SELECT
    'release_view_events',
    count(*),
    min(viewed_at),
    max(viewed_at),
    pg_size_pretty(pg_total_relation_size('public.release_view_events'::regclass))
FROM public.release_view_events

UNION ALL

SELECT
    'genre_view_events',
    count(*),
    min(viewed_at),
    max(viewed_at),
    pg_size_pretty(pg_total_relation_size('public.genre_view_events'::regclass))
FROM public.genre_view_events

UNION ALL

SELECT
    'search_events',
    count(*),
    min(searched_at),
    max(searched_at),
    pg_size_pretty(pg_total_relation_size('public.search_events'::regclass))
FROM public.search_events

UNION ALL

SELECT
    'platform_click_events',
    count(*),
    min(clicked_at),
    max(clicked_at),
    pg_size_pretty(pg_total_relation_size('public.platform_click_events'::regclass))
FROM public.platform_click_events

UNION ALL

SELECT
    'page_view_events',
    count(*),
    min(viewed_at),
    max(viewed_at),
    pg_size_pretty(pg_total_relation_size('public.page_view_events'::regclass))
FROM public.page_view_events;

-- ============================================================================
-- SECTION 4: UTILITY & INGEST TABLES (Review These)
-- ============================================================================

-- Low-utilization tables that need human verification before dropping
SELECT
    'genre_import_mapping' as table_name,
    count(*) as row_count,
    pg_size_pretty(pg_total_relation_size('public.genre_import_mapping'::regclass)) as disk_size
FROM public.genre_import_mapping

UNION ALL

SELECT
    'apple_recording_candidates',
    count(*),
    pg_size_pretty(pg_total_relation_size('public.apple_recording_candidates'::regclass))
FROM public.apple_recording_candidates

UNION ALL

SELECT
    'odesli_batch_progress',
    count(*),
    pg_size_pretty(pg_total_relation_size('public.odesli_batch_progress'::regclass))
FROM public.odesli_batch_progress

UNION ALL

SELECT
    'wikidata_raw',
    count(*),
    pg_size_pretty(pg_total_relation_size('public.wikidata_raw'::regclass))
FROM public.wikidata_raw

UNION ALL

SELECT
    'cover_art_ingest_log',
    count(*),
    pg_size_pretty(pg_total_relation_size('public.cover_art_ingest_log'::regclass))
FROM public.cover_art_ingest_log

UNION ALL

SELECT
    'imported_reference_table',
    count(*),
    pg_size_pretty(pg_total_relation_size('public.imported_reference_table'::regclass))
FROM public.imported_reference_table

UNION ALL

SELECT
    'recording_classification_review',
    count(*),
    pg_size_pretty(pg_total_relation_size('public.recording_classification_review'::regclass))
FROM public.recording_classification_review;

-- ============================================================================
-- SECTION 5: FOREIGN KEY DEPENDENCY ANALYSIS
-- ============================================================================

-- All foreign keys in the public schema
SELECT
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name,
    rc.update_rule,
    rc.delete_rule
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
    AND ccu.table_schema = tc.table_schema
JOIN information_schema.referential_constraints AS rc
    ON rc.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'public'
ORDER BY tc.table_name, kcu.column_name;

-- Count of tables by number of incoming foreign keys (tables that depend on this table)
WITH fk_counts AS (
    SELECT
        ccu.table_name,
        count(*) as incoming_fk_count
    FROM information_schema.constraint_column_usage ccu
    WHERE ccu.table_schema = 'public'
    GROUP BY ccu.table_name
)
SELECT
    table_name,
    incoming_fk_count,
    CASE
        WHEN incoming_fk_count > 5 THEN 'HIGH (many dependencies)'
        WHEN incoming_fk_count > 2 THEN 'MEDIUM'
        WHEN incoming_fk_count > 0 THEN 'LOW'
        ELSE 'NONE'
    END as dependency_risk
FROM fk_counts
ORDER BY incoming_fk_count DESC;

-- ============================================================================
-- SECTION 6: ROW LEVEL SECURITY (RLS) POLICY AUDIT
-- ============================================================================

-- List all RLS policies by table
SELECT
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    qual as policy_condition,
    with_check
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname;

-- Count of policies per table
SELECT
    schemaname,
    tablename,
    count(*) as policy_count,
    CASE
        WHEN count(*) = 0 THEN 'WARNING: No RLS policies'
        WHEN count(*) < 2 THEN 'CHECK: Minimal policies'
        ELSE 'OK'
    END as rls_status
FROM pg_policies
WHERE schemaname = 'public'
GROUP BY schemaname, tablename
ORDER BY tablename;

-- Tables with RLS enabled
SELECT
    t.schemaname,
    t.tablename,
    (SELECT count(*) FROM pg_policies WHERE schemaname = t.schemaname AND tablename = t.tablename) as policy_count,
    CASE
        WHEN (SELECT count(*) FROM pg_policies WHERE schemaname = t.schemaname AND tablename = t.tablename) > 0 THEN 'Enabled'
        ELSE 'No policies (check if RLS is enforced)'
    END as rls_status
FROM pg_tables t
WHERE t.schemaname = 'public'
ORDER BY t.tablename;

-- ============================================================================
-- SECTION 7: MATERIALIZED VIEWS & VIEWS ANALYSIS
-- ============================================================================

-- List all materialized views
SELECT
    schemaname,
    matviewname,
    pg_size_pretty(pg_total_relation_size(format('%I.%I', schemaname, matviewname))) as size
FROM pg_matviews
WHERE schemaname = 'public'
ORDER BY matviewname;

-- List all regular views
SELECT
    schemaname,
    viewname,
    CASE
        WHEN definition ILIKE '%artist_view_events%' THEN 'Uses analytics'
        WHEN definition ILIKE '%recording_view_events%' THEN 'Uses analytics'
        WHEN definition ILIKE '%release_view_events%' THEN 'Uses analytics'
        WHEN definition ILIKE '%search_events%' THEN 'Uses analytics'
        ELSE 'Other'
    END as view_purpose
FROM pg_views
WHERE schemaname = 'public'
ORDER BY viewname;

-- ============================================================================
-- SECTION 8: STORED FUNCTIONS & PROCEDURES
-- ============================================================================

-- List all functions/procedures in public schema
SELECT
    routine_schema,
    routine_name,
    routine_type,
    data_type
FROM information_schema.routines
WHERE routine_schema = 'public'
ORDER BY routine_name;

-- Functions that reference specific tables (example: find functions using artist_view_events)
SELECT
    routine_schema,
    routine_name,
    routine_definition
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_definition ILIKE '%artist_view_events%'
ORDER BY routine_name;

-- ============================================================================
-- SECTION 9: INDEX INVENTORY
-- ============================================================================

-- All indexes by table
SELECT
    t.tablename,
    i.indexname,
    ix.indisprimary,
    ix.indisunique,
    ix.indisclustered,
    pg_size_pretty(pg_relation_size(i.indexrelid)) as index_size
FROM pg_tables t
JOIN pg_indexes i ON t.tablename = i.tablename AND t.schemaname = i.schemaname
JOIN pg_index ix ON i.indexrelid = ix.indexrelid::regclass
WHERE t.schemaname = 'public'
ORDER BY t.tablename, i.indexname;

-- ============================================================================
-- SECTION 10: TABLE CONSTRAINTS AUDIT
-- ============================================================================

-- All constraints by table
SELECT
    tc.table_name,
    tc.constraint_name,
    tc.constraint_type,
    ccu.column_name
FROM information_schema.table_constraints tc
LEFT JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
    AND tc.table_schema = ccu.table_schema
WHERE tc.table_schema = 'public'
ORDER BY tc.table_name, tc.constraint_type;

-- ============================================================================
-- SECTION 11: SPECIFIC TABLE DEEP DIVES (Run for Tables Under Review)
-- ============================================================================

-- Example 1: Detailed inspection of apple_recording_candidates
SELECT
    count(*) as row_count,
    count(DISTINCT recording_id) as unique_recordings,
    min(created_at) as oldest_entry,
    max(created_at) as newest_entry,
    (SELECT count(*) FROM information_schema.table_constraints tc WHERE tc.table_name = 'apple_recording_candidates') as constraint_count
FROM public.apple_recording_candidates;

-- Example 2: Detailed inspection of odesli_batch_progress
SELECT
    count(*) as total_checkpoints,
    max(last_offset) as furthest_offset,
    max(updated_at) as most_recent_update,
    min(updated_at) as oldest_update
FROM public.odesli_batch_progress;

-- Example 3: Inspect genre_import_mapping usage
SELECT
    count(*) as total_mappings,
    count(DISTINCT genre_id) as unique_genres_mapped,
    count(DISTINCT subgenre_id) as unique_subgenres_mapped
FROM public.genre_import_mapping;

-- ============================================================================
-- SECTION 12: DATA QUALITY & NULL CHECKS
-- ============================================================================

-- Check for NULL values in critical ID columns (sample)
SELECT
    (SELECT count(*) FROM public.artists WHERE id IS NULL) as artists_null_ids,
    (SELECT count(*) FROM public.recordings WHERE id IS NULL) as recordings_null_ids,
    (SELECT count(*) FROM public.releases WHERE id IS NULL) as releases_null_ids,
    (SELECT count(*) FROM public.genres WHERE id IS NULL) as genres_null_ids;

-- Check for orphaned foreign keys (example: recording_credits with invalid recording_id)
SELECT
    rc.recording_id,
    count(*) as orphaned_credit_count
FROM public.recording_credits rc
LEFT JOIN public.recordings r ON rc.recording_id = r.id
WHERE r.id IS NULL
GROUP BY rc.recording_id;

-- ============================================================================
-- SECTION 13: CACHE/MATERIALIZED VIEW REFRESH STATUS
-- ============================================================================

-- Check when analytics rollups were last refreshed
SELECT
    id,
    refreshed_at,
    now() - refreshed_at as time_since_refresh
FROM public.analytics_rollup_status;

-- Check if materialized views exist and their size
SELECT
    matviewname,
    pg_size_pretty(pg_total_relation_size(format('%I.%I', 'public', matviewname))) as size,
    (SELECT count(*) FROM information_schema.indexes WHERE tablename = pg_matviews.matviewname) as index_count
FROM pg_matviews
WHERE schemaname = 'public'
ORDER BY matviewname;

-- ============================================================================
-- SECTION 14: TROUBLESHOOTING QUERIES
-- ============================================================================

-- Find all tables created in last 30 days (useful for tracking new tables)
SELECT
    schemaname,
    tablename
FROM pg_tables
WHERE schemaname = 'public'
  AND pg_total_relation_size(format('%I.%I', schemaname, tablename)) > 0
ORDER BY tablename;

-- List tables with no rows (potential candidates for cleanup, but verify first)
SELECT
    schemaname,
    tablename,
    (SELECT count(*) FROM information_schema.table_constraints tc WHERE tc.table_schema = 'public' AND tc.table_name = t.tablename) as constraint_count
FROM pg_tables t
WHERE schemaname = 'public'
  AND NOT EXISTS (SELECT 1 FROM information_schema.table_constraints tc WHERE tc.table_schema = 'public' AND tc.table_name = t.tablename AND tc.constraint_type = 'PRIMARY KEY')
ORDER BY tablename;

-- ============================================================================
-- FINAL VERIFICATION: Run this before dropping any table
-- ============================================================================

-- Complete audit snapshot for a specific table (replace TABLE_NAME)
WITH table_info AS (
    SELECT
        'TABLE_NAME' as target_table,
        count(*) as row_count,
        pg_size_pretty(pg_total_relation_size('public.TABLE_NAME'::regclass)) as total_size
    FROM public.TABLE_NAME
)
SELECT
    t.target_table,
    t.row_count,
    t.total_size,
    (SELECT count(*) FROM information_schema.columns WHERE table_name = 'TABLE_NAME') as column_count,
    (SELECT count(*) FROM pg_indexes WHERE tablename = 'TABLE_NAME') as index_count,
    (SELECT count(*) FROM pg_policies WHERE tablename = 'TABLE_NAME') as rls_policy_count,
    (SELECT count(*) FROM information_schema.table_constraints tc WHERE tc.table_name = 'TABLE_NAME' AND tc.constraint_type = 'FOREIGN KEY') as fk_count,
    (SELECT count(*) FROM information_schema.constraint_column_usage ccu WHERE ccu.table_name = 'TABLE_NAME') as incoming_fk_count
FROM table_info t;

-- ============================================================================
-- END OF SQL VERIFICATION QUERIES
-- ============================================================================
-- Last updated: 2026-07-03
-- Next update: After significant schema changes or quarterly audit
