BEGIN;

-- Rewrite the catalogue entry for Prince Royce.
--
-- Prince Royce. Primera de las dieciséis fichas publicadas que estaban EN BLANCO
-- -- sin documento editorial y sin bio_en ni bio_es. Una página viva que no
-- decía absolutamente nada sobre uno de los bachateros más grandes vivos.
--
-- LA FILA YA TENÍA LO BÁSICO y no se toca: nombre, tipo, género, rol, la fecha
-- de nacimiento 1989-05-11 y el nombre legal parcial. Lo que faltaba era todo lo
-- demás.
--
-- SE COMPLETA EL APELLIDO. La fila tenía last_name 'Rojas' y el segundo apellido
-- vacío. Wikipedia en español da el nombre completo: Geoffrey Royce Rojas de
-- León, de padre Ramón Rojas y madre Ángela de León. second_last_name pasa a
-- 'de León'.
--
-- SE AFINA EL LUGAR DE NACIMIENTO, y aviso porque es sobrescribir un valor. La
-- fila decía "Nueva York" y todas las fuentes coinciden en EL BRONX. Es una
-- precisión, no una contradicción, y deja la fila consistente con dj-mari-d, que
-- ya usa "El Bronx" con la misma provincia "Nacido en el Exterior".
--
-- LAS CUATRO REDES ESTABAN VACÍAS Y SE LLENAN, todas comprobadas vivas hoy:
-- instagram princeroyce (publicación de junio de 2026), youtube @prince_royce
-- -- OJO, con guion bajo; @PrinceRoyce da 404 --, facebook princeroyce
-- (publicación de abril de 2026) y princeroyce.com, que responde con "Prince
-- Royce | Official Site".
--
-- SE AÑADE LA ETIQUETA diaspora. Mirando cómo se usa de verdad en la tabla, no
-- es "nacido fuera" sino "trabaja en la diáspora": la llevan también
-- petiton-guzman, zawezo-del-patio, raul-acosta y yasser-tejeda, nacidos todos
-- en el país. Royce es el caso más claro posible, y queda junto a proyecto-uno,
-- the-new-york-band y oro-solido, que son su misma categoría exacta.
--
-- GÉNERO SECUNDARIO fusion, que la taxonomía define como "estilos de fusión que
-- combinan sonidos dominicanos e internacionales". Es literalmente su oficio.
--
-- NO SE ESCRIBEN CIFRAS de seguidores, suscriptores ni reproducciones, aunque en
-- su caso son enormes y están por todas partes. Tampoco matrimonio ni divorcio,
-- ni los oficios de sus padres. Que sean dominicanos SÍ va, porque es el criterio
-- por el que está en este catálogo.
--
-- SE ENLAZAN DOS, y las dos ya lo enlazaban a él, así que la relación queda
-- recíproca: antony-santos, en cuya ficha aparece entre los que cruzan la brecha
-- generacional de la bachata, y esme, que comparte tarima dominicana con él.
--
-- ROMEO SANTOS NO SE PUEDE ENLAZAR y es el hueco más visible de esta ficha: no
-- tiene registro. Aparece tres veces en la prosa -- la gira conjunta, "Lokita Por
-- Mí" y el paralelismo de carreras -- y las tres como texto muerto. Encabeza la
-- lista de faltantes desde hace días y esta ficha es el argumento más fuerte para
-- escribirlo ya.
--
-- FUENTES: Wikipedia en español, que es larga y está bien referenciada. Los
-- Angeles Times, ABC7 y Billboard, mayo de 2025, para ETERNO. ESENDOM, 3 de junio
-- de 2025. Sus propias cuentas para la obra reciente y la gira. El sitio oficial.
--
-- NOMBRES NUEVOS PARA LA LISTA: Andrés Hidalgo, el mánager que lo firmó a los
-- diecinueve años y produjo el debut -- OJO, no confundir con el juan-hidalgo que
-- ya está en la base --; Sergio George, el pianista y productor que lo llevó a
-- Top Stop Music; y Toby Love, del mismo circuito de bachata neoyorquina.
--
-- Applied directly over DATABASE_URL as part of an editorial pass. No Vercel
-- function ran and nothing was revalidated; the profile reaches the public site
-- on its own within the seven-day ISR fallback, or sooner if a batch sweep is
-- run at the end of the pass.
--
-- This file reproduces the change from the pre-pass state. Both it and its
-- rollback were generated from state captured live either side of the write,
-- not reconstructed afterwards.

