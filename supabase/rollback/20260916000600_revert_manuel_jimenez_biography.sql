BEGIN;

-- Revierte 20260916000600_rewrite_manuel_jimenez_biography.sql con los documentos, premios y campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'manuel-jimenez') AND document_type = 'artist_biography';
DELETE FROM artist_awards WHERE artist_id = (SELECT id FROM artists WHERE slug = 'manuel-jimenez') AND award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e'
   AND year IN (1990, 1992, 1994) AND source = 'Wikipedia (es); Diccionario Cultural Dominicano (FUNGLODE); El Nuevo Diario (2020); Listín Diario (2020)';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Manuel Jiménez is a Dominican musician born in 1952 whose career has contributed to the popular music tradition of the Dominican Republic across several decades of performance and recording. His presence in Dominican musical life reflects the commitment of working musicians who sustain the country''s popular music culture through decades of dedicated craft, even when their names may not be as widely known as the genre''s biggest commercial stars. Jiménez is part of the large and essential community of Dominican musicians whose work forms the foundation on which the country''s celebrated popular music tradition rests — playing in bands, recording albums, and performing at the events where Dominican music is most directly experienced by its audiences.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manuel-jimenez';
UPDATE artists SET bio_en = 'Manuel Jiménez is a Dominican musician born in 1952 whose career has contributed to the popular music tradition of the Dominican Republic across several decades of performance and recording. His presence in Dominican musical life reflects the commitment of working musicians who sustain the country''s popular music culture through decades of dedicated craft, even when their names may not be as widely known as the genre''s biggest commercial stars. Jiménez is part of the large and essential community of Dominican musicians whose work forms the foundation on which the country''s celebrated popular music tradition rests — playing in bands, recording albums, and performing at the events where Dominican music is most directly experienced by its audiences.', bio_es = NULL,
       middle_name = NULL, second_last_name = NULL,
       birth_place = NULL, province = NULL,
       primary_genre = 'merengue', occupations = '[]'::jsonb
       WHERE slug = 'manuel-jimenez';

COMMIT;
