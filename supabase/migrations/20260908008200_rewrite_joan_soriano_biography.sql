BEGIN;

-- Rewrite the catalogue entry for Joan Soriano.
--
-- Joan Soriano. DECIMONOVENA de las 211. 1.333 caracteres, tres parrafos, y ni
-- una cancion, ni un disco, ni un ano, ni un colaborador.
--
-- Lo que si hacia era explicar largamente que su musica es "a counterpoint to
-- the polished, internationally marketed version of the genre" y hablar de "the
-- raw beauty of bachata in its most traditional form". Es una tesis sobre el
-- genero con su nombre encima, el mismo defecto que tenian Chimbala y Edilio
-- Paredes.
--
-- EL NOMBRE LEGAL ESTABA MAL: la fila guardaba first_name 'Joan' y last_name
-- 'Soriano', que es el nombre artistico metido en los campos del legal. Se
-- llama JUAN BIENVENIDO SEVERINO SORIANO. Cuarta vez esta semana con el mismo
-- patron -- Joe Veras, Rafa Rosario, El Chaval y ahora este.
--
-- Y NO TENIA FECHA DE NACIMIENTO, solo el ano. Nacio el 23 DE FEBRERO DE 1972.
--
-- TRAMPA DE ESQUEMA NUEVA, para la bitacora: `birth_day` y `birth_month` son
-- COLUMNAS GENERADAS y no se pueden escribir -- Postgres responde "can only be
-- updated to DEFAULT". Basta con poner `date_of_birth` y las otras dos salen
-- solas. Es la misma trampa de `pair_low`/`pair_high` en la tabla de
-- parentescos.
--
-- LO QUE FALTABA, QUE ES TODO, Y ES UNA VIDA MUY CONTABLE:
--
--   SE FABRICO SU PRIMERA GUITARRA CON HILO DE PESCAR Y UNA CAJA DE METAL
--   TIRADA. Apenas fue a la escuela; ayudaba a su padre a trabajar la tierra.
--
--   LA BANDA FAMILIAR SE LLAMABA "LOS CANDES", por su padre Candelario, y la
--   armo con sus hermanos siendo ninos. A LOS TRECE SE FUE A SANTO DOMINGO
--   PIDIENDO BOLA y se puso a trabajar de musico de sesion.
--
--   ESO ES LO QUE LA FICHA VIEJA NO DECIA Y CAMBIA QUIEN ES: desde los ochenta
--   SU GUITARRA Y SUS ARREGLOS ESTAN EN EXITOS DE BACHATA DE OTROS. Es el mismo
--   oficio de Edilio Paredes, cuya ficha escribi hace un rato. No es un
--   descubrimiento del circuito de world music: es un musico de estudio con
--   veinte anos de trabajo antes de que nadie lo grabara a su nombre.
--
--   TOCA PALO Y GAGA, tradiciones sacras afrodominicanas, y las mete en la
--   bachata. Ese es el dato tecnico que explica por que los bailadores lo
--   buscan, y no estaba.
--
--   "EL DUQUE DE LA BACHATA" (septiembre de 2010, iASO), grabado EN VIVO en
--   estudios de Santo Domingo y Nueva York por Benjamin de Menil. Semanas en el
--   top diez de Tropical Albums de Billboard y MEJOR ALBUM WORLD BEAT del Indie
--   Acoustic Project.
--
--   "BACHATA BREAKDOWN EN VIVO" (2011), con Aventura y Monchy & Alexandra: un
--   video y un disco que DESMONTAN LA BACHATA INSTRUMENTO POR INSTRUMENTO sobre
--   los ritmos derecho, majao y mambo. No conozco otra cosa igual en el
--   catalogo.
--
--   "LA FAMILIA SORIANO" (abril de 2012), tocando con sus hermanos NELLY,
--   GRISELDA y FERNANDO. DEBUTO EN EL TERCER PUESTO de Tropical Albums.
--
--   "BACHATA HAITI" (2018): LAS PRIMERAS GRABACIONES DE BACHATA EN CREOL,
--   cantadas en creol y en espanol por musicos haitiano-dominicanos que el
--   dirige. La fuente dice que el proyecto se penso como alternativa a una
--   cobertura mediatica que solo mira el conflicto entre los dos paises. Es el
--   dato mas importante de la ficha y no estaba en ninguna parte.
--
--   DOS DOCUMENTALES: "The Duke of Bachata" (2009), de Adam Taub, del que es
--   protagonista, y "Santo Domingo Blues" (2005), de Alex Wolfe.
--
-- LOS HERMANOS VAN EN PROSA Y NO EN LA TABLA, y esta vez no es por falta de
-- filas: GRISELDA Y FERNANDO SORIANO TIENEN FICHA Y LOS TRES PARENTESCOS YA
-- ESTAN REGISTRADOS. Pero las dos filas estan en `needs_review`, y una
-- referencia a un artista sin publicar sale como texto muerto, asi que NO SE
-- PUEDEN ENLAZAR. Quedan nombrados y anotados: publicarlos es lo que falta.
--
-- NELLY SORIANO no tiene ficha y va a la lista.
--
-- LO QUE SE DEJA FUERA: que es el septimo de quince hermanos y los nombres de
-- sus padres. Vida privada. SI ENTRA que dejo la escuela para trabajar la
-- tierra, que es historia laboral, mismo criterio que con Joe Veras y El Chaval.
--
-- EL ALIAS 'Yoan Soriano' DE MUSICBRAINZ NO SE ANADE: esta marcado como "Artist
-- name" pero no lo respalda ninguna otra fuente y huele a variante de grafia.
-- Anotado en ortografia.
--
-- LAS CUATRO REDES DE LA FILA RESPONDEN, incluida la web propia. El handle de
-- YouTube es feo -- '@joansorianoysubandaloscand3620' -- pero es el suyo y
-- nombra a Los Candes, asi que se queda.
--
-- TRES ENLACES, que son pocos y son los que hay: Edilio Paredes y Ramon Cordero,
-- con quienes formo The Bachata Legends, y Monchy & Alexandra, del Bachata
-- Breakdown. Su trabajo de sesion de los ochenta y noventa esta sin acreditar en
-- las fuentes: dicen "algunas de las mayores estrellas de la isla" y no dan
-- nombres.
--
-- AVENTURA SE NOMBRA SIN ENLACE: no tiene ficha propia, solo existe como alias
-- sobre henry-santos. Ya estaba en la lista de ausencias.
--
-- EL GATE REPARADO MORDIO ESTA MISMA FICHA, y conviene que quede: escribi
-- "which is the part of his career that explains the rest of it" y el patron
-- 'comenta el dato en vez de exponerlo' la paro antes de aplicarse. Es la
-- primera ficha despues de arreglar los caracteres de retroceso, asi que sirve
-- de prueba en caliente. La frase sale y los dos datos se quedan sueltos.
--
-- FUENTES: Wikipedia en ingles, bien referenciada a NPR, al Kennedy Center y a
-- iASO -- NO HAY ARTICULO EN ESPANOL. La ficha del Kennedy Center, que es la mas
-- completa y da los nombres de los hermanos. iASO Records. World Music Central
-- (16 de mayo de 2011) para el premio.
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
       name = 'Joan Soriano',
       sort_name = 'Soriano, Joan',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1972-02-23',
       birth_year = 1972,
       date_of_death = NULL,
       birth_place = 'Monte Plata',
       province = 'Monte Plata',
       first_name = 'Juan',
       middle_name = 'Bienvenido',
       last_name = 'Severino',
       second_last_name = 'Soriano',
       stage_name = 'Joan Soriano',
       aliases = ARRAY['El Duque de la Bachata']::text[],
       occupations = '["composer","guitarist","arranger"]'::jsonb,
       instruments = ARRAY['voice', 'guitar']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'instrumental']::text[],
       website = 'https://joansorianomusic.com',
       youtube = '@joansorianoysubandaloscand3620',
       facebook = 'JoanSorianoMusic',
       instagram = 'joansorianomusic',
       disambiguation = 'Bachata guitarist and singer billed as El Duque de la Bachata; led the first bachata sung in Creole',
       bio_en = 'Juan Bienvenido Severino Soriano, who records as Joan Soriano and is billed as El Duque de la Bachata, is a Dominican bachata guitarist and singer. Since the nineteen-eighties his guitar and his arrangements have appeared on other people’s bachata hits, and since 2008 he has been recording under his own name for audiences outside the country.

