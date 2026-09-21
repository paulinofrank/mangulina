BEGIN;

-- Revierte 20260916009800_rewrite_rxelartista_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'rxelartista' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rxelartista') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"RXelArtista is a young Dominican artist born in 2000 in Santo Domingo who is developing his creative identity within the contemporary Dominican popular music scene. His stage name — combining an enigmatic prefix with the proud designation of Artist — signals a self-awareness about the creative persona he is constructing, the kind of branding consciousness that is characteristic of a generation that has grown up with social media as a primary medium for self-presentation. Working in the urban and popular music environment of Santo Domingo, RXelArtista is part of the continuous flow of young Dominican talent that has made the country''s music scene one of the most dynamic and productive in the Caribbean.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'rxelartista';
UPDATE artists SET bio_en = 'RXelArtista is a young Dominican artist born in 2000 in Santo Domingo who is developing his creative identity within the contemporary Dominican popular music scene. His stage name — combining an enigmatic prefix with the proud designation of Artist — signals a self-awareness about the creative persona he is constructing, the kind of branding consciousness that is characteristic of a generation that has grown up with social media as a primary medium for self-presentation. Working in the urban and popular music environment of Santo Domingo, RXelArtista is part of the continuous flow of young Dominican talent that has made the country''s music scene one of the most dynamic and productive in the Caribbean.', bio_es = NULL, aliases = ARRAY[]::text[] WHERE slug = 'rxelartista';

COMMIT;
