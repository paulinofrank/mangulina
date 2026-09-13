BEGIN;

-- Rewrite the catalogue entry for Rafa Rosario.
--
-- Rafa Rosario. DECIMOCTAVA de las 211. 789 caracteres en un párrafo, y la
-- tercera plantilla seguida: "His career across multiple decades of Dominican
-- popular music reflects the commitment of a working musician who has dedicated
-- his professional life to the genres and traditions of the country's popular
-- entertainment."
--
-- Es sobre el hombre que DIRIGE LOS HERMANOS ROSARIO DESDE 1983 y que canta la
-- voz principal de buena parte del catálogo del grupo, y no lo menciona. Lo que
-- sí hacía era gastar tres líneas explicando que Higüey ha dado artistas
-- importantes "incluidos miembros de Los Hermanos Rosario" -- sin decir que él
-- es uno de ellos.
--
-- EL NOMBRE LEGAL ESTABA EN mb_metadata Y NO EN LOS CAMPOS: MusicBrainz guarda
-- "RAFAEL INOCENCIO DEL ROSARIO" marcado expresamente como Legal name, y la
-- fila no tenía ni first_name. Tercera vez en tres días que el dato bueno está
-- dentro de la propia fila, en un campo que nadie leyó.
--
-- LO QUE FALTABA:
--
--   ES FUNDADOR DEL GRUPO. Debutaron el 1 de mayo de 1978 en Higüey, siete
--   hermanos, tocando para las autoridades municipales en un acto del Día del
--   Trabajo.
--
--   SU LIDERAZGO EMPIEZA EN 1983, y esto lo dice Listín Diario con todas las
--   letras: surgió a raíz de la muerte de PEPE ROSARIO, que era el pianista,
--   director musical y líder. Escribí la ficha de Pepe hace unos días y esta la
--   continúa: el grupo paró, los hermanos se plantearon dejarlo, y no lo
--   dejaron.
--
--   SIGUE SIENDO EL LÍDER Y DIRECTOR cuarenta y tres años después. La prensa
--   dominicana lo nombra así de manera invariable.
--
--   CANTA. Y hay créditos concretos, que es lo que la ficha vieja no tenía:
--   "ESCLAVO DE TU AMOR" (1993), de "Los Mundialmente Sabrosos", con voz suya,
--   y "EL ROMPECINTURA" (1997).
--
-- EL DATO MEJOR DE LA FICHA, y sale de la metadata de derechos de Apple Music:
-- "ESCLAVO DE TU AMOR" LA COMPUSO RAFAEL ENCARNACIÓN, el bachatero que murió en
-- 1962, y la arregló MANUEL TEJADA. Es decir, una bachata de los años cincuenta
-- convertida en merengue treinta años después. Los dos están en el catálogo.
--
-- LA FAMILIA NO VA EN LA PROSA Y NO ES OLVIDO: es hermano de Toño y de Pepe,
-- padre de Rafely y tío de Checho, y LOS CUATRO PARENTESCOS YA ESTÁN
-- REGISTRADOS en artist_family_relationships. La regla dice que los lazos
-- cercanos entre artistas van en esa tabla y no en el texto, así que aquí no se
-- repiten. A Toño y a Pepe sí se les enlaza, pero por crédito: fundaron y
-- sostuvieron la misma orquesta.
--
-- NO SE REPITE LA FICHA DEL GRUPO. Los Hermanos Rosario tienen la suya, con
-- 3.616 caracteres, escrita en esta corrida: los discos, el Billboard, los
-- Congos de Oro y "La Dueña del Swing" están allí. Esta ficha es sobre él.
--
-- occupations E instruments ESTABAN VACÍOS y se llenan con lo que las fuentes
-- sostienen: director de orquesta y director musical, y voz.
--
-- LO QUE SE DEJA FUERA: cuántos hijos tiene y con quién, que es lo que más se
-- pregunta de él en los buscadores.
--
-- CINCO ENLACES: el grupo, Pepe, Toño, Rafael Encarnación y Manuel Tejada.
--
-- FUENTES: Listín Diario (20 de octubre de 2010) para el origen de su
-- liderazgo. Wikipedia en español, artículo de Los Hermanos Rosario, para el
-- debut y la formación -- marcado por falta de referencias desde 2010, y por eso
-- solo se usa para lo que la prensa repite. Apple Music, créditos de
-- composición de "Esclavo de Tu Amor". Los videos oficiales del grupo para los
-- créditos de voz.
--
-- AUSENCIAS NUEVAS: TONY ROSARIO y LUIS ROSARIO, los otros dos integrantes
-- actuales del grupo. Ojo con Luis: el catálogo tiene un
-- `jorge-luis-rosario-rodriguez` que es OTRA PERSONA, urbano, y no debe
-- reutilizarse su slug. También CHIQUITÍN PAYÁN, que fue quien los contrató
-- para el Hotel Romana y los sacó del circuito local.
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
       name = 'Rafa Rosario',
       sort_name = 'Rosario, Rafa',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1958-12-28',
       birth_year = 1958,
       date_of_death = NULL,
       birth_place = 'Higüey',
       province = 'La Altagracia',
       first_name = 'Rafael',
       middle_name = 'Inocencio',
       last_name = 'del Rosario',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '["bandleader","musical_director"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = '100005450176734',
       instagram = 'rafarosario28',
       disambiguation = 'Merengue singer; founding member and, since 1983, leader of Los Hermanos Rosario',
       bio_en = 'Rafael Inocencio del Rosario, who performs as Rafa Rosario, is a Dominican merengue singer and bandleader. He is a founding member of Los Hermanos Rosario and has led and directed the orchestra since 1983, which makes him one of the longest-serving bandleaders in Dominican popular music.

