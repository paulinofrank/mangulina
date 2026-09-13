BEGIN;

-- Rewrite the catalogue entry for Martha Heredia.
--
-- Martha Heredia. DECIMOCUARTA de las dieciocho, y LA PEOR FICHA DEL LOTE. No
-- por pobre: por FALSA. Tenía cuatro afirmaciones erróneas, tres de ellas en
-- una sola oración, y una de esas era un premio inventado.
--
-- EL PREMIO QUE NO EXISTE. El texto publicado decía: "she released a debut
-- album that earned her A LATIN GRAMMY AWARD FOR BEST NEW ARTIST IN 2010".
--
--   ES FALSO. El Latin Grammy al Mejor Artista Nuevo de 2010 lo ganó ALEX CUBA.
--   Comprobado en la lista de premiados de la categoría, año por año: Kany
--   García 2008, Alexander Acha 2009, Alex Cuba 2010, Sie7e 2011. Martha
--   Heredia no está.
--
--   Es el error más grave que he encontrado en las 229 fichas: atribuirle a una
--   artista un galardón internacional que nunca recibió. Sale entero y no se
--   sustituye por ninguna otra mención al Latin Grammy.
--
-- EL PROGRAMA TAMBIÉN ESTABA MAL, Y TRIPLEMENTE. Decía que ganó "the EIGHTH
-- season of LA ACADEMIA, the popular MEXICAN television singing competition, in
-- 2009". Ganó la CUARTA edición de LATIN AMERICAN IDOL, que no es mexicano.
-- Está en la tabla de ediciones del propio programa: I Mayré Martínez 2006, II
-- Carlos Peña 2007, III Margarita Henríquez 2008, IV MARTHA HEREDIA 2009. Lo
-- confirma además BuenaMusica.
--
-- LO QUE SÍ ERA CIERTO Y SE CONSERVA: que fue la primera dominicana en ganar
-- ese concurso. Mirando la lista de ganadores, sigue siendo la única.
--
-- LA FICHA VIEJA HACÍA ADEMÁS UN CIRCUNLOQUIO INCÓMODO: "the pressures of early
-- stardom and the challenge of sustaining momentum in a competitive industry
-- have shaped her subsequent career". Eso alude sin decir a los asuntos penales
-- que la apartaron de la música. La regla es que los asuntos penales NO ENTRAN,
-- y la manera correcta de cumplirla no es aludir con eufemismos, sino NO
-- ESCRIBIR NADA. La biografía nueva no los menciona ni los insinúa: cuenta la
-- música y salta el hueco sin señalarlo.
--
-- LO QUE SE DEJA FUERA, EN CONCRETO: su relación con Vakeró y la denuncia de
-- 2013, el atropello de 2010, la detención en el aeropuerto y los cinco años en
-- Rafey Mujeres. Todo eso es asunto penal o vida privada. Tampoco entran los
-- nombres de sus padres.
--
-- EL ALIAS "LA BABY" ES CORRECTO Y ES UN PELIGRO. BuenaMusica lo confirma dos
-- veces -- en el cuerpo y en el bloque "Otros Nombres". PERO EL CATÁLOGO TIENE
-- UNA ARTISTA PUBLICADA QUE SE LLAMA ASÍ: la-baby, Deyanira Vargas, dembowsera
-- de Consuelo, San Pedro de Macorís, nacida en 2001. Son dos personas
-- distintas y ahora "La Baby" resuelve a las dos. Lo dejo como está porque el
-- dato es correcto, y LO REPORTO, porque una búsqueda por ese nombre va a
-- devolver dos artistas y alguien va a confundirlas.
--
-- aliases traía además "Martha Heredia", SU PROPIO NOMBRE. Sale.
--
-- NO SE ESCRIBEN LAS REPRODUCCIONES. BuenaMusica da "más de sesenta millones"
-- para "Dame Luz". Cifra de plataforma.
--
-- TRES ENLACES: manny-cruz ("Tienes Dueño", 2019), don-miguelo ("Nuevo Novio")
-- y quimico-ultra-mega (colaboraciones de 2022). NO SE ENLAZA A VAKERÓ, que
-- está publicado en el catálogo: la única relación documentada entre los dos es
-- personal, no musical, y esa no entra.
--
-- primary_genre = 'merengue-calle' SE QUEDA Y SE REPORTA. Las fuentes la ponen
-- en R&B, pop latino, reguetón y bachata; ninguna en merengue de calle. Pero el
-- género es decisión del editor y alguien pudo tener un motivo. genres dice
-- 'urban-reggaeton', que sí coincide con las fuentes.
--
-- FUENTES: la tabla de ediciones de Latin American Idol en Wikipedia. La lista
-- de premiados del Latin Grammy al Mejor Artista Nuevo, para descartar el
-- premio inventado. BuenaMusica para la trayectoria, las canciones y los
-- colaboradores. NO HAY artículo de Wikipedia sobre ella en español.
--
-- NOMBRES NUEVOS PARA LA LISTA: UNA VÍA, el grupo de hip hop que armó con su
-- hermano Luis Felipe. LA PERVERSA ya estaba anotada.
--
-- EL GATE ES_HEAD RECHAZÓ "Legado" COMO ENCABEZADO INGLÉS, y tenía razón. Es el
-- título de su álbum de 2022, pero "Legado" es tambien exactamente el encabezado
-- genérico de seccion de legado que ese gate existe para atrapar. No aflojo el
-- patrón por un caso: el encabezado inglés pasa a "The return" y el disco se
-- nombra dentro del párrafo, donde no se confunde con una etiqueta de sección.
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
       name = 'Martha Heredia',
       sort_name = 'Heredia, Martha',
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue-calle',
       date_of_birth = '1991-02-01',
       birth_year = 1991,
       date_of_death = NULL,
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Martha',
       middle_name = 'Roseli',
       last_name = 'Heredia',
       second_last_name = 'Rivas',
       stage_name = 'Martha Heredia',
       aliases = ARRAY['La Baby']::text[],
       occupations = '["songwriter"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY['urban-reggaeton']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@MarthaHerediaTv',
       facebook = '100091398427409',
       instagram = 'marthaheredia',
       disambiguation = 'Singer from Santiago; the only Dominican to win Latin American Idol',
       bio_en = 'Martha Roseli Heredia Rivas is a Dominican singer and songwriter from Santiago de los Caballeros. She won the fourth season of Latin American Idol in 2009 and remains the only Dominican to have taken that competition, and she has worked since across Latin pop, R&B, bachata and urban music.

