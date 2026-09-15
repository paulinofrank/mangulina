BEGIN;

-- Revierte 20260914011300_rewrite_la_materialista_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'la-materialista' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'la-materialista') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"La Materialista, born Yameyry Ynfante in Santiago de los Caballeros, is one of the Dominican Republic''s most recognizable female voices in urban music. Rising through the dembow and urban pop scenes, she carved out a space for herself in a genre historically dominated by male artists, combining sharp lyricism with an unapologetically bold persona. Her breakthrough came with infectious, bass-heavy tracks that blended dembow rhythms with pop hooks, earning her a massive following on social media and streaming platforms.","type":"text"}]},{"type":"paragraph","content":[{"text":"Songs like Tukiti became anthems in the Dominican urban scene and beyond, introducing her to audiences across Latin America and the United States. Beyond music, La Materialista has become a cultural figure — a businesswoman, television personality, and outspoken advocate for women''s empowerment. Her career reflects the explosion of Dominican urban music in the 2010s and its growing global footprint, and she remains one of the genre''s most enduring and commercially successful female artists.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = 'la-materialista';
UPDATE artists SET bio_en = 'La Materialista, born Yameyry Ynfante in Santiago de los Caballeros, is one of the Dominican Republic''s most recognizable female voices in urban music. Rising through the dembow and urban pop scenes, she carved out a space for herself in a genre historically dominated by male artists, combining sharp lyricism with an unapologetically bold persona. Her breakthrough came with infectious, bass-heavy tracks that blended dembow rhythms with pop hooks, earning her a massive following on social media and streaming platforms.

Songs like Tukiti became anthems in the Dominican urban scene and beyond, introducing her to audiences across Latin America and the United States. Beyond music, La Materialista has become a cultural figure — a businesswoman, television personality, and outspoken advocate for women''s empowerment. Her career reflects the explosion of Dominican urban music in the 2010s and its growing global footprint, and she remains one of the genre''s most enduring and commercially successful female artists.', bio_es = NULL, second_last_name = NULL,
       occupations = '[]'::jsonb WHERE slug = 'la-materialista';

COMMIT;
