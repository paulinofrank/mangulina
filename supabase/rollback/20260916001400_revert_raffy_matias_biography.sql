BEGIN;

-- Revierte 20260916001400_rewrite_raffy_matias_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'raffy-matias' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raffy-matias') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Raffy Matias was a Dominican singer and musician born in 1969 in Jarabacoa, the picturesque mountain city in the La Vega province known as the City of Eternal Spring. His musical career brought him into the world of Dominican popular music where he performed and recorded in a style rooted in tropical and romantic traditions. Matias was known among fans and fellow musicians as a dedicated artist whose music carried genuine emotional sincerity.","type":"text"}]},{"type":"paragraph","content":[{"text":"He remained active in the Dominican music scene for many years before his passing in 2024 at the age of fifty-five. His death was mourned by those who had followed his career and appreciated the contribution he made to Dominican popular music over the course of his life.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'raffy-matias';
UPDATE artists SET bio_en = 'Raffy Matias was a Dominican singer and musician born in 1969 in Jarabacoa, the picturesque mountain city in the La Vega province known as the City of Eternal Spring. His musical career brought him into the world of Dominican popular music where he performed and recorded in a style rooted in tropical and romantic traditions. Matias was known among fans and fellow musicians as a dedicated artist whose music carried genuine emotional sincerity.

He remained active in the Dominican music scene for many years before his passing in 2024 at the age of fifty-five. His death was mourned by those who had followed his career and appreciated the contribution he made to Dominican popular music over the course of his life.', bio_es = NULL,
       first_name = NULL, middle_name = NULL, last_name = NULL,
       second_last_name = NULL, stage_name = NULL, gender = NULL,
       occupations = '[]'::jsonb, genres = ARRAY[]::text[]
       WHERE slug = 'raffy-matias';

COMMIT;
