-- Step 1: Create credited_works table
CREATE TABLE IF NOT EXISTS credited_works (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  performer_text TEXT,
  release_title TEXT,
  release_type TEXT,
  release_year INTEGER,
  label TEXT,
  track_number TEXT,
  source_confidence TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  CONSTRAINT unique_credited_work UNIQUE (title, performer_text, release_title, release_year, track_number)
);

-- Step 2: Create indexes for credited_works
CREATE INDEX IF NOT EXISTS idx_credited_works_dedup
  ON credited_works(title, performer_text, release_title, release_year, track_number);

CREATE INDEX IF NOT EXISTS idx_credited_works_release
  ON credited_works(release_title, release_year);

-- Step 3: Create credited_work_credits table
CREATE TABLE IF NOT EXISTS credited_work_credits (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  credited_work_id UUID NOT NULL REFERENCES credited_works(id) ON DELETE CASCADE,
  artist_id UUID NOT NULL REFERENCES artists(id) ON DELETE CASCADE,
  role TEXT NOT NULL,
  credit_detail TEXT,
  co_credits TEXT,
  source_confidence TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  CONSTRAINT unique_credited_work_credit UNIQUE (credited_work_id, artist_id, role, credit_detail)
);

-- Step 4: Create indexes for credited_work_credits
CREATE INDEX IF NOT EXISTS idx_credited_work_credits_work
  ON credited_work_credits(credited_work_id);

CREATE INDEX IF NOT EXISTS idx_credited_work_credits_artist
  ON credited_work_credits(artist_id);

CREATE INDEX IF NOT EXISTS idx_credited_work_credits_role
  ON credited_work_credits(role);

CREATE INDEX IF NOT EXISTS idx_credited_work_credits_artist_role
  ON credited_work_credits(artist_id, role);

-- Step 5: Enable RLS
ALTER TABLE credited_works ENABLE ROW LEVEL SECURITY;
ALTER TABLE credited_work_credits ENABLE ROW LEVEL SECURITY;

-- Step 6: Create RLS policies
CREATE POLICY credited_works_select_public ON credited_works FOR SELECT USING (TRUE);
CREATE POLICY credited_works_insert_admin ON credited_works FOR INSERT WITH CHECK (auth.role() = 'service_role');
CREATE POLICY credited_works_update_admin ON credited_works FOR UPDATE USING (auth.role() = 'service_role');

CREATE POLICY credited_work_credits_select_public ON credited_work_credits FOR SELECT USING (TRUE);
CREATE POLICY credited_work_credits_insert_admin ON credited_work_credits FOR INSERT WITH CHECK (auth.role() = 'service_role');
CREATE POLICY credited_work_credits_update_admin ON credited_work_credits FOR UPDATE USING (auth.role() = 'service_role');

-- Step 7: Create timestamp update function
CREATE OR REPLACE FUNCTION update_credited_works_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Step 8: Drop old triggers if they exist
DROP TRIGGER IF EXISTS credited_works_update_timestamp ON credited_works;
DROP TRIGGER IF EXISTS credited_work_credits_update_timestamp ON credited_work_credits;

-- Step 9: Create triggers
CREATE TRIGGER credited_works_update_timestamp
  BEFORE UPDATE ON credited_works
  FOR EACH ROW
  EXECUTE FUNCTION update_credited_works_timestamp();

CREATE TRIGGER credited_work_credits_update_timestamp
  BEFORE UPDATE ON credited_work_credits
  FOR EACH ROW
  EXECUTE FUNCTION update_credited_works_timestamp();

-- Step 10: Create helper function - get works with roles
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

-- Step 11: Create helper function - role summary
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
