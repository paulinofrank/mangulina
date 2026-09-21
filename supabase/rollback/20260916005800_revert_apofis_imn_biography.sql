BEGIN;

-- Revierte 20260916005800_rewrite_apofis_imn_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'apofis-imn' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'apofis-imn') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Apofis Imn is a Dominican hip hop and underground rap artist whose work in the more independent, artistically serious wing of Dominican urban culture contributes to the intellectual and creative depth of the island''s rap scene. His engagement with hip hop underground — the tradition of rap that prioritizes lyrical substance, conceptual coherence, and artistic independence over commercial appeal — connects him to a community of Dominican rappers who see the genre as an art form with demanding standards and genuine stakes. Apofis Imn represents the underground dimension of Dominican hip hop, a scene that operates largely outside mainstream visibility but plays a crucial role in maintaining the integrity and artistic seriousness of the broader Dominican urban music culture.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'apofis-imn';
UPDATE artists SET bio_en = 'Apofis Imn is a Dominican hip hop and underground rap artist whose work in the more independent, artistically serious wing of Dominican urban culture contributes to the intellectual and creative depth of the island''s rap scene. His engagement with hip hop underground — the tradition of rap that prioritizes lyrical substance, conceptual coherence, and artistic independence over commercial appeal — connects him to a community of Dominican rappers who see the genre as an art form with demanding standards and genuine stakes. Apofis Imn represents the underground dimension of Dominican hip hop, a scene that operates largely outside mainstream visibility but plays a crucial role in maintaining the integrity and artistic seriousness of the broader Dominican urban music culture.', bio_es = NULL, birth_place = NULL, province = NULL,
       genres = ARRAY['urban-rap-hip-hop','urbano']::text[], birth_year = NULL WHERE slug = 'apofis-imn';

COMMIT;
