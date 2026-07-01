-- =========================================================================
-- Atomic, session-aware, per-(entity, session, day) view deduplication.
--
-- Fixes:
--   C1 — application-side dedup was dead code (head:true ⇒ null data; filtered
--        on a non-existent `created_at` column) so every refresh inflated views.
--   C3 — releases/genres had no dedup at all.
--   H4 — event INSERT and counter UPDATE were two non-atomic round-trips.
--   M4 — adds a composite UNIQUE index that exactly serves the dedup lookup.
--
-- Strategy: one SECURITY DEFINER function per entity inserts the event with
-- ON CONFLICT DO NOTHING against a partial UNIQUE index, and increments the
-- persistent `views` counter ONLY when a new row was actually inserted. This is
-- idempotent and race-safe: F5, reload, back-nav, React re-mount, StrictMode
-- double-fire, retries, and concurrent tabs can no longer double-count.
--
-- "Day" bucket uses America/Santo_Domingo (Dominican Republic, UTC-4, no DST).
--
-- NO HISTORICAL ROWS ARE DELETED. The dedup UNIQUE index is intentionally
-- bounded to events on/after a cutoff date so that pre-existing duplicate rows
-- (created while dedup was broken) do not block index creation and are left
-- completely intact. ip_hash and user_agent are still captured. Vercel
-- Analytics, page_view_events, and Trending/Rising are untouched.
--
-- >>> CUTOFF: the dedup constraint applies to events whose view_day is on or
--     after 2026-07-01. If you APPLY this migration on or after that date, bump
--     every occurrence of DATE '2026-07-01' below to a still-future date (e.g.
--     tomorrow); otherwise index creation may fail on same-day duplicates.
-- =========================================================================

-- ------------------------------------------------------------------ artists
-- Populate a per-day bucket. (Adding/populating a column is non-destructive;
-- no rows are removed.) Historical rows are filled for future windowed queries
-- but are excluded from the dedup index by the cutoff below.
ALTER TABLE public.artist_view_events ADD COLUMN IF NOT EXISTS view_day date;
UPDATE public.artist_view_events
SET view_day = (viewed_at AT TIME ZONE 'America/Santo_Domingo')::date
WHERE view_day IS NULL;

CREATE UNIQUE INDEX IF NOT EXISTS uq_artist_view_dedup
ON public.artist_view_events (artist_id, session_id, view_day)
WHERE session_id IS NOT NULL AND view_day >= DATE '2026-07-01';

CREATE OR REPLACE FUNCTION public.record_artist_view(
  p_artist_id  uuid,
  p_session    text,
  p_source     text DEFAULT NULL,
  p_referrer   text DEFAULT NULL,
  p_user_agent text DEFAULT NULL,
  p_ip_hash    text DEFAULT NULL
) RETURNS boolean
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE
  v_day   date := (now() AT TIME ZONE 'America/Santo_Domingo')::date;
  v_count integer;
BEGIN
  INSERT INTO public.artist_view_events
    (artist_id, session_id, source, referrer, user_agent, ip_hash, view_day)
  VALUES
    (p_artist_id, p_session, p_source, p_referrer, p_user_agent, p_ip_hash, v_day)
  ON CONFLICT (artist_id, session_id, view_day)
    WHERE session_id IS NOT NULL AND view_day >= DATE '2026-07-01'
  DO NOTHING;

  GET DIAGNOSTICS v_count = ROW_COUNT;
  IF v_count > 0 THEN
    UPDATE public.artists SET views = coalesce(views, 0) + 1 WHERE id = p_artist_id;
  END IF;
  RETURN v_count > 0;
END $$;

-- --------------------------------------------------------------- recordings
ALTER TABLE public.recording_view_events ADD COLUMN IF NOT EXISTS view_day date;
UPDATE public.recording_view_events
SET view_day = (viewed_at AT TIME ZONE 'America/Santo_Domingo')::date
WHERE view_day IS NULL;

CREATE UNIQUE INDEX IF NOT EXISTS uq_recording_view_dedup
ON public.recording_view_events (recording_id, session_id, view_day)
WHERE session_id IS NOT NULL AND view_day >= DATE '2026-07-01';

CREATE OR REPLACE FUNCTION public.record_recording_view(
  p_recording_id uuid,
  p_session      text,
  p_source       text DEFAULT NULL,
  p_referrer     text DEFAULT NULL,
  p_user_agent   text DEFAULT NULL,
  p_ip_hash      text DEFAULT NULL
) RETURNS boolean
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE
  v_day   date := (now() AT TIME ZONE 'America/Santo_Domingo')::date;
  v_count integer;
