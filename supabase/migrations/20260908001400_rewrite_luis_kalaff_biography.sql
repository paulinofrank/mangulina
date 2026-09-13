BEGIN;

-- Rewrite the catalogue entry for Luis Kalaff.
--
-- Luis Kalaff. NOVENA de las dieciocho. Otro texto de molde: 1.534 caracteres
-- sobre un compositor de CASI DOS MIL CANCIONES sin nombrar una sola, sin un
-- disco y sin una fecha que no sea nacer y morir.
--
-- Decía que fue "a living archive of Dominican musical heritage" y que su obra
-- "helped document and preserve the sonic landscape of the Cibao valley". Es
-- prosa sobre la idea de un compositor, no sobre este.
--
-- UN ERROR DE ARITMÉTICA QUE ESTABA PUBLICADO: "Kalaff lived to the age of 94".
-- Nació el 11 de octubre de 1916 y murió el 2 de julio de 2010, o sea que murió
-- con 93, antes de cumplir los 94. Wikipedia dice 93 y las fechas de la propia
-- fila lo confirman. Aquí no se escribe ninguna edad: van las dos fechas, que
-- es más informativo y no se puede equivocar.
--
-- EL DATO QUE LE TOCA AL CATÁLOGO EN LA CARA, y que la ficha no tenía: FUE EL
-- PRIMERO EN LLEVAR LA MANGULINA A LA RADIO. Este sitio se llama Mangulina.
--
-- LO DEMÁS QUE FALTABA:
--
--   LAS CANCIONES. "Juancito Trucupey", que popularizó Celia Cruz con la Sonora
--   Matancera; "La Hija y la Mamá", con Carlos Argentino; "Apretaíto" y "Ahí
--   Viene la Nena" con la Billo's Caracas Boys; "Amor Sin Esperanza", que
--   grabaron Celio González y Julio Jaramillo; "Aunque Me Cueste la Vida", que
--   cantaron Alberto Beltrán y también Pedro Infante; "La Empalizá"; "La
--   Tuerca"; "Cuando Yo Me Muera"; "La Mina" y "El Colorao".
--
--   LOS GÉNEROS REALES: merengue, mangulina, salve, carabiné y bolero. La ficha
--   decía "merengue, bolero, and the deeply spiritual salve" y se saltaba los
--   dos folclóricos que lo hacen singular.
--
--   LA GUITARRA QUE SE HIZO ÉL MISMO. A los catorce años, aprendiz de
--   carpintero, encontró una guitarra rota en la calle y la arregló. Ese es el
--   origen del músico y estaba fuera.
--
--   LOS DOS RECONOCIMIENTOS DEL ESTADO: la Orden al Mérito de Duarte, Sánchez y
--   Mella en grado de Caballero, que le impuso Leonel Fernández en 1996, y la
--   declaratoria de "Artista Meritísimo" del Senado cuatro años después.
--
-- SU CONJUNTO SE NOMBRA EN LA PROSA Y NO EN aliases. "Luis Kalaff y sus Alegres
-- Dominicanos" existe como entidad propia -- Discogs lo tiene con ficha y
-- discografía -- y es exactamente el tipo de agrupación que NO debe ir metida
-- como alias personal, que es el defecto que llevo corrigiendo toda la semana
-- en johnny-pacheco, damiron y luis-alberti. Va al inventario de separación.
--
-- LO QUE SE DEJA FUERA: que su padre era comerciante de origen libanés y el
-- nombre de su madre. Oficio de los padres, o sea vida privada. Su propio paso
-- por la carpintería SÍ entra, porque es de dónde sale su primera guitarra.
--
-- CINCO ENLACES, TODOS POR CRÉDITO DE INTERPRETACIÓN DOCUMENTADO:
-- alberto-beltran ("Aunque Me Cueste la Vida"), fernando-villalona ("La
-- Tuerca"), joseito-mateo y johnny-ventura ("Cuando Yo Me Muera", que grabaron
-- los dos) y dioni-fernandez-y-el-equipo ("La Mina", "El Colorao"). Los cinco
-- están publicados. Joseíto Mateo, además, es de esta misma lista de dieciocho
-- y le toca dentro de poco.
--
-- NO SE ENLAZAN los extranjeros que grabaron su obra: Celia Cruz, Carlos
-- Argentino, la Sonora Matancera, la Billo's Caracas Boys, Manolo Monterrey,
-- Cheo García, Celio González, Julio Jaramillo, Pedro Infante, Julio Iglesias.
--
-- SE REPORTA UN HUECO DE TAXONOMÍA: 'mangulina' y 'carabiné' NO EXISTEN como
-- géneros en la base. Comprobado. genres se queda como estaba -- folklore,
-- bolero, folklore-salve -- porque el género es decisión del editor, pero el
-- hombre que metió la mangulina en la radio no tiene dónde registrarlo.
--
-- LOS PREMIOS VAN EN MIGRACIÓN APARTE. Tenía CERO. La categoría de la Orden ya
-- existe, creada al escribir a Julio Alberto Hernández; hay que crear
-- "Artista Meritísimo" bajo Congreso Nacional, que solo tenía "Merenguero del
-- Siglo".
--
-- FUENTES: Wikipedia en español para la obra, la discografía y los premios.
-- Discogs para confirmar Los Alegres Dominicanos como entidad. Las fechas de la
-- fila, que coinciden con la enciclopedia.
--
-- NOMBRE NUEVO PARA LA LISTA: LUIS KALAFF Y SUS ALEGRES DOMINICANOS, la
-- agrupación, que no tiene ficha propia.
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
       name = 'Luis Kalaff',
       sort_name = 'Kalaff Pérez, Luis',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1916-10-11',
       birth_year = 1916,
       date_of_death = '2010-07-02',
       birth_place = 'Pimentel',
       province = 'Duarte',
       first_name = 'Luis',
       middle_name = NULL,
       last_name = 'Kalaff',
       second_last_name = 'Pérez',
       stage_name = 'Luis Kalaff',
       aliases = ARRAY[]::text[],
       occupations = '["composer","guitarist"]'::jsonb,
       instruments = ARRAY['guitar', 'voice']::text[],
       genres = ARRAY['folklore', 'bolero', 'folklore-salve']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Composer and guitarist of nearly two thousand songs; first to put the mangulina on the radio',
       bio_en = 'Luis Kalaff Pérez was a Dominican composer, guitarist and singer. He wrote close to two thousand songs across merengue, bolero and the country’s folk forms, and he was the first to put the mangulina on the radio.

