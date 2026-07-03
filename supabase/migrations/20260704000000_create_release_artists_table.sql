-- ============================================================================
-- Phase 3: Create release_artists table
-- ============================================================================
-- Purpose: Replace releases.release_artist_id with normalized release-level
-- credits table per ADR-004 (Three-Level Credit Architecture)
--
-- This table credits artists for a release (album/single/EP as a product)
-- Distinct from:
-- - recording_credits (who performed on a specific recording)
-- - credited_work_credits (who created/composed a work)
--
-- Migration follows ADR-006 (Backward Compatibility) and ADR-007 (Additive)
-- Legacy field releases.release_artist_id remains active during transition.
-- ============================================================================

-- ============================================================================
-- TRIGGER FUNCTION: update_timestamp
-- ============================================================================
-- Creates or updates the update_timestamp trigger function if it doesn't exist

CREATE OR REPLACE FUNCTION public.update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- CREATE TABLE: release_artists
-- ============================================================================

CREATE TABLE public.release_artists (
    id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    release_id UUID NOT NULL REFERENCES public.releases(id) ON DELETE CASCADE,
    artist_id UUID NOT NULL REFERENCES public.artists(id) ON DELETE RESTRICT,
    role TEXT NOT NULL CHECK (role IN (
        'primary',
        'featured',
        'compilation',
        'various_artists',
        'presenter'
    )),
    credited_as TEXT,
    display_order INTEGER,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),

    -- Prevent duplicate credits for the same artist in the same role
    UNIQUE (release_id, artist_id, role)
);

-- ============================================================================
-- INDEXES
-- ============================================================================

CREATE INDEX idx_release_artists_release_id ON public.release_artists(release_id);
CREATE INDEX idx_release_artists_artist_id ON public.release_artists(artist_id);
CREATE INDEX idx_release_artists_role ON public.release_artists(role);

-- ============================================================================
-- RLS POLICIES
-- ============================================================================

ALTER TABLE public.release_artists ENABLE ROW LEVEL SECURITY;

-- Allow public to read artists from published releases
CREATE POLICY release_artists_select_published ON public.release_artists
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM public.releases
            WHERE releases.id = release_artists.release_id
            AND releases.status = 'published'
        )
    );

-- Allow authenticated users to read all release_artists
CREATE POLICY release_artists_select_authenticated ON public.release_artists
    FOR SELECT
    TO authenticated
    USING (true);

-- Allow admin to manage release_artists
CREATE POLICY release_artists_manage_admin ON public.release_artists
    FOR ALL
    TO authenticated
    USING (auth.jwt()->>'role' = 'admin')
    WITH CHECK (auth.jwt()->>'role' = 'admin');

-- ============================================================================
-- TRIGGER: Auto-update updated_at
-- ============================================================================

CREATE TRIGGER release_artists_update_timestamp
    BEFORE UPDATE ON public.release_artists
    FOR EACH ROW
    EXECUTE FUNCTION public.update_timestamp();

-- ============================================================================
-- BACKFILL: Populate from releases.release_artist_id
-- ============================================================================

INSERT INTO public.release_artists (release_id, artist_id, role, display_order, created_at)
SELECT
    id as release_id,
    release_artist_id as artist_id,
    'primary' as role,
    0 as display_order,
    NOW() as created_at
FROM public.releases
WHERE release_artist_id IS NOT NULL
ON CONFLICT (release_id, artist_id, role) DO NOTHING;

-- ============================================================================
-- COMMENTS
-- ============================================================================

COMMENT ON TABLE public.release_artists IS
    'Credits artists for a release (album/single/EP as a product). '
    'Role indicates type of credit: primary, featured, compilation, various_artists, or presenter. '
    'credited_as preserves exact historical credit text (e.g., "Juan Luis Guerra y 4.40") separately from canonical artist name.';

COMMENT ON COLUMN public.release_artists.credited_as IS
    'Exact credit text as released (e.g., "Juan Luis Guerra y 4.40"). Null means use artist canonical name.';

COMMENT ON COLUMN public.release_artists.display_order IS
    'Order for display on release page. Null sorts to end.';
