BEGIN;

-- Revierte 20260915015400_rewrite_jonatan_pina_duluc_biography.sql con los documentos y premios
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM artist_awards WHERE artist_id = (SELECT id FROM artists WHERE slug = 'jonatan-pina-duluc')
   AND year = 2015 AND work = 'Sonata para Violonchelo y Piano';
DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jonatan-pina-duluc' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jonatan-pina-duluc') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jonatan Piña Duluc is a Dominican instrumental musician from Santiago de los Caballeros whose work in jazz, fusion, and rock places him at the more experimental and genre-crossing edge of Dominican music. Santiago has long been associated with the merengue típico tradition, but the city also nurtures musicians who engage with rock, jazz, and the intersections between them, and Piña Duluc is part of that less-visible but creatively significant community. His fusion of jazz harmony with rock energy and the rhythmic sensibility of Dominican music creates a sound that is both technically demanding and emotionally expressive. He represents the adventurous wing of Santiago''s musical culture, contributing to a scene that is more diverse than its most famous genre suggests.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jonatan-pina-duluc';
UPDATE artists SET bio_en = 'Jonatan Piña Duluc is a Dominican instrumental musician from Santiago de los Caballeros whose work in jazz, fusion, and rock places him at the more experimental and genre-crossing edge of Dominican music. Santiago has long been associated with the merengue típico tradition, but the city also nurtures musicians who engage with rock, jazz, and the intersections between them, and Piña Duluc is part of that less-visible but creatively significant community. His fusion of jazz harmony with rock energy and the rhythmic sensibility of Dominican music creates a sound that is both technically demanding and emotionally expressive. He represents the adventurous wing of Santiago''s musical culture, contributing to a scene that is more diverse than its most famous genre suggests.', bio_es = NULL WHERE slug = 'jonatan-pina-duluc';

COMMIT;
