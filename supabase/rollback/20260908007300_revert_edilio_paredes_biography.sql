BEGIN;

-- Reverts 20260908007300_rewrite_edilio_paredes_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Edilio Paredes',
       sort_name = 'Paredes, Edilio',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'instrumentalist',
       primary_genre = 'bachata',
       date_of_birth = '1945-09-10',
       birth_year = 1945,
       date_of_death = NULL,
       birth_place = 'San Francisco de Macorís',
       province = 'Duarte',
       first_name = 'Edilio',
       middle_name = NULL,
       last_name = 'Paredes',
       second_last_name = NULL,
       stage_name = 'Edilio Paredes',
       aliases = ARRAY['El Maestro']::text[],
       occupations = '["musician","arranger","composer"]'::jsonb,
       instruments = ARRAY['guitar']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Edilio Paredes is a Dominican bachata and bolero artist born in 1945 in San Francisco de Macorís, a city in the Cibao region that has produced numerous significant figures in Dominican popular music. He belongs to the pioneering generation of bachata musicians who developed and sustained the genre during the decades when it was dismissed by Dominican mainstream society as music of the poor and marginalized.

Paredes contributed recordings and performances that helped bachata survive its years of social stigma, preserving the genre''s emotional authenticity and guitar-based intimacy at a time when it had few champions among the cultural establishment. His work in bolero also demonstrated a broader musical sensibility rooted in the romantic vocal traditions of the Caribbean.

As bachata eventually gained acceptance and international acclaim, artists like Paredes were recognized as essential figures in its history — musicians who kept the flame alive when it would have been easier to abandon it.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'edilio-paredes';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Edilio Paredes is a Dominican bachata and bolero artist born in 1945 in San Francisco de Macorís, a city in the Cibao region that has produced numerous significant figures in Dominican popular music. He belongs to the pioneering generation of bachata musicians who developed and sustained the genre during the decades when it was dismissed by Dominican mainstream society as music of the poor and marginalized.","type":"text"}]},{"type":"paragraph","content":[{"text":"Paredes contributed recordings and performances that helped bachata survive its years of social stigma, preserving the genre''s emotional authenticity and guitar-based intimacy at a time when it had few champions among the cultural establishment. His work in bolero also demonstrated a broader musical sensibility rooted in the romantic vocal traditions of the Caribbean.","type":"text"}]},{"type":"paragraph","content":[{"text":"As bachata eventually gained acceptance and international acclaim, artists like Paredes were recognized as essential figures in its history — musicians who kept the flame alive when it would have been easier to abandon it.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'edilio-paredes'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
