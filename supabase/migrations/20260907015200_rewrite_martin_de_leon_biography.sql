BEGIN;

-- Rewrite the catalogue entry for Martín de León.
--
-- Martín de León. La DECIMOSÉPTIMA ficha publicada en blanco, que no estaba en
-- mi lista de dieciséis porque se creó en mayo de 2026, antes de aquella
-- auditoría. Con esta no queda ninguna ficha publicada sin biografía.
--
-- SE CORRIGE SU ROL, QUE ESTABA MAL. La fila decía primary_role = singer. No es
-- cantante: es COMPOSITOR, y de los más prolíficos del merengue. El Tiempo lo
-- cita diciendo de sí mismo que no es músico de profesión sino "de oído". Ha
-- escrito para otros durante tres décadas; no consta que grabe.
--
-- SE QUITA UN ALIAS REDUNDANTE. La fila guardaba aliases = ['Martín de León'],
-- idéntico carácter por carácter al campo name. Un alias es un nombre
-- ALTERNATIVO; una copia del nombre no informa nada y ensucia las búsquedas.
-- COMPROBADO POR PUNTOS DE CÓDIGO que ninguno de los dos estaba corrupto: la í
-- es U+00ED y la ó es U+00F3 en ambos. La consola de Windows los muestra mal,
-- pero el dato estaba bien.
--
-- EL PARENTESCO NO VA EN LA PROSA, VA EN SU TABLA. El Tiempo dice que Monchy
-- Capricho es su primo. El catálogo tiene artist_family_relationships, con
-- 'cousin' entre sus tipos válidos, y la ficha pública ya renderiza esas
-- relaciones. Meterlo además en el texto sería decir dos veces lo mismo. Se
-- registra la fila en migración aparte y la prosa habla solo de la orquesta.
--
-- Esto corrige un criterio que venía aplicando de más: he estado dejando fuera
-- los parentescos ENTRE ARTISTAS DEL CATÁLOGO por la regla de vida privada,
-- cuando la base tiene una tabla hecha para ellos. La regla apunta a
-- matrimonios, hijos y oficios de los padres en la prosa, no a la relación
-- documentada entre dos artistas registrados.
--
-- TRES ENLACES: monchy-capricho, en cuya orquesta tocó y que grabó su primera
-- canción; eddy-herrera, con quien tiene la sociedad larga de su carrera; y
-- vakero, en la colaboración de 2014. OJO: la fila se llama "Vakeró" CON
-- ACENTO, así que el displayText lo lleva.
--
-- UNA ATRIBUCIÓN QUE NO FUERZO: El Tiempo lista "Nuestro Amor" (1996) entre las
-- canciones que grabó Eddy Herrera, pero Conectate la lista entre los éxitos de
-- Monchy Capricho. Pueden haberla grabado los dos o una de las dos fuentes se
-- equivoca. La ficha nombra la canción sin decir quién la interpretó.
--
-- EL PREMIO DE "VIDA LOCA" SE MENCIONA SIN NOMBRAR LA PREMIACIÓN. El Tiempo
-- dice Soberano y el wiki de música dice Casandra. Son la misma entidad en dos
-- épocas, pero sin el año no puedo saber cuál correspondía. Se dice que ganó
-- merengue del año y ya. NO SE REGISTRA EN artist_awards, además, porque el
-- galardón es del intérprete y no del autor.
--
-- NO SE CONFUNDE CON EL OTRO MARTÍN DE LEÓN. Todotango tiene una biografía de
-- un cantante del mismo nombre que llegó a Estados Unidos en 1975 y cantaba a
-- Serrat y a Alberto Cortez. NO ES ÉL. Discogs, TIDAL y Amazon probablemente
-- mezclan a los dos.
--
-- FALTAN FECHA Y AÑO DE NACIMIENTO y no los inventé: ninguna fuente los da.
--
-- FUENTES: El Tiempo, 25 de noviembre de 2024, de Óscar Quezada, en su serie
-- Orgullo del Este. Música Wiki para las colaboraciones colombianas, con la
-- reserva de ser un wiki abierto. Infoexclusivas para la declaratoria de hijo
-- meritorio.
--
-- NOMBRES NUEVOS PARA LA LISTA: la orquesta Sangre Nueva. NO ENTRAN los
-- colombianos Alejandro Palacio, Daniel Calderón ni Los Gigantes.
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
       name = 'Martín de León',
       sort_name = 'de León, Martín',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'composer',
       primary_genre = 'merengue',
       date_of_birth = NULL,
       birth_year = NULL,
       date_of_death = NULL,
       birth_place = 'Sabana de la Mar',
       province = 'Hato Mayor',
       first_name = 'Martín',
       middle_name = NULL,
       last_name = 'de León',
       second_last_name = NULL,
       stage_name = 'Martín de León',
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = NULL,
       facebook = 'martin.deleon.509',
       instagram = 'martin.deleon.509',
       disambiguation = 'Merengue songwriter from Sabana de la Mar; wrote much of Eddy Herrera’s catalogue',
       bio_en = 'Martín de León is a Dominican songwriter. He has written for other performers for more than three decades, mostly in merengue and more recently in Colombian vallenato, and several of the songs he wrote became the best-known records of the artists who sang them.

