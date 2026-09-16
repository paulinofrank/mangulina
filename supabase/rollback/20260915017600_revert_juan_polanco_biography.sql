BEGIN;

-- Revierte 20260915017600_rewrite_juan_polanco_biography.sql con los documentos que la ficha
-- tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-polanco' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'juan-polanco') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan Polanco is a Dominican merengue típico and tropical musician connected to the Santiago region whose career has been devoted to the accordion-based traditional style that defines the heart of Cibao musical culture. Working within a genre that demands both technical proficiency and deep cultural understanding, Polanco has performed and recorded music that honors the conventions of típico while bringing his own personal voice to the tradition. His association with Santiago connects him to the epicenter of merengue típico, a city that has produced generations of master accordionists, tambora players, and vocalists who collectively define what traditional Dominican merengue sounds like at its best. Polanco''s contributions to this tradition represent the kind of steady, committed artistry that sustains musical culture from one generation to the next.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-polanco';
UPDATE artists SET bio_en = 'Juan Polanco is a Dominican merengue típico and tropical musician connected to the Santiago region whose career has been devoted to the accordion-based traditional style that defines the heart of Cibao musical culture. Working within a genre that demands both technical proficiency and deep cultural understanding, Polanco has performed and recorded music that honors the conventions of típico while bringing his own personal voice to the tradition. His association with Santiago connects him to the epicenter of merengue típico, a city that has produced generations of master accordionists, tambora players, and vocalists who collectively define what traditional Dominican merengue sounds like at its best. Polanco''s contributions to this tradition represent the kind of steady, committed artistry that sustains musical culture from one generation to the next.', bio_es = NULL WHERE slug = 'juan-polanco';

COMMIT;
