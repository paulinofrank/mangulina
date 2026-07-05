-- Phase 4 Final: Complete Schema Cleanup and Constraint Application
-- This migration applies AFTER duplicate cleanup, so it assumes duplicates are already removed.
-- If duplicates still exist, run 20260705000006_cleanup_duplicate_credits.sql first.

BEGIN;

-- ============================================================================
-- STEP 1: Drop all constraints that depend on columns being removed
-- ============================================================================

ALTER TABLE IF EXISTS credited_works DROP CONSTRAINT IF EXISTS unique_credited_work;
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
DROP INDEX IF EXISTS idx_credited_works_recording_id;
DROP INDEX IF EXISTS idx_credited_works_release_id;
DROP INDEX IF EXISTS idx_credited_work_credits_credit_detail;

-- ============================================================================
-- STEP 3: Drop obsolete columns from credited_works
-- ============================================================================

ALTER TABLE IF EXISTS credited_works
  DROP COLUMN IF EXISTS release_type,
  DROP COLUMN IF EXISTS label,
  DROP COLUMN IF EXISTS track_number,
  DROP COLUMN IF EXISTS source_confidence,
  DROP COLUMN IF EXISTS category,
  DROP COLUMN IF EXISTS country,
  DROP COLUMN IF EXISTS source_url,
  DROP COLUMN IF EXISTS notes,
  DROP COLUMN IF EXISTS recording_id,
  DROP COLUMN IF EXISTS release_id;

-- ============================================================================
-- STEP 4: Drop obsolete columns from credited_work_credits
-- ============================================================================

ALTER TABLE IF EXISTS credited_work_credits
  DROP COLUMN IF EXISTS credit_detail,
  DROP COLUMN IF EXISTS co_credits,
  DROP COLUMN IF EXISTS source_confidence,
  DROP COLUMN IF EXISTS work_id;

-- ============================================================================
-- STEP 5: Add new simplified unique constraints
-- ============================================================================

ALTER TABLE IF EXISTS credited_works
  ADD CONSTRAINT unique_credited_work
  UNIQUE (title, performer_text, release_title, release_year);

ALTER TABLE IF EXISTS credited_work_credits
  ADD CONSTRAINT unique_credited_work_credit
  UNIQUE (credited_work_id, artist_id, role);

-- ============================================================================
-- STEP 6: Recreate simplified indexes
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_credited_works_dedup
  ON credited_works(title, performer_text, release_title, release_year);

CREATE INDEX IF NOT EXISTS idx_credited_works_release
  ON credited_works(release_title, release_year);

CREATE INDEX IF NOT EXISTS idx_credited_work_credits_work
  ON credited_work_credits(credited_work_id);

CREATE INDEX IF NOT EXISTS idx_credited_work_credits_artist
  ON credited_work_credits(artist_id);

CREATE INDEX IF NOT EXISTS idx_credited_work_credits_role
  ON credited_work_credits(role);

CREATE INDEX IF NOT EXISTS idx_credited_work_credits_artist_role
  ON credited_work_credits(artist_id, role);

COMMIT;
