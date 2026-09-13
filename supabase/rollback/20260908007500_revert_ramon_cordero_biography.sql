BEGIN;

-- Reverts 20260908007500_rewrite_ramon_cordero_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Ramón Cordero',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1940-04-26',
       birth_year = 1940,
       date_of_death = '2017-01-19',
       birth_place = 'Moca',
       province = 'Espaillat',
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = 'RamonCorderoBachata',
       instagram = 'ramon_cordero_05',
       disambiguation = NULL,
       bio_en = 'Ramón Cordero was a Dominican musician with roots in Moca, the Espaillat province capital in the Cibao, whose work has contributed to the popular music tradition of the Dominican Republic''s northern interior. Moca''s cultural life has produced a number of significant Dominican artists, and Cordero was part of that regional heritage. His career as a musician reflected the commitment to the craft of popular performance that sustains Dominican music across the country''s diverse communities, from the capital to the smallest provincial towns. Working within the traditions that define Dominican musical identity, Cordero was part of the community of artists that keeps those traditions alive through performance, recording, and the transmission of musical knowledge from one generation to the next.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'ramon-cordero';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ramón Cordero was a Dominican musician with roots in Moca, the Espaillat province capital in the Cibao, whose work has contributed to the popular music tradition of the Dominican Republic''s northern interior. Moca''s cultural life has produced a number of significant Dominican artists, and Cordero was part of that regional heritage. His career as a musician reflected the commitment to the craft of popular performance that sustains Dominican music across the country''s diverse communities, from the capital to the smallest provincial towns. Working within the traditions that define Dominican musical identity, Cordero was part of the community of artists that keeps those traditions alive through performance, recording, and the transmission of musical knowledge from one generation to the next.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'ramon-cordero'), 2)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
