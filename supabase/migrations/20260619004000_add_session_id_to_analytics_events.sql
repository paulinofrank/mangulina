-- Add session_id column to all event tables for device-level tracking
-- This distinguishes different devices on the same network

ALTER TABLE public.artist_view_events ADD COLUMN IF NOT EXISTS session_id text;
ALTER TABLE public.recording_view_events ADD COLUMN IF NOT EXISTS session_id text;
ALTER TABLE public.release_view_events ADD COLUMN IF NOT EXISTS session_id text;
ALTER TABLE public.genre_view_events ADD COLUMN IF NOT EXISTS session_id text;
ALTER TABLE public.search_events ADD COLUMN IF NOT EXISTS session_id text;
ALTER TABLE public.platform_click_events ADD COLUMN IF NOT EXISTS session_id text;
ALTER TABLE public.page_view_events ADD COLUMN IF NOT EXISTS session_id text;

-- Create indexes for session_id queries (optional, for future analytics)
CREATE INDEX IF NOT EXISTS idx_artist_view_events_session_id
ON public.artist_view_events(session_id) WHERE session_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_recording_view_events_session_id
ON public.recording_view_events(session_id) WHERE session_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_search_events_session_id
ON public.search_events(session_id) WHERE session_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_platform_click_events_session_id
ON public.platform_click_events(session_id) WHERE session_id IS NOT NULL;

NOTIFY pgrst, 'reload schema';
