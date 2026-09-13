BEGIN;

-- Reverts 20260907015100_rewrite_guarionex_aquino_hijo_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Guarionex Aquino Hijo',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'musician',
       primary_genre = 'fusion',
       date_of_birth = '1954-06-01',
       birth_year = 1954,
       date_of_death = NULL,
       birth_place = 'Santa Cruz de Mao',
       province = 'Valverde',
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY['bongos', 'drums', 'congas', 'tambora']::text[],
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
 WHERE slug = 'guarionex-aquino-hijo';

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-hijo')
   AND locale NOT IN ('');

COMMIT;
