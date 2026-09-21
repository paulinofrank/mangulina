BEGIN;

-- Revierte 20260916003700_rewrite_andre_veloz_biography.sql con los documentos, el premio y los
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM artist_awards WHERE id = '04a3aaac-d8b0-4e31-82a6-825e92ad7a99';
DELETE FROM award_categories WHERE award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd' AND name = 'Revelación del Año'
  AND NOT EXISTS (SELECT 1 FROM artist_awards WHERE category_id = award_categories.id);
DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'andre-veloz' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'andre-veloz') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"André Velóz is a Dominican artist rooted in the Santo Domingo music world whose performances and recordings have touched the traditions of bachata, tropical, and bolero. His work in bachata connects him to one of the most beloved and emotionally resonant genres in Dominican culture, while his engagement with bolero and tropical demonstrates a broad musical sensibility rooted in the romantic and festive traditions of the Caribbean. Based in the capital, Velóz has been part of the active community of Dominican popular music artists who sustain and evolve these genres through consistent performance and recording. His music speaks to themes of love, longing, and human connection that are at the heart of both bachata and bolero, offering audiences an emotional directness that has long been the hallmark of Dominican popular expression.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'andre-veloz';
UPDATE artists SET bio_en = 'André Velóz is a Dominican artist rooted in the Santo Domingo music world whose performances and recordings have touched the traditions of bachata, tropical, and bolero. His work in bachata connects him to one of the most beloved and emotionally resonant genres in Dominican culture, while his engagement with bolero and tropical demonstrates a broad musical sensibility rooted in the romantic and festive traditions of the Caribbean. Based in the capital, Velóz has been part of the active community of Dominican popular music artists who sustain and evolve these genres through consistent performance and recording. His music speaks to themes of love, longing, and human connection that are at the heart of both bachata and bolero, offering audiences an emotional directness that has long been the hallmark of Dominican popular expression.', bio_es = NULL, name = 'André Velóz', sort_name = 'Velóz, André',
       stage_name = 'André Velóz', first_name = 'André', last_name = 'Velóz',
       second_last_name = NULL, aliases = ARRAY['La Velóz']::text[], birth_place = 'Santo Domingo',
       province = 'Distrito Nacional', genres = ARRAY['bolero']::text[], occupations = '[]'::jsonb
       WHERE slug = 'andre-veloz';

COMMIT;
