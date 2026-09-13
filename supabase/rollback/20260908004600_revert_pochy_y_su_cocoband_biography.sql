BEGIN;

-- Reverts 20260908004600_rewrite_pochy_y_su_cocoband_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Pochy y su Cocoband',
       sort_name = NULL,
       type = 'group',
       status = 'published',
       gender = NULL,
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue-orquesta',
       date_of_birth = '1966-09-17',
       birth_year = 1966,
       date_of_death = NULL,
       birth_place = 'Higüey',
       province = 'Distrito Nacional',
       first_name = 'Manuel',
       middle_name = 'Alfonso',
       last_name = 'Vázquez',
       second_last_name = 'Familia',
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@pochyfamiliaysucocoband3832',
       facebook = 'pochy.familia',
       instagram = 'pochyfamilia',
       disambiguation = NULL,
       bio_en = 'Pochy y su Cocoband is a Dominican music group. The group is documented for its contribution to Dominican music and its related scenes.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'pochy-y-su-cocoband';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Pochy y su Cocoband is a Dominican music group. The group is documented for its contribution to Dominican music and its related scenes.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
