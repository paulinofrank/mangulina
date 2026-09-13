BEGIN;

-- Rewrite the catalogue entry for Yoskar Sarante.
--
-- Yoskar Sarante. DECIMOTERCERA de las dieciocho. Molde otra vez: 1.436
-- caracteres, cero canciones, cero discos, cero años. De uno de los dos
-- bachateros más oídos del país a principios de siglo.
--
-- EL LUGAR DE NACIMIENTO ESTABA MAL Y SE CORRIGE, NO EN SILENCIO. La fila decía
-- "Bani". Nació en VILLAS AGRÍCOLAS, SANTO DOMINGO, y lo sostienen DOS fuentes
-- independientes: Wikipedia en español y Bachata Republic, que es fuente
-- especializada del género. No encontré ninguna que lo haga banilejo. El valor
-- anterior queda escrito aquí y en la migración por si alguien tiene el dato
-- que yo no tengo.
--
-- LOS CUATRO CAMPOS DEL NOMBRE ESTABAN EN NULL. Se llamaba YOSKAR SARANTE
-- VENTURA. sort_name también estaba vacío.
--
-- EL APODO ESTABA MAL ESCRITO: aliases decía 'El prabu', en minúscula y sin
-- tilde. Es EL PRABÚ, y da título además a su primer disco, de 1994. Se añade
-- el segundo apodo, "LA VOZ MÁS ALTA DE LA BACHATA", que usa Bachata Republic.
--
-- OJO CON ESE SEGUNDO APODO: es el mismo formato que "la voz más alta del
-- merengue" de Rubby Pérez, que escribí hace un rato. No es error mío ni
-- confusión entre fichas; son dos apodos paralelos en dos géneros distintos, y
-- conviene que quede dicho para que nadie lo lea como copia.
--
-- LO QUE FALTABA:
--
--   QUE EMPEZÓ EN EL MERENGUE, y no en la bachata. Estuvo en el Grupo
--   Internacional Melao y después en las orquestas de Tomás Barrera, Cheché
--   Abreu, Aramis Camilo y Guancho Viloria. La ficha lo presentaba como
--   bachatero de nacimiento.
--
--   "LLORA ALMA MÍA", de 2000, que es el disco que lo hizo. De ahí salen "La
--   Noche (Mi Gran Noche)", "No Te Detengas", "Si Te Llego a Perder" y el tema
--   que le da título.
--
--   QUE ENTRE 2000 Y 2002 ÉL Y ELVIS MARTÍNEZ FUERON LOS DOS BACHATEROS MÁS
--   ESCUCHADOS DEL PAÍS. Ese es el dato que sitúa su tamaño, y no estaba.
--
--   CÓMO SE FORMÓ: cantaba en parques con su hermano mayor a la guitarra,
--   concursó en "Mundo Infantil", y pagó la Escuela de Música Iris del Valle,
--   en Los Mina, TRABAJANDO EN CONSTRUCCIÓN.
--
-- LOS AÑOS DE LOS DISCOS SE ESCRIBEN SOLO DONDE LAS DOS FUENTES COINCIDEN:
-- 1994, 1996, 1998, 2000, 2002, 2004, 2006 y 2008. De los posteriores
-- discrepan -- "Le Pregunto al Amor" lo fechan en 2012 y en 2016, "Quién Eres
-- Tú" en 2015 y en 2016 -- así que esos se nombran sin año o no se nombran.
--
-- LO QUE SE DEJA FUERA: sus problemas de salud, que las dos fuentes detallan
-- con nombre de enfermedad, la fractura de vértebra de 2016, y la causa de
-- muerte. Todo eso es historia clínica. Sí entra que murió el 28 de enero de
-- 2019 en Orlando, que es fecha y lugar.
--
-- TAMPOCO ENTRAN los nombres de sus padres.
--
-- NO SE ESCRIBE SU EDAD AL MORIR, y a propósito: nació el 2 de enero de 1970 y
-- murió el 28 de enero de 2019, o sea con 49 recién cumplidos, pero Billboard y
-- Telemundo titularon "48" y esa cifra circula. Con las dos fechas escritas, la
-- resta la hace quien quiera y no hay nada que equivocar.
--
-- SOLO DOS ENLACES, Y ES LO QUE HAY: elvis-martinez y cheche-abreu. De los
-- otros cuatro directores de orquesta por los que pasó, Aramis Camilo, Guancho
-- Viloria y Tomás Barrera NO ESTÁN en el catálogo. Comprobado.
--
-- OJO CON LA GRAFÍA: la fila de Cheché se llama "Cheche Abreu" SIN TILDES. El
-- displayText tiene que decir eso exacto aunque las fuentes lo escriban con
-- acento. Queda reportado como posible corrección de nombre, aparte.
--
-- QUEDA PENDIENTE UN PREMIO QUE NO PUDE FECHAR. Wikipedia lo clasifica en
-- "Ganadores del premio Soberano" pero el artículo no dice cuál ni cuándo, y no
-- encontré la ceremonia. No registro nada: un premio sin categoría ni año es
-- una fila que no informa. Queda anotado para buscarlo.
--
-- FUENTES: Wikipedia en español, con sus citas a Billboard, Telemundo, El
-- Universal y El Nuevo Diario. Bachata Republic, biografía firmada por Luis
-- Becker Cabrera, para la formación, las orquestas de merengue y el detalle de
-- "Llora Alma Mía". SE IGNORÓ la sección "Logros Notables" de Wikipedia, que
-- está sin firmar, sin fuentes y mal escrita.
--
-- NOMBRES NUEVOS PARA LA LISTA: GUANCHO VILORIA y TOMÁS BARRERA, dos
-- directores de orquesta de merengue; y GRUPO INTERNACIONAL MELAO.
--
-- REVISION 3, MISMO DÍA: ARAMIS CAMILO YA NO FALTA. Lo cree unas horas despues
-- de escribir esta ficha, a peticion del editor, y ahora se enlaza en vez de
-- nombrarse en texto plano. Es la manera correcta de cerrar el circuito: cuando
-- una ausencia se llena, las fichas que la nombraban se reescriben.
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
       name = 'Yoskar Sarante',
       sort_name = 'Sarante Ventura, Yoskar',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1970-01-02',
       birth_year = 1970,
       date_of_death = '2019-01-28',
       birth_place = 'Villas Agrícolas, Santo Domingo',
       province = 'Peravia',
       first_name = 'Yoskar',
       middle_name = NULL,
       last_name = 'Sarante',
       second_last_name = 'Ventura',
       stage_name = NULL,
       aliases = ARRAY['El Prabú', 'La Voz Más Alta de la Bachata']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = 'yoskarsaranteoficial',
       disambiguation = 'Bachata singer known as El Prabú; came out of merengue orchestras before Llora Alma Mía',
       bio_en = 'Yoskar Sarante Ventura, known as El Prabú, was a Dominican bachata singer. He had a high, unforced voice that could hold a line without pushing it, and for a stretch at the start of the century he was one of the two most heard bachateros in the country.

