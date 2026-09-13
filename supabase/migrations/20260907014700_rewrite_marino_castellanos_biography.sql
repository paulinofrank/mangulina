BEGIN;

-- Rewrite the catalogue entry for Marino Castellanos.
--
-- Marino Castellanos. Duodécima de las dieciséis fichas publicadas que estaban
-- EN BLANCO.
--
-- LO QUE YA TENÍA LA FILA SE CONFIRMA Y NO SE TOCA: 9 de abril de 1958,
-- Caobete, provincia Duarte. Bachata Republic precisa que Caobete queda entre
-- Las Guáranas y Pimentel, en San Francisco de Macorís, lo que cuadra con la
-- provincia guardada.
--
-- SE COMPLETA EL NOMBRE: MARINO CRUZ CASTELLANOS. Cruz es el apellido paterno y
-- Castellanos el materno; se hizo artista con el segundo. Por eso last_name va
-- Cruz y second_last_name va Castellanos, aunque el nombre público sea Marino
-- Castellanos.
--
-- SE AÑADE EL APODO "LA VOZ DE SEDA", que usan la prensa y su propia página.
--
-- TERCERA VEZ QUE APARECE RADHAMÉS ARACENA en esta corrida, después de Leonardo
-- Paniagua y de su propia ficha. Es él quien lo firma en 1984 para el sello de
-- Radio Guarachita. Empieza a verse que media bachata dominicana pasa por ese
-- hombre, y el catálogo ya lo puede mostrar con enlaces.
--
-- LOS OTROS DOS ENLACES TAMBIÉN SON DE FONDO, no de adorno: cantaba temas de
-- luis-segura y leonardo-paniagua trabajando en el campo, y en su primera
-- tarima el público lo llamó "el doble de Luis Segura". Los dos artistas que
-- imitaba están en el catálogo, así que la línea se puede seguir.
--
-- SE INCLUYE LA HISTORIA LABORAL Y ES EL CORAZÓN DE LA FICHA: sembró arroz con
-- su padre desde los siete años, desyerbó terrenos por tres pesos con cincuenta,
-- pasó por la Academia de Policía de San Cristóbal, ejerció dos años y renunció,
-- y estuvo unos cuatro años de vigilante. Escribió sus primeras canciones en un
-- cuaderno durante los turnos de noche. Mismo criterio que con Leonardo
-- Paniagua: los oficios previos explican de dónde sale el cantante.
--
-- SE DEJA FUERA: los nombres de sus padres, los nueve hermanos, el hijo que
-- mantenía con el sueldo de vigilante, y la mujer que lo despreció y que
-- según la fuente inspiró su primera canción. Vida privada.
--
-- NO SE CITA TEXTUALMENTE la frase de Aracena al oír el casete, aunque es el
-- momento de la historia. Se cuenta con palabras propias.
--
-- LA CIFRA DE SUELDO SÍ ENTRA -- ciento quince pesos por quincena -- porque no
-- es una métrica de popularidad sino un dato de precariedad laboral, que es
-- otra cosa. Las cifras que este catálogo no escribe son las de seguidores,
-- reproducciones y ventas.
--
-- LOS HANDLES YA ESTABAN GUARDADOS Y ESTÁN BIEN: youtube @marinocastellanos,
-- instagram castellanosmarino, facebook CastellanosMarino. No se tocan.
--
-- FUENTES: Bachata Republic, 19 de febrero de 2022, de Luis Becker Cabrera, que
-- es la biografía detallada. El Caribe, 10 de octubre de 2018. La entrevista
-- "De guachimán a bachatero", de Graynmer Méndez.
--
-- NOMBRES NUEVOS PARA LA LISTA: Eddy Abikaran, manejador principal de Radio
-- Guarachita, que aparece en el momento de la firma.
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
       name = 'Marino Castellanos',
       sort_name = 'Cruz Castellanos, Marino',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1958-04-09',
       birth_year = 1958,
       date_of_death = NULL,
       birth_place = 'Caobete',
       province = 'Duarte',
       first_name = 'Marino',
       middle_name = NULL,
       last_name = 'Cruz',
       second_last_name = 'Castellanos',
       stage_name = 'Marino Castellanos',
       aliases = ARRAY['La Voz de Seda']::text[],
       occupations = '["composer","songwriter"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@marinocastellanos',
       facebook = 'CastellanosMarino',
       instagram = 'castellanosmarino',
       disambiguation = 'Bachata singer and songwriter known as La Voz de Seda',
       bio_en = 'Marino Cruz Castellanos, known as Marino Castellanos and billed as La Voz de Seda, is a Dominican bachata singer and songwriter. He came to recording late and after a long stretch of manual work, and he writes the material he records.

