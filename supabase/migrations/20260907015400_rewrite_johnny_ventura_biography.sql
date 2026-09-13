BEGIN;

-- Rewrite the catalogue entry for Johnny Ventura.
--
-- Johnny Ventura. PRIMERA de las 235 fichas que solo tenían inglés, y encabeza
-- el orden de relevancia por mucho: dieciséis premios, cuarenta y cuatro discos
-- a su nombre y CINCUENTA Y SIETE biografías del catálogo que lo citan.
--
-- NO ES UNA TRADUCCIÓN, Y NO PODÍA SERLO. El texto inglés que había es de un
-- lote de mayo de 2026: cuatro párrafos, sin secciones, sin un solo título de
-- canción, sin un solo disco, sin más fechas que 1940 y 2021, y con
-- afirmaciones que no se pueden comprobar. Para el hombre más documentado del
-- merengue dominicano. Se reescriben LOS DOS IDIOMAS.
--
-- LO QUE SE QUITA DEL TEXTO VIEJO POR NO PODER SOSTENERLO: decía que tuvo
-- amistades y colaboraciones con Celia Cruz y Johnny Pacheco. Wikipedia no lo
-- menciona y no encontré fuente. El enlace a johnny-pacheco que existía en el
-- documento inglés SE PIERDE con esta reescritura, y lo digo expresamente para
-- que no parezca un descuido: prefiero perder un enlace a sostener una amistad
-- que no puedo documentar. Si aparece la fuente, se repone.
--
-- DOS ERRORES DE LA FILA QUE SE CORRIGEN:
--
--   aliases guardaba 'El Combo Show'. ESO NO ES UN ALIAS SUYO, ES SU ORQUESTA.
--   Es exactamente la confusión entre persona y agrupación que el editor marcó
--   como trabajo pendiente, aquí metida dentro del campo de apodos. Se quita.
--   La orquesta merece ficha propia y va a la lista.
--
--   aliases guardaba también 'Juan de Dios Ventura Soriano', que es su nombre
--   legal y ya está desglosado en first_name, middle_name, last_name y
--   second_last_name. Un alias es un nombre alternativo, no una copia del
--   nombre real. Se quita.
--
-- Quedan los apodos de verdad, que son varios y todos documentados: El Caballo
-- Mayor, El Padre del Merengue Moderno, El Merenguero del Siglo y El Señor del
-- Merengue.
--
-- SE LLENA instruments, QUE ESTABA VACÍO: voz y güira. Lo segundo no es adorno:
-- Wikipedia precisa que en la Super Orquesta San José entró como vocalista Y
-- GÜIRERO. NOTA para la limpieza de acentos: en el catálogo conviven 'güira'
-- (4 usos) y 'guira' (1), igual que 'voice' (121) y 'vocals' (2). Uso las
-- formas mayoritarias.
--
-- LA POLÍTICA SÍ ENTRA AQUÍ, y cambio el criterio a propósito. Con Yaqui Núñez
-- del Risco, Félix D'Oleo y Ramón Leonardo dejé fuera candidaturas que no
-- prosperaron, porque no aportaban nada musical. Ventura FUE DIPUTADO OCHO AÑOS
-- Y ALCALDE DE SANTO DOMINGO CUATRO. No es una anécdota electoral: es una
-- segunda carrera que ocupó doce años de su vida pública. Omitirla daría una
-- imagen falsa. Se cuenta como hecho, sin entrar en partidos ni alineamientos.
--
-- SE DEJA FUERA: matrimonio, ocho hijos, la boda de su hija, los rumores sobre
-- su salud que él mismo desmintió y litigó, la causa de la muerte y su
-- conversión religiosa de 2008. Todo eso es vida privada y parte además lo
-- rechazaría la guarda de mk.cjs.
--
-- EL DETALLE MÁS BONITO Y MENOS CONOCIDO: adoptó el nombre artístico "Johnny
-- Ventura" PARA NO CONFUNDIRSE CON JUAN DE DIOS VENTURA SIMÓ, el piloto
-- antitrujillista del movimiento del 14 de junio de 1959. Su nombre de pila era
-- idéntico. Va en la ficha.
--
-- CUATRO ENLACES, TODOS DOCUMENTADOS COMO MÚSICOS DE SU ORQUESTA O DE LAS QUE
-- COMPARTIÓ: luisito-marti, fausto-rey y anthony-rios pasaron por El Combo
-- Show; vinicio-franco coincidió con él en la Super Orquesta San José.
--
-- SUS DIECISÉIS PREMIOS YA ESTÁN REGISTRADOS y no hace falta migración aparte.
--
-- FUENTES: Wikipedia en español, extensa y con infobox de cargos públicos con
-- fechas exactas. Los premios ya guardados en la base corroboran el Grammy
-- Latino de 2004, el de Excelencia de 2006, el Salón de la Fama de 1999 y el
-- Pabellón de Compositores de 2022.
--
-- NOMBRES NUEVOS PARA LA LISTA: El Combo Show como agrupación; Papa Molina;
-- Niní Cáfaro; Grecia Aquino; Luis Pérez y su Combo Caribe; Donald Wild;
-- Carmen Severino. NO ENTRA Ángel Guinea, empresario cubano.
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
       name = 'Johnny Ventura',
       sort_name = 'Ventura Soriano, Juan de Dios',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1940-03-08',
       birth_year = 1940,
       date_of_death = '2021-07-28',
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = 'Juan',
       middle_name = 'de Dios',
       last_name = 'Ventura',
       second_last_name = 'Soriano',
       stage_name = 'Johnny Ventura',
       aliases = ARRAY['El Caballo Mayor', 'El Padre del Merengue Moderno', 'El Merenguero del Siglo', 'El Señor del Merengue']::text[],
       occupations = '["bandleader","composer"]'::jsonb,
       instruments = ARRAY['voice', 'güira']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@JohnnyVenturaOficial',
       facebook = 'JohnnyVenturaOficial',
       instagram = 'johnnyventuraoficial',
       disambiguation = 'Singer and bandleader known as El Caballo Mayor; founded El Combo Show and later served as mayor of Santo Domingo',
       bio_en = 'Juan de Dios Ventura Soriano, known as Johnny Ventura and called El Caballo Mayor, was a Dominican singer, bandleader and composer, and the central figure in the modernisation of merengue. He recorded more than a hundred productions, more than any other Dominican artist, and after four decades on stage he served eight years as a deputy and four as mayor of Santo Domingo.