**Villas Agrícolas**

He was born in 1970 in Villas Agrícolas, a barrio of Santo Domingo. As a boy he sang in parks and public squares while his older brother played guitar, and what they collected went to the household. He entered the children’s singing contests on Dominican television, among them Mundo Infantil, and later enrolled at the Iris del Valle music school in Los Mina, paying for it with work on building sites.

**The merengue orchestras**

His professional career began in merengue rather than bachata. He sang with Grupo Internacional Melao, and after finishing at the music school passed through the orchestras of Tomás Barrera, Cheche Abreu, Aramis Camilo and Guancho Viloria. The years in front of merengue bands gave him the breath control and the projection that later separated him inside a slower genre.

**Llora Alma Mía**

He turned to bachata and released El Prabú in 1994, the record that gave him his name, followed by Niña Sedienta in 1996 and Si Fuera Ella in 1998. The album that made him was Llora Alma Mía, in 2000: La Noche, No Te Detengas, Si Te Llego a Perder and the title song are all still standards of the genre.

No Es Casualidad followed in 2002 and Viví in 2004. Between those records he and Elvis Martínez were the two bachateros the country listened to most, at the moment when bachata was finishing its move from the margins to the centre of Dominican radio. He was invited to New York and sang at the Mets stadium in front of the city’s mayor, which opened the United States to him.

**The later records**

Parada 37 came in 2006 and Vuelve Vuelve in 2008, and he kept releasing into the following decade. The songs that stayed are the slow ones: Vas a Llorar, Guitarra, Por una Mentira, Perdido, Perdóname, No Tengo Suerte en el Amor, El Amor es Libre, He Tenido que Llorar and Guerra de Amor.

He also recorded within the wider revival of the genre, appearing on collections such as Bachata Típico and The Rough Guide to Bachata, which carried Dominican bachata to listeners who had come to it from outside. He died in a hospital in Orlando, Florida, on 28 January 2019.',
       bio_es = 'Yoskar Sarante Ventura, conocido como El Prabú, fue un cantante de bachata dominicano. Tenía una voz aguda y sin esfuerzo, capaz de sostener una frase sin forzarla, y durante un tramo de principios de siglo fue uno de los dos bachateros más escuchados del país.

**Villas Agrícolas**

Nació en 1970 en Villas Agrícolas, barrio de Santo Domingo. De niño cantaba en parques y plazas públicas mientras su hermano mayor tocaba la guitarra, y lo que recogían iba al sustento de la casa. Concursó en los programas infantiles de canto de la televisión dominicana, entre ellos Mundo Infantil, y más adelante se inscribió en la Escuela de Música Iris del Valle, en Los Mina, que pagó trabajando en construcción.

