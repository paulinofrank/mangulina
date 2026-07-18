CREATE TABLE IF NOT EXISTS public.genre_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  genre_id bigint NOT NULL REFERENCES public.genres(id) ON DELETE CASCADE,
  media_type text NOT NULL DEFAULT 'video',
  title text NOT NULL,
  url text NOT NULL,
  platform text NOT NULL DEFAULT 'other',
  external_id text,
  thumbnail_url text,
  published_date date,
  youtube_channel_id text,
  youtube_channel_name text,
  youtube_channel_url text,
  youtube_channel_avatar_url text,
  youtube_metadata_fetched_at timestamptz,
  is_official boolean NOT NULL DEFAULT false,
  is_featured boolean NOT NULL DEFAULT false,
  display_order integer NOT NULL DEFAULT 0,
  notes text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS genre_media_genre_id_idx ON public.genre_media(genre_id);
CREATE INDEX IF NOT EXISTS genre_media_display_idx
  ON public.genre_media(genre_id, is_featured DESC, display_order, created_at);
CREATE UNIQUE INDEX IF NOT EXISTS genre_media_genre_url_idx
  ON public.genre_media(genre_id, url);
