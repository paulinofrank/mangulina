BEGIN;

-- Rewrite the catalogue entry for Tulile.
--
-- Tulile. Décima de las dieciséis fichas publicadas que estaban EN BLANCO.
--
-- LO QUE YA TENÍA LA FILA SE CONFIRMA Y NO SE TOCA: José Manuel Rivera, 8 de
-- octubre de 1976, Santo Domingo. Coinciden Conectate, BuenaMusica y República
-- Dominicana Live.
--
-- primary_genre = merengue-calle SE QUEDA. Lo verifiqué antes de dudarlo: es un
-- subgénero de nivel 1 activo, hijo de merengue, no un resto de la taxonomía
-- vieja. Está bien puesto.
--
-- LO MÁS ÚTIL DE ESTA FICHA ES SU CADENA DE ORQUESTAS, que lo conecta con tres
-- fichas del catálogo. Antes de ser Tulile fue saxofonista asalariado: Orquesta
-- del Cuerpo de Bomberos de Santo Domingo, después Dioni Fernández, después
-- Monchy Capricho y después Ramón Orlando. Es la ruta clásica del músico de
-- atril dominicano, y explica de dónde sale un merenguero de calle que sabe
-- música.
--
-- MONCHY CAPRICHO ES OTRA DE LAS DIECISÉIS EN BLANCO, así que este enlace se
-- devolverá cuando le toque su ficha.
--
-- UNA DECISIÓN QUE TOMO Y QUE REPORTO. Conectate cuenta que ex músicos suyos lo
-- demandaron por prestaciones laborales y que viajó a Estados Unidos en
-- noviembre de 2011 "dejando en el país una deuda millonaria a los integrantes
-- de la orquesta que lideraba".
--
-- NO ENTRA, por tres razones. Es UNA SOLA FUENTE. La redacción es de juicio, no
-- de dato. Y es un pleito laboral, no una disputa de créditos ni de regalías,
-- que es la única categoría legal que este catálogo sí registra porque toca la
-- autoría. El traslado a Estados Unidos en 2011 sí entra, que es el hecho.
--
-- Si el editor quiere incluirlo, hace falta antes una segunda fuente y una
-- redacción sin adjetivos.
--
-- INSTAGRAM: HABÍA DOS CUENTAS Y SE ELIGE POR ACTIVIDAD. @eltulile tiene 6.093
-- publicaciones y material de este año; @reytulile tiene 2 publicaciones y dice
-- ser "Instagram Official". Peor todavía: su propio Facebook remite a
-- @ReyTulile y su cuenta de X remite a @ElTulile. Se contradicen entre ellas.
-- Manda la actividad, como está establecido: va @eltulile.
--
-- LOS TRES HANDLES COMPROBADOS HOY: youtube @ElReyTulileoficial (el canal
-- resuelve), instagram eltulile, facebook elreytulile, que tenía una
-- publicación de hace cuatro horas. Se guarda también su sitio, reytulile.com.
--
-- NO SE ESCRIBEN CIFRAS de seguidores ni de reproducciones.
--
-- UNA DISCREPANCIA MENOR QUE SE ESQUIVA: su canal de YouTube se describe como
-- "Mambero artist since 1998" y Conectate fecha su salida como solista en 1999.
-- La ficha dice "a finales de los noventa" y no fuerza ninguno de los dos años.
--
-- ALIASES: El Rey Tulile, El Rey del Mambo y Many Rivera, los tres documentados.
--
-- INSTRUMENTS lleva saxofón con prueba: aprendió a tocarlo a los catorce años y
-- vivió de eso en cuatro orquestas antes de cantar.
--
-- FUENTES: Conectate.com.do, 8 de octubre de 2023. BuenaMusica. República
-- Dominicana Live. Sus propias cuentas para lo reciente.
--
-- NOMBRE NUEVO PARA LA LISTA: la Orquesta del Cuerpo de Bomberos de Santo
-- Domingo, donde empezó.
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
       name = 'Tulile',
       sort_name = 'Rivera, José Manuel',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue-calle',
       date_of_birth = '1976-10-08',
       birth_year = 1976,
       date_of_death = NULL,
       birth_place = 'Santo Domingo',
       province = 'Santo Domingo',
       first_name = 'José',
       middle_name = 'Manuel',
       last_name = 'Rivera',
       second_last_name = NULL,
       stage_name = 'Tulile',
       aliases = ARRAY['El Rey Tulile', 'El Rey del Mambo', 'Many Rivera']::text[],
       occupations = '["composer"]'::jsonb,
       instruments = ARRAY['voice', 'saxophone']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = 'https://reytulile.com',
       youtube = '@ElReyTulileoficial',
       facebook = 'elreytulile',
       instagram = 'eltulile',
       disambiguation = 'Merengue de calle singer and saxophonist known as El Rey Tulile',
       bio_en = 'José Manuel Rivera, known as Tulile and billed as El Rey Tulile, is a Dominican singer, saxophonist and composer. He is one of the principal names of merengue de calle, the fast, danceable and deliberately irreverent street form of merengue that took hold at the turn of the century.

