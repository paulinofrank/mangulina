-- Fix: 13 sets of byte-identical indexes, each one a second copy of an index
-- that already existed. Duplicates cost write throughput and disk on every
-- INSERT/UPDATE and buy nothing.
--
-- Which twin survives, and why:
--   * Where a plain index duplicates a UNIQUE constraint's index, the plain
--     index is dropped -- the constraint cannot be dropped without losing the
--     uniqueness guarantee.
--   * Where two UNIQUE constraints cover the same columns, the auto-generated
--     <table>_<column>_key name is dropped and the deliberately named one kept.
--   * Where both are plain indexes, the name a migration in this repo created
--     is kept, so that migration stays idempotent on a rebuild
--     (artists_genres_gin from 20260525002000, idx_releases_release_year from
--     20260619001000). Otherwise the more explicit name is kept.
--
-- No application code or migration references any of the dropped names --
-- checked across src/, scripts/ and supabase/migrations/, including
-- ON CONFLICT ON CONSTRAINT usage.

-- artist_credits: plain duplicates of plain indexes
DROP INDEX IF EXISTS public.idx_artist_credits_artist;      -- keeps idx_artist_credits_artist_id
DROP INDEX IF EXISTS public.idx_artist_credits_recording;   -- keeps idx_artist_credits_recording_id
-- artist_credits: plain duplicate of the uq_artist_credit constraint index
DROP INDEX IF EXISTS public.idx_credits_rec_seq;            -- keeps uq_artist_credit

-- artists
DROP INDEX IF EXISTS public.idx_artists_genres_gin;         -- keeps artists_genres_gin (repo-owned)
ALTER TABLE public.artists DROP CONSTRAINT IF EXISTS artists_mbid_key;  -- keeps artists_mbid_unique

-- mediums: plain duplicate of the uq_medium_release_position constraint index
DROP INDEX IF EXISTS public.idx_mediums_release_pos;        -- keeps uq_medium_release_position

-- recording_credits: two UNIQUE constraints over the same columns
ALTER TABLE public.recording_credits DROP CONSTRAINT IF EXISTS recording_credits_unique;  -- keeps uq_recording_credits_unique

-- recordings
ALTER TABLE public.recordings DROP CONSTRAINT IF EXISTS recordings_mbid_key;  -- keeps recordings_mbid_unique

-- relationships: three identical indexes on each side of the relation
DROP INDEX IF EXISTS public.idx_relationships_a;            -- keeps idx_relationships_entity_a
DROP INDEX IF EXISTS public.idx_relationships_source;       -- keeps idx_relationships_entity_a
DROP INDEX IF EXISTS public.idx_relationships_b;            -- keeps idx_relationships_entity_b
DROP INDEX IF EXISTS public.idx_relationships_target;       -- keeps idx_relationships_entity_b

-- releases
DROP INDEX IF EXISTS public.idx_releases_year;              -- keeps idx_releases_release_year (repo-owned)

-- tracks
DROP INDEX IF EXISTS public.idx_tracks_release;             -- keeps idx_tracks_release_id
DROP INDEX IF EXISTS public.idx_tracks_medium_pos;          -- keeps uq_track_medium_position

-- DOWN (manual rollback): recreate any dropped index from the surviving twin's
-- definition, e.g.
--   CREATE INDEX idx_tracks_release ON public.tracks (release_id);
-- The two dropped UNIQUE constraints are redundant with the ones kept; a
-- rollback that needs them can re-add them with ALTER TABLE ... ADD CONSTRAINT.
