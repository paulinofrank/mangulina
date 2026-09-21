BEGIN;

-- Revierte 20260916008700_rewrite_joly_sc_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'joly-sc' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joly-sc') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Joly SC is a young Dominican urban, rap, and dembow artist born in 1999 in San Cristóbal, the provincial capital south of Santo Domingo, whose work participates in the vibrant Dominican urban music scene. San Cristóbal has its own cultural character shaped by its history as an industrial center and as the birthplace of Rafael Trujillo, the dictator whose shadow looms over so much of Dominican history. Growing up there in the late 1990s and 2000s, Joly SC absorbed the sounds of Dominican urban music as it was taking shape and began adding his own voice to that conversation. His music in the rap, urban, and dembow traditions contributes to the ongoing diversification of Dominican urban sound.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'joly-sc';
UPDATE artists SET bio_en = 'Joly SC is a young Dominican urban, rap, and dembow artist born in 1999 in San Cristóbal, the provincial capital south of Santo Domingo, whose work participates in the vibrant Dominican urban music scene. San Cristóbal has its own cultural character shaped by its history as an industrial center and as the birthplace of Rafael Trujillo, the dictator whose shadow looms over so much of Dominican history. Growing up there in the late 1990s and 2000s, Joly SC absorbed the sounds of Dominican urban music as it was taking shape and began adding his own voice to that conversation. His music in the rap, urban, and dembow traditions contributes to the ongoing diversification of Dominican urban sound.', bio_es = NULL WHERE slug = 'joly-sc';

COMMIT;