**Una Vía**

She was born in 1991 and found at about thirteen that she could write as well as sing. With her brother Luis Felipe she put together a group called Una Vía, working in hip hop and reggaetón, and she was writing her own material before any of it reached a stage. A period of work in the United States followed, and she went on writing there.

**Latin American Idol**

The competition she entered in 2009 was regional rather than national, drawing contestants from across Latin America and staging its later rounds in Argentina. She won it, which no Dominican had done in the three previous seasons, and came home to a reception the country reserves for people who win things abroad. The Premio Nacional de la Juventud followed, and she appeared at the Casandra Awards and on the Latin Billboard carpet.

**The songs**

Dame Luz is the record most people know, and Para Toda la Vida, La Rikita and No Me Resigno belong to the same run. Me Voy, El Mal Sabor, Baila pa’ Mí and Novio Nuevo followed. She recorded Tienes Dueño with Manny Cruz in 2019, and appeared as a guest on Nuevo Novio by Don Miguelo.

**The return**

She returned to recording in 2022 with a run of collaborations inside the Dominican urban scene, among them work with Químico Ultra Mega, and released the album Legado the same year, thirteen tracks including Bye Bye, Quiero Bailar and Yo Sé Que Tú. She also put out a freestyle session, which closed a circle back to the hip hop she had started in with her brother.',
       bio_es = 'Martha Roseli Heredia Rivas es una cantante y compositora dominicana de Santiago de los Caballeros. Ganó la cuarta edición de Latin American Idol en 2009 y sigue siendo la única dominicana que ha ganado ese concurso, y desde entonces ha trabajado entre el pop latino, el R&B, la bachata y la música urbana.

**Una Vía**

Nació en 1991 y descubrió hacia los trece años que además de cantar podía escribir. Con su hermano Luis Felipe armó un grupo llamado Una Vía, de hip hop y reguetón, y ya componía lo suyo antes de que nada de eso llegara a una tarima. Después vino una temporada de trabajo en Estados Unidos, donde siguió escribiendo.

**Latin American Idol**

El concurso al que entró en 2009 era regional y no nacional: reunía concursantes de toda América Latina y montaba sus rondas finales en Argentina. Lo ganó, cosa que ningún dominicano había hecho en las tres ediciones anteriores, y volvió al país al recibimiento que se le da a quien gana algo afuera. Detrás vino el Premio Nacional de la Juventud, y se presentó en los Premios Casandra y en la alfombra de los Latin Billboard.

**Las canciones**

Dame Luz es el tema que más gente conoce, y Para Toda la Vida, La Rikita y No Me Resigno son de la misma racha. Detrás vinieron Me Voy, El Mal Sabor, Baila pa’ Mí y Novio Nuevo. Grabó Tienes Dueño con Manny Cruz en 2019, y estuvo como invitada en Nuevo Novio de Don Miguelo.

**Legado**

