BEGIN;

-- Revierte 20260914010600_rewrite_vinicio_franco_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'vinicio-franco' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'vinicio-franco') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Vinicio Franco was a Dominican musician born in Puerto Plata in 1933, whose long career connected the golden age of Dominican popular music to the contemporary era. Hailing from the northern coastal city that gave its name to one of the country''s most beloved musical traditions, Franco was part of a vibrant regional music scene that blended merengue, tropical, and Caribbean rhythms with local character. Over the course of his career he performed and recorded music that reflected the festive and emotional spirit of Dominican culture, earning respect from audiences and fellow musicians alike. He lived to the age of eighty-seven, passing away in 2020, and his longevity in both life and career made him a witness to extraordinary transformations in Dominican music and society.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'vinicio-franco';
UPDATE artists SET bio_en = 'Vinicio Franco was a Dominican musician born in Puerto Plata in 1933, whose long career connected the golden age of Dominican popular music to the contemporary era. Hailing from the northern coastal city that gave its name to one of the country''s most beloved musical traditions, Franco was part of a vibrant regional music scene that blended merengue, tropical, and Caribbean rhythms with local character. Over the course of his career he performed and recorded music that reflected the festive and emotional spirit of Dominican culture, earning respect from audiences and fellow musicians alike. He lived to the age of eighty-seven, passing away in 2020, and his longevity in both life and career made him a witness to extraordinary transformations in Dominican music and society.', bio_es = NULL,
       first_name = NULL, middle_name = NULL, last_name = NULL,
       second_last_name = NULL, aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb WHERE slug = 'vinicio-franco';

COMMIT;
