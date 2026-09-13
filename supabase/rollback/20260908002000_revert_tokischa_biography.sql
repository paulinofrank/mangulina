BEGIN;

-- Reverts 20260908002000_rewrite_tokischa_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Tokischa',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urban-reggaeton',
       date_of_birth = '1996-03-17',
       birth_year = 1996,
       date_of_death = NULL,
       birth_place = 'Los Frailes, Santo Domingo Este',
       province = 'Santo Domingo',
       first_name = 'Tokischa',
       middle_name = NULL,
       last_name = 'Altagracia',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY['Altagracia Peralta', 'Tokischa Altagracia Peralta']::text[],
       occupations = '["songwriter"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['urban-dembow']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@Tokischa',
       facebook = 'tokischamusic',
       instagram = 'tokischa.sol',
       disambiguation = NULL,
       bio_en = 'Tokischa Altagracia Peralta, known professionally as Tokischa, was born in 1996 in Los Frailes, a working-class neighbourhood of Santo Domingo Este. She grew up in circumstances marked by hardship, and the rawness of that experience became the fuel for some of the most provocative and talked-about music to emerge from the Dominican Republic in recent years.

Tokischa burst onto the scene with a fearless approach to dembow and reggaeton, rapping and singing about desire, identity, and street life with a directness that shocked some and thrilled many others. Her collaboration with J Balvin on Perra in 2021 brought her to global attention, igniting both enthusiasm and controversy — the video was temporarily removed from YouTube amid debates about its imagery, but the episode only amplified her profile internationally.

What makes Tokischa a genuinely significant artist goes beyond provocation: she represents a new generation of Dominican women who refuse to be constrained by expectations, blending diva house, dancehall, and Dominican dembow into a sound that is entirely her own. Her lyrics engage unapologetically with queer identity, sexuality, and the reality of life on the margins, making her a countercultural icon in a deeply conservative society.

She has collaborated with artists including Rosalía, Madonna, and Cardi B, steadily expanding her international footprint while remaining rooted in the streets and sounds of Santo Domingo.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'tokischa';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Tokischa Altagracia Peralta, known professionally as Tokischa, was born in 1996 in Los Frailes, a working-class neighbourhood of Santo Domingo Este. She grew up in circumstances marked by hardship, and the rawness of that experience became the fuel for some of the most provocative and talked-about music to emerge from the Dominican Republic in recent years.","type":"text"}]},{"type":"paragraph","content":[{"text":"Tokischa burst onto the scene with a fearless approach to dembow and reggaeton, rapping and singing about desire, identity, and street life with a directness that shocked some and thrilled many others. Her collaboration with J Balvin on Perra in 2021 brought her to global attention, igniting both enthusiasm and controversy — the video was temporarily removed from YouTube amid debates about its imagery, but the episode only amplified her profile internationally.","type":"text"}]},{"type":"paragraph","content":[{"text":"What makes Tokischa a genuinely significant artist goes beyond provocation: she represents a new generation of Dominican women who refuse to be constrained by expectations, blending diva house, dancehall, and Dominican dembow into a sound that is entirely her own. Her lyrics engage unapologetically with queer identity, sexuality, and the reality of life on the margins, making her a countercultural icon in a deeply conservative society.","type":"text"}]},{"type":"paragraph","content":[{"text":"She has collaborated with artists including Rosalía, Madonna, and Cardi B, steadily expanding her international footprint while remaining rooted in the streets and sounds of Santo Domingo.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'tokischa'), 2)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
