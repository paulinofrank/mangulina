-- ============================================================================
-- Phase A: Helper Functions/RPCs for release_artists
-- ============================================================================
-- These functions provide convenient query patterns for release credits.
-- They can be called from the application as Supabase RPC functions.
-- ============================================================================

-- ============================================================================
-- FUNCTION: get_release_artists
-- ============================================================================
-- Returns all artists credited for a release with relevant details
-- Ordered by display_order and role for consistent presentation
--
-- Usage:
--   SELECT * FROM get_release_artists('release-uuid-here');
-- ============================================================================

CREATE OR REPLACE FUNCTION public.get_release_artists(p_release_id UUID)
RETURNS TABLE (
    artist_id UUID,
    artist_name TEXT,
    artist_slug TEXT,
    role TEXT,
    credited_as TEXT,
    display_order INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        a.id,
        a.name,
        a.slug,
        ra.role,
        ra.credited_as,
        ra.display_order
    FROM public.release_artists ra
    JOIN public.artists a ON a.id = ra.artist_id
    WHERE ra.release_id = p_release_id
    AND a.status = 'published'
    ORDER BY
        COALESCE(ra.display_order, 999),
        CASE ra.role
            WHEN 'primary' THEN 1
            WHEN 'featured' THEN 2
            WHEN 'compilation' THEN 3
            WHEN 'various_artists' THEN 4
            WHEN 'presenter' THEN 5
            ELSE 6
        END,
        a.name;
END;
$$ LANGUAGE plpgsql STABLE;

COMMENT ON FUNCTION public.get_release_artists(UUID) IS
    'Get all artists credited for a release, ordered by display preference and role.';

-- ============================================================================
-- FUNCTION: get_release_artist_credit
-- ============================================================================
-- Get the exact credit text for an artist on a release
-- Returns canonical name if credited_as is null
--
-- Usage:
--   SELECT get_release_artist_credit('release-uuid', 'artist-uuid');
-- ============================================================================

CREATE OR REPLACE FUNCTION public.get_release_artist_credit(
    p_release_id UUID,
    p_artist_id UUID
)
RETURNS TEXT AS $$
DECLARE
    v_credited_as TEXT;
    v_artist_name TEXT;
BEGIN
    -- Get the exact credit text if it exists
    SELECT ra.credited_as INTO v_credited_as
    FROM public.release_artists ra
    WHERE ra.release_id = p_release_id
      AND ra.artist_id = p_artist_id
    LIMIT 1;

    -- If credited_as is null, use canonical artist name
    IF v_credited_as IS NULL THEN
        SELECT a.name INTO v_artist_name
        FROM public.artists a
        WHERE a.id = p_artist_id;
        RETURN v_artist_name;
    ELSE
        RETURN v_credited_as;
    END IF;
END;
$$ LANGUAGE plpgsql STABLE;

COMMENT ON FUNCTION public.get_release_artist_credit(UUID, UUID) IS
    'Get the credit text for an artist on a release (credited_as if set, else canonical name).';

-- ============================================================================
-- FUNCTION: get_artist_releases
-- ============================================================================
-- Get all releases where an artist is credited in any role
-- Useful for artist profile pages to show discography
--
-- Usage:
--   SELECT * FROM get_artist_releases('artist-uuid-here');
-- ============================================================================

CREATE OR REPLACE FUNCTION public.get_artist_releases(p_artist_id UUID)
RETURNS TABLE (
    release_id UUID,
    release_title TEXT,
    release_slug TEXT,
    release_date DATE,
    role TEXT,
    credited_as TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        r.id,
        r.title,
        r.slug,
        r.release_date,
        ra.role,
        ra.credited_as
    FROM public.release_artists ra
    JOIN public.releases r ON r.id = ra.release_id
    WHERE ra.artist_id = p_artist_id
    AND r.status = 'published'
    ORDER BY r.release_date DESC, r.title;
END;
$$ LANGUAGE plpgsql STABLE;

COMMENT ON FUNCTION public.get_artist_releases(UUID) IS
    'Get all releases where an artist is credited, ordered by release date descending.';

-- ============================================================================
-- FUNCTION: get_primary_release_artist
-- ============================================================================
-- Get the primary artist credited for a release (most common case)
-- Returns first primary artist if multiple exist
-- Returns null if no primary artist
--
-- Usage:
--   SELECT get_primary_release_artist('release-uuid-here');
-- ============================================================================

CREATE OR REPLACE FUNCTION public.get_primary_release_artist(p_release_id UUID)
RETURNS UUID AS $$
DECLARE
    v_artist_id UUID;
BEGIN
    SELECT ra.artist_id INTO v_artist_id
    FROM public.release_artists ra
    WHERE ra.release_id = p_release_id
    AND ra.role = 'primary'
    ORDER BY COALESCE(ra.display_order, 0), ra.created_at
    LIMIT 1;

    RETURN v_artist_id;
END;
$$ LANGUAGE plpgsql STABLE;

COMMENT ON FUNCTION public.get_primary_release_artist(UUID) IS
    'Get the primary artist credited for a release (by display_order).';

-- ============================================================================
-- FUNCTION: get_release_credit_count
-- ============================================================================
-- Count credited artists on a release by role
--
-- Usage:
--   SELECT * FROM get_release_credit_count('release-uuid-here');
-- ============================================================================

CREATE OR REPLACE FUNCTION public.get_release_credit_count(p_release_id UUID)
RETURNS TABLE (
    role TEXT,
    artist_count BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        ra.role,
        COUNT(DISTINCT ra.artist_id)::BIGINT
    FROM public.release_artists ra
    WHERE ra.release_id = p_release_id
    GROUP BY ra.role
    ORDER BY ra.role;
END;
$$ LANGUAGE plpgsql STABLE;

COMMENT ON FUNCTION public.get_release_credit_count(UUID) IS
    'Count credited artists on a release, grouped by role.';

-- ============================================================================
-- END HELPER FUNCTIONS
-- ============================================================================
-- These functions are designed to be called as Supabase RPC endpoints
-- from the application layer for efficient release artist queries.
