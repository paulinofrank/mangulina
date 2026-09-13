BEGIN;

-- Reverts 20260907015000_rewrite_guarionex_aquino_reyes_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Guarionex Aquino Reyes',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'instrumental-classical',
       date_of_birth = '1924-02-28',
       birth_year = 1924,
       date_of_death = '2010-12-24',
       birth_place = 'Santa Cruz de Mao',
       province = 'Valverde',
       first_name = 'Guarionex',
       middle_name = NULL,
       last_name = 'Aquino',
       second_last_name = 'Reyes',
       stage_name = NULL,
       aliases = ARRAY['El Gran Barítono Dominicano']::text[],
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
 WHERE slug = 'guarionex-aquino-reyes';

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-reyes')
   AND locale NOT IN ('');

COMMIT;
