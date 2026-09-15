BEGIN;

-- Revierte 20260915016800_rewrite_jose_rufino_reyes_y_siancas_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-rufino-reyes-y-siancas' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-rufino-reyes-y-siancas') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José Rufino Reyes y Siancas was one of the earliest known Dominican composers working in a Christian and instrumental tradition. Born in Santo Domingo in 1835, he came of age during a period of immense political turbulence in Dominican history, including the era surrounding independence and the country''s complicated relationship with its neighbors.","type":"text"}]},{"type":"paragraph","content":[{"text":"Despite these upheavals, Reyes dedicated himself to musical composition, contributing sacred and instrumental works at a time when formal musical education and infrastructure in the Dominican Republic were rudimentary at best. He passed away in 1905, leaving behind a legacy that, while not widely documented in surviving recordings, occupies an important place in the early history of Dominican art music.","type":"text"}]},{"type":"paragraph","content":[{"text":"His life spanned a formative century for the nation, and his contributions to Christian and instrumental composition helped lay groundwork for later generations of Dominican classical and sacred composers.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jose-rufino-reyes-y-siancas';
UPDATE artists SET bio_en = 'José Rufino Reyes y Siancas was one of the earliest known Dominican composers working in a Christian and instrumental tradition. Born in Santo Domingo in 1835, he came of age during a period of immense political turbulence in Dominican history, including the era surrounding independence and the country''s complicated relationship with its neighbors.

Despite these upheavals, Reyes dedicated himself to musical composition, contributing sacred and instrumental works at a time when formal musical education and infrastructure in the Dominican Republic were rudimentary at best. He passed away in 1905, leaving behind a legacy that, while not widely documented in surviving recordings, occupies an important place in the early history of Dominican art music.

His life spanned a formative century for the nation, and his contributions to Christian and instrumental composition helped lay groundwork for later generations of Dominican classical and sacred composers.', bio_es = NULL, instruments = ARRAY[]::text[]
       WHERE slug = 'jose-rufino-reyes-y-siancas';

COMMIT;
