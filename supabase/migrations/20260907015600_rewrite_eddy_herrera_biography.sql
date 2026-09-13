BEGIN;

-- Rewrite the catalogue entry for Eddy Herrera.
--
-- Eddy Herrera. SEGUNDA de las 235 del lote de mayo, por orden de relevancia:
-- quince premios, ochenta y dos discos a su nombre y catorce biografías que lo
-- citan.
--
-- SE REESCRIBEN LOS DOS IDIOMAS. El inglés que había eran tres párrafos sin
-- secciones, con dos títulos de canción y NI UN SOLO PREMIO MENCIONADO, cuando
-- la base ya le tenía registrados CUATRO LATIN GRAMMY y cuatro Congos de Oro.
-- Uno de los dos títulos que citaba, "Amor a Primera Vista", no aparece en
-- ninguna fuente; su álbum premiado se llama "Amor de Locos".
--
-- TRES ERRORES DE LA FILA QUE SE CORRIGEN:
--
--   aliases guardaba 'El Galan del Merengue', SIN TILDE. Es "El Galán del
--   Merengue". Otro acento perdido, de la misma familia que los que limpiamos
--   en premios y lugares.
--
--   aliases guardaba también 'Eduardo Herrera', que es su nombre real y ya está
--   en first_name y last_name. Copia, no alias. Se quita.
--
--   middle_name estaba vacío. Su nombre de nacimiento es EDUARDO JOSÉ Herrera
--   de los Ríos, según Wikipedia. Se completa, y con él el sort_name.
--
-- CONFLICTO DE AÑO QUE NO RESUELVO Y QUE REPORTO. El encabezado de Wikipedia
-- dice 30 de abril de 1965 y el cuerpo del mismo artículo dice 30 de abril de
-- 1964. La fila guarda 1964. Se queda 1964, que es lo que coincide entre la
-- fila y el cuerpo del artículo; el encabezado es el que va solo.
--
-- CUATRO ENLACES, Y UNO CIERRA UN CÍRCULO:
--
--   wilfrido-vargas -- fue cantante de su orquesta entre 1984 y 1990, que es de
--   donde sale todo lo demás.
--
--   martin-de-leon -- ESCRIBIÓ "NUESTRO AMOR" Y "COMO LLORA MI ALMA". Le acabo
--   de hacer la ficha, y ahí decía que su sociedad larga era con Herrera. Ahora
--   el catálogo lo muestra por los dos lados: el autor y el intérprete.
--
--   mozart-la-para y vakero -- colaboraciones de 2015 y del álbum de 2017.
--
-- OJO CON EL NOMBRE DE MOZART: la fila se llama "Mozart la Para", con LA EN
-- MINÚSCULA, y el displayText tiene que decir eso exacto o salta el hallazgo de
-- nombre divergente. La prensa suele escribirlo "Mozart La Para". Queda anotado
-- como duda de grafía, no se toca aquí.
--
-- LOS PREMIOS YA ESTÁN REGISTRADOS y son mejores que la prosa vieja: cuatro
-- Latin Grammy al mejor álbum de merengue/bachata (Amor de Locos, Ahora,
-- Agradecido Live! y Novato Apostador), cuatro Congos de Oro, el Casandra a
-- Orquesta Revelación de 1990 y los de Merengue del Año de 2000 y 2001. No hace
-- falta migración de premios.
--
-- SE DEJA FUERA: su padre por nombre, y la oposición de su madre a que dejara
-- arquitectura. El HECHO de que abandonó la carrera sí entra, porque explica
-- cómo llegó a la música, igual que hice con Johnny Ventura y con Leonardo
-- Paniagua.
--
-- EL BÉISBOL ENTRA. Llegó a categoría amateur y se proyectaba a ligas menores
-- en Estados Unidos. No es anécdota: es la otra vida que descartó para cantar.
--
-- INSTRUMENTS SOLO VOZ. Su padre le compró una guitarra a los nueve años y tomó
-- clases unos meses, pero las abandonó al sentir que ya podía acompañarse. Eso
-- va en la prosa; el campo afirma solo lo que sostiene su oficio.
--
-- FUENTES: Wikipedia en español, muy detallada aunque marcada como necesitada
-- de referencias. La tabla de premios de la propia base, que corrobora años y
-- obras.
--
-- NOMBRES NUEVOS PARA LA LISTA: Omar Enrique, que colabora en "A Otro Nivel"
-- (venezolano, NO ENTRA). Sí entran los sellos MP Records y J&N Records si
-- alguna vez se registran discográficas.
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
       name = 'Eddy Herrera',
       sort_name = 'Herrera de los Ríos, Eduardo José',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1964-04-30',
       birth_year = 1964,
       date_of_death = NULL,
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Eduardo',
       middle_name = 'José',
       last_name = 'Herrera',
       second_last_name = 'de los Ríos',
       stage_name = 'Eddy Herrera',
       aliases = ARRAY['El Galán del Merengue']::text[],
       occupations = '["bandleader","composer"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = 'https://eddyherrera.com',
       youtube = '@EddyHerreraOficial',
       facebook = 'EddyHerreraOficial',
       instagram = 'eddy_herrera',
       disambiguation = 'Merengue singer known as El Galán del Merengue; four-time Latin Grammy winner',
       bio_en = 'Eduardo José Herrera de los Ríos, known as Eddy Herrera and billed as El Galán del Merengue, is a Dominican merengue singer and bandleader. He came up as a vocalist in one of the genre’s biggest orchestras, went solo at the start of the nineties, and has won four Latin Grammy awards for best merengue or bachata album.

