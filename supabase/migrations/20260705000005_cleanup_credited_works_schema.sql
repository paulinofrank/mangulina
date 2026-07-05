-- Phase 4 Final: Complete Schema Cleanup for Creative Works
-- Remove all obsolete columns and constraints from the old detailed model.
-- Keep only the 5-column editorial model: Year, Album_Title, Track_Title, Performer, Roles
-- This migration is safe to run multiple times and preserves data in retained columns.

BEGIN;

-- ============================================================================
-- STEP 1: Drop all constraints that depend on columns being removed
-- ============================================================================

-- Drop the old unique constraint on credited_works if it exists
ALTER TABLE IF EXISTS credited_works DROP CONSTRAINT IF EXISTS unique_credited_work;

-- Drop the old unique constraint on credited_work_credits if it exists
ALTER TABLE IF EXISTS credited_work_credits DROP CONSTRAINT IF EXISTS unique_credited_work_credit;

-- ============================================================================
-- STEP 2: Drop all indexes that depend on columns being removed
-- ============================================================================

DROP INDEX IF EXISTS idx_credited_works_dedup;
DROP INDEX IF EXISTS idx_credited_works_release;
DROP INDEX IF EXISTS idx_credited_work_credits_work;
DROP INDEX IF EXISTS idx_credited_work_credits_artist;
DROP INDEX IF EXISTS idx_credited_work_credits_role;
DROP INDEX IF EXISTS idx_credited_work_credits_artist_role;

-- Drop any indexes that reference removed columns
DROP INDEX IF EXISTS idx_credited_works_recording_id;
DROP INDEX IF EXISTS idx_credited_works_release_id;
DROP INDEX IF EXISTS idx_credited_work_credits_credit_detail;

-- ============================================================================
-- STEP 3: Drop obsolete columns from credited_works
-- ============================================================================

-- These columns are not in the consolidated editorial workbook and are not curated
ALTER TABLE IF EXISTS credited_works
  DROP COLUMN IF EXISTS release_type,        -- "Studio Album", "Single", etc.
  DROP COLUMN IF EXISTS label,               -- Record label
  DROP COLUMN IF EXISTS track_number,        -- Track position
  DROP COLUMN IF EXISTS source_confidence,   -- Metadata about source
  DROP COLUMN IF EXISTS category,            -- national/international
  DROP COLUMN IF EXISTS country,             -- Country of origin
  DROP COLUMN IF EXISTS source_url,          -- URL to source
  DROP COLUMN IF EXISTS notes,               -- Free-form notes
  DROP COLUMN IF EXISTS recording_id,        -- FK to recordings (not used)
  DROP COLUMN IF EXISTS release_id;          -- FK to releases (not used)

-- ============================================================================
-- STEP 4: Drop obsolete columns from credited_work_credits
-- ============================================================================

-- These columns are not in the consolidated editorial workbook and are not curated
ALTER TABLE IF EXISTS credited_work_credits
  DROP COLUMN IF EXISTS credit_detail,       -- Detailed credit text
  DROP COLUMN IF EXISTS co_credits,          -- Co-credit text
  DROP COLUMN IF EXISTS source_confidence,   -- Metadata about source
  DROP COLUMN IF EXISTS work_id;             -- Old column name (should be credited_work_id)

-- ============================================================================
-- STEP 5: Add new simplified unique constraints
-- ============================================================================

-- credited_works: unique by title + performer + release + year (no track_number)
ALTER TABLE IF EXISTS credited_works
  ADD CONSTRAINT unique_credited_work
  UNIQUE (title, performer_text, release_title, release_year);

-- credited_work_credits: unique by work + artist + role (no credit_detail)
ALTER TABLE IF EXISTS credited_work_credits
  ADD CONSTRAINT unique_credited_work_credit
  UNIQUE (credited_work_id, artist_id, role);

-- ============================================================================
-- STEP 6: Recreate simplified indexes
-- ============================================================================

-- Deduplication lookup during import
CREATE INDEX IF NOT EXISTS idx_credited_works_dedup
  ON credited_works(title, performer_text, release_title, release_year);

-- Release-based queries
CREATE INDEX IF NOT EXISTS idx_credited_works_release
  ON credited_works(release_title, release_year);

-- Credit lookups by work
CREATE INDEX IF NOT EXISTS idx_credited_work_credits_work
  ON credited_work_credits(credited_work_id);

-- Credit lookups by artist (for portfolio)
CREATE INDEX IF NOT EXISTS idx_credited_work_credits_artist
  ON credited_work_credits(artist_id);

-- Credit lookups by role
CREATE INDEX IF NOT EXISTS idx_credited_work_credits_role
  ON credited_work_credits(role);

-- Role aggregation (role summary by artist)
CREATE INDEX IF NOT EXISTS idx_credited_work_credits_artist_role
  ON credited_work_credits(artist_id, role);

-- ============================================================================
-- STEP 7: Verify constraints and triggers are still in place
-- ============================================================================

-- The triggers (credited_works_update_timestamp, credited_work_credits_update_timestamp)
-- reference only the updated_at column which still exists, so they should still work.
-- RLS policies reference only id and basic row-level checks, so they remain valid.

COMMIT;
