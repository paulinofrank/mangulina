BEGIN;

-- Revierte 20260915013700_rewrite_janina_rosado_biography.sql con los documentos, campos
-- y premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'janina-rosado' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'janina-rosado') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Janina Rosado is a Dominican vocalist and musician based in Santo Domingo whose work spans merengue, bachata, tropical, and jazz, reflecting a broad and versatile musical personality. The range of genres associated with her career — from the dance-floor immediacy of merengue and tropical to the intimate romanticism of bachata and the harmonic sophistication of jazz — speaks to a musician who has refused to be confined by a single style. Based in the capital''s active music scene, Rosado has performed and recorded across these different traditions, bringing her voice to a variety of musical contexts. Her versatility makes her a valued presence in Dominican popular music, where the ability to navigate multiple genres is both commercially useful and artistically enriching.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'janina-rosado';
UPDATE artists SET bio_en = 'Janina Rosado is a Dominican vocalist and musician based in Santo Domingo whose work spans merengue, bachata, tropical, and jazz, reflecting a broad and versatile musical personality. The range of genres associated with her career — from the dance-floor immediacy of merengue and tropical to the intimate romanticism of bachata and the harmonic sophistication of jazz — speaks to a musician who has refused to be confined by a single style. Based in the capital''s active music scene, Rosado has performed and recorded across these different traditions, bringing her voice to a variety of musical contexts. Her versatility makes her a valued presence in Dominican popular music, where the ability to navigate multiple genres is both commercially useful and artistically enriching.', bio_es = NULL, birth_place = 'Santo Domingo',
       province = 'Distrito Nacional' WHERE slug = 'janina-rosado';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Record of the Year'
   AND w.year = 2024 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'janina-rosado');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Album of the Year'
   AND w.year = 2024 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'janina-rosado');
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Leading Ladies of Entertainment'
   AND w.year = 2022 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'janina-rosado');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Record of the Year'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Album of the Year'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin Grammy' AND cat.name = 'Leading Ladies of Entertainment'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);

COMMIT;
