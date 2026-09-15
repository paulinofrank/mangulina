BEGIN;

-- Revierte 20260914012100_rewrite_bienvenido_fabian_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'bienvenido-fabian' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bienvenido-fabian') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Bienvenido Fabián was a pioneering Dominican singer born in 1920 in San Pedro de Macorís, a coastal city that has produced a remarkable number of the country''s most talented musicians. Specializing in bolero and tropical music, Fabián built a career during the golden age of Latin romantic music, when the bolero reigned as the dominant form of popular song throughout the Caribbean and Latin America. His voice carried the warmth and expressiveness that the genre demanded, and he became a respected interpreter whose recordings documented an important chapter in Dominican musical history. He passed away in 2000, leaving behind a legacy as one of the early generation of Dominican artists who helped establish the island''s voice in the broader Latin American musical conversation.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bienvenido-fabian';
UPDATE artists SET bio_en = 'Bienvenido Fabián was a pioneering Dominican singer born in 1920 in San Pedro de Macorís, a coastal city that has produced a remarkable number of the country''s most talented musicians. Specializing in bolero and tropical music, Fabián built a career during the golden age of Latin romantic music, when the bolero reigned as the dominant form of popular song throughout the Caribbean and Latin America. His voice carried the warmth and expressiveness that the genre demanded, and he became a respected interpreter whose recordings documented an important chapter in Dominican musical history. He passed away in 2000, leaving behind a legacy as one of the early generation of Dominican artists who helped establish the island''s voice in the broader Latin American musical conversation.', bio_es = NULL, occupations = '["pianist"]'::jsonb, instruments = ARRAY[]::text[] WHERE slug = 'bienvenido-fabian';

COMMIT;
