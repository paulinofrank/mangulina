BEGIN;

-- Revierte 20260916001500_rewrite_adriano_ventura_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'adriano-ventura' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'adriano-ventura') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Adriano Ventura is a Dominican musician whose work has spanned merengue, folklore, and tropical music, maintaining a deep connection to the traditional sounds that form the cultural bedrock of Dominican musical identity. His engagement with folklore alongside more commercially oriented merengue and tropical styles reflects an artist who values the full spectrum of Dominican musical heritage, from the sacred and communal rituals expressed through Afro-Dominican folk traditions to the festive dance music that fills the country''s clubs and public celebrations. Through performance and recording, Ventura has contributed to the preservation and living transmission of Dominican musical culture in its many dimensions.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'adriano-ventura';
UPDATE artists SET bio_en = 'Adriano Ventura is a Dominican musician whose work has spanned merengue, folklore, and tropical music, maintaining a deep connection to the traditional sounds that form the cultural bedrock of Dominican musical identity. His engagement with folklore alongside more commercially oriented merengue and tropical styles reflects an artist who values the full spectrum of Dominican musical heritage, from the sacred and communal rituals expressed through Afro-Dominican folk traditions to the festive dance music that fills the country''s clubs and public celebrations. Through performance and recording, Ventura has contributed to the preservation and living transmission of Dominican musical culture in its many dimensions.', bio_es = NULL,
       birth_place = 'Santiago de los Caballeros', primary_genre = 'merengue', genres = ARRAY['folklore']::text[]
       WHERE slug = 'adriano-ventura';

COMMIT;
