BEGIN;

-- Reverts 20260908007600_rewrite_rafa_rosario_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Rafa Rosario',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1958-12-28',
       birth_year = 1958,
       date_of_death = NULL,
       birth_place = 'Higüey',
       province = 'La Altagracia',
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = '100005450176734',
       instagram = 'rafarosario28',
       disambiguation = NULL,
       bio_en = 'Rafa Rosario is a Dominican musician born in 1958 in Higüey, La Altagracia, whose career has contributed to the popular music tradition of the eastern Dominican Republic. Higüey, the regional capital of the island''s easternmost province, has been home to a number of important Dominican artists — including members of Los Hermanos Rosario — and Rafa Rosario is part of the musical heritage of a city and region that has punched above its weight in Dominican cultural production. His career across multiple decades of Dominican popular music reflects the commitment of a working musician who has dedicated his professional life to the genres and traditions of the country''s popular entertainment.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'rafa-rosario';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Rafa Rosario is a Dominican musician born in 1958 in Higüey, La Altagracia, whose career has contributed to the popular music tradition of the eastern Dominican Republic. Higüey, the regional capital of the island''s easternmost province, has been home to a number of important Dominican artists — including members of Los Hermanos Rosario — and Rafa Rosario is part of the musical heritage of a city and region that has punched above its weight in Dominican cultural production. His career across multiple decades of Dominican popular music reflects the commitment of a working musician who has dedicated his professional life to the genres and traditions of the country''s popular entertainment.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'rafa-rosario'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
