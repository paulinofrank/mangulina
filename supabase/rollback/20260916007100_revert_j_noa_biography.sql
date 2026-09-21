BEGIN;

-- Revierte 20260916007100_rewrite_j_noa_biography.sql con los documentos y campos previos.

DELETE FROM artist_awards WHERE id IN ('4c629060-c9ed-4913-b4cb-decdddc0da03', '0bfe6071-e0ca-4e59-a6f1-3c5c8323b410', 'd24b3d82-cc30-4309-bf0d-d28e002bb23b', '4c0b26e0-ca05-4d59-bd5f-722c012bc9bd');
DELETE FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Rap/Hip Hop Song' AND NOT EXISTS (SELECT 1 FROM artist_awards WHERE category_id = award_categories.id);
DELETE FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Alternative Song' AND NOT EXISTS (SELECT 1 FROM artist_awards WHERE category_id = award_categories.id);

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'j-noa' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'j-noa') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"J NOA is a very young Dominican rap and hip hop artist born in 2005 in San Cristóbal who represents the newest generation of Dominican urban artists. Growing up in a city with its own distinctive character south of Santo Domingo, J NOA has come of age in a Dominican music environment where hip hop and rap have established themselves as credible and culturally significant art forms alongside the more commercially dominant dembow and reggaeton. His engagement with rap at such a young age reflects the maturation of Dominican hip hop as a culture — one that now has enough infrastructure, community, and artistic precedent to cultivate new voices from childhood rather than waiting for artists to discover it as teenagers or young adults.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'j-noa';
UPDATE artists SET bio_en = 'J NOA is a very young Dominican rap and hip hop artist born in 2005 in San Cristóbal who represents the newest generation of Dominican urban artists. Growing up in a city with its own distinctive character south of Santo Domingo, J NOA has come of age in a Dominican music environment where hip hop and rap have established themselves as credible and culturally significant art forms alongside the more commercially dominant dembow and reggaeton. His engagement with rap at such a young age reflects the maturation of Dominican hip hop as a culture — one that now has enough infrastructure, community, and artistic precedent to cultivate new voices from childhood rather than waiting for artists to discover it as teenagers or young adults.', bio_es = NULL, primary_role = 'singer', artist_tags = ARRAY['secular','emerging']::text[] WHERE slug = 'j-noa';

COMMIT;
