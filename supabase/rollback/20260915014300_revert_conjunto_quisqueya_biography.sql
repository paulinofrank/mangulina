BEGIN;

-- Revierte 20260915014300_rewrite_conjunto_quisqueya_biography.sql con los documentos, campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'conjunto-quisqueya') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Conjunto Quisqueya is a Dominican music group. The group is documented for its contribution to Dominican music and its related scenes.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'conjunto-quisqueya';
UPDATE artists SET bio_en = 'Conjunto Quisqueya is a Dominican music group. The group is documented for its contribution to Dominican music and its related scenes.', bio_es = NULL,
       formation_year = NULL WHERE slug = 'conjunto-quisqueya';

COMMIT;
