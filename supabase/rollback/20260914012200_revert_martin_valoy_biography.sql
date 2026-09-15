BEGIN;

-- Revierte 20260914012200_rewrite_martin_valoy_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'martin-valoy' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martin-valoy') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Martín Valoy was a Dominican musician associated with son, merengue, and salsa, and was the brother of the celebrated Cuco Valoy with whom he co-founded the beloved ensemble Los Virtuosos. Together the Valoy brothers created one of the most respected musical partnerships in Dominican popular music history, blending the rhythmic foundations of son with merengue''s driving energy and salsa''s urban sophistication. While Cuco has become the more internationally recognized of the two, Martín''s contributions to Los Virtuosos and to the development of Dominican popular music are inseparable from that legacy. His work as a musician and collaborator helped shape a sound that placed Dominican popular music in genuine dialogue with the broader Caribbean musical tradition.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = 'martin-valoy';
UPDATE artists SET bio_en = 'Martín Valoy was a Dominican musician associated with son, merengue, and salsa, and was the brother of the celebrated Cuco Valoy with whom he co-founded the beloved ensemble Los Virtuosos. Together the Valoy brothers created one of the most respected musical partnerships in Dominican popular music history, blending the rhythmic foundations of son with merengue''s driving energy and salsa''s urban sophistication. While Cuco has become the more internationally recognized of the two, Martín''s contributions to Los Virtuosos and to the development of Dominican popular music are inseparable from that legacy. His work as a musician and collaborator helped shape a sound that placed Dominican popular music in genuine dialogue with the broader Caribbean musical tradition.', bio_es = NULL, occupations = '["musician","composer"]'::jsonb, instruments = ARRAY[]::text[], aliases = ARRAY[]::text[] WHERE slug = 'martin-valoy';

COMMIT;
