BEGIN;

-- Revierte 20260915012400_rewrite_primitivo_santos_biography.sql con los documentos, campos
-- y premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'primitivo-santos-y-su-orquesta' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'primitivo-santos-y-su-orquesta') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Primitivo Santos y su Orquesta was a Dominican music group. The group is documented for its contribution to Dominican music and its related scenes.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = 'primitivo-santos-y-su-orquesta';
UPDATE artists SET bio_en = 'Primitivo Santos y su Orquesta was a Dominican music group. The group is documented for its contribution to Dominican music and its related scenes.', bio_es = NULL,
       instruments = ARRAY['piano']::text[] WHERE slug = 'primitivo-santos-y-su-orquesta';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Gobierno de la República Dominicana' AND cat.name = 'Orden del Mérito de Duarte, Sánchez y Mella'
   AND w.year = 2011 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'primitivo-santos-y-su-orquesta');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Gobierno de la República Dominicana' AND cat.name = 'Orden del Mérito de Duarte, Sánchez y Mella'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);

COMMIT;
