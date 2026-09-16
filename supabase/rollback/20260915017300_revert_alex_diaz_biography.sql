BEGIN;

-- Revierte 20260915017300_rewrite_alex_diaz_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'alex-diaz' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'alex-diaz') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Alex Díaz is a Dominican musician from San Francisco de Macorís whose work sits at the crossroads of Afro-Dominican jazz, Latin jazz, and merengue. Drawing on the deep Afro-Caribbean musical heritage that runs through Dominican culture alongside the improvisational vocabulary of jazz, Díaz has developed a sound that is both rooted and adventurous. San Francisco de Macorís has a long tradition of musical excellence, and Díaz''s work reflects that regional identity while reaching beyond it toward an international jazz sensibility.","type":"text"}]},{"type":"paragraph","content":[{"text":"His blending of merengue rhythms with jazz harmony and Afro-Dominican percussion creates music that feels simultaneously traditional and contemporary, honoring the past while remaining alive to new possibilities. Díaz represents a generation of Dominican jazz musicians determined to claim and expand their place in the broader Latin jazz conversation.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alex-diaz';
UPDATE artists SET bio_en = 'Alex Díaz is a Dominican musician from San Francisco de Macorís whose work sits at the crossroads of Afro-Dominican jazz, Latin jazz, and merengue. Drawing on the deep Afro-Caribbean musical heritage that runs through Dominican culture alongside the improvisational vocabulary of jazz, Díaz has developed a sound that is both rooted and adventurous. San Francisco de Macorís has a long tradition of musical excellence, and Díaz''s work reflects that regional identity while reaching beyond it toward an international jazz sensibility.

His blending of merengue rhythms with jazz harmony and Afro-Dominican percussion creates music that feels simultaneously traditional and contemporary, honoring the past while remaining alive to new possibilities. Díaz represents a generation of Dominican jazz musicians determined to claim and expand their place in the broader Latin jazz conversation.', bio_es = NULL, instruments = ARRAY['congas']::text[]
       WHERE slug = 'alex-diaz';

COMMIT;
