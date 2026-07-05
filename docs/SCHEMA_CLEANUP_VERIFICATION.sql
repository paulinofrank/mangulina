-- Schema Cleanup Verification Queries
-- Run these after applying the migration to verify the schema is correct

-- ===========================================================================
-- Check 1: Verify credited_works table structure
-- ===========================================================================
-- Should show only 7 columns: id, title, performer_text, release_title, release_year, created_at, updated_at

SELECT
  column_name,
  data_type,
  is_nullable,
  column_default
FROM information_schema.columns
WHERE table_name = 'credited_works'
  AND table_schema = 'public';

-- Expected output (7 rows):
-- id | uuid | NO | gen_random_uuid()
-- title | text | NO | NULL
-- performer_text | text | YES | NULL
-- release_title | text | YES | NULL
-- release_year | integer | YES | NULL
-- created_at | timestamp with time zone | NO | now()
-- updated_at | timestamp with time zone | NO | now()

-- ===========================================================================
-- Check 2: Verify credited_work_credits table structure
-- ===========================================================================
-- Should show only 5 columns: id, credited_work_id, artist_id, role, created_at, updated_at

SELECT
  column_name,
  data_type,
  is_nullable,
  column_default
FROM information_schema.columns
WHERE table_name = 'credited_work_credits'
  AND table_schema = 'public';

-- Expected output (5 rows):
-- id | uuid | NO | gen_random_uuid()
-- credited_work_id | uuid | NO | NULL
-- artist_id | uuid | NO | NULL
-- role | text | NO | NULL
-- created_at | timestamp with time zone | NO | now()
-- updated_at | timestamp with time zone | NO | now()

-- ===========================================================================
-- Check 3: Verify constraints on credited_works
-- ===========================================================================

SELECT
  constraint_name,
  constraint_type,
  table_name
FROM information_schema.table_constraints
WHERE table_name = 'credited_works'
  AND table_schema = 'public';

-- Expected output:
-- unique_credited_work | UNIQUE | credited_works
-- credited_works_pkey | PRIMARY KEY | credited_works

-- ===========================================================================
-- Check 4: Verify unique constraint on credited_works
-- ===========================================================================

SELECT constraint_name, column_name
FROM information_schema.constraint_column_usage
WHERE constraint_name = 'unique_credited_work';

-- Expected output (4 rows):
-- unique_credited_work | title
-- unique_credited_work | performer_text
-- unique_credited_work | release_title
-- unique_credited_work | release_year

-- ===========================================================================
-- Check 5: Verify constraints on credited_work_credits
-- ===========================================================================

SELECT
  constraint_name,
  constraint_type,
  table_name
FROM information_schema.table_constraints
WHERE table_name = 'credited_work_credits'
  AND table_schema = 'public';

-- Expected output:
-- unique_credited_work_credit | UNIQUE | credited_work_credits
-- credited_work_credits_pkey | PRIMARY KEY | credited_work_credits

-- ===========================================================================
-- Check 6: Verify unique constraint on credited_work_credits
-- ===========================================================================

SELECT constraint_name, column_name
FROM information_schema.constraint_column_usage
WHERE constraint_name = 'unique_credited_work_credit';

-- Expected output (3 rows):
-- unique_credited_work_credit | credited_work_id
-- unique_credited_work_credit | artist_id
-- unique_credited_work_credit | role

-- ===========================================================================
-- Check 7: Verify indexes
-- ===========================================================================

SELECT
  indexname,
  indexdef
FROM pg_indexes
WHERE tablename IN ('credited_works', 'credited_work_credits')
  AND schemaname = 'public'
ORDER BY tablename, indexname;

