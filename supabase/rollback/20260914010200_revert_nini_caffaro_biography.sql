BEGIN;

-- Revierte 20260914010200_rewrite_nini_caffaro_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'nini-caffaro' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'nini-caffaro') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Niní Cáffaro was a beloved Dominican singer born in 1939 in San Pedro de Macorís, a city on the southeastern coast of the Dominican Republic long associated with cultural vitality and artistic talent. She built her career around bolero and Latin pop, two genres that placed great demands on vocal expression and emotional nuance — demands she met with a voice that was both warm and precisely controlled.","type":"text"}]},{"type":"paragraph","content":[{"text":"Throughout her career she became a cherished figure in Dominican romantic music, interpreting songs with a depth and sensitivity that resonated with audiences across generations. Her recordings placed her alongside the finest interpreters of the bolero tradition in the Caribbean, and she earned wide respect not only in her homeland but among Latin music lovers throughout the Americas.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cáffaro represented a generation of Dominican artists who elevated popular song to an art form, drawing on the traditions of Cuban bolero while infusing their performances with a distinctly Dominican sensibility.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'nini-caffaro';
UPDATE artists SET bio_en = 'Niní Cáffaro was a beloved Dominican singer born in 1939 in San Pedro de Macorís, a city on the southeastern coast of the Dominican Republic long associated with cultural vitality and artistic talent. She built her career around bolero and Latin pop, two genres that placed great demands on vocal expression and emotional nuance — demands she met with a voice that was both warm and precisely controlled.

Throughout her career she became a cherished figure in Dominican romantic music, interpreting songs with a depth and sensitivity that resonated with audiences across generations. Her recordings placed her alongside the finest interpreters of the bolero tradition in the Caribbean, and she earned wide respect not only in her homeland but among Latin music lovers throughout the Americas.

Cáffaro represented a generation of Dominican artists who elevated popular song to an art form, drawing on the traditions of Cuban bolero while infusing their performances with a distinctly Dominican sensibility.', bio_es = NULL WHERE slug = 'nini-caffaro';
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND w.artist_id = (SELECT id FROM artists WHERE slug = 'nini-caffaro')
   AND ((a.name = 'Festival de la Canción Dominicana' AND cat.name = 'Primer lugar' AND w.year = 1968)
     OR (a.name = 'Premios Soberano' AND cat.name = 'El Gran Soberano' AND w.year = 2020));
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Festival de la Canción Dominicana'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);
DELETE FROM awards a WHERE a.name = 'Festival de la Canción Dominicana'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id);

COMMIT;