**Salvaleón de Higüey**

He was born on 28 December 1958 in Higüey, in the province of La Altagracia at the eastern end of the country. The group he would spend his life in was made up of seven brothers and made its debut on 1 May 1978, in their own town, playing for the municipal authorities at a Labour Day event.

**Taking over the orchestra**

For the first five years the pianist, musical director and leader was his brother Pepe Rosario. When Pepe died in 1983 the group stopped playing and the brothers considered giving it up and going home. Rafa Rosario’s leadership dates from that moment, and the Dominican press has described it that way ever since.

He and Toño Rosario carried the orchestra through the years that followed, and within a decade it had become the most widely heard merengue band the country had produced. He has continued to direct it for four decades, through changes of line-up, of label and of generation.

**Esclavo de Tu Amor**

He sings lead on a substantial part of the group’s catalogue. Esclavo de Tu Amor, from Los Mundialmente Sabrosos in 1993, is his, and so is El Rompecintura, from 1997.

The first of those is worth following back: the song was written by Rafael Encarnación, a bachata singer who had died in 1962, and arranged for the orchestra by Manuel Tejada. What the record does is take a bachata from the fifties and turn it into a merengue thirty years later, which is a fair description of how the group has treated Dominican repertoire generally.',
       bio_es = 'Rafael Inocencio del Rosario, que se presenta como Rafa Rosario, es un cantante y director de orquesta dominicano de merengue. Es miembro fundador de Los Hermanos Rosario y dirige la orquesta desde 1983, lo que lo convierte en uno de los directores con más años al frente de una agrupación en la música popular dominicana.

**Salvaleón de Higüey**

Nació el 28 de diciembre de 1958 en Higüey, provincia La Altagracia, en el extremo este del país. El grupo en el que iba a pasar la vida lo formaban siete hermanos y debutó el 1 de mayo de 1978, en su propio pueblo, tocando para las autoridades municipales en un acto del Día del Trabajo.

**Al frente de la orquesta**

Durante los primeros cinco años el pianista, director musical y líder fue su hermano Pepe Rosario. Cuando Pepe murió en 1983 el grupo dejó de tocar y los hermanos se plantearon dejarlo todo y volverse al pueblo. El liderazgo de Rafa Rosario arranca de ahí, y así lo ha descrito la prensa dominicana desde entonces.

