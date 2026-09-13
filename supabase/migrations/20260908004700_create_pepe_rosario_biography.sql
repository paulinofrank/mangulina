BEGIN;

-- Create the catalogue entry for Pepe Rosario.
--
-- Pepe Rosario. FICHA NUEVA, a petición del editor. Salió escribiendo a Toño
-- Rosario esta tarde: fundador, pianista y director musical de Los Hermanos
-- Rosario, muerto en 1983, y sin ficha.
--
-- COMPROBADO ANTES DE CREAR. verificar-faltantes.cjs devuelve solo "parecidos"
-- -- checho-rosario, rafely-rosario, jorge-luis-rosario-rodriguez -- y ninguno
-- es él. Hay siete filas con "Rosario" en el catálogo y Pepe no estaba.
--
-- SE LLAMABA PEDRO JULIO ROSARIO ALMONTE. Lo da Bávaro News, en una nota
-- firmada por Patty de la Cruz publicada el 19 de marzo de 2025, aniversario de
-- su muerte.
--
-- OJO CON EL APELLIDO, QUE NO CUADRA DEL TODO CON EL DE SU HERMANO. La fuente de
-- Toño Rosario le da "Máximo Antonio DEL ROSARIO Almonte" y la de Pepe le da
-- "Pedro Julio ROSARIO Almonte", sin el "del". Son hermanos, así que uno de los
-- dos está mal, o la familia usa las dos formas. Guardo lo que dice cada fuente
-- y lo dejo reportado en vez de uniformarlo por mi cuenta.
--
-- MURIÓ A LOS VEINTIÚN AÑOS, el 19 de marzo de 1983, en La Romana. Por la edad y
-- la fecha nació entre marzo de 1961 y marzo de 1962, pero NO SE PUEDE PRECISAR
-- Y NO SE INVENTA: birth_year queda en NULL. Tenía unos dieciséis cuando fundó
-- la orquesta con sus hermanos.
--
-- ---------------------------------------------------------------------------
-- LA CAUSA DE SU MUERTE NO ENTRA, Y AQUÍ LA REGLA ES CLARA
--
-- El Nacional y Bávaro News la cuentan con detalle: lo apuñalaron al terminar un
-- set, y las dos fuentes nombran a la responsable y el móvil. ES UN HOMICIDIO,
-- o sea asunto penal, y esos no entran.
--
-- NO ES EL CASO DE RUBBY PÉREZ, donde el editor confirmó que sí se escribe: allí
-- fue un derrumbe, un hecho público sin culpable individual, ocurrido durante la
-- actuación. Aquí hay una persona responsable y un proceso. Se escribe la fecha,
-- el lugar y la edad, que son biografía, y nada más.
-- ---------------------------------------------------------------------------
--
-- LO QUE SÍ ES DATO MUSICAL Y ES BUENO: cuando murió, "LAS LOCAS" y "TE SEGUIRÉ
-- QUERIENDO" estaban sonando en las emisoras dominicanas EN SU VOZ. Lo dice El
-- Nacional. Eso lo convierte en el primer cantante que tuvo el grupo en la
-- radio, y es la razón por la que esta ficha existe y no es solo una nota al pie
-- de la de sus hermanos.
--
-- TRES ENLACES: los-hermanos-rosario, la orquesta que fundó; y sus hermanos
-- tono-rosario y rafa-rosario, que cantaban con él y sostuvieron el grupo
-- después.
--
-- LOS PARENTESCOS VAN EN MIGRACIÓN APARTE: 'sibling' con los dos, que es lo que
-- corresponde entre hermanos publicados. El par Rafa-Toño ya estaba registrado.
--
-- primary_role = 'singer' Y NO 'instrumentalist', aunque era el pianista. Es la
-- convención del catálogo, la misma que se aplicó a los acordeonistas de típico:
-- cantan primero y el instrumento va en occupations. Y en su caso encaja
-- especialmente bien, porque lo que quedó de él en la radio fue su voz.
--
-- FUENTES: Bávaro News, 19 de marzo de 2025, para el nombre completo, la edad y
-- su papel en el grupo. El Nacional, 19 de marzo de 2021, para la fecha, las dos
-- canciones que sonaban en su voz y lo que le pasó a la orquesta después.
-- Wikipedia en español sobre Los Hermanos Rosario para la fundación.
--
-- NOMBRES NUEVOS PARA LA LISTA: los otros hermanos que no tienen ficha, TONY,
-- LUIS, FRANCIS y ROSSY ROSARIO; SANTO HERNÁNDEZ, bailarín principal del grupo
-- entre 1978 y 1983; y CHIQUITÍN PAYÁN, que los contrató para el Hotel Romana.
--
-- Applied directly over DATABASE_URL as part of an editorial pass. No Vercel
-- function ran and nothing was revalidated; the profile reaches the public site
-- on its own within the 31-day ISR fallback for artist profiles, or sooner if a
-- targeted revalidation is run for the slug.
--
-- This file reproduces the change from the pre-pass state. Both it and its
-- rollback were generated from state captured live either side of the write,
-- not reconstructed afterwards.

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
       bio_en = 'Pedro Julio Rosario Almonte, known as Pepe Rosario, was a Dominican merengue singer, pianist and bandleader. He founded Los Hermanos Rosario with his brothers and led it until his death at twenty-one, and the songs that first put the group on Dominican radio were sung by him.

