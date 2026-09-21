BEGIN;

-- Revierte 20260916003600_rewrite_dj_gabriel_b_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'dj-gabriel-b' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'dj-gabriel-b') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"DJ Gabriel Beast is a Dominican DJ associated with the Santo Domingo club scene and with a growing profile in international electronic music circles. His work in Dominican dance and urban music has drawn attention within the Boiler Room community — the London-based global platform that has spotlighted underground and club DJs from around the world — giving him visibility beyond the local circuit. Gabriel Beast represents a generation of Dominican DJs who are connecting the island''s vibrant club culture to the global electronic music conversation, bringing Dominican rhythms and sensibilities into spaces previously dominated by artists from Europe, the United States, and Latin America''s larger urban centers. His presence in international DJ culture is part of a broader assertion of Dominican creative identity in global popular music.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dj-gabriel-b';
UPDATE artists SET bio_en = 'DJ Gabriel Beast is a Dominican DJ associated with the Santo Domingo club scene and with a growing profile in international electronic music circles. His work in Dominican dance and urban music has drawn attention within the Boiler Room community — the London-based global platform that has spotlighted underground and club DJs from around the world — giving him visibility beyond the local circuit. Gabriel Beast represents a generation of Dominican DJs who are connecting the island''s vibrant club culture to the global electronic music conversation, bringing Dominican rhythms and sensibilities into spaces previously dominated by artists from Europe, the United States, and Latin America''s larger urban centers. His presence in international DJ culture is part of a broader assertion of Dominican creative identity in global popular music.', bio_es = NULL, name = 'DJ Gabriel Beast', sort_name = 'Gabriel Beast, DJ',
       stage_name = 'DJ Gabriel Beast', gender = NULL, aliases = ARRAY['Gabriel B','DJ Gabriel B','Gabriel Beats']::text[], primary_genre = NULL,
       occupations = '[]'::jsonb, instagram = NULL
       WHERE slug = 'dj-gabriel-b';

COMMIT;
