BEGIN;

-- Revierte 20260914011600_rewrite_xiomara_fortuna_biography.sql con los documentos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'xiomara-fortuna' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'xiomara-fortuna') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Xiomara Fortuna is one of the Dominican Republic''s most artistically adventurous musicians, born in 1959 in Monte Cristi — a city on the arid northwestern coast of the island with its own distinct cultural and historical character. Her music defies easy categorization, drawing on Dominican folk traditions, Afro-Caribbean rhythms, jazz, and world music influences to create a sound that is deeply rooted yet strikingly contemporary.","type":"text"}]},{"type":"paragraph","content":[{"text":"Fortuna has been a passionate advocate for the African heritage embedded in Dominican culture — a heritage that has often been underacknowledged in a society that has historically privileged its European and Indigenous roots. Through her recordings and performances she has shed light on the Afro-Dominican musical traditions of the border region and the country''s African diaspora communities, bringing these sounds to new audiences in the Dominican Republic and internationally.","type":"text"}]},{"type":"paragraph","content":[{"text":"She has performed at world music festivals across Europe and the Americas, earning recognition as one of the Caribbean''s most significant and original artistic voices. Her work is both a creative achievement and a cultural act — a sustained argument for the richness and complexity of Dominican identity in all its dimensions.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'xiomara-fortuna';
UPDATE artists SET bio_en = 'Xiomara Fortuna is one of the Dominican Republic''s most artistically adventurous musicians, born in 1959 in Monte Cristi — a city on the arid northwestern coast of the island with its own distinct cultural and historical character. Her music defies easy categorization, drawing on Dominican folk traditions, Afro-Caribbean rhythms, jazz, and world music influences to create a sound that is deeply rooted yet strikingly contemporary.

Fortuna has been a passionate advocate for the African heritage embedded in Dominican culture — a heritage that has often been underacknowledged in a society that has historically privileged its European and Indigenous roots. Through her recordings and performances she has shed light on the Afro-Dominican musical traditions of the border region and the country''s African diaspora communities, bringing these sounds to new audiences in the Dominican Republic and internationally.

She has performed at world music festivals across Europe and the Americas, earning recognition as one of the Caribbean''s most significant and original artistic voices. Her work is both a creative achievement and a cultural act — a sustained argument for the richness and complexity of Dominican identity in all its dimensions.', bio_es = NULL WHERE slug = 'xiomara-fortuna';
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Música Alternativa'
   AND w.artist_id = (SELECT id FROM artists WHERE slug = 'xiomara-fortuna') AND w.year IN (2021, 2022);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Música Alternativa'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);

COMMIT;
