BEGIN;

-- Rewrite the catalogue entry for Julio Alberto Hernández.
--
-- Julio Alberto Hernández. Undécima de las dieciséis fichas publicadas que
-- estaban EN BLANCO. Noventa y ocho años de vida, fundador de la música de
-- concierto dominicana, y su página no decía nada.
--
-- LO QUE YA TENÍA LA FILA SE CONFIRMA Y NO SE TOCA: 27 de septiembre de 1900 en
-- Santiago de los Caballeros, muerte el 2 de abril de 1999, ended en true,
-- primary_role composer, instruments piano y saxofón. Wikipedia respalda las
-- dos fechas y los dos instrumentos.
--
-- SE COMPLETA EL APELLIDO MATERNO: CAMEJO. Wikipedia da el nombre de nacimiento
-- completo, Julio Alberto Hernández Camejo.
--
-- SE CORRIGE UN ERROR DE OCUPACIONES. La fila guardaba occupations = ['Singer',
-- 'musician']. Ninguna de las dos sirve:
--
--   'Singer' NO ESTÁ RESPALDADO POR NINGUNA FUENTE. Wikipedia lo describe como
--   compositor, pianista, músico y director de orquesta, y lo categoriza entre
--   los directores de orquesta y los folcloristas. En ninguna parte canta. Era
--   además el ÚNICO valor con mayúscula inicial en todo el vocabulario de
--   ocupaciones del catálogo, lo que ya delataba una carga suelta.
--
--   'musician' es tan vago que no informa nada sobre un compositor.
--
-- Quedan pianist, conductor y music educator. Los tres existen ya en el
-- vocabulario. El tercero lo sostienen sus cancioneros infantiles, sus himnos
-- escolares, su libro sobre música tradicional y el profesorado honorario que
-- le dio la UASD.
--
-- GÉNERO VERIFICADO ANTES DE DUDARLO: instrumental-classical es un subgénero de
-- nivel 1 activo, hijo de instrumental. Está bien puesto y no se toca. Se
-- agrega folklore en genres, que no repite el primario y que sostiene la propia
-- Wikipedia al llamarlo "compositor de música folclórica" y categorizarlo entre
-- los folcloristas.
--
-- CUATRO ENLACES, TODOS CON RELACIÓN DOCUMENTADA: gabriel-del-orbe y
-- carlos-piantini, con quienes compartió escenario según Wikipedia;
-- juan-francisco-garcia, que integró con él el conjunto de 1922; y
-- eduardo-brito, que formó parte del cuadro artístico que Hernández reunió.
--
-- NO SE CITA TEXTUALMENTE a Arístides Incháustegui, aunque su valoración es la
-- mejor que existe sobre esta obra. Se parafrasea y se le atribuye, que es como
-- se construyen estas fichas.
--
-- LOS DOS RECONOCIMIENTOS VAN EN MIGRACIÓN APARTE y obligan a crear dos
-- categorías. La de la UASD NO es la misma que la de Yaqui Núñez del Risco: a
-- él lo invistieron Profesor Honoris Causa y a Hernández lo declararon Profesor
-- Honorario de la Facultad de Humanidades. Son distinciones distintas y se
-- registran por separado.
--
-- FUENTES: Wikipedia en español, bien referenciada, con discografía de diez
-- larga duración. El Caribe y mipais.jmarcano.com, citados por ella.
--
-- NOMBRES NUEVOS PARA LA LISTA: Pedro Camejo, Ramón Emilio Peralta y José
-- Ovidio, sus tres maestros; Luis Bonnelly, Susano Polanco y Luis Rivera, del
-- conjunto de 1922; Catalina Jaquez y Miguel Ángel Jiménez, del cuadro
-- artístico; y la Orquesta Sinfónica de Santo Domingo. NO ENTRAN los
-- extranjeros: Antonio Paoli, Pedro San Juan, Emil Friedman y Bugomil Sykora.
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
       name = 'Julio Alberto Hernández',
       sort_name = 'Hernández Camejo, Julio Alberto',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'composer',
       primary_genre = 'instrumental-classical',
       date_of_birth = '1900-09-27',
       birth_year = 1900,
       date_of_death = '1999-04-02',
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Julio',
       middle_name = 'Alberto',
       last_name = 'Hernández',
       second_last_name = 'Camejo',
       stage_name = 'Julio Alberto Hernández',
       aliases = ARRAY[]::text[],
       occupations = '["pianist","conductor","music educator"]'::jsonb,
       instruments = ARRAY['piano', 'saxophone']::text[],
       genres = ARRAY['folklore']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Composer, pianist and conductor; built a concert repertoire out of Dominican folk rhythms',
       bio_en = 'Julio Alberto Hernández Camejo was a Dominican composer, pianist and conductor. He worked for most of the twentieth century and built a body of concert music out of Dominican folk material, and he was among the musicians who founded the country’s orchestral life.

