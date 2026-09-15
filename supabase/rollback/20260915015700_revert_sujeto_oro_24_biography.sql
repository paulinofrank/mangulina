BEGIN;

-- Revierte 20260915015700_rewrite_sujeto_oro_24_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sujeto-oro-24' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sujeto-oro-24') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Sujeto Oro 24 is a Dominican merengue artist whose name — Gold Subject 24 — evokes the standard of pure gold as a metaphor for musical quality and authenticity. Working within the merengue tradition, Sujeto Oro 24 participates in the ongoing popular music culture of Santo Domingo, bringing the festive rhythms and communal energy that have defined merengue as a national genre for over a century. His work contributes to the steady stream of merengue being created and performed in the Dominican Republic, ensuring that this foundational genre continues to find new voices and reach new audiences even as urban music has increasingly dominated the commercial landscape.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'sujeto-oro-24';
UPDATE artists SET bio_en = 'Sujeto Oro 24 is a Dominican merengue artist whose name — Gold Subject 24 — evokes the standard of pure gold as a metaphor for musical quality and authenticity. Working within the merengue tradition, Sujeto Oro 24 participates in the ongoing popular music culture of Santo Domingo, bringing the festive rhythms and communal energy that have defined merengue as a national genre for over a century. His work contributes to the steady stream of merengue being created and performed in the Dominican Republic, ensuring that this foundational genre continues to find new voices and reach new audiences even as urban music has increasingly dominated the commercial landscape.', bio_es = NULL, primary_genre = 'urbano'
       WHERE slug = 'sujeto-oro-24';

COMMIT;
