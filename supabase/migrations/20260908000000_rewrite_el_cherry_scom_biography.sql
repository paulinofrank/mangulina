BEGIN;

-- Rewrite the catalogue entry for El Cherry Scom.
--
-- El Cherry Scom. PRIMERA de las dieciocho fichas del lote de mayo que sí
-- tenían sustancia, y la mejor de las 229 con diferencia: 2.932 caracteres,
-- cuatro años fechados y veintiséis títulos.
--
-- AQUÍ NO HACE FALTA INVESTIGAR, HACE FALTA ESTRUCTURAR. El contenido era real
-- y verificable. Lo que le faltaba: secciones (ninguna), enlaces (ninguno,
-- nombrando a tres artistas que SÍ están en el catálogo) y español.
--
-- SE AJUSTA UN CRÉDITO. El texto decía que colaboró en "La Mamá de la Mamá" con
-- El Alfa y CJ, y que después el tema tuvo un remix. Spotify, Apple Music,
-- Shazam y SoundCloud lo acreditan EN EL REMIX, junto a El Alfa, CJ, Wisin,
-- Busta Rhymes y Anitta. Se escribe el remix, que es lo que las cuatro fuentes
-- sostienen, y no el original.
--
-- SE QUITA "a substantial streaming success" sobre "Tukuntazo". Es una
-- afirmación de reproducciones sin cifra ni fuente: ni informa ni se puede
-- comprobar. La canción se nombra y ya.
--
-- SE BAJA EL REGISTRO PROMOCIONAL: "earworm melodies", "the song exploded",
-- "impossible to ignore on the world stage". Son frases de nota de prensa.
--
-- CINCO ERRORES DE LA FILA:
--
--   aliases tenía CUATRO entradas y dos son el nombre legal duplicado Y SIN
--   ACENTOS: 'Ramon Antonio Reyes' y 'Ramon Antonio Reyes Alcantara'. Ni Ramón
--   ni Alcántara. Es el QUINTO caso hoy de nombre legal metido en aliases,
--   después de Martín de León, Eddy Herrera, Natti Natasha y Villalona. Quedan
--   los dos que sí son alias: El Cherry y Cherry Scom.
--
--   second_last_name decía 'Alcantara', sin tilde. Es Alcántara.
--
--   sort_name decía 'Reyes, Ramón Antonio', omitiendo el segundo apellido que
--   la propia fila guarda. Pasa a 'Reyes Alcántara, Ramón Antonio'.
--
--   instruments estaba vacío.
--
--   disambiguation repetía la fecha de nacimiento, que ya está en su campo.
--
-- QUEDA REPORTADO Y SIN TOCAR: genres dice 'urban-reggaeton' cuando él es
-- artista de DEMBOW, y el catálogo tiene 'urban-dembow' (lo usa bulin-47).
-- El género es decisión del editor y no lo cambio por mi cuenta.
--
-- TRES ENLACES, TODOS NOMBRADOS YA EN EL TEXTO VIEJO SIN ENLAZAR: kiko-el-crazy
-- en "Baje con Trenza", el-alfa en el remix de 2021 y en "La Gringa", y
-- haraca-kiko en "Melacomo".
--
-- OJO CON LA GRAFÍA: la fila se llama "Kiko el Crazy" CON EL EN MINÚSCULA,
-- igual que "Mozart la Para". El displayText tiene que decir eso exacto.
--
-- NO ENTRAN al catálogo los extranjeros que se nombran: Ozuna, CJ, Wisin, Busta
-- Rhymes, Anitta, Yandel, Lil Jon, Duki, Polimá Westcoast, Daddy Yankee.
--
-- FUENTES: el propio texto del lote, cuyo contenido resultó verificable.
-- Spotify, Apple Music, Shazam y SoundCloud para el crédito del remix.
--
-- NOMBRES NUEVOS PARA LA LISTA (comprobados con verificar-faltantes.cjs, como
-- corresponde desde hoy): Aleesha, que no está. Santiago Matías, el productor
-- ejecutivo de Alofoke, tampoco aparece con ese nombre.
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
       name = 'El Cherry Scom',
       sort_name = 'Reyes Alcántara, Ramón Antonio',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urbano',
       date_of_birth = '1991-09-27',
       birth_year = 1991,
       date_of_death = NULL,
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = 'Ramón',
       middle_name = 'Antonio',
       last_name = 'Reyes',
       second_last_name = 'Alcántara',
       stage_name = 'El Cherry Scom',
       aliases = ARRAY['El Cherry', 'Cherry Scom']::text[],
       occupations = '["composer","songwriter"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY['urban-reggaeton']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@ElCherryScomRD',
       facebook = 'ElCherryScom',
       instagram = 'elcherryscom28',
       disambiguation = 'Dembow singer and rapper known for a high vocal register and a deliberately loud visual identity',
       bio_en = 'Ramón Antonio Reyes Alcántara, known as El Cherry Scom, is a Dominican dembow singer, rapper and songwriter. He is recognisable by a vocal register far higher than most of his contemporaries and by a deliberately loud visual identity, and he is among the dembow artists who have taken the genre furthest outside the country.

