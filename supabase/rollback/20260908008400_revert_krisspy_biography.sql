BEGIN;

-- Reverts 20260908008400_rewrite_krisspy_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Krisspy',
       sort_name = 'Krisspy',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = NULL,
       birth_year = NULL,
       date_of_death = NULL,
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Juan',
       middle_name = NULL,
       last_name = 'de los Santos',
       second_last_name = NULL,
       stage_name = 'Krisspy',
       aliases = ARRAY[]::text[],
       occupations = '["composer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@Krisspy',
       facebook = 'krisspyflow',
       instagram = 'krisspyflow',
       disambiguation = NULL,
       bio_en = 'Krisspy is a Dominican merengue típico and merengue artist from Santiago de los Caballeros whose music reflects the proud accordion-driven traditions of the Cibao region. Santiago is the heartland of merengue típico, and artists like Krisspy who work within this tradition are custodians of a musical heritage with roots stretching back to the nineteenth century. His connection to Santiago places him within a community of musicians who have kept the accordion, tambora, and güira at the center of Dominican popular music identity despite the commercial pressures that have often favored more electrified and internationally oriented sounds. Krisspy''s work in both típico and modern merengue demonstrates the genre''s capacity to hold together its folk roots and its contemporary popular presence.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'krisspy';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Krisspy is a Dominican merengue típico and merengue artist from Santiago de los Caballeros whose music reflects the proud accordion-driven traditions of the Cibao region. Santiago is the heartland of merengue típico, and artists like Krisspy who work within this tradition are custodians of a musical heritage with roots stretching back to the nineteenth century. His connection to Santiago places him within a community of musicians who have kept the accordion, tambora, and güira at the center of Dominican popular music identity despite the commercial pressures that have often favored more electrified and internationally oriented sounds. Krisspy''s work in both típico and modern merengue demonstrates the genre''s capacity to hold together its folk roots and its contemporary popular presence.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'krisspy'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