Volvió a grabar en 2022 con una tanda de colaboraciones dentro de la escena urbana dominicana, entre ellas con Químico Ultra Mega, y publicó ese mismo año el álbum Legado, trece canciones entre las que están Bye Bye, Quiero Bailar y Yo Sé Que Tú. Sacó además una sesión de freestyle, que le cerró el círculo con el hip hop en el que había empezado junto a su hermano.',
       updated_at = now()
 WHERE slug = 'martha-heredia';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martha-heredia')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martha-heredia')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Martha Roseli Heredia Rivas is a Dominican singer and songwriter from Santiago de los Caballeros. She won the fourth season of Latin American Idol in 2009 and remains the only Dominican to have taken that competition, and she has worked since across Latin pop, R&B, bachata and urban music.","type":"text"}]},{"type":"paragraph","content":[{"text":"Una Vía","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She was born in 1991 and found at about thirteen that she could write as well as sing. With her brother Luis Felipe she put together a group called Una Vía, working in hip hop and reggaetón, and she was writing her own material before any of it reached a stage. A period of work in the United States followed, and she went on writing there.","type":"text"}]},{"type":"paragraph","content":[{"text":"Latin American Idol","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The competition she entered in 2009 was regional rather than national, drawing contestants from across Latin America and staging its later rounds in Argentina. She won it, which no Dominican had done in the three previous seasons, and came home to a reception the country reserves for people who win things abroad. The Premio Nacional de la Juventud followed, and she appeared at the Casandra Awards and on the Latin Billboard carpet.","type":"text"}]},{"type":"paragraph","content":[{"text":"The songs","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Dame Luz is the record most people know, and Para Toda la Vida, La Rikita and No Me Resigno belong to the same run. Me Voy, El Mal Sabor, Baila pa’ Mí and Novio Nuevo followed. She recorded Tienes Dueño with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz","occurrenceId":"cc790f3c-8894-4b11-bf1e-71a0f6000c6e"}},{"text":" in 2019, and appeared as a guest on Nuevo Novio by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"36ee9d96-ff15-411c-8e1c-f02bd61a3149"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"The return","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She returned to recording in 2022 with a run of collaborations inside the Dominican urban scene, among them work with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"de562eb7-a0fb-49c2-a3c8-db97a4be80e3","displayText":"Químico Ultra Mega","occurrenceId":"f6c6a94f-d062-4b46-8941-db45f79a21c3"}},{"text":", and released the album Legado the same year, thirteen tracks including Bye Bye, Quiero Bailar and Yo Sé Que Tú. She also put out a freestyle session, which closed a circle back to the hip hop she had started in with her brother.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'martha-heredia'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Martha Roseli Heredia Rivas es una cantante y compositora dominicana de Santiago de los Caballeros. Ganó la cuarta edición de Latin American Idol en 2009 y sigue siendo la única dominicana que ha ganado ese concurso, y desde entonces ha trabajado entre el pop latino, el R&B, la bachata y la música urbana.","type":"text"}]},{"type":"paragraph","content":[{"text":"Una Vía","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1991 y descubrió hacia los trece años que además de cantar podía escribir. Con su hermano Luis Felipe armó un grupo llamado Una Vía, de hip hop y reguetón, y ya componía lo suyo antes de que nada de eso llegara a una tarima. Después vino una temporada de trabajo en Estados Unidos, donde siguió escribiendo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Latin American Idol","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El concurso al que entró en 2009 era regional y no nacional: reunía concursantes de toda América Latina y montaba sus rondas finales en Argentina. Lo ganó, cosa que ningún dominicano había hecho en las tres ediciones anteriores, y volvió al país al recibimiento que se le da a quien gana algo afuera. Detrás vino el Premio Nacional de la Juventud, y se presentó en los Premios Casandra y en la alfombra de los Latin Billboard.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las canciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Dame Luz es el tema que más gente conoce, y Para Toda la Vida, La Rikita y No Me Resigno son de la misma racha. Detrás vinieron Me Voy, El Mal Sabor, Baila pa’ Mí y Novio Nuevo. Grabó Tienes Dueño con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz","occurrenceId":"6e610959-b3a6-4a58-8bfa-9d4f864c4b43"}},{"text":" en 2019, y estuvo como invitada en Nuevo Novio de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"ccd9118e-5d40-412f-a407-6d5e671e281a"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Legado","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Volvió a grabar en 2022 con una tanda de colaboraciones dentro de la escena urbana dominicana, entre ellas con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"de562eb7-a0fb-49c2-a3c8-db97a4be80e3","displayText":"Químico Ultra Mega","occurrenceId":"746f53d6-ca9d-4d69-91e7-60b93e2f5c79"}},{"text":", y publicó ese mismo año el álbum Legado, trece canciones entre las que están Bye Bye, Quiero Bailar y Yo Sé Que Tú. Sacó además una sesión de freestyle, que le cerró el círculo con el hip hop en el que había empezado junto a su hermano.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'martha-heredia'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martha-heredia') AND locale = 'en'), '36ee9d96-ff15-411c-8e1c-f02bd61a3149', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martha-heredia') AND locale = 'en'), 'cc790f3c-8894-4b11-bf1e-71a0f6000c6e', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martha-heredia') AND locale = 'en'), 'f6c6a94f-d062-4b46-8941-db45f79a21c3', 'artist', 'de562eb7-a0fb-49c2-a3c8-db97a4be80e3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martha-heredia') AND locale = 'es'), '6e610959-b3a6-4a58-8bfa-9d4f864c4b43', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martha-heredia') AND locale = 'es'), '746f53d6-ca9d-4d69-91e7-60b93e2f5c79', 'artist', 'de562eb7-a0fb-49c2-a3c8-db97a4be80e3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martha-heredia') AND locale = 'es'), 'ccd9118e-5d40-412f-a407-6d5e671e281a', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

COMMIT;
