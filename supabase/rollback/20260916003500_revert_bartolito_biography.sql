BEGIN;

-- Revierte 20260916003500_rewrite_bartolito_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'bartolito-y-los-bravos-del-son' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bartolito-y-los-bravos-del-son') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Bartolito y Los Bravos del Son is a Dominican music group that has worked within the traditions of son dominicano, Afro-Cuban music, and tropical, occupying a distinctive niche within the broader Caribbean popular music landscape. Son — the rhythmic and melodic matrix from which much of Latin popular music descended — has deep roots throughout the Caribbean, and in the Dominican Republic it has been filtered through local sensibilities to create a version of the style with its own character. By working in both Dominican son and Afro-Cuban forms, the group situates itself within the larger pan-Caribbean musical conversation while maintaining a Dominican identity. Their tropical material brings their sound to a wider audience, connecting the more specialized son repertoire to the mainstream dance music that Dominican audiences know and love.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bartolito-y-los-bravos-del-son';
UPDATE artists SET bio_en = 'Bartolito y Los Bravos del Son is a Dominican music group that has worked within the traditions of son dominicano, Afro-Cuban music, and tropical, occupying a distinctive niche within the broader Caribbean popular music landscape. Son — the rhythmic and melodic matrix from which much of Latin popular music descended — has deep roots throughout the Caribbean, and in the Dominican Republic it has been filtered through local sensibilities to create a version of the style with its own character. By working in both Dominican son and Afro-Cuban forms, the group situates itself within the larger pan-Caribbean musical conversation while maintaining a Dominican identity. Their tropical material brings their sound to a wider audience, connecting the more specialized son repertoire to the mainstream dance music that Dominican audiences know and love.', bio_es = NULL,
       formation_year = NULL, primary_genre = 'salsa',
       genres = ARRAY[]::text[], occupations = '[]'::jsonb, aliases = ARRAY['Los Bravos del Son','Bartolito']::text[]
       WHERE slug = 'bartolito-y-los-bravos-del-son';

COMMIT;