**Caobete**

He was born in 1958 in Caobete, a rural settlement between Las Guáranas and Pimentel in the province of Duarte. He worked from the age of seven, planting rice alongside his father and clearing land by the day for three pesos fifty. He came from a family of farmers and was the one who did not stay on the land.

The music he sang while working was other people’s. He learned the repertoire of Luis Segura and Leonardo Paniagua in the fields, and the people around him began asking him to sing.

**Police and night watch**

He entered the police academy at San Cristóbal, where a cadet who heard him sing excused him from cleaning duty in exchange for singing while the others worked. He served two years and resigned. For roughly four years afterwards he worked as a security guard, first for a firm that hired former police, then on twelve-hour residential shifts, and finally at a mining company, earning a hundred and fifteen pesos a fortnight.

**The patron-saint festival**

On one of his rare days off a guitarist friend took him to the patron-saint festival at Los Cacaos, in Hatillo. He asked to sing one song, and the band agreed. He chose a bachata, which the lead guitarist warned him was the wrong choice for that kind of event, and sang No Me Celes Tanto. The audience called him the double of Luis Segura and demanded two more.

**The notebook**

One of the guitarists told him to write his own songs and take them to Radhamés Aracena, who ran Radio Guarachita and its label. He bought a notebook and a pencil and wrote through his night shifts until he had twelve songs, recorded them on a cassette with his guitarist friend, and took it to Santo Domingo.

Aracena signed him on the spot. The first production, No Me Hagas Sufrir Tanto, named for the first song he ever wrote, was released in 1984.

**The long climb**

He formed his own group in 1986, and the recognition came slowly. The turn arrived three decades into the career, when a run of singles released in 2014 reached audiences abroad: Voy a Romper la Cama en Dos, La Lloradera and above all Eso Da Pa’ To, the record his name is now attached to. He has since toured the Caribbean and the United States.',
       bio_es = 'Marino Cruz Castellanos, conocido como Marino Castellanos y anunciado como La Voz de Seda, es un cantante y compositor de bachata dominicano. Llegó tarde al disco y después de una larga etapa de trabajo manual, y escribe el material que graba.

**Caobete**

Nació en 1958 en Caobete, un paraje rural entre Las Guáranas y Pimentel, en la provincia Duarte. Trabajó desde los siete años, sembrando arroz junto a su padre y echando días desyerbando terrenos por tres pesos con cincuenta. Venía de una familia de agricultores y fue el que no se quedó en la tierra.

La música que cantaba trabajando era ajena. Se aprendió el repertorio de Luis Segura y de Leonardo Paniagua en el campo, y la gente de alrededor empezó a pedirle que cantara.

**Policía y guachimán**

Entró a la Academia de Policía de San Cristóbal, donde un cadete que lo oyó cantar lo eximía de la limpieza a cambio de que cantara mientras los demás trabajaban. Ejerció dos años y renunció. Después estuvo unos cuatro años de vigilante: primero en una empresa que contrataba expolicías, luego en turnos residenciales de doce horas, y por último en una minera, ganando ciento quince pesos la quincena.

**Las patronales**

En uno de sus escasos días libres, un amigo guitarrista lo llevó a las fiestas patronales de Los Cacaos, en Hatillo. Pidió cantar una sola canción y el grupo accedió. Escogió una bachata, que el requinto le advirtió que era mala elección para ese tipo de evento, y cantó No Me Celes Tanto. El público lo llamó el doble de Luis Segura y le exigió dos canciones más.

