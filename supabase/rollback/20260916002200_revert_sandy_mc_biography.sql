BEGIN;

-- Revierte 20260916002200_rewrite_sandy_mc_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sandy-mc' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sandy-mc') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Sandy was a beloved Dominican entertainer whose dynamic stage presence and versatile musical talent made her one of the most popular performers in the country''s commercial music scene for nearly three decades. Born in 1972 in Santo Domingo, she established herself as a singer and television personality with a natural ability to connect with audiences that went beyond mere vocal talent.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her warmth, humor, and genuine engagement with fans made her a figure of genuine popular affection, and her performances combined musical entertainment with the kind of personal charisma that is difficult to teach. Sandy was particularly beloved for her live shows, which were celebrations of Dominican culture and popular music that left audiences feeling genuinely uplifted. She worked across multiple genres and formats, adapting to different performance contexts with ease.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her death in 2020 was a profound loss for Dominican popular culture, and the outpouring of tributes from fellow artists, fans, and public figures reflected the extraordinary depth of affection in which she was held. She is remembered as one of the most genuinely beloved entertainers the Dominican Republic has produced.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'sandy-mc';
UPDATE artists SET bio_en = 'Sandy was a beloved Dominican entertainer whose dynamic stage presence and versatile musical talent made her one of the most popular performers in the country''s commercial music scene for nearly three decades. Born in 1972 in Santo Domingo, she established herself as a singer and television personality with a natural ability to connect with audiences that went beyond mere vocal talent.

Her warmth, humor, and genuine engagement with fans made her a figure of genuine popular affection, and her performances combined musical entertainment with the kind of personal charisma that is difficult to teach. Sandy was particularly beloved for her live shows, which were celebrations of Dominican culture and popular music that left audiences feeling genuinely uplifted. She worked across multiple genres and formats, adapting to different performance contexts with ease.

Her death in 2020 was a profound loss for Dominican popular culture, and the outpouring of tributes from fellow artists, fans, and public figures reflected the extraordinary depth of affection in which she was held. She is remembered as one of the most genuinely beloved entertainers the Dominican Republic has produced.', bio_es = NULL,
       middle_name = NULL, second_last_name = NULL,
       primary_genre = 'urbano', genres = ARRAY[]::text[]
       WHERE slug = 'sandy-mc';

COMMIT;
