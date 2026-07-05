-- Phase 4: Create credited_works and credited_work_credits tables
-- For documenting creative contributions (production, composition, arrangement, engineering, etc.)
-- across the Dominican and Latin music landscape.
-- This schema is independent of recordings, releases, and release_artists tables.
-- No existing recording/release data is modified or deleted.

-- Table: credited_works
-- Stores one row per unique creative work where an artist had a role.
-- Deduplication key: (title, performer_text, release_title, release_year, track_number)
CREATE TABLE IF NOT EXISTS credited_works (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Editorial facts about the work
  title TEXT NOT NULL,
  performer_text TEXT, -- Performer(s) as credited in the release
  release_title TEXT,
  release_type TEXT, -- "Studio Album", "Compilation Album", "Soundtrack Album", "Single", etc.
  release_year INTEGER,
  label TEXT,
  track_number TEXT, -- May be "01", "ALL", "Single", etc.

  -- Editorial metadata
  source_confidence TEXT, -- "High", "Medium", "Low" with source notes

  -- Timestamps
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  -- Constraint: Unique work per (title, performer, release, year, track)
  CONSTRAINT unique_credited_work UNIQUE (title, performer_text, release_title, release_year, track_number)
);

-- Index for fast lookup during import
CREATE INDEX IF NOT EXISTS idx_credited_works_dedup
  ON credited_works(title, performer_text, release_title, release_year, track_number);

-- Index for fast lookup by release
CREATE INDEX IF NOT EXISTS idx_credited_works_release
  ON credited_works(release_title, release_year);

-- Table: credited_work_credits
-- Stores one row per artist contribution to a work.
-- One work can have multiple credits (different roles).
-- Example: Luny Tunes as Producer, Composer, and Arranger on same track.
CREATE TABLE IF NOT EXISTS credited_work_credits (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Foreign key to work
  credited_work_id UUID NOT NULL REFERENCES credited_works(id) ON DELETE CASCADE,

  -- Artist who made the contribution
  artist_id UUID NOT NULL REFERENCES artists(id) ON DELETE CASCADE,

  -- Role in this contribution
  -- Normalized values: Producer, Co-Producer, Executive Producer, Composer, Arranger,
  -- Mix Engineer, Mastering Engineer, Beat Programmer, Remixer, etc.
  role TEXT NOT NULL,

  -- Detailed credit text from source
  credit_detail TEXT,

  -- Co-credits (other people involved in this role)
  co_credits TEXT,

  -- Editorial metadata
  source_confidence TEXT, -- "High", "Medium", "Low" with source notes

  -- Timestamps
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  -- Constraint: One credit per (work, artist, role, detail)
  CONSTRAINT unique_credited_work_credit UNIQUE (credited_work_id, artist_id, role, credit_detail)
);

-- Index for fast lookup
CREATE INDEX IF NOT EXISTS idx_credited_work_credits_work
  ON credited_work_credits(credited_work_id);

CREATE INDEX IF NOT EXISTS idx_credited_work_credits_artist
  ON credited_work_credits(artist_id);

CREATE INDEX IF NOT EXISTS idx_credited_work_credits_role
  ON credited_work_credits(role);

-- Index for role aggregation (counting roles per artist)
CREATE INDEX IF NOT EXISTS idx_credited_work_credits_artist_role
  ON credited_work_credits(artist_id, role);

-- Row-level security: Editorial portfolios are public for reading
-- (Editorial data is part of public artist information)
-- Writes are restricted to authenticated users with appropriate permissions
ALTER TABLE credited_works ENABLE ROW LEVEL SECURITY;
ALTER TABLE credited_work_credits ENABLE ROW LEVEL SECURITY;

-- Public SELECT: Anyone can read editorial portfolios
CREATE POLICY credited_works_select_public
  ON credited_works
  FOR SELECT
  USING (TRUE);

-- Admin/service-role write: Only authenticated with service role
CREATE POLICY credited_works_insert_admin
  ON credited_works
  FOR INSERT
  WITH CHECK (auth.role() = 'service_role');

CREATE POLICY credited_works_update_admin
  ON credited_works
  FOR UPDATE
  USING (auth.role() = 'service_role');

-- Public SELECT: Anyone can read credits
CREATE POLICY credited_work_credits_select_public
  ON credited_work_credits
  FOR SELECT
  USING (TRUE);

-- Admin/service-role write: Only authenticated with service role
CREATE POLICY credited_work_credits_insert_admin
  ON credited_work_credits
  FOR INSERT
  WITH CHECK (auth.role() = 'service_role');

CREATE POLICY credited_work_credits_update_admin
  ON credited_work_credits
  FOR UPDATE
  USING (auth.role() = 'service_role');

-- Trigger to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_credited_works_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Drop existing triggers if they exist (to recreate cleanly)
DROP TRIGGER IF EXISTS credited_works_update_timestamp ON credited_works;
DROP TRIGGER IF EXISTS credited_work_credits_update_timestamp ON credited_work_credits;

-- Create triggers
CREATE TRIGGER credited_works_update_timestamp
  BEFORE UPDATE ON credited_works
  FOR EACH ROW
  EXECUTE FUNCTION update_credited_works_timestamp();

CREATE TRIGGER credited_work_credits_update_timestamp
  BEFORE UPDATE ON credited_work_credits
  FOR EACH ROW
  EXECUTE FUNCTION update_credited_works_timestamp();

-- Helper function: Get all credited works for an artist with all roles aggregated
-- Safe to call multiple times (CREATE OR REPLACE)
CREATE OR REPLACE FUNCTION get_artist_credited_works_with_roles(p_artist_id UUID)
RETURNS TABLE (
  work_id UUID,
  title TEXT,
  performer_text TEXT,
  release_title TEXT,
  release_type TEXT,
  release_year INTEGER,
  label TEXT,
  track_number TEXT,
  source_confidence TEXT,
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
    cw.release_type,
    cw.release_year,
    cw.label,
    cw.track_number,
    cw.source_confidence,
    ARRAY_AGG(DISTINCT cwc.role ORDER BY cwc.role) AS roles,
    cw.created_at
  FROM credited_works cw
  LEFT JOIN credited_work_credits cwc ON cwc.credited_work_id = cw.id
  WHERE cwc.artist_id = p_artist_id
  GROUP BY cw.id, cw.title, cw.performer_text, cw.release_title,
           cw.release_type, cw.release_year, cw.label, cw.track_number,
           cw.source_confidence, cw.created_at
  ORDER BY cw.release_year DESC NULLS LAST, cw.title;
END;
$$ LANGUAGE plpgsql;

-- Helper function: Get role summary for an artist
CREATE OR REPLACE FUNCTION get_artist_role_summary(p_artist_id UUID)
RETURNS TABLE (
  role TEXT,
  count BIGINT
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    cwc.role,
    COUNT(DISTINCT cwc.credited_work_id) AS count
  FROM credited_work_credits cwc
  WHERE cwc.artist_id = p_artist_id
  GROUP BY cwc.role
  ORDER BY count DESC, role;
END;
$$ LANGUAGE plpgsql;
