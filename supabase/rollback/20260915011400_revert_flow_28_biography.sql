BEGIN;

-- Revierte 20260915011400_rewrite_flow_28_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'flow-28' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'flow-28') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Flow 28 is a young Dominican dembow and urban artist born in 2004 in Santo Domingo whose work participates in the genre that has become the dominant sound of Dominican youth culture. Dembow''s combination of driving rhythmic intensity, direct lyrical content, and high-energy performance aesthetics has made it the natural musical language for a generation of young Dominicans who see in it an authentic expression of their urban experience. Flow 28 brings his own voice to this conversation, contributing to the generational depth of the Dominican dembow scene by adding another young artist from the capital who is defining the genre''s next phase. His music is part of the ongoing story of Dominican urban creativity.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'flow-28';
UPDATE artists SET bio_en = 'Flow 28 is a young Dominican dembow and urban artist born in 2004 in Santo Domingo whose work participates in the genre that has become the dominant sound of Dominican youth culture. Dembow''s combination of driving rhythmic intensity, direct lyrical content, and high-energy performance aesthetics has made it the natural musical language for a generation of young Dominicans who see in it an authentic expression of their urban experience. Flow 28 brings his own voice to this conversation, contributing to the generational depth of the Dominican dembow scene by adding another young artist from the capital who is defining the genre''s next phase. His music is part of the ongoing story of Dominican urban creativity.', bio_es = NULL WHERE slug = 'flow-28';

COMMIT;
