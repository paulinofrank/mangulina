BEGIN;

-- Reverts 20260908001600_rewrite_sonia_silvestre_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Sonia Silvestre',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'ballads',
       date_of_birth = '1952-08-16',
       birth_year = 1952,
       date_of_death = '2014-04-17',
       birth_place = 'San Pedro de Macorís',
       province = 'San Pedro de Macorís',
       first_name = 'Sonia',
       middle_name = NULL,
       last_name = 'Silvestre',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '["musician"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Sonia Silvestre was one of the most beloved and influential voices in Dominican popular music, a singer whose emotional range and artistic integrity set her apart from her contemporaries across several decades of performance. Born in 1952 in San Pedro de Macorís, she emerged during the 1970s as a key figure in the Dominican nueva canción movement, becoming closely associated with the progressive singer-songwriter Víctor Víctor, with whom she would forge one of the most celebrated artistic partnerships in the country''s musical history.

Her voice was rich and expressive, capable of conveying both delicate vulnerability and commanding strength, and she used it to champion songs of social conscience, romantic depth, and cultural pride. Silvestre was unafraid to engage with politically sensitive material, and her willingness to give voice to the struggles of ordinary Dominicans endeared her to audiences who felt that mainstream pop rarely spoke to their experiences.

She performed extensively throughout the Dominican Republic and Latin America, and her recordings became standards in the repertoire of Dominican popular music. Beyond her artistic contributions, she was regarded as a cultural figure of moral seriousness — a singer who took the craft of interpretation as a form of responsibility. Her death in 2014 marked the end of an era, but her recordings continue to circulate widely, and her influence can be heard in the work of younger Dominican singers who cite her as a foundational inspiration.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'sonia-silvestre';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Sonia Silvestre was one of the most beloved and influential voices in Dominican popular music, a singer whose emotional range and artistic integrity set her apart from her contemporaries across several decades of performance. Born in 1952 in San Pedro de Macorís, she emerged during the 1970s as a key figure in the Dominican nueva canción movement, becoming closely associated with the progressive singer-songwriter ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor","occurrenceId":"4c78a510-e958-4b4d-848c-ebfc2c31e8e6"}},{"text":", with whom she would forge one of the most celebrated artistic partnerships in the country''s musical history.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her voice was rich and expressive, capable of conveying both delicate vulnerability and commanding strength, and she used it to champion songs of social conscience, romantic depth, and cultural pride. Silvestre was unafraid to engage with politically sensitive material, and her willingness to give voice to the struggles of ordinary Dominicans endeared her to audiences who felt that mainstream pop rarely spoke to their experiences.","type":"text"}]},{"type":"paragraph","content":[{"text":"She performed extensively throughout the Dominican Republic and Latin America, and her recordings became standards in the repertoire of Dominican popular music. Beyond her artistic contributions, she was regarded as a cultural figure of moral seriousness — a singer who took the craft of interpretation as a form of responsibility. Her death in 2014 marked the end of an era, but her recordings continue to circulate widely, and her influence can be heard in the work of younger Dominican singers who cite her as a foundational inspiration.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'sonia-silvestre'), 2)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'en'), '4c78a510-e958-4b4d-848c-ebfc2c31e8e6', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3');

COMMIT;
