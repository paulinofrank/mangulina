BEGIN;

-- Revierte 20260915014700_rewrite_dj_adoni_biography.sql con los documentos y
-- premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'dj-adoni' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'dj-adoni') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"DJ Adoni, born Julio Adonis Gross Gonzalez in Santo Domingo Este, grew up in the vibrant neighborhood of Los Mina before relocating to the United States as a teenager. That transatlantic upbringing gave him a dual sensibility — rooted in Dominican street culture while absorbing the rhythms and production styles thriving in American urban centers. He built his reputation as a versatile disc jockey and producer capable of moving fluidly between dembow dominicano, reggaeton, bachata, merengue, salsa, and the broader Latin urban spectrum.","type":"text"}]},{"type":"paragraph","content":[{"text":"As a songwriter and musician, DJ Adoni went beyond the booth, contributing creatively to tracks rather than simply spinning them. His work helped bridge Dominican underground sounds with wider Latin markets, earning him a following among fans of both traditional Caribbean music and contemporary urban beats. Over the course of his career he collaborated with a range of artists across genres, positioning himself as one of the more adaptable figures in Dominican urban music production.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dj-adoni';
UPDATE artists SET bio_en = 'DJ Adoni, born Julio Adonis Gross Gonzalez in Santo Domingo Este, grew up in the vibrant neighborhood of Los Mina before relocating to the United States as a teenager. That transatlantic upbringing gave him a dual sensibility — rooted in Dominican street culture while absorbing the rhythms and production styles thriving in American urban centers. He built his reputation as a versatile disc jockey and producer capable of moving fluidly between dembow dominicano, reggaeton, bachata, merengue, salsa, and the broader Latin urban spectrum.

As a songwriter and musician, DJ Adoni went beyond the booth, contributing creatively to tracks rather than simply spinning them. His work helped bridge Dominican underground sounds with wider Latin markets, earning him a following among fans of both traditional Caribbean music and contemporary urban beats. Over the course of his career he collaborated with a range of artists across genres, positioning himself as one of the more adaptable figures in Dominican urban music production.', bio_es = NULL WHERE slug = 'dj-adoni';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Lo Máximo Productions' AND cat.name = 'DJ del Año'
   AND w.year = 2018 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'dj-adoni');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'iHeartRadio Music Awards' AND cat.name = 'Latin Pop/Reggaeton Song of the Year'
   AND w.year = 2021 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'dj-adoni');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Billboard Latin Music Awards' AND cat.name = 'Latin Airplay Song of the Year'
   AND w.year = 2021 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'dj-adoni');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Juventud' AND cat.name = 'La Mezcla Perfecta'
   AND w.year = 2022 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'dj-adoni');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Lo Nuestro' AND cat.name = 'DJ del Año'
   AND w.year = 2022 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'dj-adoni');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Latin Plug' AND cat.name = 'DJ del Año'
   AND w.year = 2022 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'dj-adoni');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Lo Máximo Productions' AND cat.name = 'DJ del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'iHeartRadio Music Awards' AND cat.name = 'Latin Pop/Reggaeton Song of the Year'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Billboard Latin Music Awards' AND cat.name = 'Latin Airplay Song of the Year'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Juventud' AND cat.name = 'La Mezcla Perfecta'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Lo Nuestro' AND cat.name = 'DJ del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Latin Plug' AND cat.name = 'DJ del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM awards a WHERE a.name = 'Lo Máximo Productions'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);
DELETE FROM awards a WHERE a.name = 'iHeartRadio Music Awards'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);
DELETE FROM awards a WHERE a.name = 'Billboard Latin Music Awards'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);
DELETE FROM awards a WHERE a.name = 'Premios Juventud'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);
DELETE FROM awards a WHERE a.name = 'Premios Lo Nuestro'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);
DELETE FROM awards a WHERE a.name = 'Premios Latin Plug'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);

COMMIT;
