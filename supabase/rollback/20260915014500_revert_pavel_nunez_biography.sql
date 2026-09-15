BEGIN;

-- Revierte 20260915014500_rewrite_pavel_nunez_biography.sql con los documentos, campos
-- y premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'pavel-nunez' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pavel-nunez') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Pavel Núñez is a Dominican singer-songwriter whose work in the Latin pop tradition has earned him respect as one of the most thoughtful and melodically gifted artists his country has produced in the contemporary era. Born in 1979 in Santo Domingo, he developed a musical sensibility shaped by the rich tradition of Latin American canción as well as by the international pop sounds circulating through his formative years.","type":"text"}]},{"type":"paragraph","content":[{"text":"His songwriting is characterized by lyrical care and emotional honesty, placing him in a tradition that values the crafted song as a vehicle for genuine expression rather than mere entertainment. Núñez has built his career steadily rather than through a single explosive breakthrough, releasing albums that demonstrate consistent artistic growth and a deepening command of his chosen form.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has been recognized with awards and critical acclaim within the Dominican Republic, and his music has found appreciative audiences across Latin America and among Dominican communities abroad. His recordings often explore themes of love, loss, identity, and longing with a literary quality that distinguishes him from more commercially oriented pop artists. Pavel Núñez stands as an example of the serious, craft-focused end of Dominican popular music — an artist whose reputation rests on the quality of his songs.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'pavel-nunez';
UPDATE artists SET bio_en = 'Pavel Núñez is a Dominican singer-songwriter whose work in the Latin pop tradition has earned him respect as one of the most thoughtful and melodically gifted artists his country has produced in the contemporary era. Born in 1979 in Santo Domingo, he developed a musical sensibility shaped by the rich tradition of Latin American canción as well as by the international pop sounds circulating through his formative years.

His songwriting is characterized by lyrical care and emotional honesty, placing him in a tradition that values the crafted song as a vehicle for genuine expression rather than mere entertainment. Núñez has built his career steadily rather than through a single explosive breakthrough, releasing albums that demonstrate consistent artistic growth and a deepening command of his chosen form.

He has been recognized with awards and critical acclaim within the Dominican Republic, and his music has found appreciative audiences across Latin America and among Dominican communities abroad. His recordings often explore themes of love, loss, identity, and longing with a literary quality that distinguishes him from more commercially oriented pop artists. Pavel Núñez stands as an example of the serious, craft-focused end of Dominican popular music — an artist whose reputation rests on the quality of his songs.', bio_es = NULL, first_name = 'Pavel',
       last_name = NULL,
       second_last_name = NULL WHERE slug = 'pavel-nunez';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Singer-Songwriter Album'
   AND w.year = 2010 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'pavel-nunez');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Álbum del Año'
   AND w.year = 2016 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'pavel-nunez');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Mejor Cantante Masculino'
   AND w.year = 2014 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'pavel-nunez');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Best Singer-Songwriter Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Álbum del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Mejor Cantante Masculino'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);

COMMIT;