**Santiago**

He was born in Santiago de los Caballeros in 1964. His father gave him a guitar for his ninth birthday and hired a teacher, but he dropped the lessons after a few months, once he could accompany himself well enough to sing the ballads and boleros he liked. The singers he grew up copying were Nino Bravo, José José, José Luis Rodríguez and Javier Solís, which is where the romantic register of his merengue comes from.

He entered the Santiago voice festival at fifteen and came second; at seventeen he entered again and won. In parallel he played baseball seriously enough to reach amateur level and to be considered a prospect for the minor leagues in the United States, and he enrolled in architecture at the Pontificia Universidad Católica Madre y Maestra.

**The orchestra**

Two and a half years into the degree he met Wilfrido Vargas, who asked him to join his orchestra as a singer. He had never sung merengue. He left the architecture course and the baseball behind and took the job, and three months later recorded El Jardinero, which became a hit well beyond the country. La Medicina, El Loco y La Luna and Mujer Tirana followed. He stayed with the band from 1984 to 1990, touring Central and South America, Europe, the Caribbean and the United States.

**Independiente**

He recorded his first solo album while serving out his last months with the orchestra, and released it under the title Independiente. No Puedo Más and La Vieron were the first singles. He made his official debut as a bandleader in July 1990, at a club in his home city, and the record took him to the Casandra awards, where his orchestra was named revelation of the year.

More than a hundred and fifty dances followed in that first year. Mi More came next, and then Ámame, which carried Carolina — the song that moved him out of the domestic market and into Venezuela, Panama, Central America, the Dutch Caribbean and the United States. He signed an exclusive five-year contract with a new label just before its release.

**Nuestro Amor**

Lluvia de Amor and Los Hombres Calientes came next. The second of those carried Nuestro Amor, written by Martín de León, which became the biggest record of his career in Colombia and has stayed in circulation there since the middle of the nineties. The same writer gave him Como Llora Mi Alma.

**The merengues of the year**

Alma Gemela and Me Enamoré followed, and with the second came Demasiado Niña, which took the Casandra award for merengue of the year and brought him his first Latin Grammy nomination. Pégame Tu Vicio, released months later, won the same award the following year and is one of the records his name is most attached to.

Two years of work produced Atrevido, which carried Tú Eres Ajena — by his own account the biggest of all of them — along with Demasiado Romántica and Como Llora Mi Alma.

**The Latin Grammys**

The awards came in a long series rather than a burst. He won the Latin Grammy for best merengue or bachata album four times, for Amor de Locos, Ahora, Agradecido Live! and Novato Apostador, and took four Congos de Oro at the Barranquilla carnival across two decades.

**The collaborations**

He has kept recording with younger artists rather than only revisiting his catalogue. Tu Boquita, made with Mozart la Para, earned a nomination for merengue video of the year, and the album A Otro Nivel brought in Vakeró among other guests.',
       bio_es = 'Eduardo José Herrera de los Ríos, conocido como Eddy Herrera y anunciado como El Galán del Merengue, es un cantante y director de orquesta de merengue dominicano. Se formó como vocalista en una de las orquestas grandes del género, se independizó a principios de los noventa, y ha ganado cuatro premios Latin Grammy al mejor álbum de merengue o bachata.

**Santiago**

Nació en Santiago de los Caballeros en 1964. Su padre le regaló una guitarra al cumplir nueve años y le contrató un profesor, pero dejó las clases a los pocos meses, cuando sintió que ya podía acompañarse solo para cantar las baladas y los boleros que le gustaban. Los cantantes que imitaba de muchacho eran Nino Bravo, José José, José Luis Rodríguez y Javier Solís, y de ahí viene el registro romántico de su merengue.

