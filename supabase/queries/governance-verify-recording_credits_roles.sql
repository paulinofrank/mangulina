-- ============================================================================
-- GOVERNANCE VERIFICATION: Current Roles in recording_credits
-- ============================================================================
--
-- Purpose: Audit which roles are currently stored in recording_credits
--          to verify they are recording-level credits, not work-level
--
-- Run this query in Supabase SQL Editor to see:
--   - All distinct roles currently used
--   - How many credits per role
--   - How many recordings/artists per role
--
-- Then classify each role as:
--   1. OK to remain (recording/performance/technical credit)
--   2. Should move to credited_work_credits (composition-level credit)
--   3. Ambiguous (needs human review)
--
-- See: docs/reports/PHASE_3C_GOVERNANCE_ROLE_VERIFICATION.md
-- ============================================================================

-- QUERY 1: Distinct Roles Summary
-- Run this first to see all roles

SELECT DISTINCT
    role,
    COUNT(*) as total_credits,
    COUNT(DISTINCT recording_id) as recordings_with_role,
    COUNT(DISTINCT artist_id) as artists_with_role,
    MIN(rc.created_at) as first_created,
    MAX(rc.created_at) as last_created
FROM public.recording_credits rc
GROUP BY role
ORDER BY total_credits DESC, role ASC;

-- ============================================================================

-- QUERY 2: Sample Data for Each Role
-- Shows examples of each role in context

SELECT
    role,
    COUNT(*) as count,
    STRING_AGG(DISTINCT a.name, ', ' ORDER BY a.name) as sample_artists,
    STRING_AGG(DISTINCT r.title, ', ' ORDER BY r.title) as sample_recordings
FROM public.recording_credits rc
JOIN public.artists a ON a.id = rc.artist_id
JOIN public.recordings r ON r.id = rc.recording_id
GROUP BY role
ORDER BY count DESC, role ASC;

-- ============================================================================

-- QUERY 3: Suspicious Work-Level Role Names
-- Check if any roles that LOOK like work-level credits exist

SELECT
    role,
    COUNT(*) as count
FROM public.recording_credits
WHERE role ILIKE ANY(ARRAY[
    '%composer%',
    '%lyricist%',
    '%writer%',
    '%songwriter%',
    '%orchestrator%',
    '%co-composer%',
    '%co-writer%'
])
GROUP BY role;

-- Expected result: 0 rows (if none found, no work-level credits in recording table)

-- ============================================================================

-- QUERY 4: Recording-Level Roles Check
-- Verify only expected recording-level roles exist

SELECT
    role,
    COUNT(*) as count,
    CASE
        WHEN role ILIKE ANY(ARRAY[
            'vocal', 'lead_vocal', 'vocals', 'featured_vocal', 'guest_vocal',
            'guitar', 'drums', 'piano', 'bass', 'trumpet', 'saxophone', 'trombone',
            'strings', 'orchestra', 'choir', 'percussion', 'horns',
            'producer', 'engineer', 'recording_engineer', 'mixing', 'mixing_engineer', 'mastering', 'mastering_engineer',
            'session_musician', 'conductor', 'arranging', 'arranger'
        ])
        THEN 'EXPECTED'
        ELSE 'REVIEW'
    END as classification
FROM public.recording_credits
GROUP BY role, classification
ORDER BY classification DESC, count DESC;

-- ============================================================================

-- QUERY 5: Artists with Both Work-Level and Recording-Level Roles
-- Find artists that may have data in both places (indicators of mixed levels)

WITH work_artists AS (
    SELECT DISTINCT artist_id
    FROM public.credited_work_credits
),
recording_artists AS (
    SELECT DISTINCT artist_id
    FROM public.recording_credits
)
SELECT
    a.id,
    a.name,
    a.slug,
    COUNT(DISTINCT CASE WHEN wa.artist_id IS NOT NULL THEN 1 END) as has_work_credits,
    COUNT(DISTINCT CASE WHEN ra.artist_id IS NOT NULL THEN 1 END) as has_recording_credits
FROM public.artists a
LEFT JOIN work_artists wa ON a.id = wa.artist_id
LEFT JOIN recording_artists ra ON a.id = ra.artist_id
WHERE wa.artist_id IS NOT NULL AND ra.artist_id IS NOT NULL
GROUP BY a.id, a.name, a.slug
ORDER BY a.name ASC;

-- ============================================================================

-- QUERY 6: Detailed Role Review (Interactive)
-- Run with WHERE clause to review specific roles
-- Example: WHERE role = 'producer'

SELECT
    role,
    a.id as artist_id,
    a.name as artist_name,
    r.id as recording_id,
    r.title as recording_title,
    w.id as work_id,
    w.title as work_title,
    rc.credited_as,
    rc.created_at
FROM public.recording_credits rc
JOIN public.artists a ON a.id = rc.artist_id
JOIN public.recordings r ON r.id = rc.recording_id
LEFT JOIN public.works w ON r.work_id = w.id
WHERE role = 'producer'  -- CHANGE THIS TO REVIEW EACH ROLE
ORDER BY r.created_at DESC
LIMIT 20;

-- ============================================================================
-- INSTRUCTIONS
-- ============================================================================
--
-- 1. Run QUERY 1 first to see summary of all roles
--
-- 2. For any suspicious roles (that look like work-level), run QUERY 3
--    Roles to watch for:
--    - composer, lyricist, writer, songwriter, orchestrator
--    - arranger (if at work level)
--
-- 3. Run QUERY 4 to see which roles are expected vs. which need review
--
-- 4. Run QUERY 5 to find artists with both work and recording credits
--    (could indicate data structure issues)
--
-- 5. For any role you want to review in detail, edit QUERY 6 WHERE clause
--    and run it to see sample records
--
-- 6. Classify each role using PHASE_3C_GOVERNANCE_ROLE_VERIFICATION.md
--    - Category 1: OK to stay
--    - Category 2: Move to credited_work_credits
--    - Category 3: Ambiguous, needs review
--
-- 7. Report results with:
--    - Count of each category
--    - List of Category 2 roles (if any)
--    - List of Category 3 roles (if any)
--    - Recommendation: safe to deploy or needs data migration
--
-- ============================================================================
