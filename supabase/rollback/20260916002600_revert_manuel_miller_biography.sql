BEGIN;

-- Revierte 20260916002600_rewrite_manuel_miller_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-miller' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'manuel-miller') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Manuel Miller, who performs and produces under the name DJ Miller, is among the most enduring figures in Dominican electronic music. Born Manuel de Jesús Díaz Miller in Santo Domingo, he began DJing in 1996 at a moment when the island''s club culture was still finding its footing in house and electronic dance music. By the late 1990s he had transitioned into production, helping shape a homegrown electronic scene that often existed in the shadow of the country''s dominant merengue and bachata industries.","type":"text"}]},{"type":"paragraph","content":[{"text":"His residencies at major Santo Domingo nightclubs became proving grounds for new sounds, while his presence on radio and television gave electronic music a legitimacy it had not previously enjoyed in the Dominican mainstream. Beyond performing, DJ Miller invested in the next generation of the scene by working as an electronic music educator, passing on technical skills and aesthetic values to emerging producers and DJs.","type":"text"}]},{"type":"paragraph","content":[{"text":"His three-decade career stands as a testament to the depth of Dominican musical culture beyond its most internationally recognized genres.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manuel-miller';
UPDATE artists SET bio_en = 'Manuel Miller, who performs and produces under the name DJ Miller, is among the most enduring figures in Dominican electronic music. Born Manuel de Jesús Díaz Miller in Santo Domingo, he began DJing in 1996 at a moment when the island''s club culture was still finding its footing in house and electronic dance music. By the late 1990s he had transitioned into production, helping shape a homegrown electronic scene that often existed in the shadow of the country''s dominant merengue and bachata industries.

His residencies at major Santo Domingo nightclubs became proving grounds for new sounds, while his presence on radio and television gave electronic music a legitimacy it had not previously enjoyed in the Dominican mainstream. Beyond performing, DJ Miller invested in the next generation of the scene by working as an electronic music educator, passing on technical skills and aesthetic values to emerging producers and DJs.

His three-decade career stands as a testament to the depth of Dominican musical culture beyond its most internationally recognized genres.', bio_es = NULL, name = 'DJ Miller',
       aliases = ARRAY['Manuel Miller','DJ Mastermix']::text[], primary_genre = NULL,
       occupations = '["producer"]'::jsonb
       WHERE slug = 'manuel-miller';

COMMIT;
