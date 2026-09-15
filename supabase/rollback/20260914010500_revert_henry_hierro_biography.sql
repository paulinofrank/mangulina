BEGIN;

-- Revierte 20260914010500_rewrite_henry_hierro_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).
-- Aviso: devuelve a una persona el nombre de una orquesta con fila propia como alias.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'henry-hierro' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'henry-hierro') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Henry Hierro was a Dominican merengue and tropical musician from San Francisco de Macorís whose career has contributed to the popular music landscape of the Cibao''s most culturally productive city. San Francisco de Macorís has an extraordinary musical legacy for a relatively small urban center, producing figures across the full range of Dominican popular and jazz traditions, and Hierro was part of that story. His work in merengue and tropical reflected the festive, dance-oriented side of Dominican music that has always had its most devoted audience in the Cibao''s communities, where the music is not merely entertainment but a living expression of regional identity. Hierro was the kind of dedicated regional artist whose contribution to Dominican musical culture is no less significant for being less nationally prominent.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = 'henry-hierro';
UPDATE artists SET bio_en = 'Henry Hierro was a Dominican merengue and tropical musician from San Francisco de Macorís whose career has contributed to the popular music landscape of the Cibao''s most culturally productive city. San Francisco de Macorís has an extraordinary musical legacy for a relatively small urban center, producing figures across the full range of Dominican popular and jazz traditions, and Hierro was part of that story. His work in merengue and tropical reflected the festive, dance-oriented side of Dominican music that has always had its most devoted audience in the Cibao''s communities, where the music is not merely entertainment but a living expression of regional identity. Hierro was the kind of dedicated regional artist whose contribution to Dominican musical culture is no less significant for being less nationally prominent.', bio_es = NULL,
       middle_name = NULL, second_last_name = NULL, aliases = ARRAY['La Gran Manzana', 'Henry Hierro y la Gran Manzana']::text[],
       occupations = '["musician","arranger","bandleader","composer"]'::jsonb WHERE slug = 'henry-hierro';
DELETE FROM artist_relationships r USING artists s, artists g
 WHERE r.source_artist_id = s.id AND r.target_artist_id = g.id AND r.relationship_type = 'founder_of'
   AND s.slug = 'henry-hierro' AND g.slug = 'victor-roque-y-la-gran-manzana';

COMMIT;
