BEGIN;

-- Revierte 20260916007900_rewrite_bladimir_vasquez_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'bladimir-vasquez' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bladimir-vasquez') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Bladimir Vásquez is a young Dominican artist born in 1995 who works in merengue, bachata, and tropical — the three genres that form the core of Dominican popular music tradition. His work across all three of these interconnected styles reflects the versatility expected of a serious Dominican popular musician, and his ability to move between the festive energy of merengue, the intimate romanticism of bachata, and the broadly appealing world of tropical demonstrates a command of the emotional range that Dominican popular music encompasses. Vásquez represents the younger generation''s embrace of these established traditions, choosing to develop within the Dominican mainstream rather than against it.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bladimir-vasquez';
UPDATE artists SET bio_en = 'Bladimir Vásquez is a young Dominican artist born in 1995 who works in merengue, bachata, and tropical — the three genres that form the core of Dominican popular music tradition. His work across all three of these interconnected styles reflects the versatility expected of a serious Dominican popular musician, and his ability to move between the festive energy of merengue, the intimate romanticism of bachata, and the broadly appealing world of tropical demonstrates a command of the emotional range that Dominican popular music encompasses. Vásquez represents the younger generation''s embrace of these established traditions, choosing to develop within the Dominican mainstream rather than against it.', bio_es = NULL, first_name = 'Bladimir', middle_name = NULL, last_name = 'Vásquez', second_last_name = NULL, occupations = '["arranger","musician","bandleader"]'::jsonb, artist_tags = ARRAY['secular']::text[] WHERE slug = 'bladimir-vasquez';

COMMIT;
