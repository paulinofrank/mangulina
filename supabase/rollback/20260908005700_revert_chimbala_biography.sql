BEGIN;

-- Reverts 20260908005700_rewrite_chimbala_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Chimbala',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urbano',
       date_of_birth = '1991-05-18',
       birth_year = 1991,
       date_of_death = NULL,
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = 'Leury',
       middle_name = 'José',
       last_name = 'Tejeda',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY['Leury José Tejeda Brito']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['urban-reggaeton', 'urban-dembow']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@ChimbalaHD',
       facebook = 'ChimbalaOfficial',
       instagram = 'chimbalaofficial',
       disambiguation = NULL,
       bio_en = 'Chimbala is one of the leading figures in Dominican dembow, the high-energy urban subgenre that emerged from the island''s barrios as a homegrown response to reggaeton and dancehall. Born in 1991 in Santo Domingo, he grew up in a city where the rhythms of dembow were developing in real time, shaped by the informal music culture of working-class neighborhoods that took Jamaican and Puerto Rican influences and pushed them through a distinctly Dominican filter.

Chimbala''s rise to prominence in the mid-2010s coincided with the broader explosion of Dominican dembow as a nationally and internationally recognized genre, and he became one of its most recognizable and commercially successful representatives. His style is characterized by dense rhythmic production, assertive vocal delivery, and lyrics that speak to the experiences and aspirations of young urban Dominicans.

He has collaborated with major figures in the Latin urban world and has performed at festivals and events that reflect the growing global appetite for Dominican dembow. His success helped demonstrate that Dominican urban music did not need to be subordinate to the reggaeton establishment centered in Puerto Rico and Colombia but could generate its own stars and its own sonic identity. Chimbala continues to be one of the most active and successful artists in the Dominican urban music space.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'chimbala';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Chimbala is one of the leading figures in Dominican dembow, the high-energy urban subgenre that emerged from the island''s barrios as a homegrown response to reggaeton and dancehall. Born in 1991 in Santo Domingo, he grew up in a city where the rhythms of dembow were developing in real time, shaped by the informal music culture of working-class neighborhoods that took Jamaican and Puerto Rican influences and pushed them through a distinctly Dominican filter.","type":"text"}]},{"type":"paragraph","content":[{"text":"Chimbala''s rise to prominence in the mid-2010s coincided with the broader explosion of Dominican dembow as a nationally and internationally recognized genre, and he became one of its most recognizable and commercially successful representatives. His style is characterized by dense rhythmic production, assertive vocal delivery, and lyrics that speak to the experiences and aspirations of young urban Dominicans.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has collaborated with major figures in the Latin urban world and has performed at festivals and events that reflect the growing global appetite for Dominican dembow. His success helped demonstrate that Dominican urban music did not need to be subordinate to the reggaeton establishment centered in Puerto Rico and Colombia but could generate its own stars and its own sonic identity. Chimbala continues to be one of the most active and successful artists in the Dominican urban music space.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'chimbala'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
