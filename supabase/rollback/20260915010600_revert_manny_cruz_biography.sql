BEGIN;

-- Revierte 20260915010600_rewrite_manny_cruz_biography.sql con los documentos, campos
-- y premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manny-cruz' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'manny-cruz') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Manny Cruz is a Dominican singer and performer who has built a strong following across the merengue, Latin pop, and bachata genres, demonstrating an artistic flexibility that has helped him remain a consistent presence on the Dominican music scene for more than two decades. Born in 1983 in Santo Domingo, he developed his musical instincts in the capital''s vibrant popular music environment and pursued a professional career that launched in earnest during the early 2000s.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cruz possesses a natural vocal charisma and a gift for romantic interpretation that have made him a popular choice for radio-friendly love songs in the bachata and merengue idioms. His recordings have performed well in Dominican markets and among diaspora communities in the United States, where the Dominican tropical music audience has a long-established appetite for polished romantic performers.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has collaborated with prominent producers and fellow artists, and his live performances have been well received at festivals and concerts throughout the Caribbean and the Americas. Cruz represents the continuing vitality of Dominican mainstream popular music — an artist who combines professional craftsmanship with genuine popular appeal.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manny-cruz';
UPDATE artists SET bio_en = 'Manny Cruz is a Dominican singer and performer who has built a strong following across the merengue, Latin pop, and bachata genres, demonstrating an artistic flexibility that has helped him remain a consistent presence on the Dominican music scene for more than two decades. Born in 1983 in Santo Domingo, he developed his musical instincts in the capital''s vibrant popular music environment and pursued a professional career that launched in earnest during the early 2000s.

Cruz possesses a natural vocal charisma and a gift for romantic interpretation that have made him a popular choice for radio-friendly love songs in the bachata and merengue idioms. His recordings have performed well in Dominican markets and among diaspora communities in the United States, where the Dominican tropical music audience has a long-established appetite for polished romantic performers.

He has collaborated with prominent producers and fellow artists, and his live performances have been well received at festivals and concerts throughout the Caribbean and the Americas. Cruz represents the continuing vitality of Dominican mainstream popular music — an artist who combines professional craftsmanship with genuine popular appeal.', bio_es = NULL,
       date_of_birth = '1983-04-23' WHERE slug = 'manny-cruz';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Billboard Latin Music Awards' AND cat.name = 'Tropical Song of the Year'
   AND w.year = 2018 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'manny-cruz');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin American Music Awards' AND cat.name = 'Canción del Año'
   AND w.year = 2017 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'manny-cruz');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Cantante Solista del Año'
   AND w.year = 2017 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'manny-cruz');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Álbum del Año'
   AND w.year = 2019 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'manny-cruz');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Merengue del Año'
   AND w.year = 2020 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'manny-cruz');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Merengue del Año'
   AND w.year = 2022 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'manny-cruz');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Colaboración del Año'
   AND w.year = 2024 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'manny-cruz');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Billboard Latin Music Awards' AND cat.name = 'Tropical Song of the Year'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin American Music Awards' AND cat.name = 'Canción del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Cantante Solista del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Álbum del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Merengue del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Merengue del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Colaboración del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM awards a WHERE a.name = 'Latin American Music Awards'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);

COMMIT;
