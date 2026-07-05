-- Credited Works System - Validation Queries
-- Use these to verify the import succeeded and data is correct

-- ============================================================================
-- BEFORE IMPORT: Check prerequisites
-- ============================================================================

-- Verify Luny Tunes exists
SELECT id, slug, name, status
FROM artists
WHERE slug = 'luny-tunes' OR name = 'Luny Tunes'
LIMIT 1;

-- Store the ID for use in subsequent queries
-- For examples below, replace [LUNY_TUNES_ID] with the actual UUID


-- ============================================================================
-- AFTER IMPORT: Verify table creation
-- ============================================================================

-- Check credited_works table exists and has data
SELECT
  COUNT(*) as total_works,
  COUNT(DISTINCT release_year) as years_covered,
  MIN(release_year) as earliest_year,
  MAX(release_year) as latest_year,
  COUNT(CASE WHEN source_confidence = 'High' THEN 1 END) as high_confidence,
  COUNT(CASE WHEN source_confidence = 'Medium' THEN 1 END) as medium_confidence,
  COUNT(CASE WHEN source_confidence = 'Low' THEN 1 END) as low_confidence
FROM credited_works;

-- Expected: ~280 total works, 2002-2019 span, majority high confidence


-- Check credited_work_credits table exists and has data
SELECT
  COUNT(*) as total_credits,
  COUNT(DISTINCT credited_work_id) as unique_works,
  COUNT(DISTINCT artist_id) as unique_artists
FROM credited_work_credits;

-- Expected: 344 total credits, ~280 unique works, 1 artist (Luny Tunes)


-- ============================================================================
-- VERIFY DEDUPLICATION: Works should not be duplicated
-- ============================================================================

-- Check for duplicate works (should be 0)
SELECT
  title,
  performer_text,
  release_title,
  release_year,
  track_number,
  COUNT(*) as duplicate_count
FROM credited_works
GROUP BY title, performer_text, release_title, release_year, track_number
HAVING COUNT(*) > 1;

-- Expected: No rows (empty result)


-- Check works that appear multiple times with different roles
-- (This is EXPECTED - same work, multiple credits)
SELECT
  cw.title,
  cw.performer_text,
  cw.release_year,
  ARRAY_AGG(DISTINCT cwc.role ORDER BY cwc.role) as roles,
  COUNT(DISTINCT cwc.id) as credit_count
FROM credited_works cw
LEFT JOIN credited_work_credits cwc ON cwc.credited_work_id = cw.id
GROUP BY cw.id, cw.title, cw.performer_text, cw.release_year
HAVING COUNT(DISTINCT cwc.id) > 1
ORDER BY credit_count DESC
LIMIT 20;

-- Expected: Shows works with multiple roles (Producer + Composer + Arranger, etc.)
-- Example: "Gasolina" should have Producer, Composer, Mix Engineer, Mastering Engineer


-- ============================================================================
-- VERIFY ROLE NORMALIZATION
-- ============================================================================

-- Count credits by role
SELECT
  role,
  COUNT(*) as credit_count,
  COUNT(DISTINCT credited_work_id) as unique_works,
  COUNT(DISTINCT artist_id) as artists
FROM credited_work_credits
GROUP BY role
ORDER BY credit_count DESC;

-- Expected roles: Producer, Composer, Arranger, Mix Engineer, Mastering Engineer,
-- Beat Programmer, Executive Producer, Co-Producer, Remixer, etc.


-- List any unusual or non-standard roles
SELECT DISTINCT role
FROM credited_work_credits
WHERE role NOT IN (
  'Producer', 'Co-Producer', 'Executive Producer',
  'Composer', 'Songwriter', 'Lyricist',
  'Arranger', 'Musical Director', 'Conductor',
  'Mix Engineer', 'Mastering Engineer', 'Beat Programmer',
  'Remixer'
)
ORDER BY role;

-- Expected: Empty or minimal (any new roles discovered)


-- ============================================================================
-- VERIFY DATA INTEGRITY
-- ============================================================================

-- Check for works without credits
SELECT
  id, title, performer_text, release_title, release_year
FROM credited_works
WHERE id NOT IN (SELECT credited_work_id FROM credited_work_credits)
LIMIT 10;

-- Expected: Empty (all works should have at least one credit)


-- Check for credits without works (foreign key violation check)
SELECT COUNT(*)
FROM credited_work_credits
WHERE credited_work_id NOT IN (SELECT id FROM credited_works);

-- Expected: 0 (referential integrity maintained)


-- Check for credits without artists
SELECT COUNT(*)
FROM credited_work_credits
WHERE artist_id NOT IN (SELECT id FROM artists);

-- Expected: 0 (all artists should exist)


-- ============================================================================
-- ANALYZE PORTFOLIO BY YEAR
-- ============================================================================

-- Works per year
SELECT
  release_year,
  COUNT(DISTINCT cw.id) as works,
  COUNT(DISTINCT cwc.id) as credits,
  ARRAY_AGG(DISTINCT cwc.role ORDER BY cwc.role) as roles_present
FROM credited_works cw
LEFT JOIN credited_work_credits cwc ON cwc.credited_work_id = cw.id
WHERE cwc.artist_id = '[LUNY_TUNES_ID]'
GROUP BY release_year
ORDER BY release_year DESC;

-- Expected: Shows distribution across 2002-2019


