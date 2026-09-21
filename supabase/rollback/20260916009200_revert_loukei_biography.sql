BEGIN;

-- Revierte 20260916009200_rewrite_loukei_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'loukei' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'loukei') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Trainer Slump is a young Dominican artist born in 2001 in Santo Domingo whose work is part of the current generation of Dominican creators developing their artistic identities within the contemporary urban music environment. His name — combining the athletic associations of training with the slump that every career inevitably encounters — suggests a self-aware, ironic persona rooted in the realities of artistic development. Growing up in Santo Domingo during the period of Dominican dembow''s global rise, Trainer Slump has absorbed the full range of contemporary Dominican musical influences and is working to develop a sound and identity that reflects his own generation''s experience and perspective.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'loukei';
UPDATE artists SET bio_en = 'Trainer Slump is a young Dominican artist born in 2001 in Santo Domingo whose work is part of the current generation of Dominican creators developing their artistic identities within the contemporary urban music environment. His name — combining the athletic associations of training with the slump that every career inevitably encounters — suggests a self-aware, ironic persona rooted in the realities of artistic development. Growing up in Santo Domingo during the period of Dominican dembow''s global rise, Trainer Slump has absorbed the full range of contemporary Dominican musical influences and is working to develop a sound and identity that reflects his own generation''s experience and perspective.', bio_es = NULL, primary_genre = 'urban-dembow', genres = ARRAY[]::text[] WHERE slug = 'loukei';

COMMIT;