**The saxophone**

He was born in Santo Domingo in 1976 and began studying music as a teenager, learning the saxophone at fourteen. The instrument, rather than his voice, is what first gave him a living.

**The orchestras**

He worked his way through the salaried circuit before fronting anything of his own. He played in the orchestra of the Santo Domingo fire brigade, then was hired by Dioni Fernández y El Equipo, then moved to the orchestra of Monchy Capricho, and then to Ramón Orlando & Orquesta Internacional. That is the standard route of a Dominican section player, and it accounts for the trained musicianship behind a genre usually described as raw.

**On his own**

At the end of the nineties he left the orchestras to record under his own name, choosing a deliberately provocative register: fast rhythm, comic lyrics and a steady undercurrent of double meaning. His second album, released in 2000, carried La Cuca, the record that made his name across the country.

Susana, Una Culebra, Tan Buena, Conmigo No and Presumida followed, and the formula held: the songs are built to be danced and repeated rather than contemplated.

**The costumes**

His stage presentation has drawn as much comment as the music. He has appeared in nappies, in a pharaoh’s costume and in a bridal gown, treating the concert as a spectacle in which the outfit is part of the joke.

**Working from abroad**

He moved to the United States in November 2011 and has continued to record and tour from there. His recent output includes merengue adaptations of hits from other genres, a practice that has kept his catalogue in circulation with younger audiences.',
       bio_es = 'José Manuel Rivera, conocido como Tulile y anunciado como El Rey Tulile, es un cantante, saxofonista y compositor dominicano. Es uno de los nombres principales del merengue de calle, la forma callejera, rápida, bailable y deliberadamente irreverente del merengue que se impuso al cambio de siglo.

**El saxofón**

Nació en Santo Domingo en 1976 y empezó a estudiar música siendo adolescente, aprendiendo saxofón a los catorce años. Fue el instrumento, y no la voz, lo que primero le dio de comer.

**Las orquestas**

Recorrió el circuito asalariado antes de ponerse al frente de nada propio. Tocó en la orquesta del Cuerpo de Bomberos de Santo Domingo, después lo contrató Dioni Fernández y El Equipo, luego pasó a la orquesta de Monchy Capricho, y después a la de Ramón Orlando & Orquesta Internacional. Es la ruta corriente del músico de atril dominicano, y explica el oficio que hay detrás de un género que suele describirse como crudo.

**Por su cuenta**

A finales de los noventa dejó las orquestas para grabar con su propio nombre, y escogió un registro deliberadamente provocador: ritmo rápido, letras cómicas y una corriente constante de doble sentido. Su segundo álbum, publicado en 2000, traía La Cuca, el disco que lo dio a conocer en todo el país.

Detrás vinieron Susana, Una Culebra, Tan Buena, Conmigo No y Presumida, y la fórmula se mantuvo: son canciones hechas para bailarse y repetirse, no para contemplarse.

**El vestuario**

Su puesta en escena ha dado tanto que hablar como la música. Se ha presentado en pañales, con traje de faraón y con vestido de novia, tratando el concierto como un espectáculo donde el atuendo forma parte del chiste.

**Trabajar desde afuera**

