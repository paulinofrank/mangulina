-- ============================================================================
-- FUNCTION: reassign_release_primary_artist
-- ============================================================================
-- Atomically moves the PRIMARY artist of a release from one artist to another,
-- keeping the release, its tracks, its recordings, and its primary performer
-- credits together as one discography unit.
--
-- Why a single RPC instead of client-side updates:
-- The primary-artist association is denormalized across three places that must
-- stay in sync for the discography to render:
--   1. releases.release_artist_id   (legacy column; still authoritative — both
--      get_artist_discography() and the profile discography summaries filter
--      releases by this column)
--   2. release_artists role='primary' (canonical credit table, Phase 3A)
--   3. recordings.artist_id          (denormalized primary performer; drives
--      song pages, genre pages, year archives, trending)
--   plus recording_credits rows whose role represents the primary performer.
-- The previous admin flow updated (1) and (2) in separate non-atomic requests
-- and never touched (3) or the credits, which orphaned discographies when a
-- release was moved between artists (e.g. duplicate-artist cleanup).
--
-- What it deliberately does NOT touch:
--   * tracks (they belong to the release, not the artist)
--   * release_artists rows in other roles (featured / compilation /
--     various_artists / presenter) for either artist
--   * recording_credits in creative or non-primary roles (composer, producer,
--     songwriter, lyricist, featured_performer, guest_performer, musicians...)
--   * recordings whose primary artist is a different artist (protects
--     compilations and multi-artist releases)
--   * recordings canonically owned by a different release
--     (recordings.release_id points elsewhere) — protects recordings shared
--     across releases from being reassigned globally
--
-- Primary performer roles in recording_credits: 'lead_performer' plus the
-- legacy generic 'performer' (see docs/ROLE_DICTIONARY.md). Both mirror the
-- recording's primary association, so both follow the reassignment; every
-- other role is preserved untouched. credited_as (historical credit text) is
-- always preserved.
--
-- Runs in a single transaction (plpgsql function body): any failure rolls the
-- whole operation back. Returns a jsonb summary of affected row counts.
--
-- Usage:
--   SELECT reassign_release_primary_artist(
--     'release-uuid', 'old-artist-uuid', 'new-artist-uuid');
-- ============================================================================

CREATE OR REPLACE FUNCTION public.reassign_release_primary_artist(
    p_release_id uuid,
    p_old_artist_id uuid,
    p_new_artist_id uuid
)
RETURNS jsonb
LANGUAGE plpgsql
SET search_path = public
AS $$
DECLARE
    v_release_artist_id uuid;
    v_track_count integer := 0;
    v_legacy_updated integer := 0;
    v_release_artists_updated integer := 0;
    v_release_artists_deleted integer := 0;
    v_release_artists_inserted integer := 0;
    v_recordings_updated integer := 0;
    v_credits_updated integer := 0;
    v_credits_merged integer := 0;
    v_recording_ids uuid[];
    v_old_was_primary boolean;
