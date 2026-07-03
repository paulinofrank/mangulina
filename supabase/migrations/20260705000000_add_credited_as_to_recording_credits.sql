-- ============================================================================
-- Phase 3C Step 1: Add credited_as to recording_credits table
-- ============================================================================
-- Purpose: Preserve exact historical credit text for recording performers
-- (e.g., "Luis Díaz (vocal)" instead of just "Luis Díaz")
--
-- The recording_credits table credits actual performers on a recording.
-- The credited_as field stores exact credit text as released/documented.
--
-- This is a PERFORMANCE CREDIT (recording level), distinct from:
-- - Creative credits (who wrote/composed the work)
-- - Release credits (who is credited for the album)
--
-- Migration follows ADR-006 (Backward Compatibility) and ADR-007 (Additive).
-- ============================================================================

-- ============================================================================
-- ALTER TABLE: Add credited_as column to recording_credits
-- ============================================================================

ALTER TABLE public.recording_credits
ADD COLUMN credited_as TEXT;

-- Add constraint to prevent empty strings
ALTER TABLE public.recording_credits
ADD CONSTRAINT recording_credits_credited_as_check
    CHECK (credited_as IS NULL OR length(trim(credited_as)) > 0);

-- ============================================================================
-- UPDATE table comments for clarity
-- ============================================================================

COMMENT ON TABLE public.recording_credits IS
    'Credits actual performers on a recording (vocalist, guitarist, engineer, producer). '
    'This is PERFORMANCE CREDIT level, distinct from creative credits (work) and release credits. '
    'Role indicates type of performance: vocal, guitar, drums, orchestra, choir, producer, engineer, etc. '
    'credited_as preserves exact historical credit text separately from canonical artist name.';

COMMENT ON COLUMN public.recording_credits.credited_as IS
    'Exact credit text as released/documented (e.g., "Luis Díaz (vocal)"). '
    'Null means use artist canonical name. Preserves historical accuracy.';

-- ============================================================================
-- END OF MIGRATION
-- ============================================================================
-- This migration:
-- ✅ Is additive only (no drops, no renames)
-- ✅ Preserves all existing data
-- ✅ Is backward compatible
-- ✅ Follows Phase 3B (release_artists) precedent
-- ✅ Matches EDITORIAL_GUIDELINES.md (preserve exact credits)
