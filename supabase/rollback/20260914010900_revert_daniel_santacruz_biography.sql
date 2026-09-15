BEGIN;

-- Revierte 20260914010900_rewrite_daniel_santacruz_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'daniel-santacruz' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'daniel-santacruz') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Daniel Santacruz is a bachata artist of Dominican heritage whose smooth vocal style and talent for romantic songwriting have won him a devoted following among fans of the genre across multiple countries. Born in 1976 in New Jersey to Dominican parents, he represents the rich musical tradition of the Dominican diaspora in the United States — artists who grew up between cultures and brought the sounds of their heritage into new contexts.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santacruz developed a refined, polished approach to bachata that incorporates elements of Latin pop and even hints of kizomba, the Angolan-influenced social dance music that shares bachata''s emphasis on close partnering and romantic feeling. His music has found particular favor in Europe, where bachata has a large and enthusiastic following, and he has performed extensively on the festival and concert circuit in Spain and other European countries.","type":"text"}]},{"type":"paragraph","content":[{"text":"His songwriting demonstrates a facility with the vocabulary of bachata romance — longing, heartbreak, devotion, and desire — expressed through melodies that are immediately accessible without being formulaic. Santacruz occupies a niche in the bachata world that bridges traditional Dominican roots and contemporary international appeal, and his recordings have earned him a loyal audience that values both the genre''s emotional directness and his particular brand of melodic sophistication.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'daniel-santacruz';
UPDATE artists SET bio_en = 'Daniel Santacruz is a bachata artist of Dominican heritage whose smooth vocal style and talent for romantic songwriting have won him a devoted following among fans of the genre across multiple countries. Born in 1976 in New Jersey to Dominican parents, he represents the rich musical tradition of the Dominican diaspora in the United States — artists who grew up between cultures and brought the sounds of their heritage into new contexts.

Santacruz developed a refined, polished approach to bachata that incorporates elements of Latin pop and even hints of kizomba, the Angolan-influenced social dance music that shares bachata''s emphasis on close partnering and romantic feeling. His music has found particular favor in Europe, where bachata has a large and enthusiastic following, and he has performed extensively on the festival and concert circuit in Spain and other European countries.

His songwriting demonstrates a facility with the vocabulary of bachata romance — longing, heartbreak, devotion, and desire — expressed through melodies that are immediately accessible without being formulaic. Santacruz occupies a niche in the bachata world that bridges traditional Dominican roots and contemporary international appeal, and his recordings have earned him a loyal audience that values both the genre''s emotional directness and his particular brand of melodic sophistication.', bio_es = NULL,
       last_name = 'Santacruz', second_last_name = NULL WHERE slug = 'daniel-santacruz';
DELETE FROM artist_awards WHERE artist_id = (SELECT id FROM artists WHERE slug = 'daniel-santacruz');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Compositor del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM artist_family_relationships f USING artists a, artists b
 WHERE f.relationship_type = 'sibling' AND a.slug = 'daniel-santacruz' AND b.slug = 'manny-cruz'
   AND ((f.artist_id = a.id AND f.related_artist_id = b.id) OR (f.artist_id = b.id AND f.related_artist_id = a.id));

COMMIT;