**The name**

He was born in Santo Domingo in 1940 and wanted to be an architect, but there was no money for university. He enrolled instead in a commercial secretarial course, and it was there, pushed by two classmates who took him to an amateur radio programme under false pretences, that he sang in public for the first time and won. That was in June 1956. He went on to study singing and broadcasting at the school run by La Voz Dominicana, graduating as a professional announcer.

The stage name was a practical decision. His given name was identical to that of Juan de Dios Ventura Simó, the pilot who took part in the anti-Trujillo landing of June 1959, and he adopted Johnny Ventura to keep the two apart.

**The orchestras**

He passed through several bands before leading one. He sang with the group of the percussionist Donald Wild and with the orchestra Su Majestad, and in 1962 joined the Combo Caribe of Luis Pérez, with which he made his first recordings: La Agarradera, by Pérez, and Cuidado con el Cuabero, which he wrote himself. His first twelve-song album came out the same year.

In 1963 the bandleader Papa Molina brought him into the Super Orquesta San José, where he worked as singer and güira player alongside Vinicio Franco and other figures of the period.

**El Combo Show**

In 1964, urged on by the Cuban impresario Ángel Guinea, he formed the band that changed the genre. Merengue at the time belonged to large orchestras; he replaced them with a smaller group that could move faster, rehearse choreography and treat the concert as a spectacle, which is what the name says: a combo, and a show.

The sound changed with the format. He brought saxophones, trumpets, piano, drums, timbales and electronic effects into merengue, and took elements from other rhythms without losing the shape of the thing. The band was also a school: Luisito Martí, Fausto Rey and Anthony Ríos all passed through it. An American trade magazine named it combo of the year on nine occasions.

**The records**

