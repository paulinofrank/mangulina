BEGIN;

-- Revierte 20260915013800_rewrite_juan_hidalgo_biography.sql con los documentos, campos
-- y premios que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-hidalgo' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'juan-hidalgo') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan Hidalgo is a Dominican artist from San Francisco de Macorís whose music in merengue, bachata, and tropical reflects the deep musical culture of the Cibao region. San Francisco de Macorís has been a particularly rich source of Dominican musical talent across many genres, and Hidalgo''s work in both the danceable world of merengue and the more intimate emotional register of bachata demonstrates the versatility characteristic of musicians who grow up surrounded by the full range of popular Dominican styles. His music has found audiences both within the Dominican Republic and among diaspora communities abroad, connecting listeners to the sound of a region that has always punched above its weight in Dominican cultural production.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-hidalgo';
UPDATE artists SET bio_en = 'Juan Hidalgo is a Dominican artist from San Francisco de Macorís whose music in merengue, bachata, and tropical reflects the deep musical culture of the Cibao region. San Francisco de Macorís has been a particularly rich source of Dominican musical talent across many genres, and Hidalgo''s work in both the danceable world of merengue and the more intimate emotional register of bachata demonstrates the versatility characteristic of musicians who grow up surrounded by the full range of popular Dominican styles. His music has found audiences both within the Dominican Republic and among diaspora communities abroad, connecting listeners to the sound of a region that has always punched above its weight in Dominican cultural production.', bio_es = NULL,
       occupations = '[]'::jsonb WHERE slug = 'juan-hidalgo';

DELETE FROM artist_awards w USING award_categories cat, awards a
 WHERE w.category_id = cat.id AND cat.award_id = a.id AND a.name = 'Latin Songwriters Hall of Fame' AND cat.name = 'Ralph S. Peer Publishers Award'
   AND w.year = 2025 AND w.artist_id = (SELECT id FROM artists WHERE slug = 'juan-hidalgo');
DELETE FROM award_categories cat USING awards a
 WHERE cat.award_id = a.id AND a.name = 'Latin Songwriters Hall of Fame' AND cat.name = 'Ralph S. Peer Publishers Award'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.category_id = cat.id);

COMMIT;
