BEGIN;

-- Revierte 20260915017400_rewrite_bienvenido_brens_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'bienvenido-brens' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bienvenido-brens') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Bienvenido Brens was a Dominican musician born in 1925 in Pimentel, the Duarte province town in the Cibao, whose career in bolero, merengue, and tropical music contributed to the mid-twentieth century flowering of Dominican popular song. Pimentel, a small Cibao community, was part of the musical ecosystem that produced many important Dominican artists, and Brens grew up within that tradition before pursuing a professional career that brought his voice to wider audiences. His work in bolero placed him within the great Latin American romantic tradition that dominated popular music across the region in the postwar decades, while his merengue recordings connected him to the national music that was defining Dominican cultural identity during the same period. He passed away in 2007, leaving behind a legacy rooted in the golden age of Dominican popular song.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bienvenido-brens';
UPDATE artists SET bio_en = 'Bienvenido Brens was a Dominican musician born in 1925 in Pimentel, the Duarte province town in the Cibao, whose career in bolero, merengue, and tropical music contributed to the mid-twentieth century flowering of Dominican popular song. Pimentel, a small Cibao community, was part of the musical ecosystem that produced many important Dominican artists, and Brens grew up within that tradition before pursuing a professional career that brought his voice to wider audiences. His work in bolero placed him within the great Latin American romantic tradition that dominated popular music across the region in the postwar decades, while his merengue recordings connected him to the national music that was defining Dominican cultural identity during the same period. He passed away in 2007, leaving behind a legacy rooted in the golden age of Dominican popular song.', bio_es = NULL,
       date_of_birth = '1925-01-22'
       WHERE slug = 'bienvenido-brens';

COMMIT;