**Salvaleón de Higüey**

He was born in Higüey, in the province of La Altagracia at the eastern end of the country, into a family of seven brothers who were all going to end up in the same band. He was about sixteen when they formed it.

The debut was on 1 May 1978, in their own town, playing for the municipal authorities at a Labour Day event. From there the group worked its way around the eastern towns before the bandleader Chiquitín Payán hired them to play the Hotel Romana at Casa de Campo, which was the first booking that took them out of the local circuit.

**Las Locas**

He was the pianist, the musical director and the leader, and he sang. The group recorded María Guayando as its first single, and moved to the capital in 1980 to make a first album. Las Locas came off it and went to the top of the Dominican charts.

At the time of his death the stations were playing Las Locas and Te Seguiré Queriendo, both in his voice. That is the part worth holding onto: the sound the country first recognised as Los Hermanos Rosario was his.

**What followed**

He died on 19 March 1983 in La Romana, at twenty-one. The group stopped playing for a time and the brothers considered giving it up altogether and going home.

They did not. Toño Rosario and Rafa Rosario took the orchestra forward, and within a decade it was the most successful merengue band the country had produced. Everything it did after 1983 rests on five years that he directed.',
       bio_es = 'Pedro Julio Rosario Almonte, conocido como Pepe Rosario, fue un cantante, pianista y director de orquesta dominicano de merengue. Fundó Los Hermanos Rosario junto a sus hermanos y la dirigió hasta su muerte a los veintiún años, y las canciones que pusieron al grupo por primera vez en la radio dominicana las cantaba él.

**Salvaleón de Higüey**

Nació en Higüey, provincia La Altagracia, en el extremo este del país, en una familia de siete hermanos que iban a terminar todos en la misma orquesta. Tenía unos dieciséis años cuando la formaron.

El debut fue el 1 de mayo de 1978, en su propio pueblo, tocando para las autoridades municipales en un acto del Día del Trabajo. De ahí el grupo se fue abriendo camino por los pueblos del este hasta que el maestro Chiquitín Payán los contrató para amenizar el Hotel Romana, en Casa de Campo, que fue la contratación que los sacó del circuito local.

**Las Locas**

Era el pianista, el director musical y el líder, y cantaba. El grupo grabó María Guayando como primer sencillo y se mudó a la capital en 1980 para hacer un primer disco. De ahí salió Las Locas, que encabezó las listas dominicanas.

