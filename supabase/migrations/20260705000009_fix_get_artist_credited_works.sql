-- Fix get_artist_credited_works to work with simplified schema
-- The old function referenced removed columns and wrong join key

CREATE OR REPLACE FUNCTION public.get_artist_credited_works(p_artist_id uuid)
RETURNS TABLE (
    title text,
    performer_name text,
    release_title text,
    release_type text,
    release_year integer,
    category text,
    country text,
    role text,
    recording_id uuid,
    release_id uuid,
    source_url text,
    notes text
)
LANGUAGE sql
STABLE
SET search_path = public
AS $$
    SELECT
        cw.title,
        cw.performer_text as performer_name,
        cw.release_title,
        NULL::text as release_type,
        cw.release_year,
        NULL::text as category,
        NULL::text as country,
        cwc.role,
        NULL::uuid as recording_id,
        NULL::uuid as release_id,
        NULL::text as source_url,
        NULL::text as notes
    FROM public.credited_work_credits cwc
    JOIN public.credited_works cw ON cw.id = cwc.credited_work_id
    WHERE cwc.artist_id = p_artist_id
    ORDER BY cw.release_year DESC NULLS LAST, cw.title ASC, cwc.role ASC;
$$;

GRANT EXECUTE ON FUNCTION public.get_artist_credited_works(uuid) TO anon, authenticated, service_role;