**A guitar made from fishing line**

He was born on 23 February 1972 in Monte Plata, in the countryside outside Santo Domingo. He had little schooling and spent his childhood helping his father work the family’s land. His first guitar he made himself, out of fishing line and a discarded metal box.

He and his brothers and sisters put together a family band, known as Los Candes after their father Candelario, and it became a fixture at events around the neighbourhood. At thirteen he hitched a ride to Santo Domingo and began working as a session musician alongside the established names of the genre. He was twenty years into that work before anyone recorded him under his own name.

**Palo and gagá**

He plays palo and gagá, the Afro-Dominican sacred traditions, and brings their rhythmic base into his bachata, which is what dancers respond to in his records. He plays steel strings, and the sound is closer to the acoustic bachata of the sixties than to the guitar tone the genre adopted after it went electric.

**El Duque de la Bachata**

His first international release came in September 2010 on iASO Records. El Duque de la Bachata was recorded live in studios in Santo Domingo and New York by the producer Benjamin de Menil, spent weeks inside the top ten of Billboard’s Tropical Albums chart and took the world beat album award from the Indie Acoustic Project. Before it he had released Joan Soriano aka El Duque en Pampers, Vocales de Amor and Afro Bachata, and appeared on the Rough Guide to Bachata compilation.

**Bachata Breakdown**

