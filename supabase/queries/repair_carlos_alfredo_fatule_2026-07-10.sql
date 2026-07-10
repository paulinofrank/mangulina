-- ============================================================================
-- REPAIR SCRIPT: Carlos Alfredo Fatule duplicate-artist reassignment
-- Date: 2026-07-10
-- ============================================================================
-- Context:
--   Correct artist:   Carlos Alfredo Fatule  214e98cc-cac9-4473-9741-2a87481b0685
--   Duplicate artist: Carlos Alfredo         38c943f3-6ab4-4302-a53b-ef5e31cf3f09
--
--   The release "Merengue clásico" (9e94fe91-d264-48c1-bed8-cc2cfcc3d4e3) was
--   manually moved from the duplicate to the correct artist before the
--   transactional reassign_release_primary_artist() RPC existed.
--
-- Investigation findings (2026-07-10, read-only):
--   * releases.release_artist_id, the primary release_artists row
--     (credited_as 'Carlos Alfredo' preserved), all 7 tracks, all 7
--     recordings (artist_id + release_id), and all 7 lead_performer
--     recording_credits ALREADY point at the correct artist.
--   * The duplicate artist has ZERO remaining references in any table with an
--     artists FK (artist_awards, artist_credits, artist_media,
--     artist_occupations, artist_relationships, artist_view_events,
--     credited_work_credits, featured_artist, recording_credits, recordings,
--     release_artists, releases).
--   * The only remaining data blemish: releases.type = 'album' (lowercase).
--     Site convention (release_groups.primary_type and messages keys) is
--     'Album'. The lowercase value is what made the profile Discography
--     render an empty section before the UI grouping fix.
--
-- This script is scoped to the two artist IDs above, is idempotent, and does
-- NOT delete the duplicate artist. Run PART 1 first and review before PART 2.
-- ============================================================================

-- ============================================================================
-- PART 1 — READ-ONLY PREVIEW (run first, review output)
-- ============================================================================

-- 1a. Both artist rows
SELECT id, name, slug, status
FROM artists
WHERE id IN ('214e98cc-cac9-4473-9741-2a87481b0685',
             '38c943f3-6ab4-4302-a53b-ef5e31cf3f09');

-- 1b. Rows PART 2 would change (expected: exactly one row, type = 'album')
SELECT id, title, type, release_artist_id
FROM releases
WHERE release_artist_id = '214e98cc-cac9-4473-9741-2a87481b0685'
  AND type IS NOT NULL
  AND type <> 'Album'
  AND lower(type) = 'album';

-- 1c. Confirm nothing anywhere still references the duplicate artist
SELECT 'artist_awards' AS table_name, count(*) AS rows_referencing_duplicate FROM artist_awards WHERE artist_id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09'
UNION ALL SELECT 'artist_credits', count(*) FROM artist_credits WHERE artist_id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09'
UNION ALL SELECT 'artist_media', count(*) FROM artist_media WHERE artist_id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09'
UNION ALL SELECT 'artist_occupations', count(*) FROM artist_occupations WHERE artist_id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09'
UNION ALL SELECT 'artist_relationships (source)', count(*) FROM artist_relationships WHERE source_artist_id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09'
UNION ALL SELECT 'artist_relationships (target)', count(*) FROM artist_relationships WHERE target_artist_id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09'
UNION ALL SELECT 'artist_view_events', count(*) FROM artist_view_events WHERE artist_id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09'
UNION ALL SELECT 'credited_work_credits', count(*) FROM credited_work_credits WHERE artist_id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09'
UNION ALL SELECT 'featured_artist', count(*) FROM featured_artist WHERE artist_id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09'
UNION ALL SELECT 'recording_credits', count(*) FROM recording_credits WHERE artist_id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09'
UNION ALL SELECT 'recordings', count(*) FROM recordings WHERE artist_id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09'
UNION ALL SELECT 'release_artists', count(*) FROM release_artists WHERE artist_id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09'
UNION ALL SELECT 'releases (legacy column)', count(*) FROM releases WHERE release_artist_id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09'
ORDER BY 1;

-- 1d. Full unit view of the reassigned release
SELECT r.id AS release_id, r.title, r.type, r.release_artist_id,
       t.id AS track_id, t.position,
       rec.id AS recording_id, rec.title AS recording_title,
       rec.artist_id AS recording_artist_id, rec.release_id AS recording_release_id
FROM releases r
LEFT JOIN tracks t ON t.release_id = r.id
LEFT JOIN recordings rec ON rec.id = t.recording_id
WHERE r.id = '9e94fe91-d264-48c1-bed8-cc2cfcc3d4e3'
ORDER BY t.position;

-- ============================================================================
-- PART 2 — REPAIR (idempotent; safe to run more than once)
-- ============================================================================
-- Normalize the release type casing so it matches site convention. Scoped to
-- the correct artist's releases only. Historical credit text (credited_as =
-- 'Carlos Alfredo') is intentionally NOT modified: it preserves the credit as
-- released, per docs/DATA_GOVERNANCE.md.

BEGIN;

UPDATE releases
SET type = 'Album',
    updated_at = now()
WHERE release_artist_id = '214e98cc-cac9-4473-9741-2a87481b0685'
  AND type IS NOT NULL
  AND type <> 'Album'
  AND lower(type) = 'album';

COMMIT;

-- NOTE: the duplicate artist row is intentionally left in place. Once you are
-- satisfied the merge is complete, the editorial follow-up (manual decision,
-- not part of this repair) would be to hide it from public pages:
--   -- UPDATE artists SET status = 'duplicate'
--   -- WHERE id = '38c943f3-6ab4-4302-a53b-ef5e31cf3f09';

-- ============================================================================
-- PART 3 — VERIFICATION (run after PART 2)
-- ============================================================================

-- 3a. Discography RPC for the CORRECT artist (expect 7 track rows for
--     "Merengue clásico", release_type 'Album')
SELECT release_id, release_title, release_year, release_type,
       track_number, recording_title
FROM get_artist_discography('214e98cc-cac9-4473-9741-2a87481b0685'::uuid)
ORDER BY track_number;

-- 3b. Discography RPC for the DUPLICATE artist (expect 0 rows)
SELECT count(*) AS duplicate_artist_discography_rows
FROM get_artist_discography('38c943f3-6ab4-4302-a53b-ef5e31cf3f09'::uuid);

-- 3c. Release credit rows (expect one primary row for the correct artist,
--     credited_as 'Carlos Alfredo' preserved)
SELECT * FROM get_release_artists('9e94fe91-d264-48c1-bed8-cc2cfcc3d4e3'::uuid);
