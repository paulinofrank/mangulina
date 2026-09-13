BEGIN;

-- Reverts 20260908002800_rewrite_blas_duran_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Blas Durán',
       sort_name = 'Durán, Blas',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1941-02-03',
       birth_year = 1941,
       date_of_death = '2023-03-28',
       birth_place = 'Nagua',
       province = 'María Trinidad Sánchez',
       first_name = 'Blas',
       middle_name = NULL,
       last_name = 'Durán',
       second_last_name = NULL,
       stage_name = 'Blas Durán',
       aliases = ARRAY['Blas Durán y Sus Peluches']::text[],
       occupations = '["guitarist","songwriter"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Blas Durán was one of the defining figures of Dominican bachata, a musician born in 1941 in Nagua on the country''s northeastern Atlantic coast who spent his career celebrating and reshaping a genre that for much of its history was dismissed by the Dominican cultural establishment as music of the poor and marginalized. Durán was a pioneer of the merengue de guataca style as well as a major force in bachata, and his recordings from the 1980s onward helped bring bachata to wider national attention at a time when it was beginning its long ascent from the margins to the mainstream.

He was known for his charismatic stage presence, his husky voice, and an ability to convey the earthy humor and emotional directness that characterized bachata at its most authentic. His song Consejo a las Mujeres became one of the genre''s landmark recordings, a piece that demonstrated bachata''s capacity for wit and social commentary as well as heartbreak. Durán lived long enough to see bachata transform from a stigmatized regional music into one of the Dominican Republic''s most celebrated cultural exports.

He passed away in 2023, leaving behind a body of work that documents the evolution of Dominican popular music across half a century.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'blas-duran';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'blas-duran')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'blas-duran')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Blas Durán was one of the defining figures of Dominican bachata, a musician born in 1941 in Nagua on the country''s northeastern Atlantic coast who spent his career celebrating and reshaping a genre that for much of its history was dismissed by the Dominican cultural establishment as music of the poor and marginalized. Durán was a pioneer of the merengue de guataca style as well as a major force in bachata, and his recordings from the 1980s onward helped bring bachata to wider national attention at a time when it was beginning its long ascent from the margins to the mainstream.","type":"text"}]},{"type":"paragraph","content":[{"text":"He was known for his charismatic stage presence, his husky voice, and an ability to convey the earthy humor and emotional directness that characterized bachata at its most authentic. His song Consejo a las Mujeres became one of the genre''s landmark recordings, a piece that demonstrated bachata''s capacity for wit and social commentary as well as heartbreak. Durán lived long enough to see bachata transform from a stigmatized regional music into one of the Dominican Republic''s most celebrated cultural exports.","type":"text"}]},{"type":"paragraph","content":[{"text":"He passed away in 2023, leaving behind a body of work that documents the evolution of Dominican popular music across half a century.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'blas-duran'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
