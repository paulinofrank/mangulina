BEGIN;

-- Revierte 20260916005300_rewrite_23thierno_biography.sql con los documentos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = '23thierno' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = '23thierno') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"23Thierno is a young Dominican dembow, Latin trap, and urban artist born in 2001 in San Cristóbal who participates in the genre-blending tendencies of his generation, combining the rhythmic intensity of Dominican dembow with the melodic and atmospheric qualities of Latin trap. The name itself — suggesting a combination of numeric identity and African heritage — reflects the multicultural influences that shape young Dominican artists in the twenty-first century. His music is part of the generational shift in Dominican urban music toward a sound that absorbs trap, drill, and other international urban influences while retaining the Caribbean rhythmic core that makes Dominican dembow distinctive. 23Thierno represents the next wave of Dominican artists redefining the boundaries of the genre.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = '23thierno';
UPDATE artists SET bio_en = '23Thierno is a young Dominican dembow, Latin trap, and urban artist born in 2001 in San Cristóbal who participates in the genre-blending tendencies of his generation, combining the rhythmic intensity of Dominican dembow with the melodic and atmospheric qualities of Latin trap. The name itself — suggesting a combination of numeric identity and African heritage — reflects the multicultural influences that shape young Dominican artists in the twenty-first century. His music is part of the generational shift in Dominican urban music toward a sound that absorbs trap, drill, and other international urban influences while retaining the Caribbean rhythmic core that makes Dominican dembow distinctive. 23Thierno represents the next wave of Dominican artists redefining the boundaries of the genre.', bio_es = NULL WHERE slug = '23thierno';

COMMIT;