**Santiago**

He was born in Santiago de los Caballeros in 1900 and began studying music very young, taking solfège from Pedro Camejo, saxophone from Ramón Emilio Peralta and piano from José Ovidio. By fourteen he was playing saxophone in his town’s municipal band and was already drawing attention at the piano.

**The accompanist**

For years he was one of the most sought-after accompanying pianists in the country, and over a long career he shared the stage with singers and instrumentalists including Gabriel del Orbe and Carlos Piantini. In 1922 he formed an ensemble with Juan Francisco García on cornet and three other players, and they toured Dajabón, Montecristi and Cap-Haïtien.

**Havana**

In 1924 he left for Cuba with a touring variety company. In Havana he studied harmony and composition with the Spanish conductor Pedro San Juan, then at the head of the city’s philharmonic, and it was there that his training as a composer was completed.

**The artistic circle**

Back home he assembled a company that gathered several of the leading performers of the period, among them Eduardo Brito, Catalina Jaquez and Miguel Ángel Jiménez.

**The symphony**

When the Orquesta Sinfónica de Santo Domingo was founded in 1932 he was invited to take part. In December of the following year he conducted one of its first concerts, which is remembered as the first time a complete work was performed in the country: a cello concerto by Saint-Saëns, with a visiting Russian soloist.

**The work**

His catalogue is wide and deliberately small in scale. The musicographer Arístides Incháustegui described him as a miniaturist who used the roots of Dominican folklore to fix the country’s creole rhythms in written form, and that is the shape of the output: waltzes, criollas, merengues and pieces for two pianos.

He also worked at the base of musical life. He recorded albums of Dominican children’s songs and school hymns, made instrumental settings of the best-known national songs, and published a study of Dominican traditional music.

**Recognition**

The Dominican government awarded him the Order of Merit of Duarte, Sánchez and Mella at the rank of officer, and the Universidad Autónoma de Santo Domingo named him an honorary professor of its faculty of humanities. He died in Santo Domingo in 1999, at ninety-eight.',
       bio_es = 'Julio Alberto Hernández Camejo fue un compositor, pianista y director de orquesta dominicano. Trabajó durante casi todo el siglo veinte y construyó una obra de concierto a partir de material folclórico dominicano, y fue uno de los músicos que fundaron la vida orquestal del país.

**Santiago**

Nació en Santiago de los Caballeros en 1900 y empezó a estudiar música muy niño: solfeo con Pedro Camejo, saxofón con Ramón Emilio Peralta y piano con José Ovidio. A los catorce años ya tocaba el saxofón en la banda de música de su ciudad y empezaba a destacar en el piano.

**El acompañante**

Durante años fue uno de los pianistas acompañantes más solicitados del país, y a lo largo de una carrera larga compartió escenario con cantantes e instrumentistas, entre ellos Gabriel del Orbe y Carlos Piantini. En 1922 formó un conjunto con Juan Francisco García en el cornetín y otros tres músicos, y recorrieron Dajabón, Montecristi y Cabo Haitiano.

**La Habana**

En 1924 partió hacia Cuba con una compañía de variedades. En La Habana estudió armonía y composición con el director español Pedro San Juan, entonces al frente de la filarmónica de aquella ciudad, y allí terminó de formarse como compositor.

**El cuadro artístico**

De regreso reunió una compañía que agrupó a varios de los intérpretes principales de la época, entre ellos Eduardo Brito, Catalina Jaquez y Miguel Ángel Jiménez.

**La sinfónica**

Cuando se fundó la Orquesta Sinfónica de Santo Domingo, en 1932, fue invitado a participar. En diciembre del año siguiente dirigió uno de sus primeros conciertos, recordado como la primera vez que se ejecutó una obra completa en el país: un concierto para violonchelo de Saint-Saëns, con un solista ruso de visita.

**La obra**

Su catálogo es amplio y de escala deliberadamente pequeña. El musicógrafo Arístides Incháustegui lo describió como un miniaturista que usó las raíces del folklore dominicano para fijar por escrito los ritmos criollos del país, y esa es la forma de su producción: valses, criollas, merengues y piezas para dos pianos.

Trabajó además en la base de la vida musical. Grabó discos de canciones infantiles dominicanas y de himnos escolares, hizo versiones instrumentales de las canciones nacionales más conocidas, y publicó un estudio sobre la música tradicional dominicana.

**Reconocimientos**

