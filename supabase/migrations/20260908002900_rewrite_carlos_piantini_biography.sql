BEGIN;

-- Rewrite the catalogue entry for Carlos Piantini.
--
-- Carlos Piantini. LA ÚLTIMA DE LAS DIECIOCHO. Y la ficha más vacía de todas:
-- 1.226 caracteres que no nombran UNA orquesta, UNA obra, UN cargo ni UNA
-- fecha. Decía cosas como "his work as an instrumental musician and his
-- involvement in the country's classical music infrastructure helped elevate
-- standards". Eso no es una biografía, es un relleno.
--
-- LO QUE ERA, Y QUE NO APARECÍA POR NINGÚN LADO:
--
--   MIEMBRO FUNDADOR DE LA ORQUESTA SINFÓNICA NACIONAL A LOS CATORCE AÑOS.
--
--   QUINCE AÑOS DE VIOLINISTA EN LA FILARMÓNICA DE NUEVA YORK, BAJO LEONARD
--   BERNSTEIN. Un dominicano dentro de esa orquesta durante quince años, y la
--   ficha del catálogo dominicano no lo decía.
--
--   DIRECTOR DE LA ORQUESTA SINFÓNICA NACIONAL DE 1984 A 1994, y director
--   laureado desde entonces.
--
--   DIRIGIÓ como invitado la Filarmónica de Nueva York, la Sinfónica de Viena,
--   la Sinfónica Nacional de Washington, la Sinfónica de Jerusalén y la
--   Orquesta Internacional de Italia. Y la Filarmónica de Maracaibo.
--
--   DOS PREMIOS CASANDRA como mejor artista clásico en el exterior, 1989 y
--   1992, más tres órdenes: la Andrés Bello de Venezuela, la Heráldica
--   Cristóbal Colón y la de Duarte, Sánchez y Mella. Tenía CERO premios
--   registrados.
--
-- LA FILA ESTABA CASI VACÍA: los cuatro campos de nombre en NULL, sort_name en
-- NULL, aliases vacío, instruments vacío PARA UN VIOLINISTA, y gender en NULL.
-- Se llenan todos.
--
-- LA FUENTE ES BUENA Y CONVIENE ANOTARLO: el DICCIONARIO CULTURAL DOMINICANO de
-- FUNGLODE, que es obra de referencia y no enciclopedia abierta. NO HAY
-- ARTÍCULO DE WIKIPEDIA sobre él en español, lo que explica por qué la ficha
-- del lote de mayo se quedó en generalidades: quien la escribió no tenía de
-- dónde copiar.
--
-- SU FORMACIÓN, que es media ficha: debutó como violinista a los diez años y le
-- decían el Niño Precoz Sancarleño y el Niño Artista. Estudió con Josefita
-- Heredia y Guillermo Jiménez, después con el austríaco Willy Kleinberg y el
-- checo Emil Friedman. Entre 1944 y 1946 vivió en México, donde trabajó técnica
-- de violín con Joseph Smilovits y HENRYK SZERYNG y armonía con MANUEL M.
-- PONCE. Para hacerse director se fue a Viena a estudiar con HANS SWAROWSKY,
-- que es el maestro de media dirección orquestal del siglo XX.
--
-- UN SOLO ENLACE, Y ES EL QUE HAY: julio-alberto-hernandez, fundador de la
-- Orquesta Sinfónica Nacional, en la que Piantini entró como miembro fundador a
-- los catorce años. Los dos hechos vienen de fuentes distintas -- el de
-- Hernández de su propia ficha en este catálogo, el de Piantini de FUNGLODE --
-- y se cruzan en el mismo acontecimiento.
--
-- LA ORQUESTA SINFÓNICA NACIONAL EXISTE EN EL CATÁLOGO Y NO SE PUEDE ENLAZAR:
-- la fila 'orquesta-sinfonica-nacional' está en 'needs_review'. Una biografía
-- no debe apuntar a una página que nadie puede abrir, así que va en texto
-- plano. QUEDA REPORTADO, y con énfasis: que la Sinfónica Nacional esté sin
-- publicar es un hueco grande, y aparece nombrada en al menos tres fichas.
--
-- MANUEL SIMÓ Y JORGE TAVERAS ESTÁN PUBLICADOS Y NO SE ENLAZAN. Los dos son del
-- mismo mundo sinfónico dominicano y es probable que se cruzaran con él, pero
-- FUNGLODE no documenta ninguna relación concreta y no invento colaboraciones
-- por proximidad de campo.
--
-- NO SE ENLAZAN los extranjeros: Bernstein, Szeryng, Ponce, Swarowsky,
-- Kleinberg, Friedman, Smilovits.
--
-- primary_role = 'instrumentalist' Y primary_genre = 'instrumental' SE QUEDAN Y
-- SE REPORTAN. Fue violinista quince años y director cuatro décadas, así que
-- 'musical_director' -- que el catálogo tiene y usan cuatro filas -- puede
-- describirlo mejor. Y en géneros existen 'instrumental-classical' (veintiún
-- filas) e 'instrumental-orchestral', más precisos que el 'instrumental' que
-- tiene. Las dos son decisiones del editor.
--
-- SE DEJA FUERA que murió en Florida, no por ocultarlo sino porque la fila no
-- guarda lugar de muerte y no voy a añadir un campo de contexto que la ficha no
-- pide; el dato queda en esta nota y en la migración por si se quiere.
--
-- LOS PREMIOS VAN EN MIGRACIÓN APARTE.
--
-- FUENTE ÚNICA Y DECLARADA: Diccionario Cultural Dominicano, FUNGLODE, entrada
-- "Piantini, Carlos". Todo lo que se escribe aquí sale de ahí.
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
       name = 'Carlos Piantini',
       sort_name = 'Piantini, Carlos',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'instrumentalist',
       primary_genre = 'instrumental',
       date_of_birth = '1927-05-09',
       birth_year = 1927,
       date_of_death = '2010-03-26',
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = 'Carlos',
       middle_name = NULL,
       last_name = 'Piantini',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY['El Niño Artista', 'El Niño Precoz Sancarleño']::text[],
       occupations = '["conductor","violinist","music educator"]'::jsonb,
       instruments = ARRAY['violin']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend', 'instrumental']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Conductor and violinist; fifteen years in the New York Philharmonic and a decade leading the National Symphony',
       bio_en = 'Carlos Piantini was a Dominican violinist and conductor. He played fifteen years in the New York Philharmonic, conducted orchestras from Vienna to Jerusalem, and led the Dominican National Symphony for a decade, which makes him the Dominican musician who went furthest inside the European concert tradition.

