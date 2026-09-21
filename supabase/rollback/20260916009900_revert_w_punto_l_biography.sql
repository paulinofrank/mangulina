BEGIN;

-- Revierte 20260916009900_rewrite_w_punto_l_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'w-punto-l' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'w-punto-l') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"W punto L is a young Dominican artist born in 1998 in Santo Domingo who participates in the contemporary Dominican popular music scene. His name — W dot L — has the compressed, abbreviated quality of internet-era branding, suggesting an artist who is fully at home in the digital world and understands that identity in contemporary music is as much about how you present yourself online as about what you record. Working in the Santo Domingo music ecosystem, W punto L is part of the generation that has grown up with streaming, social media, and digital distribution as the primary infrastructure of the music industry, developing their art and audience within that framework from the beginning.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'w-punto-l';
UPDATE artists SET bio_en = 'W punto L is a young Dominican artist born in 1998 in Santo Domingo who participates in the contemporary Dominican popular music scene. His name — W dot L — has the compressed, abbreviated quality of internet-era branding, suggesting an artist who is fully at home in the digital world and understands that identity in contemporary music is as much about how you present yourself online as about what you record. Working in the Santo Domingo music ecosystem, W punto L is part of the generation that has grown up with streaming, social media, and digital distribution as the primary infrastructure of the music industry, developing their art and audience within that framework from the beginning.', bio_es = NULL, aliases = ARRAY[]::text[] WHERE slug = 'w-punto-l';

COMMIT;
