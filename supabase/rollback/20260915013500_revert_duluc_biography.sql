BEGIN;

-- Revierte 20260915013500_rewrite_duluc_biography.sql con los documentos, campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'duluc' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'duluc') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Duluc is a Dominican artist born in 1957 in Higüey who has pursued one of the more unconventional creative paths in Dominican music, working across Dominican folklore, fusion, rock, and tropical. His willingness to cross genre boundaries and blend the sounds of Dominican folk tradition with rock and fusion influences has made him a singular figure — one who does not fit neatly into any single category but occupies a distinctive space in the island''s musical ecosystem. Born in the same eastern city as Fausto Rey, Duluc grew up surrounded by traditional Dominican musical culture but chose to engage with it in ways that pushed outward toward new forms. His work has been appreciated by listeners who seek music that engages seriously with Dominican identity while refusing to be limited by convention.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'duluc';
UPDATE artists SET bio_en = 'Duluc is a Dominican artist born in 1957 in Higüey who has pursued one of the more unconventional creative paths in Dominican music, working across Dominican folklore, fusion, rock, and tropical. His willingness to cross genre boundaries and blend the sounds of Dominican folk tradition with rock and fusion influences has made him a singular figure — one who does not fit neatly into any single category but occupies a distinctive space in the island''s musical ecosystem. Born in the same eastern city as Fausto Rey, Duluc grew up surrounded by traditional Dominican musical culture but chose to engage with it in ways that pushed outward toward new forms. His work has been appreciated by listeners who seek music that engages seriously with Dominican identity while refusing to be limited by convention.', bio_es = NULL,
       date_of_birth = NULL,
       birth_year = 1957 WHERE slug = 'duluc';

COMMIT;
