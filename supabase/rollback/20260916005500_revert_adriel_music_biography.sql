BEGIN;

-- Revierte 20260916005500_rewrite_adriel_music_biography.sql con los documentos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'adriel-music' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'adriel-music') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Adriel is a Dominican artist working in the Latin pop, R&B, and urban traditions, connected to the creative music community of Santo Domingo. His musical work reflects the current landscape of Dominican popular music, where the boundaries between Latin pop, R&B, and urban sounds are increasingly fluid and where younger artists draw freely on an international palette of influences while maintaining connections to the rhythms and sensibilities of their home culture. Adriel brings a smooth vocal style and a contemporary production aesthetic to his recordings, placing him in the broad mainstream of twenty-first century Dominican popular music. His connections to the Santo Domingo music scene situate him within one of the Caribbean''s most vibrant and productive musical environments.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'adriel-music';
UPDATE artists SET bio_en = 'Adriel is a Dominican artist working in the Latin pop, R&B, and urban traditions, connected to the creative music community of Santo Domingo. His musical work reflects the current landscape of Dominican popular music, where the boundaries between Latin pop, R&B, and urban sounds are increasingly fluid and where younger artists draw freely on an international palette of influences while maintaining connections to the rhythms and sensibilities of their home culture. Adriel brings a smooth vocal style and a contemporary production aesthetic to his recordings, placing him in the broad mainstream of twenty-first century Dominican popular music. His connections to the Santo Domingo music scene situate him within one of the Caribbean''s most vibrant and productive musical environments.', bio_es = NULL WHERE slug = 'adriel-music';

COMMIT;
