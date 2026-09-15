BEGIN;

-- Revierte 20260915010800_rewrite_amenazzy_biography.sql con los documentos y
-- premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'amenazzy' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'amenazzy') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Amenazzy, born Josué Manuel Peña in 1995 in Santiago de los Caballeros, is a Dominican reggaeton and R&B latino artist who has steadily emerged as one of the most promising voices of his generation. Growing up in Santiago, the Dominican Republic''s second-largest city and a hub of musical activity, he absorbed the sounds of urban music from an early age and began developing his craft as a teenager.","type":"text"}]},{"type":"paragraph","content":[{"text":"His style blends the rhythmic pulse of reggaeton with the melodic sensitivity of R&B, resulting in music that is simultaneously danceable and emotionally resonant. Amenazzy gained widespread attention through collaborations with established Latin urban artists and through independently released music that circulated widely on social media and streaming platforms.","type":"text"}]},{"type":"paragraph","content":[{"text":"His trajectory reflects the broader democratization of Latin urban music, where talented young artists from cities like Santiago can reach global audiences without the traditional gatekeepers of the music industry.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'amenazzy';
UPDATE artists SET bio_en = 'Amenazzy, born Josué Manuel Peña in 1995 in Santiago de los Caballeros, is a Dominican reggaeton and R&B latino artist who has steadily emerged as one of the most promising voices of his generation. Growing up in Santiago, the Dominican Republic''s second-largest city and a hub of musical activity, he absorbed the sounds of urban music from an early age and began developing his craft as a teenager.

His style blends the rhythmic pulse of reggaeton with the melodic sensitivity of R&B, resulting in music that is simultaneously danceable and emotionally resonant. Amenazzy gained widespread attention through collaborations with established Latin urban artists and through independently released music that circulated widely on social media and streaming platforms.

His trajectory reflects the broader democratization of Latin urban music, where talented young artists from cities like Santiago can reach global audiences without the traditional gatekeepers of the music industry.', bio_es = NULL WHERE slug = 'amenazzy';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Juventud' AND cat.name = 'Nueva Generación Urbana'
   AND w.year = 2019 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'amenazzy');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Juventud' AND cat.name = 'Nueva Generación Urbana'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM awards a WHERE a.name = 'Premios Juventud'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);

COMMIT;
