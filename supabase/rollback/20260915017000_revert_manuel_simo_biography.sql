BEGIN;

-- Revierte 20260915017000_rewrite_manuel_simo_biography.sql con los documentos, premios y campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM artist_awards WHERE artist_id = (SELECT id FROM artists WHERE slug = 'manuel-simo')
   AND year = 1944 AND work = 'Cantata para cuarteto de solistas, gran coro y orquesta';
DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-simo' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'manuel-simo') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Manuel Simó was a Dominican musician born in 1916 in San Francisco de Macorís, the capital of Duarte province in the fertile Cibao valley region of the Dominican Republic. As a native of the Cibao, he was born into one of the most musically rich regions of the island, a land deeply associated with the origins and development of merengue. Simó built a career as a performer and bandleader during the mid-twentieth century, contributing to the vibrant popular music scene that flourished even under the cultural constraints of the Trujillo era.","type":"text"}]},{"type":"paragraph","content":[{"text":"His work reflected the distinctive musical character of the Cibao — driving rhythms, expressive melodic lines, and an energy rooted in community celebration. He passed away in 1988, having lived through and participated in some of the most consequential decades in Dominican music history. His contribution belongs to the proud tradition of Cibaeño musicians who gave merengue much of its essential spirit.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manuel-simo';
UPDATE artists SET bio_en = 'Manuel Simó was a Dominican musician born in 1916 in San Francisco de Macorís, the capital of Duarte province in the fertile Cibao valley region of the Dominican Republic. As a native of the Cibao, he was born into one of the most musically rich regions of the island, a land deeply associated with the origins and development of merengue. Simó built a career as a performer and bandleader during the mid-twentieth century, contributing to the vibrant popular music scene that flourished even under the cultural constraints of the Trujillo era.

His work reflected the distinctive musical character of the Cibao — driving rhythms, expressive melodic lines, and an energy rooted in community celebration. He passed away in 1988, having lived through and participated in some of the most consequential decades in Dominican music history. His contribution belongs to the proud tradition of Cibaeño musicians who gave merengue much of its essential spirit.', bio_es = NULL,
       instruments = ARRAY['piano']::text[], occupations = '["conductor"]'::jsonb
       WHERE slug = 'manuel-simo';

COMMIT;
