BEGIN;

-- Revierte 20260915013400_rewrite_el_jeffrey_biography.sql con los documentos, campos
-- y premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-jeffrey' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-jeffrey') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"El Jeffrey, born Jeffrey Gómez in 1974 in Santiago de los Caballeros, is a Dominican merengue singer who became one of the genre''s most popular figures in the late 1990s and 2000s. Known for his charismatic stage presence and his ability to connect with audiences through high-energy performances, he built a loyal following across the Dominican Republic and in Dominican communities throughout the United States and Europe. His recordings blended the traditional merengue sound of the Cibao with contemporary production values, giving his music broad commercial appeal while retaining a distinctly Dominican character. El Jeffrey has maintained a consistent presence in the merengue world, continuing to perform and record over the course of a career that has made him one of Santiago''s most celebrated musical exports.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'el-jeffrey';
UPDATE artists SET bio_en = 'El Jeffrey, born Jeffrey Gómez in 1974 in Santiago de los Caballeros, is a Dominican merengue singer who became one of the genre''s most popular figures in the late 1990s and 2000s. Known for his charismatic stage presence and his ability to connect with audiences through high-energy performances, he built a loyal following across the Dominican Republic and in Dominican communities throughout the United States and Europe. His recordings blended the traditional merengue sound of the Cibao with contemporary production values, giving his music broad commercial appeal while retaining a distinctly Dominican character. El Jeffrey has maintained a consistent presence in the merengue world, continuing to perform and record over the course of a career that has made him one of Santiago''s most celebrated musical exports.', bio_es = NULL, first_name = 'José',
       last_name = 'García' WHERE slug = 'el-jeffrey';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'Orquesta del Año'
   AND w.year = 2005 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'el-jeffrey');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'Orquesta del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);

COMMIT;
