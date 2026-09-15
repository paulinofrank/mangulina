BEGIN;

-- Revierte 20260915012900_rewrite_fernando_echavarria_biography.sql con los documentos, campos
-- y premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'fernando-echavarria' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-echavarria') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Fernando Echavarría was a Dominican musician born in 1953 in Santo Domingo whose work in son, merengue, fusion, and tropical music reflected a broad and adventurous musical intelligence. Son, the foundational Cuban genre that influenced virtually all of the Spanish-speaking Caribbean''s popular music, was central to Echavarría''s artistic identity, and his engagement with it placed him within a pan-Caribbean tradition that transcended national borders while remaining deeply rooted in specific cultural contexts.","type":"text"}]},{"type":"paragraph","content":[{"text":"His fusion work demonstrated a willingness to experiment and combine influences in ways that went beyond simple genre blending, seeking genuinely new sounds from the intersection of traditions. Echavarría worked both within the Dominican Republic and in connection with the broader Latin music world, contributing to a scene that during the latter decades of the twentieth century was increasingly interconnected through recordings, touring, and the shared musical vocabulary of Caribbean popular music. He passed away in 2015 at the age of sixty-one.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'fernando-echavarria';
UPDATE artists SET bio_en = 'Fernando Echavarría was a Dominican musician born in 1953 in Santo Domingo whose work in son, merengue, fusion, and tropical music reflected a broad and adventurous musical intelligence. Son, the foundational Cuban genre that influenced virtually all of the Spanish-speaking Caribbean''s popular music, was central to Echavarría''s artistic identity, and his engagement with it placed him within a pan-Caribbean tradition that transcended national borders while remaining deeply rooted in specific cultural contexts.

His fusion work demonstrated a willingness to experiment and combine influences in ways that went beyond simple genre blending, seeking genuinely new sounds from the intersection of traditions. Echavarría worked both within the Dominican Republic and in connection with the broader Latin music world, contributing to a scene that during the latter decades of the twentieth century was increasingly interconnected through recordings, touring, and the shared musical vocabulary of Caribbean popular music. He passed away in 2015 at the age of sixty-one.', bio_es = NULL, first_name = 'Fernando',
       second_last_name = NULL WHERE slug = 'fernando-echavarria';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'Honor al Mérito'
   AND w.year = 2008 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'fernando-echavarria');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Reserva Musical Nacional' AND cat.name = 'Reserva Musical Nacional'
   AND w.year = 2011 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'fernando-echavarria');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Luna' AND cat.name = 'Artista Internacional de Mayor Influencia'
   AND w.year = 2006 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'fernando-echavarria');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'Honor al Mérito'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Reserva Musical Nacional' AND cat.name = 'Reserva Musical Nacional'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Luna' AND cat.name = 'Artista Internacional de Mayor Influencia'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM awards a WHERE a.name = 'Premios Casandra'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);
DELETE FROM awards a WHERE a.name = 'Reserva Musical Nacional'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);
DELETE FROM awards a WHERE a.name = 'Premios Luna'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);

COMMIT;
