BEGIN;

-- Rewrite the catalogue entry for Lápiz Conciente.
--
-- Lápiz Conciente. PRIMERA de las 211 que quedan solo en inglés, y la elegí con
-- un criterio medible en vez de con impresión: ES LA FICHA A LA QUE MÁS ENLAZAN
-- LAS DEMÁS. 42 referencias entrantes desde otras biografías del catálogo, casi
-- el doble que la segunda. Eso mide centralidad real: cuánta gente del catálogo
-- lo necesita para explicarse.
--
-- Y tenía 1.319 caracteres sin UNA canción, UN disco, UN año ni UN colaborador.
--
-- LA FICHA VIEJA INVENTABA UNA ETIMOLOGÍA. Decía: "His stage name — which
-- translates roughly as Conscious Pencil — signals his identity as a writer
-- first and a performer second, an artist who approaches each verse as a
-- literary exercise". Eso es una interpretación bonita y es de quien la
-- escribió, no del artista. La fuente dice otra cosa: el nombre viene de cómo
-- lo decía SU ABUELA. Se escribe eso, que además explica por qué "Conciente" va
-- sin la s.
--
-- LO QUE FALTABA, QUE ES TODO:
--
--   "CAPEA EL DOUGH", 2011, con Toxic Crow. Es el tema que la prensa trata como
--   representativo del hip hop dominicano, y en 2022 más de veintiocho urbanos
--   dominicanos grabaron otra versión. Un catálogo dominicano que no nombra esa
--   canción en su ficha no está haciendo su trabajo.
--
--   "SI NO TE QUISIERA", 2014, con Juan Magán y Belinda: disco de oro.
--
--   LOS DOS ÁLBUMES: "Latidos" (2016) y "Cicatrices", el primero bajo Sony
--   Music Latin, que es cuando firma.
--
--   LA BATALLA CON MOZART LA PARA en 2020, de la que salieron "El Descanso
--   Eterno", "Tú No Tá" y "9 Días". Es un episodio central del rap dominicano y
--   enlaza dos fichas del catálogo.
--
--   ROLLING STONE EN ESPAÑOL lo puso en el puesto 48 de los 50 grandes de la
--   historia del rap en español, en 2023.
--
--   VICO C, que es de donde sale todo: lo oyó a los diez años, en 1993, y de
--   ahí viene el rapero. Y con él grabó "Papa", nominada al Latin Grammy en
--   2017.
--
-- EL NOMBRE LEGAL DE LA FILA ESTABA BIEN y se confirma: Avelino Junior Figueroa
-- Rodríguez, 24 de enero de 1983, Los Mina. Es de las pocas filas del lote que
-- no traía ningún defecto en los campos de nombre.
--
-- LO QUE SE DEJA FUERA: el tiempo que estuvo preso, que es asunto penal; que se
-- crió en una familia disfuncional; la muerte de su madre; su pareja y sus dos
-- hijos; sus estudios de contabilidad sin terminar; y su religión. SÍ ENTRA de
-- dónde sale el nombre artístico, porque el nombre artístico es público.
--
-- NO SE ESCRIBEN LAS REPRODUCCIONES. La fuente da 39 millones para "Yo No Te
-- Quiero Perder" y 300 millones para "Si No Te Quisiera". Cifras de plataforma.
-- EL DISCO DE ORO SÍ VA, que es certificación.
--
-- CUATRO ENLACES, TODOS POR CRÉDITO: toxic-crow ("Capea el Dough"),
-- mozart-la-para (la batalla de 2020), natti-natasha y negro-hp (los dos
-- álbumes de 2016).
--
-- NO SE ENLAZAN los extranjeros -- Vico C, Juan Magán, Belinda, Nacho, El B, J
-- Álvarez -- ni los dominicanos que NO ESTÁN en el catálogo, que son cuatro y
-- van a la lista.
--
-- occupations decía solo 'composer'. Se añade 'rapper', que es el oficio, y
-- 'executive', que la fuente sostiene: lo describe como empresario y tiene
-- sello propio. instruments estaba vacío.
--
-- LOS PREMIOS VAN EN MIGRACIÓN APARTE. Tenía CERO, incluidas DOS NOMINACIONES
-- que se registran con won = false y un premio italiano doble.
--
-- FUENTES: Wikipedia en español, que en su caso está bien referenciada -- El
-- Día, Listín Diario, Diario Libre, El Caribe, Acento, Rolling Stone en
-- Español, Sony Music. La fila para el nombre legal, que coincide.
--
-- NOMBRES NUEVOS PARA LA LISTA: BLACK JONAS POINT, MUSICÓLOGO EL LIBRO, MAGIC
-- JUAN y XAXO, los cuatro dominicanos y los cuatro sin ficha. LESLIE GRACE,
-- dominicano-americana, tampoco está. ROMEO SANTOS sigue sin estar, y ya lo
-- tengo anotado como el hueco más grande del catálogo.
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
       name = 'Lápiz Conciente',
       sort_name = 'Conciente, Lápiz',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urbano',
       date_of_birth = '1983-01-24',
       birth_year = 1983,
       date_of_death = NULL,
       birth_place = 'Los Mina, Santo Domingo Este',
       province = 'Santo Domingo',
       first_name = 'Avelino',
       middle_name = 'Junior',
       last_name = 'Figueroa',
       second_last_name = 'Rodríguez',
       stage_name = 'Lápiz Conciente',
       aliases = ARRAY['El Papa del Rap']::text[],
       occupations = '["composer","rapper","executive"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = 'https://lapizmusic.com',
       youtube = '@LAPIZCONCIENTERD',
       facebook = 'lapizconcienteofficial',
       instagram = 'lapizconciente',
       disambiguation = 'Rapper from Los Mina; one of the founders of Dominican hip hop and the voice on Capea el Dough',
       bio_en = 'Avelino Junior Figueroa Rodríguez, who records as Lápiz Conciente, is a Dominican rapper, songwriter and label owner. He is treated as one of the founders of Dominican hip hop, and more biographies in this record point to him than to any other artist of his generation, which is a fair measure of how much of the scene runs through him.

