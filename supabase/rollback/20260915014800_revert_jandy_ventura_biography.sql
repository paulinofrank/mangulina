BEGIN;

-- Revierte 20260915014800_rewrite_jandy_ventura_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jandy-ventura' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jandy-ventura') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jandy Ventura is a Dominican merengue and tropical artist born in 1974 in Santo Domingo who carries forward the musical legacy of one of the most celebrated families in Dominican music history. As the son of Johnny Ventura, the legendary merengue star who transformed the genre in the 1960s and went on to become a beloved public figure in the Dominican Republic, Jandy grew up at the center of Dominican musical life with access to the finest musicians, producers, and musical knowledge the country had to offer. Rather than simply inheriting his father''s audience, Jandy Ventura worked to establish his own artistic identity, developing as a performer and recording artist in the merengue and tropical traditions with a style that reflected both his heritage and his own generation''s musical sensibilities. He has performed at major venues and festivals, released albums that earned him recognition in his own right, and carried the Ventura name forward with energy and commitment.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jandy-ventura';
UPDATE artists SET bio_en = 'Jandy Ventura is a Dominican merengue and tropical artist born in 1974 in Santo Domingo who carries forward the musical legacy of one of the most celebrated families in Dominican music history. As the son of Johnny Ventura, the legendary merengue star who transformed the genre in the 1960s and went on to become a beloved public figure in the Dominican Republic, Jandy grew up at the center of Dominican musical life with access to the finest musicians, producers, and musical knowledge the country had to offer. Rather than simply inheriting his father''s audience, Jandy Ventura worked to establish his own artistic identity, developing as a performer and recording artist in the merengue and tropical traditions with a style that reflected both his heritage and his own generation''s musical sensibilities. He has performed at major venues and festivals, released albums that earned him recognition in his own right, and carried the Ventura name forward with energy and commitment.', bio_es = NULL, first_name = 'Juan',
       last_name = 'Ventura',
       second_last_name = 'Flores' WHERE slug = 'jandy-ventura';

COMMIT;
