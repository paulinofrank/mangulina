BEGIN;

-- Revierte 20260916008100_rewrite_chiquito_team_band_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chiquito-team-band' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chiquito-team-band') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Chiquito Team Band is a Dominican music group. The group is documented for its contribution to Dominican music and its related scenes.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'chiquito-team-band';
UPDATE artists SET bio_en = 'Chiquito Team Band is a Dominican music group. The group is documented for its contribution to Dominican music and its related scenes.', bio_es = NULL, birth_year = NULL, primary_genre = 'merengue' WHERE slug = 'chiquito-team-band';

COMMIT;
