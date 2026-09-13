BEGIN;

-- Rewrite the catalogue entry for Don Miguelo.
--
-- Don Miguelo. UNDÉCIMA de las 211, con 14 enlaces entrantes. 928 caracteres, y
-- con DOS ERRORES DE DATO, uno de ellos un apellido inventado.
--
-- ---------------------------------------------------------------------------
-- EL APELLIDO ERA FALSO Y LA PROPIA FILA LO DESMENTÍA
--
-- El texto publicado empezaba: "Don Miguelo, born MIGUEL ÁNGEL DÍAZ in 1981".
-- La fila guarda last_name 'Valerio' y second_last_name 'Lebrón'.
--
-- LA FILA TIENE RAZÓN: se llama MIGUEL ÁNGEL VALERIO LEBRÓN, y Wikipedia lo
-- confirma con referencia. "Díaz" no sale de ninguna parte.
--
-- Es el tercer apellido inventado que encuentro hoy, después del "Hanthony
-- Dawson Hurtado" de Bulin 47 y del "Juan Pablo" que casi le pongo a Pacheco. La
-- diferencia aquí es que el dato correcto YA ESTABA EN LA FILA y el texto lo
-- contradecía: quien escribió el molde no miró los campos que tenía delante.
-- ---------------------------------------------------------------------------
--
-- EL HANDLE DE YOUTUBE ESTABA MUERTO. La fila guardaba '@donmiguelotv' y DA 404.
-- Aquí sí es un 404 de verdad y no el problema de codificación que casi me hace
-- borrar el de Toño Rosario esta mañana: no hay caracteres no ASCII de por
-- medio.
--
-- Su canal real es '@DonMigueloDM', con 1.84 millones de suscriptores y 3.900
-- videos, y su propia descripción dice "Canal Oficial de Don Miguelo". Se
-- corrige el campo.
--
-- LO QUE FALTABA, QUE ES TODO LO CONCRETO. La ficha vieja hablaba de "a string
-- of hits", "viral hits and sold-out performances" y "earworm melodies" sin
-- nombrar UNA canción. Las suyas son:
--
--   "QUE TÚ QUIERES", más conocida como "LA COLA DE MOTORA", de su primer disco
--   "Contra el Tiempo". La produjo él mismo y con ella ganó su primer Casandra.
--   Él mismo dijo después que el éxito lo sorprendió.
--
--   "COMO YO LE DOY", "Y Que Fue?", "Con Don Miguelo", "Pa Que Me Dan De Eso",
--   "Nota de Pasión", "Adicción al Contacto", y "El Mario de Tu Mujer" con
--   Sensato.
--
--   "LO VIBRO", con Bulin 47, cuya ficha escribí esta tarde.
--
--   "EMDP (The Last Album)", su disco reciente, con "La 5 70", "Mandarte al
--   Diablo", "Me Empute" y "No Te Lo Metí".
--
-- DOS PREMIOS CASANDRA que no estaban ni en la prosa ni en la tabla: ARTISTA
-- REVELACIÓN en 2006 y MEJOR ARTISTA URBANO en 2012. Por el segundo, el alcalde
-- de San Francisco de Macorís lo declaró hijo distinguido.
--
-- SU PRIMER DISCO SE HIZO EN EL PAÍS y con gente del catálogo: la fuente dice
-- que "Contra el Tiempo" fue mezclado y creado en la República Dominicana e
-- incluye el trabajo de Rafy Mercenario, FRANK REYES y MONCHY & ALEXANDRA. Dos
-- de esos tres están publicados y se enlazan. Que un disco urbano de 2006
-- llevara dentro a un bachatero y a un dúo de bachata dice bastante sobre cómo
-- se hacía la música urbana dominicana antes de que tuviera industria propia.
--
-- LOS OFICIOS ANTES DE LA MÚSICA ENTRAN: fue sastre, ebanista y locutor de
-- radio. Es historia laboral, mismo criterio que con Leonardo Paniagua y Blas
-- Durán.
--
-- LO QUE SE DEJA FUERA, Y ES BASTANTE: que su madre lo abandonó, que su padre
-- estuvo ausente, que lo criaron sus abuelos, su pareja y su hija. Y LA PRISIÓN
-- PREVENTIVA DE 2012 con la acusación que la motivó. Asunto penal: no entra, y
-- no se alude con eufemismos, que es el error que corregí en martha-heredia.
--
-- NO SE ESCRIBEN LAS REPRODUCCIONES, que en su canal son enormes.
--
-- aliases guardaba 'Miguel Angel Valerio', el nombre legal sin acentos y a
-- medias. DECIMOTERCER caso del patrón. Sale; queda "El Mejor del Bloque".
--
-- CUATRO ENLACES: frank-reyes y monchy-alexandra (los dos en "Contra el
-- Tiempo"), bulin-47 ("Lo Vibro") y chimbala, con quien compartió el segmento
-- urbano de los Premios Soberano de 2018 y cuya ficha escribí hace un rato.
--
-- FUENTES: Wikipedia en español, con citas a Listín Diario, Diario Libre y El
-- Caribe. El canal oficial de YouTube para el catálogo de canciones y para
-- corregir el handle.
--
-- NOMBRES NUEVOS PARA LA LISTA: RAFY MERCENARIO, productor que trabajó en su
-- primer disco, y SENSATO, con quien grabó "El Mario de Tu Mujer". Ninguno está.
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
       name = 'Don Miguelo',
       sort_name = 'Valerio Lebrón, Miguel Ángel',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urbano',
       date_of_birth = '1981-08-27',
       birth_year = 1981,
       date_of_death = NULL,
       birth_place = 'San Francisco de Macorís',
       province = 'Duarte',
       first_name = 'Miguel',
       middle_name = 'Ángel',
       last_name = 'Valerio',
       second_last_name = 'Lebrón',
       stage_name = 'Don Miguelo',
       aliases = ARRAY['El Mejor del Bloque']::text[],
       occupations = '["producer","composer","rapper"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY['urban-dembow', 'urban-reggaeton']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@DonMigueloDM',
       facebook = NULL,
       instagram = 'donmiguelo',
       disambiguation = 'Urban singer and producer from San Francisco de Macorís; two-time Casandra winner',
       bio_en = 'Miguel Ángel Valerio Lebrón, who records as Don Miguelo, is a Dominican rapper, singer and producer from San Francisco de Macorís. He has been working since 2001 and produces much of his own material, which is less common in the genre than it sounds.

**Before the music**

He was born in 1981 in San Francisco de Macorís, in the province of Duarte. Before he made a living from music he worked as a tailor, as a cabinetmaker and as a radio disc jockey — the last of those being the job that put him closest to the thing he ended up doing.

**La Cola de Motora**

His first album, Contra el Tiempo, carried Que Tú Quieres, which everybody calls La Cola de Motora. He produced it himself, and he has said since that its success surprised him as much as anyone. It won him the Casandra award for revelation of the year in 2006.

The record was mixed and made in the Dominican Republic, and the people on it say something about how Dominican urban music was made before it had an industry of its own: alongside the producer Rafy Mercenario it carries work by Frank Reyes and Monchy & Alexandra, a bachata singer and a bachata duo on an urban record.

**Como Yo Le Doy**

The catalogue after that is long and stays inside the same register: Como Yo Le Doy, Y Que Fue?, Con Don Miguelo, Pa Que Me Dan De Eso, Nota de Pasión, Adicción al Contacto, and El Mario de Tu Mujer with the Dominican-American rapper Sensato.

He has worked across the scene rather than beside it. Lo Vibro was made with Bulin 47, and he shared the urban segment of the Premios Soberano with Chimbala and others in 2018.

**Hijo distinguido**

He performed at the opening of the Casandra awards in 2012 and won the urban artist category that night. The mayor of San Francisco de Macorís gave him a plaque as a distinguished son of the city on the strength of that second award, which is the kind of recognition Dominican urban artists were not getting at the time.

In 2018 he recorded a remix of Sufriendo de Amor with the Puerto Ricans Papi Wilo and Ñejo, and he later released EMDP, subtitled The Last Album, which carries La 5 70, Mandarte al Diablo, Me Empute and No Te Lo Metí.',
       bio_es = 'Miguel Ángel Valerio Lebrón, que graba como Don Miguelo, es un rapero, cantante y productor dominicano de San Francisco de Macorís. Trabaja desde 2001 y produce buena parte de su propio material, cosa menos común en el género de lo que parece.

**Antes de la música**

Nació en 1981 en San Francisco de Macorís, provincia Duarte. Antes de vivir de la música trabajó de sastre, de ebanista y de locutor de radio, siendo este último el oficio que más cerca lo puso de lo que terminaría haciendo.

**La Cola de Motora**

Su primer disco, Contra el Tiempo, traía Que Tú Quieres, que todo el mundo llama La Cola de Motora. La produjo él mismo, y ha contado después que el éxito lo sorprendió tanto como a cualquiera. Con ella ganó el Casandra a la revelación del año en 2006.

El disco se mezcló y se hizo en la República Dominicana, y quiénes están dentro dice algo sobre cómo se hacía la música urbana dominicana antes de tener industria propia: junto al productor Rafy Mercenario lleva trabajo de Frank Reyes y de Monchy & Alexandra, un bachatero y un dúo de bachata dentro de un disco urbano.

**Como Yo Le Doy**

El catálogo posterior es largo y se mantiene en el mismo registro: Como Yo Le Doy, Y Que Fue?, Con Don Miguelo, Pa Que Me Dan De Eso, Nota de Pasión, Adicción al Contacto, y El Mario de Tu Mujer con el rapero dominicano-americano Sensato.

Ha trabajado dentro de la escena y no al lado. Lo Vibro la hizo con Bulin 47, y compartió el segmento urbano de los Premios Soberano con Chimbala y otros en 2018.

**Hijo distinguido**

Actuó en la apertura de los Premios Casandra de 2012 y ganó esa noche la categoría de mejor artista urbano. El alcalde de San Francisco de Macorís le entregó una placa como hijo distinguido de la ciudad a raíz de ese segundo premio, que es el tipo de reconocimiento que los artistas urbanos dominicanos no estaban recibiendo entonces.

En 2018 grabó un remix de Sufriendo de Amor con los puertorriqueños Papi Wilo y Ñejo, y más adelante publicó EMDP, subtitulado The Last Album, que lleva La 5 70, Mandarte al Diablo, Me Empute y No Te Lo Metí.',
       updated_at = now()
 WHERE slug = 'don-miguelo';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'don-miguelo')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'don-miguelo')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Miguel Ángel Valerio Lebrón, who records as Don Miguelo, is a Dominican rapper, singer and producer from San Francisco de Macorís. He has been working since 2001 and produces much of his own material, which is less common in the genre than it sounds.","type":"text"}]},{"type":"paragraph","content":[{"text":"Before the music","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1981 in San Francisco de Macorís, in the province of Duarte. Before he made a living from music he worked as a tailor, as a cabinetmaker and as a radio disc jockey — the last of those being the job that put him closest to the thing he ended up doing.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Cola de Motora","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His first album, Contra el Tiempo, carried Que Tú Quieres, which everybody calls La Cola de Motora. He produced it himself, and he has said since that its success surprised him as much as anyone. It won him the Casandra award for revelation of the year in 2006.","type":"text"}]},{"type":"paragraph","content":[{"text":"The record was mixed and made in the Dominican Republic, and the people on it say something about how Dominican urban music was made before it had an industry of its own: alongside the producer Rafy Mercenario it carries work by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes","occurrenceId":"6cf37542-59c5-45cd-9d21-0ad6f53e6bea"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra","occurrenceId":"3a997e25-548f-44a6-84f1-d87b89b6d44b"}},{"text":", a bachata singer and a bachata duo on an urban record.","type":"text"}]},{"type":"paragraph","content":[{"text":"Como Yo Le Doy","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The catalogue after that is long and stays inside the same register: Como Yo Le Doy, Y Que Fue?, Con Don Miguelo, Pa Que Me Dan De Eso, Nota de Pasión, Adicción al Contacto, and El Mario de Tu Mujer with the Dominican-American rapper Sensato.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has worked across the scene rather than beside it. Lo Vibro was made with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47","occurrenceId":"72b3eb65-d1e8-48f7-809c-549f2310fea2"}},{"text":", and he shared the urban segment of the Premios Soberano with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala","occurrenceId":"122deb94-2fac-4aeb-9fab-d9f2b5ebf667"}},{"text":" and others in 2018.","type":"text"}]},{"type":"paragraph","content":[{"text":"Hijo distinguido","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He performed at the opening of the Casandra awards in 2012 and won the urban artist category that night. The mayor of San Francisco de Macorís gave him a plaque as a distinguished son of the city on the strength of that second award, which is the kind of recognition Dominican urban artists were not getting at the time.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 2018 he recorded a remix of Sufriendo de Amor with the Puerto Ricans Papi Wilo and Ñejo, and he later released EMDP, subtitled The Last Album, which carries La 5 70, Mandarte al Diablo, Me Empute and No Te Lo Metí.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'don-miguelo'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Miguel Ángel Valerio Lebrón, que graba como Don Miguelo, es un rapero, cantante y productor dominicano de San Francisco de Macorís. Trabaja desde 2001 y produce buena parte de su propio material, cosa menos común en el género de lo que parece.","type":"text"}]},{"type":"paragraph","content":[{"text":"Antes de la música","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1981 en San Francisco de Macorís, provincia Duarte. Antes de vivir de la música trabajó de sastre, de ebanista y de locutor de radio, siendo este último el oficio que más cerca lo puso de lo que terminaría haciendo.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Cola de Motora","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su primer disco, Contra el Tiempo, traía Que Tú Quieres, que todo el mundo llama La Cola de Motora. La produjo él mismo, y ha contado después que el éxito lo sorprendió tanto como a cualquiera. Con ella ganó el Casandra a la revelación del año en 2006.","type":"text"}]},{"type":"paragraph","content":[{"text":"El disco se mezcló y se hizo en la República Dominicana, y quiénes están dentro dice algo sobre cómo se hacía la música urbana dominicana antes de tener industria propia: junto al productor Rafy Mercenario lleva trabajo de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes","occurrenceId":"eb3d5e7a-42af-4423-a02e-fb40865d47ec"}},{"text":" y de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra","occurrenceId":"36f8d4e8-d4ed-4851-a968-9164d69c4759"}},{"text":", un bachatero y un dúo de bachata dentro de un disco urbano.","type":"text"}]},{"type":"paragraph","content":[{"text":"Como Yo Le Doy","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El catálogo posterior es largo y se mantiene en el mismo registro: Como Yo Le Doy, Y Que Fue?, Con Don Miguelo, Pa Que Me Dan De Eso, Nota de Pasión, Adicción al Contacto, y El Mario de Tu Mujer con el rapero dominicano-americano Sensato.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ha trabajado dentro de la escena y no al lado. Lo Vibro la hizo con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47","occurrenceId":"eae974b8-9bdb-4b92-bf9f-0223acc275d0"}},{"text":", y compartió el segmento urbano de los Premios Soberano con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala","occurrenceId":"a9377b59-34f1-4db9-ba2b-c3f634301870"}},{"text":" y otros en 2018.","type":"text"}]},{"type":"paragraph","content":[{"text":"Hijo distinguido","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Actuó en la apertura de los Premios Casandra de 2012 y ganó esa noche la categoría de mejor artista urbano. El alcalde de San Francisco de Macorís le entregó una placa como hijo distinguido de la ciudad a raíz de ese segundo premio, que es el tipo de reconocimiento que los artistas urbanos dominicanos no estaban recibiendo entonces.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 2018 grabó un remix de Sufriendo de Amor con los puertorriqueños Papi Wilo y Ñejo, y más adelante publicó EMDP, subtitulado The Last Album, que lleva La 5 70, Mandarte al Diablo, Me Empute y No Te Lo Metí.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'don-miguelo'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'don-miguelo') AND locale = 'en'), '122deb94-2fac-4aeb-9fab-d9f2b5ebf667', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'don-miguelo') AND locale = 'en'), '3a997e25-548f-44a6-84f1-d87b89b6d44b', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'don-miguelo') AND locale = 'en'), '6cf37542-59c5-45cd-9d21-0ad6f53e6bea', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'don-miguelo') AND locale = 'en'), '72b3eb65-d1e8-48f7-809c-549f2310fea2', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'don-miguelo') AND locale = 'es'), '36f8d4e8-d4ed-4851-a968-9164d69c4759', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'don-miguelo') AND locale = 'es'), 'a9377b59-34f1-4db9-ba2b-c3f634301870', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'don-miguelo') AND locale = 'es'), 'eae974b8-9bdb-4b92-bf9f-0223acc275d0', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'don-miguelo') AND locale = 'es'), 'eb3d5e7a-42af-4423-a02e-fb40865d47ec', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9');

COMMIT;