**Pimentel**

He was born in Pimentel, in the province of Duarte, in 1916. He was apprenticed as a carpenter at fourteen, and it was the carpentry that gave him his instrument: he found a broken guitar in the street, repaired it himself, and kept playing from then on.

**The country forms**

His range was wider than the merengue he is filed under. He worked in mangulina and carabiné, two of the older Dominican dance forms, and in the salve, which belongs to Afro-Dominican religious practice, as well as in bolero. Carrying the mangulina onto the radio moved a rural form into the medium that was then deciding what the country listened to.

**Los Alegres Dominicanos**

He led his own group, Luis Kalaff y sus Alegres Dominicanos, and recorded steadily with it from the late fifties into the eighties: Los Reyes del Merengue, Mi Palito de Oro, El Rey del Merengue, La Hija y la Mamá, Fuego a la Lata and Aquí Hay Un Chivo among many others. In 1979 he made an album of merengues with Joseíto Mateo.

**The songs**

The larger part of his work reached the public through other singers, and a good deal of it left the country. Celia Cruz recorded Juancito Trucupey with the Sonora Matancera, Carlos Argentino sang La Hija y la Mamá, and the Billo’s Caracas Boys took Apretaíto and Ahí Viene la Nena across Venezuela. Amor Sin Esperanza was recorded by Celio González and by Julio Jaramillo.

