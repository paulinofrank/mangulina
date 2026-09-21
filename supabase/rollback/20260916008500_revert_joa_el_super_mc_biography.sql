BEGIN;

-- Revierte 20260916008500_rewrite_joa_el_super_mc_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'joa-el-super-mc' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joa-el-super-mc') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Joa El Super MC is a Dominican rapper and hip-hop artist born in 1983 in Santo Domingo. Operating in the rap, hip-hop, and urban genres, he has been part of the generation of Dominican artists who brought Spanish-language hip-hop to the forefront of the island''s youth culture. His work engages with the social realities of urban Dominican life, using rap as a vehicle for storytelling, social commentary, and cultural expression. As part of the broader Dominican urban music scene, Joa El Super MC has contributed to establishing a local hip-hop identity that draws on both international influences and distinctly Caribbean sensibilities.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'joa-el-super-mc';
UPDATE artists SET bio_en = 'Joa El Super MC is a Dominican rapper and hip-hop artist born in 1983 in Santo Domingo. Operating in the rap, hip-hop, and urban genres, he has been part of the generation of Dominican artists who brought Spanish-language hip-hop to the forefront of the island''s youth culture. His work engages with the social realities of urban Dominican life, using rap as a vehicle for storytelling, social commentary, and cultural expression. As part of the broader Dominican urban music scene, Joa El Super MC has contributed to establishing a local hip-hop identity that draws on both international influences and distinctly Caribbean sensibilities.', bio_es = NULL, first_name = 'José', middle_name = 'Manuel', last_name = 'Almonte', aliases = ARRAY['Joa']::text[], primary_role = 'singer', occupations = '["composer","lyricist"]'::jsonb WHERE slug = 'joa-el-super-mc';

COMMIT;
