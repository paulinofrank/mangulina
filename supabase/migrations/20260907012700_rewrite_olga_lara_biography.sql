BEGIN;

-- Rewrite the catalogue entry for Olga Lara.
--
-- Olga Lara. Cuarta de las dieciséis fichas publicadas que estaban EN BLANCO, y
-- la de mayor peso hasta ahora: cantautora, con Soberano al Mérito, con dos
-- Casandra al Espectáculo del Año, con más de doscientas canciones firmadas, y
-- su página no decía nada.
--
-- TIENE SITIO OFICIAL PROPIO, olgalara.com, con biografía y galardones. Es la
-- mejor fuente para su relato y se usa, pero contrastada, porque en las fechas
-- de premios no coincide con Wikipedia (ver abajo).
--
-- LO QUE YA TENÍA LA FILA SE CONFIRMA Y NO SE TOCA: 16 de septiembre de 1953,
-- Azua, y el nombre completo Olga Francia Elena Lara D'Soto, que dan su propio
-- sitio, EcuRed y Last.fm. Wikipedia escribe "Lara Soto" sin apóstrofo en el
-- encabezado y "Lara D'Soto" en el cuerpo; se mantiene lo que ya estaba
-- guardado, que es la forma mayoritaria.
--
-- CONFLICTO DE AÑOS QUE NO RESUELVO Y QUE DEJO REPORTADO. Su sitio y Wikipedia
-- se contradicen en varios premios:
--
--   El Dorado, Cantante del Año -- su sitio: 1982, 1984 y 1985.
--                                  Wikipedia: 1981 y 1982.
--   Casandra, Cantante del Año  -- su sitio: 1985 y 1987.
--                                  Wikipedia: "Cantante más popular" en 1981.
--
-- NO SE GUARDA NINGUNO DE ESOS. Solo entran los tres en que las dos fuentes
-- coinciden o que verifiqué aparte. Un premio con el año cambiado es peor que
-- un premio ausente, porque el ausente se nota y el equivocado no.
--
-- ADEMÁS, EL DORADO, EL ÁNGEL, EL GORDO DEL AÑO Y MERENGUE DEL AÑO NO EXISTEN
-- como filas en la tabla awards. Crear cuatro entidades de premio nuevas es una
-- decisión de catálogo, no un efecto colateral de escribir una ficha, así que
-- queda propuesto y no hecho.
--
-- EL SOBERANO AL MÉRITO DE 2015 SÍ SE VERIFICÓ APARTE: La Crónica e
-- idominicanas cubren la ceremonia del 14 de abril de 2015, compartido con
-- Vickiana, y ella misma sacó por eso el recopilatorio de 35 éxitos.
--
-- EL HANDLE DE YOUTUBE ES LA TRAMPA DE ESTA FICHA. Su propio Instagram enlaza a
-- youtube.com/@OtraCosaOlgaLara, Y ESE DA 404. El canal vivo es
-- @olgalaraesotracosa, que comprobé: 50 videos, material de diciembre de 2025 y
-- las puestas en circulación de sus libros. Copiar el enlace que publica la
-- artista habría metido un handle roto en el catálogo.
--
-- INSTRUMENTS VA SOLO CON VOZ, aunque el Ministerio de Cultura y Wikipedia
-- digan que estudió solfeo, piano y guitarra. Estudiar un instrumento no es
-- tocarlo en público, y no encontré ninguna grabación ni foto suya tocando. La
-- formación va en la prosa, que es donde se puede decir con precisión; el campo
-- estructurado afirma solo lo seguro.
--
-- OCCUPATIONS: composer y writer. NO se inventa "poeta" ni "psicóloga" como
-- roles: el diccionario no los tiene y CLAUDE.md prohíbe introducir roles
-- nuevos de pasada. Las dos cosas se cuentan en la prosa. "writer" ya existe con
-- 18 usos y le cabe: tiene siete libros publicados.
--
-- GÉNERO, DECISIÓN DEL EDITOR: la fila dice ballads y no lo cambio. Pero
-- Wikipedia la clasifica ante todo como exponente de MERENGUE y balada, y sus
-- premios de los ochenta son de merengue ("Mi Vida", "Cualquiera se engaña").
-- Si se quiere mover a merengue, la línea es primary_genre en esta ficha.
--
-- OCHO ENLACES, TODOS CON RELACIÓN DOCUMENTADA: yaqui-nunez-del-risco (apoyó su
-- arranque en 1979), johnny-ventura (su sello Combo Records publicó el debut),
-- manuel-tejada y jorge-taveras (direcciones musicales de sus espectáculos),
-- fernando-villalona, las-chicas-del-can, belkis-concepcion (grabaron temas
-- suyos) y alex-matos (regrabó "Aprenderé" en salsa).
--
-- SE DEJA FUERA: que tiene dos hijos, el fallecimiento de su madre, y que se
-- retiró de los escenarios "para dedicar tiempo a su familia". Vida privada.
--
-- FUENTES: olgalara.com (biografía y galardones). Wikipedia en español, que
-- está bien referenciada. Ministerio de Cultura y Comisionado Dominicano de
-- Cultura para la formación musical. La Crónica e idominicanas para el Soberano
-- 2015. Diario Libre, 2 de septiembre de 2022, para el Senado. Su canal y su
-- Instagram para lo reciente.
--
-- NOMBRES NUEVOS PARA LA LISTA DE FALTANTES: Frank Natera (periodista que la
-- impulsa), Bienvenido Bustamante (maestro que la apoya), Charlie Mosquea
-- (autor de temas que ella grabó), Niní Cáfaro, Raúl Grisanti, Robert del
-- Castillo, Danny de León y Ambriorix Francisco (arreglistas), Armando Olivero
-- (dirección musical de "Cristal"), Vickiana (compartió el Soberano al Mérito
-- de 2015) y Alfio Lora. NO ENTRA Thalía, que es mexicana.
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
       name = 'Olga Lara',
       sort_name = 'Lara D''Soto, Olga Francia Elena',
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'ballads',
       date_of_birth = '1953-09-16',
       birth_year = 1953,
       date_of_death = NULL,
       birth_place = 'Azua',
       province = 'Azua',
       first_name = 'Olga',
       middle_name = 'Francia Elena',
       last_name = 'Lara',
       second_last_name = 'D''Soto',
       stage_name = 'Olga Lara',
       aliases = ARRAY[]::text[],
       occupations = '["composer","writer"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = 'https://olgalara.com',
       youtube = 'olgalaraesotracosa',
       facebook = NULL,
       instagram = 'olgalaraoficial',
       disambiguation = 'Singer-songwriter and poet from Azua; a leading Dominican solo voice of the eighties and early nineties',
       bio_en = 'Olga Francia Elena Lara D’Soto, known as Olga Lara, is a Dominican singer, songwriter and poet. She was among the country’s foremost solo voices between the early eighties and the mid-nineties, working across ballad, bolero and merengue, and she has written well over two hundred songs, many of them recorded by other artists.

