BEGIN;

-- Reverts 20260908000500_rewrite_johnny_pacheco_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Johnny Pacheco',
       sort_name = 'Pacheco, Johnny',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'salsa',
       date_of_birth = '1935-03-25',
       birth_year = 1935,
       date_of_death = '2021-02-15',
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Juan',
       middle_name = 'Azarías',
       last_name = 'Pacheco',
       second_last_name = 'Knipping',
       stage_name = 'Johnny Pacheco',
       aliases = ARRAY['Fania All-stars', 'Juan Azarias Pacheco Knipping', 'El Zorro de Plata']::text[],
       occupations = '["musician","arranger","bandleader","producer","composer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = 'http://www.johnnypacheco.com',
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Johnny Pacheco was one of the most consequential figures in the history of Latin music, a Dominican musician, bandleader, arranger, and entrepreneur whose influence on salsa was so profound that the genre as the world came to know it is almost unimaginable without him. Born in 1935 in Santiago de los Caballeros, Pacheco grew up in a musical family — his father was a bandleader — and showed natural talent across multiple instruments before settling on the flute and percussion as his primary voices. He immigrated to New York City as a young man and quickly made his presence felt in the Latin music scene, studying at Juilliard while performing in the city''s vibrant ballroom and nightclub world.

In 1964, in partnership with attorney Jerry Masucci, Pacheco co-founded Fania Records, a small independent label that would grow into the most important Latin music company of the twentieth century. As Fania''s artistic director and one of its star performers with his group Johnny Pacheco y su Conjunto, he helped define the sound and business model of salsa, signing and developing artists including Celia Cruz, Rubén Blades, Willie Colón, and dozens of others who became legends in their own right.

His own recordings as a bandleader showcased a deep knowledge of Cuban son, guaguancó, and Afro-Caribbean rhythm, filtered through a New York sensibility that was tough, joyful, and endlessly danceable. Pacheco organized the Fania All Stars, the supergroup that brought salsa to global audiences through landmark concerts and recordings in the 1970s. Beyond his business acumen and promotional genius, he was a genuine artist whose flute playing and compositional gifts gave salsa some of its most beloved melodies.

He passed away in February 2021 at the age of eighty-five, mourned by the entire Latin music world as an irreplaceable architect of a genre that had given millions of people a music to call their own.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'johnny-pacheco';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Johnny Pacheco was one of the most consequential figures in the history of Latin music, a Dominican musician, bandleader, arranger, and entrepreneur whose influence on salsa was so profound that the genre as the world came to know it is almost unimaginable without him. Born in 1935 in Santiago de los Caballeros, Pacheco grew up in a musical family — his father was a bandleader — and showed natural talent across multiple instruments before settling on the flute and percussion as his primary voices. He immigrated to New York City as a young man and quickly made his presence felt in the Latin music scene, studying at Juilliard while performing in the city''s vibrant ballroom and nightclub world.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 1964, in partnership with attorney Jerry Masucci, Pacheco co-founded Fania Records, a small independent label that would grow into the most important Latin music company of the twentieth century. As Fania''s artistic director and one of its star performers with his group Johnny Pacheco y su Conjunto, he helped define the sound and business model of salsa, signing and developing artists including Celia Cruz, Rubén Blades, Willie Colón, and dozens of others who became legends in their own right.","type":"text"}]},{"type":"paragraph","content":[{"text":"His own recordings as a bandleader showcased a deep knowledge of Cuban son, guaguancó, and Afro-Caribbean rhythm, filtered through a New York sensibility that was tough, joyful, and endlessly danceable. Pacheco organized the Fania All Stars, the supergroup that brought salsa to global audiences through landmark concerts and recordings in the 1970s. Beyond his business acumen and promotional genius, he was a genuine artist whose flute playing and compositional gifts gave salsa some of its most beloved melodies.","type":"text"}]},{"type":"paragraph","content":[{"text":"He passed away in February 2021 at the age of eighty-five, mourned by the entire Latin music world as an irreplaceable architect of a genre that had given millions of people a music to call their own.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'johnny-pacheco'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