**Santo Domingo**

He was born in Santo Domingo in 1991 and came up through the local dembow circuit, working the underground for years before anything reached a wider audience.

**Baje con Trenza**

The turn came at the end of 2019 with Baje con Trenza, made with Kiko el Crazy and executive produced by the Alofoke broadcaster Santiago Matías, who has backed dembow from the radio for years. The Puerto Rican singer Ozuna took the track onto a remix, the video reached the top of what was trending in the country, and Rolling Stone picked the remix for its Song You Need to Know column, which was the first time his name travelled abroad as criticism rather than as export.

**The catalogue**

Tukuntazo, De Manhattan Pa El Bronx and Corre Corre followed, all built inside the fast tempo the genre works in. In 2021 he appeared on the remix of La Mamá de la Mamá alongside El Alfa, CJ, Wisin, Busta Rhymes and Anitta, a line-up that measured how far Dominican dembow had moved from its own neighbourhoods.

Two years later he was on La Gringa, again with El Alfa and with Yandel, Lil Jon, Duki and Polimá Westcoast, putting dembow in the same room as reggaeton, hip hop and Latin trap. He also recorded Melacomo with Haraca Kiko and the singer Aleesha.

**The voice**

What separates him is the delivery. The high register, the abrupt changes of flow and the tonal play give the records a restlessness that identifies him within a bar. He has named Daddy Yankee and Ozuna as his references, two artists who showed that Caribbean urban music could travel without giving up its rhythm.',
       bio_es = 'Ramón Antonio Reyes Alcántara, conocido como El Cherry Scom, es un cantante, rapero y compositor de dembow dominicano. Se le reconoce por un registro vocal mucho más agudo que el de sus contemporáneos y por una identidad visual deliberadamente estridente, y está entre los artistas de dembow que más lejos han llevado el género fuera del país.

**Santo Domingo**

Nació en Santo Domingo en 1991 y se formó en el circuito local de dembow, trabajando en el bajo mundo durante años antes de que algo suyo llegara a un público amplio.

**Baje con Trenza**

El giro llegó a finales de 2019 con Baje con Trenza, hecha junto a Kiko el Crazy y con producción ejecutiva del locutor de Alofoke Santiago Matías, que lleva años respaldando el dembow desde la radio. El puertorriqueño Ozuna llevó el tema a un remix, el video encabezó las tendencias del país, y Rolling Stone escogió esa versión para su columna Song You Need to Know, que fue la primera vez que su nombre salió al exterior como crítica y no como exportación.

**El catálogo**

