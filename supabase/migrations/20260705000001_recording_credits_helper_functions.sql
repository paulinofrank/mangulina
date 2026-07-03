-- ============================================================================
-- Phase 3C Step 2: Helper Functions for Recording Performers
-- ============================================================================
-- RPC functions for querying recording performance credits
-- Matches helper function patterns from Phase 3B (release_artists)
-- All functions are STABLE and preserve historical credit text via credited_as
-- ============================================================================

-- ============================================================================
-- 1. get_recording_performers(recording_id UUID)
-- ============================================================================
-- Returns all performers credited on a recording with their details
-- Includes credited_as field for historical accuracy
-- Ordered by display_order (for UI presentation)

CREATE OR REPLACE FUNCTION public.get_recording_performers(
    recording_id UUID
)
RETURNS TABLE (
    artist_id UUID,
    artist_name TEXT,
    artist_slug TEXT,
    role TEXT,
    credited_as TEXT,
    display_order INTEGER
) LANGUAGE SQL STABLE AS $$
SELECT
    rc.artist_id,
    a.name as artist_name,
    a.slug as artist_slug,
    rc.role,
    rc.credited_as,
    rc.display_order
FROM public.recording_credits rc
JOIN public.artists a ON a.id = rc.artist_id
WHERE rc.recording_id = $1
AND a.status = 'published'
ORDER BY
    CASE WHEN rc.display_order IS NULL THEN 999 ELSE rc.display_order END ASC,
    rc.role ASC
$$;

COMMENT ON FUNCTION public.get_recording_performers(UUID) IS
    'Get all performers credited on a recording, ordered by display_order then role. '
    'Only includes published artists. Returns credited_as for historical accuracy.';

-- ============================================================================
-- 2. get_recording_performer_credit(recording_id UUID, artist_id UUID)
-- ============================================================================
-- Returns the exact credit text for a performer on a recording
-- Uses COALESCE(credited_as, artist.name) pattern for accurate display

CREATE OR REPLACE FUNCTION public.get_recording_performer_credit(
    recording_id UUID,
    artist_id UUID
)
RETURNS TEXT LANGUAGE SQL STABLE AS $$
SELECT COALESCE(rc.credited_as, a.name)
FROM public.recording_credits rc
JOIN public.artists a ON a.id = rc.artist_id
WHERE rc.recording_id = $1 AND rc.artist_id = $2
LIMIT 1
$$;

COMMENT ON FUNCTION public.get_recording_performer_credit(UUID, UUID) IS
    'Get the display credit for a performer on a recording. '
    'Returns credited_as if set (historical text), otherwise canonical artist name.';

-- ============================================================================
-- 3. get_recording_performers_by_role(recording_id UUID, role TEXT)
-- ============================================================================
-- Returns all performers in a specific role on a recording
-- Useful for getting all vocalists, all guitarists, orchestras, choirs, etc.

CREATE OR REPLACE FUNCTION public.get_recording_performers_by_role(
    recording_id UUID,
    role TEXT
)
RETURNS TABLE (
    artist_id UUID,
    artist_name TEXT,
    credited_as TEXT,
    display_order INTEGER
) LANGUAGE SQL STABLE AS $$
SELECT
    rc.artist_id,
    a.name as artist_name,
    rc.credited_as,
    rc.display_order
FROM public.recording_credits rc
JOIN public.artists a ON a.id = rc.artist_id
WHERE rc.recording_id = $1
AND rc.role = $2
AND a.status = 'published'
ORDER BY
    CASE WHEN rc.display_order IS NULL THEN 999 ELSE rc.display_order END ASC
$$;

COMMENT ON FUNCTION public.get_recording_performers_by_role(UUID, TEXT) IS
    'Get performers in a specific role (e.g., "vocal", "guitar", "orchestra", "choir") for a recording.';

-- ============================================================================
-- 4. get_artist_recording_credits(artist_id UUID)
-- ============================================================================
-- Returns all recordings an artist performed on (with roles and credited_as)
-- Useful for artist profile pages and performance discographies

CREATE OR REPLACE FUNCTION public.get_artist_recording_credits(
    artist_id UUID
)
RETURNS TABLE (
    recording_id UUID,
    recording_title TEXT,
    role TEXT,
    credited_as TEXT,
    display_order INTEGER,
    created_at TIMESTAMP WITH TIME ZONE
) LANGUAGE SQL STABLE AS $$
SELECT
    r.id as recording_id,
    r.title as recording_title,
    rc.role,
    rc.credited_as,
    rc.display_order,
    rc.created_at
