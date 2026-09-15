BEGIN;

-- Revierte 20260915011300_rewrite_beethoven_villaman_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'beethoven-villaman' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'beethoven-villaman') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Beethoven Villaman is a Dominican underground rap and hip hop artist from Santo Domingo whose work in rap underground and urban music situates him within the independent, artistically serious wing of Dominican hip hop culture. Underground rap in the Dominican context typically signals an artist who prioritizes lyrical substance and creative independence over commercial calculation, and Villaman''s engagement with this tradition reflects a commitment to hip hop as an art form rather than merely a commercial genre. His music speaks to audiences who follow Dominican rap not for its hits but for its ideas, connecting with the community of listeners who value technical skill and genuine expression in their music. Beethoven Villaman contributes to the intellectual and artistic dimension of Dominican urban culture.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'beethoven-villaman';
UPDATE artists SET bio_en = 'Beethoven Villaman is a Dominican underground rap and hip hop artist from Santo Domingo whose work in rap underground and urban music situates him within the independent, artistically serious wing of Dominican hip hop culture. Underground rap in the Dominican context typically signals an artist who prioritizes lyrical substance and creative independence over commercial calculation, and Villaman''s engagement with this tradition reflects a commitment to hip hop as an art form rather than merely a commercial genre. His music speaks to audiences who follow Dominican rap not for its hits but for its ideas, connecting with the community of listeners who value technical skill and genuine expression in their music. Beethoven Villaman contributes to the intellectual and artistic dimension of Dominican urban culture.', bio_es = NULL WHERE slug = 'beethoven-villaman';

COMMIT;
