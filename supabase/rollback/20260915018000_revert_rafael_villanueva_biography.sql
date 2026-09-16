BEGIN;

-- Revierte 20260915018000_rewrite_rafael_villanueva_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'rafael-villanueva' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-villanueva') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Rafael Villanueva was a Dominican musician born in Santo Domingo in 1947 who contributed to the vibrant landscape of Dominican popular music during the second half of the twentieth century. His career as a performer placed him within the merengue and tropical traditions that defined Dominican popular culture from the 1970s onward. Working in the capital, he was part of the busy Santo Domingo music scene where bands, orchestras, and solo artists competed for audiences at clubs, public events, and on the radio.","type":"text"}]},{"type":"paragraph","content":[{"text":"Villanueva was active during a period when Dominican music was expanding its reach both nationally and internationally. His life was cut short when he passed away in 1995 at the age of forty-eight, leaving behind a legacy among those who followed Dominican popular music in its golden years.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'rafael-villanueva';
UPDATE artists SET bio_en = 'Rafael Villanueva was a Dominican musician born in Santo Domingo in 1947 who contributed to the vibrant landscape of Dominican popular music during the second half of the twentieth century. His career as a performer placed him within the merengue and tropical traditions that defined Dominican popular culture from the 1970s onward. Working in the capital, he was part of the busy Santo Domingo music scene where bands, orchestras, and solo artists competed for audiences at clubs, public events, and on the radio.

Villanueva was active during a period when Dominican music was expanding its reach both nationally and internationally. His life was cut short when he passed away in 1995 at the age of forty-eight, leaving behind a legacy among those who followed Dominican popular music in its golden years.', bio_es = NULL,
       middle_name = NULL, second_last_name = NULL,
       date_of_death = '1995-12-02', primary_genre = 'merengue',
       occupations = '["conductor"]'::jsonb
       WHERE slug = 'rafael-villanueva';

COMMIT;