**The child violinist**

He was born in Santo Domingo in 1927 and made his debut as a violinist at ten, young enough that the press of the day gave him nicknames for it. He studied first with Josefita Heredia and Guillermo Jiménez, and then with the Austrian violinist Willy Kleinberg and the Czech Emil Friedman.

**The National Symphony**

He was fourteen when the Orquesta Sinfónica Nacional was founded, and he was one of its founding members — an orchestra assembled by Julio Alberto Hernández and the generation that built the country’s musical institutions. Piantini would come back to it four decades later, from the other side of the podium.

**Mexico and New York**

He lived in Mexico between 1944 and 1946, working on violin technique with Joseph Smilovits and Henryk Szeryng and studying harmony with Manuel M. Ponce. He then spent fifteen years as a violinist in the New York Philharmonic under Leonard Bernstein, which is an unusual sentence to be able to write about a Dominican musician of his generation.

When he decided to conduct rather than play, he went to Vienna and studied orchestral conducting with Hans Swarowsky, whose students account for a large part of how orchestras were conducted in the second half of the century.

**The podium**

He conducted the Philharmonic of Maracaibo in Venezuela and appeared as a guest with the New York Philharmonic, the Vienna Symphony, the National Symphony Orchestra in Washington, the Jerusalem Symphony and the Orchestra Internazionale d’Italia. He also served as director of the Teatro Nacional in Santo Domingo and taught orchestral studies at Florida International University.

**Laureate conductor**

He was music director of the Orquesta Sinfónica Nacional from 1984 to 1994, and on leaving the post was named its laureate conductor. The Casandra Awards named him best classical artist abroad twice, in 1989 and in 1992, and he held the Order of Andrés Bello of Venezuela along with the Dominican Order of Christopher Columbus and the Order of Merit of Duarte, Sánchez and Mella. He died in 2010.',
       bio_es = 'Carlos Piantini fue un violinista y director de orquesta dominicano. Tocó quince años en la Filarmónica de Nueva York, dirigió orquestas desde Viena hasta Jerusalén, y estuvo una década al frente de la Orquesta Sinfónica Nacional, lo que lo convierte en el músico dominicano que más lejos llegó dentro de la tradición de concierto europea.