UPDATE artists SET
       name = 'Prince Royce',
       sort_name = 'Prince Royce',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1989-05-11',
       birth_year = 1989,
       date_of_death = NULL,
       birth_place = 'El Bronx',
       province = 'Nacido en el Exterior',
       first_name = 'Geoffrey',
       middle_name = 'Royce',
       last_name = 'Rojas',
       second_last_name = 'de León',
       stage_name = 'Prince Royce',
       aliases = ARRAY[]::text[],
       occupations = '["composer","actor"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['fusion']::text[],
       artist_tags = ARRAY['secular', 'diaspora']::text[],
       website = 'https://www.princeroyce.com',
       youtube = '@prince_royce',
       facebook = 'princeroyce',
       instagram = 'princeroyce',
       disambiguation = 'Bachata singer from the Bronx; Stand By Me, Darte un Beso, Eterno',
       bio_en = 'Prince Royce, born Geoffrey Royce Rojas de León, is a Dominican-American bachata singer and songwriter. He took the most Dominican of guitar musics, sang it in two languages to an audience raised on American radio, and turned it into one of the largest careers the genre has produced.

**The Bronx**

He was born in the Bronx in 1989 to Dominican parents and grew up between two languages, which is the ordinary condition of his generation in New York and turns out to be the whole explanation of his music.

He started writing poetry at thirteen and songs at sixteen, and took the name Prince Royce then. At eighteen he sang on a Spanish-language variety show. He worked in a mobile phone shop to pay for musicians and studio time, which is the part of the story he tells most often and the part that explains the discipline.

At nineteen a manager heard a demo and pushed him toward bachata specifically — he had not necessarily arrived there on his own — and introduced him to a producer with a label. That is the hinge. A Bronx kid writing bilingual songs could have gone half a dozen directions; somebody pointed him at his parents’ music.

**Stand By Me**

His first album came out in 2010 and led with a bachata version of Ben E. King’s Stand By Me, sung half in English and half in Spanish. It went to number one on the tropical chart, and Corazón Sin Cara did the same.

That single is the thesis of the whole career and it was there from the first record. Take a song the whole hemisphere already knows in English, put it over a bachata guitar, sing it in both languages, and let two audiences hear something that belongs to each of them. Nothing he has done since departs from it.

It also made him the most audible answer to a question the genre had been asking for years — whether bachata could leave the barrio without stopping being bachata. He is one of the names that closes the distance between the founding generation and the present, and Antony Santos’s own record shows the same crossing from the other side.

**The albums**

Phase II followed in 2012, went platinum and was nominated for the tropical Latin Grammy. Soy El Mismo came in 2013 with Darte Un Beso, which topped the Hot Latin Songs chart. Double Vision, in 2015, was his English-language album and produced Back It Up with Jennifer Lopez and Pitbull.

Five arrived in 2017 with a guest list that reads like a map of where Latin music had got to — Shakira, Chris Brown, Zendaya, Farruko, Gente de Zona, Arturo Sandoval — and it was his fourth number one. Then a long run of collaborations across genres, and Alter Ego in 2020, a double record split into two halves with different names.

Llamada Perdida, in 2024, is the outlier: a heartbreak album, personal and unornamented, made by someone who had spent fifteen years making records for stadiums. He has also shared a Dominican stage with Esme, which is what the older names in this genre do for the younger ones.

**Eterno**

His eighth album came out in May 2025 and is the idea from Stand By Me carried to its conclusion. Thirteen English-language pop standards — the Beatles, the Bee Gees, Elvis, the Backstreet Boys, Richard Marx — rebuilt as bilingual bachata. Yesterday. How Deep Is Your Love. I Want It That Way.

A record like that could be a novelty and is not, because he has been doing exactly this since he was twenty-one and because the arrangements take the songs seriously. What it argues is that bachata is not a regional flavour you apply to foreign material but a form capable of holding anything you put in it.

He tours with Romeo Santos now, the two largest names the genre has produced, and Miami-Dade has a day named after him. The kid cleaning display cases in a phone shop was the same person planning all of it.',
       bio_es = 'Prince Royce, de nombre Geoffrey Royce Rojas de León, es cantante y compositor de bachata dominicano-estadounidense. Agarró la más dominicana de las músicas de guitarra, la cantó en dos idiomas ante un público criado con la radio estadounidense, y la convirtió en una de las carreras más grandes que ha dado el género.

**El Bronx**

