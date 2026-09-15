BEGIN;

-- Revierte 20260915015300_rewrite_aramis_villalona_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'aramis-villalona' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aramis-villalona') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Aramis Villalona is a Dominican merengue and tropical musician with roots in Loma de Cabrera, the small northwestern municipality in Dajabón province that sits close to the Haitian border. His connection to this borderland region gives his music a particular cultural grounding — Loma de Cabrera is a place where Dominican and Haitian influences have coexisted and occasionally mingled, shaping a local culture with its own distinctive character. Villalona has carried the merengue and tropical traditions of this regional context into a broader musical career, contributing recordings and performances that reflect both the national genre and the specific regional sensibility of his origins. His work adds to the geographic and cultural diversity of Dominican popular music.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'aramis-villalona';
UPDATE artists SET bio_en = 'Aramis Villalona is a Dominican merengue and tropical musician with roots in Loma de Cabrera, the small northwestern municipality in Dajabón province that sits close to the Haitian border. His connection to this borderland region gives his music a particular cultural grounding — Loma de Cabrera is a place where Dominican and Haitian influences have coexisted and occasionally mingled, shaping a local culture with its own distinctive character. Villalona has carried the merengue and tropical traditions of this regional context into a broader musical career, contributing recordings and performances that reflect both the national genre and the specific regional sensibility of his origins. His work adds to the geographic and cultural diversity of Dominican popular music.', bio_es = NULL,
       second_last_name = NULL WHERE slug = 'aramis-villalona';

COMMIT;