**El niño violinista**

Nació en Santo Domingo en 1927 y debutó como violinista a los diez años, lo bastante niño como para que la prensa de entonces le pusiera apodos por eso. Estudió primero con Josefita Heredia y Guillermo Jiménez, y después con el violinista austríaco Willy Kleinberg y el checo Emil Friedman.

**La Sinfónica Nacional**

Tenía catorce años cuando se fundó la Orquesta Sinfónica Nacional, y fue uno de sus miembros fundadores: una orquesta armada por Julio Alberto Hernández y la generación que levantó las instituciones musicales del país. Piantini volvería a ella cuatro décadas después, desde el otro lado del podio.

**México y Nueva York**

Vivió en México entre 1944 y 1946, trabajando técnica de violín con Joseph Smilovits y Henryk Szeryng y estudiando armonía con Manuel M. Ponce. Después pasó quince años como violinista de la Filarmónica de Nueva York bajo la dirección de Leonard Bernstein, que es una frase poco común de poder escribir sobre un músico dominicano de su generación.

Cuando decidió dirigir en vez de tocar, se fue a Viena a estudiar dirección orquestal con Hans Swarowsky, de cuyos alumnos sale buena parte de cómo se dirigieron las orquestas en la segunda mitad del siglo.

**El podio**

Dirigió la Filarmónica de Maracaibo, en Venezuela, y se presentó como invitado con la Filarmónica de Nueva York, la Sinfónica de Viena, la Sinfónica Nacional de Washington, la Sinfónica de Jerusalén y la Orquesta Internacional de Italia. Fue además director del Teatro Nacional de Santo Domingo y profesor de estudios orquestales en la Universidad Internacional de Florida.

**Director laureado**