Nació en el Bronx en 1989, de padres dominicanos, y se crió entre dos idiomas, que es la condición corriente de su generación en Nueva York y resulta ser la explicación entera de su música.

Empezó a escribir poesía a los trece años y canciones a los dieciséis, y fue entonces cuando tomó el nombre de Prince Royce. A los dieciocho cantó en un programa de variedades en español. Trabajó en una tienda de teléfonos para pagar músicos y horas de estudio, que es la parte de la historia que más cuenta y la que explica la disciplina.

A los diecinueve un mánager oyó una maqueta y lo empujó hacia la bachata en concreto —no había llegado ahí necesariamente por su cuenta— y le presentó a un productor con sello. Ahí está la bisagra. Un muchacho del Bronx que escribía canciones bilingües podía haber ido por media docena de caminos; alguien le señaló la música de sus padres.

**Stand By Me**

Su primer disco salió en 2010 y abría con una versión en bachata del Stand By Me de Ben E. King, cantada mitad en inglés y mitad en español. Llegó al número uno de la lista tropical, y Corazón Sin Cara hizo lo mismo.

Ese sencillo es la tesis de toda la carrera y ya estaba en el primer disco. Agarrar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas, y dejar que dos públicos oigan algo que le pertenece a cada uno. Nada de lo que ha hecho después se aparta de eso.

Lo convirtió además en la respuesta más audible a una pregunta que el género llevaba años haciéndose: si la bachata podía salir del barrio sin dejar de ser bachata. Es uno de los nombres que cierra la distancia entre la generación fundadora y el presente, y la ficha del propio Antony Santos muestra ese mismo cruce desde el otro lado.

**Los álbumes**

Phase II vino en 2012, fue disco de platino y quedó nominado al Grammy Latino tropical. Soy El Mismo llegó en 2013 con Darte Un Beso, que encabezó la lista Hot Latin Songs. Double Vision, en 2015, fue su disco en inglés y de ahí salió Back It Up con Jennifer Lopez y Pitbull.

Five apareció en 2017 con una lista de invitados que se lee como un mapa de dónde había llegado la música latina —Shakira, Chris Brown, Zendaya, Farruko, Gente de Zona, Arturo Sandoval— y fue su cuarto número uno. Después una tanda larga de colaboraciones entre géneros, y en 2020 Alter Ego, un disco doble partido en dos mitades con nombre propio cada una.

Llamada Perdida, de 2024, es la excepción: un disco de desamor, personal y sin adornos, hecho por alguien que llevaba quince años grabando para estadios. Ha compartido además tarima dominicana con Esme, que es lo que los nombres mayores de este género hacen por los jóvenes.

**Eterno**

Su octavo álbum salió en mayo de 2025 y es la idea de Stand By Me llevada hasta el final. Trece clásicos del pop anglosajón —los Beatles, los Bee Gees, Elvis, los Backstreet Boys, Richard Marx— rehechos como bachata bilingüe. Yesterday. How Deep Is Your Love. I Want It That Way.

Un disco así podría ser una curiosidad y no lo es, porque lleva haciendo exactamente esto desde los veintiún años y porque los arreglos se toman las canciones en serio. Lo que argumenta es que la bachata no es un sabor regional que se le aplica a material ajeno, sino una forma capaz de sostener cualquier cosa que se le meta dentro.

