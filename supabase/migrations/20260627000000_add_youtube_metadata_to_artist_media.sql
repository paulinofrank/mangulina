alter table public.artist_media
add column if not exists youtube_channel_id text,
add column if not exists youtube_channel_name text,
add column if not exists youtube_channel_url text,
add column if not exists youtube_channel_avatar_url text,
add column if not exists youtube_metadata_fetched_at timestamptz;