FROM public.recording_credits rc
JOIN public.recordings r ON r.id = rc.recording_id
WHERE rc.artist_id = $1
AND r.status = 'published'
ORDER BY r.created_at DESC, rc.display_order NULLS LAST
$$;

COMMENT ON FUNCTION public.get_artist_recording_credits(UUID) IS
    'Get all recordings a performer/artist is credited on, with roles and historical credit text. '
    'Ordered by recording date (newest first).';

-- ============================================================================
-- 5. get_recording_credit_count(recording_id UUID)
-- ============================================================================
-- Returns count of credits by role for a recording
-- Useful for analytics and determining which roles are present on a recording

CREATE OR REPLACE FUNCTION public.get_recording_credit_count(
    recording_id UUID
)
RETURNS TABLE (
    role TEXT,
    count INTEGER
) LANGUAGE SQL STABLE AS $$
SELECT
    rc.role,
    COUNT(*)::INTEGER as count
FROM public.recording_credits rc
WHERE rc.recording_id = $1
GROUP BY rc.role
ORDER BY count DESC, role ASC
$$;

COMMENT ON FUNCTION public.get_recording_credit_count(UUID) IS
    'Get count of credits by role for a recording (e.g., vocals: 2, guitar: 1, orchestra: 1, etc.). '
    'Useful for UI rendering and analytics.';

-- ============================================================================
-- 6. get_primary_recording_performer(recording_id UUID)
-- ============================================================================
-- Returns primary performer for a recording (usually lead vocalist or main artist)
-- Uses display_order=0 as primary heuristic, then 'vocal' role
-- Falls back to any performer if no clear primary found

CREATE OR REPLACE FUNCTION public.get_primary_recording_performer(
    recording_id UUID
)
RETURNS TABLE (
    artist_id UUID,
    artist_name TEXT,
    credited_as TEXT,
    role TEXT,
    display_order INTEGER
) LANGUAGE SQL STABLE AS $$
SELECT
    rc.artist_id,
    a.name as artist_name,
    rc.credited_as,
    rc.role,
    rc.display_order
FROM public.recording_credits rc
JOIN public.artists a ON a.id = rc.artist_id
WHERE rc.recording_id = $1
AND a.status = 'published'
ORDER BY
    -- Prioritize explicit display_order=0
    CASE WHEN rc.display_order = 0 THEN 0 ELSE 1 END ASC,
    -- Then prioritize vocal roles (lead/featured)
    CASE WHEN rc.role ILIKE '%vocal%' THEN 0 ELSE 1 END ASC,
    -- Then by role name
    rc.role ASC,
    -- Finally by display order
    rc.display_order NULLS LAST
LIMIT 1
$$;

COMMENT ON FUNCTION public.get_primary_recording_performer(UUID) IS
    'Get primary performer for a recording (prioritizes display_order=0, then vocal role). '
    'Returns single row (or NULL if no performers) for use in summary displays.';

-- ============================================================================
-- 7. get_recording_performers_summary(recording_id UUID)
-- ============================================================================
-- Returns a text summary of all performers for display purposes
-- Format: "Artist1 (role1), Artist2 (role2), etc."
-- Uses credited_as when available, artist name otherwise

CREATE OR REPLACE FUNCTION public.get_recording_performers_summary(
    recording_id UUID
)
RETURNS TEXT LANGUAGE SQL STABLE AS $$
SELECT STRING_AGG(
    COALESCE(rc.credited_as, a.name) ||
    CASE WHEN rc.role IS NOT NULL THEN ' (' || rc.role || ')' ELSE '' END,
    ', '
    ORDER BY
        CASE WHEN rc.display_order IS NULL THEN 999 ELSE rc.display_order END ASC,
        rc.role ASC
)
FROM public.recording_credits rc
JOIN public.artists a ON a.id = rc.artist_id
WHERE rc.recording_id = $1
AND a.status = 'published'
$$;

COMMENT ON FUNCTION public.get_recording_performers_summary(UUID) IS
    'Get a text summary of all performers on a recording (e.g., "Luis Díaz (vocal), Pedro García (guitar)"). '
    'Uses credited_as for historical accuracy when available.';

-- ============================================================================
-- END OF HELPER FUNCTIONS
-- ============================================================================
-- All functions:
-- ✅ Use STABLE designation for query optimization
-- ✅ Preserve historical credit text via credited_as field
-- ✅ Follow same patterns as Phase 3B (release_artists) helpers
-- ✅ Include published status checks for security
-- ✅ Are read-only (no INSERT/UPDATE/DELETE)
