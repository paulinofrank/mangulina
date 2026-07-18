ALTER TABLE public.genres
  ADD COLUMN IF NOT EXISTS history_en text,
  ADD COLUMN IF NOT EXISTS history_es text;

COMMENT ON COLUMN public.genres.history_en IS
  'English rich-text history content for a top-level genre.';

COMMENT ON COLUMN public.genres.history_es IS
  'Spanish rich-text history content for a top-level genre.';