**Los Mina**

He was born in 1983 in Los Mina, on the eastern side of Santo Domingo. He heard the Puerto Rican rapper Vico C at ten years old, in 1993, and that is where the rapper comes from; he has been working since 1997. The name is his grandmother’s: it comes from the way she said it, which is also why he has always written Conciente without the s.

**Ráfaga de Plomo**

He began putting music out through YouTube in 2008, among it Las Menores, and released the mixtape Ráfaga de Plomo the following year. That was the route available at the time — the Dominican radio of the period had little room for rap, and the platform was where the audience already was.

**Capea el Dough**

In 2011 he recorded Capea el Dough with Toxic Crow. The record became the piece the Dominican press reaches for when it needs to point at what hip hop sounds like in this country, and it kept working: in 2022 more than twenty-eight Dominican urban artists cut a new version of it together.

Yo Soy Papá and Yo No Te Quiero Perder followed, and the audience for them was larger than anything Dominican rap had reached before.

**Si No Te Quisiera**

In 2014 he appeared on Si No Te Quisiera alongside the Spanish producer Juan Magán and the Mexican singer Belinda, and the record earned him a gold certification. It also placed a Dominican rapper inside a commercial Latin pop release, which was not a route that had been open to the genre before.

**Latidos and Cicatrices**

Latidos arrived in 2016, with Natti Natasha among its guests along with Vico C, Belinda, J Álvarez and Musicólogo El Libro. He signed to Sony Music Latin the same year and made Cicatrices for the label, bringing in Negro HP, Magic Juan, Nacho, Leslie Grace and the Cuban rapper El B.

**The battle**

In 2020 he went into a rap battle against Mozart la Para. It produced three singles — El Descanso Eterno, Tú No Tá and 9 Días — and it was followed as an event rather than as a novelty, which says something about where the genre had arrived. In 2022 he appeared on Culpable, on Romeo Santos’s Fórmula, Vol. 3.

**The standing**

Premios Juventud nominated him as urban artist of the year in 2013. He won two Latin Music Italian Awards in 2016, and in 2017 Papa, recorded with Vico C, took him to a Latin Grammy nomination for best urban song — the man who had made him want to rap, on the record that got him there.