Detrás vinieron Tukuntazo, De Manhattan Pa El Bronx y Corre Corre, todas armadas dentro del tempo rápido en que trabaja el género. En 2021 apareció en el remix de La Mamá de la Mamá junto a El Alfa, CJ, Wisin, Busta Rhymes y Anitta, un reparto que midió cuánto se había alejado el dembow dominicano de sus propios barrios.

Dos años después estuvo en La Gringa, otra vez con El Alfa y con Yandel, Lil Jon, Duki y Polimá Westcoast, poniendo el dembow en la misma sala que el reguetón, el hip hop y el trap latino. Grabó además Melacomo con Haraca Kiko y la cantante Aleesha.

**La voz**

Lo que lo separa es la entrega. El registro agudo, los cambios bruscos de flow y el juego de tonos le dan a los discos una inquietud que lo identifica en un compás. Ha nombrado como referencias a Daddy Yankee y a Ozuna, dos artistas que demostraron que la música urbana caribeña podía viajar sin renunciar a su ritmo.',
       updated_at = now()
 WHERE slug = 'el-cherry-scom';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-cherry-scom')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-cherry-scom')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ramón Antonio Reyes Alcántara, known as El Cherry Scom, is a Dominican dembow singer, rapper and songwriter. He is recognisable by a vocal register far higher than most of his contemporaries and by a deliberately loud visual identity, and he is among the dembow artists who have taken the genre furthest outside the country.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santo Domingo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Santo Domingo in 1991 and came up through the local dembow circuit, working the underground for years before anything reached a wider audience.","type":"text"}]},{"type":"paragraph","content":[{"text":"Baje con Trenza","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The turn came at the end of 2019 with Baje con Trenza, made with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9be0ed08-6eb6-4ca0-bb68-d5126190aeb1","displayText":"Kiko el Crazy","occurrenceId":"5a329b99-503c-446f-9108-845c5b51fb72"}},{"text":" and executive produced by the Alofoke broadcaster Santiago Matías, who has backed dembow from the radio for years. The Puerto Rican singer Ozuna took the track onto a remix, the video reached the top of what was trending in the country, and Rolling Stone picked the remix for its Song You Need to Know column, which was the first time his name travelled abroad as criticism rather than as export.","type":"text"}]},{"type":"paragraph","content":[{"text":"The catalogue","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Tukuntazo, De Manhattan Pa El Bronx and Corre Corre followed, all built inside the fast tempo the genre works in. In 2021 he appeared on the remix of La Mamá de la Mamá alongside ","type":"text"},{"type":"artistReference","attrs":{"artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa","occurrenceId":"d823c02e-b1b8-4b79-a91c-18304046e52a"}},{"text":", CJ, Wisin, Busta Rhymes and Anitta, a line-up that measured how far Dominican dembow had moved from its own neighbourhoods.","type":"text"}]},{"type":"paragraph","content":[{"text":"Two years later he was on La Gringa, again with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa","occurrenceId":"0d05bc83-8326-4329-b5bc-251847262556"}},{"text":" and with Yandel, Lil Jon, Duki and Polimá Westcoast, putting dembow in the same room as reggaeton, hip hop and Latin trap. He also recorded Melacomo with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2993cde1-f93d-4cf0-9668-fa1e54b09919","displayText":"Haraca Kiko","occurrenceId":"0a61ccee-ebf2-4e42-87ba-5a42703aba3b"}},{"text":" and the singer Aleesha.","type":"text"}]},{"type":"paragraph","content":[{"text":"The voice","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"What separates him is the delivery. The high register, the abrupt changes of flow and the tonal play give the records a restlessness that identifies him within a bar. He has named Daddy Yankee and Ozuna as his references, two artists who showed that Caribbean urban music could travel without giving up its rhythm.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'el-cherry-scom'), 3)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ramón Antonio Reyes Alcántara, conocido como El Cherry Scom, es un cantante, rapero y compositor de dembow dominicano. Se le reconoce por un registro vocal mucho más agudo que el de sus contemporáneos y por una identidad visual deliberadamente estridente, y está entre los artistas de dembow que más lejos han llevado el género fuera del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santo Domingo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santo Domingo en 1991 y se formó en el circuito local de dembow, trabajando en el bajo mundo durante años antes de que algo suyo llegara a un público amplio.","type":"text"}]},{"type":"paragraph","content":[{"text":"Baje con Trenza","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El giro llegó a finales de 2019 con Baje con Trenza, hecha junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9be0ed08-6eb6-4ca0-bb68-d5126190aeb1","displayText":"Kiko el Crazy","occurrenceId":"7c959ca6-31f3-4dc1-baa9-58f605497bee"}},{"text":" y con producción ejecutiva del locutor de Alofoke Santiago Matías, que lleva años respaldando el dembow desde la radio. El puertorriqueño Ozuna llevó el tema a un remix, el video encabezó las tendencias del país, y Rolling Stone escogió esa versión para su columna Song You Need to Know, que fue la primera vez que su nombre salió al exterior como crítica y no como exportación.","type":"text"}]},{"type":"paragraph","content":[{"text":"El catálogo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Detrás vinieron Tukuntazo, De Manhattan Pa El Bronx y Corre Corre, todas armadas dentro del tempo rápido en que trabaja el género. En 2021 apareció en el remix de La Mamá de la Mamá junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa","occurrenceId":"d6ae90a8-c474-4bfc-9246-8c5137b44f10"}},{"text":", CJ, Wisin, Busta Rhymes y Anitta, un reparto que midió cuánto se había alejado el dembow dominicano de sus propios barrios.","type":"text"}]},{"type":"paragraph","content":[{"text":"Dos años después estuvo en La Gringa, otra vez con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa","occurrenceId":"fafb6279-b5c5-428e-81db-8720c8a32558"}},{"text":" y con Yandel, Lil Jon, Duki y Polimá Westcoast, poniendo el dembow en la misma sala que el reguetón, el hip hop y el trap latino. Grabó además Melacomo con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2993cde1-f93d-4cf0-9668-fa1e54b09919","displayText":"Haraca Kiko","occurrenceId":"71b47053-f9b6-45e5-9bf0-540589897757"}},{"text":" y la cantante Aleesha.","type":"text"}]},{"type":"paragraph","content":[{"text":"La voz","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Lo que lo separa es la entrega. El registro agudo, los cambios bruscos de flow y el juego de tonos le dan a los discos una inquietud que lo identifica en un compás. Ha nombrado como referencias a Daddy Yankee y a Ozuna, dos artistas que demostraron que la música urbana caribeña podía viajar sin renunciar a su ritmo.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'el-cherry-scom'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-cherry-scom') AND locale = 'en'), '0a61ccee-ebf2-4e42-87ba-5a42703aba3b', 'artist', '2993cde1-f93d-4cf0-9668-fa1e54b09919');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-cherry-scom') AND locale = 'en'), '0d05bc83-8326-4329-b5bc-251847262556', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-cherry-scom') AND locale = 'en'), '5a329b99-503c-446f-9108-845c5b51fb72', 'artist', '9be0ed08-6eb6-4ca0-bb68-d5126190aeb1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-cherry-scom') AND locale = 'en'), 'd823c02e-b1b8-4b79-a91c-18304046e52a', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-cherry-scom') AND locale = 'es'), '71b47053-f9b6-45e5-9bf0-540589897757', 'artist', '2993cde1-f93d-4cf0-9668-fa1e54b09919');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-cherry-scom') AND locale = 'es'), '7c959ca6-31f3-4dc1-baa9-58f605497bee', 'artist', '9be0ed08-6eb6-4ca0-bb68-d5126190aeb1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-cherry-scom') AND locale = 'es'), 'd6ae90a8-c474-4bfc-9246-8c5137b44f10', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-cherry-scom') AND locale = 'es'), 'fafb6279-b5c5-428e-81db-8720c8a32558', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92');

COMMIT;