Se presentó al festival de la voz de Santiago a los quince años y quedó segundo; a los diecisiete volvió y ganó. En paralelo jugaba béisbol con suficiente seriedad como para llegar a categoría amateur y proyectarse a las ligas menores en Estados Unidos, y entró a estudiar arquitectura en la Pontificia Universidad Católica Madre y Maestra.

**La orquesta**

Llevaba dos años y medio de carrera cuando conoció a Wilfrido Vargas, que le pidió que entrara como cantante de su orquesta. Nunca había cantado merengue. Dejó la arquitectura y el béisbol y aceptó, y tres meses después grabó El Jardinero, que se convirtió en un éxito muy por encima de las fronteras del país. Detrás vinieron La Medicina, El Loco y La Luna y Mujer Tirana. Se mantuvo en la banda entre 1984 y 1990, recorriendo Centroamérica, Suramérica, Europa, el Caribe y Estados Unidos.

**Independiente**

Grabó su primer disco como solista mientras cumplía sus últimos meses con la orquesta, y lo publicó con el título Independiente. No Puedo Más y La Vieron fueron los primeros temas promocionados. Debutó oficialmente al frente de su propia agrupación en julio de 1990, en un local de su ciudad natal, y el disco lo llevó a los Premios Casandra, donde su orquesta fue nombrada revelación del año.

Ese primer año hizo más de ciento cincuenta bailes. Después vino Mi More, y luego Ámame, que traía Carolina: la canción que lo sacó del mercado dominicano y lo llevó a Venezuela, Panamá, Centroamérica, el Caribe holandés y Estados Unidos. Justo antes de lanzarla firmó un contrato exclusivo de cinco años con un sello nuevo.

**Nuestro Amor**

Siguieron Lluvia de Amor y Los Hombres Calientes. Este último traía Nuestro Amor, escrita por Martín de León, que se convirtió en el disco más grande de su carrera en Colombia y que sigue circulando allá desde mediados de los noventa. Del mismo autor es Como Llora Mi Alma.

**Los merengues del año**

Vinieron Alma Gemela y Me Enamoré, y con este último Demasiado Niña, que se llevó el Casandra al merengue del año y le dio su primera nominación al Latin Grammy. Pégame Tu Vicio, publicada meses después, ganó el mismo premio al año siguiente y es uno de los discos a los que su nombre queda más pegado.

Dos años de trabajo dieron Atrevido, que traía Tú Eres Ajena —según él mismo, el mayor de todos— junto a Demasiado Romántica y Como Llora Mi Alma.

**Los Latin Grammy**

Los premios le llegaron en serie larga y no de golpe. Ganó cuatro veces el Latin Grammy al mejor álbum de merengue o bachata, por Amor de Locos, Ahora, Agradecido Live! y Novato Apostador, y se llevó cuatro Congos de Oro del carnaval de Barranquilla a lo largo de dos décadas.

**Las colaboraciones**

