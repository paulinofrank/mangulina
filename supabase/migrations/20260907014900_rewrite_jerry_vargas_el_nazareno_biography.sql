BEGIN;

-- Rewrite the catalogue entry for Jerry Vargas El Nazareno.
--
-- Jerry Vargas El Nazareno. Decimocuarta de las dieciséis fichas publicadas que
-- estaban EN BLANCO.
--
-- LO QUE YA TENÍA LA FILA SE CONFIRMA Y NO SE TOCA: 11 de agosto de 1954, Las
-- Guáranas, provincia Duarte; muerte el 18 de enero de 2020; ended en true. El
-- Día da la fecha de nacimiento y el lugar exactos, y las notas necrológicas
-- dan los 65 años, que cuadran con las dos fechas.
--
-- SE COMPLETA EL NOMBRE DE PILA: GERARDO. "Jerry" es la forma con la que
-- trabajó. El Día lo escribe "Gerardo (Jerry) Vargas".
--
-- LA MEJOR FUENTE ES EL DÍA DEL 20 DE ENERO DE 2020, firmada por Fausto
-- Polanco, que es el AUTOR DEL LIBRO "MERENGUEROS" y cita su propia
-- investigación. No es una nota de agencia: es el cronista del género contando
-- una carrera que conoce.
--
-- LA HISTORIA DE ESTA FICHA ES LA CENSURA, y por eso se escribe. Sus tres
-- primeros temas como director de orquesta fueron PROHIBIDOS por la Comisión
-- Nacional de Espectáculos Públicos y Radiofonía: "El Huevero", "El Hijo de la
-- Ruta" y "El Cubanito". A este último le cambiaron la letra para salvarlo y la
-- presidenta de la comisión lo rechazó igual, porque la gente ya lo tarareaba
-- con la versión original.
--
-- Mismo criterio que apliqué con Ramón Leonardo: la censura de una obra no es
-- un asunto penal del artista, es lo que el Estado le hizo a su música, y
-- omitirla dejaría la ficha contando una carrera que no existió así.
--
-- NO SE ESCRIBE DE QUÉ MURIÓ, aunque toda la prensa lo detalla al día siguiente
-- y con nombre de clínica. Regla de vida privada. Tampoco entra su hija, que es
-- quien declara a los medios.
--
-- TAMPOCO ENTRA que lo sepultaron "sin lápida ni homenajes", que un portal
-- destacó. Es una afirmación de una sola fuente, con carga editorial, y sobre
-- el entierro y no sobre la música. Queda anotado por si el editor la quiere.
--
-- UN SOLO ENLACE, los-hermanos-rosario, porque es la única de sus orquestas que
-- está en el catálogo. FALTAN CUATRO: El Combo Candela de Nagua, la orquesta de
-- El Charro Mejía en Pimentel, La Gente del País y La Santo Domingo All Star.
-- Es otro hueco de época.
--
-- CUARTA APARICIÓN DE RADIO GUARACHITA en esta corrida. Fue yendo a grabar allí
-- con El Combo Candela que decidió quedarse en la capital. No se enlaza a
-- radhames-aracena porque la fuente nombra la emisora, no al hombre, y no voy a
-- convertir una cosa en la otra.
--
-- INSTRUMENTS: piano y guitarra. El Día precisa que el piano fue el instrumento
-- con el que se destacó, pero que prefería la guitarra; se metió a estudiar
-- piano porque su primera orquesta necesitaba pianista. Las dos van al campo y
-- el matiz va en la prosa.
--
-- FUENTES: El Día, 20 de enero de 2020, de Fausto Polanco. Acento y Listín
-- Diario para el repertorio. El Caribe para el sepelio.
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
       name = 'Jerry Vargas El Nazareno',
       sort_name = 'Vargas, Gerardo',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue-orquesta',
       date_of_birth = '1954-08-11',
       birth_year = 1954,
       date_of_death = '2020-01-18',
       birth_place = 'Las Guáranas',
       province = 'Duarte',
       first_name = 'Gerardo',
       middle_name = NULL,
       last_name = 'Vargas',
       second_last_name = NULL,
       stage_name = 'Jerry Vargas',
       aliases = ARRAY['El Nazareno']::text[],
       occupations = '["bandleader","pianist"]'::jsonb,
       instruments = ARRAY['voice', 'piano', 'guitar']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Merengue singer, pianist and bandleader of the golden years; his first three records were banned from the air',
       bio_en = 'Gerardo Vargas, known as Jerry Vargas and billed as El Nazareno, was a Dominican merengue singer, pianist and bandleader. He was one of the recognisable voices of the genre’s golden years in the eighties, and the first three records he released as a bandleader were all banned from Dominican radio.

