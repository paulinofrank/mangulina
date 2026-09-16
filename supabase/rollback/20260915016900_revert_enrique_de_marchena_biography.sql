BEGIN;

-- Revierte 20260915016900_rewrite_enrique_de_marchena_biography.sql con los documentos, premios y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM artist_awards WHERE artist_id = (SELECT id FROM artists WHERE slug = 'enrique-de-marchena')
   AND year IN (1979, 1982);
DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'enrique-de-marchena' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'enrique-de-marchena') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jaime Enrique de Marchena was a Dominican composer and musician based in Santo Domingo whose work inhabited the classical and Romantic traditions that held prestige in Dominican cultural circles during his active years. Working in a country where music was often divided between the formal European tradition and the vibrant popular vernacular of merengue and bolero, De Marchena represented the classical side of that divide with dedication and craft. His compositions in the Romantic idiom drew on a tradition of melody and harmonic development that valued emotional directness and formal elegance. While detailed biographical records of his life and specific works are limited in widely available sources, his presence in the Dominican classical repertoire marks him as a contributor to the country''s serious music culture, one of many composers who worked to ensure that Santo Domingo had an artistic life that extended beyond popular entertainment.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'enrique-de-marchena';
UPDATE artists SET bio_en = 'Jaime Enrique de Marchena was a Dominican composer and musician based in Santo Domingo whose work inhabited the classical and Romantic traditions that held prestige in Dominican cultural circles during his active years. Working in a country where music was often divided between the formal European tradition and the vibrant popular vernacular of merengue and bolero, De Marchena represented the classical side of that divide with dedication and craft. His compositions in the Romantic idiom drew on a tradition of melody and harmonic development that valued emotional directness and formal elegance. While detailed biographical records of his life and specific works are limited in widely available sources, his presence in the Dominican classical repertoire marks him as a contributor to the country''s serious music culture, one of many composers who worked to ensure that Santo Domingo had an artistic life that extended beyond popular entertainment.', bio_es = NULL, occupations = '["musician"]'::jsonb
       WHERE slug = 'enrique-de-marchena';

COMMIT;
