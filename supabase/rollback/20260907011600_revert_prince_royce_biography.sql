BEGIN;

-- Reverts 20260907011600_rewrite_prince_royce_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Prince Royce',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1989-05-11',
       birth_year = 1989,
       date_of_death = NULL,
       birth_place = 'Nueva York',
       province = 'Nacido en el Exterior',
       first_name = 'Geoffrey',
       middle_name = 'Royce',
       last_name = 'Rojas',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = NULL,
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'prince-royce';

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'prince-royce')
   AND locale NOT IN ('');

COMMIT;
