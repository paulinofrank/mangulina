BEGIN;

-- Revierte 20260916004600_rewrite_alih_jey_biography.sql con los documentos y los campos previos.

DELETE FROM artist_awards WHERE id IN ('5ba16080-6cc3-4955-b555-456873194e0e', '439024ad-0de4-4ab5-9e93-bd1e9f3b9ed6');
DELETE FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Rock Solo Vocal Album'
  AND NOT EXISTS (SELECT 1 FROM artist_awards WHERE category_id = award_categories.id);
DELETE FROM award_categories WHERE award_id = '39b84fb1-2924-4389-a3d1-51cfb3688934' AND name = 'Award-Winning Song'
  AND NOT EXISTS (SELECT 1 FROM artist_awards WHERE category_id = award_categories.id);
DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'alih-jey' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'alih-jey') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Alih Jey is a Dominican singer and musician born in 1982 in Santo Domingo who has pursued a creative path quite different from the merengue and bachata traditions most associated with Dominican music. Working in rock alternativo, indie pop, and Latin pop, she has built a career that connects her to the broader Latin alternative music movement — a scene defined by its independence from mainstream commercial formulas and its embrace of rock, folk, and experimental influences. Alih Jey''s music is introspective and melodically sophisticated, drawing on international indie sensibilities while retaining a Latin emotional core. She has released recordings and performed at alternative music festivals, building a following among listeners who seek something beyond the dance floor in their Dominican music experience.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alih-jey';
UPDATE artists SET bio_en = 'Alih Jey is a Dominican singer and musician born in 1982 in Santo Domingo who has pursued a creative path quite different from the merengue and bachata traditions most associated with Dominican music. Working in rock alternativo, indie pop, and Latin pop, she has built a career that connects her to the broader Latin alternative music movement — a scene defined by its independence from mainstream commercial formulas and its embrace of rock, folk, and experimental influences. Alih Jey''s music is introspective and melodically sophisticated, drawing on international indie sensibilities while retaining a Latin emotional core. She has released recordings and performed at alternative music festivals, building a following among listeners who seek something beyond the dance floor in their Dominican music experience.', bio_es = NULL, first_name = 'Alissa',
       middle_name = 'Jeylani', last_name = 'García', second_last_name = NULL,
       aliases = ARRAY[]::text[], date_of_birth = '1982-02-04', birth_year = 1982,
       occupations = '["songwriter","guitarist"]'::jsonb
       WHERE slug = 'alih-jey';

COMMIT;
