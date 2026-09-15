BEGIN;

-- Revierte 20260915011800_rewrite_dioris_valladares_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'dioris-valladares' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'dioris-valladares') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Dioris Valladares was a Dominican musician born in 1916 in San Pedro de Macorís whose long career in merengue, tropical music, and bolero made him a respected figure in Dominican popular music across much of the twentieth century. San Pedro de Macorís, a cosmopolitan city shaped by waves of immigration and the rhythms of the sugar economy, was a fitting birthplace for a musician who would work across multiple styles and in multiple cultural contexts during his career.","type":"text"}]},{"type":"paragraph","content":[{"text":"Valladares performed and recorded during decades that saw merengue evolve from primarily regional folk music into the defining sound of Dominican national identity, and he was part of the generation that helped facilitate that transformation. His bolero work connected him to the broader Latin American romantic tradition, reflecting the close musical ties between the Dominican Republic and the rest of the Spanish-speaking Caribbean and Latin American world.","type":"text"}]},{"type":"paragraph","content":[{"text":"He passed away in 2001 at the age of eighty-eight, leaving a recording legacy that documents Dominican popular music across a remarkable span of the twentieth century.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = 'dioris-valladares';
UPDATE artists SET bio_en = 'Dioris Valladares was a Dominican musician born in 1916 in San Pedro de Macorís whose long career in merengue, tropical music, and bolero made him a respected figure in Dominican popular music across much of the twentieth century. San Pedro de Macorís, a cosmopolitan city shaped by waves of immigration and the rhythms of the sugar economy, was a fitting birthplace for a musician who would work across multiple styles and in multiple cultural contexts during his career.

Valladares performed and recorded during decades that saw merengue evolve from primarily regional folk music into the defining sound of Dominican national identity, and he was part of the generation that helped facilitate that transformation. His bolero work connected him to the broader Latin American romantic tradition, reflecting the close musical ties between the Dominican Republic and the rest of the Spanish-speaking Caribbean and Latin American world.

He passed away in 2001 at the age of eighty-eight, leaving a recording legacy that documents Dominican popular music across a remarkable span of the twentieth century.', bio_es = NULL, second_last_name = NULL,
       occupations = '["bandleader","musician"]'::jsonb,
       instruments = ARRAY[]::text[] WHERE slug = 'dioris-valladares';

COMMIT;
