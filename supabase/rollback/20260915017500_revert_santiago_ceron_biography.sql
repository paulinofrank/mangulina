BEGIN;

-- Revierte 20260915017500_rewrite_santiago_ceron_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'santiago-ceron' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'santiago-ceron') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Santiago Cerón was a Dominican musician and artist whose career spanned the middle decades of the twentieth century and into the early twenty-first, connecting the traditions of an older era to the musical environment of the present. Born in 1940 in Santiago de los Caballeros, the cultural capital of the Cibao region, he grew up in a city with a storied musical heritage and developed his artistic practice in dialogue with the rich popular music traditions of that region. The Cibao valley has been central to the development of merengue and other forms of Dominican popular music, and Cerón''s formation in that environment gave him a deep grounding in the sounds and sensibilities that define Dominican culture at its most locally rooted. He contributed to Dominican musical life over a career of several decades before passing away in 2011 at the age of 71.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'santiago-ceron';
UPDATE artists SET bio_en = 'Santiago Cerón was a Dominican musician and artist whose career spanned the middle decades of the twentieth century and into the early twenty-first, connecting the traditions of an older era to the musical environment of the present. Born in 1940 in Santiago de los Caballeros, the cultural capital of the Cibao region, he grew up in a city with a storied musical heritage and developed his artistic practice in dialogue with the rich popular music traditions of that region. The Cibao valley has been central to the development of merengue and other forms of Dominican popular music, and Cerón''s formation in that environment gave him a deep grounding in the sounds and sensibilities that define Dominican culture at its most locally rooted. He contributed to Dominican musical life over a career of several decades before passing away in 2011 at the age of 71.', bio_es = NULL,
       birth_place = 'Santiago de los Caballeros', province = 'Santiago', primary_genre = 'merengue',
       genres = ARRAY[]::text[], occupations = '[]'::jsonb, instruments = ARRAY[]::text[]
       WHERE slug = 'santiago-ceron';

COMMIT;
