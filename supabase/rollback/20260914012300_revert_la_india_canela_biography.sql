BEGIN;

-- Revierte 20260914012300_rewrite_la_india_canela_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'la-india-canela' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'la-india-canela') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"La India Canela is a Dominican singer associated with merengue típico, merengue, and tropical music, hailing from the Santiago Rodríguez province in the northwestern part of the island. Her connection to merengue típico — the raw, accordion-driven folk form of merengue rooted in the Cibao region — gives her music an authentic, earthy quality that distinguishes her from more commercially polished contemporaries. Known for her powerful voice and energetic stage presence, she has been a staple of the típico circuit, performing at festivals, local celebrations, and cultural events that keep this traditional style alive. Her artistry honors the grassroots origins of Dominican merengue while bringing her own personality and vocal strength to every performance.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'la-india-canela';
UPDATE artists SET bio_en = 'La India Canela is a Dominican singer associated with merengue típico, merengue, and tropical music, hailing from the Santiago Rodríguez province in the northwestern part of the island. Her connection to merengue típico — the raw, accordion-driven folk form of merengue rooted in the Cibao region — gives her music an authentic, earthy quality that distinguishes her from more commercially polished contemporaries. Known for her powerful voice and energetic stage presence, she has been a staple of the típico circuit, performing at festivals, local celebrations, and cultural events that keep this traditional style alive. Her artistry honors the grassroots origins of Dominican merengue while bringing her own personality and vocal strength to every performance.', bio_es = NULL,
       first_name = 'Mery', middle_name = NULL, last_name = 'Hernández',
       second_last_name = NULL, birth_place = 'Santiago Rodríguez', province = 'Santiago Rodríguez',
       occupations = '["musician"]'::jsonb,
       instruments = ARRAY[]::text[], aliases = ARRAY[]::text[]
 WHERE slug = 'la-india-canela';

COMMIT;
