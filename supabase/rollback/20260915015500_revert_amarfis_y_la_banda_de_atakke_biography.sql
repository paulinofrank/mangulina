BEGIN;

-- Revierte 20260915015500_rewrite_amarfis_y_la_banda_de_atakke_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'amarfis-y-la-banda-de-atakke' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'amarfis-y-la-banda-de-atakke') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Amarfis y La Banda de Atakke is a Dominican music ensemble associated with merengue de calle, mambo, and tropical, led by the Sabana Grande de Boyá–born artist Amarfis. The band represents the ensemble dimension of the merengue de calle tradition, where a full rhythm section and horn arrangement amplify the percussive intensity of the genre far beyond what a solo artist can achieve. Their music has the full-bodied, driving energy of Dominican street merengue at its most developed, and their presence on the popular music circuit has contributed to keeping the genre''s core audience engaged while attracting new listeners. Amarfis y La Banda de Atakke embody the communal, celebratory spirit that is merengue''s deepest social function.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'amarfis-y-la-banda-de-atakke';
UPDATE artists SET bio_en = 'Amarfis y La Banda de Atakke is a Dominican music ensemble associated with merengue de calle, mambo, and tropical, led by the Sabana Grande de Boyá–born artist Amarfis. The band represents the ensemble dimension of the merengue de calle tradition, where a full rhythm section and horn arrangement amplify the percussive intensity of the genre far beyond what a solo artist can achieve. Their music has the full-bodied, driving energy of Dominican street merengue at its most developed, and their presence on the popular music circuit has contributed to keeping the genre''s core audience engaged while attracting new listeners. Amarfis y La Banda de Atakke embody the communal, celebratory spirit that is merengue''s deepest social function.', bio_es = NULL,
       birth_place = 'Nueva York', province = 'Nacido en el Exterior', formation_year = NULL
       WHERE slug = 'amarfis-y-la-banda-de-atakke';

COMMIT;
