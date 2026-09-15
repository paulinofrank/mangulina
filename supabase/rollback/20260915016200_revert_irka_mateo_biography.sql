BEGIN;

-- Revierte 20260915016200_rewrite_irka_mateo_biography.sql con los documentos que la ficha
-- tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'irka-mateo' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'irka-mateo') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Irka Mateo is a Dominican singer and cultural activist based in Santo Domingo whose work sits at the convergence of Dominican folklore, world music, and fusion. She has devoted much of her artistic life to excavating and reimagining the Afro-Dominican musical traditions that form the deepest roots of the island''s cultural heritage — the salves, palos, and gagá rhythms associated with the country''s African-descended communities.","type":"text"}]},{"type":"paragraph","content":[{"text":"Through her recordings and extensive live performance work, Mateo has brought these traditions into contemporary contexts, reaching audiences in the Dominican Republic and internationally who might not otherwise encounter this dimension of Dominican culture. She has collaborated with musicians from across the Caribbean and beyond, weaving together threads from different musical traditions into a sound that is always rooted in Dominican identity.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mateo is recognized not only as a musician but as a guardian and transmitter of cultural knowledge, working to ensure that the Afro-Dominican musical heritage survives and thrives in a changing world.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'irka-mateo';
UPDATE artists SET bio_en = 'Irka Mateo is a Dominican singer and cultural activist based in Santo Domingo whose work sits at the convergence of Dominican folklore, world music, and fusion. She has devoted much of her artistic life to excavating and reimagining the Afro-Dominican musical traditions that form the deepest roots of the island''s cultural heritage — the salves, palos, and gagá rhythms associated with the country''s African-descended communities.

Through her recordings and extensive live performance work, Mateo has brought these traditions into contemporary contexts, reaching audiences in the Dominican Republic and internationally who might not otherwise encounter this dimension of Dominican culture. She has collaborated with musicians from across the Caribbean and beyond, weaving together threads from different musical traditions into a sound that is always rooted in Dominican identity.

Mateo is recognized not only as a musician but as a guardian and transmitter of cultural knowledge, working to ensure that the Afro-Dominican musical heritage survives and thrives in a changing world.', bio_es = NULL WHERE slug = 'irka-mateo';

COMMIT;
