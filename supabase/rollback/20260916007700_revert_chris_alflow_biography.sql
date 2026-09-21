BEGIN;

-- Revierte 20260916007700_rewrite_chris_alflow_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-alflow' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chris-alflow') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Chris Alflow is a young Dominican artist born in 1995 whose work participates in the contemporary Dominican popular music scene. His stage name — combining a given name with the concept of flow, the quality of rhythmic fluency that is central to both rap and urban music — signals an artist whose primary artistic identity is rooted in the verbal and rhythmic arts of hip hop and urban culture. Working in Santo Domingo''s music ecosystem, Chris Alflow is part of the ongoing proliferation of young Dominican talent that has made the country''s urban music scene one of the most productive and visible in the Caribbean. His work contributes to the continuing evolution of Dominican popular music in the digital era.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'chris-alflow';
UPDATE artists SET bio_en = 'Chris Alflow is a young Dominican artist born in 1995 whose work participates in the contemporary Dominican popular music scene. His stage name — combining a given name with the concept of flow, the quality of rhythmic fluency that is central to both rap and urban music — signals an artist whose primary artistic identity is rooted in the verbal and rhythmic arts of hip hop and urban culture. Working in Santo Domingo''s music ecosystem, Chris Alflow is part of the ongoing proliferation of young Dominican talent that has made the country''s urban music scene one of the most productive and visible in the Caribbean. His work contributes to the continuing evolution of Dominican popular music in the digital era.', bio_es = NULL, occupations = '[]'::jsonb WHERE slug = 'chris-alflow';

COMMIT;
