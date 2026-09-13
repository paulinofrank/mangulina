BEGIN;

-- Rewrite the catalogue entry for Raulín Rosendo.
--
-- Raulin Rosendo. VIGESIMOPRIMERA de las 211. 1.329 caracteres, tres parrafos
-- de plantilla, y DOS ERRORES QUE SE SOSTIENEN EL UNO AL OTRO.
--
-- ---------------------------------------------------------------------------
-- ERROR 1: LO DABA POR MUERTO Y LO PONIA EN OTRO SIGLO
--
-- "Raulin Rosendo WAS a significant figure... whose career SPANNED THE MIDDLE
-- DECADES OF THE TWENTIETH CENTURY". Esta vivo -- tiene 69 anos y la fila lo
-- sabe, `ended` en false-- y su carrera en solitario EMPIEZA EN 1988. El texto
-- entero estaba en pasado.
--
-- ERROR 2: EL PUEBLO ESTABA MAL Y EL TEXTO CONSTRUYO DOS PARRAFOS ENCIMA
--
-- La fila decia SAN PEDRO DE MACORIS, y el texto se explayaba: "a city in the
-- eastern province that has produced a remarkable number of distinguished
-- Dominican artists", "San Pedro de Macoris has long been a cultural crossroads
-- where Caribbean musical currents converge".
--
-- NACIO EN VILLA DUARTE, SANTO DOMINGO. Lo dicen Wikipedia en ingles, Wikidata
-- (con dos referencias), EcuRed y toda la prensa especializada de salsa. NADA
-- respalda San Pedro. Se corrige, con la misma vara que use con El Chaval de la
-- Bachata esta manana, que era el mismo caso: pueblo falso con parrafo encima.
--
-- La convencion del catalogo para ese sitio ya existe: Luisito Marti tiene
-- birth_place 'Villa Duarte' y province 'Santo Domingo'.
-- ---------------------------------------------------------------------------
--
-- EL GENERO NO LO TOCO, Y ESTA VEZ NO ES UN ERROR CLARO.
--
-- La fila dice `merengue` y todo el mundo lo llama SALSERO: sus discos se
-- titulan "Salsa, Solamente Salsa" y "El Salsero del Pueblo".
--
-- PERO AL INVESTIGAR APARECIO LO QUE LO EXPLICA, y es el mejor dato de la
-- ficha: EMPEZO EN EL MERENGUE, y no en cualquier sitio. En los setenta fue
-- VOZ PRINCIPAL DE "LOS HIJOS DEL REY", la orquesta que creo WILFRIDO VARGAS,
-- AL FRENTE JUNTO A FERNANDO VILLALONA, con BONNY CEPEDA en el piano y en los
-- arreglos, y editada por Karen. De ahi son "Marisela", "La Mazorca", "La Boda
-- de Marisela" y "La Tetera y la Tijera".
--
-- Lo confirma el propio Villalona en su cuenta: "cuantos recuerdos de cuando
-- pertenecí al fenómeno llamado los hijos del rey junto a Raulin Rosendo".
-- Discogs lo lista como miembro junto a Sergio Vargas y Wilfrido Vargas.
--
-- Asi que la pregunta de genero es real y no es mia: es un merenguero de los
-- setenta que se hizo salsero en Nueva York. Va a CONFLICTOS_DE_DATO.md con el
-- contexto, no como error.
--
-- LOS ALIAS: la fila guardaba 'Raulin Rosendo', su propio nombre sin tilde.
-- Patron de 89 filas. Sale. Entra "El Sonero del Pueblo", que es como se le
-- anuncia y da titulo a uno de sus discos.
--
-- LO QUE FALTABA, QUE ES LA CARRERA ENTERA:
--
--   EMPEZO A LOS DOCE en un grupo de merengue, "El Chivo y su Banda".
--
--   LOS HIJOS DEL REY en los setenta, como queda dicho.
--
--   SE FUE A NUEVA YORK y paso por Conjunto Clasico y LOS VECINOS.
--
--   DEBUT EN SOLITARIO: "Salsa con Amor" (1988) y "Salsa, Solamente Salsa"
--   (1991).
--
--   1993: GRABANDO EN NUEVA YORK con el productor Ricky Gonzalez, con los
--   exitos "Amor en Secreto" y "Santo Domingo".
--
--   1995: "EL SONERO QUE EL PUEBLO PREFIERE" fue el disco mas vendido del ano,
--   y de el sale "Uno Se Cura". POR EL FUE NOMINADO A UN CASANDRA Y A UN PREMIO
--   A.C.E. DE NUEVA YORK.
--
--   Y detras: "Dominicano Para el Mundo" (1996), "Simplemente Controlate"
--   (1997), "Llego la Ley" (1998), "Donde Me Coja la Noche" (1999), "En
--   Venezuela" (2001), "De Aqui Pa' Alla" (2002), "La Fama Es Peligrosa"
--   (2003), "Dame Otra Oportunidad" (2006) y "Tranquilo Que Yo Controlo" (2021).
--
-- LAS NOMINACIONES NO SE REGISTRAN EN LA TABLA y explico por que: la fuente
-- -- Wikipedia en ingles, articulo marcado como esbozo -- dice "he was nominated
-- for a Cassandra Award and an A.C.E. Award in New York" SIN DAR CATEGORIA NI
-- ANO, y no encontre el listado de nominados de esa edicion. Sin categoria no
-- hay fila que insertar. Quedan en la prosa, que es donde se pueden decir con
-- la vaguedad que tiene la fuente.
--
-- "EL DISCO MAS VENDIDO DEL ANO" SI ENTRA: no es una cifra de unidades, es una
-- posicion. La regla prohibe las unidades, no los puestos.
--
-- NOMBRE LEGAL: la fila guarda 'Raul' / 'Martinez' y asi lo dan EcuRed, La
-- Salsa es mi Vida y la prensa de salsa. Wikipedia en ingles dice "Raulin Amado
-- Martinez". NO TOCO LA FILA: la mayoria va con Raul Martinez. Anotado.
--
-- ME CORREGI UN CIERRE. La primera version acababa con "lo que deja leer su
-- carrera como una sola linea y no como dos": eso es un aforismo de cierre, que
-- es justo lo que la nota de registro prohibe. Los gates no lo cazaron -- no lo
-- persigue ningun patron -- y lo vi releyendo. Queda el hecho: hizo de sonero en
-- los dos generos.
--
-- CINCO ENLACES, todos por credito documentado.
--
-- FUENTES: Wikipedia en ingles, esbozo pero referenciado a Billboard de 1993.
-- EcuRed, que es la unica que trae la etapa de Los Hijos del Rey. Wikidata, con
-- dos referencias para el lugar. Discogs para la alineacion. La cuenta del
-- propio Fernando Villalona. NO HAY ARTICULO EN ESPANOL EN WIKIPEDIA.
--
-- AUSENCIAS NUEVAS: LOS HIJOS DEL REY, que ya estaba en la lista y ahora tiene
-- una razon mas para subir; EL CHIVO Y SU BANDA, el grupo de merengue donde
-- empezo a los doce; y BIENVENIDO RODRIGUEZ, el dueno de Karen Records, para
-- MUSICOS_PENDIENTES. Ricky Gonzalez y Conjunto Clasico son de Nueva York y no
-- entran.
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
       name = 'Raulín Rosendo',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1957-08-30',
       birth_year = 1957,
       date_of_death = NULL,
       birth_place = 'Villa Duarte',
       province = 'Santo Domingo',
       first_name = 'Raúl',
       middle_name = NULL,
       last_name = 'Martínez',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY['El Sonero del Pueblo']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@RaulinRosendo-xz6hf',
       facebook = 'morenaraulin',
       instagram = 'raulinrosendooficial',
       disambiguation = 'Salsa singer who came up fronting the merengue orchestra Los Hijos del Rey',
       bio_en = 'Raúl Martínez, who sings as Raulín Rosendo, is a Dominican salsa singer. He came up in merengue, fronting one of the biggest Dominican orchestras of the nineteen-seventies, and made his name a second time in New York in the nineties as a sonero.

