BEGIN;

-- Revierte 20260914011900_rewrite_pena_suazo_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-pena-suazo-y-la-banda-gorda') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José Peña Suazo, popularly known as El Ciego de Nagua, is a Dominican merengue artist born in 1967 in Cotuí, the capital of the Sánchez Ramírez province in the Cibao. Despite losing his sight, he developed into one of the most respected figures in traditional Dominican merengue, with a command of the accordion that earned him wide admiration among fans and fellow musicians. His connection to the típico tradition of the Cibao gave his music an authenticity rooted in the countryside and the folk practices of the Dominican interior.","type":"text"}]},{"type":"paragraph","content":[{"text":"Peña Suazo''s recordings and live performances demonstrated that his disability was no barrier to a life of full artistic expression, and his resilience made him an inspirational as well as a musical figure. He remains one of the cherished voices of Dominican merengue típico, celebrated for keeping alive a tradition that is central to the island''s cultural identity.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jose-pena-suazo-y-la-banda-gorda';
UPDATE artists SET bio_en = 'José Peña Suazo, popularly known as El Ciego de Nagua, is a Dominican merengue artist born in 1967 in Cotuí, the capital of the Sánchez Ramírez province in the Cibao. Despite losing his sight, he developed into one of the most respected figures in traditional Dominican merengue, with a command of the accordion that earned him wide admiration among fans and fellow musicians. His connection to the típico tradition of the Cibao gave his music an authenticity rooted in the countryside and the folk practices of the Dominican interior.

Peña Suazo''s recordings and live performances demonstrated that his disability was no barrier to a life of full artistic expression, and his resilience made him an inspirational as well as a musical figure. He remains one of the cherished voices of Dominican merengue típico, celebrated for keeping alive a tradition that is central to the island''s cultural identity.', bio_es = NULL, instruments = ARRAY[]::text[] WHERE slug = 'jose-pena-suazo-y-la-banda-gorda';
DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Merengue del Año'
   AND w.year = 2015 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'jose-pena-suazo-y-la-banda-gorda');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Premios Soberano' AND cat.name = 'Merengue del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);

COMMIT;
