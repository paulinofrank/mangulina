BEGIN;

-- Reverts 20260908008200_rewrite_joan_soriano_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Joan Soriano',
       sort_name = 'Soriano, Joan',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = NULL,
       birth_year = 1972,
       date_of_death = NULL,
       birth_place = 'Monte Plata',
       province = 'Monte Plata',
       first_name = 'Joan',
       middle_name = NULL,
       last_name = 'Soriano',
       second_last_name = NULL,
       stage_name = 'Joan Soriano',
       aliases = ARRAY['El Duque de la Bachata']::text[],
       occupations = '["musician","composer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'instrumental']::text[],
       website = 'https://joansorianomusic.com',
       youtube = '@joansorianoysubandaloscand3620',
       facebook = 'JoanSorianoMusic',
       instagram = 'joansorianomusic',
       disambiguation = NULL,
       bio_en = 'Joan Soriano is a Dominican guitarist and singer born in 1972 in Monte Plata whose work in bachata has earned him recognition as one of the genre''s most authentic contemporary practitioners. Soriano comes from a musical family — his father and other relatives were musicians — and he absorbed the acoustic, guitar-centered style of traditional bachata from the inside out, understanding the genre not as a commercial product but as a living folk tradition rooted in Dominican rural culture.

His music has attracted the attention of world music audiences internationally, giving traditional Dominican bachata a global platform at a time when the genre''s commercial mainstream had moved significantly toward pop production. Soriano''s recordings retain the rough emotional honesty and acoustic intimacy that characterized bachata''s origins, presenting a counterpoint to the polished, internationally marketed version of the genre.

He has performed at world music festivals in Europe and elsewhere, introducing listeners unfamiliar with Dominican culture to the raw beauty of bachata in its most traditional form.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'joan-soriano';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joan-soriano')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joan-soriano')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Joan Soriano is a Dominican guitarist and singer born in 1972 in Monte Plata whose work in bachata has earned him recognition as one of the genre''s most authentic contemporary practitioners. Soriano comes from a musical family — his father and other relatives were musicians — and he absorbed the acoustic, guitar-centered style of traditional bachata from the inside out, understanding the genre not as a commercial product but as a living folk tradition rooted in Dominican rural culture.","type":"text"}]},{"type":"paragraph","content":[{"text":"His music has attracted the attention of world music audiences internationally, giving traditional Dominican bachata a global platform at a time when the genre''s commercial mainstream had moved significantly toward pop production. Soriano''s recordings retain the rough emotional honesty and acoustic intimacy that characterized bachata''s origins, presenting a counterpoint to the polished, internationally marketed version of the genre.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has performed at world music festivals in Europe and elsewhere, introducing listeners unfamiliar with Dominican culture to the raw beauty of bachata in its most traditional form.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'joan-soriano'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