**Azua**

She was born in Azua, in the south of the country, in 1953. She studied solfège, piano and guitar there, sang in the municipal choir and in her school’s tuna, and gave her first performances at school and church events.

**Television and the first record**

Her professional career began in 1979, encouraged by the journalist Frank Natera and supported by the musician Bienvenido Bustamante and the broadcaster Yaqui Núñez del Risco. She first appeared on El Show del Mediodía, and other television programmes followed.

Her debut album arrived in 1981 on Combo Records, the label of Johnny Ventura. Every song on it was her own, and it brought her a nomination as songwriter of the year — an unusual footing for a singer to start from.

**The great shows**

Much of her reputation rests on staged productions rather than on records alone. She debuted at the Palacio de Bellas Artes in 1982, and presented a programme at the Teatro Nacional under the musical direction of Manuel Tejada. Two years later she staged Mi Vida at Bellas Artes with Jorge Taveras directing the music.

In 1985 she took the concert Olga Lara es otra cosa through stadiums around the country. The title outlived the tour: in Dominican speech the phrase attached itself to her, and her name came to stand for something singular.

Her tribute to the poet Héctor J. Díaz, staged at Bellas Artes in 1987, won the Casandra award for production of the year. She left the stage in 1995 with Cristal, at the Teatro Nacional, which won the same award and was filmed for television.