**Las orquestas de merengue**

Su carrera profesional empezó en el merengue y no en la bachata. Cantó con el Grupo Internacional Melao y, al graduarse de la escuela de música, pasó por las orquestas de Tomás Barrera, Cheche Abreu, Aramis Camilo y Guancho Viloria. Los años delante de bandas de merengue le dieron el aire y la proyección que después lo distinguieron dentro de un género más lento.

**Llora Alma Mía**

Se pasó a la bachata y sacó El Prabú en 1994, el disco que le dio el nombre, seguido de Niña Sedienta en 1996 y Si Fuera Ella en 1998. El álbum que lo hizo fue Llora Alma Mía, de 2000: La Noche, No Te Detengas, Si Te Llego a Perder y el tema que le da título siguen siendo clásicos del género.

Detrás vinieron No Es Casualidad en 2002 y Viví en 2004. Entre esos discos, él y Elvis Martínez eran los dos bachateros que más oía el país, justo cuando la bachata terminaba de pasar del margen al centro de la radio dominicana. Lo invitaron a Nueva York y cantó en el estadio de los Mets delante del alcalde de la ciudad, lo que le abrió Estados Unidos.

**Los discos siguientes**

Parada 37 salió en 2006 y Vuelve Vuelve en 2008, y siguió publicando en la década siguiente. Las canciones que quedaron son las lentas: Vas a Llorar, Guitarra, Por una Mentira, Perdido, Perdóname, No Tengo Suerte en el Amor, El Amor es Libre, He Tenido que Llorar y Guerra de Amor.

