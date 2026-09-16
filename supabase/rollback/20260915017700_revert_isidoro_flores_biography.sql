BEGIN;

-- Revierte 20260915017700_rewrite_isidoro_flores_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'isidoro-flores' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'isidoro-flores') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Isidoro Flores was a Dominican merengue típico and tropical musician connected to the Santiago region, the cultural capital of the Cibao and the city most closely identified with the accordion-based típico style. His work in this tradition placed him within a long lineage of Cibao musicians who have treated merengue not merely as entertainment but as cultural heritage worthy of careful preservation and passionate performance. Flores contributed to the típico world through recordings and live performances that upheld the rhythmic vitality and improvisational energy that define the genre at its most authentic. His connection to Santiago aligned him with some of the great figures of traditional Dominican music who have called that city home, and his dedication to the form reflected a deep respect for the roots of Dominican musical identity.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = 'isidoro-flores';
UPDATE artists SET bio_en = 'Isidoro Flores was a Dominican merengue típico and tropical musician connected to the Santiago region, the cultural capital of the Cibao and the city most closely identified with the accordion-based típico style. His work in this tradition placed him within a long lineage of Cibao musicians who have treated merengue not merely as entertainment but as cultural heritage worthy of careful preservation and passionate performance. Flores contributed to the típico world through recordings and live performances that upheld the rhythmic vitality and improvisational energy that define the genre at its most authentic. His connection to Santiago aligned him with some of the great figures of traditional Dominican music who have called that city home, and his dedication to the form reflected a deep respect for the roots of Dominican musical identity.', bio_es = NULL, instruments = ARRAY[]::text[]
       WHERE slug = 'isidoro-flores';

COMMIT;
