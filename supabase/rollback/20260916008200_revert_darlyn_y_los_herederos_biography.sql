BEGIN;

-- Revierte 20260916008200_rewrite_darlyn_y_los_herederos_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'darlyn-y-los-herederos' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'darlyn-y-los-herederos') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Darlyn y Los Herederos — Darlyn and the Heirs — is a Dominican music group performing in the merengue and tropical genres whose very name suggests a conscious relationship to musical inheritance and tradition. By calling themselves the Heirs, the group announces their intention to carry forward the Dominican popular music legacy, positioning themselves as custodians of the merengue and tropical tradition rather than innovators seeking to depart from it. Their work has contributed to the festive and dance-floor-oriented side of Dominican popular music, providing audiences with the kind of high-energy, rhythm-driven entertainment that merengue has always promised.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'darlyn-y-los-herederos';
UPDATE artists SET bio_en = 'Darlyn y Los Herederos — Darlyn and the Heirs — is a Dominican music group performing in the merengue and tropical genres whose very name suggests a conscious relationship to musical inheritance and tradition. By calling themselves the Heirs, the group announces their intention to carry forward the Dominican popular music legacy, positioning themselves as custodians of the merengue and tropical tradition rather than innovators seeking to depart from it. Their work has contributed to the festive and dance-floor-oriented side of Dominican popular music, providing audiences with the kind of high-energy, rhythm-driven entertainment that merengue has always promised.', bio_es = NULL, occupations = '["musician"]'::jsonb WHERE slug = 'darlyn-y-los-herederos';

COMMIT;
