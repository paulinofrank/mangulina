BEGIN;

-- Revierte 20260915010300_rewrite_milly_jocelyn_y_los_vecinos_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'milly-jocelyn-y-los-vecinos' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'milly-jocelyn-y-los-vecinos') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Los Vecinos — The Neighbors — is a music group associated with merengue and tropical whose name evokes the communal, neighborhood-centered character of Dominican social life and musical culture. Merengue has always been music of the community, played at neighborhood gatherings, corner stores, and family celebrations as much as in formal concert venues, and a name like Los Vecinos speaks directly to that grassroots social reality. The group has performed and recorded in the merengue and tropical traditions, contributing to the lively landscape of Dominican popular dance music with an approachable, community-oriented identity.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'milly-jocelyn-y-los-vecinos';
UPDATE artists SET bio_en = 'Los Vecinos — The Neighbors — is a music group associated with merengue and tropical whose name evokes the communal, neighborhood-centered character of Dominican social life and musical culture. Merengue has always been music of the community, played at neighborhood gatherings, corner stores, and family celebrations as much as in formal concert venues, and a name like Los Vecinos speaks directly to that grassroots social reality. The group has performed and recorded in the merengue and tropical traditions, contributing to the lively landscape of Dominican popular dance music with an approachable, community-oriented identity.', bio_es = NULL, formation_year = NULL WHERE slug = 'milly-jocelyn-y-los-vecinos';

COMMIT;