Dirigió la Orquesta Sinfónica Nacional entre 1984 y 1994, y al dejar el cargo fue designado director laureado de la institución. Los Premios Casandra lo nombraron mejor artista clásico en el exterior dos veces, en 1989 y en 1992, y recibió la Orden Andrés Bello de Venezuela junto a la Orden Heráldica Cristóbal Colón y la Orden del Mérito de Duarte, Sánchez y Mella. Murió en 2010.',
       updated_at = now()
 WHERE slug = 'carlos-piantini';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'carlos-piantini')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'carlos-piantini')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Carlos Piantini was a Dominican violinist and conductor. He played fifteen years in the New York Philharmonic, conducted orchestras from Vienna to Jerusalem, and led the Dominican National Symphony for a decade, which makes him the Dominican musician who went furthest inside the European concert tradition.","type":"text"}]},{"type":"paragraph","content":[{"text":"The child violinist","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Santo Domingo in 1927 and made his debut as a violinist at ten, young enough that the press of the day gave him nicknames for it. He studied first with Josefita Heredia and Guillermo Jiménez, and then with the Austrian violinist Willy Kleinberg and the Czech Emil Friedman.","type":"text"}]},{"type":"paragraph","content":[{"text":"The National Symphony","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was fourteen when the Orquesta Sinfónica Nacional was founded, and he was one of its founding members — an orchestra assembled by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0e61046c-e96d-400b-819c-f9de8cbacba1","displayText":"Julio Alberto Hernández","occurrenceId":"8c5226c0-831b-4cba-9bbd-33d56fb653d3"}},{"text":" and the generation that built the country’s musical institutions. Piantini would come back to it four decades later, from the other side of the podium.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mexico and New York","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He lived in Mexico between 1944 and 1946, working on violin technique with Joseph Smilovits and Henryk Szeryng and studying harmony with Manuel M. Ponce. He then spent fifteen years as a violinist in the New York Philharmonic under Leonard Bernstein, which is an unusual sentence to be able to write about a Dominican musician of his generation.","type":"text"}]},{"type":"paragraph","content":[{"text":"When he decided to conduct rather than play, he went to Vienna and studied orchestral conducting with Hans Swarowsky, whose students account for a large part of how orchestras were conducted in the second half of the century.","type":"text"}]},{"type":"paragraph","content":[{"text":"The podium","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He conducted the Philharmonic of Maracaibo in Venezuela and appeared as a guest with the New York Philharmonic, the Vienna Symphony, the National Symphony Orchestra in Washington, the Jerusalem Symphony and the Orchestra Internazionale d’Italia. He also served as director of the Teatro Nacional in Santo Domingo and taught orchestral studies at Florida International University.","type":"text"}]},{"type":"paragraph","content":[{"text":"Laureate conductor","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was music director of the Orquesta Sinfónica Nacional from 1984 to 1994, and on leaving the post was named its laureate conductor. The Casandra Awards named him best classical artist abroad twice, in 1989 and in 1992, and he held the Order of Andrés Bello of Venezuela along with the Dominican Order of Christopher Columbus and the Order of Merit of Duarte, Sánchez and Mella. He died in 2010.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'carlos-piantini'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Carlos Piantini fue un violinista y director de orquesta dominicano. Tocó quince años en la Filarmónica de Nueva York, dirigió orquestas desde Viena hasta Jerusalén, y estuvo una década al frente de la Orquesta Sinfónica Nacional, lo que lo convierte en el músico dominicano que más lejos llegó dentro de la tradición de concierto europea.","type":"text"}]},{"type":"paragraph","content":[{"text":"El niño violinista","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santo Domingo en 1927 y debutó como violinista a los diez años, lo bastante niño como para que la prensa de entonces le pusiera apodos por eso. Estudió primero con Josefita Heredia y Guillermo Jiménez, y después con el violinista austríaco Willy Kleinberg y el checo Emil Friedman.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Sinfónica Nacional","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Tenía catorce años cuando se fundó la Orquesta Sinfónica Nacional, y fue uno de sus miembros fundadores: una orquesta armada por ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0e61046c-e96d-400b-819c-f9de8cbacba1","displayText":"Julio Alberto Hernández","occurrenceId":"0763ec61-fe04-4608-b3a5-74a4091bd475"}},{"text":" y la generación que levantó las instituciones musicales del país. Piantini volvería a ella cuatro décadas después, desde el otro lado del podio.","type":"text"}]},{"type":"paragraph","content":[{"text":"México y Nueva York","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Vivió en México entre 1944 y 1946, trabajando técnica de violín con Joseph Smilovits y Henryk Szeryng y estudiando armonía con Manuel M. Ponce. Después pasó quince años como violinista de la Filarmónica de Nueva York bajo la dirección de Leonard Bernstein, que es una frase poco común de poder escribir sobre un músico dominicano de su generación.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cuando decidió dirigir en vez de tocar, se fue a Viena a estudiar dirección orquestal con Hans Swarowsky, de cuyos alumnos sale buena parte de cómo se dirigieron las orquestas en la segunda mitad del siglo.","type":"text"}]},{"type":"paragraph","content":[{"text":"El podio","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Dirigió la Filarmónica de Maracaibo, en Venezuela, y se presentó como invitado con la Filarmónica de Nueva York, la Sinfónica de Viena, la Sinfónica Nacional de Washington, la Sinfónica de Jerusalén y la Orquesta Internacional de Italia. Fue además director del Teatro Nacional de Santo Domingo y profesor de estudios orquestales en la Universidad Internacional de Florida.","type":"text"}]},{"type":"paragraph","content":[{"text":"Director laureado","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Dirigió la Orquesta Sinfónica Nacional entre 1984 y 1994, y al dejar el cargo fue designado director laureado de la institución. Los Premios Casandra lo nombraron mejor artista clásico en el exterior dos veces, en 1989 y en 1992, y recibió la Orden Andrés Bello de Venezuela junto a la Orden Heráldica Cristóbal Colón y la Orden del Mérito de Duarte, Sánchez y Mella. Murió en 2010.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'carlos-piantini'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'carlos-piantini') AND locale = 'en'), '8c5226c0-831b-4cba-9bbd-33d56fb653d3', 'artist', '0e61046c-e96d-400b-819c-f9de8cbacba1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'carlos-piantini') AND locale = 'es'), '0763ec61-fe04-4608-b3a5-74a4091bd475', 'artist', '0e61046c-e96d-400b-819c-f9de8cbacba1');

COMMIT;
