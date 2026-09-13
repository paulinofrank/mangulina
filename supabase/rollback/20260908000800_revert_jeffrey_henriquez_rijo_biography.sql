BEGIN;

-- Reverts 20260908000800_rewrite_jeffrey_henriquez_rijo_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Jeff',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urbano',
       date_of_birth = '1999-10-28',
       birth_year = 1999,
       date_of_death = NULL,
       birth_place = 'Higüey',
       province = 'La Altagracia',
       first_name = 'Jeffrey',
       middle_name = NULL,
       last_name = 'Henríquez',
       second_last_name = 'Rijo',
       stage_name = 'Jeffrey Henríquez Rijo',
       aliases = ARRAY[]::text[],
       occupations = '["musician","composer"]'::jsonb,
       instruments = ARRAY['guitar']::text[],
       genres = ARRAY['instrumental-classical', 'bachata', 'urban-reggaeton']::text[],
       artist_tags = ARRAY['secular', 'emerging', 'instrumental']::text[],
       website = NULL,
       youtube = '@jeffhrmusic',
       facebook = 'Jeffhrmusi',
       instagram = 'jeffhrmusic',
       disambiguation = NULL,
       bio_en = 'Jeffrey Henríquez Rijo, professionally known as Jeff, is an independent Dominican singer, songwriter, and voice actor. Born on October 28, 1999, in Higüey, La Altagracia, he has established himself in the Latin urban music scene. He creates music across genres like reggaeton, sad song styles, and Latin pop.

Jeffrey is the son of Luis Alberto Henríquez and Eusebia Rijo López. Growing up in Higüey, the capital of the La Altagracia province, he developed a dual passion for vocal production and modern commercial songwriting.Music CareerAs a recording artist, Henríquez Rijo manages his brand and discography through his own independent imprint, JEFFHRMUSIC. 

His work is deeply embedded in the contemporary Latin urban landscape, prioritizing emotional melodies and rhythmic beats over the traditional classical structures mistakenly attributed to him previously. His musical footprint includes:Discography: He has released 11 commercial tracks, featuring popular singles like "Ya No Te Quiero", "Mientes", "Mi Adicción", and "Le Fallé al Amor".

In March 2026, data from Muso.AI placed Henríquez Rijo in the Top 25% of global songwriters based on his active collaborations and growing digital footprint.Collaborations: He works closely with regular urban music collaborators, including the producer/engineer Disny, songwriter Octavio Seccexon, and fellow artist Lara51.

His track "No Valió la Pena" was released commercially under his JEFFHRMUSI imprint in partnership with DISNYMUSIC.

Outside of streaming music platforms, Henríquez Rijo leverages his vocal skills as a professional voice actor based in Higüey. He shares a steady stream of musical updates, behind-the-scenes content, and snippet previews directly with his audience via his official Facebook Page. His verified musical profile and lyrics registry are maintained on Musixmatch and streaming channels like SoundCloud.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'jeffrey-henriquez-rijo';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jeffrey-henriquez-rijo')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jeffrey-henriquez-rijo')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jeffrey Henríquez Rijo, professionally known as Jeff, is an independent Dominican singer, songwriter, and voice actor. Born on October 28, 1999, in Higüey, La Altagracia, he has established himself in the Latin urban music scene. He creates music across genres like reggaeton, sad song styles, and Latin pop.","type":"text"}]},{"type":"paragraph","content":[{"text":"Jeffrey is the son of Luis Alberto Henríquez and Eusebia Rijo López. Growing up in Higüey, the capital of the La Altagracia province, he developed a dual passion for vocal production and modern commercial songwriting.Music CareerAs a recording artist, Henríquez Rijo manages his brand and discography through his own independent imprint, JEFFHRMUSIC. ","type":"text"}]},{"type":"paragraph","content":[{"text":"His work is deeply embedded in the contemporary Latin urban landscape, prioritizing emotional melodies and rhythmic beats over the traditional classical structures mistakenly attributed to him previously. His musical footprint includes:Discography: He has released 11 commercial tracks, featuring popular singles like \"Ya No Te Quiero\", \"Mientes\", \"Mi Adicción\", and \"Le Fallé al Amor\".","type":"text"}]},{"type":"paragraph","content":[{"text":"In March 2026, data from Muso.AI placed Henríquez Rijo in the Top 25% of global songwriters based on his active collaborations and growing digital footprint.Collaborations: He works closely with regular urban music collaborators, including the producer/engineer Disny, songwriter Octavio Seccexon, and fellow artist Lara51.","type":"text"}]},{"type":"paragraph","content":[{"text":"His track \"No Valió la Pena\" was released commercially under his JEFFHRMUSI imprint in partnership with DISNYMUSIC.","type":"text"}]},{"type":"paragraph","content":[{"text":"Outside of streaming music platforms, Henríquez Rijo leverages his vocal skills as a professional voice actor based in Higüey. He shares a steady stream of musical updates, behind-the-scenes content, and snippet previews directly with his audience via his official Facebook Page. His verified musical profile and lyrics registry are maintained on Musixmatch and streaming channels like SoundCloud.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jeffrey-henriquez-rijo'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
