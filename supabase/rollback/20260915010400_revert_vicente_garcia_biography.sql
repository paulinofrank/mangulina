BEGIN;

-- Revierte 20260915010400_rewrite_vicente_garcia_biography.sql con los documentos, campos
-- y premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'vicente-garcia' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'vicente-garcia') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Vicente García is one of the most artistically ambitious and internationally recognized Dominican musicians of his generation, an artist who has taken the raw material of Dominican folk and popular tradition and reshaped it into something bracingly original and globally relevant. Born in 1983 in Santo Domingo, he developed his musical voice through immersion in the bachata tradition and the broader sounds of Dominican popular music before embarking on a trajectory that would carry him far beyond those roots.","type":"text"}]},{"type":"paragraph","content":[{"text":"His work is distinguished by a restless curiosity — an unwillingness to accept the comfortable formulas of any single genre in favor of a synthetic vision that draws on bachata, Caribbean rhythm, folk, world music, and contemporary pop production. García has released a series of critically acclaimed albums that have been recognized by the Latin Grammy organization and have won him devoted audiences in the Dominican Republic, Latin America, Europe, and the United States.","type":"text"}]},{"type":"paragraph","content":[{"text":"He is a gifted guitarist and vocalist as well as a thoughtful producer, and his live performances have earned rave reviews from critics who have compared him to the great Latin singer-songwriter tradition while acknowledging his distinctly Dominican personality. His willingness to engage with the full complexity of Dominican cultural identity — including its African, Spanish, and indigenous dimensions — gives his music an intellectual depth that complements its emotional immediacy.","type":"text"}]},{"type":"paragraph","content":[{"text":"Vicente García is widely regarded as one of the most important Dominican artists of the twenty-first century.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'vicente-garcia';
UPDATE artists SET bio_en = 'Vicente García is one of the most artistically ambitious and internationally recognized Dominican musicians of his generation, an artist who has taken the raw material of Dominican folk and popular tradition and reshaped it into something bracingly original and globally relevant. Born in 1983 in Santo Domingo, he developed his musical voice through immersion in the bachata tradition and the broader sounds of Dominican popular music before embarking on a trajectory that would carry him far beyond those roots.

His work is distinguished by a restless curiosity — an unwillingness to accept the comfortable formulas of any single genre in favor of a synthetic vision that draws on bachata, Caribbean rhythm, folk, world music, and contemporary pop production. García has released a series of critically acclaimed albums that have been recognized by the Latin Grammy organization and have won him devoted audiences in the Dominican Republic, Latin America, Europe, and the United States.

He is a gifted guitarist and vocalist as well as a thoughtful producer, and his live performances have earned rave reviews from critics who have compared him to the great Latin singer-songwriter tradition while acknowledging his distinctly Dominican personality. His willingness to engage with the full complexity of Dominican cultural identity — including its African, Spanish, and indigenous dimensions — gives his music an intellectual depth that complements its emotional immediacy.

Vicente García is widely regarded as one of the most important Dominican artists of the twenty-first century.', bio_es = NULL, occupations = '["composer","musician","guitarist"]'::jsonb WHERE slug = 'vicente-garcia';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best New Artist'
   AND w.year = 2017 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'vicente-garcia');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Singer-Songwriter Album'
   AND w.year = 2017 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'vicente-garcia');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Tropical Song'
   AND w.year = 2017 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'vicente-garcia');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Videoclip del Año'
   AND w.year = 2018 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'vicente-garcia');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Canción del Año'
   AND w.year = 2022 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'vicente-garcia');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Folk Album'
   AND w.year = 2023 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'vicente-garcia');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Contemporary Tropical Album'
   AND w.year = 2025 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'vicente-garcia');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best New Artist'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Singer-Songwriter Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Tropical Song'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Videoclip del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Canción del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Folk Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Contemporary Tropical Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);

COMMIT;
