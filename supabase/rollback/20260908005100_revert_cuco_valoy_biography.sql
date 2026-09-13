BEGIN;

-- Reverts 20260908005100_rewrite_cuco_valoy_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Cuco Valoy',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1937-01-06',
       birth_year = 1937,
       date_of_death = NULL,
       birth_place = 'Manoguayabo',
       province = 'Santo Domingo',
       first_name = 'Pupo',
       middle_name = NULL,
       last_name = 'Valoy',
       second_last_name = 'Reynoso',
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '["composer","musician"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['folklore-son-dominicano']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@CucoValoyoficial',
       facebook = 'CucoValoyLaTribu',
       instagram = 'cucovaloyoficial',
       disambiguation = NULL,
       bio_en = 'Cuco Valoy stands as one of the most distinctive and innovative voices in Dominican music, an artist who spent decades weaving together the threads of son cubano, salsa, merengue, and Afro-Caribbean folk traditions into a sound entirely his own. Born in 1937 in Manoguayabo, a community on the outskirts of Santo Domingo, he grew up hearing the full spectrum of popular Caribbean music and absorbed its rhythms deeply before embarking on a professional career that would span well over half a century.

In the 1960s, he and his brother Martín formed Los Virtuosos, an ensemble that became one of the most celebrated acts on the Dominican popular music circuit. The group''s blend of spirited arrangements, tight vocal harmonies, and rhythmic sophistication won them a loyal following throughout the country and earned them recognition across the broader Caribbean and Latin American music world. Valoy himself was a natural bandleader — charismatic, technically accomplished, and possessed of a creative restlessness that kept his music fresh across changing eras.

His recordings in the son cubano and salsa idioms demonstrated a deep understanding of Afro-Cuban musical structures, while his Dominican sensibility always gave his work a distinct local flavor. He collaborated with musicians from Cuba, Puerto Rico, Colombia, and beyond, and his influence on Dominican popular music has been widely acknowledged by artists of subsequent generations. Now well into his eighties, Cuco Valoy remains a celebrated patriarch of Dominican music, a living connection to an era of profound Caribbean musical ferment.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'cuco-valoy';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Cuco Valoy stands as one of the most distinctive and innovative voices in Dominican music, an artist who spent decades weaving together the threads of son cubano, salsa, merengue, and Afro-Caribbean folk traditions into a sound entirely his own. Born in 1937 in Manoguayabo, a community on the outskirts of Santo Domingo, he grew up hearing the full spectrum of popular Caribbean music and absorbed its rhythms deeply before embarking on a professional career that would span well over half a century.","type":"text"}]},{"type":"paragraph","content":[{"text":"In the 1960s, he and his brother Martín formed Los Virtuosos, an ensemble that became one of the most celebrated acts on the Dominican popular music circuit. The group''s blend of spirited arrangements, tight vocal harmonies, and rhythmic sophistication won them a loyal following throughout the country and earned them recognition across the broader Caribbean and Latin American music world. Valoy himself was a natural bandleader — charismatic, technically accomplished, and possessed of a creative restlessness that kept his music fresh across changing eras.","type":"text"}]},{"type":"paragraph","content":[{"text":"His recordings in the son cubano and salsa idioms demonstrated a deep understanding of Afro-Cuban musical structures, while his Dominican sensibility always gave his work a distinct local flavor. He collaborated with musicians from Cuba, Puerto Rico, Colombia, and beyond, and his influence on Dominican popular music has been widely acknowledged by artists of subsequent generations. Now well into his eighties, Cuco Valoy remains a celebrated patriarch of Dominican music, a living connection to an era of profound Caribbean musical ferment.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'cuco-valoy'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
