BEGIN;

-- Revierte 20260916008000_rewrite_bryan_dotel_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'bryan-dotel' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bryan-dotel') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Bryan Dotel is a Dominican artist working in pop, ballad, and acoustic music whose work reflects the quieter, melody-focused side of Dominican popular song. His engagement with acoustic music alongside pop and ballad styles places him within a tradition of Dominican artists who have sought expressive territory beyond the danceable rhythms of merengue, bachata, and dembow — territory defined by lyrical depth, melodic craftsmanship, and the intimacy of a voice in direct relationship with its audience. In a musical environment that often prizes volume and energy, Bryan Dotel''s acoustic sensibility offers a different kind of intensity — the intensity of a well-crafted song performed with sincerity and care.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bryan-dotel';
UPDATE artists SET bio_en = 'Bryan Dotel is a Dominican artist working in pop, ballad, and acoustic music whose work reflects the quieter, melody-focused side of Dominican popular song. His engagement with acoustic music alongside pop and ballad styles places him within a tradition of Dominican artists who have sought expressive territory beyond the danceable rhythms of merengue, bachata, and dembow — territory defined by lyrical depth, melodic craftsmanship, and the intimacy of a voice in direct relationship with its audience. In a musical environment that often prizes volume and energy, Bryan Dotel''s acoustic sensibility offers a different kind of intensity — the intensity of a well-crafted song performed with sincerity and care.', bio_es = NULL, primary_genre = 'merengue', genres = ARRAY['ballads']::text[], occupations = '["musician","producer"]'::jsonb WHERE slug = 'bryan-dotel';

COMMIT;
