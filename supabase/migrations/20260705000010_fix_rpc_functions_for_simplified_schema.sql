-- Fix RPC functions to work with simplified schema (removed columns)
-- The old functions tried to SELECT from columns that were deleted in schema cleanup
-- This migration updates them to return NULL for removed columns instead

DROP FUNCTION IF EXISTS get_artist_credited_works_with_roles(uuid);

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

GRANT EXECUTE ON FUNCTION get_artist_credited_works_with_roles(uuid) TO anon, authenticated, service_role;
