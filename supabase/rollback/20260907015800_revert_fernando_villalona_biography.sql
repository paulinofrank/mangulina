BEGIN;

-- Reverts 20260907015800_rewrite_fernando_villalona_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Fernando Villalona',
       sort_name = 'Villalona Évora, Ramón Fernando',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1955-05-07',
       birth_year = 1955,
       date_of_death = NULL,
       birth_place = 'Loma de Cabrera',
       province = 'Dajabón',
       first_name = 'Ramón',
       middle_name = 'Fernando',
       last_name = 'Villalona',
       second_last_name = 'Évora',
       stage_name = 'Fernando Villalona',
       aliases = ARRAY['El Mayimbe', 'El Nino Mimado', 'Ramon Fernando Villalona Evora']::text[],
       occupations = '["bandleader","composer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['bolero', 'ballads']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@fernandovillalona',
       facebook = 'Fernandovillalonard',
       instagram = 'elmayimbe',
       disambiguation = NULL,
       bio_en = 'Ramón Fernando Villalona Évora was born on May 7, 1955, in the municipality of Loma de Cabrera, in the northwestern Dominican province of Dajabón, where he grew up alongside his nine siblings and took his first steps in both school and the arts. From a small town on the border with Haiti, he would go on to become one of the most recognized voices in the entire Latin music world.

His nickname, "El Mayimbe," is rooted in the Taíno language of the Dominican Republic''s indigenous peoples — the word signifying a tribal leader or "the boss" — a title that perfectly captured his commanding stage presence and unquestioned authority within the merengue genre from the moment it was first applied to him in the 1970s.

Though he would eventually become synonymous with merengue, Villalona originally made his name in ballad and bolero, before successfully branching into merengue, bachata, and, later in his career, Christian music. His voice carried equal weight across all of them — a natural instrument that could shift effortlessly from tender romanticism to high-energy dance floor heat.

His public breakthrough came early. In 1971, still a teenager, he entered the amateur television talent competition *El Festival de la Voz*, finishing in third place and announcing himself as a voice worth watching. The moment caught the attention of the right people. Merengue icon Wilfrido Vargas subsequently brought him into his band Los Hijos del Rey, but the arrangement proved short-lived — not because it failed, but because Villalona''s individual star grew too bright to remain part of an ensemble. When his personal popularity outgrew the group, he departed to build his own orchestra and chart his own course.

What followed was one of the most durable careers in Dominican music. The 1980s belonged to him in a very particular way — songs like "Tabaco y Ron," "Celos," "Te Amo Demasiado," "La Hamaquita," "Dominicano Soy," "Sonámbulo," and "Carnaval" became staples of the era, anthems that defined parties and soundtracked a generation of Dominican life both on the island and across the diaspora. The 1990s added another chapter, with hits including "Quisqueya," "No Podrás," "Música Latina," "Retorno," and "Me he Enamorado" keeping him firmly at the top of the merengue conversation.

That decade also tested him personally. He stepped back from the spotlight for a period, battling drug dependency and emotional upheaval — yet remarkably, even during that withdrawal, he kept recording, and some of what emerged from that difficult stretch is considered among his finest work. His return to the charts in the early 1990s, anchored in part by a reworking of Joan Manuel Serrat''s "Penélope," confirmed that neither hardship nor absence had diminished his connection to audiences.

The recognition of the broader industry followed naturally. His album *Mal Acostumbrado* earned him a Grammy Award nomination for Best Merengue Album at the 45th Grammy ceremony held at Madison Square Garden in 2003. He also joined an elite circle of Spanish-language artists — including Shakira, Ricky Martin, Romeo Santos, and Enrique Iglesias — in the charity recording *Somos El Mundo 25 Por Haiti*, the Spanish-language version of "We Are the World."

In 2011, at the forty-year mark of his career, Villalona took a deeply personal creative step. He released *Mi Luz*, a Christian album in which he reflected openly on his troubled past, his transformation, and his renewed relationship with God — a project that he described as an act of both faith and gratitude. The Dominican Senate formally recognized his fifty-year musical journey in May 2022, a tribute that only confirmed what fans across Latin America had long understood.