-- Expected indexes:
-- idx_credited_works_dedup | CREATE INDEX idx_credited_works_dedup ON public.credited_works USING btree (title, performer_text, release_title, release_year)
-- idx_credited_works_release | CREATE INDEX idx_credited_works_release ON public.credited_works USING btree (release_title, release_year)
-- idx_credited_work_credits_artist | CREATE INDEX idx_credited_work_credits_artist ON public.credited_work_credits USING btree (artist_id)
-- idx_credited_work_credits_artist_role | CREATE INDEX idx_credited_work_credits_artist_role ON public.credited_work_credits USING btree (artist_id, role)
-- idx_credited_work_credits_role | CREATE INDEX idx_credited_work_credits_role ON public.credited_work_credits USING btree (role)
-- idx_credited_work_credits_work | CREATE INDEX idx_credited_work_credits_work ON public.credited_work_credits USING btree (credited_work_id)

-- ===========================================================================
-- Check 8: Verify no obsolete columns exist
-- ===========================================================================
-- Should return 0 rows (no obsolete columns found)

SELECT column_name
FROM information_schema.columns
WHERE table_name IN ('credited_works', 'credited_work_credits')
  AND table_schema = 'public'
  AND column_name IN (
    -- Obsolete credited_works columns
    'release_type', 'label', 'track_number', 'source_confidence',
    'category', 'country', 'source_url', 'notes',
    'recording_id', 'release_id',
    -- Obsolete credited_work_credits columns
    'credit_detail', 'co_credits', 'work_id'
  );

-- Expected output: (empty)

-- ===========================================================================
-- Check 9: Data integrity - verify foreign key relationships
-- ===========================================================================
-- All credited_work_ids in credited_work_credits should exist in credited_works

SELECT COUNT(*) AS orphaned_credits
FROM credited_work_credits cwc
WHERE NOT EXISTS (
  SELECT 1 FROM credited_works cw WHERE cw.id = cwc.credited_work_id
);

-- Expected output: 0 rows (no orphaned credits)

-- ===========================================================================
-- Check 10: Data integrity - verify all artist_ids are valid
-- ===========================================================================
-- All artist_ids in credited_work_credits should exist in artists

SELECT COUNT(*) AS invalid_artists
FROM credited_work_credits cwc
WHERE NOT EXISTS (
  SELECT 1 FROM artists a WHERE a.id = cwc.artist_id
);

-- Expected output: 0 rows (no invalid artist references)

-- ===========================================================================
-- Check 11: Verify no NULL values in NOT NULL columns
-- ===========================================================================

SELECT
  'credited_works' AS table_name,
  COUNT(*) AS null_count
FROM credited_works
WHERE title IS NULL
  OR created_at IS NULL
  OR updated_at IS NULL

UNION ALL

SELECT
  'credited_work_credits' AS table_name,
  COUNT(*) AS null_count
FROM credited_work_credits
WHERE credited_work_id IS NULL
  OR artist_id IS NULL
  OR role IS NULL
  OR created_at IS NULL
  OR updated_at IS NULL;

-- Expected output: All rows with 0 null_count

-- ===========================================================================
-- Check 12: Sample data to verify format
-- ===========================================================================
-- Show sample credited_works rows

SELECT id, title, performer_text, release_title, release_year, created_at
FROM credited_works
LIMIT 3;

-- ===========================================================================
-- Check 13: Sample credits to verify format
-- ===========================================================================
-- Show sample credited_work_credits rows

SELECT cwc.id, cwc.credited_work_id, cw.title, cwc.artist_id, cwc.role
FROM credited_work_credits cwc
JOIN credited_works cw ON cw.id = cwc.credited_work_id
LIMIT 5;

-- ===========================================================================
-- Check 14: Count total data
-- ===========================================================================

SELECT
  'credited_works' AS table_name,
  COUNT(*) AS row_count
FROM credited_works

UNION ALL

SELECT
  'credited_work_credits' AS table_name,
  COUNT(*) AS row_count
FROM credited_work_credits;

-- Expected for Luny Tunes:
-- credited_works: 210
-- credited_work_credits: ~341-342
