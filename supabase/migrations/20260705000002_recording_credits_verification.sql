-- ============================================================================
-- Phase 3C Verification: Recording Credits Structure & Data
-- ============================================================================
-- READ-ONLY VERIFICATION QUERIES (do not modify data)
-- Run these after Phase 3C migrations to validate success
-- ============================================================================

-- ============================================================================
-- 1. Table Exists & Has All Columns
-- ============================================================================

SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'recording_credits'
ORDER BY ordinal_position;

-- Expected columns:
-- id (uuid, NOT NULL, default)
-- recording_id (uuid, NOT NULL)
-- artist_id (uuid, NOT NULL)
-- role (text, NOT NULL)
-- display_order (integer, YES nullable)
-- created_at (timestamp, NOT NULL, default)
-- updated_at (timestamp, NOT NULL, default)
-- credited_as (text, YES nullable) ← NEW COLUMN

-- ============================================================================
-- 2. Constraints Exist & Are Correct
-- ============================================================================

SELECT
    constraint_name,
    constraint_type,
    is_deferrable
FROM information_schema.table_constraints
WHERE table_schema = 'public' AND table_name = 'recording_credits'
ORDER BY constraint_type, constraint_name;

-- Expected constraints:
-- PRIMARY KEY on id
-- UNIQUE on (recording_id, artist_id, role)
-- FOREIGN KEY for recording_id
-- FOREIGN KEY for artist_id
-- CHECK on credited_as (empty string prevention)

-- ============================================================================
-- 3. Check Constraints Specific
-- ============================================================================

SELECT
    constraint_name,
    check_clause
FROM information_schema.check_constraints
WHERE constraint_schema = 'public'
  AND constraint_name LIKE 'recording_credits%';

-- Expected CHECK constraints:
-- recording_credits_credited_as_check: credited_as IS NULL OR length(trim(credited_as)) > 0

-- ============================================================================
-- 4. Foreign Key Details
-- ============================================================================

SELECT
    constraint_name,
    table_name,
    column_name,
    referenced_table_name,
    referenced_column_name,
    delete_rule
FROM information_schema.referential_constraints
JOIN information_schema.key_column_usage
    ON referential_constraints.constraint_name = key_column_usage.constraint_name
WHERE key_column_usage.table_schema = 'public'
  AND key_column_usage.table_name = 'recording_credits'
ORDER BY constraint_name;

-- Expected:
-- recording_id → recordings.id (CASCADE)
-- artist_id → artists.id (RESTRICT)

-- ============================================================================
-- 5. Indexes Exist
-- ============================================================================

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public' AND tablename = 'recording_credits'
ORDER BY indexname;

-- Expected indexes:
-- recording_credits_pkey (primary key on id)
-- idx_recording_credits_recording_id
-- idx_recording_credits_artist_id
-- idx_recording_credits_role (optional but good)
-- recording_credits_recording_id_artist_id_role_key (unique constraint)

-- ============================================================================
-- 6. RLS Policies Enabled
-- ============================================================================

SELECT
    tablename,
    rowsecurity
FROM pg_tables
WHERE schemaname = 'public' AND tablename = 'recording_credits';

-- Expected: rowsecurity = true

-- ============================================================================
-- 7. RLS Policies Exist
-- ============================================================================

SELECT
    tablename,
    policyname,
    permissive,
    roles,
    qual,
    with_check
FROM pg_policies
WHERE schemaname = 'public' AND tablename = 'recording_credits'
ORDER BY policyname;

-- Expected policies:
-- recording_credits_select_published (SELECT for published recordings)
-- recording_credits_select_authenticated (SELECT for authenticated)
-- recording_credits_manage_admin (ALL for admin)

-- ============================================================================
-- 8. Helper Functions Exist
-- ============================================================================

SELECT
    routine_name,
    routine_type,
    data_type
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name LIKE 'get_%recording%'
ORDER BY routine_name;

-- Expected functions:
-- get_recording_performers
-- get_recording_performer_credit
-- get_recording_performers_by_role
-- get_artist_recording_credits
-- get_recording_credit_count
-- get_primary_recording_performer
-- get_recording_performers_summary

-- ============================================================================
-- 9. credited_as Column Data Check
-- ============================================================================

SELECT
    COUNT(*) as total_records,
    COUNT(*) FILTER (WHERE credited_as IS NULL) as null_count,
    COUNT(*) FILTER (WHERE credited_as IS NOT NULL) as populated_count,
    COUNT(DISTINCT credited_as) FILTER (WHERE credited_as IS NOT NULL) as unique_values
FROM public.recording_credits;

-- ============================================================================
-- 10. Role Distribution (Performance Level Types)
-- ============================================================================

SELECT
    role,
    COUNT(*) as count,
    COUNT(DISTINCT recording_id) as recordings_count
FROM public.recording_credits
GROUP BY role
ORDER BY count DESC
LIMIT 20;

-- Check for expected role values like:
-- vocal, guitar, drums, piano, orchestra, choir, producer, engineer, etc.