**Sabana de la Mar**

He is from Sabana de la Mar, in the province of Hato Mayor. He does not describe himself as a professional musician: he works by ear, and has said he is grateful to write as many lyrics as he has without formal training. The town later declared him a meritorious son.

**The orchestras**

He came into the business through the bands, playing in the orchestra of Monchy Capricho and in Sangre Nueva before settling into writing. His first song, Nadie Como Tú, was recorded in 1991 by Monchy’s orchestra, and he also wrote Te Saqué los Pies for him.

**Eddy Herrera**

The long partnership of his career is with Eddy Herrera. He wrote Los Hombres Calientes and De Risita in the mid-nineties, Como Llora Mi Alma in 2001, which became a fixture of that singer’s repertoire, and Si Yo Se Lo Pido. Nuestro Amor is also his. Vida Loca, another of his merengues, took the award for merengue of the year.

In 2014 he wrote Ella Me Gusta, recorded by Herrera with Vakeró.

**Colombia**

Vallenato became a second market for him. He wrote 24 Horas, released in 2011 and taken up by Colombian performers, and Ese Loco Soy Yo, which a Colombian singer recorded for a major label. He has continued writing across genres rather than settling in one.',
       bio_es = 'Martín de León es un compositor dominicano. Lleva más de tres décadas escribiendo para otros intérpretes, sobre todo en merengue y más recientemente en vallenato colombiano, y varias de sus canciones se convirtieron en los discos más conocidos de quienes las cantaron.

**Sabana de la Mar**

Es de Sabana de la Mar, en la provincia de Hato Mayor. No se describe como músico de profesión: trabaja de oído, y ha dicho que agradece haber escrito tantas letras sin formación formal. Su pueblo lo declaró después hijo meritorio.

**Las orquestas**

Entró al oficio por las bandas, tocando en la orquesta de Monchy Capricho y en Sangre Nueva, antes de dedicarse a escribir. Su primera canción, Nadie Como Tú, la grabó en 1991 la orquesta de Monchy, y para él escribió también Te Saqué los Pies.

**Eddy Herrera**

La sociedad larga de su carrera es con Eddy Herrera. Le escribió Los Hombres Calientes y De Risita a mediados de los noventa, Como Llora Mi Alma en 2001, que quedó como pieza fija de su repertorio, y Si Yo Se Lo Pido. Nuestro Amor es suya también. Vida Loca, otro de sus merengues, se llevó el premio al merengue del año.

En 2014 escribió Ella Me Gusta, que Herrera grabó junto a Vakeró.

**Colombia**

