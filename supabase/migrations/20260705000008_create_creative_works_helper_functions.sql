-- Phase 4: Helper functions for creative works display
-- These functions support the simplified schema (no recording/release links, no obsolete columns)

CREATE OR REPLACE FUNCTION get_artist_creative_works(p_artist_id uuid)
RETURNS TABLE(
  work_id uuid,
  title text,
  performer_text text,
  release_title text,
  release_year integer,
  roles text[]
)
LANGUAGE sql
STABLE
AS $$
  SELECT
    cw.id as work_id,
    cw.title,
    cw.performer_text,
    cw.release_title,
    cw.release_year,
    ARRAY_AGG(cwc.role ORDER BY cwc.role) as roles
  FROM credited_works cw
  INNER JOIN credited_work_credits cwc ON cwc.credited_work_id = cw.id
  WHERE cwc.artist_id = p_artist_id
  GROUP BY cw.id, cw.title, cw.performer_text, cw.release_title, cw.release_year
  ORDER BY cw.release_year DESC NULLS LAST, cw.title ASC;
$$;

CREATE OR REPLACE FUNCTION get_artist_creative_role_summary(p_artist_id uuid)
RETURNS TABLE(
  role text,
  count bigint
)
LANGUAGE sql
STABLE
AS $$
  SELECT
    cwc.role,
    COUNT(*) as count
  FROM credited_work_credits cwc
  WHERE cwc.artist_id = p_artist_id
  GROUP BY cwc.role
  ORDER BY count DESC, cwc.role ASC;
$$;

-- For backward compatibility with Phase 3, keep old function names
-- But map to new creative works functions
CREATE OR REPLACE FUNCTION get_artist_credited_works_with_roles(p_artist_id uuid)
RETURNS TABLE(
  id uuid,
  title text,
  performer_text text,
  release_title text,
  release_type text,
  release_year integer,
  label text,
  track_number text,
  source_confidence text,
  roles text[],
  created_at timestamptz
)
LANGUAGE sql
STABLE
AS $$
  SELECT
    cw.id,
    cw.title,
    cw.performer_text,
    cw.release_title,
    NULL::text as release_type,
    cw.release_year,
    NULL::text as label,
    NULL::text as track_number,
    NULL::text as source_confidence,
    ARRAY_AGG(cwc.role ORDER BY cwc.role) as roles,
    cw.created_at
  FROM credited_works cw
  INNER JOIN credited_work_credits cwc ON cwc.credited_work_id = cw.id
  WHERE cwc.artist_id = p_artist_id
  GROUP BY cw.id, cw.title, cw.performer_text, cw.release_title, cw.release_year, cw.created_at
  ORDER BY cw.release_year DESC NULLS LAST, cw.title ASC;
$$;

CREATE OR REPLACE FUNCTION get_artist_role_summary(p_artist_id uuid)
RETURNS TABLE(
  role text,
  count bigint
)
LANGUAGE sql
STABLE
AS $$
  SELECT
    cwc.role,
    COUNT(*) as count
  FROM credited_work_credits cwc
  WHERE cwc.artist_id = p_artist_id
  GROUP BY cwc.role
  ORDER BY count DESC, cwc.role ASC;
$$;