-- ============================================================================
-- 11. Data Integrity: No Null Role Values
-- ============================================================================

SELECT
    COUNT(*) as invalid_records
FROM public.recording_credits
WHERE role IS NULL OR role = '';

-- Expected: 0 (all roles should be set)

-- ============================================================================
-- 12. Data Integrity: No Orphaned Recording References
-- ============================================================================

SELECT
    COUNT(*) as orphaned_count
FROM public.recording_credits rc
WHERE NOT EXISTS (
    SELECT 1 FROM public.recordings r WHERE r.id = rc.recording_id
);

-- Expected: 0 (all recording_id should reference valid recordings)

-- ============================================================================
-- 13. Data Integrity: No Orphaned Artist References
-- ============================================================================

SELECT
    COUNT(*) as orphaned_count
FROM public.recording_credits rc
WHERE NOT EXISTS (
    SELECT 1 FROM public.artists a WHERE a.id = rc.artist_id
);

-- Expected: 0 (all artist_id should reference valid artists)

-- ============================================================================
-- 14. Unique Constraint Check
-- ============================================================================

SELECT
    recording_id,
    artist_id,
    role,
    COUNT(*) as duplicate_count
FROM public.recording_credits
GROUP BY recording_id, artist_id, role
HAVING COUNT(*) > 1;

-- Expected: 0 rows (no duplicates should exist)

-- ============================================================================
-- 15. Backward Compatibility: recordings.artist_id Still Exists
-- ============================================================================

SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'recordings'
  AND column_name = 'artist_id';

-- Expected: column still exists (not dropped)

-- ============================================================================
-- 16. Performance Test: Query a Recording's Performers
-- ============================================================================

EXPLAIN ANALYZE
SELECT
    rc.id,
    rc.artist_id,
    a.name,
    a.slug,
    rc.credited_as,
    rc.role,
    rc.display_order
FROM public.recording_credits rc
JOIN public.artists a ON a.id = rc.artist_id
WHERE rc.recording_id = (SELECT id FROM public.recordings LIMIT 1)
  AND a.status = 'published'
ORDER BY rc.display_order NULLS LAST, rc.role;

-- Check execution plan - should use indexes efficiently

-- ============================================================================
-- 17. Performance Test: Helper Function Execution
-- ============================================================================

EXPLAIN ANALYZE
SELECT * FROM public.get_recording_performers(
    (SELECT id FROM public.recordings LIMIT 1)
);

-- Should use same indexes, returns performers quickly

-- ============================================================================
-- 18. Coverage: Recordings with Performance Credits
-- ============================================================================

SELECT
    COUNT(DISTINCT recording_id) as recordings_with_credits,
    COUNT(DISTINCT artist_id) as artists_credited
FROM public.recording_credits;

-- Shows how many recordings have credits documented

-- ============================================================================
-- 19. Coverage: Recordings WITHOUT Performance Credits
-- ============================================================================

SELECT
    COUNT(*) as recordings_without_credits
FROM public.recordings r
WHERE NOT EXISTS (
    SELECT 1 FROM public.recording_credits rc
    WHERE rc.recording_id = r.id
);

-- Identifies gaps in data entry

-- ============================================================================
-- 20. Sample Data: Newest Credits
-- ============================================================================

SELECT
    r.title as recording_title,
    a.name as artist_name,
    rc.role,
    rc.credited_as,
    rc.created_at
FROM public.recording_credits rc
JOIN public.recordings r ON r.id = rc.recording_id
JOIN public.artists a ON a.id = rc.artist_id
WHERE a.status = 'published'
ORDER BY rc.created_at DESC
LIMIT 10;

-- Shows recent credits for spot-checking

-- ============================================================================
-- 21. Legacy Performer Audit
-- ============================================================================

SELECT
    rc.id,
    rc.recording_id,
    r.title as recording_title,
    rc.artist_id,
    a.name as artist_name,
    rc.role,
    rc.credited_as,
    rc.display_order,
    rc.created_at
FROM public.recording_credits rc
JOIN public.recordings r ON r.id = rc.recording_id
JOIN public.artists a ON a.id = rc.artist_id
WHERE rc.role = 'performer'
ORDER BY r.title ASC, a.name ASC;

-- Lists all legacy 'performer' role entries that need manual review/classification
-- These should be updated to explicit roles: lead_performer, featured_performer,
-- guest_performer, orchestra, choir, instrumentalist, etc.
-- This is a manual task for editors (can be done in Phase 3C-B admin UI)

-- ============================================================================
-- END OF VERIFICATION QUERIES
-- ============================================================================
-- All queries above should execute without error.
-- Check results against expected values to validate Phase 3C success.
--
-- PASS CRITERIA:
-- ✅ All columns present (including credited_as)
-- ✅ All constraints exist
-- ✅ All indexes exist
-- ✅ RLS enabled and policies present
-- ✅ All 7 helper functions exist
-- ✅ No NULL roles
-- ✅ No orphaned references
-- ✅ No duplicates
-- ✅ Legacy recordings.artist_id still exists
-- ✅ Queries execute efficiently