**Los Hijos del Rey**

He was born on 30 August 1957 in Villa Duarte, on the eastern edge of Santo Domingo, and began performing at twelve with a merengue group called El Chivo y su Banda.

In the seventies he became one of the two lead voices of Los Hijos del Rey, the orchestra Wilfrido Vargas had put together. He fronted it alongside Fernando Villalona, with Bonny Cepeda directing from the piano and writing the arrangements, and the records came out on Karen. Marisela, La Mazorca, La Boda de Marisela and La Tetera y la Tijera date from those years. Sergio Vargas would front the same orchestra later.

**New York**

He moved to New York and worked there with Conjunto Clásico and with Milly, Jocelyn y Los Vecinos. His own records began with Salsa con Amor in 1988 and Salsa, Solamente Salsa in 1991, and by 1993 he was recording in the city with the producer Ricky González, who cut Amor en Secreto and Santo Domingo with him.

**El sonero que el pueblo prefiere**

The record of that title, from 1995, was the best-selling album of its year and carried Uno Se Cura, which is the song most people name first. It brought him a nomination at the Casandra awards at home and another at the A.C.E. awards in New York.

The albums that followed put him among the most widely heard salsa singers of the decade: Dominicano Para el Mundo, ¡Simplemente! ¡Contrólate!, Llegó la Ley and Donde Me Coja la Noche, one a year from 1996. He has gone on recording since — En Venezuela, De Aquí Pa’ Allá, La Fama Es Peligrosa, Dame Otra Oportunidad and, in 2021, Tranquilo Que Yo Controlo.

