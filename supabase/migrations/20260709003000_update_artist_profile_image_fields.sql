DROP FUNCTION IF EXISTS public.get_artist_profile_page(text);

CREATE OR REPLACE FUNCTION public.get_artist_profile_page(artist_slug text)
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY INVOKER
SET search_path = public
AS $$
  SELECT jsonb_build_object(
    'id', a.id,
    'name', a.name,
    'slug', a.slug,
    'type', a.type,
    'ended', a.ended,
    'bio_en', a.bio_en,
    'bio_es', a.bio_es,
    'views', a.views,
    'has_image', a.has_image,
    'image_updated_at', a.image_updated_at,
    'first_name', a.first_name,
    'middle_name', a.middle_name,
    'last_name', a.last_name,
    'second_last_name', a.second_last_name,
    'stage_name', a.stage_name,
    'date_of_birth', a.date_of_birth,
    'date_of_death', a.date_of_death,
    'death_year', a.death_year,
    'birth_place', a.birth_place,
    'province', a.province,
    'primary_role', a.primary_role,
    'primary_genre', a.primary_genre,
    'occupations', a.occupations,
    'instruments', a.instruments,
    'genres', a.genres,
    'artist_tags', a.artist_tags,
    'aliases', a.aliases,
    'pseudonyms', '[]'::jsonb,
    'website', a.website,
    'youtube', a.youtube,
    'facebook', a.facebook,
    'instagram', a.instagram,
    'awards', COALESCE(
      (
        SELECT jsonb_agg(
          jsonb_build_object(
            'year', aa.year,
            'award', aw.name,
            'category', ac.name,
            'work', aa.work,
            'won', aa.won,
            'country', aw.country,
            'source', aa.source
          )
          ORDER BY aa.year DESC NULLS LAST, aw.name ASC, ac.name ASC
        )
        FROM public.artist_awards aa
        JOIN public.awards aw ON aw.id = aa.award_id
        LEFT JOIN public.award_categories ac ON ac.id = aa.category_id
        WHERE aa.artist_id = a.id
      ),
      '[]'::jsonb
    )
  )
  FROM public.artists a
  WHERE a.slug = artist_slug
    AND a.status = 'published'
  LIMIT 1;
$$;

NOTIFY pgrst, 'reload schema';
