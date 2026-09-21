BEGIN;

-- Revierte 20260916005000_rewrite_antihippie_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'antihippie' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'antihippie') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"AntiHippie is a Dominican artist working in alternative rock, punk, and indie music whose work positions itself deliberately against the dominant currents of Dominican popular culture. The name itself announces an attitude of refusal — not the idealism of the original hippie movement but the punk ethos of rejection and creative confrontation. In a musical environment dominated by dembow, merengue, and bachata, AntiHippie represents the alternative music underground that has always coexisted with Dominican mainstream culture, drawing inspiration from international rock traditions while developing a distinctly Dominican voice within those genres. His work contributes to the diversity of Dominican musical expression and to the community of artists who refuse to define themselves by what sells most.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'antihippie';
UPDATE artists SET bio_en = 'AntiHippie is a Dominican artist working in alternative rock, punk, and indie music whose work positions itself deliberately against the dominant currents of Dominican popular culture. The name itself announces an attitude of refusal — not the idealism of the original hippie movement but the punk ethos of rejection and creative confrontation. In a musical environment dominated by dembow, merengue, and bachata, AntiHippie represents the alternative music underground that has always coexisted with Dominican mainstream culture, drawing inspiration from international rock traditions while developing a distinctly Dominican voice within those genres. His work contributes to the diversity of Dominican musical expression and to the community of artists who refuse to define themselves by what sells most.', bio_es = NULL, genres = ARRAY['urbano']::text[],
       birth_year = NULL WHERE slug = 'antihippie';

COMMIT;
