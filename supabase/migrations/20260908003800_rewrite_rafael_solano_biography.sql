BEGIN;

-- Rewrite the catalogue entry for Rafael Solano.
--
-- Rafael Solano. SEGUNDA de las 211, por enlaces entrantes: 26 fichas del
-- catálogo apuntan a él. Y tenía 1.036 CARACTERES, la ficha más corta de todo
-- el lote, sin una sola canción.
--
-- NO NOMBRABA "POR AMOR". Esa es la canción dominicana que más lejos ha ido en
-- el mundo: traducida a varios idiomas y grabada por Niní Cáffaro, Marco
-- Antonio Muñiz, Jon Secada, el Mariachi Vargas, Vikki Carr y Plácido Domingo.
-- Una ficha de Rafael Solano que no la nombra no es una ficha corta, es una
-- ficha equivocada.
--
-- DOS CAMPOS EN NULL QUE IMPORTAN Y SE CORRIGEN: gender estaba vacío, y ended
-- TAMBIÉN. Ese segundo no es cosmético: en este catálogo ended = true significa
-- que la persona murió. RAFAEL SOLANO ESTÁ VIVO, tiene 95 años, y dejar ese
-- campo ambiguo en la ficha de alguien vivo es de las cosas que no se pueden
-- permitir. Pasa a false.
--
-- LO QUE FALTABA, QUE ES UNA VIDA ENTERA:
--
--   FUE EMBAJADOR ANTE LA UNESCO en París, entre 1982 y 1986. Cargo
--   efectivamente ocupado, así que entra: mismo criterio que con Johnny Ventura
--   y Sergio Vargas.
--
--   CREÓ "LA HORA DEL MORO" EN 1959, y con ella rompió el monopolio de La Voz
--   Dominicana -- la emisora de Petán, hermano del dictador -- sobre quién
--   podía cantar en televisión. De ahí salieron Aníbal de Peña, Fernando
--   Casado, Niní Cáffaro, Horacio Pichardo, Arístides Incháustegui, Julio César
--   Defilló, Luchy Vicioso, José Lacay y Los Olmeños.
--
--   ESE PROGRAMA SE CONVIRTIÓ EN "EL SHOW DEL MEDIODÍA", que sigue al aire.
--
--   CREÓ EL FESTIVAL DE LA VOZ, de donde salieron Fernando Villalona, Sergio
--   Vargas, Adalgisa Pantaleón, Frank Valdez, Manny Oliva y Fausto Guillén.
--
--   TOCÓ EN EL CARNEGIE HALL. El disco "Amorama: Su Piano y Su Música
--   Instrumental en Carnegie Hall" es de 1969.
--
--   ESCRIBIÓ "A BAILAR LA MANGULINA" (1970). Este sitio se llama Mangulina y su
--   ficha no lo decía.
--
--   ES ESCRITOR PREMIADO: su libro con la musicóloga Catana Pérez de Cuello, "El
--   merengue, música y baile de la República Dominicana" (2003), ganó el PREMIO
--   NACIONAL FERIA DEL LIBRO en 2005.
--
--   TRES PREMIOS MAYORES QUE NO ESTABAN NI EN LA PROSA NI EN LA TABLA: El Gran
--   Dorado (1976), El Soberano (2005) y el Premio a la Excelencia Musical del
--   Latin Grammy (2016), más la Orden al Mérito de Duarte, Sánchez y Mella.
--
-- SU FORMACIÓN, que explica al músico: niño prodigio a los once, violinista,
-- chelista y armonista de la iglesia parroquial antes de quedarse con el piano.
-- Conservatorio Nacional desde 1950. Y después NUEVA YORK, con clases
-- particulares de HALL OVERTON y estudios en la New School.
--
-- EL PREMIO DEL LIBRO NO SE REGISTRA EN artist_awards Y SE REPORTA. El Premio
-- Nacional Feria del Libro es un galardón literario, no musical, y crear esa
-- entidad en una base de música es decisión del editor. Va contado en la prosa,
-- que es donde informa igual.
--
-- OCHO ENLACES, TODOS POR CRÉDITO O POR PROGRAMA DOCUMENTADO: nini-caffaro
-- (cantó "Por Amor" y ganó con ella el I Festival de la Canción Dominicana),
-- fernando-casado ("En la Oscuridad"), rene-del-risco-bermudez ("Una Primavera
-- para el Mundo", enlace recíproco porque escribí su ficha en esta corrida),
-- yaqui-nunez-del-risco (coprodujeron "Letra y Música" y le puso letra a
-- "Pensándolo Bien"), anibal-de-pena (salió de La Hora del Moro), y
-- fernando-villalona, sergio-vargas y adalgisa-pantaleon (salieron del Festival
-- de la Voz).
--
-- NO SE ENLAZAN los extranjeros que grabaron su obra: Marco Antonio Muñiz, Tito
-- Rodríguez, Felipe Pirela, Vicentico Valdés, Jon Secada, Vikki Carr, Plácido
-- Domingo, el Mariachi Vargas.
--
-- LA FILA GANA CAMPOS: middle_name 'Leónidas', sort_name completo, instruments
-- -- que estaba VACÍO para un pianista --, y occupations pierde 'musician', que
-- no dice nada, y gana 'conductor' y 'writer', los dos documentados.
--
-- LO QUE SE DEJA FUERA: su esposa. Nada más, porque la fuente no trae vida
-- privada: es una entrada larga y casi entera profesional.
--
-- FUENTES: Wikipedia en español, extensa y con discografía fechada.
--
-- NOMBRES NUEVOS PARA LA LISTA: ARÍSTIDES INCHÁUSTEGUI, LUCHY VICIOSO, JOSÉ
-- LACAY, JULIO CÉSAR DEFILLÓ y LOS OLMEÑOS, todos salidos de La Hora del Moro;
-- FRANK VALDEZ, MANNY OLIVA y FAUSTO GUILLÉN, del Festival de la Voz; HORACIO
-- PICHARDO; NOBEL ALFONSO, coproductor del programa diario; y CATANA PÉREZ DE
-- CUELLO, musicóloga y coautora del libro premiado. Doce nombres de una sola
-- ficha, y varios son cantantes de primera línea de los sesenta.
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
       name = 'Rafael Solano',
       sort_name = 'Solano Sánchez, Rafael Leónidas',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'composer',
       primary_genre = 'ballads',
       date_of_birth = '1931-04-10',
       birth_year = 1931,
       date_of_death = NULL,
       birth_place = 'San Felipe de Puerto Plata',
       province = 'Puerto Plata',
       first_name = 'Rafael',
       middle_name = 'Leónidas',
       last_name = 'Solano',
       second_last_name = 'Sánchez',
       stage_name = NULL,
       aliases = NULL,
       occupations = '["pianist","songwriter","conductor","writer"]'::jsonb,
       instruments = ARRAY['piano', 'violin', 'voice']::text[],
       genres = ARRAY['bolero', 'merengue', 'folklore']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Composer of Por Amor, the Dominican song that travelled furthest; also a television producer and ambassador to UNESCO',
       bio_en = 'Rafael Leónidas Solano Sánchez is a Dominican composer, pianist, conductor and writer. He wrote Por Amor, which has gone further into the world than any other Dominican song, and he built the television programmes through which two generations of Dominican singers were first heard.

**Puerto Plata**

He was born in Puerto Plata in 1931 and was treated as a prodigy by eleven, playing at the theatrical evenings his town put on. He came to the piano by way of the violin, the cello and the harmonium of the parish church, and in 1950 moved to the capital and enrolled at the National Conservatory.

He finished the whole course and then turned away from the concert career it pointed to, joining La Voz Dominicana, the country’s first television channel. He became one of its musical directors, working beside Italian, Cuban, Mexican and Argentine musicians who taught him orchestral arranging in practice. He later went to New York for private lessons with the American composer Hall Overton and study at the New School.

**La Hora del Moro**

Back in Santo Domingo he became a television producer, and in 1959 put La Hora del Moro on the air. Until then singing on Dominican television meant La Voz Dominicana, the station founded by the dictator’s brother; the new Sunday programme opened a second door.

The voices that came through it include Aníbal de Peña, Fernando Casado, Niní Cáffaro, Horacio Pichardo, Arístides Incháustegui, Julio César Defilló, Luchy Vicioso, José Lacay and Los Olmeños. With Nobel Alfonso he later remade the format as a daily show and renamed it El Show del Mediodía, which is still on the air in Santo Domingo.

He also created the Festival de la Voz, a talent competition that produced Fernando Villalona, Sergio Vargas, Adalgisa Pantaleón, Frank Valdez, Manny Oliva and Fausto Guillén. With Yaqui Núñez del Risco he produced Letra y Música, a nightly programme of music and opinion, and later Solano en Domingo and Solano Invita.

**Por Amor**

Por Amor won the first Dominican Song Festival sung by Niní Cáffaro. It has since been translated into several languages and recorded by Marco Antonio Muñiz, Tito Rodríguez, Jon Secada, Vikki Carr, the Mariachi Vargas and Plácido Domingo, which makes it the most widely travelled song the country has produced.

The rest of the catalogue runs past a hundred pieces. En la Oscuridad went out in the voice of Fernando Casado and later in those of Muñiz and Tito Rodríguez; En Ruinas was recorded by Felipe Pirela, Quiero Verte by Vicentico Valdés, Yo Soy Tu Enamorado again by Tito Rodríguez. Cada Vez Más, Confundidos, Mi Amor por Ti, Confesión de Amor, Perdidamente Enamorado, El Sonido de Tu Voz and Magia belong to the same body of work.

He set the words of René del Risco Bermudez for Una Primavera para el Mundo, and the lyrics of Yaqui Núñez del Risco for Pensándolo Bien.

**Mangulina and Carnegie Hall**

He did not stay inside the bolero. Como Juan, Fandango, Güira y Tambora and Mocanita are folk pieces, and Dominicanita and Pensándolo Bien are bolemengues, all of them recorded in his own voice with his orchestra behind him. He made an album called A Bailar la Mangulina in 1970.

The instrumental records carried him abroad. Amorama, released in 1969, was recorded at Carnegie Hall.

**The writing**

His column Solanismos ran in Listín Diario from 1975. He published Letra y Música in 1992, which he described in its prologue as autobiographical accounts of a Dominican musician rather than an autobiography, and in 2003 wrote El merengue, música y baile de la República Dominicana with the musicologist Catana Pérez de Cuello. That book won the national book fair prize in 2005. Música y Pensamiento followed in 2016.

**The honours**

He served as Dominican ambassador and delegate to UNESCO in Paris between 1982 and 1986, and holds the Order of Merit of Duarte, Sánchez and Mella. He received the Gran Dorado in 1976 and El Soberano in 2005, the two highest awards in Dominican popular music, and in 2016 the Latin Recording Academy gave him its Musical Excellence Award.',
       bio_es = 'Rafael Leónidas Solano Sánchez es un compositor, pianista, director de orquesta y escritor dominicano. Escribió Por Amor, que ha llegado más lejos en el mundo que ninguna otra canción dominicana, y armó los programas de televisión por los que se oyó por primera vez a dos generaciones de cantantes del país.

**Puerto Plata**

Nació en Puerto Plata en 1931 y a los once años ya lo trataban de niño prodigio, presentándolo en las funciones teatrales de su pueblo. Llegó al piano pasando por el violín, el chelo y el armonio de la iglesia parroquial, y en 1950 se mudó a la capital y entró al Conservatorio Nacional.

Terminó todos los cursos y entonces se desvió de la carrera de concierto a la que apuntaban, entrando a La Voz Dominicana, el primer canal de televisión del país. Llegó a ser uno de sus directores musicales, trabajando al lado de músicos italianos, cubanos, mexicanos y argentinos que le enseñaron arreglo orquestal en la práctica. Después se fue a Nueva York a tomar clases particulares con el compositor estadounidense Hall Overton y a estudiar en la New School.

**La Hora del Moro**

De vuelta en Santo Domingo se hizo productor de televisión, y en 1959 puso al aire La Hora del Moro. Hasta entonces cantar en la televisión dominicana quería decir La Voz Dominicana, la emisora fundada por el hermano del dictador; aquel programa dominical abrió una segunda puerta.

Por ahí salieron Aníbal de Peña, Fernando Casado, Niní Cáffaro, Horacio Pichardo, Arístides Incháustegui, Julio César Defilló, Luchy Vicioso, José Lacay y Los Olmeños. Con Nobel Alfonso rehízo después el formato en diario y lo rebautizó El Show del Mediodía, que sigue al aire en Santo Domingo.

Creó además el Festival de la Voz, un concurso de donde salieron Fernando Villalona, Sergio Vargas, Adalgisa Pantaleón, Frank Valdez, Manny Oliva y Fausto Guillén. Con Yaqui Núñez del Risco produjo Letra y Música, programa nocturno diario de música y opinión, y más tarde Solano en Domingo y Solano Invita.

**Por Amor**

Por Amor ganó el I Festival de la Canción Dominicana en la voz de Niní Cáffaro. Desde entonces se ha traducido a varios idiomas y la han grabado Marco Antonio Muñiz, Tito Rodríguez, Jon Secada, Vikki Carr, el Mariachi Vargas y Plácido Domingo, lo que la convierte en la canción que más ha viajado de cuantas ha producido el país.

El resto del catálogo pasa del centenar de piezas. En la Oscuridad salió en la voz de Fernando Casado y después en las de Muñiz y Tito Rodríguez; En Ruinas la grabó Felipe Pirela, Quiero Verte Vicentico Valdés, y Yo Soy Tu Enamorado otra vez Tito Rodríguez. Cada Vez Más, Confundidos, Mi Amor por Ti, Confesión de Amor, Perdidamente Enamorado, El Sonido de Tu Voz y Magia pertenecen al mismo cuerpo de obra.

Le puso música a los versos de René del Risco Bermudez en Una Primavera para el Mundo, y a la letra de Yaqui Núñez del Risco en Pensándolo Bien.

**La mangulina y el Carnegie Hall**

No se quedó dentro del bolero. Como Juan, Fandango, Güira y Tambora y Mocanita son piezas folclóricas, y Dominicanita y Pensándolo Bien son bolemengues, todas grabadas en su propia voz y con su orquesta detrás. En 1970 hizo un disco titulado A Bailar la Mangulina.

Los discos instrumentales lo sacaron del país. Amorama, publicado en 1969, se grabó en el Carnegie Hall.

**La escritura**

Su columna Solanismos salía en el Listín Diario desde 1975. Publicó Letra y Música en 1992, que él mismo describe en el prólogo como relatos autobiográficos de un músico dominicano y no como una autobiografía, y en 2003 escribió El merengue, música y baile de la República Dominicana junto a la musicóloga Catana Pérez de Cuello. Ese libro ganó el Premio Nacional Feria del Libro en 2005. Música y Pensamiento vino en 2016.

**Los reconocimientos**

Fue embajador y delegado dominicano ante la Unesco en París entre 1982 y 1986, y tiene la Orden al Mérito de Duarte, Sánchez y Mella. Recibió El Gran Dorado en 1976 y El Soberano en 2005, los dos máximos galardones de la música popular dominicana, y en 2016 la Academia Latina de la Grabación le entregó su Premio a la Excelencia Musical.',
       updated_at = now()
 WHERE slug = 'rafael-solano';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Rafael Leónidas Solano Sánchez is a Dominican composer, pianist, conductor and writer. He wrote Por Amor, which has gone further into the world than any other Dominican song, and he built the television programmes through which two generations of Dominican singers were first heard.","type":"text"}]},{"type":"paragraph","content":[{"text":"Puerto Plata","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Puerto Plata in 1931 and was treated as a prodigy by eleven, playing at the theatrical evenings his town put on. He came to the piano by way of the violin, the cello and the harmonium of the parish church, and in 1950 moved to the capital and enrolled at the National Conservatory.","type":"text"}]},{"type":"paragraph","content":[{"text":"He finished the whole course and then turned away from the concert career it pointed to, joining La Voz Dominicana, the country’s first television channel. He became one of its musical directors, working beside Italian, Cuban, Mexican and Argentine musicians who taught him orchestral arranging in practice. He later went to New York for private lessons with the American composer Hall Overton and study at the New School.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Hora del Moro","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Back in Santo Domingo he became a television producer, and in 1959 put La Hora del Moro on the air. Until then singing on Dominican television meant La Voz Dominicana, the station founded by the dictator’s brother; the new Sunday programme opened a second door.","type":"text"}]},{"type":"paragraph","content":[{"text":"The voices that came through it include ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bdd072a-e0d4-472f-9579-ba9499ac4005","displayText":"Aníbal de Peña","occurrenceId":"b57d54ed-bfde-4101-8b1c-e8f0a066cbb5"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1131dfe6-f404-44b4-8d0d-f8120dc6f71a","displayText":"Fernando Casado","occurrenceId":"655ebf40-8995-4087-a1f2-159b061343c3"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"19124a2a-a49c-435e-989e-049b5dc3726c","displayText":"Niní Cáffaro","occurrenceId":"9eb83edc-cb69-4abf-bc18-66f42b50d808"}},{"text":", Horacio Pichardo, Arístides Incháustegui, Julio César Defilló, Luchy Vicioso, José Lacay and Los Olmeños. With Nobel Alfonso he later remade the format as a daily show and renamed it El Show del Mediodía, which is still on the air in Santo Domingo.","type":"text"}]},{"type":"paragraph","content":[{"text":"He also created the Festival de la Voz, a talent competition that produced ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"2307bdfa-70fc-417e-8227-1050eb2ec5e0"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"e57179c2-306d-4dcc-8b16-4e82f0f1fabd"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"79d013c7-dafc-4807-966e-32c370172dee","displayText":"Adalgisa Pantaleón","occurrenceId":"4aa61dc5-6cf4-4be6-a0bf-5f244a5eb3d0"}},{"text":", Frank Valdez, Manny Oliva and Fausto Guillén. With ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faff18bd-3dbc-477a-bc38-859d611887f0","displayText":"Yaqui Núñez del Risco","occurrenceId":"d100bc80-a9ae-48b9-9cab-48b6acf901d3"}},{"text":" he produced Letra y Música, a nightly programme of music and opinion, and later Solano en Domingo and Solano Invita.","type":"text"}]},{"type":"paragraph","content":[{"text":"Por Amor","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Por Amor won the first Dominican Song Festival sung by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"19124a2a-a49c-435e-989e-049b5dc3726c","displayText":"Niní Cáffaro","occurrenceId":"064e2cbf-0e5a-436c-9e99-7be005e40b1e"}},{"text":". It has since been translated into several languages and recorded by Marco Antonio Muñiz, Tito Rodríguez, Jon Secada, Vikki Carr, the Mariachi Vargas and Plácido Domingo, which makes it the most widely travelled song the country has produced.","type":"text"}]},{"type":"paragraph","content":[{"text":"The rest of the catalogue runs past a hundred pieces. En la Oscuridad went out in the voice of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1131dfe6-f404-44b4-8d0d-f8120dc6f71a","displayText":"Fernando Casado","occurrenceId":"d54da193-5695-4a4c-9429-21771112471b"}},{"text":" and later in those of Muñiz and Tito Rodríguez; En Ruinas was recorded by Felipe Pirela, Quiero Verte by Vicentico Valdés, Yo Soy Tu Enamorado again by Tito Rodríguez. Cada Vez Más, Confundidos, Mi Amor por Ti, Confesión de Amor, Perdidamente Enamorado, El Sonido de Tu Voz and Magia belong to the same body of work.","type":"text"}]},{"type":"paragraph","content":[{"text":"He set the words of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c1575281-d275-4f34-a721-9f02736132d2","displayText":"René del Risco Bermudez","occurrenceId":"c35b9e3b-f86a-4576-ac1d-c84898d6b113"}},{"text":" for Una Primavera para el Mundo, and the lyrics of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faff18bd-3dbc-477a-bc38-859d611887f0","displayText":"Yaqui Núñez del Risco","occurrenceId":"0d18a025-56d8-4899-adf5-b08117b1440d"}},{"text":" for Pensándolo Bien.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mangulina and Carnegie Hall","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He did not stay inside the bolero. Como Juan, Fandango, Güira y Tambora and Mocanita are folk pieces, and Dominicanita and Pensándolo Bien are bolemengues, all of them recorded in his own voice with his orchestra behind him. He made an album called A Bailar la Mangulina in 1970.","type":"text"}]},{"type":"paragraph","content":[{"text":"The instrumental records carried him abroad. Amorama, released in 1969, was recorded at Carnegie Hall.","type":"text"}]},{"type":"paragraph","content":[{"text":"The writing","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His column Solanismos ran in Listín Diario from 1975. He published Letra y Música in 1992, which he described in its prologue as autobiographical accounts of a Dominican musician rather than an autobiography, and in 2003 wrote El merengue, música y baile de la República Dominicana with the musicologist Catana Pérez de Cuello. That book won the national book fair prize in 2005. Música y Pensamiento followed in 2016.","type":"text"}]},{"type":"paragraph","content":[{"text":"The honours","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He served as Dominican ambassador and delegate to UNESCO in Paris between 1982 and 1986, and holds the Order of Merit of Duarte, Sánchez and Mella. He received the Gran Dorado in 1976 and El Soberano in 2005, the two highest awards in Dominican popular music, and in 2016 the Latin Recording Academy gave him its Musical Excellence Award.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'rafael-solano'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Rafael Leónidas Solano Sánchez es un compositor, pianista, director de orquesta y escritor dominicano. Escribió Por Amor, que ha llegado más lejos en el mundo que ninguna otra canción dominicana, y armó los programas de televisión por los que se oyó por primera vez a dos generaciones de cantantes del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Puerto Plata","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Puerto Plata en 1931 y a los once años ya lo trataban de niño prodigio, presentándolo en las funciones teatrales de su pueblo. Llegó al piano pasando por el violín, el chelo y el armonio de la iglesia parroquial, y en 1950 se mudó a la capital y entró al Conservatorio Nacional.","type":"text"}]},{"type":"paragraph","content":[{"text":"Terminó todos los cursos y entonces se desvió de la carrera de concierto a la que apuntaban, entrando a La Voz Dominicana, el primer canal de televisión del país. Llegó a ser uno de sus directores musicales, trabajando al lado de músicos italianos, cubanos, mexicanos y argentinos que le enseñaron arreglo orquestal en la práctica. Después se fue a Nueva York a tomar clases particulares con el compositor estadounidense Hall Overton y a estudiar en la New School.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Hora del Moro","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"De vuelta en Santo Domingo se hizo productor de televisión, y en 1959 puso al aire La Hora del Moro. Hasta entonces cantar en la televisión dominicana quería decir La Voz Dominicana, la emisora fundada por el hermano del dictador; aquel programa dominical abrió una segunda puerta.","type":"text"}]},{"type":"paragraph","content":[{"text":"Por ahí salieron ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bdd072a-e0d4-472f-9579-ba9499ac4005","displayText":"Aníbal de Peña","occurrenceId":"7144be02-ff86-41ec-bbe4-6165c77ca244"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1131dfe6-f404-44b4-8d0d-f8120dc6f71a","displayText":"Fernando Casado","occurrenceId":"1557da73-af0b-4e7b-83bb-d70070cf8f5e"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"19124a2a-a49c-435e-989e-049b5dc3726c","displayText":"Niní Cáffaro","occurrenceId":"dca6522b-7045-4a37-94cf-4cba869a6b92"}},{"text":", Horacio Pichardo, Arístides Incháustegui, Julio César Defilló, Luchy Vicioso, José Lacay y Los Olmeños. Con Nobel Alfonso rehízo después el formato en diario y lo rebautizó El Show del Mediodía, que sigue al aire en Santo Domingo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Creó además el Festival de la Voz, un concurso de donde salieron ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"cd335b4d-0884-4c22-b93d-b175b472bb4a"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"f743d299-12c6-4bfa-9040-bf2c2dcd29ee"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"79d013c7-dafc-4807-966e-32c370172dee","displayText":"Adalgisa Pantaleón","occurrenceId":"355283d6-e730-49ae-b1f8-e6a805779188"}},{"text":", Frank Valdez, Manny Oliva y Fausto Guillén. Con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faff18bd-3dbc-477a-bc38-859d611887f0","displayText":"Yaqui Núñez del Risco","occurrenceId":"f05b25d6-7b94-4977-8a37-68d1971209da"}},{"text":" produjo Letra y Música, programa nocturno diario de música y opinión, y más tarde Solano en Domingo y Solano Invita.","type":"text"}]},{"type":"paragraph","content":[{"text":"Por Amor","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Por Amor ganó el I Festival de la Canción Dominicana en la voz de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"19124a2a-a49c-435e-989e-049b5dc3726c","displayText":"Niní Cáffaro","occurrenceId":"4707bb59-5548-47f1-ab10-8d7d77906a47"}},{"text":". Desde entonces se ha traducido a varios idiomas y la han grabado Marco Antonio Muñiz, Tito Rodríguez, Jon Secada, Vikki Carr, el Mariachi Vargas y Plácido Domingo, lo que la convierte en la canción que más ha viajado de cuantas ha producido el país.","type":"text"}]},{"type":"paragraph","content":[{"text":"El resto del catálogo pasa del centenar de piezas. En la Oscuridad salió en la voz de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1131dfe6-f404-44b4-8d0d-f8120dc6f71a","displayText":"Fernando Casado","occurrenceId":"3d167cbd-8e55-4719-8809-9c37d5aba653"}},{"text":" y después en las de Muñiz y Tito Rodríguez; En Ruinas la grabó Felipe Pirela, Quiero Verte Vicentico Valdés, y Yo Soy Tu Enamorado otra vez Tito Rodríguez. Cada Vez Más, Confundidos, Mi Amor por Ti, Confesión de Amor, Perdidamente Enamorado, El Sonido de Tu Voz y Magia pertenecen al mismo cuerpo de obra.","type":"text"}]},{"type":"paragraph","content":[{"text":"Le puso música a los versos de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c1575281-d275-4f34-a721-9f02736132d2","displayText":"René del Risco Bermudez","occurrenceId":"e8e559b6-cc59-4307-aee7-2cf37258bbbe"}},{"text":" en Una Primavera para el Mundo, y a la letra de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faff18bd-3dbc-477a-bc38-859d611887f0","displayText":"Yaqui Núñez del Risco","occurrenceId":"2c22a1c7-472e-4570-9488-721096014df2"}},{"text":" en Pensándolo Bien.","type":"text"}]},{"type":"paragraph","content":[{"text":"La mangulina y el Carnegie Hall","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"No se quedó dentro del bolero. Como Juan, Fandango, Güira y Tambora y Mocanita son piezas folclóricas, y Dominicanita y Pensándolo Bien son bolemengues, todas grabadas en su propia voz y con su orquesta detrás. En 1970 hizo un disco titulado A Bailar la Mangulina.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los discos instrumentales lo sacaron del país. Amorama, publicado en 1969, se grabó en el Carnegie Hall.","type":"text"}]},{"type":"paragraph","content":[{"text":"La escritura","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su columna Solanismos salía en el Listín Diario desde 1975. Publicó Letra y Música en 1992, que él mismo describe en el prólogo como relatos autobiográficos de un músico dominicano y no como una autobiografía, y en 2003 escribió El merengue, música y baile de la República Dominicana junto a la musicóloga Catana Pérez de Cuello. Ese libro ganó el Premio Nacional Feria del Libro en 2005. Música y Pensamiento vino en 2016.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los reconocimientos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Fue embajador y delegado dominicano ante la Unesco en París entre 1982 y 1986, y tiene la Orden al Mérito de Duarte, Sánchez y Mella. Recibió El Gran Dorado en 1976 y El Soberano en 2005, los dos máximos galardones de la música popular dominicana, y en 2016 la Academia Latina de la Grabación le entregó su Premio a la Excelencia Musical.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'rafael-solano'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'en'), '064e2cbf-0e5a-436c-9e99-7be005e40b1e', 'artist', '19124a2a-a49c-435e-989e-049b5dc3726c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'en'), '0d18a025-56d8-4899-adf5-b08117b1440d', 'artist', 'faff18bd-3dbc-477a-bc38-859d611887f0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'en'), '2307bdfa-70fc-417e-8227-1050eb2ec5e0', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'en'), '4aa61dc5-6cf4-4be6-a0bf-5f244a5eb3d0', 'artist', '79d013c7-dafc-4807-966e-32c370172dee');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'en'), '655ebf40-8995-4087-a1f2-159b061343c3', 'artist', '1131dfe6-f404-44b4-8d0d-f8120dc6f71a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'en'), '9eb83edc-cb69-4abf-bc18-66f42b50d808', 'artist', '19124a2a-a49c-435e-989e-049b5dc3726c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'en'), 'b57d54ed-bfde-4101-8b1c-e8f0a066cbb5', 'artist', '2bdd072a-e0d4-472f-9579-ba9499ac4005');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'en'), 'c35b9e3b-f86a-4576-ac1d-c84898d6b113', 'artist', 'c1575281-d275-4f34-a721-9f02736132d2');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'en'), 'd100bc80-a9ae-48b9-9cab-48b6acf901d3', 'artist', 'faff18bd-3dbc-477a-bc38-859d611887f0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'en'), 'd54da193-5695-4a4c-9429-21771112471b', 'artist', '1131dfe6-f404-44b4-8d0d-f8120dc6f71a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'en'), 'e57179c2-306d-4dcc-8b16-4e82f0f1fabd', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'es'), '1557da73-af0b-4e7b-83bb-d70070cf8f5e', 'artist', '1131dfe6-f404-44b4-8d0d-f8120dc6f71a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'es'), '2c22a1c7-472e-4570-9488-721096014df2', 'artist', 'faff18bd-3dbc-477a-bc38-859d611887f0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'es'), '355283d6-e730-49ae-b1f8-e6a805779188', 'artist', '79d013c7-dafc-4807-966e-32c370172dee');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'es'), '3d167cbd-8e55-4719-8809-9c37d5aba653', 'artist', '1131dfe6-f404-44b4-8d0d-f8120dc6f71a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'es'), '4707bb59-5548-47f1-ab10-8d7d77906a47', 'artist', '19124a2a-a49c-435e-989e-049b5dc3726c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'es'), '7144be02-ff86-41ec-bbe4-6165c77ca244', 'artist', '2bdd072a-e0d4-472f-9579-ba9499ac4005');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'es'), 'cd335b4d-0884-4c22-b93d-b175b472bb4a', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'es'), 'dca6522b-7045-4a37-94cf-4cba869a6b92', 'artist', '19124a2a-a49c-435e-989e-049b5dc3726c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'es'), 'e8e559b6-cc59-4307-aee7-2cf37258bbbe', 'artist', 'c1575281-d275-4f34-a721-9f02736132d2');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'es'), 'f05b25d6-7b94-4977-8a37-68d1971209da', 'artist', 'faff18bd-3dbc-477a-bc38-859d611887f0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafael-solano') AND locale = 'es'), 'f743d299-12c6-4bfa-9040-bf2c2dcd29ee', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

COMMIT;