In 2011 he made Bachata Breakdown En Vivo with Aventura and Monchy & Alexandra. It is a video and record that take the music apart instrument by instrument across its three rhythms — derecho, majao and mambo — which is an unusual thing for working musicians to sit down and do.

La Familia Soriano followed in April 2012, made with his siblings Nelly, Griselda and Fernando, and entered the Billboard Tropical Albums chart at number three. He has since re-formed the family band with Fernando and Griselda.

**Bachata Haití**

In 2018 he led Bachata Haití, the first bachata recorded in Creole. The songs are sung in Creole and in Spanish by a group of Haitian-Dominican musicians, and the record was conceived as a counterweight to coverage that treats the relationship between the two countries only as a conflict.

**On film and on the road**

He is the subject of Adam Taub’s documentary The Duke of Bachata, from 2009, and appears in Alex Wolfe’s Santo Domingo Blues. He has toured across the United States and Europe, and formed The Bachata Legends with Ramón Cordero and Edilio Paredes to carry the older acoustic style abroad.',
       bio_es = 'Juan Bienvenido Severino Soriano, que graba como Joan Soriano y se anuncia como El Duque de la Bachata, es un guitarrista y cantante dominicano de bachata. Desde los años ochenta su guitarra y sus arreglos están en éxitos de bachata de otros, y desde 2008 graba a su nombre para públicos de fuera del país.

**Una guitarra de hilo de pescar**

Nació el 23 de febrero de 1972 en Monte Plata, en el campo a las afueras de Santo Domingo. Fue poco a la escuela y pasó la infancia ayudando a su padre a trabajar la tierra de la familia. La primera guitarra se la fabricó él, con hilo de pescar y una caja de metal tirada.

Con sus hermanos armó una banda familiar, conocida como Los Candes por su padre Candelario, que se hizo habitual en las actividades del barrio. A los trece se fue a Santo Domingo pidiendo bola y empezó a trabajar de músico de sesión junto a los nombres ya establecidos del género. Llevaba veinte años en ese oficio antes de que nadie lo grabara a su nombre.

**Palo y gagá**

Toca palo y gagá, las tradiciones sacras afrodominicanas, y mete su base rítmica dentro de la bachata, que es lo que los bailadores encuentran en sus discos. Toca con cuerdas de acero, y el sonido queda más cerca de la bachata acústica de los sesenta que del timbre que el género adoptó al electrificarse.

**El Duque de la Bachata**

Su primera edición internacional salió en septiembre de 2010 con iASO Records. El Duque de la Bachata se grabó en vivo en estudios de Santo Domingo y Nueva York con el productor Benjamin de Menil, pasó semanas dentro del top diez de la lista Tropical Albums de Billboard y se llevó el premio al álbum world beat del Indie Acoustic Project. Antes había publicado Joan Soriano aka El Duque en Pampers, Vocales de Amor y Afro Bachata, y había aparecido en el recopilatorio Rough Guide to Bachata.

**Bachata Breakdown**

En 2011 hizo Bachata Breakdown En Vivo con Aventura y Monchy & Alexandra. Es un video y un disco que desmontan la música instrumento por instrumento a través de sus tres ritmos —derecho, majao y mambo—, cosa poco común entre músicos en activo.

La Familia Soriano llegó en abril de 2012, hecha con sus hermanos Nelly, Griselda y Fernando, y entró en el tercer puesto de la lista Tropical Albums de Billboard. Desde entonces ha vuelto a armar la banda familiar con Fernando y Griselda.

**Bachata Haití**

