BEGIN;

-- Revierte 20260916000500_rewrite_felix_cumbe_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'felix-cumbe' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-cumbe') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Félix Cumbé was a musician born in Haiti in 1964 who built his career within the Dominican music world, working across the genres of merengue, bachata, and tropical. His Haitian origins and Dominican career made him part of the complex cross-border musical culture of Hispaniola, the island shared by Haiti and the Dominican Republic, where musical influences have always flowed in both directions despite the political tensions that divide the two nations. Cumbé developed as an artist within the Dominican popular music ecosystem, contributing recordings and performances that reflected both his personal background and his deep immersion in Dominican musical traditions. He passed away in 2025, leaving behind a body of work that crossed the island''s cultural frontiers.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'felix-cumbe';
UPDATE artists SET bio_en = 'Félix Cumbé was a musician born in Haiti in 1964 who built his career within the Dominican music world, working across the genres of merengue, bachata, and tropical. His Haitian origins and Dominican career made him part of the complex cross-border musical culture of Hispaniola, the island shared by Haiti and the Dominican Republic, where musical influences have always flowed in both directions despite the political tensions that divide the two nations. Cumbé developed as an artist within the Dominican popular music ecosystem, contributing recordings and performances that reflected both his personal background and his deep immersion in Dominican musical traditions. He passed away in 2025, leaving behind a body of work that crossed the island''s cultural frontiers.', bio_es = NULL,
       first_name = 'Félix', last_name = 'Cumbé', second_last_name = NULL,
       birth_place = 'Haití', occupations = '["composer"]'::jsonb
       WHERE slug = 'felix-cumbe';

COMMIT;
