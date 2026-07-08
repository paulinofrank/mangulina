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
  death_year integer
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
    a.death_year
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
