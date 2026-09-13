BEGIN;

-- Reverts 20260908006600_rewrite_frank_reyes_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Frank Reyes',
       sort_name = 'Reyes, Frank',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1969-06-04',
       birth_year = 1969,
       date_of_death = NULL,
       birth_place = 'Tenares',
       province = 'Hermanas Mirabal',
       first_name = 'Francisco',
       middle_name = NULL,
       last_name = 'López',
       second_last_name = 'Reyes',
       stage_name = 'Frank Reyes',
       aliases = ARRAY['El Principe de la Bachata', 'Francisco Lopez Reyes']::text[],
       occupations = '["composer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@FrankReyes809',
       facebook = 'FrankReyes809',
       instagram = 'FrankReyes809',
       disambiguation = NULL,
       bio_en = 'Frank Reyes is a Dominican bachata singer born in 1969 in Tenares, a municipality in the Hermanas Mirabal province of the Cibao region. Known as El Príncipe de la Bachata — the Prince of Bachata — he is one of the genre''s most treasured and distinctive voices, celebrated for a vocal style that is simultaneously tender and passionate, intimate and commanding.

Reyes came of age as an artist during the period when bachata was shedding its social stigma and beginning its ascent toward mainstream and international acceptance, and his recordings played a meaningful role in that transition. His ability to inhabit a song emotionally — to make the listener feel that every lyric is being drawn from genuine experience — set him apart from more technically accomplished but less soulful contemporaries.

Over a career of several decades he has released a consistent stream of hits, toured extensively, and maintained a devoted following that spans multiple generations. Frank Reyes represents the heart of bachata — the vulnerability, the longing, the capacity for deep feeling — expressed through one of the genre''s most naturally gifted voices.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'frank-reyes';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Frank Reyes is a Dominican bachata singer born in 1969 in Tenares, a municipality in the Hermanas Mirabal province of the Cibao region. Known as El Príncipe de la Bachata — the Prince of Bachata — he is one of the genre''s most treasured and distinctive voices, celebrated for a vocal style that is simultaneously tender and passionate, intimate and commanding.","type":"text"}]},{"type":"paragraph","content":[{"text":"Reyes came of age as an artist during the period when bachata was shedding its social stigma and beginning its ascent toward mainstream and international acceptance, and his recordings played a meaningful role in that transition. His ability to inhabit a song emotionally — to make the listener feel that every lyric is being drawn from genuine experience — set him apart from more technically accomplished but less soulful contemporaries.","type":"text"}]},{"type":"paragraph","content":[{"text":"Over a career of several decades he has released a consistent stream of hits, toured extensively, and maintained a devoted following that spans multiple generations. Frank Reyes represents the heart of bachata — the vulnerability, the longing, the capacity for deep feeling — expressed through one of the genre''s most naturally gifted voices.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'frank-reyes'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
