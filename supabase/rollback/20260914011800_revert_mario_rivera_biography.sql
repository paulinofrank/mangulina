BEGIN;

-- Revierte 20260914011800_rewrite_mario_rivera_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'mario-rivera' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mario-rivera') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Mario Rivera was a Dominican saxophonist of exceptional talent whose career unfolded largely in New York City, the capital of Latin jazz and salsa during his most productive decades. Born in Santo Domingo in 1939, Rivera relocated to the United States and immersed himself in the rich musical ecosystem of the city, working alongside some of the greatest names in jazz and Latin music.","type":"text"}]},{"type":"paragraph","content":[{"text":"He became known for his mastery of multiple reed instruments and his ability to move with authority between straight-ahead jazz, Latin jazz, salsa, and merengue jazz — a synthesis that reflected both his Dominican roots and his deep absorption of the American jazz tradition. Rivera performed with figures including Tito Puente, one of Latin music''s most celebrated bandleaders, and his presence on recordings and in live settings cemented his reputation as one of the finest Dominican instrumentalists of his generation.","type":"text"}]},{"type":"paragraph","content":[{"text":"He passed away in 2007, leaving behind a body of work that documented the creative possibilities at the intersection of Caribbean and American musical cultures.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'mario-rivera';
UPDATE artists SET bio_en = 'Mario Rivera was a Dominican saxophonist of exceptional talent whose career unfolded largely in New York City, the capital of Latin jazz and salsa during his most productive decades. Born in Santo Domingo in 1939, Rivera relocated to the United States and immersed himself in the rich musical ecosystem of the city, working alongside some of the greatest names in jazz and Latin music.

He became known for his mastery of multiple reed instruments and his ability to move with authority between straight-ahead jazz, Latin jazz, salsa, and merengue jazz — a synthesis that reflected both his Dominican roots and his deep absorption of the American jazz tradition. Rivera performed with figures including Tito Puente, one of Latin music''s most celebrated bandleaders, and his presence on recordings and in live settings cemented his reputation as one of the finest Dominican instrumentalists of his generation.

He passed away in 2007, leaving behind a body of work that documented the creative possibilities at the intersection of Caribbean and American musical cultures.', bio_es = NULL,
       occupations = '["composer","saxophonist","arranger"]'::jsonb, instruments = ARRAY[]::text[] WHERE slug = 'mario-rivera';

COMMIT;
