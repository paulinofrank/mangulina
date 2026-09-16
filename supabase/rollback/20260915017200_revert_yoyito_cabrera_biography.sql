BEGIN;

-- Revierte 20260915017200_rewrite_yoyito_cabrera_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'yoyito-cabrera' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoyito-cabrera') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Yoyito Cabrera was a pioneering Dominican musician and entertainer born in Santo Domingo in 1928. Active during the mid-twentieth century, he was part of the generation of artists who helped shape the sound and theatrical character of Dominican popular music at a time when merengue was consolidating its identity as the national dance form. Cabrera was known for his lively performances and his ability to blend musical skill with showmanship, qualities that made him a popular figure at dances, festivals, and social gatherings across the country.","type":"text"}]},{"type":"paragraph","content":[{"text":"He contributed to the rich landscape of Dominican tropical and merengue music during a period of significant cultural development, working alongside other artists who were defining the conventions of Dominican popular entertainment. He passed away in 1984, leaving behind a legacy as one of the colorful figures of the golden era of Dominican popular music.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'yoyito-cabrera';
UPDATE artists SET bio_en = 'Yoyito Cabrera was a pioneering Dominican musician and entertainer born in Santo Domingo in 1928. Active during the mid-twentieth century, he was part of the generation of artists who helped shape the sound and theatrical character of Dominican popular music at a time when merengue was consolidating its identity as the national dance form. Cabrera was known for his lively performances and his ability to blend musical skill with showmanship, qualities that made him a popular figure at dances, festivals, and social gatherings across the country.

He contributed to the rich landscape of Dominican tropical and merengue music during a period of significant cultural development, working alongside other artists who were defining the conventions of Dominican popular entertainment. He passed away in 1984, leaving behind a legacy as one of the colorful figures of the golden era of Dominican popular music.', bio_es = NULL,
       birth_year = 1928, birth_place = 'Santo Domingo', province = 'Distrito Nacional',
       date_of_birth = '1928-09-13',
       first_name = NULL, last_name = NULL, occupations = '[]'::jsonb
       WHERE slug = 'yoyito-cabrera';

COMMIT;
