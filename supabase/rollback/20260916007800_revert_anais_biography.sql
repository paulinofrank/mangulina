BEGIN;

-- Revierte 20260916007800_rewrite_anais_biography.sql con los documentos y campos previos.

DELETE FROM artist_awards WHERE id IN ('7b9b4c87-d963-4e48-987e-fc8bfd13bed7', 'c20be0c8-545a-4f03-a792-8f86bd32a80d');
DELETE FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Female Pop Vocal Album' AND NOT EXISTS (SELECT 1 FROM artist_awards WHERE category_id = award_categories.id);
DELETE FROM award_categories WHERE award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e' AND name = 'Artista Destacada en el Extranjero' AND NOT EXISTS (SELECT 1 FROM artist_awards WHERE category_id = award_categories.id);

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'anais' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'anais') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Anaís is a Dominican singer born in 1984 in Santo Domingo whose artistry moves across pop latino, ballad, and tropical music. With a voice capable of both delicacy and power, she entered the Dominican music scene with recordings that showcased her range and emotional expressiveness. Her work in the pop latino and ballad traditions placed her within a lineage of Dominican female vocalists who have brought sophistication and feeling to the island''s popular music. Anaís has performed at major stages in the Dominican Republic and has built a following among listeners who appreciate polished, heartfelt vocal performance rooted in the Latin pop tradition.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'anais';
UPDATE artists SET bio_en = 'Anaís is a Dominican singer born in 1984 in Santo Domingo whose artistry moves across pop latino, ballad, and tropical music. With a voice capable of both delicacy and power, she entered the Dominican music scene with recordings that showcased her range and emotional expressiveness. Her work in the pop latino and ballad traditions placed her within a lineage of Dominican female vocalists who have brought sophistication and feeling to the island''s popular music. Anaís has performed at major stages in the Dominican Republic and has built a following among listeners who appreciate polished, heartfelt vocal performance rooted in the Latin pop tradition.', bio_es = NULL, second_last_name = NULL, artist_tags = ARRAY['secular']::text[] WHERE slug = 'anais';

COMMIT;