In 2023 Rolling Stone en Español placed him forty-eighth on its list of the fifty greatest figures in the history of Spanish-language rap, which is the highest position any Dominican holds on it.',
       bio_es = 'Avelino Junior Figueroa Rodríguez, que graba como Lápiz Conciente, es un rapero, compositor y dueño de sello dominicano. Se le trata como uno de los fundadores del hip hop dominicano, y hay más biografías de este registro que apuntan hacia él que hacia ningún otro artista de su generación, lo que da una medida bastante justa de cuánta escena le pasa por encima.

**Los Mina**

Nació en 1983 en Los Mina, al este de Santo Domingo. Oyó al puertorriqueño Vico C a los diez años, en 1993, y de ahí sale el rapero; trabaja desde 1997. El nombre es de su abuela: viene de cómo lo decía ella, que es también la razón por la que siempre ha escrito Conciente sin la s.

**Ráfaga de Plomo**

Empezó a sacar música por YouTube en 2008, entre ella Las Menores, y al año siguiente publicó el mixtape Ráfaga de Plomo. Era la vía que había: la radio dominicana de entonces le hacía poco sitio al rap, y la plataforma era donde ya estaba el público.

**Capea el Dough**

En 2011 grabó Capea el Dough con Toxic Crow. El tema se convirtió en la pieza a la que echa mano la prensa dominicana cuando necesita señalar a qué suena el hip hop en este país, y siguió funcionando: en 2022 más de veintiocho urbanos dominicanos grabaron juntos una versión nueva.

Detrás vinieron Yo Soy Papá y Yo No Te Quiero Perder, con un público más grande que el que había alcanzado antes ningún rap dominicano.

**Si No Te Quisiera**

En 2014 apareció en Si No Te Quisiera junto al productor español Juan Magán y la cantante mexicana Belinda, y el tema le valió una certificación de oro. Metió además a un rapero dominicano dentro de un lanzamiento comercial de pop latino, que no era una vía que hubiera estado abierta al género.

**Latidos y Cicatrices**

Latidos salió en 2016, con Natti Natasha entre los invitados junto a Vico C, Belinda, J Álvarez y Musicólogo El Libro. Ese mismo año firmó con Sony Music Latin e hizo para el sello Cicatrices, donde metió a Negro HP, Magic Juan, Nacho, Leslie Grace y al rapero cubano El B.

**La batalla**

En 2020 se metió en una batalla de rap contra Mozart la Para. De ahí salieron tres sencillos — El Descanso Eterno, Tú No Tá y 9 Días — y se siguió como acontecimiento y no como curiosidad, lo que dice algo sobre dónde había llegado el género. En 2022 apareció en Culpable, del Fórmula, Vol. 3 de Romeo Santos.

**El lugar**

Premios Juventud lo nominó como artista urbano del año en 2013. Ganó dos Latin Music Italian Awards en 2016, y en 2017 Papa, grabada con Vico C, lo llevó a una nominación al Latin Grammy a la mejor canción urbana: el hombre que le dio ganas de rapear, en el disco que lo puso ahí.

