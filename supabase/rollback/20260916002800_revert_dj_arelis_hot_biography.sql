BEGIN;

-- Revierte 20260916002800_rewrite_dj_arelis_hot_biography.sql con los documentos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'dj-arelis-hot' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'dj-arelis-hot') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"DJ Arelis Hot, born Arelis Hernandez Gomez in 1975 in San Francisco de Macorís, is a multifaceted Dominican entertainer who has carved out a distinctive niche in the country''s urban music world. Active since the late 2000s, she has worn many hats — DJ, singer, songwriter, YouTuber, and producer — building an audience through a willingness to work across a remarkably broad range of sounds including Dominican urban music, rap, hip hop, romantic reggaeton, R&B, soul, and merengue.","type":"text"}]},{"type":"paragraph","content":[{"text":"Coming from San Francisco de Macorís, a city with its own rich musical heritage in the Cibao region, Arelis brought regional flavor to her work even as she embraced contemporary urban styles. Her YouTube presence became an important vehicle for reaching fans directly, reflecting a generation of Dominican artists who understood that digital platforms were as important as radio or television for building a career. Her output blends energy and eclecticism, making her a singular voice in Dominican urban entertainment.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dj-arelis-hot';
UPDATE artists SET bio_en = 'DJ Arelis Hot, born Arelis Hernandez Gomez in 1975 in San Francisco de Macorís, is a multifaceted Dominican entertainer who has carved out a distinctive niche in the country''s urban music world. Active since the late 2000s, she has worn many hats — DJ, singer, songwriter, YouTuber, and producer — building an audience through a willingness to work across a remarkably broad range of sounds including Dominican urban music, rap, hip hop, romantic reggaeton, R&B, soul, and merengue.

Coming from San Francisco de Macorís, a city with its own rich musical heritage in the Cibao region, Arelis brought regional flavor to her work even as she embraced contemporary urban styles. Her YouTube presence became an important vehicle for reaching fans directly, reflecting a generation of Dominican artists who understood that digital platforms were as important as radio or television for building a career. Her output blends energy and eclecticism, making her a singular voice in Dominican urban entertainment.', bio_es = NULL WHERE slug = 'dj-arelis-hot';

COMMIT;
