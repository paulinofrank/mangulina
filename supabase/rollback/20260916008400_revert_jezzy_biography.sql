BEGIN;

-- Revierte 20260916008400_rewrite_jezzy_biography.sql con los documentos y campos previos.

DELETE FROM artist_awards WHERE id IN ('25b3cf57-2015-424c-aea9-eff2d2c75aa1', 'ebe4805a-688f-4bfc-9bfe-2d661ee28f9f');
DELETE FROM award_categories WHERE award_id = '8304c63b-ff51-40ed-80bb-ea7c4079ca6f' AND name = 'Mejor Canción Urbano Trap' AND NOT EXISTS (SELECT 1 FROM artist_awards WHERE category_id = award_categories.id);

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jezzy' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jezzy') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jezzy is a young Dominican rap and hip hop artist born in 2001 in Santo Domingo who has emerged within the generation of Dominican urban artists shaped by the full maturity of the local hip hop scene. Born into a digital era where American rap, Dominican dembow, and Latin trap are equally accessible on the same platforms, Jezzy brings a perspective shaped by all three while developing a voice that speaks to the specific realities of growing up in the Dominican capital. His work in rap and hip hop contributes to the ongoing conversation within Dominican urban culture about identity, aspiration, and the possibilities of creative expression for young people from the island''s working-class communities.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jezzy';
UPDATE artists SET bio_en = 'Jezzy is a young Dominican rap and hip hop artist born in 2001 in Santo Domingo who has emerged within the generation of Dominican urban artists shaped by the full maturity of the local hip hop scene. Born into a digital era where American rap, Dominican dembow, and Latin trap are equally accessible on the same platforms, Jezzy brings a perspective shaped by all three while developing a voice that speaks to the specific realities of growing up in the Dominican capital. His work in rap and hip hop contributes to the ongoing conversation within Dominican urban culture about identity, aspiration, and the possibilities of creative expression for young people from the island''s working-class communities.', bio_es = NULL, first_name = NULL, middle_name = NULL, last_name = NULL, second_last_name = NULL, aliases = ARRAY[]::text[], primary_genre = 'urban-rap-hip-hop', genres = ARRAY['urbano']::text[], artist_tags = ARRAY['secular','emerging']::text[] WHERE slug = 'jezzy';

COMMIT;