**Las Guáranas**

He was born in 1954 in Las Guáranas, in the province of Duarte. He became known locally as a boy for how well he played the guitar, and friends paid him to sing serenades. He has said that at twelve he traded his food for a guitar, and that the obsession grew from there until he made a living from it.

**The piano he did not want**

In 1968 he heard that some young men in Las Guáranas were forming a merengue orchestra and asked to join. The band needed a pianist rather than another guitarist, so he went every afternoon to the municipal music academy and learned the instrument. The piano became what he was known for, though the guitar remained what he preferred.

**The orchestras**

He joined El Combo Candela, from Nagua, as a pianist in 1970, and then the orchestra of El Charro Mejía in Pimentel. A trip to the capital to record with El Combo Candela at Radio Guarachita decided the rest: he stayed. From 1972 he was in Santo Domingo playing with professional bands, among them La Gente del País, La Santo Domingo All Star and Los Hermanos Rosario.

**Three records, three bans**

El Huevero was the record that made his name as a bandleader, and the national commission for public entertainment and broadcasting prohibited it. The merengue El Hijo de la Ruta was banned as well. His third release, El Cubanito, was censored in turn; the lyrics were rewritten to save it, and the commission rejected the new version too, on the grounds that the public was already humming the original.

**The repertoire**

What reached the audience anyway is what he is remembered for: Ojitos Mexicanos, Bésame Mucho, Teorema de Amor and Hijo de la Ruta among them. He remained one of the representative figures of the golden years of merengue until his death in Santo Domingo in January 2020, at sixty-five.',
       bio_es = 'Gerardo Vargas, conocido como Jerry Vargas y anunciado como El Nazareno, fue un cantante, pianista y director de orquesta de merengue dominicano. Fue una de las voces reconocibles de los años dorados del género, en los ochenta, y los tres primeros discos que publicó como director de orquesta fueron prohibidos en la radio dominicana.

**Las Guáranas**

Nació en 1954 en Las Guáranas, en la provincia Duarte. Se hizo conocido en su zona desde muy niño por lo bien que tocaba la guitarra, y los amigos le pagaban para que cantara serenatas. Contó que a los doce años cambiaba su comida por una guitarra, y que de ahí la fiebre fue creciendo hasta que se hizo músico profesional.

**El piano que no quería**

En 1968 se enteró de que unos jóvenes de Las Guáranas estaban formando una orquesta de merengue y se acercó para que lo integraran. Al grupo le hacía falta un pianista y no otro guitarrista, así que se trasladaba todas las tardes a la academia municipal de música y aprendió el instrumento. El piano acabó siendo aquello por lo que se le conoció, aunque la guitarra siguió siendo lo que prefería.

**Las orquestas**

Entró como pianista a El Combo Candela, de Nagua, en 1970, y después a la orquesta de El Charro Mejía, en Pimentel. Un viaje a la capital para grabar con El Combo Candela en Radio Guarachita decidió el resto: se quedó. Desde 1972 estuvo en Santo Domingo tocando con agrupaciones profesionales, entre ellas La Gente del País, La Santo Domingo All Star y Los Hermanos Rosario.

**Tres discos, tres prohibiciones**

El Huevero fue el disco que lo dio a conocer como director de orquesta, y la Comisión Nacional de Espectáculos Públicos y Radiofonía lo prohibió. El merengue El Hijo de la Ruta también fue prohibido. Su tercera publicación, El Cubanito, fue censurada a su vez; le reescribieron la letra para salvarla, y la comisión rechazó igualmente la nueva versión, con el argumento de que el público ya la tarareaba con la primera.

**El repertorio**

