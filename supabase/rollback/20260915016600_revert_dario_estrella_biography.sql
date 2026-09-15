BEGIN;

-- Revierte 20260915016600_rewrite_dario_estrella_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'dario-estrella' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'dario-estrella') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Darío Estrella is a Dominican musician born in 1951 in La Vega whose career has traced a rich path through Latin jazz, merengue, and fusion music. La Vega, situated in the heart of the Cibao region, is a city with deep musical traditions, and Estrella grew up immersed in the rhythmic and melodic language of Dominican popular music before expanding his horizons into jazz and fusion.","type":"text"}]},{"type":"paragraph","content":[{"text":"His approach to Latin jazz is informed by the merengue idiom, giving his improvisations a rhythmic backbone rooted in Dominican musical identity even when he ventures into more experimental harmonic territory. Estrella represents a generation of Dominican musicians who refused to see the boundaries between vernacular and jazz traditions as fixed, working instead to demonstrate that those worlds could illuminate each other in productive and surprising ways.","type":"text"}]},{"type":"paragraph","content":[{"text":"His career has unfolded largely within the Dominican Republic, where he has been a respected figure in the jazz and popular music communities for several decades.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dario-estrella';
UPDATE artists SET bio_en = 'Darío Estrella is a Dominican musician born in 1951 in La Vega whose career has traced a rich path through Latin jazz, merengue, and fusion music. La Vega, situated in the heart of the Cibao region, is a city with deep musical traditions, and Estrella grew up immersed in the rhythmic and melodic language of Dominican popular music before expanding his horizons into jazz and fusion.

His approach to Latin jazz is informed by the merengue idiom, giving his improvisations a rhythmic backbone rooted in Dominican musical identity even when he ventures into more experimental harmonic territory. Estrella represents a generation of Dominican musicians who refused to see the boundaries between vernacular and jazz traditions as fixed, working instead to demonstrate that those worlds could illuminate each other in productive and surprising ways.

His career has unfolded largely within the Dominican Republic, where he has been a respected figure in the jazz and popular music communities for several decades.', bio_es = NULL, instruments = ARRAY[]::text[]
       WHERE slug = 'dario-estrella';

COMMIT;
