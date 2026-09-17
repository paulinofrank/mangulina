BEGIN;

-- Revierte 20260916002500_rewrite_akinohayley_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'akinohayley' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'akinohayley') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"AKINOhayLEY (born Josué Daniel Aquino Leyba in 1988) is a Dominican artist whose work in urban, R&B, and alternative music places them at an interesting creative intersection within Dominican popular culture.","type":"text"}]},{"type":"paragraph","content":[{"text":"Born and raised in Los Mina, a vibrant and historically rich sector of Santo Domingo Este, his artistry is deeply rooted in the raw energy, rhythmic pulse, and daily realities of one of the capital''s most culturally fertile neighborhoods. This distinct urban Dominican upbringing blends seamlessly with a soulful melodic sensibility and a genre-questioning impulse. The result is a sound that refuses to fit neatly into any existing category—a characteristic creative ambition among artists who feel most alive in the spaces between established genres.","type":"text"}]},{"type":"paragraph","content":[{"text":"By grounding experimental rap and alternative beats in the authentic lived experience of Santo Domingo Este, AKINOhayLEY''s work contributes significantly to the growing diversity of Dominican music beyond its most commercially visible genres, enriching the overall scene with sounds that challenge and expand contemporary expectations.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'akinohayley';
UPDATE artists SET bio_en = 'AKINOhayLEY (born Josué Daniel Aquino Leyba in 1988) is a Dominican artist whose work in urban, R&B, and alternative music places them at an interesting creative intersection within Dominican popular culture.

Born and raised in Los Mina, a vibrant and historically rich sector of Santo Domingo Este, his artistry is deeply rooted in the raw energy, rhythmic pulse, and daily realities of one of the capital''s most culturally fertile neighborhoods. This distinct urban Dominican upbringing blends seamlessly with a soulful melodic sensibility and a genre-questioning impulse. The result is a sound that refuses to fit neatly into any existing category—a characteristic creative ambition among artists who feel most alive in the spaces between established genres.

By grounding experimental rap and alternative beats in the authentic lived experience of Santo Domingo Este, AKINOhayLEY''s work contributes significantly to the growing diversity of Dominican music beyond its most commercially visible genres, enriching the overall scene with sounds that challenge and expand contemporary expectations.', bio_es = NULL,
       primary_role = 'singer', occupations = '["songwriter"]'::jsonb,
       genres = ARRAY['urban-rap-hip-hop']::text[]
       WHERE slug = 'akinohayley';

COMMIT;
