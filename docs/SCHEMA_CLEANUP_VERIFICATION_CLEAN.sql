-- Schema Cleanup Verification - Run each query individually in Supabase SQL Editor
-- Do NOT run all together - copy and paste ONE query at a time

-- ===========================================================================
-- CHECK 1: Verify credited_works has 7 columns
-- ===========================================================================
SELECT
  column_name,
  data_type,
  is_nullable
FROM information_schema.columns
WHERE table_name = 'credited_works'
  AND table_schema = 'public';

-- ===========================================================================
-- CHECK 2: Verify credited_work_credits has 5 columns
-- ===========================================================================
SELECT
  column_name,
  data_type,
  is_nullable
FROM information_schema.columns
WHERE table_name = 'credited_work_credits'
  AND table_schema = 'public';

-- ===========================================================================
-- CHECK 3: Verify unique_credited_work constraint exists
-- ===========================================================================
SELECT constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_name = 'credited_works'
  AND table_schema = 'public'
  AND constraint_name = 'unique_credited_work';

-- ===========================================================================
-- CHECK 4: Verify unique_credited_work_credit constraint exists
-- ===========================================================================
SELECT constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_name = 'credited_work_credits'
  AND table_schema = 'public'
  AND constraint_name = 'unique_credited_work_credit';

-- ===========================================================================
-- CHECK 5: Verify no obsolete columns remain
-- ===========================================================================
SELECT column_name
FROM information_schema.columns
WHERE table_name IN ('credited_works', 'credited_work_credits')
  AND table_schema = 'public'
  AND column_name IN (
    'release_type', 'label', 'track_number', 'source_confidence',
    'category', 'country', 'source_url', 'notes',
    'recording_id', 'release_id',
    'credit_detail', 'co_credits', 'work_id'
  );

-- ===========================================================================
-- CHECK 6: Verify no orphaned credits (all link to valid works)
-- ===========================================================================
SELECT COUNT(*) AS orphaned_credits
FROM credited_work_credits cwc
WHERE NOT EXISTS (
  SELECT 1 FROM credited_works cw WHERE cw.id = cwc.credited_work_id
);

-- ===========================================================================
-- CHECK 7: Verify all artist_ids are valid
-- ===========================================================================
SELECT COUNT(*) AS invalid_artists
FROM credited_work_credits cwc
WHERE NOT EXISTS (
  SELECT 1 FROM artists a WHERE a.id = cwc.artist_id
);

-- ===========================================================================
-- CHECK 8: Count total records
-- ===========================================================================
SELECT 'credited_works' as table_name, COUNT(*) as row_count FROM credited_works
UNION ALL
SELECT 'credited_work_credits', COUNT(*) FROM credited_work_credits;

-- ===========================================================================
-- CHECK 9: Sample data (first 3 works)
-- ===========================================================================
SELECT id, title, performer_text, release_title, release_year
FROM credited_works
LIMIT 3;
