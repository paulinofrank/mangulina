BEGIN;

-- Revierte 20260916001600_rewrite_jochy_hernandez_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jochy-hernandez' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jochy-hernandez') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jochy Hernández was a Dominican merengue singer born in 1963 in San Cristóbal whose career, though brief, earned him a devoted following in the Dominican Republic. He developed a reputation as a powerful vocalist with genuine stage presence, performing merengue with the energy and conviction that audiences in the Cibao tradition demanded. His recordings captured the spirit of Dominican tropical music in the late 1980s and early 1990s, and he was considered a rising talent with significant potential. His death in 1994 cut short a career that many believed was still ascending, and he is remembered by fans of classic Dominican merengue as an artist taken too soon.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jochy-hernandez';
UPDATE artists SET bio_en = 'Jochy Hernández was a Dominican merengue singer born in 1963 in San Cristóbal whose career, though brief, earned him a devoted following in the Dominican Republic. He developed a reputation as a powerful vocalist with genuine stage presence, performing merengue with the energy and conviction that audiences in the Cibao tradition demanded. His recordings captured the spirit of Dominican tropical music in the late 1980s and early 1990s, and he was considered a rising talent with significant potential. His death in 1994 cut short a career that many believed was still ascending, and he is remembered by fans of classic Dominican merengue as an artist taken too soon.', bio_es = NULL,
       last_name = 'Díaz', second_last_name = 'Hernández', aliases = ARRAY['El Amiguito','Jose Johnsmil Hernandez Aristy']::text[]
       WHERE slug = 'jochy-hernandez';

COMMIT;
