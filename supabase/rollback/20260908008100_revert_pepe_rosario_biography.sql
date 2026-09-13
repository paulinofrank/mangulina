BEGIN;

-- Reverts 20260908008100_rewrite_pepe_rosario_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Pepe Rosario',
       sort_name = 'Rosario Almonte, Pedro Julio',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = NULL,
       birth_year = NULL,
       date_of_death = '1983-03-19',
       birth_place = 'Salvaleón de Higüey',
       province = 'La Altagracia',
       first_name = 'Pedro',
       middle_name = 'Julio',
       last_name = 'Rosario',
       second_last_name = 'Almonte',
       stage_name = 'Pepe Rosario',
       aliases = NULL,
       occupations = '["pianist","musical_director"]'::jsonb,
       instruments = ARRAY['piano', 'voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Founder, pianist and musical director of Los Hermanos Rosario; sang their first radio hits',
       bio_en = 'Pepe Rosario was a Dominican singer. That is the detail worth holding onto: the sound was his.',
       bio_es = 'Pedro Julio Rosario Almonte, conocido como Pepe Rosario, fue un cantante, pianista y director de orquesta dominicano de merengue. Fundó Los Hermanos Rosario junto a sus hermanos y la dirigió hasta su muerte a los veintiún años, y las canciones que pusieron al grupo por primera vez en la radio dominicana las cantaba él.

**Salvaleón de Higüey**

Nació en Higüey, provincia La Altagracia, en el extremo este del país, en una familia de siete hermanos que iban a terminar todos en la misma orquesta. Tenía unos dieciséis años cuando la formaron.

El debut fue el 1 de mayo de 1978, en su propio pueblo, tocando para las autoridades municipales en un acto del Día del Trabajo. De ahí el grupo se fue abriendo camino por los pueblos del este hasta que el maestro Chiquitín Payán los contrató para amenizar el Hotel Romana, en Casa de Campo, que fue la contratación que los sacó del circuito local.

**Las Locas**

Era el pianista, el director musical y el líder, y cantaba. El grupo grabó María Guayando como primer sencillo y se mudó a la capital en 1980 para hacer un primer disco. De ahí salió Las Locas, que encabezó las listas dominicanas.

Cuando murió, las emisoras estaban poniendo Las Locas y Te Seguiré Queriendo, las dos en su voz. El sonido que el país reconoció primero como Los Hermanos Rosario era el suyo.

**Lo que vino después**

Murió el 19 de marzo de 1983 en La Romana, a los veintiún años. El grupo dejó de tocar por un tiempo y los hermanos llegaron a plantearse dejarlo todo y volverse al pueblo.

No lo hicieron. Toño Rosario y Rafa Rosario llevaron la orquesta adelante, y en una década era la banda de merengue más exitosa que había dado el país. Todo lo que hizo después de 1983 se apoya en cinco años que dirigió él.',
       updated_at = now()
 WHERE slug = 'pepe-rosario';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pepe-rosario')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pepe-rosario')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Pepe Rosario was a Dominican singer. That is the detail worth holding onto: the sound was his.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'pepe-rosario'), 4)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Pedro Julio Rosario Almonte, conocido como Pepe Rosario, fue un cantante, pianista y director de orquesta dominicano de merengue. Fundó ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario","occurrenceId":"090c3702-4152-4818-bdaf-e9838a02aa9a"}},{"text":" junto a sus hermanos y la dirigió hasta su muerte a los veintiún años, y las canciones que pusieron al grupo por primera vez en la radio dominicana las cantaba él.","type":"text"}]},{"type":"paragraph","content":[{"text":"Salvaleón de Higüey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Higüey, provincia La Altagracia, en el extremo este del país, en una familia de siete hermanos que iban a terminar todos en la misma orquesta. Tenía unos dieciséis años cuando la formaron.","type":"text"}]},{"type":"paragraph","content":[{"text":"El debut fue el 1 de mayo de 1978, en su propio pueblo, tocando para las autoridades municipales en un acto del Día del Trabajo. De ahí el grupo se fue abriendo camino por los pueblos del este hasta que el maestro Chiquitín Payán los contrató para amenizar el Hotel Romana, en Casa de Campo, que fue la contratación que los sacó del circuito local.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las Locas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Era el pianista, el director musical y el líder, y cantaba. El grupo grabó María Guayando como primer sencillo y se mudó a la capital en 1980 para hacer un primer disco. De ahí salió Las Locas, que encabezó las listas dominicanas.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cuando murió, las emisoras estaban poniendo Las Locas y Te Seguiré Queriendo, las dos en su voz. El sonido que el país reconoció primero como Los Hermanos Rosario era el suyo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Lo que vino después","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Murió el 19 de marzo de 1983 en La Romana, a los veintiún años. El grupo dejó de tocar por un tiempo y los hermanos llegaron a plantearse dejarlo todo y volverse al pueblo.","type":"text"}]},{"type":"paragraph","content":[{"text":"No lo hicieron. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario","occurrenceId":"d7cdb288-ae98-4f46-8e1f-61e7595aa2b2"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fb033f0-4f8b-4101-a67d-1d445f316dc4","displayText":"Rafa Rosario","occurrenceId":"f0dd405e-c3e3-4960-b5c0-420446026430"}},{"text":" llevaron la orquesta adelante, y en una década era la banda de merengue más exitosa que había dado el país. Todo lo que hizo después de 1983 se apoya en cinco años que dirigió él.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'pepe-rosario'), 2)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pepe-rosario') AND locale = 'es'), '090c3702-4152-4818-bdaf-e9838a02aa9a', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pepe-rosario') AND locale = 'es'), 'd7cdb288-ae98-4f46-8e1f-61e7595aa2b2', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pepe-rosario') AND locale = 'es'), 'f0dd405e-c3e3-4960-b5c0-420446026430', 'artist', '6fb033f0-4f8b-4101-a67d-1d445f316dc4');

COMMIT;