**The sonero**

He is billed as El Sonero del Pueblo. A sonero is judged on what he invents over the montuno rather than on what he brings prepared, and he did that work in both of his genres: first trading verses at the front of a merengue orchestra, then over a salsa rhythm section in New York.',
       bio_es = 'Raúl Martínez, que canta como Raulín Rosendo, es un salsero dominicano. Se hizo en el merengue, al frente de una de las orquestas dominicanas más grandes de los años setenta, y volvió a hacerse un nombre en Nueva York en los noventa como sonero.

**Los Hijos del Rey**

Nació el 30 de agosto de 1957 en Villa Duarte, en el extremo este de Santo Domingo, y empezó a cantar a los doce años en un grupo de merengue llamado El Chivo y su Banda.

En los setenta pasó a ser una de las dos voces principales de Los Hijos del Rey, la orquesta que había armado Wilfrido Vargas. Estaba al frente junto a Fernando Villalona, con Bonny Cepeda dirigiendo desde el piano y firmando los arreglos, y los discos salían por Karen. De esos años son Marisela, La Mazorca, La Boda de Marisela y La Tetera y la Tijera. Sergio Vargas encabezaría esa misma orquesta más adelante.

**Nueva York**

Se fue a Nueva York y allí trabajó con el Conjunto Clásico y con Milly, Jocelyn y Los Vecinos. Sus discos propios empiezan con Salsa con Amor, de 1988, y Salsa, Solamente Salsa, de 1991, y en 1993 ya grababa en la ciudad con el productor Ricky González, que le sacó Amor en Secreto y Santo Domingo.

**El sonero que el pueblo prefiere**

El disco de ese título, de 1995, fue el más vendido de su año y traía Uno Se Cura, que es la canción que la gente nombra primero. Le valió una nominación en los Premios Casandra en el país y otra en los premios A.C.E. de Nueva York.

Los discos siguientes lo pusieron entre los salseros más escuchados de la década: Dominicano Para el Mundo, ¡Simplemente! ¡Contrólate!, Llegó la Ley y Donde Me Coja la Noche, uno por año desde 1996. Ha seguido grabando después: En Venezuela, De Aquí Pa’ Allá, La Fama Es Peligrosa, Dame Otra Oportunidad y, en 2021, Tranquilo Que Yo Controlo.

