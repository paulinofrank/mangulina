BEGIN;

-- Revierte 20260915016700_rewrite_jacinto_gimbernard_biography.sql con los documentos y campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jacinto-gimbernard' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jacinto-gimbernard') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jacinto Gimbernard was a Dominican composer and musician born in Santo Domingo in 1931 whose career was defined by a commitment to classical and academic music at a time when those traditions required active cultivation in the Dominican Republic. Working within the European classical tradition while maintaining a distinctly Caribbean identity, Gimbernard contributed compositions and musical scholarship that enriched the country''s formal music culture.","type":"text"}]},{"type":"paragraph","content":[{"text":"He was associated with academic institutions and helped support the infrastructure of serious musical study in the Dominican Republic across several decades. His life spanned nearly nine decades — he passed away in 2017 — during which time he witnessed extraordinary transformations in both Dominican society and its musical life. Gimbernard''s dedication to classical and academic composition placed him among a small but vital cohort of Dominican artists who ensured that Western art music traditions found genuine root in Caribbean soil.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jacinto-gimbernard';
UPDATE artists SET bio_en = 'Jacinto Gimbernard was a Dominican composer and musician born in Santo Domingo in 1931 whose career was defined by a commitment to classical and academic music at a time when those traditions required active cultivation in the Dominican Republic. Working within the European classical tradition while maintaining a distinctly Caribbean identity, Gimbernard contributed compositions and musical scholarship that enriched the country''s formal music culture.

He was associated with academic institutions and helped support the infrastructure of serious musical study in the Dominican Republic across several decades. His life spanned nearly nine decades — he passed away in 2017 — during which time he witnessed extraordinary transformations in both Dominican society and its musical life. Gimbernard''s dedication to classical and academic composition placed him among a small but vital cohort of Dominican artists who ensured that Western art music traditions found genuine root in Caribbean soil.', bio_es = NULL,
       middle_name = NULL, instruments = ARRAY[]::text[], occupations = '["lyricist"]'::jsonb
       WHERE slug = 'jacinto-gimbernard';

COMMIT;
