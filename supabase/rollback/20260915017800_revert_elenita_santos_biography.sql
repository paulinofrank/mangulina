BEGIN;

-- Revierte 20260915017800_rewrite_elenita_santos_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'elenita-santos' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'elenita-santos') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Elenita Santos was a foundational figure in Dominican folk and popular music, born in 1933 in Santo Domingo. Her work encompassed Dominican folklore, merengue, and tropical music, and she became one of the most important voices in the preservation and popularization of the island''s traditional musical forms.","type":"text"}]},{"type":"paragraph","content":[{"text":"At a time when Dominican folk music was at risk of being overshadowed by foreign influences, Santos championed the authentic sounds and rhythms of her homeland, recording and performing material that rooted her audiences in their own cultural heritage. Her contribution to merengue as a living folk tradition — rather than merely a commercial product — was significant, and she earned deep respect from scholars of Dominican music as well as from general audiences. Her long career left a lasting mark on Dominican musical identity.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'elenita-santos';
UPDATE artists SET bio_en = 'Elenita Santos was a foundational figure in Dominican folk and popular music, born in 1933 in Santo Domingo. Her work encompassed Dominican folklore, merengue, and tropical music, and she became one of the most important voices in the preservation and popularization of the island''s traditional musical forms.

At a time when Dominican folk music was at risk of being overshadowed by foreign influences, Santos championed the authentic sounds and rhythms of her homeland, recording and performing material that rooted her audiences in their own cultural heritage. Her contribution to merengue as a living folk tradition — rather than merely a commercial product — was significant, and she earned deep respect from scholars of Dominican music as well as from general audiences. Her long career left a lasting mark on Dominican musical identity.', bio_es = NULL,
       birth_place = 'Santo Domingo', province = 'Distrito Nacional', primary_genre = 'folklore',
       genres = ARRAY['merengue']::text[], occupations = '[]'::jsonb
       WHERE slug = 'elenita-santos';

COMMIT;