Él y Toño Rosario sacaron adelante la orquesta en los años siguientes, y en una década era la banda de merengue más escuchada que había dado el país. La ha dirigido cuatro décadas, a través de cambios de alineación, de sello y de generación.

**Esclavo de Tu Amor**

Canta la voz principal de buena parte del catálogo del grupo. Esclavo de Tu Amor, de Los Mundialmente Sabrosos, de 1993, es suya, y también El Rompecintura, de 1997.

La primera conviene seguirla hacia atrás: la compuso Rafael Encarnación, un bachatero muerto en 1962, y la arregló para la orquesta Manuel Tejada. Lo que hace ese disco es tomar una bachata de los años cincuenta y convertirla en merengue treinta años después, que es una buena descripción de cómo el grupo ha tratado el repertorio dominicano en general.',
       updated_at = now()
 WHERE slug = 'rafa-rosario';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Rafael Inocencio del Rosario, who performs as Rafa Rosario, is a Dominican merengue singer and bandleader. He is a founding member of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario","occurrenceId":"a4afb7ed-9a0e-4b63-b19e-d365bac0352a"}},{"text":" and has led and directed the orchestra since 1983, which makes him one of the longest-serving bandleaders in Dominican popular music.","type":"text"}]},{"type":"paragraph","content":[{"text":"Salvaleón de Higüey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born on 28 December 1958 in Higüey, in the province of La Altagracia at the eastern end of the country. The group he would spend his life in was made up of seven brothers and made its debut on 1 May 1978, in their own town, playing for the municipal authorities at a Labour Day event.","type":"text"}]},{"type":"paragraph","content":[{"text":"Taking over the orchestra","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"For the first five years the pianist, musical director and leader was his brother ","type":"text"},{"type":"artistReference","attrs":{"artistId":"03586dc0-5bbe-4b91-859d-f9c0dd580ea4","displayText":"Pepe Rosario","occurrenceId":"65748052-fcc2-4f39-aa1a-ee2b47782e09"}},{"text":". When Pepe died in 1983 the group stopped playing and the brothers considered giving it up and going home. Rafa Rosario’s leadership dates from that moment, and the Dominican press has described it that way ever since.","type":"text"}]},{"type":"paragraph","content":[{"text":"He and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario","occurrenceId":"c574c885-5de0-469a-9cd0-b98cbec8d86b"}},{"text":" carried the orchestra through the years that followed, and within a decade it had become the most widely heard merengue band the country had produced. He has continued to direct it for four decades, through changes of line-up, of label and of generation.","type":"text"}]},{"type":"paragraph","content":[{"text":"Esclavo de Tu Amor","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He sings lead on a substantial part of the group’s catalogue. Esclavo de Tu Amor, from Los Mundialmente Sabrosos in 1993, is his, and so is El Rompecintura, from 1997.","type":"text"}]},{"type":"paragraph","content":[{"text":"The first of those is worth following back: the song was written by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3ae30a9a-5369-4084-8162-b2d470263f1e","displayText":"Rafael Encarnación","occurrenceId":"7a20611c-cddd-4cd6-866e-ff30201e2dbe"}},{"text":", a bachata singer who had died in 1962, and arranged for the orchestra by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4d3a653c-688e-47c1-8cec-b8cf85a4abac","displayText":"Manuel Tejada","occurrenceId":"d6c7dfa6-ad20-4bf7-82aa-d73519f72d41"}},{"text":". What the record does is take a bachata from the fifties and turn it into a merengue thirty years later, which is a fair description of how the group has treated Dominican repertoire generally.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'rafa-rosario'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Rafael Inocencio del Rosario, que se presenta como Rafa Rosario, es un cantante y director de orquesta dominicano de merengue. Es miembro fundador de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario","occurrenceId":"56196792-d02b-438b-a2e3-d74e4bc6d300"}},{"text":" y dirige la orquesta desde 1983, lo que lo convierte en uno de los directores con más años al frente de una agrupación en la música popular dominicana.","type":"text"}]},{"type":"paragraph","content":[{"text":"Salvaleón de Higüey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació el 28 de diciembre de 1958 en Higüey, provincia La Altagracia, en el extremo este del país. El grupo en el que iba a pasar la vida lo formaban siete hermanos y debutó el 1 de mayo de 1978, en su propio pueblo, tocando para las autoridades municipales en un acto del Día del Trabajo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Al frente de la orquesta","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Durante los primeros cinco años el pianista, director musical y líder fue su hermano ","type":"text"},{"type":"artistReference","attrs":{"artistId":"03586dc0-5bbe-4b91-859d-f9c0dd580ea4","displayText":"Pepe Rosario","occurrenceId":"dd8c8913-2dd5-4cfe-9ef9-3a3eb12cabe4"}},{"text":". Cuando Pepe murió en 1983 el grupo dejó de tocar y los hermanos se plantearon dejarlo todo y volverse al pueblo. El liderazgo de Rafa Rosario arranca de ahí, y así lo ha descrito la prensa dominicana desde entonces.","type":"text"}]},{"type":"paragraph","content":[{"text":"Él y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario","occurrenceId":"ede552ef-7706-4a2a-adab-0e6d3baf40cc"}},{"text":" sacaron adelante la orquesta en los años siguientes, y en una década era la banda de merengue más escuchada que había dado el país. La ha dirigido cuatro décadas, a través de cambios de alineación, de sello y de generación.","type":"text"}]},{"type":"paragraph","content":[{"text":"Esclavo de Tu Amor","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Canta la voz principal de buena parte del catálogo del grupo. Esclavo de Tu Amor, de Los Mundialmente Sabrosos, de 1993, es suya, y también El Rompecintura, de 1997.","type":"text"}]},{"type":"paragraph","content":[{"text":"La primera conviene seguirla hacia atrás: la compuso ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3ae30a9a-5369-4084-8162-b2d470263f1e","displayText":"Rafael Encarnación","occurrenceId":"7d22c3a1-5b1a-41ed-9130-b512ba69eb46"}},{"text":", un bachatero muerto en 1962, y la arregló para la orquesta ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4d3a653c-688e-47c1-8cec-b8cf85a4abac","displayText":"Manuel Tejada","occurrenceId":"4561c03e-ee0f-4c10-8dc1-c528816f2f2e"}},{"text":". Lo que hace ese disco es tomar una bachata de los años cincuenta y convertirla en merengue treinta años después, que es una buena descripción de cómo el grupo ha tratado el repertorio dominicano en general.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'rafa-rosario'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario') AND locale = 'en'), '65748052-fcc2-4f39-aa1a-ee2b47782e09', 'artist', '03586dc0-5bbe-4b91-859d-f9c0dd580ea4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario') AND locale = 'en'), '7a20611c-cddd-4cd6-866e-ff30201e2dbe', 'artist', '3ae30a9a-5369-4084-8162-b2d470263f1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario') AND locale = 'en'), 'a4afb7ed-9a0e-4b63-b19e-d365bac0352a', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario') AND locale = 'en'), 'c574c885-5de0-469a-9cd0-b98cbec8d86b', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario') AND locale = 'en'), 'd6c7dfa6-ad20-4bf7-82aa-d73519f72d41', 'artist', '4d3a653c-688e-47c1-8cec-b8cf85a4abac');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario') AND locale = 'es'), '4561c03e-ee0f-4c10-8dc1-c528816f2f2e', 'artist', '4d3a653c-688e-47c1-8cec-b8cf85a4abac');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario') AND locale = 'es'), '56196792-d02b-438b-a2e3-d74e4bc6d300', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario') AND locale = 'es'), '7d22c3a1-5b1a-41ed-9130-b512ba69eb46', 'artist', '3ae30a9a-5369-4084-8162-b2d470263f1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario') AND locale = 'es'), 'dd8c8913-2dd5-4cfe-9ef9-3a3eb12cabe4', 'artist', '03586dc0-5bbe-4b91-859d-f9c0dd580ea4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rafa-rosario') AND locale = 'es'), 'ede552ef-7706-4a2a-adab-0e6d3baf40cc', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e');

COMMIT;