**The songwriter**

Her catalogue as an author is larger than her catalogue as a performer. Among the artists who have recorded her songs are Fernando Villalona, Las Chicas del Can, Belkis Concepción and the Combo Show. Alex Matos remade her song Aprenderé as a salsa, and in 2024 the Mexican singer Thalía recorded an unreleased Lara composition as a bachata.

Her own best-known titles include Cualquiera Se Engaña, Mi Vida, Desconéctalo, Estrellita and Ladrón de Corazones. In the studio she worked with arrangers and musical directors including Manuel Tejada and Jorge Taveras, on her own material and on songs by other writers.

**Books and return**

She trained as a psychologist and has published as an author, beginning with a 1988 collection of fifty of her own lyrics and continuing with books of poetry and of psychology. She was named a distinguished daughter of Azua, received the Soberano al Mérito for her career, and was recognised by the Senate for her work in music, culture and psychology. She has kept composing, and now publishes new recordings, readings and book presentations through her own channel.',
       bio_es = 'Olga Francia Elena Lara D’Soto, conocida como Olga Lara, es una cantautora y poeta dominicana. Fue una de las voces solistas más importantes del país entre principios de los ochenta y mediados de los noventa, en un repertorio que recorre la balada, el bolero y el merengue, y ha escrito más de doscientas canciones, muchas de ellas grabadas por otros artistas.

**Azua**

Nació en Azua, al sur del país, en 1953. Allí estudió solfeo, piano y guitarra, cantó en el coro del ayuntamiento y en la tuna de su colegio, y dio sus primeras presentaciones en actos escolares y religiosos.

**La televisión y el primer disco**

Su carrera profesional empezó en 1979, impulsada por el periodista Frank Natera y apoyada por el músico Bienvenido Bustamante y el presentador Yaqui Núñez del Risco. Su primera aparición fue en El Show del Mediodía, y detrás vinieron otros espacios de televisión.

Su álbum debut salió en 1981 por Combo Records, el sello de Johnny Ventura. Todas las canciones eran suyas, y el disco le valió una nominación como compositora del año: un punto de partida poco frecuente para una cantante.

**Los grandes espectáculos**

Buena parte de su prestigio descansa en producciones de escenario y no solo en los discos. Debutó en el Palacio de Bellas Artes en 1982 y presentó un espectáculo en el Teatro Nacional bajo la dirección musical de Manuel Tejada. Dos años después montó Mi Vida en Bellas Artes, con Jorge Taveras en la dirección musical.

En 1985 llevó el concierto Olga Lara es otra cosa por estadios de todo el país. El título sobrevivió a la gira: en el habla dominicana la expresión quedó asociada a ella, y su nombre pasó a significar algo singular.

Su homenaje al poeta Héctor J. Díaz, montado en Bellas Artes en 1987, ganó el Premio Casandra al espectáculo del año. Se despidió de los escenarios en 1995 con Cristal, en el Teatro Nacional, que obtuvo el mismo galardón y fue grabado para televisión.

**La autora**

Su catálogo como autora es mayor que el suyo como intérprete. Entre quienes han grabado canciones suyas están Fernando Villalona, Las Chicas del Can, Belkis Concepción y el Combo Show. Alex Matos rehízo su canción Aprenderé en versión salsa, y en 2024 la cantante mexicana Thalía grabó en bachata un tema inédito de su autoría.

Entre sus títulos más conocidos están Cualquiera Se Engaña, Mi Vida, Desconéctalo, Estrellita y Ladrón de Corazones. En el estudio trabajó con arreglistas y directores musicales como Manuel Tejada y Jorge Taveras, sobre material propio y sobre canciones de otros autores.

**Los libros y el regreso**

