BEGIN;

-- Revierte 20260916007000_rewrite_johandy_urena_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johandy-urena' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johandy-urena') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Johandy Ureña is a Dominican jazz musician based in Santo Domingo whose work in jazz latino, jazz, and fusion contributes to the active but often underrecognized jazz culture of the Dominican Republic. Jazz in the Dominican Republic has developed in dialogue with the country''s dominant popular traditions, and artists like Ureña who work primarily in jazz and fusion play an important role in maintaining space for improvisation, harmonic complexity, and the jazz aesthetic within a musical environment that could easily crowd out those values. His connection to Santo Domingo places him at the center of Dominican jazz life, and his work in fusion suggests an artist willing to engage with the full range of contemporary musical possibility.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'johandy-urena';
UPDATE artists SET bio_en = 'Johandy Ureña is a Dominican jazz musician based in Santo Domingo whose work in jazz latino, jazz, and fusion contributes to the active but often underrecognized jazz culture of the Dominican Republic. Jazz in the Dominican Republic has developed in dialogue with the country''s dominant popular traditions, and artists like Ureña who work primarily in jazz and fusion play an important role in maintaining space for improvisation, harmonic complexity, and the jazz aesthetic within a musical environment that could easily crowd out those values. His connection to Santo Domingo places him at the center of Dominican jazz life, and his work in fusion suggests an artist willing to engage with the full range of contemporary musical possibility.', bio_es = NULL, primary_genre = 'jazz', genres = ARRAY['fusion']::text[], artist_tags = ARRAY['secular','instrumental']::text[], occupations = '["drummer"]'::jsonb WHERE slug = 'johandy-urena';

COMMIT;
