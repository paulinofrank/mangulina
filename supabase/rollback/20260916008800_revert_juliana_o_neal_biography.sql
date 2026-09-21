BEGIN;

-- Revierte 20260916008800_rewrite_juliana_o_neal_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juliana-o-neal' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'juliana-o-neal') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juliana O''Neal is a Dominican artist born in 1988 in Santo Domingo who has made her mark in the merengue de calle, mambo, and tropical genres. As a female voice in the merengue de calle scene — a style known for its street energy and percussive intensity — she has brought a distinctive presence to a space where women have historically been underrepresented. Her recordings and performances have demonstrated both vocal power and a natural feel for the rhythms that make merengue de calle so compelling to its devoted audience. O''Neal represents the younger generation of Dominican artists who carry forward the traditions of tropical and merengue music while stamping them with a contemporary identity.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juliana-o-neal';
UPDATE artists SET bio_en = 'Juliana O''Neal is a Dominican artist born in 1988 in Santo Domingo who has made her mark in the merengue de calle, mambo, and tropical genres. As a female voice in the merengue de calle scene — a style known for its street energy and percussive intensity — she has brought a distinctive presence to a space where women have historically been underrepresented. Her recordings and performances have demonstrated both vocal power and a natural feel for the rhythms that make merengue de calle so compelling to its devoted audience. O''Neal represents the younger generation of Dominican artists who carry forward the traditions of tropical and merengue music while stamping them with a contemporary identity.', bio_es = NULL, date_of_birth = '1988-04-08'::date, aliases = ARRAY['La Reina del Mambo']::text[] WHERE slug = 'juliana-o-neal';

COMMIT;
