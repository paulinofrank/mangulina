-- ============================================================================
-- Phase 3C Step 0: Normalize Generic Performer Role
-- ============================================================================
-- Purpose: Replace generic 'performer' role with explicit performer roles
-- before the table grows significantly.
--
-- Current state: 13 rows with role='performer'
-- Action: Migrate to role='lead_performer' (default assumption)
-- Note: Can be manually corrected later if specific knowledge available
--
-- This migration:
-- ✅ Additive to ROLE_DICTIONARY.md
-- ✅ Does not drop existing role
-- ✅ Only updates existing 'performer' rows
-- ✅ Can be reverted if needed
-- ============================================================================

-- ============================================================================
-- UPDATE: Replace 'performer' with 'lead_performer'
-- ============================================================================

UPDATE public.recording_credits
SET role = 'lead_performer'
WHERE role = 'performer';

-- ============================================================================
-- COMMENTS & DOCUMENTATION
-- ============================================================================

COMMENT ON CONSTRAINT recording_credits_role_check ON public.recording_credits IS
    'Validates that role is one of the approved values from ROLE_DICTIONARY.md. '
    'Recording-level roles: lead_performer, featured_performer, guest_performer, instrumentalist, orchestra, choir, vocalist, '
    'guitar, drums, piano, bass, trumpet, saxophone, trombone, strings, horns, percussion, conductor, '
    'producer, engineer, recording_engineer, mixing_engineer, mixing, mastering_engineer, mastering, session_musician, arranger';

-- ============================================================================
-- AUDIT LOG
-- ============================================================================

-- Document the assumption made during normalization
INSERT INTO public.migration_audit_log (
    migration_id,
    action,
    table_name,
    details,
    created_at
) VALUES (
    '20260705000000_normalize_recording_credits_performer_roles',
    'ROLE_NORMALIZATION',
    'recording_credits',
    'Migrated 13 rows from role="performer" to role="lead_performer". This assumes these are primary performers. '
    'Can be manually corrected if specific information becomes available (e.g., featured_performer, guest_performer).',
    NOW()
) ON CONFLICT DO NOTHING;

-- ============================================================================
-- VERIFICATION QUERIES (run after migration)
-- ============================================================================

-- Verify migration success
-- SELECT role, COUNT(*) FROM public.recording_credits GROUP BY role;
-- Expected: No 'performer' role remaining, 13 rows with 'lead_performer'

-- Check if any 'performer' role remains
-- SELECT COUNT(*) as orphaned_rows FROM public.recording_credits
-- WHERE role = 'performer';
-- Expected: 0

-- ============================================================================
-- ROLLBACK INSTRUCTIONS (if needed)
-- ============================================================================
-- If this migration needs to be reverted:
--
-- UPDATE public.recording_credits
-- SET role = 'performer'
-- WHERE role = 'lead_performer'
--   AND created_at < '2026-07-05'::timestamp;
--
-- However, this is NOT recommended. Once normalized, keep the explicit roles.
-- If a row was incorrectly assumed as 'lead_performer', update it to the
-- correct role (featured_performer, guest_performer, etc.) rather than
-- reverting to generic 'performer'.

-- ============================================================================
-- ASSUMPTION DOCUMENTATION
-- ============================================================================
--
-- This migration makes the following assumption:
--
-- ASSUMPTION: All 13 rows with role='performer' are primary performers
-- (lead_performer) on their respective recordings.
--
-- REASON: No other information was available to distinguish between:
-- - lead_performer (primary vocalist/musician)
-- - featured_performer (prominent guest)
-- - guest_performer (one-time appearance)
-- - orchestra (ensemble)
-- - choir (vocal ensemble)
--
-- CONFIDENCE LEVEL: Medium (normalized from generic, not confirmed)
--
-- ACTION IF WRONG: Manually update rows to correct role:
--   UPDATE public.recording_credits
--   SET role = 'featured_performer'  -- or other role
--   WHERE id = '[recording_credit_id]';
--
-- The credit is not lost; it's just re-classified to the correct performer type.

-- ============================================================================
-- END OF MIGRATION
-- ============================================================================
-- This migration:
-- ✅ Normalizes generic roles to explicit performer types
-- ✅ Occurs BEFORE adding credited_as column
-- ✅ Can be audited via this comment block
-- ✅ Maintains data integrity (role still valid)
-- ✅ Enables future role-based queries and analytics
