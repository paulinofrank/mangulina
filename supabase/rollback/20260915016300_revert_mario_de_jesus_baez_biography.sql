BEGIN;

-- Revierte 20260915016300_rewrite_mario_de_jesus_baez_biography.sql con los documentos, premios y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM artist_awards WHERE artist_id = (SELECT id FROM artists WHERE slug = 'mario-de-jesus-baez')
   AND year = 1995 AND work = 'Ni con la vida te pago';
DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'mario-de-jesus-baez' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mario-de-jesus-baez') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Mario de Jesús Báez was a Dominican musician born in 1924 in San Pedro de Macorís whose career navigated the interconnected worlds of bolero, cumbia, salsa, and merengue with the ease of a musician who understood Latin popular music as a unified creative ecosystem rather than a set of competing national traditions. San Pedro de Macorís, a port city with a cosmopolitan history shaped by immigration and the sugar trade, provided a fitting birthplace for an artist whose music would cross borders with similar ease.","type":"text"}]},{"type":"paragraph","content":[{"text":"Báez worked as a performer and recording artist across several decades, contributing to the richness of Dominican popular music during the mid-twentieth-century period when the country''s music industry was establishing its infrastructure and identity. His work in bolero captured the romantic sensibility that made that genre dominant across Latin America in the postwar period, while his engagement with salsa and cumbia reflected a musician who paid close attention to what was happening across the broader Latin music world. He passed away in 2008.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'mario-de-jesus-baez';
UPDATE artists SET bio_en = 'Mario de Jesús Báez was a Dominican musician born in 1924 in San Pedro de Macorís whose career navigated the interconnected worlds of bolero, cumbia, salsa, and merengue with the ease of a musician who understood Latin popular music as a unified creative ecosystem rather than a set of competing national traditions. San Pedro de Macorís, a port city with a cosmopolitan history shaped by immigration and the sugar trade, provided a fitting birthplace for an artist whose music would cross borders with similar ease.

Báez worked as a performer and recording artist across several decades, contributing to the richness of Dominican popular music during the mid-twentieth-century period when the country''s music industry was establishing its infrastructure and identity. His work in bolero captured the romantic sensibility that made that genre dominant across Latin America in the postwar period, while his engagement with salsa and cumbia reflected a musician who paid close attention to what was happening across the broader Latin music world. He passed away in 2008.', bio_es = NULL,
       middle_name = 'de Jesús', last_name = 'Báez', second_last_name = NULL,
       sort_name = 'Báez, Mario de Jesús', date_of_death = '2008-07-20'
       WHERE slug = 'mario-de-jesus-baez';

COMMIT;
