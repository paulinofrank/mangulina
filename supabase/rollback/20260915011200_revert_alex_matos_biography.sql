BEGIN;

-- Revierte 20260915011200_rewrite_alex_matos_biography.sql con los documentos, campos
-- y premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'alex-matos' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'alex-matos') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Alex Matos is a Dominican salsa singer born in 1976 in Santo Domingo who built his reputation as one of the most compelling voices in the tropical salsa circuit. Though salsa has its deepest roots in Puerto Rico and New York''s Latino communities, Dominican artists like Matos have made significant contributions to the genre, and he distinguished himself with a vocal style that combined technical precision with genuine emotional warmth. His recordings in the salsa romántica and balada traditions earned him critical praise and commercial success, and his collaborations with orchestras and producers across Latin America expanded his reach well beyond the Dominican Republic. Matos occupies a distinctive place in Dominican music as an artist who mastered a genre not traditionally associated with the island and elevated it with a Caribbean sensibility that is unmistakably his own.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alex-matos';
UPDATE artists SET bio_en = 'Alex Matos is a Dominican salsa singer born in 1976 in Santo Domingo who built his reputation as one of the most compelling voices in the tropical salsa circuit. Though salsa has its deepest roots in Puerto Rico and New York''s Latino communities, Dominican artists like Matos have made significant contributions to the genre, and he distinguished himself with a vocal style that combined technical precision with genuine emotional warmth. His recordings in the salsa romántica and balada traditions earned him critical praise and commercial success, and his collaborations with orchestras and producers across Latin America expanded his reach well beyond the Dominican Republic. Matos occupies a distinctive place in Dominican music as an artist who mastered a genre not traditionally associated with the island and elevated it with a Caribbean sensibility that is unmistakably his own.', bio_es = NULL,
       first_name = 'Alex', middle_name = NULL, last_name = 'Matos',
       second_last_name = NULL, aliases = ARRAY['El Fiscal de la Salsa']::text[] WHERE slug = 'alex-matos';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Latino' AND cat.name = 'Salsero del Año'
   AND w.year = 2011 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'alex-matos');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'Salsero del Año'
   AND w.year = 2012 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'alex-matos');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Salsero del Año'
   AND w.year = 2013 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'alex-matos');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premio Lo Nuestro' AND cat.name = 'Revelación Tropical'
   AND w.year = 2014 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'alex-matos');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Latino' AND cat.name = 'Salsero del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'Salsero del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Salsero del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premio Lo Nuestro' AND cat.name = 'Revelación Tropical'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM awards a WHERE a.name = 'Premios Latino'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);

COMMIT;
