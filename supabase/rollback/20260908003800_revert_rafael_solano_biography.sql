BEGIN;

-- Reverts 20260908003800_rewrite_rafael_solano_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Rafael Solano',
       sort_name = 'Solano, Rafael',
       type = 'solo_artist',
       status = 'published',
       gender = NULL,
       ended = NULL,
       primary_role = 'composer',
       primary_genre = 'ballads',
       date_of_birth = '1931-04-10',
       birth_year = 1931,
       date_of_death = NULL,
       birth_place = 'San Felipe de Puerto Plata',
       province = 'Puerto Plata',
       first_name = 'Rafael',
       middle_name = NULL,
       last_name = 'Solano',
       second_last_name = 'Sánchez',
       stage_name = NULL,
       aliases = NULL,
       occupations = '["pianist","songwriter","musician"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['bolero', 'merengue', 'folklore']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Rafael Solano was one of the Dominican Republic''s most distinguished musical figures, a composer, arranger, and performer whose contributions spanned bolero, balada, merengue, and folk music. Born in 1931 in San Felipe de Puerto Plata, he demonstrated exceptional musical aptitude from an early age and went on to study and develop his craft with serious dedication. As a composer he was responsible for some of the most enduring songs in the Dominican and Latin American repertoire, with works that were recorded by internationally acclaimed artists.

His sophisticated understanding of melody and harmony set him apart, and his arrangements brought elegance and depth to whatever genre he touched. Solano also worked as a music educator, sharing his knowledge with younger generations of Dominican musicians. His legacy is that of a complete musician — one who both shaped the popular musical taste of his era and left behind a body of compositional work that continues to be performed and celebrated long after his most active years.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'rafael-solano';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Rafael Solano was one of the Dominican Republic''s most distinguished musical figures, a composer, arranger, and performer whose contributions spanned bolero, balada, merengue, and folk music. Born in 1931 in San Felipe de Puerto Plata, he demonstrated exceptional musical aptitude from an early age and went on to study and develop his craft with serious dedication. As a composer he was responsible for some of the most enduring songs in the Dominican and Latin American repertoire, with works that were recorded by internationally acclaimed artists.","type":"text"}]},{"type":"paragraph","content":[{"text":"His sophisticated understanding of melody and harmony set him apart, and his arrangements brought elegance and depth to whatever genre he touched. Solano also worked as a music educator, sharing his knowledge with younger generations of Dominican musicians. His legacy is that of a complete musician — one who both shaped the popular musical taste of his era and left behind a body of compositional work that continues to be performed and celebrated long after his most active years.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'rafael-solano'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
