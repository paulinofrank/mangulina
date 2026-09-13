BEGIN;

-- Reverts 20260908000400_rewrite_carlos_manuel_vargas_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Carlos Manuel Vargas',
       sort_name = 'Vargas, Carlos Manuel',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'instrumentalist',
       primary_genre = 'instrumental-classical',
       date_of_birth = NULL,
       birth_year = NULL,
       date_of_death = NULL,
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Carlos',
       middle_name = 'Manuel',
       last_name = 'Vargas',
       second_last_name = NULL,
       stage_name = 'Carlos Manuel Vargas',
       aliases = ARRAY[]::text[],
       occupations = '["pianist"]'::jsonb,
       instruments = ARRAY['piano']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'instrumental']::text[],
       website = 'https://www.carlosmanuelvargas.com',
       youtube = '@carlosvpiano',
       facebook = 'carlosvpiano',
       instagram = 'carlosvpiano',
       disambiguation = 'Dominican classical pianist and educator',
       bio_en = 'Carlos Manuel Vargas is a Dominican classical pianist, educator, and cultural organizer from Santiago de los Caballeros. A native of the Dominican Republic, he began piano studies at a young age with the Cuban pianist and pedagogue Karelia Escalante, later receiving the Zitrin Scholarship in 2005 to study at the Boston Conservatory, where he completed both a Bachelor of Music and a Master of Music in piano performance under Jonathan Bass.

Vargas is an assistant professor of music in the Instrumental Studies and Piano departments at Boston Conservatory at Berklee, where his appointment as a full-time faculty member has been recognized in the Dominican press as an important milestone for Dominican classical musicians. His performances have reached audiences in the United States, South America, and Europe, including a German solo recital debut and a 2023 appearance with the National Symphony of Ecuador in Rachmaninoff''s Piano Concerto No. 2.

His artistic work connects the European piano tradition with Dominican and Latin American repertory. His debut album, Souvenirs, released by Navona Records in 2024, presents works by composers including Francis Poulenc, Alexander Scriabin, George Gershwin, and Dominican composer Rafael Bullumba Landestoy. In 2026, he was preparing Voyage, a follow-up album focused on music by Spanish-speaking composers such as Enrique Granados, Federico Mompou, Aldo López-Gavilán, and Andrea Casarrubios.

Beyond performance, Vargas has built a career around education and community access. In 2008 he founded the Roxbury Piano Program, a free music-lesson initiative for children in Roxbury and neighboring Boston communities; in 2019 he received the Berklee Urban Service Award for that work. He is also artistic director of the Roxbury Concert Series and cofounder, with Colombian violinist José Romero, of Macondo Chamber Players, a chamber music organization that has toured in the Dominican Republic, Colombia, Ecuador, Mexico, and Turkey.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'carlos-manuel-vargas';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'carlos-manuel-vargas')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'carlos-manuel-vargas')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Carlos Manuel Vargas is a Dominican classical pianist, educator, and cultural organizer from Santiago de los Caballeros. A native of the Dominican Republic, he began piano studies at a young age with the Cuban pianist and pedagogue Karelia Escalante, later receiving the Zitrin Scholarship in 2005 to study at the Boston Conservatory, where he completed both a Bachelor of Music and a Master of Music in piano performance under Jonathan Bass.","type":"text"}]},{"type":"paragraph","content":[{"text":"Vargas is an assistant professor of music in the Instrumental Studies and Piano departments at Boston Conservatory at Berklee, where his appointment as a full-time faculty member has been recognized in the Dominican press as an important milestone for Dominican classical musicians. His performances have reached audiences in the United States, South America, and Europe, including a German solo recital debut and a 2023 appearance with the National Symphony of Ecuador in Rachmaninoff''s Piano Concerto No. 2.","type":"text"}]},{"type":"paragraph","content":[{"text":"His artistic work connects the European piano tradition with Dominican and Latin American repertory. His debut album, Souvenirs, released by Navona Records in 2024, presents works by composers including Francis Poulenc, Alexander Scriabin, George Gershwin, and Dominican composer Rafael Bullumba Landestoy. In 2026, he was preparing Voyage, a follow-up album focused on music by Spanish-speaking composers such as Enrique Granados, Federico Mompou, Aldo López-Gavilán, and Andrea Casarrubios.","type":"text"}]},{"type":"paragraph","content":[{"text":"Beyond performance, Vargas has built a career around education and community access. In 2008 he founded the Roxbury Piano Program, a free music-lesson initiative for children in Roxbury and neighboring Boston communities; in 2019 he received the Berklee Urban Service Award for that work. He is also artistic director of the Roxbury Concert Series and cofounder, with Colombian violinist José Romero, of Macondo Chamber Players, a chamber music organization that has toured in the Dominican Republic, Colombia, Ecuador, Mexico, and Turkey.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'carlos-manuel-vargas'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
