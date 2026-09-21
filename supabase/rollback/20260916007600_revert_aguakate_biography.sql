BEGIN;

-- Revierte 20260916007600_rewrite_aguakate_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'aguakate' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aguakate') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Aguakate is a Dominican music group working in the genres of merengue típico and tropical, contributing to the living tradition of accordion-driven merengue that remains one of the most beloved and culturally distinctive sounds in the Dominican Republic. Their name — the Spanish word for avocado — suggests a connection to the natural abundance of the Caribbean and an unpretentious, down-to-earth character that aligns well with the grassroots spirit of típico music. By performing and recording in the típico tradition, Aguakate participates in the ongoing effort to maintain and transmit a musical heritage that predates the commercial music industry and carries within it centuries of Dominican cultural memory.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'aguakate';
UPDATE artists SET bio_en = 'Aguakate is a Dominican music group working in the genres of merengue típico and tropical, contributing to the living tradition of accordion-driven merengue that remains one of the most beloved and culturally distinctive sounds in the Dominican Republic. Their name — the Spanish word for avocado — suggests a connection to the natural abundance of the Caribbean and an unpretentious, down-to-earth character that aligns well with the grassroots spirit of típico music. By performing and recording in the típico tradition, Aguakate participates in the ongoing effort to maintain and transmit a musical heritage that predates the commercial music industry and carries within it centuries of Dominican cultural memory.', bio_es = NULL, birth_year = NULL, birth_place = 'Santiago', province = 'Santiago', ended = 'true', primary_genre = 'merengue', artist_tags = ARRAY['secular']::text[] WHERE slug = 'aguakate';

COMMIT;
