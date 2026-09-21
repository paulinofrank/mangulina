BEGIN;

-- Revierte 20260916005200_rewrite_el_negro_5_estrellas_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-negro-5-estrellas' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-negro-5-estrellas') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"El Negro 5 Estrellas is a Dominican merengue de calle artist from Santo Domingo whose music channels the street-level energy and percussive intensity that define the genre. Merengue de calle — literally street merengue — is the raw, working-class-identified variant of merengue that prioritizes rhythmic drive and communal celebration over polished production, and El Negro 5 Estrellas has built his reputation by delivering that energy consistently. His connection to Santo Domingo places him within the capital''s vibrant street music culture, where merengue de calle remains a living, constantly evolving tradition. The five-star designation in his name signals confidence and quality — an assertion of excellence within a genre where artists compete fiercely for neighborhood and national recognition.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'el-negro-5-estrellas';
UPDATE artists SET bio_en = 'El Negro 5 Estrellas is a Dominican merengue de calle artist from Santo Domingo whose music channels the street-level energy and percussive intensity that define the genre. Merengue de calle — literally street merengue — is the raw, working-class-identified variant of merengue that prioritizes rhythmic drive and communal celebration over polished production, and El Negro 5 Estrellas has built his reputation by delivering that energy consistently. His connection to Santo Domingo places him within the capital''s vibrant street music culture, where merengue de calle remains a living, constantly evolving tradition. The five-star designation in his name signals confidence and quality — an assertion of excellence within a genre where artists compete fiercely for neighborhood and national recognition.', bio_es = NULL, middle_name = NULL,
       primary_genre = 'urbano', genres = ARRAY[]::text[], youtube = NULL WHERE slug = 'el-negro-5-estrellas';

COMMIT;