BEGIN
  INSERT INTO public.recording_view_events
    (recording_id, session_id, source, referrer, user_agent, ip_hash, view_day)
  VALUES
    (p_recording_id, p_session, p_source, p_referrer, p_user_agent, p_ip_hash, v_day)
  ON CONFLICT (recording_id, session_id, view_day)
    WHERE session_id IS NOT NULL AND view_day >= DATE '2026-07-01'
  DO NOTHING;

  GET DIAGNOSTICS v_count = ROW_COUNT;
  IF v_count > 0 THEN
    UPDATE public.recordings SET views = coalesce(views, 0) + 1 WHERE id = p_recording_id;
  END IF;
  RETURN v_count > 0;
END $$;

-- ----------------------------------------------------------------- releases
ALTER TABLE public.release_view_events ADD COLUMN IF NOT EXISTS view_day date;
UPDATE public.release_view_events
SET view_day = (viewed_at AT TIME ZONE 'America/Santo_Domingo')::date
WHERE view_day IS NULL;

CREATE UNIQUE INDEX IF NOT EXISTS uq_release_view_dedup
ON public.release_view_events (release_id, session_id, view_day)
WHERE session_id IS NOT NULL AND view_day >= DATE '2026-07-01';

CREATE OR REPLACE FUNCTION public.record_release_view(
  p_release_id uuid,
  p_session    text,
  p_source     text DEFAULT NULL,
  p_referrer   text DEFAULT NULL,
  p_user_agent text DEFAULT NULL,
  p_ip_hash    text DEFAULT NULL
) RETURNS boolean
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE
  v_day   date := (now() AT TIME ZONE 'America/Santo_Domingo')::date;
  v_count integer;
BEGIN
  INSERT INTO public.release_view_events
    (release_id, session_id, source, referrer, user_agent, ip_hash, view_day)
  VALUES
    (p_release_id, p_session, p_source, p_referrer, p_user_agent, p_ip_hash, v_day)
  ON CONFLICT (release_id, session_id, view_day)
    WHERE session_id IS NOT NULL AND view_day >= DATE '2026-07-01'
  DO NOTHING;

  GET DIAGNOSTICS v_count = ROW_COUNT;
  IF v_count > 0 THEN
    UPDATE public.releases SET views = coalesce(views, 0) + 1 WHERE id = p_release_id;
  END IF;
  RETURN v_count > 0;
END $$;

-- ------------------------------------------------------------------- genres
-- Genres have no popularity counter today (left unchanged per scope); we only
-- dedup the event log so refreshes don't inflate genre event counts.
ALTER TABLE public.genre_view_events ADD COLUMN IF NOT EXISTS view_day date;
UPDATE public.genre_view_events
SET view_day = (viewed_at AT TIME ZONE 'America/Santo_Domingo')::date
WHERE view_day IS NULL;

CREATE UNIQUE INDEX IF NOT EXISTS uq_genre_view_dedup
ON public.genre_view_events (genre_slug, session_id, view_day)
WHERE session_id IS NOT NULL AND view_day >= DATE '2026-07-01';

CREATE OR REPLACE FUNCTION public.record_genre_view(
  p_genre_slug text,
  p_session    text,
  p_source     text DEFAULT NULL,
  p_referrer   text DEFAULT NULL,
  p_user_agent text DEFAULT NULL,
  p_ip_hash    text DEFAULT NULL
) RETURNS boolean
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE
  v_day   date := (now() AT TIME ZONE 'America/Santo_Domingo')::date;
  v_count integer;
BEGIN
  INSERT INTO public.genre_view_events
    (genre_slug, session_id, source, referrer, user_agent, ip_hash, view_day)
  VALUES
    (p_genre_slug, p_session, p_source, p_referrer, p_user_agent, p_ip_hash, v_day)
  ON CONFLICT (genre_slug, session_id, view_day)
    WHERE session_id IS NOT NULL AND view_day >= DATE '2026-07-01'
  DO NOTHING;

  GET DIAGNOSTICS v_count = ROW_COUNT;
  RETURN v_count > 0;
END $$;

-- ------------------------------------------------------------- permissions
REVOKE ALL ON FUNCTION public.record_artist_view(uuid,text,text,text,text,text)    FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.record_recording_view(uuid,text,text,text,text,text) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.record_release_view(uuid,text,text,text,text,text)   FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.record_genre_view(text,text,text,text,text,text)     FROM PUBLIC, anon, authenticated;

GRANT EXECUTE ON FUNCTION public.record_artist_view(uuid,text,text,text,text,text)    TO service_role;
GRANT EXECUTE ON FUNCTION public.record_recording_view(uuid,text,text,text,text,text) TO service_role;
GRANT EXECUTE ON FUNCTION public.record_release_view(uuid,text,text,text,text,text)   TO service_role;
GRANT EXECUTE ON FUNCTION public.record_genre_view(text,text,text,text,text,text)     TO service_role;

NOTIFY pgrst, 'reload schema';
