BEGIN;

-- Reverts 20260907014200_rewrite_ramon_leonardo_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Ramón Leonardo',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'ballads',
       date_of_birth = '1948-02-28',
       birth_year = 1948,
       date_of_death = NULL,
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Ramón',
       middle_name = 'Leonardo',
       last_name = 'Blanco',
       second_last_name = 'Quesada',
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = NULL,
       facebook = 'ramon.leonardo.cantautor.de.la.patria',
       instagram = 'ramonleonardocantautor',
       disambiguation = NULL,
       bio_en = NULL,
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'ramon-leonardo';

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-leonardo')
   AND locale NOT IN ('');

COMMIT;
