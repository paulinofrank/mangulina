BEGIN;

-- Revierte 20260916002100_rewrite_genoveva_biography.sql con los documentos, campos y relación
-- familiar que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'genoveva-la-patrona' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'genoveva-la-patrona') AND document_type = 'artist_biography';
DELETE FROM artist_family_relationships WHERE artist_id = (SELECT id FROM artists WHERE slug = 'genoveva-la-patrona')
       AND related_artist_id = (SELECT id FROM artists WHERE slug = 'luis-terror-dias');
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Genoveva is the stage name of Cristina Genoveva Almonte Rodríguez, a Dominican singer-songwriter and recording artist born on August 24, 1977, in Pimentel, Duarte Province. She is best understood as a secular Latin artist with a bachata foundation, rather than as a Christian artist, even though some faith-oriented or inspirational songs may appear within her catalog.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her public artist profiles describe an early connection to music through her school choir, where she began singing as a child, and present her as a bachata performer whose work moves through romantic, social, and everyday-life themes. Releases such as \"Yo Quiero Andar,\" \"Sin Competencia,\" \"Me Dejaste Sola,\" \"Ay Ombe,\" and \"Las Perchas Del Amor\" place her in the contemporary independent Dominican music scene, with a sound connected to bachata and broader Latin popular music.","type":"text"}]},{"type":"paragraph","content":[{"text":"Genoveva''s music is distributed through her own Genoveva Records presence and appears across streaming platforms with Latin, bachata, merengue, and reggaeton-related tagging. Her profile therefore belongs alongside Dominican secular vocalists and singer-songwriters whose work may touch spiritual or inspirational subjects without being defined primarily as gospel or worship ministry.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'genoveva-la-patrona';
UPDATE artists SET bio_en = 'Genoveva is the stage name of Cristina Genoveva Almonte Rodríguez, a Dominican singer-songwriter and recording artist born on August 24, 1977, in Pimentel, Duarte Province. She is best understood as a secular Latin artist with a bachata foundation, rather than as a Christian artist, even though some faith-oriented or inspirational songs may appear within her catalog.

Her public artist profiles describe an early connection to music through her school choir, where she began singing as a child, and present her as a bachata performer whose work moves through romantic, social, and everyday-life themes. Releases such as "Yo Quiero Andar," "Sin Competencia," "Me Dejaste Sola," "Ay Ombe," and "Las Perchas Del Amor" place her in the contemporary independent Dominican music scene, with a sound connected to bachata and broader Latin popular music.

Genoveva''s music is distributed through her own Genoveva Records presence and appears across streaming platforms with Latin, bachata, merengue, and reggaeton-related tagging. Her profile therefore belongs alongside Dominican secular vocalists and singer-songwriters whose work may touch spiritual or inspirational subjects without being defined primarily as gospel or worship ministry.', bio_es = NULL,
       first_name = 'Genoveva', middle_name = NULL, last_name = NULL,
       second_last_name = NULL, occupations = '["songwriter"]'::jsonb, genres = ARRAY['merengue','urban-reggaeton']::text[]
       WHERE slug = 'genoveva-la-patrona';

COMMIT;