At home the list runs through the whole history of the genre. Alberto Beltrán sang Aunque Me Cueste la Vida, which Pedro Infante also recorded; Fernando Villalona had La Tuerca; Joseíto Mateo and Johnny Ventura both cut Cuando Yo Me Muera; and Dioni Fernández y El Equipo recorded La Mina and El Colorao. La Empalizá passed through so many Dominican orchestras that it stopped belonging to any of them.

**The honours**

President Leonel Fernández conferred the Order of Merit of Duarte, Sánchez and Mella on him in 1996, in the grade of knight, and four years later the Senate declared him an artist of merit. He died in Santo Domingo on 2 July 2010.',
       bio_es = 'Luis Kalaff Pérez fue un compositor, guitarrista y cantante dominicano. Escribió cerca de dos mil canciones entre merengue, bolero y las formas folclóricas del país, y fue el primero en llevar la mangulina a la radio.

**Pimentel**

Nació en Pimentel, provincia Duarte, en 1916. A los catorce años entró de aprendiz de carpintero, y de la carpintería salió su instrumento: encontró una guitarra rota en la calle, la arregló él mismo, y desde entonces no la soltó.

**Las formas del campo**

Su registro es más ancho que el merengue bajo el que se le archiva. Trabajó la mangulina y el carabiné, dos de los bailes dominicanos viejos, y la salve, que pertenece a la práctica religiosa afrodominicana, además del bolero. Meter la mangulina en la radio fue sacar una forma rural al medio que entonces decidía lo que el país oía.

**Los Alegres Dominicanos**

Dirigió su propio conjunto, Luis Kalaff y sus Alegres Dominicanos, y grabó con él sin parar desde finales de los cincuenta hasta los ochenta: Los Reyes del Merengue, Mi Palito de Oro, El Rey del Merengue, La Hija y la Mamá, Fuego a la Lata y Aquí Hay Un Chivo, entre muchos otros. En 1979 hizo un disco de merengues con Joseíto Mateo.

**Las canciones**

La mayor parte de su obra llegó al público por voces ajenas, y buena parte de ella salió del país. Celia Cruz grabó Juancito Trucupey con la Sonora Matancera, Carlos Argentino cantó La Hija y la Mamá, y la Billo’s Caracas Boys llevó Apretaíto y Ahí Viene la Nena por toda Venezuela. Amor Sin Esperanza la grabaron Celio González y Julio Jaramillo.

En el país la lista atraviesa la historia entera del género. Alberto Beltrán cantó Aunque Me Cueste la Vida, que también grabó Pedro Infante; Fernando Villalona tuvo La Tuerca; Joseíto Mateo y Johnny Ventura grabaron los dos Cuando Yo Me Muera; y Dioni Fernández y El Equipo registró La Mina y El Colorao. La Empalizá pasó por tantas orquestas dominicanas que dejó de pertenecerle a ninguna.

**Los reconocimientos**

