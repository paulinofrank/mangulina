BEGIN;

-- Reverts 20260908002400_rewrite_tatico_henriquez_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Tatico Henríquez',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1943-07-30',
       birth_year = 1943,
       date_of_death = '1976-05-23',
       birth_place = 'Nagua',
       province = 'María Trinidad Sánchez',
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '["musician"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Tatico Henríquez was one of the most gifted and original accordionists in the history of Dominican merengue típico, a musician whose innovations in technique and style helped push the traditional form into new expressive territory while keeping it rooted in its folk origins. Born in 1943 in Nagua, the capital of the María Trinidad Sánchez province on the northern Atlantic coast, he grew up immersed in the musical traditions of the region and developed his accordion playing to a level of virtuosity that astonished contemporaries and successors alike.

Tatico, as he was universally known, brought a rhythmic inventiveness and an improvisational vitality to the típico tradition that set him apart from other accordion players of his era, and his recordings from the 1960s and early 1970s remain touchstones of the genre. He was also a distinctive vocalist whose earthy, direct delivery suited the festive and sometimes bawdy material he favored. He died in May 1976, at thirty-two, leaving a body of work that was too brief but remains profoundly influential.

Tatico Henríquez is remembered as a genius of Dominican traditional music whose early death deprived the country of a talent that might have transformed the típico tradition even further.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'tatico-henriquez';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Tatico Henríquez was one of the most gifted and original accordionists in the history of Dominican merengue típico, a musician whose innovations in technique and style helped push the traditional form into new expressive territory while keeping it rooted in its folk origins. Born in 1943 in Nagua, the capital of the María Trinidad Sánchez province on the northern Atlantic coast, he grew up immersed in the musical traditions of the region and developed his accordion playing to a level of virtuosity that astonished contemporaries and successors alike.","type":"text"}]},{"type":"paragraph","content":[{"text":"Tatico, as he was universally known, brought a rhythmic inventiveness and an improvisational vitality to the típico tradition that set him apart from other accordion players of his era, and his recordings from the 1960s and early 1970s remain touchstones of the genre. He was also a distinctive vocalist whose earthy, direct delivery suited the festive and sometimes bawdy material he favored. He died in May 1976, at thirty-two, leaving a body of work that was too brief but remains profoundly influential.","type":"text"}]},{"type":"paragraph","content":[{"text":"Tatico Henríquez is remembered as a genius of Dominican traditional music whose early death deprived the country of a talent that might have transformed the típico tradition even further.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'tatico-henriquez'), 2)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
