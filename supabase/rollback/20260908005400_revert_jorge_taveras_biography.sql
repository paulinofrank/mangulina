BEGIN;

-- Reverts 20260908005400_rewrite_jorge_taveras_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Jorge Taveras',
       sort_name = 'Taveras, Jorge',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'instrumentalist',
       primary_genre = 'merengue',
       date_of_birth = '1945-04-23',
       birth_year = 1945,
       date_of_death = '2021-12-03',
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = 'Jorge',
       middle_name = NULL,
       last_name = 'Taveras',
       second_last_name = NULL,
       stage_name = 'Jorge Taveras',
       aliases = NULL,
       occupations = '["musician","arranger","conductor","composer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['ballads']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Jorge Taveras was a Dominican musician born in 1945 in Santo Domingo whose career embraced merengue, balada, and tropical music over several decades of dedicated performance and recording. A product of the mid-twentieth-century Dominican music scene, Taveras developed his artistry during a period when the country''s popular music was finding its identity on the international stage. He contributed to the rich tapestry of Dominican sound with recordings and live performances that endeared him to audiences at home and in the Dominican diaspora. He passed away in 2021, and his passing was mourned by fans and fellow musicians who remembered him as a committed artist whose voice had been part of the soundtrack of Dominican life for generations.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'jorge-taveras';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jorge Taveras was a Dominican musician born in 1945 in Santo Domingo whose career embraced merengue, balada, and tropical music over several decades of dedicated performance and recording. A product of the mid-twentieth-century Dominican music scene, Taveras developed his artistry during a period when the country''s popular music was finding its identity on the international stage. He contributed to the rich tapestry of Dominican sound with recordings and live performances that endeared him to audiences at home and in the Dominican diaspora. He passed away in 2021, and his passing was mourned by fans and fellow musicians who remembered him as a committed artist whose voice had been part of the soundtrack of Dominican life for generations.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jorge-taveras'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