Lo que llegó al público de todos modos es aquello por lo que se le recuerda: Ojitos Mexicanos, Bésame Mucho, Teorema de Amor y El Hijo de la Ruta, entre otros. Siguió siendo una de las figuras representativas de los años dorados del merengue hasta su muerte, en Santo Domingo, en enero de 2020, a los sesenta y cinco años.',
       updated_at = now()
 WHERE slug = 'jerry-vargas-el-nazareno';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jerry-vargas-el-nazareno')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jerry-vargas-el-nazareno')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Gerardo Vargas, known as Jerry Vargas and billed as El Nazareno, was a Dominican merengue singer, pianist and bandleader. He was one of the recognisable voices of the genre’s golden years in the eighties, and the first three records he released as a bandleader were all banned from Dominican radio.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las Guáranas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1954 in Las Guáranas, in the province of Duarte. He became known locally as a boy for how well he played the guitar, and friends paid him to sing serenades. He has said that at twelve he traded his food for a guitar, and that the obsession grew from there until he made a living from it.","type":"text"}]},{"type":"paragraph","content":[{"text":"The piano he did not want","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1968 he heard that some young men in Las Guáranas were forming a merengue orchestra and asked to join. The band needed a pianist rather than another guitarist, so he went every afternoon to the municipal music academy and learned the instrument. The piano became what he was known for, though the guitar remained what he preferred.","type":"text"}]},{"type":"paragraph","content":[{"text":"The orchestras","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He joined El Combo Candela, from Nagua, as a pianist in 1970, and then the orchestra of El Charro Mejía in Pimentel. A trip to the capital to record with El Combo Candela at Radio Guarachita decided the rest: he stayed. From 1972 he was in Santo Domingo playing with professional bands, among them La Gente del País, La Santo Domingo All Star and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario","occurrenceId":"ed32c80c-90d0-4a31-abd7-9406ac7d7332"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Three records, three bans","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El Huevero was the record that made his name as a bandleader, and the national commission for public entertainment and broadcasting prohibited it. The merengue El Hijo de la Ruta was banned as well. His third release, El Cubanito, was censored in turn; the lyrics were rewritten to save it, and the commission rejected the new version too, on the grounds that the public was already humming the original.","type":"text"}]},{"type":"paragraph","content":[{"text":"The repertoire","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"What reached the audience anyway is what he is remembered for: Ojitos Mexicanos, Bésame Mucho, Teorema de Amor and Hijo de la Ruta among them. He remained one of the representative figures of the golden years of merengue until his death in Santo Domingo in January 2020, at sixty-five.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jerry-vargas-el-nazareno'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Gerardo Vargas, conocido como Jerry Vargas y anunciado como El Nazareno, fue un cantante, pianista y director de orquesta de merengue dominicano. Fue una de las voces reconocibles de los años dorados del género, en los ochenta, y los tres primeros discos que publicó como director de orquesta fueron prohibidos en la radio dominicana.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las Guáranas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1954 en Las Guáranas, en la provincia Duarte. Se hizo conocido en su zona desde muy niño por lo bien que tocaba la guitarra, y los amigos le pagaban para que cantara serenatas. Contó que a los doce años cambiaba su comida por una guitarra, y que de ahí la fiebre fue creciendo hasta que se hizo músico profesional.","type":"text"}]},{"type":"paragraph","content":[{"text":"El piano que no quería","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1968 se enteró de que unos jóvenes de Las Guáranas estaban formando una orquesta de merengue y se acercó para que lo integraran. Al grupo le hacía falta un pianista y no otro guitarrista, así que se trasladaba todas las tardes a la academia municipal de música y aprendió el instrumento. El piano acabó siendo aquello por lo que se le conoció, aunque la guitarra siguió siendo lo que prefería.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las orquestas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Entró como pianista a El Combo Candela, de Nagua, en 1970, y después a la orquesta de El Charro Mejía, en Pimentel. Un viaje a la capital para grabar con El Combo Candela en Radio Guarachita decidió el resto: se quedó. Desde 1972 estuvo en Santo Domingo tocando con agrupaciones profesionales, entre ellas La Gente del País, La Santo Domingo All Star y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario","occurrenceId":"598f318e-d4c5-4854-8a92-b1ad3af9cfb3"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Tres discos, tres prohibiciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El Huevero fue el disco que lo dio a conocer como director de orquesta, y la Comisión Nacional de Espectáculos Públicos y Radiofonía lo prohibió. El merengue El Hijo de la Ruta también fue prohibido. Su tercera publicación, El Cubanito, fue censurada a su vez; le reescribieron la letra para salvarla, y la comisión rechazó igualmente la nueva versión, con el argumento de que el público ya la tarareaba con la primera.","type":"text"}]},{"type":"paragraph","content":[{"text":"El repertorio","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Lo que llegó al público de todos modos es aquello por lo que se le recuerda: Ojitos Mexicanos, Bésame Mucho, Teorema de Amor y El Hijo de la Ruta, entre otros. Siguió siendo una de las figuras representativas de los años dorados del merengue hasta su muerte, en Santo Domingo, en enero de 2020, a los sesenta y cinco años.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jerry-vargas-el-nazareno'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jerry-vargas-el-nazareno') AND locale = 'en'), 'ed32c80c-90d0-4a31-abd7-9406ac7d7332', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jerry-vargas-el-nazareno') AND locale = 'es'), '598f318e-d4c5-4854-8a92-b1ad3af9cfb3', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4');

COMMIT;
