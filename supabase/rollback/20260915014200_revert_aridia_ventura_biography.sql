BEGIN;

-- Revierte 20260915014200_rewrite_aridia_ventura_biography.sql con los documentos, campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'aridia-ventura' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aridia-ventura') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Aridia Ventura was a Dominican bachata, tropical, and folklore artist born in 1951 in San Francisco de Macorís, a Cibao city with a proud tradition of producing significant Dominican musicians. She was part of the generation of Dominican women artists who navigated the male-dominated world of bachata and popular music with a combination of talent and determination, contributing recordings and performances that enriched the genre''s emotional landscape. Her engagement with Dominican folklore alongside commercial bachata and tropical music reflected a musician interested in the full spectrum of island musical tradition. She passed away in 2001, leaving behind a legacy as a female voice in the foundational era of Dominican bachata.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'aridia-ventura';
UPDATE artists SET bio_en = 'Aridia Ventura was a Dominican bachata, tropical, and folklore artist born in 1951 in San Francisco de Macorís, a Cibao city with a proud tradition of producing significant Dominican musicians. She was part of the generation of Dominican women artists who navigated the male-dominated world of bachata and popular music with a combination of talent and determination, contributing recordings and performances that enriched the genre''s emotional landscape. Her engagement with Dominican folklore alongside commercial bachata and tropical music reflected a musician interested in the full spectrum of island musical tradition. She passed away in 2001, leaving behind a legacy as a female voice in the foundational era of Dominican bachata.', bio_es = NULL, birth_place = 'San Francisco de Macorís',
       province = 'Duarte' WHERE slug = 'aridia-ventura';

COMMIT;