Ha seguido grabando con artistas más jóvenes en vez de limitarse a revisitar su catálogo. Tu Boquita, hecha con Mozart la Para, le valió una nominación a video de merengue del año, y el álbum A Otro Nivel sumó a Vakeró entre otros invitados.',
       updated_at = now()
 WHERE slug = 'eddy-herrera';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eddy-herrera')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eddy-herrera')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Eduardo José Herrera de los Ríos, known as Eddy Herrera and billed as El Galán del Merengue, is a Dominican merengue singer and bandleader. He came up as a vocalist in one of the genre’s biggest orchestras, went solo at the start of the nineties, and has won four Latin Grammy awards for best merengue or bachata album.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santiago","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Santiago de los Caballeros in 1964. His father gave him a guitar for his ninth birthday and hired a teacher, but he dropped the lessons after a few months, once he could accompany himself well enough to sing the ballads and boleros he liked. The singers he grew up copying were Nino Bravo, José José, José Luis Rodríguez and Javier Solís, which is where the romantic register of his merengue comes from.","type":"text"}]},{"type":"paragraph","content":[{"text":"He entered the Santiago voice festival at fifteen and came second; at seventeen he entered again and won. In parallel he played baseball seriously enough to reach amateur level and to be considered a prospect for the minor leagues in the United States, and he enrolled in architecture at the Pontificia Universidad Católica Madre y Maestra.","type":"text"}]},{"type":"paragraph","content":[{"text":"The orchestra","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Two and a half years into the degree he met ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"113c662e-7ea7-43f6-b992-7f11380f557f"}},{"text":", who asked him to join his orchestra as a singer. He had never sung merengue. He left the architecture course and the baseball behind and took the job, and three months later recorded El Jardinero, which became a hit well beyond the country. La Medicina, El Loco y La Luna and Mujer Tirana followed. He stayed with the band from 1984 to 1990, touring Central and South America, Europe, the Caribbean and the United States.","type":"text"}]},{"type":"paragraph","content":[{"text":"Independiente","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He recorded his first solo album while serving out his last months with the orchestra, and released it under the title Independiente. No Puedo Más and La Vieron were the first singles. He made his official debut as a bandleader in July 1990, at a club in his home city, and the record took him to the Casandra awards, where his orchestra was named revelation of the year.","type":"text"}]},{"type":"paragraph","content":[{"text":"More than a hundred and fifty dances followed in that first year. Mi More came next, and then Ámame, which carried Carolina — the song that moved him out of the domestic market and into Venezuela, Panama, Central America, the Dutch Caribbean and the United States. He signed an exclusive five-year contract with a new label just before its release.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nuestro Amor","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Lluvia de Amor and Los Hombres Calientes came next. The second of those carried Nuestro Amor, written by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"990631fd-edfa-4a9a-8652-7e336d64010f","displayText":"Martín de León","occurrenceId":"f259691d-613b-49fb-8362-2764ab0f93d2"}},{"text":", which became the biggest record of his career in Colombia and has stayed in circulation there since the middle of the nineties. The same writer gave him Como Llora Mi Alma.","type":"text"}]},{"type":"paragraph","content":[{"text":"The merengues of the year","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Alma Gemela and Me Enamoré followed, and with the second came Demasiado Niña, which took the Casandra award for merengue of the year and brought him his first Latin Grammy nomination. Pégame Tu Vicio, released months later, won the same award the following year and is one of the records his name is most attached to.","type":"text"}]},{"type":"paragraph","content":[{"text":"Two years of work produced Atrevido, which carried Tú Eres Ajena — by his own account the biggest of all of them — along with Demasiado Romántica and Como Llora Mi Alma.","type":"text"}]},{"type":"paragraph","content":[{"text":"The Latin Grammys","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The awards came in a long series rather than a burst. He won the Latin Grammy for best merengue or bachata album four times, for Amor de Locos, Ahora, Agradecido Live! and Novato Apostador, and took four Congos de Oro at the Barranquilla carnival across two decades.","type":"text"}]},{"type":"paragraph","content":[{"text":"The collaborations","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He has kept recording with younger artists rather than only revisiting his catalogue. Tu Boquita, made with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fa9cc802-28ca-4695-b585-f75aa90a2b6c","displayText":"Mozart la Para","occurrenceId":"e14844d7-e0cd-430e-9c0a-6a84de537041"}},{"text":", earned a nomination for merengue video of the year, and the album A Otro Nivel brought in ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ec8ba439-3772-49ff-a218-05f5dc615763","displayText":"Vakeró","occurrenceId":"6899f78d-cb83-4269-ad52-bc951cb6a080"}},{"text":" among other guests.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'eddy-herrera'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Eduardo José Herrera de los Ríos, conocido como Eddy Herrera y anunciado como El Galán del Merengue, es un cantante y director de orquesta de merengue dominicano. Se formó como vocalista en una de las orquestas grandes del género, se independizó a principios de los noventa, y ha ganado cuatro premios Latin Grammy al mejor álbum de merengue o bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santiago","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santiago de los Caballeros en 1964. Su padre le regaló una guitarra al cumplir nueve años y le contrató un profesor, pero dejó las clases a los pocos meses, cuando sintió que ya podía acompañarse solo para cantar las baladas y los boleros que le gustaban. Los cantantes que imitaba de muchacho eran Nino Bravo, José José, José Luis Rodríguez y Javier Solís, y de ahí viene el registro romántico de su merengue.","type":"text"}]},{"type":"paragraph","content":[{"text":"Se presentó al festival de la voz de Santiago a los quince años y quedó segundo; a los diecisiete volvió y ganó. En paralelo jugaba béisbol con suficiente seriedad como para llegar a categoría amateur y proyectarse a las ligas menores en Estados Unidos, y entró a estudiar arquitectura en la Pontificia Universidad Católica Madre y Maestra.","type":"text"}]},{"type":"paragraph","content":[{"text":"La orquesta","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Llevaba dos años y medio de carrera cuando conoció a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"72a0aaaa-28f5-4091-bf9b-abcd7b51c53c"}},{"text":", que le pidió que entrara como cantante de su orquesta. Nunca había cantado merengue. Dejó la arquitectura y el béisbol y aceptó, y tres meses después grabó El Jardinero, que se convirtió en un éxito muy por encima de las fronteras del país. Detrás vinieron La Medicina, El Loco y La Luna y Mujer Tirana. Se mantuvo en la banda entre 1984 y 1990, recorriendo Centroamérica, Suramérica, Europa, el Caribe y Estados Unidos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Independiente","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Grabó su primer disco como solista mientras cumplía sus últimos meses con la orquesta, y lo publicó con el título Independiente. No Puedo Más y La Vieron fueron los primeros temas promocionados. Debutó oficialmente al frente de su propia agrupación en julio de 1990, en un local de su ciudad natal, y el disco lo llevó a los Premios Casandra, donde su orquesta fue nombrada revelación del año.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ese primer año hizo más de ciento cincuenta bailes. Después vino Mi More, y luego Ámame, que traía Carolina: la canción que lo sacó del mercado dominicano y lo llevó a Venezuela, Panamá, Centroamérica, el Caribe holandés y Estados Unidos. Justo antes de lanzarla firmó un contrato exclusivo de cinco años con un sello nuevo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nuestro Amor","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Siguieron Lluvia de Amor y Los Hombres Calientes. Este último traía Nuestro Amor, escrita por ","type":"text"},{"type":"artistReference","attrs":{"artistId":"990631fd-edfa-4a9a-8652-7e336d64010f","displayText":"Martín de León","occurrenceId":"5c499b36-9344-4288-8b11-4e100fa55c65"}},{"text":", que se convirtió en el disco más grande de su carrera en Colombia y que sigue circulando allá desde mediados de los noventa. Del mismo autor es Como Llora Mi Alma.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los merengues del año","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Vinieron Alma Gemela y Me Enamoré, y con este último Demasiado Niña, que se llevó el Casandra al merengue del año y le dio su primera nominación al Latin Grammy. Pégame Tu Vicio, publicada meses después, ganó el mismo premio al año siguiente y es uno de los discos a los que su nombre queda más pegado.","type":"text"}]},{"type":"paragraph","content":[{"text":"Dos años de trabajo dieron Atrevido, que traía Tú Eres Ajena —según él mismo, el mayor de todos— junto a Demasiado Romántica y Como Llora Mi Alma.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Latin Grammy","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Los premios le llegaron en serie larga y no de golpe. Ganó cuatro veces el Latin Grammy al mejor álbum de merengue o bachata, por Amor de Locos, Ahora, Agradecido Live! y Novato Apostador, y se llevó cuatro Congos de Oro del carnaval de Barranquilla a lo largo de dos décadas.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las colaboraciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Ha seguido grabando con artistas más jóvenes en vez de limitarse a revisitar su catálogo. Tu Boquita, hecha con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fa9cc802-28ca-4695-b585-f75aa90a2b6c","displayText":"Mozart la Para","occurrenceId":"7a3a8837-1071-479d-af8a-01c079f64aa8"}},{"text":", le valió una nominación a video de merengue del año, y el álbum A Otro Nivel sumó a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ec8ba439-3772-49ff-a218-05f5dc615763","displayText":"Vakeró","occurrenceId":"ffdafb3e-50e9-4c8f-afc1-53f0bd4cdc31"}},{"text":" entre otros invitados.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'eddy-herrera'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eddy-herrera') AND locale = 'en'), '113c662e-7ea7-43f6-b992-7f11380f557f', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eddy-herrera') AND locale = 'en'), '6899f78d-cb83-4269-ad52-bc951cb6a080', 'artist', 'ec8ba439-3772-49ff-a218-05f5dc615763');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eddy-herrera') AND locale = 'en'), 'e14844d7-e0cd-430e-9c0a-6a84de537041', 'artist', 'fa9cc802-28ca-4695-b585-f75aa90a2b6c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eddy-herrera') AND locale = 'en'), 'f259691d-613b-49fb-8362-2764ab0f93d2', 'artist', '990631fd-edfa-4a9a-8652-7e336d64010f');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eddy-herrera') AND locale = 'es'), '5c499b36-9344-4288-8b11-4e100fa55c65', 'artist', '990631fd-edfa-4a9a-8652-7e336d64010f');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eddy-herrera') AND locale = 'es'), '72a0aaaa-28f5-4091-bf9b-abcd7b51c53c', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eddy-herrera') AND locale = 'es'), '7a3a8837-1071-479d-af8a-01c079f64aa8', 'artist', 'fa9cc802-28ca-4695-b585-f75aa90a2b6c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eddy-herrera') AND locale = 'es'), 'ffdafb3e-50e9-4c8f-afc1-53f0bd4cdc31', 'artist', 'ec8ba439-3772-49ff-a218-05f5dc615763');

COMMIT;
