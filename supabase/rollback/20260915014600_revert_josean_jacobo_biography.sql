BEGIN;

-- Revierte 20260915014600_rewrite_josean_jacobo_biography.sql con los documentos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'josean-jacobo' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'josean-jacobo') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Josean Jacobo is a Dominican jazz musician born in 1983 in Santo Domingo whose work has established him as one of the leading voices in contemporary Latin jazz and Afro-Dominican jazz from the Caribbean. Jacobo''s musical language draws on multiple traditions simultaneously — the improvisational freedom of jazz, the rhythmic complexity of Afro-Dominican percussion and folklore, and the harmonic richness of Latin jazz — weaving them into a sound that feels both deeply local and genuinely international.","type":"text"}]},{"type":"paragraph","content":[{"text":"Based in Santo Domingo and active in regional and international jazz circuits, he has worked to raise the profile of Dominican jazz as a distinct creative tradition rather than simply a regional variant of American or Cuban models. His fusion work pushes the boundaries further, incorporating electronic and contemporary elements into a fundamentally acoustic jazz sensibility. Jacobo represents a generation of Dominican jazz musicians committed to building a serious, sustained jazz culture rooted in their own island''s musical heritage.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'josean-jacobo';
UPDATE artists SET bio_en = 'Josean Jacobo is a Dominican jazz musician born in 1983 in Santo Domingo whose work has established him as one of the leading voices in contemporary Latin jazz and Afro-Dominican jazz from the Caribbean. Jacobo''s musical language draws on multiple traditions simultaneously — the improvisational freedom of jazz, the rhythmic complexity of Afro-Dominican percussion and folklore, and the harmonic richness of Latin jazz — weaving them into a sound that feels both deeply local and genuinely international.

Based in Santo Domingo and active in regional and international jazz circuits, he has worked to raise the profile of Dominican jazz as a distinct creative tradition rather than simply a regional variant of American or Cuban models. His fusion work pushes the boundaries further, incorporating electronic and contemporary elements into a fundamentally acoustic jazz sensibility. Jacobo represents a generation of Dominican jazz musicians committed to building a serious, sustained jazz culture rooted in their own island''s musical heritage.', bio_es = NULL WHERE slug = 'josean-jacobo';

COMMIT;