Cuando murió, las emisoras estaban poniendo Las Locas y Te Seguiré Queriendo, las dos en su voz. Eso es lo que conviene retener: el sonido que el país reconoció primero como Los Hermanos Rosario era el suyo.

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
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Pedro Julio Rosario Almonte, known as Pepe Rosario, was a Dominican merengue singer, pianist and bandleader. He founded ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario","occurrenceId":"fd753e64-358d-4d2f-9ec9-eeefee276c0b"}},{"text":" with his brothers and led it until his death at twenty-one, and the songs that first put the group on Dominican radio were sung by him.","type":"text"}]},{"type":"paragraph","content":[{"text":"Salvaleón de Higüey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Higüey, in the province of La Altagracia at the eastern end of the country, into a family of seven brothers who were all going to end up in the same band. He was about sixteen when they formed it.","type":"text"}]},{"type":"paragraph","content":[{"text":"The debut was on 1 May 1978, in their own town, playing for the municipal authorities at a Labour Day event. From there the group worked its way around the eastern towns before the bandleader Chiquitín Payán hired them to play the Hotel Romana at Casa de Campo, which was the first booking that took them out of the local circuit.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las Locas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was the pianist, the musical director and the leader, and he sang. The group recorded María Guayando as its first single, and moved to the capital in 1980 to make a first album. Las Locas came off it and went to the top of the Dominican charts.","type":"text"}]},{"type":"paragraph","content":[{"text":"At the time of his death the stations were playing Las Locas and Te Seguiré Queriendo, both in his voice. That is the part worth holding onto: the sound the country first recognised as Los Hermanos Rosario was his.","type":"text"}]},{"type":"paragraph","content":[{"text":"What followed","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He died on 19 March 1983 in La Romana, at twenty-one. The group stopped playing for a time and the brothers considered giving it up altogether and going home.","type":"text"}]},{"type":"paragraph","content":[{"text":"They did not. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario","occurrenceId":"c8c2fd98-72d8-4035-af0f-5737f33daf22"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fb033f0-4f8b-4101-a67d-1d445f316dc4","displayText":"Rafa Rosario","occurrenceId":"1222a869-6246-4313-a8a0-cbadc1a9eefa"}},{"text":" took the orchestra forward, and within a decade it was the most successful merengue band the country had produced. Everything it did after 1983 rests on five years that he directed.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'pepe-rosario'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Pedro Julio Rosario Almonte, conocido como Pepe Rosario, fue un cantante, pianista y director de orquesta dominicano de merengue. Fundó ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario","occurrenceId":"ceda5bad-30f9-4a2d-89f4-929fe719ed96"}},{"text":" junto a sus hermanos y la dirigió hasta su muerte a los veintiún años, y las canciones que pusieron al grupo por primera vez en la radio dominicana las cantaba él.","type":"text"}]},{"type":"paragraph","content":[{"text":"Salvaleón de Higüey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Higüey, provincia La Altagracia, en el extremo este del país, en una familia de siete hermanos que iban a terminar todos en la misma orquesta. Tenía unos dieciséis años cuando la formaron.","type":"text"}]},{"type":"paragraph","content":[{"text":"El debut fue el 1 de mayo de 1978, en su propio pueblo, tocando para las autoridades municipales en un acto del Día del Trabajo. De ahí el grupo se fue abriendo camino por los pueblos del este hasta que el maestro Chiquitín Payán los contrató para amenizar el Hotel Romana, en Casa de Campo, que fue la contratación que los sacó del circuito local.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las Locas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Era el pianista, el director musical y el líder, y cantaba. El grupo grabó María Guayando como primer sencillo y se mudó a la capital en 1980 para hacer un primer disco. De ahí salió Las Locas, que encabezó las listas dominicanas.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cuando murió, las emisoras estaban poniendo Las Locas y Te Seguiré Queriendo, las dos en su voz. Eso es lo que conviene retener: el sonido que el país reconoció primero como Los Hermanos Rosario era el suyo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Lo que vino después","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Murió el 19 de marzo de 1983 en La Romana, a los veintiún años. El grupo dejó de tocar por un tiempo y los hermanos llegaron a plantearse dejarlo todo y volverse al pueblo.","type":"text"}]},{"type":"paragraph","content":[{"text":"No lo hicieron. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario","occurrenceId":"413ff6c4-534c-4b3a-af82-96b1f85cbc07"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fb033f0-4f8b-4101-a67d-1d445f316dc4","displayText":"Rafa Rosario","occurrenceId":"e11f27bb-ae66-4c26-b9f6-863ee551f3ed"}},{"text":" llevaron la orquesta adelante, y en una década era la banda de merengue más exitosa que había dado el país. Todo lo que hizo después de 1983 se apoya en cinco años que dirigió él.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'pepe-rosario'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pepe-rosario') AND locale = 'en'), '1222a869-6246-4313-a8a0-cbadc1a9eefa', 'artist', '6fb033f0-4f8b-4101-a67d-1d445f316dc4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pepe-rosario') AND locale = 'en'), 'c8c2fd98-72d8-4035-af0f-5737f33daf22', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pepe-rosario') AND locale = 'en'), 'fd753e64-358d-4d2f-9ec9-eeefee276c0b', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pepe-rosario') AND locale = 'es'), '413ff6c4-534c-4b3a-af82-96b1f85cbc07', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pepe-rosario') AND locale = 'es'), 'ceda5bad-30f9-4a2d-89f4-929fe719ed96', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pepe-rosario') AND locale = 'es'), 'e11f27bb-ae66-4c26-b9f6-863ee551f3ed', 'artist', '6fb033f0-4f8b-4101-a67d-1d445f316dc4');

COMMIT;
