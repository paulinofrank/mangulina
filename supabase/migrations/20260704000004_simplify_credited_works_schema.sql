-- Phase 4B: Simplify Creative Works Schema
-- Remove obsolete columns that are no longer part of the consolidated editorial model.
-- The consolidated workbook contains only: Year, Album_Title, Track_Title, Performer, Roles.
-- Database schema is simplified to match this editorial reality.
-- This migration is safe to run on existing databases with data.

BEGIN;

-- Step 1: Drop constraints that depend on removed columns
-- Drop the old unique constraint that includes track_number
ALTER TABLE IF EXISTS credited_works DROP CONSTRAINT IF EXISTS unique_credited_work;

-- Drop the old unique constraint that includes credit_detail
ALTER TABLE IF EXISTS credited_work_credits DROP CONSTRAINT IF EXISTS unique_credited_work_credit;

-- Step 2: Drop indexes that depend on removed columns
DROP INDEX IF EXISTS idx_credited_works_dedup;

-- Step 3: Drop helper function that returns removed columns
-- Will be recreated below without removed columns
DROP FUNCTION IF EXISTS get_artist_credited_works_with_roles(UUID);

-- Step 4: Remove columns from credited_works table
ALTER TABLE IF EXISTS credited_works
  DROP COLUMN IF EXISTS release_type,
  DROP COLUMN IF EXISTS label,
  DROP COLUMN IF EXISTS track_number,
  DROP COLUMN IF EXISTS source_confidence;

-- Step 5: Remove columns from credited_work_credits table
ALTER TABLE IF EXISTS credited_work_credits
  DROP COLUMN IF EXISTS credit_detail,
  DROP COLUMN IF EXISTS co_credits,
  DROP COLUMN IF EXISTS source_confidence;

-- Step 6: Add new constraints with correct column sets
-- credited_works: Unique constraint now without track_number
ALTER TABLE credited_works
  ADD CONSTRAINT unique_credited_work UNIQUE (title, performer_text, release_title, release_year);

-- credited_work_credits: Unique constraint now without credit_detail
ALTER TABLE credited_work_credits
  ADD CONSTRAINT unique_credited_work_credit UNIQUE (credited_work_id, artist_id, role);

-- Step 7: Recreate the dedup index with correct columns
CREATE INDEX idx_credited_works_dedup
  ON credited_works(title, performer_text, release_title, release_year);

-- Step 8: Recreate helper function without removed columns
CREATE OR REPLACE FUNCTION get_artist_credited_works_with_roles(p_artist_id UUID)
RETURNS TABLE (
  work_id UUID,
  title TEXT,
  performer_text TEXT,
  release_title TEXT,
  release_year INTEGER,
  roles TEXT[],
  created_at TIMESTAMP WITH TIME ZONE
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    cw.id,
    cw.title,
    cw.performer_text,
    cw.release_title,
    cw.release_year,
    ARRAY_AGG(DISTINCT cwc.role ORDER BY cwc.role) AS roles,
    cw.created_at
  FROM credited_works cw
  LEFT JOIN credited_work_credits cwc ON cwc.credited_work_id = cw.id
  WHERE cwc.artist_id = p_artist_id
  GROUP BY cw.id, cw.title, cw.performer_text, cw.release_title,
           cw.release_year, cw.created_at
  ORDER BY cw.release_year DESC NULLS LAST, cw.title;
END;
$$ LANGUAGE plpgsql;

-- Note: get_artist_role_summary remains unchanged as it has no dependencies on removed columns

COMMIT;