El gobierno dominicano le otorgó la Orden del Mérito de Duarte, Sánchez y Mella en el grado de oficial, y la Universidad Autónoma de Santo Domingo lo declaró profesor honorario de su facultad de humanidades. Murió en Santo Domingo en 1999, a los noventa y ocho años.',
       updated_at = now()
 WHERE slug = 'julio-alberto-hernandez';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'julio-alberto-hernandez')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'julio-alberto-hernandez')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Julio Alberto Hernández Camejo was a Dominican composer, pianist and conductor. He worked for most of the twentieth century and built a body of concert music out of Dominican folk material, and he was among the musicians who founded the country’s orchestral life.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santiago","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Santiago de los Caballeros in 1900 and began studying music very young, taking solfège from Pedro Camejo, saxophone from Ramón Emilio Peralta and piano from José Ovidio. By fourteen he was playing saxophone in his town’s municipal band and was already drawing attention at the piano.","type":"text"}]},{"type":"paragraph","content":[{"text":"The accompanist","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"For years he was one of the most sought-after accompanying pianists in the country, and over a long career he shared the stage with singers and instrumentalists including ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f588dfa7-06ce-4b33-8d63-51182258bb71","displayText":"Gabriel del Orbe","occurrenceId":"2bd24ce3-8d5e-4c0c-9a44-9b2868c3fc4a"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ebd75bb5-0571-4199-9474-22d173b3d072","displayText":"Carlos Piantini","occurrenceId":"01830ccc-1d69-4ced-b6aa-16072fbf49fb"}},{"text":". In 1922 he formed an ensemble with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a4f98603-5d27-4971-bea9-d8c1c9e996da","displayText":"Juan Francisco García","occurrenceId":"b38daf4c-c9dd-4f71-9b02-ebc980e57be5"}},{"text":" on cornet and three other players, and they toured Dajabón, Montecristi and Cap-Haïtien.","type":"text"}]},{"type":"paragraph","content":[{"text":"Havana","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1924 he left for Cuba with a touring variety company. In Havana he studied harmony and composition with the Spanish conductor Pedro San Juan, then at the head of the city’s philharmonic, and it was there that his training as a composer was completed.","type":"text"}]},{"type":"paragraph","content":[{"text":"The artistic circle","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Back home he assembled a company that gathered several of the leading performers of the period, among them ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ec0423fc-fe53-42e9-8d0f-f2ae902512d3","displayText":"Eduardo Brito","occurrenceId":"cdb09673-05be-494c-b5dc-aeef0dfdc379"}},{"text":", Catalina Jaquez and Miguel Ángel Jiménez.","type":"text"}]},{"type":"paragraph","content":[{"text":"The symphony","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"When the Orquesta Sinfónica de Santo Domingo was founded in 1932 he was invited to take part. In December of the following year he conducted one of its first concerts, which is remembered as the first time a complete work was performed in the country: a cello concerto by Saint-Saëns, with a visiting Russian soloist.","type":"text"}]},{"type":"paragraph","content":[{"text":"The work","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His catalogue is wide and deliberately small in scale. The musicographer Arístides Incháustegui described him as a miniaturist who used the roots of Dominican folklore to fix the country’s creole rhythms in written form, and that is the shape of the output: waltzes, criollas, merengues and pieces for two pianos.","type":"text"}]},{"type":"paragraph","content":[{"text":"He also worked at the base of musical life. He recorded albums of Dominican children’s songs and school hymns, made instrumental settings of the best-known national songs, and published a study of Dominican traditional music.","type":"text"}]},{"type":"paragraph","content":[{"text":"Recognition","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The Dominican government awarded him the Order of Merit of Duarte, Sánchez and Mella at the rank of officer, and the Universidad Autónoma de Santo Domingo named him an honorary professor of its faculty of humanities. He died in Santo Domingo in 1999, at ninety-eight.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'julio-alberto-hernandez'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Julio Alberto Hernández Camejo fue un compositor, pianista y director de orquesta dominicano. Trabajó durante casi todo el siglo veinte y construyó una obra de concierto a partir de material folclórico dominicano, y fue uno de los músicos que fundaron la vida orquestal del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santiago","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santiago de los Caballeros en 1900 y empezó a estudiar música muy niño: solfeo con Pedro Camejo, saxofón con Ramón Emilio Peralta y piano con José Ovidio. A los catorce años ya tocaba el saxofón en la banda de música de su ciudad y empezaba a destacar en el piano.","type":"text"}]},{"type":"paragraph","content":[{"text":"El acompañante","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Durante años fue uno de los pianistas acompañantes más solicitados del país, y a lo largo de una carrera larga compartió escenario con cantantes e instrumentistas, entre ellos ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f588dfa7-06ce-4b33-8d63-51182258bb71","displayText":"Gabriel del Orbe","occurrenceId":"8174ee1f-1907-4d8a-9f6f-959e20014726"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ebd75bb5-0571-4199-9474-22d173b3d072","displayText":"Carlos Piantini","occurrenceId":"79e40ea6-7e7e-4690-94f8-90fd1ff4f4cb"}},{"text":". En 1922 formó un conjunto con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a4f98603-5d27-4971-bea9-d8c1c9e996da","displayText":"Juan Francisco García","occurrenceId":"f7a5519a-913c-4e4f-9d20-014923f64f92"}},{"text":" en el cornetín y otros tres músicos, y recorrieron Dajabón, Montecristi y Cabo Haitiano.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Habana","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1924 partió hacia Cuba con una compañía de variedades. En La Habana estudió armonía y composición con el director español Pedro San Juan, entonces al frente de la filarmónica de aquella ciudad, y allí terminó de formarse como compositor.","type":"text"}]},{"type":"paragraph","content":[{"text":"El cuadro artístico","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"De regreso reunió una compañía que agrupó a varios de los intérpretes principales de la época, entre ellos ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ec0423fc-fe53-42e9-8d0f-f2ae902512d3","displayText":"Eduardo Brito","occurrenceId":"f38d0a60-85dc-4e82-9a56-a6b491d1bf4d"}},{"text":", Catalina Jaquez y Miguel Ángel Jiménez.","type":"text"}]},{"type":"paragraph","content":[{"text":"La sinfónica","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Cuando se fundó la Orquesta Sinfónica de Santo Domingo, en 1932, fue invitado a participar. En diciembre del año siguiente dirigió uno de sus primeros conciertos, recordado como la primera vez que se ejecutó una obra completa en el país: un concierto para violonchelo de Saint-Saëns, con un solista ruso de visita.","type":"text"}]},{"type":"paragraph","content":[{"text":"La obra","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su catálogo es amplio y de escala deliberadamente pequeña. El musicógrafo Arístides Incháustegui lo describió como un miniaturista que usó las raíces del folklore dominicano para fijar por escrito los ritmos criollos del país, y esa es la forma de su producción: valses, criollas, merengues y piezas para dos pianos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Trabajó además en la base de la vida musical. Grabó discos de canciones infantiles dominicanas y de himnos escolares, hizo versiones instrumentales de las canciones nacionales más conocidas, y publicó un estudio sobre la música tradicional dominicana.","type":"text"}]},{"type":"paragraph","content":[{"text":"Reconocimientos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El gobierno dominicano le otorgó la Orden del Mérito de Duarte, Sánchez y Mella en el grado de oficial, y la Universidad Autónoma de Santo Domingo lo declaró profesor honorario de su facultad de humanidades. Murió en Santo Domingo en 1999, a los noventa y ocho años.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'julio-alberto-hernandez'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'julio-alberto-hernandez') AND locale = 'en'), '01830ccc-1d69-4ced-b6aa-16072fbf49fb', 'artist', 'ebd75bb5-0571-4199-9474-22d173b3d072');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'julio-alberto-hernandez') AND locale = 'en'), '2bd24ce3-8d5e-4c0c-9a44-9b2868c3fc4a', 'artist', 'f588dfa7-06ce-4b33-8d63-51182258bb71');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'julio-alberto-hernandez') AND locale = 'en'), 'b38daf4c-c9dd-4f71-9b02-ebc980e57be5', 'artist', 'a4f98603-5d27-4971-bea9-d8c1c9e996da');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'julio-alberto-hernandez') AND locale = 'en'), 'cdb09673-05be-494c-b5dc-aeef0dfdc379', 'artist', 'ec0423fc-fe53-42e9-8d0f-f2ae902512d3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'julio-alberto-hernandez') AND locale = 'es'), '79e40ea6-7e7e-4690-94f8-90fd1ff4f4cb', 'artist', 'ebd75bb5-0571-4199-9474-22d173b3d072');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'julio-alberto-hernandez') AND locale = 'es'), '8174ee1f-1907-4d8a-9f6f-959e20014726', 'artist', 'f588dfa7-06ce-4b33-8d63-51182258bb71');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'julio-alberto-hernandez') AND locale = 'es'), 'f38d0a60-85dc-4e82-9a56-a6b491d1bf4d', 'artist', 'ec0423fc-fe53-42e9-8d0f-f2ae902512d3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'julio-alberto-hernandez') AND locale = 'es'), 'f7a5519a-913c-4e4f-9d20-014923f64f92', 'artist', 'a4f98603-5d27-4971-bea9-d8c1c9e996da');

COMMIT;
