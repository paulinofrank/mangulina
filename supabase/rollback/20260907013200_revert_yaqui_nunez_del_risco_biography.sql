BEGIN;

-- Reverts 20260907013200_rewrite_yaqui_nunez_del_risco_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Yaqui Núñez del Risco',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'composer',
       primary_genre = 'merengue',
       date_of_birth = '1939-05-04',
       birth_year = 1939,
       date_of_death = '2014-09-08',
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Pedro',
       middle_name = 'Antonio',
       last_name = 'Núñez',
       second_last_name = 'del Risco',
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
 WHERE slug = 'yaqui-nunez-del-risco';

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco')
   AND locale NOT IN ('');

COMMIT;
