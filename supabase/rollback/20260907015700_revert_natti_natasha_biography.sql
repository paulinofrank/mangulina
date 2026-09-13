BEGIN;

-- Reverts 20260907015700_rewrite_natti_natasha_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Natti Natasha',
       sort_name = 'Natasha, Natti',
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urban-reggaeton',
       date_of_birth = '1986-12-10',
       birth_year = 1986,
       date_of_death = NULL,
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Natalia',
       middle_name = 'Alexandra',
       last_name = 'Gutiérrez',
       second_last_name = 'Batista',
       stage_name = 'Natti Natasha',
       aliases = ARRAY['Natti Natasha', 'Natalia Alexandra Gutiérrez Batista']::text[],
       occupations = '["songwriter"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['bachata', 'urbano']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = 'https://nattinatasha.com',
       youtube = 'c/NattiNatasha',
       facebook = 'NattiNatashaOfficial',
       instagram = 'nattinatasha',
       disambiguation = NULL,
       bio_en = 'Natti Natasha is one of the most successful Dominican artists of the twenty-first century, a singer and performer who broke through barriers of gender and genre to become a dominant force in Latin urban music on the global stage. Born Natalia Alexandra Gutiérrez Batista in 1986 in Santiago de los Caballeros, she demonstrated a passion for music from an early age and pursued formal vocal training before relocating to the United States in pursuit of a professional career.

Her initial years in the industry were marked by persistence and gradual development, working within the reggaeton and urban Latin scenes at a time when female artists faced significant structural disadvantages in those male-dominated spaces. Her breakthrough came through collaborations with high-profile artists in the reggaeton world, most notably her work with Bad Bunny, Daddy Yankee, and Drake, among others, which exposed her talent to massive new audiences.

Her solo releases demonstrated a confident command of reggaeton, bachata, and Latin pop, and her ability to navigate multiple genres made her one of the most versatile urban Latin artists of her generation. Songs like Criminal with Ozuna became massive international hits, cementing her status as a superstar. She has received numerous Latin Grammy nominations and has won multiple Billboard Latin Music Awards, becoming the most-followed Dominican woman on social media globally at various points in her career.

Beyond her music, she has become a fashion and lifestyle brand unto herself, and her influence on the trajectory of women in Latin urban music has been substantial and widely recognized.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'natti-natasha';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'natti-natasha')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'natti-natasha')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Natti Natasha is one of the most successful Dominican artists of the twenty-first century, a singer and performer who broke through barriers of gender and genre to become a dominant force in Latin urban music on the global stage. Born Natalia Alexandra Gutiérrez Batista in 1986 in Santiago de los Caballeros, she demonstrated a passion for music from an early age and pursued formal vocal training before relocating to the United States in pursuit of a professional career.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her initial years in the industry were marked by persistence and gradual development, working within the reggaeton and urban Latin scenes at a time when female artists faced significant structural disadvantages in those male-dominated spaces. Her breakthrough came through collaborations with high-profile artists in the reggaeton world, most notably her work with Bad Bunny, Daddy Yankee, and Drake, among others, which exposed her talent to massive new audiences.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her solo releases demonstrated a confident command of reggaeton, bachata, and Latin pop, and her ability to navigate multiple genres made her one of the most versatile urban Latin artists of her generation. Songs like Criminal with Ozuna became massive international hits, cementing her status as a superstar. She has received numerous Latin Grammy nominations and has won multiple Billboard Latin Music Awards, becoming the most-followed Dominican woman on social media globally at various points in her career.","type":"text"}]},{"type":"paragraph","content":[{"text":"Beyond her music, she has become a fashion and lifestyle brand unto herself, and her influence on the trajectory of women in Latin urban music has been substantial and widely recognized.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'natti-natasha'), 2)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