Grabó también dentro del rescate más amplio del género, apareciendo en recopilaciones como Bachata Típico y The Rough Guide to Bachata, que llevaron la bachata dominicana a oyentes que llegaron a ella desde afuera. Murió en un hospital de Orlando, Florida, el 28 de enero de 2019.',
       updated_at = now()
 WHERE slug = 'yoskar-sarante';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Yoskar Sarante Ventura, known as El Prabú, was a Dominican bachata singer. He had a high, unforced voice that could hold a line without pushing it, and for a stretch at the start of the century he was one of the two most heard bachateros in the country.","type":"text"}]},{"type":"paragraph","content":[{"text":"Villas Agrícolas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1970 in Villas Agrícolas, a barrio of Santo Domingo. As a boy he sang in parks and public squares while his older brother played guitar, and what they collected went to the household. He entered the children’s singing contests on Dominican television, among them Mundo Infantil, and later enrolled at the Iris del Valle music school in Los Mina, paying for it with work on building sites.","type":"text"}]},{"type":"paragraph","content":[{"text":"The merengue orchestras","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His professional career began in merengue rather than bachata. He sang with Grupo Internacional Melao, and after finishing at the music school passed through the orchestras of Tomás Barrera, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"73691e65-206a-4c71-9b5f-8689f15b2584","displayText":"Cheche Abreu","occurrenceId":"af0b240c-234b-4214-ab00-2d41575ba01d"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e5129444-0923-4e06-b77d-f82f14c02b7d","displayText":"Aramis Camilo","occurrenceId":"d8487513-f171-4f98-8f66-6a3bb8dccee5"}},{"text":" and Guancho Viloria. The years in front of merengue bands gave him the breath control and the projection that later separated him inside a slower genre.","type":"text"}]},{"type":"paragraph","content":[{"text":"Llora Alma Mía","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He turned to bachata and released El Prabú in 1994, the record that gave him his name, followed by Niña Sedienta in 1996 and Si Fuera Ella in 1998. The album that made him was Llora Alma Mía, in 2000: La Noche, No Te Detengas, Si Te Llego a Perder and the title song are all still standards of the genre.","type":"text"}]},{"type":"paragraph","content":[{"text":"No Es Casualidad followed in 2002 and Viví in 2004. Between those records he and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e566c763-02c1-4f96-8a82-edbba9fc0bb2","displayText":"Elvis Martínez","occurrenceId":"c9aaff5f-8de7-40f2-9bf3-1effe4ae92fa"}},{"text":" were the two bachateros the country listened to most, at the moment when bachata was finishing its move from the margins to the centre of Dominican radio. He was invited to New York and sang at the Mets stadium in front of the city’s mayor, which opened the United States to him.","type":"text"}]},{"type":"paragraph","content":[{"text":"The later records","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Parada 37 came in 2006 and Vuelve Vuelve in 2008, and he kept releasing into the following decade. The songs that stayed are the slow ones: Vas a Llorar, Guitarra, Por una Mentira, Perdido, Perdóname, No Tengo Suerte en el Amor, El Amor es Libre, He Tenido que Llorar and Guerra de Amor.","type":"text"}]},{"type":"paragraph","content":[{"text":"He also recorded within the wider revival of the genre, appearing on collections such as Bachata Típico and The Rough Guide to Bachata, which carried Dominican bachata to listeners who had come to it from outside. He died in a hospital in Orlando, Florida, on 28 January 2019.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'yoskar-sarante'), 4)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Yoskar Sarante Ventura, conocido como El Prabú, fue un cantante de bachata dominicano. Tenía una voz aguda y sin esfuerzo, capaz de sostener una frase sin forzarla, y durante un tramo de principios de siglo fue uno de los dos bachateros más escuchados del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Villas Agrícolas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1970 en Villas Agrícolas, barrio de Santo Domingo. De niño cantaba en parques y plazas públicas mientras su hermano mayor tocaba la guitarra, y lo que recogían iba al sustento de la casa. Concursó en los programas infantiles de canto de la televisión dominicana, entre ellos Mundo Infantil, y más adelante se inscribió en la Escuela de Música Iris del Valle, en Los Mina, que pagó trabajando en construcción.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las orquestas de merengue","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su carrera profesional empezó en el merengue y no en la bachata. Cantó con el Grupo Internacional Melao y, al graduarse de la escuela de música, pasó por las orquestas de Tomás Barrera, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"73691e65-206a-4c71-9b5f-8689f15b2584","displayText":"Cheche Abreu","occurrenceId":"f8f3ac2c-c5c3-4458-936b-0e1662cf14ff"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e5129444-0923-4e06-b77d-f82f14c02b7d","displayText":"Aramis Camilo","occurrenceId":"c7a5a8da-62ad-40a9-920d-7cfe4a6c8f97"}},{"text":" y Guancho Viloria. Los años delante de bandas de merengue le dieron el aire y la proyección que después lo distinguieron dentro de un género más lento.","type":"text"}]},{"type":"paragraph","content":[{"text":"Llora Alma Mía","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se pasó a la bachata y sacó El Prabú en 1994, el disco que le dio el nombre, seguido de Niña Sedienta en 1996 y Si Fuera Ella en 1998. El álbum que lo hizo fue Llora Alma Mía, de 2000: La Noche, No Te Detengas, Si Te Llego a Perder y el tema que le da título siguen siendo clásicos del género.","type":"text"}]},{"type":"paragraph","content":[{"text":"Detrás vinieron No Es Casualidad en 2002 y Viví en 2004. Entre esos discos, él y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e566c763-02c1-4f96-8a82-edbba9fc0bb2","displayText":"Elvis Martínez","occurrenceId":"f800fb22-df05-4b83-b2f2-2d5837b5b407"}},{"text":" eran los dos bachateros que más oía el país, justo cuando la bachata terminaba de pasar del margen al centro de la radio dominicana. Lo invitaron a Nueva York y cantó en el estadio de los Mets delante del alcalde de la ciudad, lo que le abrió Estados Unidos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los discos siguientes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Parada 37 salió en 2006 y Vuelve Vuelve en 2008, y siguió publicando en la década siguiente. Las canciones que quedaron son las lentas: Vas a Llorar, Guitarra, Por una Mentira, Perdido, Perdóname, No Tengo Suerte en el Amor, El Amor es Libre, He Tenido que Llorar y Guerra de Amor.","type":"text"}]},{"type":"paragraph","content":[{"text":"Grabó también dentro del rescate más amplio del género, apareciendo en recopilaciones como Bachata Típico y The Rough Guide to Bachata, que llevaron la bachata dominicana a oyentes que llegaron a ella desde afuera. Murió en un hospital de Orlando, Florida, el 28 de enero de 2019.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'yoskar-sarante'), 3)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante') AND locale = 'en'), 'af0b240c-234b-4214-ab00-2d41575ba01d', 'artist', '73691e65-206a-4c71-9b5f-8689f15b2584');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante') AND locale = 'en'), 'c9aaff5f-8de7-40f2-9bf3-1effe4ae92fa', 'artist', 'e566c763-02c1-4f96-8a82-edbba9fc0bb2');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante') AND locale = 'en'), 'd8487513-f171-4f98-8f66-6a3bb8dccee5', 'artist', 'e5129444-0923-4e06-b77d-f82f14c02b7d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante') AND locale = 'es'), 'c7a5a8da-62ad-40a9-920d-7cfe4a6c8f97', 'artist', 'e5129444-0923-4e06-b77d-f82f14c02b7d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante') AND locale = 'es'), 'f800fb22-df05-4b83-b2f2-2d5837b5b407', 'artist', 'e566c763-02c1-4f96-8a82-edbba9fc0bb2');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante') AND locale = 'es'), 'f8f3ac2c-c5c3-4458-936b-0e1662cf14ff', 'artist', '73691e65-206a-4c71-9b5f-8689f15b2584');

COMMIT;