El presidente Leonel Fernández le impuso la Orden al Mérito de Duarte, Sánchez y Mella en grado de caballero en 1996, y cuatro años después el Senado lo declaró artista meritísimo. Murió en Santo Domingo el 2 de julio de 2010.',
       updated_at = now()
 WHERE slug = 'luis-kalaff';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Luis Kalaff Pérez was a Dominican composer, guitarist and singer. He wrote close to two thousand songs across merengue, bolero and the country’s folk forms, and he was the first to put the mangulina on the radio.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pimentel","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Pimentel, in the province of Duarte, in 1916. He was apprenticed as a carpenter at fourteen, and it was the carpentry that gave him his instrument: he found a broken guitar in the street, repaired it himself, and kept playing from then on.","type":"text"}]},{"type":"paragraph","content":[{"text":"The country forms","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His range was wider than the merengue he is filed under. He worked in mangulina and carabiné, two of the older Dominican dance forms, and in the salve, which belongs to Afro-Dominican religious practice, as well as in bolero. Carrying the mangulina onto the radio moved a rural form into the medium that was then deciding what the country listened to.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Alegres Dominicanos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He led his own group, Luis Kalaff y sus Alegres Dominicanos, and recorded steadily with it from the late fifties into the eighties: Los Reyes del Merengue, Mi Palito de Oro, El Rey del Merengue, La Hija y la Mamá, Fuego a la Lata and Aquí Hay Un Chivo among many others. In 1979 he made an album of merengues with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8c784f57-4ee4-41b5-b140-c45d0da1c5f6","displayText":"Joseíto Mateo","occurrenceId":"3d124031-0798-4c46-a7df-35042f913ffa"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"The songs","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The larger part of his work reached the public through other singers, and a good deal of it left the country. Celia Cruz recorded Juancito Trucupey with the Sonora Matancera, Carlos Argentino sang La Hija y la Mamá, and the Billo’s Caracas Boys took Apretaíto and Ahí Viene la Nena across Venezuela. Amor Sin Esperanza was recorded by Celio González and by Julio Jaramillo.","type":"text"}]},{"type":"paragraph","content":[{"text":"At home the list runs through the whole history of the genre. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1410b448-6357-4895-a32a-58708697e10d","displayText":"Alberto Beltrán","occurrenceId":"f77ab838-c3d7-473a-b459-e90d3e26529e"}},{"text":" sang Aunque Me Cueste la Vida, which Pedro Infante also recorded; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"3b4bba98-44c8-4fe1-bea1-72e57314565b"}},{"text":" had La Tuerca; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8c784f57-4ee4-41b5-b140-c45d0da1c5f6","displayText":"Joseíto Mateo","occurrenceId":"520692f8-4f49-498f-936b-65f0b396de3e"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"1f488528-68fb-407b-ab1a-1f36930e215f"}},{"text":" both cut Cuando Yo Me Muera; and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fb2c703f-5362-47dd-ada0-7c6d5e106f3b","displayText":"Dioni Fernández y El Equipo","occurrenceId":"65c767c2-9522-4e83-8374-7d618fa4b4cd"}},{"text":" recorded La Mina and El Colorao. La Empalizá passed through so many Dominican orchestras that it stopped belonging to any of them.","type":"text"}]},{"type":"paragraph","content":[{"text":"The honours","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"President Leonel Fernández conferred the Order of Merit of Duarte, Sánchez and Mella on him in 1996, in the grade of knight, and four years later the Senate declared him an artist of merit. He died in Santo Domingo on 2 July 2010.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'luis-kalaff'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Luis Kalaff Pérez fue un compositor, guitarrista y cantante dominicano. Escribió cerca de dos mil canciones entre merengue, bolero y las formas folclóricas del país, y fue el primero en llevar la mangulina a la radio.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pimentel","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Pimentel, provincia Duarte, en 1916. A los catorce años entró de aprendiz de carpintero, y de la carpintería salió su instrumento: encontró una guitarra rota en la calle, la arregló él mismo, y desde entonces no la soltó.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las formas del campo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su registro es más ancho que el merengue bajo el que se le archiva. Trabajó la mangulina y el carabiné, dos de los bailes dominicanos viejos, y la salve, que pertenece a la práctica religiosa afrodominicana, además del bolero. Meter la mangulina en la radio fue sacar una forma rural al medio que entonces decidía lo que el país oía.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Alegres Dominicanos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Dirigió su propio conjunto, Luis Kalaff y sus Alegres Dominicanos, y grabó con él sin parar desde finales de los cincuenta hasta los ochenta: Los Reyes del Merengue, Mi Palito de Oro, El Rey del Merengue, La Hija y la Mamá, Fuego a la Lata y Aquí Hay Un Chivo, entre muchos otros. En 1979 hizo un disco de merengues con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8c784f57-4ee4-41b5-b140-c45d0da1c5f6","displayText":"Joseíto Mateo","occurrenceId":"6c3ac0d5-7ca6-4481-a258-8adbeabe76cf"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Las canciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La mayor parte de su obra llegó al público por voces ajenas, y buena parte de ella salió del país. Celia Cruz grabó Juancito Trucupey con la Sonora Matancera, Carlos Argentino cantó La Hija y la Mamá, y la Billo’s Caracas Boys llevó Apretaíto y Ahí Viene la Nena por toda Venezuela. Amor Sin Esperanza la grabaron Celio González y Julio Jaramillo.","type":"text"}]},{"type":"paragraph","content":[{"text":"En el país la lista atraviesa la historia entera del género. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1410b448-6357-4895-a32a-58708697e10d","displayText":"Alberto Beltrán","occurrenceId":"60cb9abd-400a-44df-8a46-2110f269dc90"}},{"text":" cantó Aunque Me Cueste la Vida, que también grabó Pedro Infante; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"d8889c6e-40bb-4d1d-ba3b-0055c12d0e2f"}},{"text":" tuvo La Tuerca; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8c784f57-4ee4-41b5-b140-c45d0da1c5f6","displayText":"Joseíto Mateo","occurrenceId":"f87cc5f4-bf95-4115-9032-115424c02355"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"9878d666-d99e-44e0-9377-225b787eb4b9"}},{"text":" grabaron los dos Cuando Yo Me Muera; y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fb2c703f-5362-47dd-ada0-7c6d5e106f3b","displayText":"Dioni Fernández y El Equipo","occurrenceId":"dc77a6a6-5cb9-415f-bc06-0fe6bd86be41"}},{"text":" registró La Mina y El Colorao. La Empalizá pasó por tantas orquestas dominicanas que dejó de pertenecerle a ninguna.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los reconocimientos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El presidente Leonel Fernández le impuso la Orden al Mérito de Duarte, Sánchez y Mella en grado de caballero en 1996, y cuatro años después el Senado lo declaró artista meritísimo. Murió en Santo Domingo el 2 de julio de 2010.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'luis-kalaff'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff') AND locale = 'en'), '1f488528-68fb-407b-ab1a-1f36930e215f', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff') AND locale = 'en'), '3b4bba98-44c8-4fe1-bea1-72e57314565b', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff') AND locale = 'en'), '3d124031-0798-4c46-a7df-35042f913ffa', 'artist', '8c784f57-4ee4-41b5-b140-c45d0da1c5f6');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff') AND locale = 'en'), '520692f8-4f49-498f-936b-65f0b396de3e', 'artist', '8c784f57-4ee4-41b5-b140-c45d0da1c5f6');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff') AND locale = 'en'), '65c767c2-9522-4e83-8374-7d618fa4b4cd', 'artist', 'fb2c703f-5362-47dd-ada0-7c6d5e106f3b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff') AND locale = 'en'), 'f77ab838-c3d7-473a-b459-e90d3e26529e', 'artist', '1410b448-6357-4895-a32a-58708697e10d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff') AND locale = 'es'), '60cb9abd-400a-44df-8a46-2110f269dc90', 'artist', '1410b448-6357-4895-a32a-58708697e10d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff') AND locale = 'es'), '6c3ac0d5-7ca6-4481-a258-8adbeabe76cf', 'artist', '8c784f57-4ee4-41b5-b140-c45d0da1c5f6');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff') AND locale = 'es'), '9878d666-d99e-44e0-9377-225b787eb4b9', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff') AND locale = 'es'), 'd8889c6e-40bb-4d1d-ba3b-0055c12d0e2f', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff') AND locale = 'es'), 'dc77a6a6-5cb9-415f-bc06-0fe6bd86be41', 'artist', 'fb2c703f-5362-47dd-ada0-7c6d5e106f3b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-kalaff') AND locale = 'es'), 'f87cc5f4-bf95-4115-9032-115424c02355', 'artist', '8c784f57-4ee4-41b5-b140-c45d0da1c5f6');

COMMIT;
