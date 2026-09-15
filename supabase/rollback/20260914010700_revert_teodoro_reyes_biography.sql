BEGIN;

-- Revierte 20260914010700_rewrite_teodoro_reyes_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).
-- Aviso: devuelve el lugar de nacimiento Mao, que seis fuentes contradicen.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'teodoro-reyes' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'teodoro-reyes') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Teodoro Reyes is a Dominican musician born in 1954 in Mao, the capital of Valverde province in the northwestern Cibao, whose career has contributed to the popular music tradition of the Dominican Republic. Mao is a city in the agricultural heart of the Cibao, and Reyes''s formation there gave him a grounding in the traditional sounds of the region that has always been central to Dominican musical identity. His career as a musician reflects the long tradition of Dominican popular music rooted in the provinces, where artists develop their craft in community with their neighbors and audiences before reaching broader national and international recognition. Reyes represents the provincial musical heritage that is the foundation of Dominican popular song.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'teodoro-reyes';
UPDATE artists SET bio_en = 'Teodoro Reyes is a Dominican musician born in 1954 in Mao, the capital of Valverde province in the northwestern Cibao, whose career has contributed to the popular music tradition of the Dominican Republic. Mao is a city in the agricultural heart of the Cibao, and Reyes''s formation there gave him a grounding in the traditional sounds of the region that has always been central to Dominican musical identity. His career as a musician reflects the long tradition of Dominican popular music rooted in the provinces, where artists develop their craft in community with their neighbors and audiences before reaching broader national and international recognition. Reyes represents the provincial musical heritage that is the foundation of Dominican popular song.', bio_es = NULL,
       birth_place = 'Mao', province = 'Valverde', aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb WHERE slug = 'teodoro-reyes';
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Casandra' AND cat.name = 'Bachatero del Año'
   AND w.year = 1994 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'teodoro-reyes');

COMMIT;
