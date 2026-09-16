BEGIN;

-- Revierte 20260916001300_rewrite_roger_zayas_bazan_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'roger-zayas-bazan' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'roger-zayas-bazan') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Roger Zayas-Bazán is a Dominican musician born in 1961 in Santo Domingo whose career has contributed to the country''s popular music landscape. Working in the capital during a period of significant development and internationalization in Dominican music, Zayas-Bazán has been part of the active musical community that has sustained and evolved the country''s popular traditions across several decades. His presence in the Dominican music scene reflects the depth of talent that the country has consistently produced, talent that extends well beyond the internationally celebrated stars to include the many dedicated musicians who perform, record, and teach as part of the broader ecosystem that keeps Dominican music alive.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'roger-zayas-bazan';
UPDATE artists SET bio_en = 'Roger Zayas-Bazán is a Dominican musician born in 1961 in Santo Domingo whose career has contributed to the country''s popular music landscape. Working in the capital during a period of significant development and internationalization in Dominican music, Zayas-Bazán has been part of the active musical community that has sustained and evolved the country''s popular traditions across several decades. His presence in the Dominican music scene reflects the depth of talent that the country has consistently produced, talent that extends well beyond the internationally celebrated stars to include the many dedicated musicians who perform, record, and teach as part of the broader ecosystem that keeps Dominican music alive.', bio_es = NULL,
       second_last_name = NULL, occupations = '["musician"]'::jsonb, genres = ARRAY[]::text[]
       WHERE slug = 'roger-zayas-bazan';

COMMIT;