**El sonero**

Se anuncia como El Sonero del Pueblo. A un sonero se le juzga por lo que inventa sobre el montuno y no por lo que trae aprendido, y ese trabajo lo hizo en sus dos géneros: primero cruzando versos al frente de una orquesta de merengue y después sobre una sección rítmica de salsa en Nueva York.',
       updated_at = now()
 WHERE slug = 'raulin-rosendo';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Raúl Martínez, who sings as Raulín Rosendo, is a Dominican salsa singer. He came up in merengue, fronting one of the biggest Dominican orchestras of the nineteen-seventies, and made his name a second time in New York in the nineties as a sonero.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Hijos del Rey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born on 30 August 1957 in Villa Duarte, on the eastern edge of Santo Domingo, and began performing at twelve with a merengue group called El Chivo y su Banda.","type":"text"}]},{"type":"paragraph","content":[{"text":"In the seventies he became one of the two lead voices of Los Hijos del Rey, the orchestra ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"1be24a19-4b04-4963-b313-537396f89d56"}},{"text":" had put together. He fronted it alongside ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"fc2cd944-fc47-4451-b2a9-36e7b8631f2b"}},{"text":", with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc4db4c6-c96f-4eb7-af95-ac637785c5bf","displayText":"Bonny Cepeda","occurrenceId":"ce5c9a80-2f3f-4263-b12f-5ccc9e19f1ec"}},{"text":" directing from the piano and writing the arrangements, and the records came out on Karen. Marisela, La Mazorca, La Boda de Marisela and La Tetera y la Tijera date from those years. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"e3367050-b090-4d19-8372-8c1db1b9373a"}},{"text":" would front the same orchestra later.","type":"text"}]},{"type":"paragraph","content":[{"text":"New York","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He moved to New York and worked there with Conjunto Clásico and with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"241703d2-a7f0-457d-b020-704f3a02b0d4","displayText":"Milly, Jocelyn y Los Vecinos","occurrenceId":"0cb11920-6489-452a-a3b0-c0a799830c44"}},{"text":". His own records began with Salsa con Amor in 1988 and Salsa, Solamente Salsa in 1991, and by 1993 he was recording in the city with the producer Ricky González, who cut Amor en Secreto and Santo Domingo with him.","type":"text"}]},{"type":"paragraph","content":[{"text":"El sonero que el pueblo prefiere","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The record of that title, from 1995, was the best-selling album of its year and carried Uno Se Cura, which is the song most people name first. It brought him a nomination at the Casandra awards at home and another at the A.C.E. awards in New York.","type":"text"}]},{"type":"paragraph","content":[{"text":"The albums that followed put him among the most widely heard salsa singers of the decade: Dominicano Para el Mundo, ¡Simplemente! ¡Contrólate!, Llegó la Ley and Donde Me Coja la Noche, one a year from 1996. He has gone on recording since — En Venezuela, De Aquí Pa’ Allá, La Fama Es Peligrosa, Dame Otra Oportunidad and, in 2021, Tranquilo Que Yo Controlo.","type":"text"}]},{"type":"paragraph","content":[{"text":"The sonero","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He is billed as El Sonero del Pueblo. A sonero is judged on what he invents over the montuno rather than on what he brings prepared, and he did that work in both of his genres: first trading verses at the front of a merengue orchestra, then over a salsa rhythm section in New York.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'raulin-rosendo'), 4)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Raúl Martínez, que canta como Raulín Rosendo, es un salsero dominicano. Se hizo en el merengue, al frente de una de las orquestas dominicanas más grandes de los años setenta, y volvió a hacerse un nombre en Nueva York en los noventa como sonero.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Hijos del Rey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació el 30 de agosto de 1957 en Villa Duarte, en el extremo este de Santo Domingo, y empezó a cantar a los doce años en un grupo de merengue llamado El Chivo y su Banda.","type":"text"}]},{"type":"paragraph","content":[{"text":"En los setenta pasó a ser una de las dos voces principales de Los Hijos del Rey, la orquesta que había armado ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"b82d937b-6cb4-4f80-82f3-e3d5885fe1fc"}},{"text":". Estaba al frente junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"b3b318fb-8418-4046-91a7-a75f01bf3848"}},{"text":", con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc4db4c6-c96f-4eb7-af95-ac637785c5bf","displayText":"Bonny Cepeda","occurrenceId":"09907902-2af7-4fcf-a5c7-fdf5439e2f9f"}},{"text":" dirigiendo desde el piano y firmando los arreglos, y los discos salían por Karen. De esos años son Marisela, La Mazorca, La Boda de Marisela y La Tetera y la Tijera. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"12868923-9bd3-40dd-8940-19acd1588bee"}},{"text":" encabezaría esa misma orquesta más adelante.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nueva York","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se fue a Nueva York y allí trabajó con el Conjunto Clásico y con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"241703d2-a7f0-457d-b020-704f3a02b0d4","displayText":"Milly, Jocelyn y Los Vecinos","occurrenceId":"70ca77ba-907a-4edd-8059-ef98904e3be6"}},{"text":". Sus discos propios empiezan con Salsa con Amor, de 1988, y Salsa, Solamente Salsa, de 1991, y en 1993 ya grababa en la ciudad con el productor Ricky González, que le sacó Amor en Secreto y Santo Domingo.","type":"text"}]},{"type":"paragraph","content":[{"text":"El sonero que el pueblo prefiere","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El disco de ese título, de 1995, fue el más vendido de su año y traía Uno Se Cura, que es la canción que la gente nombra primero. Le valió una nominación en los Premios Casandra en el país y otra en los premios A.C.E. de Nueva York.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los discos siguientes lo pusieron entre los salseros más escuchados de la década: Dominicano Para el Mundo, ¡Simplemente! ¡Contrólate!, Llegó la Ley y Donde Me Coja la Noche, uno por año desde 1996. Ha seguido grabando después: En Venezuela, De Aquí Pa’ Allá, La Fama Es Peligrosa, Dame Otra Oportunidad y, en 2021, Tranquilo Que Yo Controlo.","type":"text"}]},{"type":"paragraph","content":[{"text":"El sonero","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se anuncia como El Sonero del Pueblo. A un sonero se le juzga por lo que inventa sobre el montuno y no por lo que trae aprendido, y ese trabajo lo hizo en sus dos géneros: primero cruzando versos al frente de una orquesta de merengue y después sobre una sección rítmica de salsa en Nueva York.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'raulin-rosendo'), 2)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'en'), '0cb11920-6489-452a-a3b0-c0a799830c44', 'artist', '241703d2-a7f0-457d-b020-704f3a02b0d4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'en'), '1be24a19-4b04-4963-b313-537396f89d56', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'en'), 'ce5c9a80-2f3f-4263-b12f-5ccc9e19f1ec', 'artist', 'bc4db4c6-c96f-4eb7-af95-ac637785c5bf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'en'), 'e3367050-b090-4d19-8372-8c1db1b9373a', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'en'), 'fc2cd944-fc47-4451-b2a9-36e7b8631f2b', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'es'), '09907902-2af7-4fcf-a5c7-fdf5439e2f9f', 'artist', 'bc4db4c6-c96f-4eb7-af95-ac637785c5bf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'es'), '12868923-9bd3-40dd-8940-19acd1588bee', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'es'), '70ca77ba-907a-4edd-8059-ef98904e3be6', 'artist', '241703d2-a7f0-457d-b020-704f3a02b0d4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'es'), 'b3b318fb-8418-4046-91a7-a75f01bf3848', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'es'), 'b82d937b-6cb4-4f80-82f3-e3d5885fe1fc', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

COMMIT;