Se trasladó a Estados Unidos en noviembre de 2011 y desde allí ha seguido grabando y presentándose. Su producción reciente incluye adaptaciones a merengue de éxitos de otros géneros, práctica que ha mantenido su catálogo circulando entre públicos más jóvenes.',
       updated_at = now()
 WHERE slug = 'tulile';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tulile')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tulile')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José Manuel Rivera, known as Tulile and billed as El Rey Tulile, is a Dominican singer, saxophonist and composer. He is one of the principal names of merengue de calle, the fast, danceable and deliberately irreverent street form of merengue that took hold at the turn of the century.","type":"text"}]},{"type":"paragraph","content":[{"text":"The saxophone","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Santo Domingo in 1976 and began studying music as a teenager, learning the saxophone at fourteen. The instrument, rather than his voice, is what first gave him a living.","type":"text"}]},{"type":"paragraph","content":[{"text":"The orchestras","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He worked his way through the salaried circuit before fronting anything of his own. He played in the orchestra of the Santo Domingo fire brigade, then was hired by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fb2c703f-5362-47dd-ada0-7c6d5e106f3b","displayText":"Dioni Fernández y El Equipo","occurrenceId":"9ecd860a-168d-468e-9eb4-f04a5c9eee2d"}},{"text":", then moved to the orchestra of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"97249298-9041-4d41-904c-2c788ac2963e","displayText":"Monchy Capricho","occurrenceId":"be8ec680-47e0-432c-9073-2502810b0bc3"}},{"text":", and then to ","type":"text"},{"type":"artistReference","attrs":{"artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional","occurrenceId":"320f67f8-9990-487d-b168-7a524e257b78"}},{"text":". That is the standard route of a Dominican section player, and it accounts for the trained musicianship behind a genre usually described as raw.","type":"text"}]},{"type":"paragraph","content":[{"text":"On his own","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"At the end of the nineties he left the orchestras to record under his own name, choosing a deliberately provocative register: fast rhythm, comic lyrics and a steady undercurrent of double meaning. His second album, released in 2000, carried La Cuca, the record that made his name across the country.","type":"text"}]},{"type":"paragraph","content":[{"text":"Susana, Una Culebra, Tan Buena, Conmigo No and Presumida followed, and the formula held: the songs are built to be danced and repeated rather than contemplated.","type":"text"}]},{"type":"paragraph","content":[{"text":"The costumes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His stage presentation has drawn as much comment as the music. He has appeared in nappies, in a pharaoh’s costume and in a bridal gown, treating the concert as a spectacle in which the outfit is part of the joke.","type":"text"}]},{"type":"paragraph","content":[{"text":"Working from abroad","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He moved to the United States in November 2011 and has continued to record and tour from there. His recent output includes merengue adaptations of hits from other genres, a practice that has kept his catalogue in circulation with younger audiences.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'tulile'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José Manuel Rivera, conocido como Tulile y anunciado como El Rey Tulile, es un cantante, saxofonista y compositor dominicano. Es uno de los nombres principales del merengue de calle, la forma callejera, rápida, bailable y deliberadamente irreverente del merengue que se impuso al cambio de siglo.","type":"text"}]},{"type":"paragraph","content":[{"text":"El saxofón","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santo Domingo en 1976 y empezó a estudiar música siendo adolescente, aprendiendo saxofón a los catorce años. Fue el instrumento, y no la voz, lo que primero le dio de comer.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las orquestas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Recorrió el circuito asalariado antes de ponerse al frente de nada propio. Tocó en la orquesta del Cuerpo de Bomberos de Santo Domingo, después lo contrató ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fb2c703f-5362-47dd-ada0-7c6d5e106f3b","displayText":"Dioni Fernández y El Equipo","occurrenceId":"92eb241b-6284-406b-8f33-69db21e444e2"}},{"text":", luego pasó a la orquesta de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"97249298-9041-4d41-904c-2c788ac2963e","displayText":"Monchy Capricho","occurrenceId":"59f7a96e-9fe7-4871-b235-d1018f21eabb"}},{"text":", y después a la de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional","occurrenceId":"70c3d7d8-5311-4174-b2cc-87d349d929ea"}},{"text":". Es la ruta corriente del músico de atril dominicano, y explica el oficio que hay detrás de un género que suele describirse como crudo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Por su cuenta","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A finales de los noventa dejó las orquestas para grabar con su propio nombre, y escogió un registro deliberadamente provocador: ritmo rápido, letras cómicas y una corriente constante de doble sentido. Su segundo álbum, publicado en 2000, traía La Cuca, el disco que lo dio a conocer en todo el país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Detrás vinieron Susana, Una Culebra, Tan Buena, Conmigo No y Presumida, y la fórmula se mantuvo: son canciones hechas para bailarse y repetirse, no para contemplarse.","type":"text"}]},{"type":"paragraph","content":[{"text":"El vestuario","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su puesta en escena ha dado tanto que hablar como la música. Se ha presentado en pañales, con traje de faraón y con vestido de novia, tratando el concierto como un espectáculo donde el atuendo forma parte del chiste.","type":"text"}]},{"type":"paragraph","content":[{"text":"Trabajar desde afuera","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se trasladó a Estados Unidos en noviembre de 2011 y desde allí ha seguido grabando y presentándose. Su producción reciente incluye adaptaciones a merengue de éxitos de otros géneros, práctica que ha mantenido su catálogo circulando entre públicos más jóvenes.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'tulile'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tulile') AND locale = 'en'), '320f67f8-9990-487d-b168-7a524e257b78', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tulile') AND locale = 'en'), '9ecd860a-168d-468e-9eb4-f04a5c9eee2d', 'artist', 'fb2c703f-5362-47dd-ada0-7c6d5e106f3b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tulile') AND locale = 'en'), 'be8ec680-47e0-432c-9073-2502810b0bc3', 'artist', '97249298-9041-4d41-904c-2c788ac2963e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tulile') AND locale = 'es'), '59f7a96e-9fe7-4871-b235-d1018f21eabb', 'artist', '97249298-9041-4d41-904c-2c788ac2963e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tulile') AND locale = 'es'), '70c3d7d8-5311-4174-b2cc-87d349d929ea', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tulile') AND locale = 'es'), '92eb241b-6284-406b-8f33-69db21e444e2', 'artist', 'fb2c703f-5362-47dd-ada0-7c6d5e106f3b');

COMMIT;
