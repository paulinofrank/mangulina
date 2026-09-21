BEGIN;

-- Revierte 20260916004800_rewrite_jose_el_calvo_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-el-calvo') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José El Calvo is a Dominican merengue típico and tropical artist born in 1956 in Imbert, in the northern province of Puerto Plata, a region with deep roots in traditional Cibao culture. His origins in this highland community, closely connected to the heartland of accordion-driven típico merengue, shaped his musical sensibility from an early age. José El Calvo has built a career as a performer of authentic merengue típico, a style that relies on the interaction of accordion, tambora drum, and güira scraper to create its characteristic driving energy. His music reflects the rural Dominican traditions that gave birth to merengue long before the genre was polished for urban and international audiences, and his commitment to this sound has made him a respected figure among lovers of traditional Dominican music.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = 'jose-el-calvo';
UPDATE artists SET bio_en = 'José El Calvo is a Dominican merengue típico and tropical artist born in 1956 in Imbert, in the northern province of Puerto Plata, a region with deep roots in traditional Cibao culture. His origins in this highland community, closely connected to the heartland of accordion-driven típico merengue, shaped his musical sensibility from an early age. José El Calvo has built a career as a performer of authentic merengue típico, a style that relies on the interaction of accordion, tambora drum, and güira scraper to create its characteristic driving energy. His music reflects the rural Dominican traditions that gave birth to merengue long before the genre was polished for urban and international audiences, and his commitment to this sound has made him a respected figure among lovers of traditional Dominican music.', bio_es = NULL, first_name = 'José', middle_name = 'Gabriel',
       last_name = 'Guaba', second_last_name = NULL, aliases = ARRAY['Jose El Calvo y Su Conjunto Tipico']::text[],
       primary_role = 'singer', occupations = '["musician","bandleader"]'::jsonb, genres = ARRAY[]::text[]
       WHERE slug = 'jose-el-calvo';

COMMIT;
