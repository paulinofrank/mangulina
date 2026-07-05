-- Phase 4 Data Cleanup: Remove Duplicate Credits
-- Before applying the unique constraint, remove duplicate (work, artist, role) combinations.
-- Keep the oldest (first created) record, delete the duplicates.
-- This is safe in pre-production: data can be re-imported cleanly with --reset-artist.

BEGIN;

-- ============================================================================
-- STEP 1: Identify duplicates
-- ============================================================================
-- Show what will be deleted (for safety verification)

WITH duplicates AS (
  SELECT
    credited_work_id,
    artist_id,
    role,
    COUNT(*) as count,
    STRING_AGG(id::text, ', ' ORDER BY created_at) as ids_ordered_by_created_at
  FROM credited_work_credits
  GROUP BY credited_work_id, artist_id, role
  HAVING COUNT(*) > 1
)
SELECT
  COUNT(*) as duplicate_groups,
  SUM(count - 1) as total_records_to_delete
FROM duplicates;

-- ============================================================================
-- STEP 2: Delete duplicate records (keep oldest)
-- ============================================================================
-- For each (work, artist, role) combination with duplicates,
-- keep the oldest record (by created_at) and delete the rest.

DELETE FROM credited_work_credits
WHERE id IN (
  SELECT id
  FROM (
    SELECT
      id,
      ROW_NUMBER() OVER (
        PARTITION BY credited_work_id, artist_id, role
        ORDER BY created_at ASC
      ) as rn
    FROM credited_work_credits
  ) ranked
  WHERE rn > 1
);

-- ============================================================================
-- STEP 3: Verify duplicates are gone
-- ============================================================================

SELECT
  'No duplicates found' as status
WHERE NOT EXISTS (
  SELECT 1
  FROM credited_work_credits
  GROUP BY credited_work_id, artist_id, role
  HAVING COUNT(*) > 1
);

-- ============================================================================
-- STEP 4: Delete orphaned works
-- ============================================================================
-- After deleting credits, some works may have no credits left.
-- Clean them up.

DELETE FROM credited_works
WHERE id NOT IN (
  SELECT DISTINCT credited_work_id FROM credited_work_credits
);

COMMIT;