With more than twenty albums to his name — nearly all of them commercially successful — and a career still active more than five decades after it began, Fernando Villalona stands as one of the rare artists whose impact cannot be measured by chart positions alone. He helped carry Dominican music to corners of the world that had never heard a merengue before, and the title El Mayimbe — the boss — remains as fitting today as it was the day it was given to him.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'fernando-villalona';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ramón Fernando Villalona Évora was born on May 7, 1955, in the municipality of Loma de Cabrera, in the northwestern Dominican province of Dajabón, where he grew up alongside his nine siblings and took his first steps in both school and the arts. From a small town on the border with Haiti, he would go on to become one of the most recognized voices in the entire Latin music world.","type":"text"}]},{"type":"paragraph","content":[{"text":"His nickname, \"El Mayimbe,\" is rooted in the Taíno language of the Dominican Republic''s indigenous peoples — the word signifying a tribal leader or \"the boss\" — a title that perfectly captured his commanding stage presence and unquestioned authority within the merengue genre from the moment it was first applied to him in the 1970s.","type":"text"}]},{"type":"paragraph","content":[{"text":"Though he would eventually become synonymous with merengue, Villalona originally made his name in ballad and bolero, before successfully branching into merengue, bachata, and, later in his career, Christian music. His voice carried equal weight across all of them — a natural instrument that could shift effortlessly from tender romanticism to high-energy dance floor heat.","type":"text"}]},{"type":"paragraph","content":[{"text":"His public breakthrough came early. In 1971, still a teenager, he entered the amateur television talent competition *El Festival de la Voz*, finishing in third place and announcing himself as a voice worth watching. The moment caught the attention of the right people. Merengue icon ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"ce1a0a5e-cf5e-4f7e-ab4f-d78cbf68d366"}},{"text":" subsequently brought him into his band Los Hijos del Rey, but the arrangement proved short-lived — not because it failed, but because Villalona''s individual star grew too bright to remain part of an ensemble. When his personal popularity outgrew the group, he departed to build his own orchestra and chart his own course.","type":"text"}]},{"type":"paragraph","content":[{"text":"What followed was one of the most durable careers in Dominican music. The 1980s belonged to him in a very particular way — songs like \"Tabaco y Ron,\" \"Celos,\" \"Te Amo Demasiado,\" \"La Hamaquita,\" \"Dominicano Soy,\" \"Sonámbulo,\" and \"Carnaval\" became staples of the era, anthems that defined parties and soundtracked a generation of Dominican life both on the island and across the diaspora. The 1990s added another chapter, with hits including \"Quisqueya,\" \"No Podrás,\" \"Música Latina,\" \"Retorno,\" and \"Me he Enamorado\" keeping him firmly at the top of the merengue conversation.","type":"text"}]},{"type":"paragraph","content":[{"text":"That decade also tested him personally. He stepped back from the spotlight for a period, battling drug dependency and emotional upheaval — yet remarkably, even during that withdrawal, he kept recording, and some of what emerged from that difficult stretch is considered among his finest work. His return to the charts in the early 1990s, anchored in part by a reworking of Joan Manuel Serrat''s \"Penélope,\" confirmed that neither hardship nor absence had diminished his connection to audiences.","type":"text"}]},{"type":"paragraph","content":[{"text":"The recognition of the broader industry followed naturally. His album *Mal Acostumbrado* earned him a Grammy Award nomination for Best Merengue Album at the 45th Grammy ceremony held at Madison Square Garden in 2003. He also joined an elite circle of Spanish-language artists — including Shakira, Ricky Martin, Romeo Santos, and Enrique Iglesias — in the charity recording *Somos El Mundo 25 Por Haiti*, the Spanish-language version of \"We Are the World.\"","type":"text"}]},{"type":"paragraph","content":[{"text":"In 2011, at the forty-year mark of his career, Villalona took a deeply personal creative step. He released *Mi Luz*, a Christian album in which he reflected openly on his troubled past, his transformation, and his renewed relationship with God — a project that he described as an act of both faith and gratitude. The Dominican Senate formally recognized his fifty-year musical journey in May 2022, a tribute that only confirmed what fans across Latin America had long understood.","type":"text"}]},{"type":"paragraph","content":[{"text":"With more than twenty albums to his name — nearly all of them commercially successful — and a career still active more than five decades after it began, Fernando Villalona stands as one of the rare artists whose impact cannot be measured by chart positions alone. He helped carry Dominican music to corners of the world that had never heard a merengue before, and the title El Mayimbe — the boss — remains as fitting today as it was the day it was given to him.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'fernando-villalona'), 2)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona') AND locale = 'en'), 'ce1a0a5e-cf5e-4f7e-ab4f-d78cbf68d366', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

COMMIT;
