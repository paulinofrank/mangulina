BEGIN;

-- Revierte 20260916001700_rewrite_junior_jorge_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'junior-jorge' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'junior-jorge') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Junior & Jorge is a Dominican musical duo working in bachata and tropical, bringing together two performers whose combined talents have contributed to the romantic and dance-oriented side of Dominican popular music. Bachata duos have a particular appeal because the genre''s emotional themes — love, heartbreak, longing, reunion — lend themselves to the interplay of two voices, creating harmonies and vocal conversations that amplify the intimate quality of the music. Their work in tropical ensures that the duo reaches audiences beyond the core bachata faithful, connecting them to the broader dance music tradition that encompasses much of Dominican popular culture.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'junior-jorge';
UPDATE artists SET bio_en = 'Junior & Jorge is a Dominican musical duo working in bachata and tropical, bringing together two performers whose combined talents have contributed to the romantic and dance-oriented side of Dominican popular music. Bachata duos have a particular appeal because the genre''s emotional themes — love, heartbreak, longing, reunion — lend themselves to the interplay of two voices, creating harmonies and vocal conversations that amplify the intimate quality of the music. Their work in tropical ensures that the duo reaches audiences beyond the core bachata faithful, connecting them to the broader dance music tradition that encompasses much of Dominican popular culture.', bio_es = NULL,
       birth_place = 'Santo Domingo', province = 'Distrito Nacional',
       formation_year = NULL, dissolution_year = NULL
       WHERE slug = 'junior-jorge';

COMMIT;
