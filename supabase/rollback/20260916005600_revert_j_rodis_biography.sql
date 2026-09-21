BEGIN;

-- Revierte 20260916005600_rewrite_j_rodis_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jorge-luis-rosario-rodriguez' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-luis-rosario-rodriguez') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jorge Luis Rosario Rodríguez is a Dominican classical and academic musician based in Santo Domingo whose dedication to formal European art music traditions represents a commitment to the serious, institutionally supported side of Dominican musical culture. Working in classical and academic music requires navigating a scene that lacks the commercial infrastructure supporting popular genres, and Rosario Rodríguez has contributed to sustaining that tradition through his performances and musical work. His connection to Santo Domingo places him within the capital''s artistic community, where conservatories, universities, and cultural institutions provide the infrastructure for classical music to survive and occasionally flourish alongside the dominant popular and tropical genres.","type":"text"}]}]}'::jsonb, 'published', id, 3 FROM artists WHERE slug = 'jorge-luis-rosario-rodriguez';
UPDATE artists SET bio_en = 'Jorge Luis Rosario Rodríguez is a Dominican classical and academic musician based in Santo Domingo whose dedication to formal European art music traditions represents a commitment to the serious, institutionally supported side of Dominican musical culture. Working in classical and academic music requires navigating a scene that lacks the commercial infrastructure supporting popular genres, and Rosario Rodríguez has contributed to sustaining that tradition through his performances and musical work. His connection to Santo Domingo places him within the capital''s artistic community, where conservatories, universities, and cultural institutions provide the infrastructure for classical music to survive and occasionally flourish alongside the dominant popular and tropical genres.', bio_es = NULL, name = 'Jorge Luis Rosario Rodríguez', sort_name = 'Rosario Rodríguez, Jorge Luis',
       stage_name = 'Jorge Luis Rosario Rodríguez', genres = ARRAY['instrumental-classical']::text[], artist_tags = ARRAY['secular','instrumental']::text[],
       occupations = '["musician"]'::jsonb WHERE slug = 'jorge-luis-rosario-rodriguez';

COMMIT;
