BEGIN;

-- Revierte 20260915015200_rewrite_jandy_feliz_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jandy-feliz' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jandy-feliz') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jandy Feliz is a Dominican musician born in 1977 in Barahona, the capital of the southern Barahona province, a region whose cultural character has been shaped by its distinctive geography and its strong Afro-Dominican heritage. He has built a career around fusion, pop latino, and tropical music, developing a sound that blends Dominican rhythms with contemporary pop production and a sensibility drawn from multiple musical traditions. His connection to Barahona gives his music a southern Dominican flavor that distinguishes it from the Cibao-dominated mainstream of the island''s popular music. Jandy Feliz has performed across the Dominican Republic and for diaspora audiences, developing a loyal following among fans who appreciate music that bridges the traditional and the modern.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = 'jandy-feliz';
UPDATE artists SET bio_en = 'Jandy Feliz is a Dominican musician born in 1977 in Barahona, the capital of the southern Barahona province, a region whose cultural character has been shaped by its distinctive geography and its strong Afro-Dominican heritage. He has built a career around fusion, pop latino, and tropical music, developing a sound that blends Dominican rhythms with contemporary pop production and a sensibility drawn from multiple musical traditions. His connection to Barahona gives his music a southern Dominican flavor that distinguishes it from the Cibao-dominated mainstream of the island''s popular music. Jandy Feliz has performed across the Dominican Republic and for diaspora audiences, developing a loyal following among fans who appreciate music that bridges the traditional and the modern.', bio_es = NULL,
       first_name = 'Jandy', last_name = 'Feliz', second_last_name = NULL,
       birth_place = 'Barahona' WHERE slug = 'jandy-feliz';

COMMIT;