Se formó como psicóloga y ha publicado como escritora, empezando en 1988 con una recopilación de cincuenta letras suyas y siguiendo con libros de poesía y de psicología. Fue declarada hija distinguida de Azua, recibió el Soberano al Mérito por su trayectoria y fue reconocida por el Senado por su labor en la música, la cultura y la psicología. No ha dejado de componer, y hoy publica grabaciones nuevas, lecturas y puestas en circulación de sus libros por su propio canal.',
       updated_at = now()
 WHERE slug = 'olga-lara';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Olga Francia Elena Lara D’Soto, known as Olga Lara, is a Dominican singer, songwriter and poet. She was among the country’s foremost solo voices between the early eighties and the mid-nineties, working across ballad, bolero and merengue, and she has written well over two hundred songs, many of them recorded by other artists.","type":"text"}]},{"type":"paragraph","content":[{"text":"Azua","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She was born in Azua, in the south of the country, in 1953. She studied solfège, piano and guitar there, sang in the municipal choir and in her school’s tuna, and gave her first performances at school and church events.","type":"text"}]},{"type":"paragraph","content":[{"text":"Television and the first record","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Her professional career began in 1979, encouraged by the journalist Frank Natera and supported by the musician Bienvenido Bustamante and the broadcaster ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faff18bd-3dbc-477a-bc38-859d611887f0","displayText":"Yaqui Núñez del Risco","occurrenceId":"c314129c-9ba4-4a04-a4e6-1152ff3109a3"}},{"text":". She first appeared on El Show del Mediodía, and other television programmes followed.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her debut album arrived in 1981 on Combo Records, the label of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"a01bc562-fc17-46f0-8e70-3ed837a13c56"}},{"text":". Every song on it was her own, and it brought her a nomination as songwriter of the year — an unusual footing for a singer to start from.","type":"text"}]},{"type":"paragraph","content":[{"text":"The great shows","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Much of her reputation rests on staged productions rather than on records alone. She debuted at the Palacio de Bellas Artes in 1982, and presented a programme at the Teatro Nacional under the musical direction of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4d3a653c-688e-47c1-8cec-b8cf85a4abac","displayText":"Manuel Tejada","occurrenceId":"0284abd9-70c0-4c98-a7a6-3c5a28e37c1c"}},{"text":". Two years later she staged Mi Vida at Bellas Artes with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c958758c-a949-4bd9-963d-6d48bc750b60","displayText":"Jorge Taveras","occurrenceId":"5a0dd007-db65-4982-9603-c7077e37a716"}},{"text":" directing the music.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 1985 she took the concert Olga Lara es otra cosa through stadiums around the country. The title outlived the tour: in Dominican speech the phrase attached itself to her, and her name came to stand for something singular.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her tribute to the poet Héctor J. Díaz, staged at Bellas Artes in 1987, won the Casandra award for production of the year. She left the stage in 1995 with Cristal, at the Teatro Nacional, which won the same award and was filmed for television.","type":"text"}]},{"type":"paragraph","content":[{"text":"The songwriter","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Her catalogue as an author is larger than her catalogue as a performer. Among the artists who have recorded her songs are ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"8c63530c-6cec-43fc-9d7e-83349f66d29e"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5","displayText":"Las Chicas del Can","occurrenceId":"cce15cdc-b89f-4b15-8674-18e810da5506"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0d7c68df-63ca-4b6b-9a8f-c6c1a62912f1","displayText":"Belkis Concepción","occurrenceId":"24eddaec-072a-4566-be37-e9ec92da1eab"}},{"text":" and the Combo Show. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"14777546-5b72-4dcf-b18a-15320124a0ee","displayText":"Alex Matos","occurrenceId":"64a6a409-cc37-4f29-b66f-66dbea8b06a5"}},{"text":" remade her song Aprenderé as a salsa, and in 2024 the Mexican singer Thalía recorded an unreleased Lara composition as a bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her own best-known titles include Cualquiera Se Engaña, Mi Vida, Desconéctalo, Estrellita and Ladrón de Corazones. In the studio she worked with arrangers and musical directors including ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4d3a653c-688e-47c1-8cec-b8cf85a4abac","displayText":"Manuel Tejada","occurrenceId":"eb387c02-122a-4df8-ac9d-c11754d88a68"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c958758c-a949-4bd9-963d-6d48bc750b60","displayText":"Jorge Taveras","occurrenceId":"cb09da3a-d465-424b-86bb-340902420ac9"}},{"text":", on her own material and on songs by other writers.","type":"text"}]},{"type":"paragraph","content":[{"text":"Books and return","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She trained as a psychologist and has published as an author, beginning with a 1988 collection of fifty of her own lyrics and continuing with books of poetry and of psychology. She was named a distinguished daughter of Azua, received the Soberano al Mérito for her career, and was recognised by the Senate for her work in music, culture and psychology. She has kept composing, and now publishes new recordings, readings and book presentations through her own channel.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'olga-lara'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Olga Francia Elena Lara D’Soto, conocida como Olga Lara, es una cantautora y poeta dominicana. Fue una de las voces solistas más importantes del país entre principios de los ochenta y mediados de los noventa, en un repertorio que recorre la balada, el bolero y el merengue, y ha escrito más de doscientas canciones, muchas de ellas grabadas por otros artistas.","type":"text"}]},{"type":"paragraph","content":[{"text":"Azua","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Azua, al sur del país, en 1953. Allí estudió solfeo, piano y guitarra, cantó en el coro del ayuntamiento y en la tuna de su colegio, y dio sus primeras presentaciones en actos escolares y religiosos.","type":"text"}]},{"type":"paragraph","content":[{"text":"La televisión y el primer disco","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su carrera profesional empezó en 1979, impulsada por el periodista Frank Natera y apoyada por el músico Bienvenido Bustamante y el presentador ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faff18bd-3dbc-477a-bc38-859d611887f0","displayText":"Yaqui Núñez del Risco","occurrenceId":"313976cb-26c9-49f9-a0ad-aee4bbb6ba6d"}},{"text":". Su primera aparición fue en El Show del Mediodía, y detrás vinieron otros espacios de televisión.","type":"text"}]},{"type":"paragraph","content":[{"text":"Su álbum debut salió en 1981 por Combo Records, el sello de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"64a2e728-afce-43bf-ae5d-2a51bfe13a96"}},{"text":". Todas las canciones eran suyas, y el disco le valió una nominación como compositora del año: un punto de partida poco frecuente para una cantante.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los grandes espectáculos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Buena parte de su prestigio descansa en producciones de escenario y no solo en los discos. Debutó en el Palacio de Bellas Artes en 1982 y presentó un espectáculo en el Teatro Nacional bajo la dirección musical de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4d3a653c-688e-47c1-8cec-b8cf85a4abac","displayText":"Manuel Tejada","occurrenceId":"3a505556-a6d7-42fd-b6be-65d66d889d39"}},{"text":". Dos años después montó Mi Vida en Bellas Artes, con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c958758c-a949-4bd9-963d-6d48bc750b60","displayText":"Jorge Taveras","occurrenceId":"cbfabe9d-f406-46cf-b5c8-5a1fbccfdb4f"}},{"text":" en la dirección musical.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 1985 llevó el concierto Olga Lara es otra cosa por estadios de todo el país. El título sobrevivió a la gira: en el habla dominicana la expresión quedó asociada a ella, y su nombre pasó a significar algo singular.","type":"text"}]},{"type":"paragraph","content":[{"text":"Su homenaje al poeta Héctor J. Díaz, montado en Bellas Artes en 1987, ganó el Premio Casandra al espectáculo del año. Se despidió de los escenarios en 1995 con Cristal, en el Teatro Nacional, que obtuvo el mismo galardón y fue grabado para televisión.","type":"text"}]},{"type":"paragraph","content":[{"text":"La autora","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su catálogo como autora es mayor que el suyo como intérprete. Entre quienes han grabado canciones suyas están ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"4334eb63-aa71-4cb5-8da2-5011dc9845d2"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5","displayText":"Las Chicas del Can","occurrenceId":"a6e5ce65-67ee-4a5f-8027-0237672b9b65"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0d7c68df-63ca-4b6b-9a8f-c6c1a62912f1","displayText":"Belkis Concepción","occurrenceId":"80bbb3e0-70e3-4337-ad50-234774a6a0ec"}},{"text":" y el Combo Show. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"14777546-5b72-4dcf-b18a-15320124a0ee","displayText":"Alex Matos","occurrenceId":"ad97383a-543e-4aa9-962d-da600148838a"}},{"text":" rehízo su canción Aprenderé en versión salsa, y en 2024 la cantante mexicana Thalía grabó en bachata un tema inédito de su autoría.","type":"text"}]},{"type":"paragraph","content":[{"text":"Entre sus títulos más conocidos están Cualquiera Se Engaña, Mi Vida, Desconéctalo, Estrellita y Ladrón de Corazones. En el estudio trabajó con arreglistas y directores musicales como ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4d3a653c-688e-47c1-8cec-b8cf85a4abac","displayText":"Manuel Tejada","occurrenceId":"05ed5a55-6c02-46ab-a605-358a963045c8"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c958758c-a949-4bd9-963d-6d48bc750b60","displayText":"Jorge Taveras","occurrenceId":"89f8cf8e-b0a3-4dca-9c1e-98070ff4c988"}},{"text":", sobre material propio y sobre canciones de otros autores.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los libros y el regreso","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se formó como psicóloga y ha publicado como escritora, empezando en 1988 con una recopilación de cincuenta letras suyas y siguiendo con libros de poesía y de psicología. Fue declarada hija distinguida de Azua, recibió el Soberano al Mérito por su trayectoria y fue reconocida por el Senado por su labor en la música, la cultura y la psicología. No ha dejado de componer, y hoy publica grabaciones nuevas, lecturas y puestas en circulación de sus libros por su propio canal.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'olga-lara'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'en'), '0284abd9-70c0-4c98-a7a6-3c5a28e37c1c', 'artist', '4d3a653c-688e-47c1-8cec-b8cf85a4abac');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'en'), '24eddaec-072a-4566-be37-e9ec92da1eab', 'artist', '0d7c68df-63ca-4b6b-9a8f-c6c1a62912f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'en'), '5a0dd007-db65-4982-9603-c7077e37a716', 'artist', 'c958758c-a949-4bd9-963d-6d48bc750b60');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'en'), '64a6a409-cc37-4f29-b66f-66dbea8b06a5', 'artist', '14777546-5b72-4dcf-b18a-15320124a0ee');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'en'), '8c63530c-6cec-43fc-9d7e-83349f66d29e', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'en'), 'a01bc562-fc17-46f0-8e70-3ed837a13c56', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'en'), 'c314129c-9ba4-4a04-a4e6-1152ff3109a3', 'artist', 'faff18bd-3dbc-477a-bc38-859d611887f0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'en'), 'cb09da3a-d465-424b-86bb-340902420ac9', 'artist', 'c958758c-a949-4bd9-963d-6d48bc750b60');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'en'), 'cce15cdc-b89f-4b15-8674-18e810da5506', 'artist', '6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'en'), 'eb387c02-122a-4df8-ac9d-c11754d88a68', 'artist', '4d3a653c-688e-47c1-8cec-b8cf85a4abac');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'es'), '05ed5a55-6c02-46ab-a605-358a963045c8', 'artist', '4d3a653c-688e-47c1-8cec-b8cf85a4abac');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'es'), '313976cb-26c9-49f9-a0ad-aee4bbb6ba6d', 'artist', 'faff18bd-3dbc-477a-bc38-859d611887f0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'es'), '3a505556-a6d7-42fd-b6be-65d66d889d39', 'artist', '4d3a653c-688e-47c1-8cec-b8cf85a4abac');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'es'), '4334eb63-aa71-4cb5-8da2-5011dc9845d2', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'es'), '64a2e728-afce-43bf-ae5d-2a51bfe13a96', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'es'), '80bbb3e0-70e3-4337-ad50-234774a6a0ec', 'artist', '0d7c68df-63ca-4b6b-9a8f-c6c1a62912f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'es'), '89f8cf8e-b0a3-4dca-9c1e-98070ff4c988', 'artist', 'c958758c-a949-4bd9-963d-6d48bc750b60');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'es'), 'a6e5ce65-67ee-4a5f-8027-0237672b9b65', 'artist', '6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'es'), 'ad97383a-543e-4aa9-962d-da600148838a', 'artist', '14777546-5b72-4dcf-b18a-15320124a0ee');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara') AND locale = 'es'), 'cbfabe9d-f406-46cf-b5c8-5a1fbccfdb4f', 'artist', 'c958758c-a949-4bd9-963d-6d48bc750b60');

COMMIT;