-- ============================================================================
-- SPECIFIC WORK VALIDATION
-- ============================================================================

-- View a specific well-known work with all credits
-- "Gasolina" by Daddy Yankee (2004) should have 4 roles
SELECT
  cw.title,
  cw.performer_text,
  cw.release_title,
  cw.release_year,
  cwc.role,
  cwc.credit_detail,
  cwc.co_credits,
  cwc.source_confidence
FROM credited_works cw
LEFT JOIN credited_work_credits cwc ON cwc.credited_work_id = cw.id
WHERE cw.title = 'Gasolina' AND cw.release_year = 2004
ORDER BY cwc.role;

-- Expected: 4 rows
-- - Producer | Primary Beat Production | (null) | High
-- - Composer | Composition Credit | Raymond Ayala | High
-- - Mix Engineer | Mixing Credit | ECHO Hyde | High
-- - Mastering Engineer | Mastered by Nestor Salomón | (null) | High


-- ============================================================================
-- PORTFOLIO SUMMARY
-- ============================================================================

-- Role summary for Luny Tunes (using helper function)
SELECT * FROM get_artist_role_summary('[LUNY_TUNES_ID]')
ORDER BY count DESC;

-- Expected: Shows role frequencies
-- Producer: ~186
-- Composer: ~120
-- Arranger: ~38
-- etc.


-- Works summary
SELECT * FROM get_artist_credited_works_with_roles('[LUNY_TUNES_ID]')
LIMIT 10;

-- Expected: Returns works with aggregated roles as array


-- ============================================================================
-- SEARCH & FILTER EXAMPLES
-- ============================================================================

-- Find all works with a specific role
SELECT
  cw.title,
  cw.performer_text,
  cw.release_title,
  cw.release_year,
  cwc.role
FROM credited_works cw
JOIN credited_work_credits cwc ON cwc.credited_work_id = cw.id
WHERE cwc.artist_id = '[LUNY_TUNES_ID]'
  AND cwc.role = 'Composer'
ORDER BY cw.release_year DESC
LIMIT 20;

-- Expected: ~120 rows of composition credits


-- Find collaborations with specific artist
SELECT
  cw.title,
  cw.performer_text,
  cw.release_title,
  cw.release_year,
  ARRAY_AGG(cwc.role ORDER BY cwc.role) as roles
FROM credited_works cw
JOIN credited_work_credits cwc ON cwc.credited_work_id = cw.id
WHERE cwc.artist_id = '[LUNY_TUNES_ID]'
  AND cw.performer_text LIKE '%Daddy Yankee%'
GROUP BY cw.id, cw.title, cw.performer_text, cw.release_title, cw.release_year
ORDER BY cw.release_year DESC;

-- Expected: Multiple works with Daddy Yankee (frequent collaborator)


-- Find works from specific album
SELECT
  cw.title,
  cw.performer_text,
  cw.track_number,
  ARRAY_AGG(cwc.role ORDER BY cwc.role) as roles
FROM credited_works cw
JOIN credited_work_credits cwc ON cwc.credited_work_id = cw.id
WHERE cwc.artist_id = '[LUNY_TUNES_ID]'
  AND cw.release_title = 'Barrio Fino'
ORDER BY CAST(cw.track_number AS INTEGER);

-- Expected: All Daddy Yankee album tracks where Luny Tunes contributed


-- ============================================================================
-- RLS & PERMISSION CHECK
-- ============================================================================

-- Verify RLS policies allow public read
SELECT * FROM credited_works LIMIT 1;
-- Expected: Should work without authentication

SELECT * FROM credited_work_credits LIMIT 1;
-- Expected: Should work without authentication

-- Verify source_confidence is preserved
SELECT DISTINCT source_confidence
FROM credited_works
ORDER BY source_confidence;

-- Expected: "High", "Medium", "Low" (or variations)


-- ============================================================================
-- PERFORMANCE CHECK
-- ============================================================================

-- Check indexes were created
SELECT
  schemaname,
  tablename,
  indexname
FROM pg_indexes
WHERE tablename IN ('credited_works', 'credited_work_credits')
ORDER BY tablename, indexname;

-- Expected: Indexes on:
-- - credited_works: dedup key, release, timestamps
-- - credited_work_credits: work, artist, role, combined


-- ============================================================================
-- IDEMPOTENCY CHECK: Run import again
-- ============================================================================

-- Before second import, record current state
SELECT
  (SELECT COUNT(*) FROM credited_works) as works_before,
  (SELECT COUNT(*) FROM credited_work_credits) as credits_before;

-- Run import again:
-- npx ts-node scripts/importLunyTunesCreditedWorks.ts --file ./data/Luny_Tunes.csv

-- After second import, verify counts are identical
SELECT
  (SELECT COUNT(*) FROM credited_works) as works_after,
  (SELECT COUNT(*) FROM credited_work_credits) as credits_after;

-- Expected: works_before == works_after, credits_before == credits_after


-- ============================================================================
-- CLEANUP & VERIFICATION (if needed)
-- ============================================================================

-- To delete all Luny Tunes credits (for re-import):
-- DELETE FROM credited_work_credits
-- WHERE artist_id = '[LUNY_TUNES_ID]';
--
-- DELETE FROM credited_works
-- WHERE id NOT IN (
--   SELECT DISTINCT credited_work_id FROM credited_work_credits
-- );

-- CAUTION: This removes data. Use only for testing/development.
