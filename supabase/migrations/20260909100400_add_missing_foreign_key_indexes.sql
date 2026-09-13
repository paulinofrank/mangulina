-- Fix: 51 foreign keys had no covering index.
--
-- An unindexed FK makes the child side of every join a sequential scan and
-- makes ON DELETE/ON UPDATE on the parent scan the whole child table.
--
-- Two of these are on hot paths and are the reason this migration is worth
-- more than advisor hygiene:
--   * releases.release_artist_id -- the legacy discography link. Because the
--     release_artists RLS policy matched nothing (see 20260909100000), every
--     public release lookup fell through to this column, unindexed, 3163 rows.
--   * recordings.subgenre_id -- now read by get_related_songs (20260909100100)
--     on every song page.
--
-- The rest are editorial_* and redirect tables that are small today. The index
-- cost on a small table is negligible and these tables are designed to grow;
-- indexing the FK now avoids a silent regression later. Note that they will
-- appear in the next advisor run as "unused indexes" until traffic reaches
-- them -- that is expected, not a defect.

CREATE INDEX IF NOT EXISTS idx_admin_invites_created_by ON public.admin_invites (created_by);
CREATE INDEX IF NOT EXISTS idx_admin_members_invited_by ON public.admin_members (invited_by);
CREATE INDEX IF NOT EXISTS idx_artist_redirects_canonical_artist_id ON public.artist_redirects (canonical_artist_id);
CREATE INDEX IF NOT EXISTS idx_artist_redirects_decision_id ON public.artist_redirects (decision_id);
CREATE INDEX IF NOT EXISTS idx_credit_role_aliases_role_id ON public.credit_role_aliases (role_id);
CREATE INDEX IF NOT EXISTS idx_cultural_notes_recording_id ON public.cultural_notes (recording_id);
CREATE INDEX IF NOT EXISTS idx_editorial_assertion_evidence_created_by ON public.editorial_assertion_evidence (created_by);
CREATE INDEX IF NOT EXISTS idx_editorial_assertion_external_contributors_external_contribu ON public.editorial_assertion_external_contributors (external_contributor_id);
CREATE INDEX IF NOT EXISTS idx_editorial_assertion_isrcs_recording_isrc_id ON public.editorial_assertion_isrcs (recording_isrc_id);
CREATE INDEX IF NOT EXISTS idx_editorial_assertion_recording_credits_recording_credit_id ON public.editorial_assertion_recording_credits (recording_credit_id);
CREATE INDEX IF NOT EXISTS idx_editorial_assertion_recording_work_targets_work_id ON public.editorial_assertion_recording_work_targets (work_id);
CREATE INDEX IF NOT EXISTS idx_editorial_assertion_work_credits_work_credit_id ON public.editorial_assertion_work_credits (work_credit_id);
CREATE INDEX IF NOT EXISTS idx_editorial_assertions_created_by ON public.editorial_assertions (created_by);
CREATE INDEX IF NOT EXISTS idx_editorial_assertions_reviewed_by ON public.editorial_assertions (reviewed_by);
CREATE INDEX IF NOT EXISTS idx_editorial_assertions_supersedes_assertion_id ON public.editorial_assertions (supersedes_assertion_id);
CREATE INDEX IF NOT EXISTS idx_editorial_audit_events_actor_user_id ON public.editorial_audit_events (actor_user_id);
CREATE INDEX IF NOT EXISTS idx_editorial_audit_events_decision_id ON public.editorial_audit_events (decision_id);
CREATE INDEX IF NOT EXISTS idx_editorial_case_assertions_assertion_id ON public.editorial_case_assertions (assertion_id);
CREATE INDEX IF NOT EXISTS idx_editorial_case_isrcs_recording_isrc_id ON public.editorial_case_isrcs (recording_isrc_id);
CREATE INDEX IF NOT EXISTS idx_editorial_case_recordings_recording_id ON public.editorial_case_recordings (recording_id);
CREATE INDEX IF NOT EXISTS idx_editorial_case_works_work_id ON public.editorial_case_works (work_id);
CREATE INDEX IF NOT EXISTS idx_editorial_cases_assigned_to ON public.editorial_cases (assigned_to);
CREATE INDEX IF NOT EXISTS idx_editorial_cases_opened_by ON public.editorial_cases (opened_by);
CREATE INDEX IF NOT EXISTS idx_editorial_cases_resolved_by ON public.editorial_cases (resolved_by);
CREATE INDEX IF NOT EXISTS idx_editorial_decision_assertions_assertion_id ON public.editorial_decision_assertions (assertion_id);
CREATE INDEX IF NOT EXISTS idx_editorial_decisions_approved_by ON public.editorial_decisions (approved_by);
CREATE INDEX IF NOT EXISTS idx_editorial_decisions_decided_by ON public.editorial_decisions (decided_by);
CREATE INDEX IF NOT EXISTS idx_editorial_decisions_requested_by ON public.editorial_decisions (requested_by);
CREATE INDEX IF NOT EXISTS idx_editorial_decisions_reverses_decision_id ON public.editorial_decisions (reverses_decision_id);
CREATE INDEX IF NOT EXISTS idx_editorial_isrc_findings_created_by ON public.editorial_isrc_findings (created_by);
CREATE INDEX IF NOT EXISTS idx_editorial_role_capabilities_capability ON public.editorial_role_capabilities (capability);
CREATE INDEX IF NOT EXISTS idx_editorial_sources_created_by ON public.editorial_sources (created_by);
CREATE INDEX IF NOT EXISTS idx_external_contributors_created_by ON public.external_contributors (created_by);
CREATE INDEX IF NOT EXISTS idx_featured_artist_artist_id ON public.featured_artist (artist_id);
CREATE INDEX IF NOT EXISTS idx_lyrics_recording_id ON public.lyrics (recording_id);
CREATE INDEX IF NOT EXISTS idx_recording_expressions_expression_id ON public.recording_expressions (expression_id);
CREATE INDEX IF NOT EXISTS idx_recording_expressions_recording_id ON public.recording_expressions (recording_id);
CREATE INDEX IF NOT EXISTS idx_recording_isrc_sources_source_id ON public.recording_isrc_sources (source_id);
CREATE INDEX IF NOT EXISTS idx_recording_locations_location_id ON public.recording_locations (location_id);
CREATE INDEX IF NOT EXISTS idx_recording_media_source_id ON public.recording_media (source_id);
CREATE INDEX IF NOT EXISTS idx_recording_redirects_canonical_recording_id ON public.recording_redirects (canonical_recording_id);
CREATE INDEX IF NOT EXISTS idx_recording_redirects_decision_id ON public.recording_redirects (decision_id);
CREATE INDEX IF NOT EXISTS idx_recording_relationships_source_id ON public.recording_relationships (source_id);
CREATE INDEX IF NOT EXISTS idx_recordings_subgenre_id ON public.recordings (subgenre_id);
CREATE INDEX IF NOT EXISTS idx_releases_release_artist_id ON public.releases (release_artist_id);
CREATE INDEX IF NOT EXISTS idx_translations_recording_id ON public.translations (recording_id);
CREATE INDEX IF NOT EXISTS idx_work_credit_sources_source_id ON public.work_credit_sources (source_id);
CREATE INDEX IF NOT EXISTS idx_work_credits_external_contributor_id ON public.work_credits (external_contributor_id);
CREATE INDEX IF NOT EXISTS idx_work_credits_role_id ON public.work_credits (role_id);
CREATE INDEX IF NOT EXISTS idx_work_redirects_canonical_work_id ON public.work_redirects (canonical_work_id);
CREATE INDEX IF NOT EXISTS idx_work_redirects_decision_id ON public.work_redirects (decision_id);

-- DOWN (manual rollback): DROP INDEX IF EXISTS public.<name>; for each above.
