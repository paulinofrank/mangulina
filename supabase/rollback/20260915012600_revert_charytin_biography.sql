BEGIN;

-- Revierte 20260915012600_rewrite_charytin_biography.sql con los documentos, campos
-- y premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'charytin' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'charytin') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Charytin Goyco is one of the most recognizable and beloved personalities in Dominican entertainment, a singer, actress, and television host whose irrepressible energy, platinum blonde hair, and theatrical exuberance made her an icon across the Spanish-speaking Caribbean and Latin America. Born in 1949 in El Seibo, in the eastern part of the Dominican Republic, she rose to prominence first as a singer with a dynamic stage presence before expanding into acting and television hosting, where her natural charisma and comic timing found their fullest expression.","type":"text"}]},{"type":"paragraph","content":[{"text":"She became particularly well known to international audiences through her long-running television presence in Puerto Rico and the United States, where she became a household name in Spanish-language media. Her singing career produced popular recordings in the merengue and pop traditions, but it was her larger-than-life personality and her ability to entertain across formats that made her a true multimedia phenomenon.","type":"text"}]},{"type":"paragraph","content":[{"text":"Charytin has been celebrated throughout her career as much for her spirit and humor as for her artistic output, and she has remained an active and beloved presence in Latin entertainment well into the twenty-first century.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'charytin';
UPDATE artists SET bio_en = 'Charytin Goyco is one of the most recognizable and beloved personalities in Dominican entertainment, a singer, actress, and television host whose irrepressible energy, platinum blonde hair, and theatrical exuberance made her an icon across the Spanish-speaking Caribbean and Latin America. Born in 1949 in El Seibo, in the eastern part of the Dominican Republic, she rose to prominence first as a singer with a dynamic stage presence before expanding into acting and television hosting, where her natural charisma and comic timing found their fullest expression.

She became particularly well known to international audiences through her long-running television presence in Puerto Rico and the United States, where she became a household name in Spanish-language media. Her singing career produced popular recordings in the merengue and pop traditions, but it was her larger-than-life personality and her ability to entertain across formats that made her a true multimedia phenomenon.

Charytin has been celebrated throughout her career as much for her spirit and humor as for her artistic output, and she has remained an active and beloved presence in Latin entertainment well into the twenty-first century.', bio_es = NULL, second_last_name = NULL,
       birth_place = 'El Seibo',
       occupations = '[]'::jsonb WHERE slug = 'charytin';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premio ACE' AND cat.name = 'Premio ACE'
   AND w.year = 2003 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'charytin');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'El Soberano'
   AND w.year = 2007 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'charytin');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premio ACE' AND cat.name = 'Premio ACE'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'El Soberano'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);

COMMIT;
