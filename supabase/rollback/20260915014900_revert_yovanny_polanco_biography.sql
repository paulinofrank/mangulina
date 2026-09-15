BEGIN;

-- Revierte 20260915014900_rewrite_yovanny_polanco_biography.sql con los documentos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'yovanny-polanco' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yovanny-polanco') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Geovanny Polanco is a Dominican merengue típico and tropical musician born in 1974 in Nagua, the capital of María Trinidad Sánchez province on the northeastern Atlantic coast of the Dominican Republic. Growing up in a region where the agricultural and fishing communities maintained strong ties to traditional Dominican music, Polanco developed an affinity for the accordion-driven típico sound that has been the heartbeat of Cibao culture for generations. He has pursued a career as a performer and recording artist in the típico tradition, contributing to the ongoing vitality of a genre that faces competitive pressure from modern urban styles but remains passionately supported by its core audience. His work reflects the energy and authenticity of traditional merengue and represents the commitment of a younger generation of artists to keeping this essential Dominican sound alive and evolving.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'yovanny-polanco';
UPDATE artists SET bio_en = 'Geovanny Polanco is a Dominican merengue típico and tropical musician born in 1974 in Nagua, the capital of María Trinidad Sánchez province on the northeastern Atlantic coast of the Dominican Republic. Growing up in a region where the agricultural and fishing communities maintained strong ties to traditional Dominican music, Polanco developed an affinity for the accordion-driven típico sound that has been the heartbeat of Cibao culture for generations. He has pursued a career as a performer and recording artist in the típico tradition, contributing to the ongoing vitality of a genre that faces competitive pressure from modern urban styles but remains passionately supported by its core audience. His work reflects the energy and authenticity of traditional merengue and represents the commitment of a younger generation of artists to keeping this essential Dominican sound alive and evolving.', bio_es = NULL WHERE slug = 'yovanny-polanco';

COMMIT;
