BEGIN;

-- Revierte 20260916006300_rewrite_albert_mendez_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'albert-mendez' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'albert-mendez') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Albert Mendez is a Dominican artist whose work in bachata and tropical contributes to the ongoing vitality of these foundational Dominican popular genres. His engagement with bachata places him within one of the most emotionally rich and historically significant traditions in Dominican music — a genre that traveled from stigmatized folk music to global phenomenon over the course of the twentieth century. Mendez brings his own voice to the bachata tradition, adding to the extensive catalog of Dominican artists who have found in the genre''s acoustic intimacy and emotional directness the perfect vehicle for the stories and feelings that define human experience. His work in tropical extends his musical identity into the broader festive tradition of Caribbean dance music.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'albert-mendez';
UPDATE artists SET bio_en = 'Albert Mendez is a Dominican artist whose work in bachata and tropical contributes to the ongoing vitality of these foundational Dominican popular genres. His engagement with bachata places him within one of the most emotionally rich and historically significant traditions in Dominican music — a genre that traveled from stigmatized folk music to global phenomenon over the course of the twentieth century. Mendez brings his own voice to the bachata tradition, adding to the extensive catalog of Dominican artists who have found in the genre''s acoustic intimacy and emotional directness the perfect vehicle for the stories and feelings that define human experience. His work in tropical extends his musical identity into the broader festive tradition of Caribbean dance music.', bio_es = NULL, birth_place = NULL, province = NULL,
       primary_genre = 'bachata', occupations = '[]'::jsonb, artist_tags = ARRAY['secular','emerging']::text[], aliases = ARRAY[]::text[] WHERE slug = 'albert-mendez';

COMMIT;