El vallenato se le volvió un segundo mercado. Escribió 24 Horas, publicada en 2011 y llevada al disco por intérpretes colombianos, y Ese Loco Soy Yo, que un cantante colombiano grabó para un sello grande. Ha seguido escribiendo entre géneros en vez de quedarse en uno.',
       updated_at = now()
 WHERE slug = 'martin-de-leon';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martin-de-leon')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martin-de-leon')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Martín de León is a Dominican songwriter. He has written for other performers for more than three decades, mostly in merengue and more recently in Colombian vallenato, and several of the songs he wrote became the best-known records of the artists who sang them.","type":"text"}]},{"type":"paragraph","content":[{"text":"Sabana de la Mar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He is from Sabana de la Mar, in the province of Hato Mayor. He does not describe himself as a professional musician: he works by ear, and has said he is grateful to write as many lyrics as he has without formal training. The town later declared him a meritorious son.","type":"text"}]},{"type":"paragraph","content":[{"text":"The orchestras","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He came into the business through the bands, playing in the orchestra of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"97249298-9041-4d41-904c-2c788ac2963e","displayText":"Monchy Capricho","occurrenceId":"7580c06b-284c-4264-8005-b3071d8671d4"}},{"text":" and in Sangre Nueva before settling into writing. His first song, Nadie Como Tú, was recorded in 1991 by Monchy’s orchestra, and he also wrote Te Saqué los Pies for him.","type":"text"}]},{"type":"paragraph","content":[{"text":"Eddy Herrera","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The long partnership of his career is with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera","occurrenceId":"2a98d590-26b1-4e61-833b-d8dd03aedc37"}},{"text":". He wrote Los Hombres Calientes and De Risita in the mid-nineties, Como Llora Mi Alma in 2001, which became a fixture of that singer’s repertoire, and Si Yo Se Lo Pido. Nuestro Amor is also his. Vida Loca, another of his merengues, took the award for merengue of the year.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 2014 he wrote Ella Me Gusta, recorded by Herrera with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ec8ba439-3772-49ff-a218-05f5dc615763","displayText":"Vakeró","occurrenceId":"bd5fe0aa-df5f-4edf-ab00-8032fc6280c5"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Colombia","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Vallenato became a second market for him. He wrote 24 Horas, released in 2011 and taken up by Colombian performers, and Ese Loco Soy Yo, which a Colombian singer recorded for a major label. He has continued writing across genres rather than settling in one.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'martin-de-leon'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Martín de León es un compositor dominicano. Lleva más de tres décadas escribiendo para otros intérpretes, sobre todo en merengue y más recientemente en vallenato colombiano, y varias de sus canciones se convirtieron en los discos más conocidos de quienes las cantaron.","type":"text"}]},{"type":"paragraph","content":[{"text":"Sabana de la Mar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Es de Sabana de la Mar, en la provincia de Hato Mayor. No se describe como músico de profesión: trabaja de oído, y ha dicho que agradece haber escrito tantas letras sin formación formal. Su pueblo lo declaró después hijo meritorio.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las orquestas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Entró al oficio por las bandas, tocando en la orquesta de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"97249298-9041-4d41-904c-2c788ac2963e","displayText":"Monchy Capricho","occurrenceId":"0d215762-93b7-41ee-af99-69e25c31dc77"}},{"text":" y en Sangre Nueva, antes de dedicarse a escribir. Su primera canción, Nadie Como Tú, la grabó en 1991 la orquesta de Monchy, y para él escribió también Te Saqué los Pies.","type":"text"}]},{"type":"paragraph","content":[{"text":"Eddy Herrera","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La sociedad larga de su carrera es con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera","occurrenceId":"1740c950-72a7-4b48-84c8-fd305ff6fefe"}},{"text":". Le escribió Los Hombres Calientes y De Risita a mediados de los noventa, Como Llora Mi Alma en 2001, que quedó como pieza fija de su repertorio, y Si Yo Se Lo Pido. Nuestro Amor es suya también. Vida Loca, otro de sus merengues, se llevó el premio al merengue del año.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 2014 escribió Ella Me Gusta, que Herrera grabó junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ec8ba439-3772-49ff-a218-05f5dc615763","displayText":"Vakeró","occurrenceId":"36ddb19a-fdd9-4669-a77b-c6e483f7b639"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Colombia","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El vallenato se le volvió un segundo mercado. Escribió 24 Horas, publicada en 2011 y llevada al disco por intérpretes colombianos, y Ese Loco Soy Yo, que un cantante colombiano grabó para un sello grande. Ha seguido escribiendo entre géneros en vez de quedarse en uno.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'martin-de-leon'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martin-de-leon') AND locale = 'en'), '2a98d590-26b1-4e61-833b-d8dd03aedc37', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martin-de-leon') AND locale = 'en'), '7580c06b-284c-4264-8005-b3071d8671d4', 'artist', '97249298-9041-4d41-904c-2c788ac2963e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martin-de-leon') AND locale = 'en'), 'bd5fe0aa-df5f-4edf-ab00-8032fc6280c5', 'artist', 'ec8ba439-3772-49ff-a218-05f5dc615763');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martin-de-leon') AND locale = 'es'), '0d215762-93b7-41ee-af99-69e25c31dc77', 'artist', '97249298-9041-4d41-904c-2c788ac2963e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martin-de-leon') AND locale = 'es'), '1740c950-72a7-4b48-84c8-fd305ff6fefe', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martin-de-leon') AND locale = 'es'), '36ddb19a-fdd9-4669-a77b-c6e483f7b639', 'artist', 'ec8ba439-3772-49ff-a218-05f5dc615763');

COMMIT;