**El cuaderno**

Uno de los guitarristas le dijo que escribiera canciones propias y se las llevara a Radhamés Aracena, que dirigía Radio Guarachita y su sello. Compró un cuaderno y un lápiz y escribió durante sus turnos de noche hasta juntar doce canciones, las grabó en un casete con su amigo guitarrista y se fue con él a Santo Domingo.

Aracena lo firmó en el acto. La primera producción, No Me Hagas Sufrir Tanto, que lleva el nombre de la primera canción que escribió en su vida, salió en 1984.

**La subida larga**

Formó su propia agrupación en 1986, y el reconocimiento llegó despacio. El giro vino tres décadas después de empezar, cuando una tanda de sencillos publicada en 2014 alcanzó público en el exterior: Voy a Romper la Cama en Dos, La Lloradera y sobre todo Eso Da Pa’ To, el disco al que su nombre está hoy asociado. Desde entonces ha girado por el Caribe y por Estados Unidos.',
       updated_at = now()
 WHERE slug = 'marino-castellanos';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'marino-castellanos')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'marino-castellanos')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Marino Cruz Castellanos, known as Marino Castellanos and billed as La Voz de Seda, is a Dominican bachata singer and songwriter. He came to recording late and after a long stretch of manual work, and he writes the material he records.","type":"text"}]},{"type":"paragraph","content":[{"text":"Caobete","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1958 in Caobete, a rural settlement between Las Guáranas and Pimentel in the province of Duarte. He worked from the age of seven, planting rice alongside his father and clearing land by the day for three pesos fifty. He came from a family of farmers and was the one who did not stay on the land.","type":"text"}]},{"type":"paragraph","content":[{"text":"The music he sang while working was other people’s. He learned the repertoire of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"6b2c47a7-7a9e-41ec-b5eb-693d90dc8d2c"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"31915623-3206-4052-b13a-2170226671b9","displayText":"Leonardo Paniagua","occurrenceId":"5214bf72-0d76-405a-912b-e698bd9d4fba"}},{"text":" in the fields, and the people around him began asking him to sing.","type":"text"}]},{"type":"paragraph","content":[{"text":"Police and night watch","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He entered the police academy at San Cristóbal, where a cadet who heard him sing excused him from cleaning duty in exchange for singing while the others worked. He served two years and resigned. For roughly four years afterwards he worked as a security guard, first for a firm that hired former police, then on twelve-hour residential shifts, and finally at a mining company, earning a hundred and fifteen pesos a fortnight.","type":"text"}]},{"type":"paragraph","content":[{"text":"The patron-saint festival","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"On one of his rare days off a guitarist friend took him to the patron-saint festival at Los Cacaos, in Hatillo. He asked to sing one song, and the band agreed. He chose a bachata, which the lead guitarist warned him was the wrong choice for that kind of event, and sang No Me Celes Tanto. The audience called him the double of Luis Segura and demanded two more.","type":"text"}]},{"type":"paragraph","content":[{"text":"The notebook","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"One of the guitarists told him to write his own songs and take them to ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena","occurrenceId":"a26da3b6-b27a-49c1-97e3-3942aa16eedd"}},{"text":", who ran Radio Guarachita and its label. He bought a notebook and a pencil and wrote through his night shifts until he had twelve songs, recorded them on a cassette with his guitarist friend, and took it to Santo Domingo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Aracena signed him on the spot. The first production, No Me Hagas Sufrir Tanto, named for the first song he ever wrote, was released in 1984.","type":"text"}]},{"type":"paragraph","content":[{"text":"The long climb","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He formed his own group in 1986, and the recognition came slowly. The turn arrived three decades into the career, when a run of singles released in 2014 reached audiences abroad: Voy a Romper la Cama en Dos, La Lloradera and above all Eso Da Pa’ To, the record his name is now attached to. He has since toured the Caribbean and the United States.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'marino-castellanos'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Marino Cruz Castellanos, conocido como Marino Castellanos y anunciado como La Voz de Seda, es un cantante y compositor de bachata dominicano. Llegó tarde al disco y después de una larga etapa de trabajo manual, y escribe el material que graba.","type":"text"}]},{"type":"paragraph","content":[{"text":"Caobete","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1958 en Caobete, un paraje rural entre Las Guáranas y Pimentel, en la provincia Duarte. Trabajó desde los siete años, sembrando arroz junto a su padre y echando días desyerbando terrenos por tres pesos con cincuenta. Venía de una familia de agricultores y fue el que no se quedó en la tierra.","type":"text"}]},{"type":"paragraph","content":[{"text":"La música que cantaba trabajando era ajena. Se aprendió el repertorio de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"32b6710e-737f-436e-b1c6-f57142d24988"}},{"text":" y de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"31915623-3206-4052-b13a-2170226671b9","displayText":"Leonardo Paniagua","occurrenceId":"8155d938-d0c7-482e-8b37-32a7a0a65e7b"}},{"text":" en el campo, y la gente de alrededor empezó a pedirle que cantara.","type":"text"}]},{"type":"paragraph","content":[{"text":"Policía y guachimán","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Entró a la Academia de Policía de San Cristóbal, donde un cadete que lo oyó cantar lo eximía de la limpieza a cambio de que cantara mientras los demás trabajaban. Ejerció dos años y renunció. Después estuvo unos cuatro años de vigilante: primero en una empresa que contrataba expolicías, luego en turnos residenciales de doce horas, y por último en una minera, ganando ciento quince pesos la quincena.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las patronales","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En uno de sus escasos días libres, un amigo guitarrista lo llevó a las fiestas patronales de Los Cacaos, en Hatillo. Pidió cantar una sola canción y el grupo accedió. Escogió una bachata, que el requinto le advirtió que era mala elección para ese tipo de evento, y cantó No Me Celes Tanto. El público lo llamó el doble de Luis Segura y le exigió dos canciones más.","type":"text"}]},{"type":"paragraph","content":[{"text":"El cuaderno","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Uno de los guitarristas le dijo que escribiera canciones propias y se las llevara a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena","occurrenceId":"66df5096-73d4-4edb-9b29-b9bc72962e8e"}},{"text":", que dirigía Radio Guarachita y su sello. Compró un cuaderno y un lápiz y escribió durante sus turnos de noche hasta juntar doce canciones, las grabó en un casete con su amigo guitarrista y se fue con él a Santo Domingo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Aracena lo firmó en el acto. La primera producción, No Me Hagas Sufrir Tanto, que lleva el nombre de la primera canción que escribió en su vida, salió en 1984.","type":"text"}]},{"type":"paragraph","content":[{"text":"La subida larga","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Formó su propia agrupación en 1986, y el reconocimiento llegó despacio. El giro vino tres décadas después de empezar, cuando una tanda de sencillos publicada en 2014 alcanzó público en el exterior: Voy a Romper la Cama en Dos, La Lloradera y sobre todo Eso Da Pa’ To, el disco al que su nombre está hoy asociado. Desde entonces ha girado por el Caribe y por Estados Unidos.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'marino-castellanos'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'marino-castellanos') AND locale = 'en'), '5214bf72-0d76-405a-912b-e698bd9d4fba', 'artist', '31915623-3206-4052-b13a-2170226671b9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'marino-castellanos') AND locale = 'en'), '6b2c47a7-7a9e-41ec-b5eb-693d90dc8d2c', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'marino-castellanos') AND locale = 'en'), 'a26da3b6-b27a-49c1-97e3-3942aa16eedd', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'marino-castellanos') AND locale = 'es'), '32b6710e-737f-436e-b1c6-f57142d24988', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'marino-castellanos') AND locale = 'es'), '66df5096-73d4-4edb-9b29-b9bc72962e8e', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'marino-castellanos') AND locale = 'es'), '8155d938-d0c7-482e-8b37-32a7a0a65e7b', 'artist', '31915623-3206-4052-b13a-2170226671b9');

COMMIT;
