BEGIN;

-- Revierte 20260914010400_rewrite_henry_garcia_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'henry-garcia' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'henry-garcia') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Henry García is a Dominican musician and performer born in 1955 in Santo Domingo whose career has spanned the worlds of merengue, salsa, and tropical music. A product of the capital''s vibrant and competitive music scene, García developed as an artist during the era when Dominican merengue was asserting its identity on the international stage and salsa was the dominant force in Latin urban music. His versatility across merengue and salsa demonstrated a broad musical sensibility, allowing him to connect with audiences who moved between the two great dance music traditions of the Spanish-speaking Caribbean. Based in Santo Domingo, García has been a consistent presence in Dominican popular music for decades, contributing recordings and performances that reflect the energy and emotional richness of the Caribbean tropical sound.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'henry-garcia';
UPDATE artists SET bio_en = 'Henry García is a Dominican musician and performer born in 1955 in Santo Domingo whose career has spanned the worlds of merengue, salsa, and tropical music. A product of the capital''s vibrant and competitive music scene, García developed as an artist during the era when Dominican merengue was asserting its identity on the international stage and salsa was the dominant force in Latin urban music. His versatility across merengue and salsa demonstrated a broad musical sensibility, allowing him to connect with audiences who moved between the two great dance music traditions of the Spanish-speaking Caribbean. Based in Santo Domingo, García has been a consistent presence in Dominican popular music for decades, contributing recordings and performances that reflect the energy and emotional richness of the Caribbean tropical sound.', bio_es = NULL,
       middle_name = NULL, second_last_name = NULL,
       occupations = '["arranger"]'::jsonb WHERE slug = 'henry-garcia';

COMMIT;
