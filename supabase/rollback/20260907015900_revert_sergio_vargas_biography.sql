BEGIN;

-- Reverts 20260907015900_rewrite_sergio_vargas_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Sergio Vargas',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = NULL,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1960-03-15',
       birth_year = 1960,
       date_of_death = NULL,
       birth_place = 'Villa Altagracia',
       province = 'San Cristóbal',
       first_name = 'Sergio',
       middle_name = NULL,
       last_name = 'Vargas',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = NULL,
       occupations = '["musician"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = '422849571084732',
       instagram = 'sergiovargas3',
       disambiguation = NULL,
       bio_en = 'Sergio Vargas is one of the Dominican Republic''s most celebrated merengue artists, born in 1960 in Villa Altagracia in the San Cristóbal province. He burst onto the national music scene in the 1980s with a voice of remarkable power and clarity, quickly establishing himself among the elite of Dominican merengue singers. Known for his energetic performances and his ability to command a crowd, Vargas built a discography of hits that became classics of the genre — songs that were impossible to resist on a dance floor and equally beloved as recordings.

He was part of the generation of merengue artists who carried the genre to its peak of international popularity in the late 1980s and 1990s, performing to huge audiences in the United States, Europe, and Latin America. His career has shown remarkable staying power; decades after his initial breakthrough, Vargas continues to record and perform, drawing on a legacy of hits and a stage presence that has never dimmed. He is regarded as one of the defining voices of Dominican merengue''s golden era.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'sergio-vargas';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Sergio Vargas is one of the Dominican Republic''s most celebrated merengue artists, born in 1960 in Villa Altagracia in the San Cristóbal province. He burst onto the national music scene in the 1980s with a voice of remarkable power and clarity, quickly establishing himself among the elite of Dominican merengue singers. Known for his energetic performances and his ability to command a crowd, Vargas built a discography of hits that became classics of the genre — songs that were impossible to resist on a dance floor and equally beloved as recordings.","type":"text"}]},{"type":"paragraph","content":[{"text":"He was part of the generation of merengue artists who carried the genre to its peak of international popularity in the late 1980s and 1990s, performing to huge audiences in the United States, Europe, and Latin America. His career has shown remarkable staying power; decades after his initial breakthrough, Vargas continues to record and perform, drawing on a legacy of hits and a stage presence that has never dimmed. He is regarded as one of the defining voices of Dominican merengue''s golden era.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'sergio-vargas'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
