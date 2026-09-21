BEGIN;

-- Revierte 20260916006200_rewrite_archaios_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'archaios' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'archaios') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Archiaos is a Dominican artist working in metal experimental, rock, and alternative music whose work represents the underground extreme and experimental music community that exists at the margins of Dominican popular culture. In a country where the dominant sounds are merengue, bachata, and dembow, artists like Archiaos occupy a deliberate counterposition, choosing sonic confrontation and genre experimentation over commercial accessibility. Metal experimental as a genre encompasses some of the most demanding and unconventional music being made anywhere, and Archiaos''s engagement with it reflects a genuine commitment to sound as a medium for radical creative expression. His work enriches the Dominican musical ecosystem by demonstrating its capacity to contain multitudes.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'archaios';
UPDATE artists SET bio_en = 'Archiaos is a Dominican artist working in metal experimental, rock, and alternative music whose work represents the underground extreme and experimental music community that exists at the margins of Dominican popular culture. In a country where the dominant sounds are merengue, bachata, and dembow, artists like Archiaos occupy a deliberate counterposition, choosing sonic confrontation and genre experimentation over commercial accessibility. Metal experimental as a genre encompasses some of the most demanding and unconventional music being made anywhere, and Archiaos''s engagement with it reflects a genuine commitment to sound as a medium for radical creative expression. His work enriches the Dominican musical ecosystem by demonstrating its capacity to contain multitudes.', bio_es = NULL, birth_place = NULL, province = NULL,
       genres = ARRAY[]::text[], birth_year = NULL, artist_tags = ARRAY['secular','emerging']::text[] WHERE slug = 'archaios';

COMMIT;