En 2018 encabezó Bachata Haití, la primera bachata grabada en creol. Las canciones las cantan en creol y en español músicos haitiano-dominicanos, y el disco se pensó como contrapeso a una cobertura que trata la relación entre los dos países únicamente como un conflicto.

**En el cine y en la carretera**

Es el protagonista del documental The Duke of Bachata, de Adam Taub, de 2009, y aparece en Santo Domingo Blues, de Alex Wolfe. Ha girado por Estados Unidos y Europa, y formó The Bachata Legends con Ramón Cordero y Edilio Paredes para llevar fuera el estilo acústico antiguo.',
       updated_at = now()
 WHERE slug = 'joan-soriano';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joan-soriano')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joan-soriano')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan Bienvenido Severino Soriano, who records as Joan Soriano and is billed as El Duque de la Bachata, is a Dominican bachata guitarist and singer. Since the nineteen-eighties his guitar and his arrangements have appeared on other people’s bachata hits, and since 2008 he has been recording under his own name for audiences outside the country.","type":"text"}]},{"type":"paragraph","content":[{"text":"A guitar made from fishing line","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born on 23 February 1972 in Monte Plata, in the countryside outside Santo Domingo. He had little schooling and spent his childhood helping his father work the family’s land. His first guitar he made himself, out of fishing line and a discarded metal box.","type":"text"}]},{"type":"paragraph","content":[{"text":"He and his brothers and sisters put together a family band, known as Los Candes after their father Candelario, and it became a fixture at events around the neighbourhood. At thirteen he hitched a ride to Santo Domingo and began working as a session musician alongside the established names of the genre. He was twenty years into that work before anyone recorded him under his own name.","type":"text"}]},{"type":"paragraph","content":[{"text":"Palo and gagá","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He plays palo and gagá, the Afro-Dominican sacred traditions, and brings their rhythmic base into his bachata, which is what dancers respond to in his records. He plays steel strings, and the sound is closer to the acoustic bachata of the sixties than to the guitar tone the genre adopted after it went electric.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Duque de la Bachata","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His first international release came in September 2010 on iASO Records. El Duque de la Bachata was recorded live in studios in Santo Domingo and New York by the producer Benjamin de Menil, spent weeks inside the top ten of Billboard’s Tropical Albums chart and took the world beat album award from the Indie Acoustic Project. Before it he had released Joan Soriano aka El Duque en Pampers, Vocales de Amor and Afro Bachata, and appeared on the Rough Guide to Bachata compilation.","type":"text"}]},{"type":"paragraph","content":[{"text":"Bachata Breakdown","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2011 he made Bachata Breakdown En Vivo with Aventura and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra","occurrenceId":"c7c6a4c6-2cff-4a95-bfce-6cfe4b43a44a"}},{"text":". It is a video and record that take the music apart instrument by instrument across its three rhythms — derecho, majao and mambo — which is an unusual thing for working musicians to sit down and do.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Familia Soriano followed in April 2012, made with his siblings Nelly, Griselda and Fernando, and entered the Billboard Tropical Albums chart at number three. He has since re-formed the family band with Fernando and Griselda.","type":"text"}]},{"type":"paragraph","content":[{"text":"Bachata Haití","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2018 he led Bachata Haití, the first bachata recorded in Creole. The songs are sung in Creole and in Spanish by a group of Haitian-Dominican musicians, and the record was conceived as a counterweight to coverage that treats the relationship between the two countries only as a conflict.","type":"text"}]},{"type":"paragraph","content":[{"text":"On film and on the road","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He is the subject of Adam Taub’s documentary The Duke of Bachata, from 2009, and appears in Alex Wolfe’s Santo Domingo Blues. He has toured across the United States and Europe, and formed The Bachata Legends with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"449f86a9-d10e-4fff-976f-9581fb3d03a1","displayText":"Ramón Cordero","occurrenceId":"5f615614-141b-47e8-88f7-203f1cc95e08"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cbda65a4-c7da-4762-8cf8-f29b942d2ac3","displayText":"Edilio Paredes","occurrenceId":"bb0b5acd-9410-49f0-b581-4ec879404c83"}},{"text":" to carry the older acoustic style abroad.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'joan-soriano'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan Bienvenido Severino Soriano, que graba como Joan Soriano y se anuncia como El Duque de la Bachata, es un guitarrista y cantante dominicano de bachata. Desde los años ochenta su guitarra y sus arreglos están en éxitos de bachata de otros, y desde 2008 graba a su nombre para públicos de fuera del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Una guitarra de hilo de pescar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació el 23 de febrero de 1972 en Monte Plata, en el campo a las afueras de Santo Domingo. Fue poco a la escuela y pasó la infancia ayudando a su padre a trabajar la tierra de la familia. La primera guitarra se la fabricó él, con hilo de pescar y una caja de metal tirada.","type":"text"}]},{"type":"paragraph","content":[{"text":"Con sus hermanos armó una banda familiar, conocida como Los Candes por su padre Candelario, que se hizo habitual en las actividades del barrio. A los trece se fue a Santo Domingo pidiendo bola y empezó a trabajar de músico de sesión junto a los nombres ya establecidos del género. Llevaba veinte años en ese oficio antes de que nadie lo grabara a su nombre.","type":"text"}]},{"type":"paragraph","content":[{"text":"Palo y gagá","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Toca palo y gagá, las tradiciones sacras afrodominicanas, y mete su base rítmica dentro de la bachata, que es lo que los bailadores encuentran en sus discos. Toca con cuerdas de acero, y el sonido queda más cerca de la bachata acústica de los sesenta que del timbre que el género adoptó al electrificarse.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Duque de la Bachata","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su primera edición internacional salió en septiembre de 2010 con iASO Records. El Duque de la Bachata se grabó en vivo en estudios de Santo Domingo y Nueva York con el productor Benjamin de Menil, pasó semanas dentro del top diez de la lista Tropical Albums de Billboard y se llevó el premio al álbum world beat del Indie Acoustic Project. Antes había publicado Joan Soriano aka El Duque en Pampers, Vocales de Amor y Afro Bachata, y había aparecido en el recopilatorio Rough Guide to Bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"Bachata Breakdown","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2011 hizo Bachata Breakdown En Vivo con Aventura y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra","occurrenceId":"4abe74c8-543c-49eb-b14a-03ed0320753c"}},{"text":". Es un video y un disco que desmontan la música instrumento por instrumento a través de sus tres ritmos —derecho, majao y mambo—, cosa poco común entre músicos en activo.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Familia Soriano llegó en abril de 2012, hecha con sus hermanos Nelly, Griselda y Fernando, y entró en el tercer puesto de la lista Tropical Albums de Billboard. Desde entonces ha vuelto a armar la banda familiar con Fernando y Griselda.","type":"text"}]},{"type":"paragraph","content":[{"text":"Bachata Haití","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2018 encabezó Bachata Haití, la primera bachata grabada en creol. Las canciones las cantan en creol y en español músicos haitiano-dominicanos, y el disco se pensó como contrapeso a una cobertura que trata la relación entre los dos países únicamente como un conflicto.","type":"text"}]},{"type":"paragraph","content":[{"text":"En el cine y en la carretera","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Es el protagonista del documental The Duke of Bachata, de Adam Taub, de 2009, y aparece en Santo Domingo Blues, de Alex Wolfe. Ha girado por Estados Unidos y Europa, y formó The Bachata Legends con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"449f86a9-d10e-4fff-976f-9581fb3d03a1","displayText":"Ramón Cordero","occurrenceId":"1fe970b6-935d-404a-82aa-bc4410e42a62"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cbda65a4-c7da-4762-8cf8-f29b942d2ac3","displayText":"Edilio Paredes","occurrenceId":"30dc78b9-5318-4de0-b6b8-a37c99be1b64"}},{"text":" para llevar fuera el estilo acústico antiguo.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'joan-soriano'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joan-soriano') AND locale = 'en'), '5f615614-141b-47e8-88f7-203f1cc95e08', 'artist', '449f86a9-d10e-4fff-976f-9581fb3d03a1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joan-soriano') AND locale = 'en'), 'bb0b5acd-9410-49f0-b581-4ec879404c83', 'artist', 'cbda65a4-c7da-4762-8cf8-f29b942d2ac3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joan-soriano') AND locale = 'en'), 'c7c6a4c6-2cff-4a95-bfce-6cfe4b43a44a', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joan-soriano') AND locale = 'es'), '1fe970b6-935d-404a-82aa-bc4410e42a62', 'artist', '449f86a9-d10e-4fff-976f-9581fb3d03a1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joan-soriano') AND locale = 'es'), '30dc78b9-5318-4de0-b6b8-a37c99be1b64', 'artist', 'cbda65a4-c7da-4762-8cf8-f29b942d2ac3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joan-soriano') AND locale = 'es'), '4abe74c8-543c-49eb-b14a-03ed0320753c', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310');

COMMIT;