En 2023 Rolling Stone en Español lo colocó en el puesto cuarenta y ocho de su lista de los cincuenta grandes de la historia del rap en español, que es la posición más alta que ocupa un dominicano en ella.',
       updated_at = now()
 WHERE slug = 'lapiz-conciente';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'lapiz-conciente')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'lapiz-conciente')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Avelino Junior Figueroa Rodríguez, who records as Lápiz Conciente, is a Dominican rapper, songwriter and label owner. He is treated as one of the founders of Dominican hip hop, and more biographies in this record point to him than to any other artist of his generation, which is a fair measure of how much of the scene runs through him.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Mina","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1983 in Los Mina, on the eastern side of Santo Domingo. He heard the Puerto Rican rapper Vico C at ten years old, in 1993, and that is where the rapper comes from; he has been working since 1997. The name is his grandmother’s: it comes from the way she said it, which is also why he has always written Conciente without the s.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ráfaga de Plomo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He began putting music out through YouTube in 2008, among it Las Menores, and released the mixtape Ráfaga de Plomo the following year. That was the route available at the time — the Dominican radio of the period had little room for rap, and the platform was where the audience already was.","type":"text"}]},{"type":"paragraph","content":[{"text":"Capea el Dough","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2011 he recorded Capea el Dough with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d25ea8c2-1e9f-4f77-832a-48886d50c47b","displayText":"Toxic Crow","occurrenceId":"338f6d29-66cf-4f43-8ddd-9b290b363fa6"}},{"text":". The record became the piece the Dominican press reaches for when it needs to point at what hip hop sounds like in this country, and it kept working: in 2022 more than twenty-eight Dominican urban artists cut a new version of it together.","type":"text"}]},{"type":"paragraph","content":[{"text":"Yo Soy Papá and Yo No Te Quiero Perder followed, and the audience for them was larger than anything Dominican rap had reached before.","type":"text"}]},{"type":"paragraph","content":[{"text":"Si No Te Quisiera","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2014 he appeared on Si No Te Quisiera alongside the Spanish producer Juan Magán and the Mexican singer Belinda, and the record earned him a gold certification. It also placed a Dominican rapper inside a commercial Latin pop release, which was not a route that had been open to the genre before.","type":"text"}]},{"type":"paragraph","content":[{"text":"Latidos and Cicatrices","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Latidos arrived in 2016, with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"af726afa-c7a0-47da-99bb-a4c7669a8785","displayText":"Natti Natasha","occurrenceId":"59676565-1192-4d97-9c87-0ca3fc806219"}},{"text":" among its guests along with Vico C, Belinda, J Álvarez and Musicólogo El Libro. He signed to Sony Music Latin the same year and made Cicatrices for the label, bringing in ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8cd8d8ba-1043-4a73-be0b-7f64c3a2bae8","displayText":"Negro HP","occurrenceId":"af80ae7c-e564-4a6a-8431-22bde3acae51"}},{"text":", Magic Juan, Nacho, Leslie Grace and the Cuban rapper El B.","type":"text"}]},{"type":"paragraph","content":[{"text":"The battle","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2020 he went into a rap battle against ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fa9cc802-28ca-4695-b585-f75aa90a2b6c","displayText":"Mozart la Para","occurrenceId":"1fe7b9f7-b4d6-4a1e-966e-79baace4ce61"}},{"text":". It produced three singles — El Descanso Eterno, Tú No Tá and 9 Días — and it was followed as an event rather than as a novelty, which says something about where the genre had arrived. In 2022 he appeared on Culpable, on Romeo Santos’s Fórmula, Vol. 3.","type":"text"}]},{"type":"paragraph","content":[{"text":"The standing","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Premios Juventud nominated him as urban artist of the year in 2013. He won two Latin Music Italian Awards in 2016, and in 2017 Papa, recorded with Vico C, took him to a Latin Grammy nomination for best urban song — the man who had made him want to rap, on the record that got him there.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 2023 Rolling Stone en Español placed him forty-eighth on its list of the fifty greatest figures in the history of Spanish-language rap, which is the highest position any Dominican holds on it.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'lapiz-conciente'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Avelino Junior Figueroa Rodríguez, que graba como Lápiz Conciente, es un rapero, compositor y dueño de sello dominicano. Se le trata como uno de los fundadores del hip hop dominicano, y hay más biografías de este registro que apuntan hacia él que hacia ningún otro artista de su generación, lo que da una medida bastante justa de cuánta escena le pasa por encima.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Mina","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1983 en Los Mina, al este de Santo Domingo. Oyó al puertorriqueño Vico C a los diez años, en 1993, y de ahí sale el rapero; trabaja desde 1997. El nombre es de su abuela: viene de cómo lo decía ella, que es también la razón por la que siempre ha escrito Conciente sin la s.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ráfaga de Plomo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Empezó a sacar música por YouTube en 2008, entre ella Las Menores, y al año siguiente publicó el mixtape Ráfaga de Plomo. Era la vía que había: la radio dominicana de entonces le hacía poco sitio al rap, y la plataforma era donde ya estaba el público.","type":"text"}]},{"type":"paragraph","content":[{"text":"Capea el Dough","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2011 grabó Capea el Dough con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d25ea8c2-1e9f-4f77-832a-48886d50c47b","displayText":"Toxic Crow","occurrenceId":"985aafbc-f882-4aaf-9fb2-ea46ac311917"}},{"text":". El tema se convirtió en la pieza a la que echa mano la prensa dominicana cuando necesita señalar a qué suena el hip hop en este país, y siguió funcionando: en 2022 más de veintiocho urbanos dominicanos grabaron juntos una versión nueva.","type":"text"}]},{"type":"paragraph","content":[{"text":"Detrás vinieron Yo Soy Papá y Yo No Te Quiero Perder, con un público más grande que el que había alcanzado antes ningún rap dominicano.","type":"text"}]},{"type":"paragraph","content":[{"text":"Si No Te Quisiera","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2014 apareció en Si No Te Quisiera junto al productor español Juan Magán y la cantante mexicana Belinda, y el tema le valió una certificación de oro. Metió además a un rapero dominicano dentro de un lanzamiento comercial de pop latino, que no era una vía que hubiera estado abierta al género.","type":"text"}]},{"type":"paragraph","content":[{"text":"Latidos y Cicatrices","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Latidos salió en 2016, con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"af726afa-c7a0-47da-99bb-a4c7669a8785","displayText":"Natti Natasha","occurrenceId":"8c1c7d43-8062-43d3-b000-6dce1958e96b"}},{"text":" entre los invitados junto a Vico C, Belinda, J Álvarez y Musicólogo El Libro. Ese mismo año firmó con Sony Music Latin e hizo para el sello Cicatrices, donde metió a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8cd8d8ba-1043-4a73-be0b-7f64c3a2bae8","displayText":"Negro HP","occurrenceId":"d2f09be7-337b-48c5-9fbd-a1fa33934d9f"}},{"text":", Magic Juan, Nacho, Leslie Grace y al rapero cubano El B.","type":"text"}]},{"type":"paragraph","content":[{"text":"La batalla","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2020 se metió en una batalla de rap contra ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fa9cc802-28ca-4695-b585-f75aa90a2b6c","displayText":"Mozart la Para","occurrenceId":"390638ba-add4-4969-9028-964f07c6e633"}},{"text":". De ahí salieron tres sencillos — El Descanso Eterno, Tú No Tá y 9 Días — y se siguió como acontecimiento y no como curiosidad, lo que dice algo sobre dónde había llegado el género. En 2022 apareció en Culpable, del Fórmula, Vol. 3 de Romeo Santos.","type":"text"}]},{"type":"paragraph","content":[{"text":"El lugar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Premios Juventud lo nominó como artista urbano del año en 2013. Ganó dos Latin Music Italian Awards en 2016, y en 2017 Papa, grabada con Vico C, lo llevó a una nominación al Latin Grammy a la mejor canción urbana: el hombre que le dio ganas de rapear, en el disco que lo puso ahí.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 2023 Rolling Stone en Español lo colocó en el puesto cuarenta y ocho de su lista de los cincuenta grandes de la historia del rap en español, que es la posición más alta que ocupa un dominicano en ella.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'lapiz-conciente'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'lapiz-conciente') AND locale = 'en'), '1fe7b9f7-b4d6-4a1e-966e-79baace4ce61', 'artist', 'fa9cc802-28ca-4695-b585-f75aa90a2b6c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'lapiz-conciente') AND locale = 'en'), '338f6d29-66cf-4f43-8ddd-9b290b363fa6', 'artist', 'd25ea8c2-1e9f-4f77-832a-48886d50c47b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'lapiz-conciente') AND locale = 'en'), '59676565-1192-4d97-9c87-0ca3fc806219', 'artist', 'af726afa-c7a0-47da-99bb-a4c7669a8785');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'lapiz-conciente') AND locale = 'en'), 'af80ae7c-e564-4a6a-8431-22bde3acae51', 'artist', '8cd8d8ba-1043-4a73-be0b-7f64c3a2bae8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'lapiz-conciente') AND locale = 'es'), '390638ba-add4-4969-9028-964f07c6e633', 'artist', 'fa9cc802-28ca-4695-b585-f75aa90a2b6c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'lapiz-conciente') AND locale = 'es'), '8c1c7d43-8062-43d3-b000-6dce1958e96b', 'artist', 'af726afa-c7a0-47da-99bb-a4c7669a8785');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'lapiz-conciente') AND locale = 'es'), '985aafbc-f882-4aaf-9fb2-ea46ac311917', 'artist', 'd25ea8c2-1e9f-4f77-832a-48886d50c47b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'lapiz-conciente') AND locale = 'es'), 'd2f09be7-337b-48c5-9fbd-a1fa33934d9f', 'artist', '8cd8d8ba-1043-4a73-be0b-7f64c3a2bae8');

COMMIT;