The first albums under his own name appeared in 1965: La Coquetona, La Resbalosa and El Turún Tun Tun. Two years later La Muerte de Martín and Ah No, Yo No Sé No brought the Combo Show its first gold record.

What followed is the largest catalogue any Dominican artist has built: more than a hundred productions, twenty-eight of them certified gold and two platinum. He wrote most of what he sang and arranged most of what he recorded, which is unusual for a performer of that reach.

**Abroad**

He was crowned king of Miami’s Calle Ocho festival in 1987, won four Congos de Oro at the Barranquilla carnival, and was the first Dominican to take the Antorcha de Plata at Viña del Mar, an award decided by the audience. In 1977 he became the first Dominican artist invited to the inauguration of a president of the United States.

**Public office**

He qualified as a lawyer, graduating summa cum laude, and spent more than four decades in political life. He sat in the chamber of deputies for Santo Domingo from 1990 to 1998 and served as mayor of the city from 1998 to 2002. He stood for mayor again in 2020 and came third.

**The names he was given**

The country gave him more titles than any other performer: father of modern merengue, the merengue man of the century, the joy of the nation, and above all El Caballo Mayor. He died in Santiago de los Caballeros in July 2021, at eighty-one.',
       bio_es = 'Juan de Dios Ventura Soriano, conocido como Johnny Ventura y llamado El Caballo Mayor, fue un cantante, director de orquesta y compositor dominicano, y la figura central de la modernización del merengue. Grabó más de cien producciones, más que ningún otro artista dominicano, y después de cuatro décadas de tarima fue ocho años diputado y cuatro alcalde de Santo Domingo.

**El nombre**

Nació en Santo Domingo en 1940 y quiso ser arquitecto, pero no había dinero para la universidad. Se inscribió entonces en un secretariado comercial, y fue allí, empujado por dos compañeros de aula que lo llevaron engañado a un programa de aficionados, donde cantó en público por primera vez y ganó. Ocurrió en junio de 1956. Después estudió canto y locución en la escuela de La Voz Dominicana, de donde egresó como profesional del micrófono.

El nombre artístico fue una decisión práctica. Se llamaba igual que Juan de Dios Ventura Simó, el piloto que participó en la expedición antitrujillista de junio de 1959, y adoptó Johnny Ventura para que no se confundieran.

**Las orquestas**

Pasó por varias agrupaciones antes de dirigir una. Cantó con el grupo del percusionista Donald Wild y con la orquesta Su Majestad, y en 1962 entró al Combo Caribe de Luis Pérez, con el que hizo sus primeras grabaciones: La Agarradera, de Pérez, y Cuidado con el Cuabero, de su propia autoría. Ese mismo año salió su primer álbum de doce canciones.

En 1963 el director Papa Molina lo integró a la Super Orquesta San José, donde trabajó como cantante y güirero junto a Vinicio Franco y otras figuras de la época.

**El Combo Show**

En 1964, animado por el empresario cubano Ángel Guinea, formó la agrupación que le cambió la cara al género. El merengue de entonces era de orquestas grandes; él las sustituyó por un grupo más pequeño, capaz de moverse más rápido, de ensayar coreografía y de tratar el concierto como espectáculo, que es justo lo que dice el nombre: un combo, y un show.

Con el formato cambió el sonido. Metió al merengue saxofones, trompetas, piano, tambores, timbales y efectos electrónicos, y tomó elementos de otros ritmos sin perderle la forma. La banda fue además una escuela: por ella pasaron Luisito Martí, Fausto Rey y Anthony Ríos. Una revista especializada estadounidense la declaró combo del año en nueve ocasiones.

**Los discos**

Los primeros álbumes a su nombre aparecieron en 1965: La Coquetona, La Resbalosa y El Turún Tun Tun. Dos años después, La Muerte de Martín y Ah No, Yo No Sé No le dieron al Combo Show su primer disco de oro.

Lo que vino después es el catálogo más grande que ha armado un artista dominicano: más de cien producciones, veintiocho de ellas certificadas de oro y dos de platino. Escribió la mayor parte de lo que cantó y arregló la mayor parte de lo que grabó, cosa poco común en un intérprete de ese alcance.

