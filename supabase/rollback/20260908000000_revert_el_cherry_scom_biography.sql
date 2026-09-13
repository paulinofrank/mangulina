BEGIN;

-- Reverts 20260908000000_rewrite_el_cherry_scom_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'El Cherry Scom',
       sort_name = 'Reyes, Ramón Antonio',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urbano',
       date_of_birth = '1991-09-27',
       birth_year = 1991,
       date_of_death = NULL,
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = 'Ramón',
       middle_name = 'Antonio',
       last_name = 'Reyes',
       second_last_name = 'Alcantara',
       stage_name = 'El Cherry Scom',
       aliases = ARRAY['El Cherry', 'Ramon Antonio Reyes', 'Ramon Antonio Reyes Alcantara', 'Cherry Scom']::text[],
       occupations = '["composer","songwriter"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['urban-reggaeton']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@ElCherryScomRD',
       facebook = 'ElCherryScom',
       instagram = 'elcherryscom28',
       disambiguation = 'Dominican dembow rapper and singer, born September 27, 1991',
       bio_en = 'El Cherry Scom is one of the most distinctive voices in Dominican dembow, a singer, rapper, and songwriter born Ramón Antonio Reyes on September 27, 1991, in Santo Domingo, Dominican Republic. Known for his colorful visual identity, unusually high-pitched vocal delivery, and an instinct for constructing earworm melodies, he emerged from the Dominican urban underground to become one of the genre''s most internationally recognized representatives.

He developed his passion for music in the streets of Santo Domingo and began making his mark in the local dembow circuit before catching wider attention. The pivotal moment in his career came in late 2019 when he and fellow dembow artist Kiko El Crazy released "Baje con Trenza," a racing, percussion-heavy track executive produced by Santiago Matias — the influential Alofoke radio personality who has long championed Dominican dembow. When Puerto Rican superstar Ozuna heard the track and jumped on a remix with a fiercely rapped verse, the song exploded: the music video shot to the top of YouTube''s trending chart in the Dominican Republic. Rolling Stone featured "Baje con Trenza (Remix)" in its Song You Need to Know series, introducing El Cherry Scom to an international critical audience for the first time.

He continued building his catalog with singles including "Tukuntazo" — a substantial streaming success — and "De Manhattan Pa El Bronx" and "Corre Corre," tracks that demonstrated his range within the genre''s fast-tempo framework. His collaboration on "La Mamá de la Mamá" with El Alfa and CJ became one of the defining dembow moments of 2021, and the track spawned a star-studded remix featuring Busta Rhymes, Anitta, Wisin, and CJ alongside El Cherry Scom — a signal of how far Dominican dembow had traveled from its local roots into the global Latin music mainstream.

In 2023 he appeared on "La Gringa" alongside an extraordinary roster that included El Alfa, Yandel, Lil Jon, Duki, and Polimá Westcoast — a collaboration that positioned Dominican dembow in direct conversation with hip-hop, reggaeton, and Latin trap from across the Americas. He has also collaborated with rising artist Aleesha and Haraca Kiko on "Melacomo," further cementing his place at the crossroads of Dominican urban music''s present and future.

Artistically, El Cherry Scom is recognized for a vocal style unlike most of his contemporaries — the high register, rapid-fire flow changes, and playful tonal variations give his performances a kinetic energy that is immediately recognizable. His visual presentation, consistently bold and colorful, reinforces an artistic identity built around standing out. His influences include Daddy Yankee and Ozuna, two figures who demonstrated that Caribbean urban music could reach global audiences without sacrificing its rhythmic soul. El Cherry Scom has continued that trajectory, making Dominican dembow impossible to ignore on the world stage.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'el-cherry-scom';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-cherry-scom')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-cherry-scom')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"El Cherry Scom is one of the most distinctive voices in Dominican dembow, a singer, rapper, and songwriter born Ramón Antonio Reyes on September 27, 1991, in Santo Domingo, Dominican Republic. Known for his colorful visual identity, unusually high-pitched vocal delivery, and an instinct for constructing earworm melodies, he emerged from the Dominican urban underground to become one of the genre''s most internationally recognized representatives.","type":"text"}]},{"type":"paragraph","content":[{"text":"He developed his passion for music in the streets of Santo Domingo and began making his mark in the local dembow circuit before catching wider attention. The pivotal moment in his career came in late 2019 when he and fellow dembow artist Kiko El Crazy released \"Baje con Trenza,\" a racing, percussion-heavy track executive produced by Santiago Matias — the influential Alofoke radio personality who has long championed Dominican dembow. When Puerto Rican superstar Ozuna heard the track and jumped on a remix with a fiercely rapped verse, the song exploded: the music video shot to the top of YouTube''s trending chart in the Dominican Republic. Rolling Stone featured \"Baje con Trenza (Remix)\" in its Song You Need to Know series, introducing El Cherry Scom to an international critical audience for the first time.","type":"text"}]},{"type":"paragraph","content":[{"text":"He continued building his catalog with singles including \"Tukuntazo\" — a substantial streaming success — and \"De Manhattan Pa El Bronx\" and \"Corre Corre,\" tracks that demonstrated his range within the genre''s fast-tempo framework. His collaboration on \"La Mamá de la Mamá\" with El Alfa and CJ became one of the defining dembow moments of 2021, and the track spawned a star-studded remix featuring Busta Rhymes, Anitta, Wisin, and CJ alongside El Cherry Scom — a signal of how far Dominican dembow had traveled from its local roots into the global Latin music mainstream.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 2023 he appeared on \"La Gringa\" alongside an extraordinary roster that included El Alfa, Yandel, Lil Jon, Duki, and Polimá Westcoast — a collaboration that positioned Dominican dembow in direct conversation with hip-hop, reggaeton, and Latin trap from across the Americas. He has also collaborated with rising artist Aleesha and Haraca Kiko on \"Melacomo,\" further cementing his place at the crossroads of Dominican urban music''s present and future.","type":"text"}]},{"type":"paragraph","content":[{"text":"Artistically, El Cherry Scom is recognized for a vocal style unlike most of his contemporaries — the high register, rapid-fire flow changes, and playful tonal variations give his performances a kinetic energy that is immediately recognizable. His visual presentation, consistently bold and colorful, reinforces an artistic identity built around standing out. His influences include Daddy Yankee and Ozuna, two figures who demonstrated that Caribbean urban music could reach global audiences without sacrificing its rhythmic soul. El Cherry Scom has continued that trajectory, making Dominican dembow impossible to ignore on the world stage.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'el-cherry-scom'), 2)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
