BEGIN;

-- Revierte 20260916003100_rewrite_francisco_casanova_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'francisco-casanova' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'francisco-casanova') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Francisco Casanova was a Dominican lyric tenor born in 1957 in San Pedro de Macorís whose voice carried him to operatic stages and concert halls well beyond the borders of his homeland. Working in opera, classical repertoire, and the broader lyric tradition, Casanova represented a Dominican presence in a world where Caribbean voices had historically been underrepresented. His training and career placed him within the rigorous demands of operatic performance, requiring not only vocal power and beauty but also dramatic ability and linguistic range.","type":"text"}]},{"type":"paragraph","content":[{"text":"San Pedro de Macorís, a city that has produced a remarkable number of accomplished Dominicans across many fields, gave Casanova his origins, and he carried those roots with him throughout a career built on disciplined artistry. He died in 2019, having spent his professional life demonstrating that Dominican singers could compete and excel in the most demanding arenas of classical vocal performance.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'francisco-casanova';
UPDATE artists SET bio_en = 'Francisco Casanova was a Dominican lyric tenor born in 1957 in San Pedro de Macorís whose voice carried him to operatic stages and concert halls well beyond the borders of his homeland. Working in opera, classical repertoire, and the broader lyric tradition, Casanova represented a Dominican presence in a world where Caribbean voices had historically been underrepresented. His training and career placed him within the rigorous demands of operatic performance, requiring not only vocal power and beauty but also dramatic ability and linguistic range.

San Pedro de Macorís, a city that has produced a remarkable number of accomplished Dominicans across many fields, gave Casanova his origins, and he carried those roots with him throughout a career built on disciplined artistry. He died in 2019, having spent his professional life demonstrating that Dominican singers could compete and excel in the most demanding arenas of classical vocal performance.', bio_es = NULL,
       last_name = 'Casanova', second_last_name = NULL,
       birth_place = 'San Pedro de Macorís', province = 'San Pedro de Macorís'
       WHERE slug = 'francisco-casanova';

COMMIT;