**Afuera**

Fue coronado rey del festival de la Calle Ocho de Miami en 1987, ganó cuatro Congos de Oro en el carnaval de Barranquilla, y fue el primer dominicano en llevarse la Antorcha de Plata de Viña del Mar, que la decide el público. En 1977 se convirtió en el primer artista dominicano invitado a la toma de posesión de un presidente de Estados Unidos.

**El cargo público**

Se hizo abogado, graduado summa cum laude, y pasó más de cuatro décadas en la vida política. Fue diputado por Santo Domingo entre 1990 y 1998 y alcalde de la ciudad entre 1998 y 2002. Volvió a aspirar a la alcaldía en 2020 y quedó tercero.

**Los nombres que le pusieron**

El país le puso más títulos que a ningún otro intérprete: padre del merengue moderno, el merenguero del siglo, la alegría del país, y por encima de todos El Caballo Mayor. Murió en Santiago de los Caballeros en julio de 2021, a los ochenta y un años.',
       updated_at = now()
 WHERE slug = 'johnny-ventura';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-ventura')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-ventura')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan de Dios Ventura Soriano, known as Johnny Ventura and called El Caballo Mayor, was a Dominican singer, bandleader and composer, and the central figure in the modernisation of merengue. He recorded more than a hundred productions, more than any other Dominican artist, and after four decades on stage he served eight years as a deputy and four as mayor of Santo Domingo.","type":"text"}]},{"type":"paragraph","content":[{"text":"The name","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Santo Domingo in 1940 and wanted to be an architect, but there was no money for university. He enrolled instead in a commercial secretarial course, and it was there, pushed by two classmates who took him to an amateur radio programme under false pretences, that he sang in public for the first time and won. That was in June 1956. He went on to study singing and broadcasting at the school run by La Voz Dominicana, graduating as a professional announcer.","type":"text"}]},{"type":"paragraph","content":[{"text":"The stage name was a practical decision. His given name was identical to that of Juan de Dios Ventura Simó, the pilot who took part in the anti-Trujillo landing of June 1959, and he adopted Johnny Ventura to keep the two apart.","type":"text"}]},{"type":"paragraph","content":[{"text":"The orchestras","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He passed through several bands before leading one. He sang with the group of the percussionist Donald Wild and with the orchestra Su Majestad, and in 1962 joined the Combo Caribe of Luis Pérez, with which he made his first recordings: La Agarradera, by Pérez, and Cuidado con el Cuabero, which he wrote himself. His first twelve-song album came out the same year.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 1963 the bandleader Papa Molina brought him into the Super Orquesta San José, where he worked as singer and güira player alongside ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f625be23-cfa4-43fe-8bb5-0879b2fa492f","displayText":"Vinicio Franco","occurrenceId":"136f6640-0c0d-4c2c-b835-c9de15e92a44"}},{"text":" and other figures of the period.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Combo Show","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1964, urged on by the Cuban impresario Ángel Guinea, he formed the band that changed the genre. Merengue at the time belonged to large orchestras; he replaced them with a smaller group that could move faster, rehearse choreography and treat the concert as a spectacle, which is what the name says: a combo, and a show.","type":"text"}]},{"type":"paragraph","content":[{"text":"The sound changed with the format. He brought saxophones, trumpets, piano, drums, timbales and electronic effects into merengue, and took elements from other rhythms without losing the shape of the thing. The band was also a school: ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bd631179-2de1-4db3-809d-a896b591ca1d","displayText":"Luisito Martí","occurrenceId":"3a4d0191-50fd-4c78-9894-9d16bd2d36a6"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"60b0cfd0-b572-4d0f-a913-bbeb1aa734c6","displayText":"Fausto Rey","occurrenceId":"52170809-7c52-4c7f-9bc6-3340d40981d2"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"081c1484-bf1c-4b11-ba01-d68446b7b111","displayText":"Anthony Ríos","occurrenceId":"62ce40b2-f631-47c2-8472-9a6c7761ac19"}},{"text":" all passed through it. An American trade magazine named it combo of the year on nine occasions.","type":"text"}]},{"type":"paragraph","content":[{"text":"The records","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The first albums under his own name appeared in 1965: La Coquetona, La Resbalosa and El Turún Tun Tun. Two years later La Muerte de Martín and Ah No, Yo No Sé No brought the Combo Show its first gold record.","type":"text"}]},{"type":"paragraph","content":[{"text":"What followed is the largest catalogue any Dominican artist has built: more than a hundred productions, twenty-eight of them certified gold and two platinum. He wrote most of what he sang and arranged most of what he recorded, which is unusual for a performer of that reach.","type":"text"}]},{"type":"paragraph","content":[{"text":"Abroad","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was crowned king of Miami’s Calle Ocho festival in 1987, won four Congos de Oro at the Barranquilla carnival, and was the first Dominican to take the Antorcha de Plata at Viña del Mar, an award decided by the audience. In 1977 he became the first Dominican artist invited to the inauguration of a president of the United States.","type":"text"}]},{"type":"paragraph","content":[{"text":"Public office","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He qualified as a lawyer, graduating summa cum laude, and spent more than four decades in political life. He sat in the chamber of deputies for Santo Domingo from 1990 to 1998 and served as mayor of the city from 1998 to 2002. He stood for mayor again in 2020 and came third.","type":"text"}]},{"type":"paragraph","content":[{"text":"The names he was given","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The country gave him more titles than any other performer: father of modern merengue, the merengue man of the century, the joy of the nation, and above all El Caballo Mayor. He died in Santiago de los Caballeros in July 2021, at eighty-one.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'johnny-ventura'), 3)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan de Dios Ventura Soriano, conocido como Johnny Ventura y llamado El Caballo Mayor, fue un cantante, director de orquesta y compositor dominicano, y la figura central de la modernización del merengue. Grabó más de cien producciones, más que ningún otro artista dominicano, y después de cuatro décadas de tarima fue ocho años diputado y cuatro alcalde de Santo Domingo.","type":"text"}]},{"type":"paragraph","content":[{"text":"El nombre","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santo Domingo en 1940 y quiso ser arquitecto, pero no había dinero para la universidad. Se inscribió entonces en un secretariado comercial, y fue allí, empujado por dos compañeros de aula que lo llevaron engañado a un programa de aficionados, donde cantó en público por primera vez y ganó. Ocurrió en junio de 1956. Después estudió canto y locución en la escuela de La Voz Dominicana, de donde egresó como profesional del micrófono.","type":"text"}]},{"type":"paragraph","content":[{"text":"El nombre artístico fue una decisión práctica. Se llamaba igual que Juan de Dios Ventura Simó, el piloto que participó en la expedición antitrujillista de junio de 1959, y adoptó Johnny Ventura para que no se confundieran.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las orquestas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Pasó por varias agrupaciones antes de dirigir una. Cantó con el grupo del percusionista Donald Wild y con la orquesta Su Majestad, y en 1962 entró al Combo Caribe de Luis Pérez, con el que hizo sus primeras grabaciones: La Agarradera, de Pérez, y Cuidado con el Cuabero, de su propia autoría. Ese mismo año salió su primer álbum de doce canciones.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 1963 el director Papa Molina lo integró a la Super Orquesta San José, donde trabajó como cantante y güirero junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f625be23-cfa4-43fe-8bb5-0879b2fa492f","displayText":"Vinicio Franco","occurrenceId":"bc22cd51-8492-4f9f-a5d6-827e5d83d419"}},{"text":" y otras figuras de la época.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Combo Show","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1964, animado por el empresario cubano Ángel Guinea, formó la agrupación que le cambió la cara al género. El merengue de entonces era de orquestas grandes; él las sustituyó por un grupo más pequeño, capaz de moverse más rápido, de ensayar coreografía y de tratar el concierto como espectáculo, que es justo lo que dice el nombre: un combo, y un show.","type":"text"}]},{"type":"paragraph","content":[{"text":"Con el formato cambió el sonido. Metió al merengue saxofones, trompetas, piano, tambores, timbales y efectos electrónicos, y tomó elementos de otros ritmos sin perderle la forma. La banda fue además una escuela: por ella pasaron ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bd631179-2de1-4db3-809d-a896b591ca1d","displayText":"Luisito Martí","occurrenceId":"e710c37e-49de-497c-8372-9b94ef7895de"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"60b0cfd0-b572-4d0f-a913-bbeb1aa734c6","displayText":"Fausto Rey","occurrenceId":"9802212e-59ac-4909-8e7e-6277382cfff9"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"081c1484-bf1c-4b11-ba01-d68446b7b111","displayText":"Anthony Ríos","occurrenceId":"ef8926d8-cf2d-42ea-ad1e-9827abb3c4ce"}},{"text":". Una revista especializada estadounidense la declaró combo del año en nueve ocasiones.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los discos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Los primeros álbumes a su nombre aparecieron en 1965: La Coquetona, La Resbalosa y El Turún Tun Tun. Dos años después, La Muerte de Martín y Ah No, Yo No Sé No le dieron al Combo Show su primer disco de oro.","type":"text"}]},{"type":"paragraph","content":[{"text":"Lo que vino después es el catálogo más grande que ha armado un artista dominicano: más de cien producciones, veintiocho de ellas certificadas de oro y dos de platino. Escribió la mayor parte de lo que cantó y arregló la mayor parte de lo que grabó, cosa poco común en un intérprete de ese alcance.","type":"text"}]},{"type":"paragraph","content":[{"text":"Afuera","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Fue coronado rey del festival de la Calle Ocho de Miami en 1987, ganó cuatro Congos de Oro en el carnaval de Barranquilla, y fue el primer dominicano en llevarse la Antorcha de Plata de Viña del Mar, que la decide el público. En 1977 se convirtió en el primer artista dominicano invitado a la toma de posesión de un presidente de Estados Unidos.","type":"text"}]},{"type":"paragraph","content":[{"text":"El cargo público","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se hizo abogado, graduado summa cum laude, y pasó más de cuatro décadas en la vida política. Fue diputado por Santo Domingo entre 1990 y 1998 y alcalde de la ciudad entre 1998 y 2002. Volvió a aspirar a la alcaldía en 2020 y quedó tercero.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los nombres que le pusieron","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El país le puso más títulos que a ningún otro intérprete: padre del merengue moderno, el merenguero del siglo, la alegría del país, y por encima de todos El Caballo Mayor. Murió en Santiago de los Caballeros en julio de 2021, a los ochenta y un años.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'johnny-ventura'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-ventura') AND locale = 'en'), '136f6640-0c0d-4c2c-b835-c9de15e92a44', 'artist', 'f625be23-cfa4-43fe-8bb5-0879b2fa492f');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-ventura') AND locale = 'en'), '3a4d0191-50fd-4c78-9894-9d16bd2d36a6', 'artist', 'bd631179-2de1-4db3-809d-a896b591ca1d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-ventura') AND locale = 'en'), '52170809-7c52-4c7f-9bc6-3340d40981d2', 'artist', '60b0cfd0-b572-4d0f-a913-bbeb1aa734c6');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-ventura') AND locale = 'en'), '62ce40b2-f631-47c2-8472-9a6c7761ac19', 'artist', '081c1484-bf1c-4b11-ba01-d68446b7b111');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-ventura') AND locale = 'es'), '9802212e-59ac-4909-8e7e-6277382cfff9', 'artist', '60b0cfd0-b572-4d0f-a913-bbeb1aa734c6');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-ventura') AND locale = 'es'), 'bc22cd51-8492-4f9f-a5d6-827e5d83d419', 'artist', 'f625be23-cfa4-43fe-8bb5-0879b2fa492f');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-ventura') AND locale = 'es'), 'e710c37e-49de-497c-8372-9b94ef7895de', 'artist', 'bd631179-2de1-4db3-809d-a896b591ca1d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-ventura') AND locale = 'es'), 'ef8926d8-cf2d-42ea-ad1e-9827abb3c4ce', 'artist', '081c1484-bf1c-4b11-ba01-d68446b7b111');

COMMIT;
