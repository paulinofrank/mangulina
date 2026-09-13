BEGIN;

-- Reverts 20260908003600_rewrite_lapiz_conciente_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Lápiz Conciente',
       sort_name = 'Conciente, Lápiz',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urbano',
       date_of_birth = '1983-01-24',
       birth_year = 1983,
       date_of_death = NULL,
       birth_place = 'Los Mina, Santo Domingo Este',
       province = 'Santo Domingo',
       first_name = 'Avelino',
       middle_name = 'Junior',
       last_name = 'Figueroa',
       second_last_name = 'Rodríguez',
       stage_name = 'Lápiz Conciente',
       aliases = ARRAY['El Papa del Rap']::text[],
       occupations = '["composer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = 'https://lapizmusic.com',
       youtube = '@LAPIZCONCIENTERD',
       facebook = 'lapizconcienteofficial',
       instagram = 'lapizconciente',
       disambiguation = NULL,
       bio_en = 'Lápiz Conciente is one of the most respected lyricists in Dominican hip hop, an artist whose commitment to conscious rap and verbal artistry has made him a standard-bearer for the more thoughtful, socially engaged side of the country''s urban music scene. Born in 1983 in Santo Domingo, he came up in a Dominican hip hop culture that was finding its own voice in dialogue with American rap and Caribbean urban music, and he chose a path that prioritized substance and craft over commercial expediency.

His stage name — which translates roughly as Conscious Pencil — signals his identity as a writer first and a performer second, an artist who approaches each verse as a literary exercise. His lyrics engage with themes of social inequality, Dominican identity, Afro-Caribbean heritage, and the everyday realities of life in the capital, delivered with a technical precision that has earned the admiration of hip hop purists.

Lápiz Conciente has been an important figure in building the infrastructure of Dominican hip hop as a credible artistic form, participating in cyphers, collaborations, and cultural initiatives that have helped elevate the genre''s standing. He is widely cited by younger Dominican rappers as an influence and an example of what the form can achieve when it is practiced with genuine dedication.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'lapiz-conciente';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'lapiz-conciente')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'lapiz-conciente')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Lápiz Conciente is one of the most respected lyricists in Dominican hip hop, an artist whose commitment to conscious rap and verbal artistry has made him a standard-bearer for the more thoughtful, socially engaged side of the country''s urban music scene. Born in 1983 in Santo Domingo, he came up in a Dominican hip hop culture that was finding its own voice in dialogue with American rap and Caribbean urban music, and he chose a path that prioritized substance and craft over commercial expediency.","type":"text"}]},{"type":"paragraph","content":[{"text":"His stage name — which translates roughly as Conscious Pencil — signals his identity as a writer first and a performer second, an artist who approaches each verse as a literary exercise. His lyrics engage with themes of social inequality, Dominican identity, Afro-Caribbean heritage, and the everyday realities of life in the capital, delivered with a technical precision that has earned the admiration of hip hop purists.","type":"text"}]},{"type":"paragraph","content":[{"text":"Lápiz Conciente has been an important figure in building the infrastructure of Dominican hip hop as a credible artistic form, participating in cyphers, collaborations, and cultural initiatives that have helped elevate the genre''s standing. He is widely cited by younger Dominican rappers as an influence and an example of what the form can achieve when it is practiced with genuine dedication.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'lapiz-conciente'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