BEGIN
    IF p_release_id IS NULL OR p_old_artist_id IS NULL OR p_new_artist_id IS NULL THEN
        RAISE EXCEPTION 'reassign_release_primary_artist: release id, old artist id and new artist id are all required';
    END IF;

    -- Lock the release row for the duration of the reassignment.
    SELECT release_artist_id INTO v_release_artist_id
    FROM releases
    WHERE id = p_release_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'reassign_release_primary_artist: release % does not exist', p_release_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM artists WHERE id = p_new_artist_id) THEN
        RAISE EXCEPTION 'reassign_release_primary_artist: new artist % does not exist', p_new_artist_id;
    END IF;

    SELECT count(*) INTO v_track_count FROM tracks WHERE release_id = p_release_id;

    -- Identical ids: nothing to do, report a successful no-op.
    IF p_old_artist_id = p_new_artist_id THEN
        RETURN jsonb_build_object(
            'ok', true,
            'noop', true,
            'release_id', p_release_id,
            'tracks_seen', v_track_count,
            'legacy_release_artist_updated', 0,
            'release_artists_updated', 0,
            'release_artists_deleted', 0,
            'release_artists_inserted', 0,
            'recordings_updated', 0,
            'recording_credits_updated', 0,
            'recording_credits_merged', 0
        );
    END IF;

    -- The old artist must actually hold the primary association, via the
    -- legacy column and/or a primary release_artists row. A featured artist
    -- cannot be "reassigned" through this function.
    v_old_was_primary :=
        v_release_artist_id = p_old_artist_id
        OR EXISTS (
            SELECT 1 FROM release_artists
            WHERE release_id = p_release_id
              AND artist_id = p_old_artist_id
              AND role = 'primary'
        );

    IF NOT v_old_was_primary THEN
        RAISE EXCEPTION 'reassign_release_primary_artist: artist % is not a primary artist of release %',
            p_old_artist_id, p_release_id;
    END IF;

    -- 1. Legacy authoritative column. Only rewrite it when it pointed at the
    --    old artist (or was NULL while the old artist held the primary credit
    --    row); if it names a different collaborator, leave it alone.
    UPDATE releases
    SET release_artist_id = p_new_artist_id,
        updated_at = now()
    WHERE id = p_release_id
      AND (release_artist_id = p_old_artist_id OR release_artist_id IS NULL);
    GET DIAGNOSTICS v_legacy_updated = ROW_COUNT;

    -- 2. Canonical primary credit row. If the new artist already holds a
    --    primary row, drop the old artist's row instead of creating a
    --    duplicate (unique on release_id, artist_id, role). Otherwise move the
    --    old row in place, preserving credited_as and display_order.
    IF EXISTS (
        SELECT 1 FROM release_artists
        WHERE release_id = p_release_id
          AND artist_id = p_new_artist_id
          AND role = 'primary'
    ) THEN
        DELETE FROM release_artists
        WHERE release_id = p_release_id
          AND artist_id = p_old_artist_id
          AND role = 'primary';
        GET DIAGNOSTICS v_release_artists_deleted = ROW_COUNT;
    ELSE
        UPDATE release_artists
        SET artist_id = p_new_artist_id,
            updated_at = now()
        WHERE release_id = p_release_id
          AND artist_id = p_old_artist_id
          AND role = 'primary';
        GET DIAGNOSTICS v_release_artists_updated = ROW_COUNT;

        IF v_release_artists_updated = 0 THEN
            -- Old artist held only the legacy column; backfill the canonical row.
            INSERT INTO release_artists (release_id, artist_id, role, display_order)
            VALUES (p_release_id, p_new_artist_id, 'primary', 0)
            ON CONFLICT (release_id, artist_id, role) DO NOTHING;
            GET DIAGNOSTICS v_release_artists_inserted = ROW_COUNT;
        END IF;
    END IF;

    -- 3. Recordings that belong to this release AND whose denormalized primary
    --    artist is the old artist. Recordings owned by another release
    --    (shared recordings) or by another artist (compilations, features)
    --    are untouched.
    SELECT array_agg(rec.id) INTO v_recording_ids
    FROM recordings rec
    WHERE rec.artist_id = p_old_artist_id
      AND (
          rec.release_id = p_release_id
          OR (
              rec.release_id IS NULL
              AND EXISTS (
                  SELECT 1 FROM tracks t
                  WHERE t.release_id = p_release_id
                    AND t.recording_id = rec.id
              )
          )
      );

    IF v_recording_ids IS NOT NULL THEN
        UPDATE recordings
        SET artist_id = p_new_artist_id,
            updated_at = now()
        WHERE id = ANY (v_recording_ids);
        GET DIAGNOSTICS v_recordings_updated = ROW_COUNT;

        -- 4. Primary performer credits on those recordings. Where the new
        --    artist already holds the same credit, merge by removing the old
        --    artist's row (unique on recording_id, artist_id, role); otherwise
        --    move the row in place, preserving credited_as.
        DELETE FROM recording_credits rc_old
        USING recording_credits rc_new
        WHERE rc_old.recording_id = ANY (v_recording_ids)
          AND rc_old.artist_id = p_old_artist_id
          AND rc_old.role IN ('lead_performer', 'performer')
          AND rc_new.recording_id = rc_old.recording_id
          AND rc_new.artist_id = p_new_artist_id
          AND rc_new.role = rc_old.role;
        GET DIAGNOSTICS v_credits_merged = ROW_COUNT;

        UPDATE recording_credits
        SET artist_id = p_new_artist_id
        WHERE recording_id = ANY (v_recording_ids)
          AND artist_id = p_old_artist_id
          AND role IN ('lead_performer', 'performer');
        GET DIAGNOSTICS v_credits_updated = ROW_COUNT;
    END IF;

    -- tracks.release_id and tracks.recording_id are intentionally untouched:
    -- the tracklist belongs to the release and moves with it.

    RETURN jsonb_build_object(
        'ok', true,
        'noop', false,
        'release_id', p_release_id,
        'old_artist_id', p_old_artist_id,
        'new_artist_id', p_new_artist_id,
        'tracks_seen', v_track_count,
        'legacy_release_artist_updated', v_legacy_updated,
        'release_artists_updated', v_release_artists_updated,
        'release_artists_deleted', v_release_artists_deleted,
        'release_artists_inserted', v_release_artists_inserted,
        'recordings_updated', v_recordings_updated,
        'recording_credits_updated', v_credits_updated,
        'recording_credits_merged', v_credits_merged
    );
END;
$$;

COMMENT ON FUNCTION public.reassign_release_primary_artist(uuid, uuid, uuid) IS
    'Atomically reassigns the primary artist of a release: legacy releases.release_artist_id, the primary release_artists row, recordings.artist_id for recordings owned by the release, and lead_performer/legacy performer recording_credits. Preserves featured/creative credits, credited_as text, tracks, and recordings shared with other releases.';

-- Admin-only operation: the Next.js admin API executes with the service role.
-- Keep it out of reach of anon/authenticated PostgREST callers.
REVOKE ALL ON FUNCTION public.reassign_release_primary_artist(uuid, uuid, uuid) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.reassign_release_primary_artist(uuid, uuid, uuid) FROM anon;
REVOKE ALL ON FUNCTION public.reassign_release_primary_artist(uuid, uuid, uuid) FROM authenticated;
GRANT EXECUTE ON FUNCTION public.reassign_release_primary_artist(uuid, uuid, uuid) TO service_role;
