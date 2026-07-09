ALTER TABLE public.artists
ADD COLUMN IF NOT EXISTS has_image boolean NOT NULL DEFAULT false;

COMMENT ON COLUMN public.artists.has_image IS
  'True when artists-images/{id}.webp exists and frontend list/card views should request it.';

DROP FUNCTION IF EXISTS public.get_homepage_birthday_artists(date, integer);

CREATE OR REPLACE FUNCTION public.get_homepage_birthday_artists(
  p_today date DEFAULT CURRENT_DATE,
  p_limit integer DEFAULT 10
)
RETURNS TABLE (
  id uuid,
  slug text,
  name text,
  date_of_birth date,
  province text,
  death_year integer,
  has_image boolean
)
LANGUAGE sql
STABLE
SECURITY INVOKER
SET search_path = public
AS $$
  WITH birthday_window AS (
    SELECT
      gs::date AS birthday_date,
      row_number() OVER (ORDER BY gs::date) - 1 AS birthday_offset
    FROM generate_series(
      p_today,
      p_today + interval '6 days',
      interval '1 day'
    ) AS gs
  )
  SELECT
    a.id,
    a.slug,
    a.name,
    a.date_of_birth,
    a.province,
    a.death_year,
    a.has_image
  FROM public.artists a
  JOIN birthday_window bw
    ON EXTRACT(MONTH FROM a.date_of_birth)::int = EXTRACT(MONTH FROM bw.birthday_date)::int
   AND EXTRACT(DAY FROM a.date_of_birth)::int = EXTRACT(DAY FROM bw.birthday_date)::int
  WHERE a.status = 'published'
    AND a.date_of_birth IS NOT NULL
  ORDER BY
    bw.birthday_offset ASC,
    a.name ASC
  LIMIT LEAST(GREATEST(p_limit, 1), 50);
$$;

DROP FUNCTION IF EXISTS public.get_homepage_most_awarded_artists(integer);

CREATE OR REPLACE FUNCTION public.get_homepage_most_awarded_artists(
  p_limit integer DEFAULT 10
)
RETURNS TABLE (
  id uuid,
  slug text,
  name text,
  province text,
  views bigint,
  has_image boolean,
  award_count bigint,
  nomination_count bigint
)
LANGUAGE sql
STABLE
SECURITY INVOKER
SET search_path = public
AS $$
  WITH award_counts AS (
    SELECT
      aa.artist_id,
      COUNT(*) FILTER (WHERE aa.won IS TRUE) AS award_count,
      COUNT(*) FILTER (WHERE aa.won IS NOT TRUE) AS nomination_count
    FROM public.artist_awards aa
    WHERE aa.artist_id IS NOT NULL
    GROUP BY aa.artist_id
  )
  SELECT
    a.id,
    a.slug,
    a.name,
    a.province,
    COALESCE(a.views, 0)::bigint AS views,
    a.has_image,
    ac.award_count,
    ac.nomination_count
  FROM award_counts ac
  JOIN public.artists a ON a.id = ac.artist_id
  WHERE a.status = 'published'
  ORDER BY
    ac.award_count DESC,
    (ac.award_count + ac.nomination_count) DESC,
    COALESCE(a.views, 0) DESC,
    a.name ASC
  LIMIT LEAST(GREATEST(p_limit, 1), 50);
$$;