Ahora sale de gira con Romeo Santos, los dos nombres más grandes que ha dado el género, y el condado de Miami-Dade tiene un día con su nombre. El muchacho que limpiaba vitrinas en una tienda de teléfonos era la misma persona que estaba planificando todo esto.',
       updated_at = now()
 WHERE slug = 'prince-royce';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'prince-royce')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'prince-royce')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Prince Royce, born Geoffrey Royce Rojas de León, is a Dominican-American bachata singer and songwriter. He took the most Dominican of guitar musics, sang it in two languages to an audience raised on American radio, and turned it into one of the largest careers the genre has produced.","type":"text"}]},{"type":"paragraph","content":[{"text":"The Bronx","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in the Bronx in 1989 to Dominican parents and grew up between two languages, which is the ordinary condition of his generation in New York and turns out to be the whole explanation of his music.","type":"text"}]},{"type":"paragraph","content":[{"text":"He started writing poetry at thirteen and songs at sixteen, and took the name Prince Royce then. At eighteen he sang on a Spanish-language variety show. He worked in a mobile phone shop to pay for musicians and studio time, which is the part of the story he tells most often and the part that explains the discipline.","type":"text"}]},{"type":"paragraph","content":[{"text":"At nineteen a manager heard a demo and pushed him toward bachata specifically — he had not necessarily arrived there on his own — and introduced him to a producer with a label. That is the hinge. A Bronx kid writing bilingual songs could have gone half a dozen directions; somebody pointed him at his parents’ music.","type":"text"}]},{"type":"paragraph","content":[{"text":"Stand By Me","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His first album came out in 2010 and led with a bachata version of Ben E. King’s Stand By Me, sung half in English and half in Spanish. It went to number one on the tropical chart, and Corazón Sin Cara did the same.","type":"text"}]},{"type":"paragraph","content":[{"text":"That single is the thesis of the whole career and it was there from the first record. Take a song the whole hemisphere already knows in English, put it over a bachata guitar, sing it in both languages, and let two audiences hear something that belongs to each of them. Nothing he has done since departs from it.","type":"text"}]},{"type":"paragraph","content":[{"text":"It also made him the most audible answer to a question the genre had been asking for years — whether bachata could leave the barrio without stopping being bachata. He is one of the names that closes the distance between the founding generation and the present, and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos","occurrenceId":"7dc492fc-b2f8-406b-8ac9-fbdf4e821e06"}},{"text":"’s own record shows the same crossing from the other side.","type":"text"}]},{"type":"paragraph","content":[{"text":"The albums","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Phase II followed in 2012, went platinum and was nominated for the tropical Latin Grammy. Soy El Mismo came in 2013 with Darte Un Beso, which topped the Hot Latin Songs chart. Double Vision, in 2015, was his English-language album and produced Back It Up with Jennifer Lopez and Pitbull.","type":"text"}]},{"type":"paragraph","content":[{"text":"Five arrived in 2017 with a guest list that reads like a map of where Latin music had got to — Shakira, Chris Brown, Zendaya, Farruko, Gente de Zona, Arturo Sandoval — and it was his fourth number one. Then a long run of collaborations across genres, and Alter Ego in 2020, a double record split into two halves with different names.","type":"text"}]},{"type":"paragraph","content":[{"text":"Llamada Perdida, in 2024, is the outlier: a heartbreak album, personal and unornamented, made by someone who had spent fifteen years making records for stadiums. He has also shared a Dominican stage with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4c291d80-954a-4c8f-8f82-6317253b26d8","displayText":"Esme","occurrenceId":"1a26846f-cf76-410d-ab7d-869872094b15"}},{"text":", which is what the older names in this genre do for the younger ones.","type":"text"}]},{"type":"paragraph","content":[{"text":"Eterno","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His eighth album came out in May 2025 and is the idea from Stand By Me carried to its conclusion. Thirteen English-language pop standards — the Beatles, the Bee Gees, Elvis, the Backstreet Boys, Richard Marx — rebuilt as bilingual bachata. Yesterday. How Deep Is Your Love. I Want It That Way.","type":"text"}]},{"type":"paragraph","content":[{"text":"A record like that could be a novelty and is not, because he has been doing exactly this since he was twenty-one and because the arrangements take the songs seriously. What it argues is that bachata is not a regional flavour you apply to foreign material but a form capable of holding anything you put in it.","type":"text"}]},{"type":"paragraph","content":[{"text":"He tours with Romeo Santos now, the two largest names the genre has produced, and Miami-Dade has a day named after him. The kid cleaning display cases in a phone shop was the same person planning all of it.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'prince-royce'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Prince Royce, de nombre Geoffrey Royce Rojas de León, es cantante y compositor de bachata dominicano-estadounidense. Agarró la más dominicana de las músicas de guitarra, la cantó en dos idiomas ante un público criado con la radio estadounidense, y la convirtió en una de las carreras más grandes que ha dado el género.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Bronx","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en el Bronx en 1989, de padres dominicanos, y se crió entre dos idiomas, que es la condición corriente de su generación en Nueva York y resulta ser la explicación entera de su música.","type":"text"}]},{"type":"paragraph","content":[{"text":"Empezó a escribir poesía a los trece años y canciones a los dieciséis, y fue entonces cuando tomó el nombre de Prince Royce. A los dieciocho cantó en un programa de variedades en español. Trabajó en una tienda de teléfonos para pagar músicos y horas de estudio, que es la parte de la historia que más cuenta y la que explica la disciplina.","type":"text"}]},{"type":"paragraph","content":[{"text":"A los diecinueve un mánager oyó una maqueta y lo empujó hacia la bachata en concreto —no había llegado ahí necesariamente por su cuenta— y le presentó a un productor con sello. Ahí está la bisagra. Un muchacho del Bronx que escribía canciones bilingües podía haber ido por media docena de caminos; alguien le señaló la música de sus padres.","type":"text"}]},{"type":"paragraph","content":[{"text":"Stand By Me","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su primer disco salió en 2010 y abría con una versión en bachata del Stand By Me de Ben E. King, cantada mitad en inglés y mitad en español. Llegó al número uno de la lista tropical, y Corazón Sin Cara hizo lo mismo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ese sencillo es la tesis de toda la carrera y ya estaba en el primer disco. Agarrar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas, y dejar que dos públicos oigan algo que le pertenece a cada uno. Nada de lo que ha hecho después se aparta de eso.","type":"text"}]},{"type":"paragraph","content":[{"text":"Lo convirtió además en la respuesta más audible a una pregunta que el género llevaba años haciéndose: si la bachata podía salir del barrio sin dejar de ser bachata. Es uno de los nombres que cierra la distancia entre la generación fundadora y el presente, y la ficha del propio ","type":"text"},{"type":"artistReference","attrs":{"artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos","occurrenceId":"8ad81bdb-75c8-4360-a1c5-8c1c34be8640"}},{"text":" muestra ese mismo cruce desde el otro lado.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los álbumes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Phase II vino en 2012, fue disco de platino y quedó nominado al Grammy Latino tropical. Soy El Mismo llegó en 2013 con Darte Un Beso, que encabezó la lista Hot Latin Songs. Double Vision, en 2015, fue su disco en inglés y de ahí salió Back It Up con Jennifer Lopez y Pitbull.","type":"text"}]},{"type":"paragraph","content":[{"text":"Five apareció en 2017 con una lista de invitados que se lee como un mapa de dónde había llegado la música latina —Shakira, Chris Brown, Zendaya, Farruko, Gente de Zona, Arturo Sandoval— y fue su cuarto número uno. Después una tanda larga de colaboraciones entre géneros, y en 2020 Alter Ego, un disco doble partido en dos mitades con nombre propio cada una.","type":"text"}]},{"type":"paragraph","content":[{"text":"Llamada Perdida, de 2024, es la excepción: un disco de desamor, personal y sin adornos, hecho por alguien que llevaba quince años grabando para estadios. Ha compartido además tarima dominicana con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4c291d80-954a-4c8f-8f82-6317253b26d8","displayText":"Esme","occurrenceId":"ebcb537a-f696-42f4-a174-796a53f5c0b4"}},{"text":", que es lo que los nombres mayores de este género hacen por los jóvenes.","type":"text"}]},{"type":"paragraph","content":[{"text":"Eterno","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su octavo álbum salió en mayo de 2025 y es la idea de Stand By Me llevada hasta el final. Trece clásicos del pop anglosajón —los Beatles, los Bee Gees, Elvis, los Backstreet Boys, Richard Marx— rehechos como bachata bilingüe. Yesterday. How Deep Is Your Love. I Want It That Way.","type":"text"}]},{"type":"paragraph","content":[{"text":"Un disco así podría ser una curiosidad y no lo es, porque lleva haciendo exactamente esto desde los veintiún años y porque los arreglos se toman las canciones en serio. Lo que argumenta es que la bachata no es un sabor regional que se le aplica a material ajeno, sino una forma capaz de sostener cualquier cosa que se le meta dentro.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ahora sale de gira con Romeo Santos, los dos nombres más grandes que ha dado el género, y el condado de Miami-Dade tiene un día con su nombre. El muchacho que limpiaba vitrinas en una tienda de teléfonos era la misma persona que estaba planificando todo esto.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'prince-royce'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'prince-royce') AND locale = 'en'), '1a26846f-cf76-410d-ab7d-869872094b15', 'artist', '4c291d80-954a-4c8f-8f82-6317253b26d8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'prince-royce') AND locale = 'en'), '7dc492fc-b2f8-406b-8ac9-fbdf4e821e06', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'prince-royce') AND locale = 'es'), '8ad81bdb-75c8-4360-a1c5-8c1c34be8640', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'prince-royce') AND locale = 'es'), 'ebcb537a-f696-42f4-a174-796a53f5c0b4', 'artist', '4c291d80-954a-4c8f-8f82-6317253b26d8');

COMMIT;
