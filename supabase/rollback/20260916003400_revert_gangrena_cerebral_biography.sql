BEGIN;

-- Revierte 20260916003400_rewrite_gangrena_cerebral_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'gangrena-cerebral' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'gangrena-cerebral') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Gangrena Cerebral — Brain Gangrene — is a Dominican music group operating in the genres of punk, grindcore, and metal, representing the underground extreme music scene that exists at the furthest remove from the merengue and bachata traditions most associated with Dominican popular culture. Their name announces an aesthetic of confrontation and provocation that is characteristic of punk and grindcore worldwide, genres built on the rejection of musical and social conventions. The existence of a Dominican extreme metal and grindcore scene is a reminder of the remarkable diversity of the country''s musical culture, which encompasses everything from Afro-Dominican folk ritual to internationally connected underground rock. Gangrena Cerebral has contributed to building a community of Dominican extreme music fans and musicians who maintain connections to the global metal and punk underground while developing their own local scene.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'gangrena-cerebral';
UPDATE artists SET bio_en = 'Gangrena Cerebral — Brain Gangrene — is a Dominican music group operating in the genres of punk, grindcore, and metal, representing the underground extreme music scene that exists at the furthest remove from the merengue and bachata traditions most associated with Dominican popular culture. Their name announces an aesthetic of confrontation and provocation that is characteristic of punk and grindcore worldwide, genres built on the rejection of musical and social conventions. The existence of a Dominican extreme metal and grindcore scene is a reminder of the remarkable diversity of the country''s musical culture, which encompasses everything from Afro-Dominican folk ritual to internationally connected underground rock. Gangrena Cerebral has contributed to building a community of Dominican extreme music fans and musicians who maintain connections to the global metal and punk underground while developing their own local scene.', bio_es = NULL,
       formation_year = NULL
       WHERE slug = 'gangrena-cerebral';

COMMIT;
