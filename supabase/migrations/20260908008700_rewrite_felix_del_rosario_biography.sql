BEGIN;

-- Rewrite the catalogue entry for Félix del Rosario.
--
-- Felix del Rosario. VIGESIMOSEGUNDA de las 211. 1.261 caracteres, dos
-- parrafos, y una ficha que no nombra ni una cancion ni un musico de su
-- orquesta, sobre un hombre que TIENE VEINTITANTOS DISCOS.
--
-- Ademas cerraba diciendo que paso "nearly eight decades enriching Dominican
-- musical life": vivio 78 anos y empezo a estudiar musica a los quince, asi que
-- la carrera fue de unos cincuenta y cinco. Es una cifra inventada por redondeo.
--
-- ---------------------------------------------------------------------------
-- TRES ARREGLOS DE FILA, Y LOS TRES CON FUENTE UNANIME
--
-- 1. LA FECHA ESTABA UN MES CORRIDA. La fila decia 12 DE JUNIO de 1934. Nacio
--    el 12 DE JULIO: lo dicen Wikipedia, EcuRed, el MINISTERIO DE CULTURA, El
--    Dia en su obituario del 27 de octubre de 2012 y El Nacional. NADA dice
--    junio. Corregido.
--
-- 2. `primary_role` DECIA 'singer'. NO CANTABA. Era SAXOFONISTA, compositor y
--    director. Es el mismo error que tenia Edilio Paredes al reves: alli la
--    fila sabia que era instrumentista y el texto lo llamaba "artist"; aqui la
--    fila lo hace cantante. Pasa a 'instrumentalist'.
--
-- 3. LOS ALIAS ERAN EL NOMBRE DE SU ORQUESTA. La fila guardaba "Los Magos del
--    Ritmo" y "Felix del Rosario y Sus Magos del Ritmo". Eso es la agrupacion,
--    no el. TERCER caso del patron esta semana, despues de Los Infantiles del
--    Amargue en El Chaval y de Los Candes en Joan Soriano.
--
--    Aqui NO PUEDO moverlos a la fila del grupo porque LA ORQUESTA NO TIENE
--    FICHA. Salen de aliases, se nombra el grupo en la prosa y va a la lista de
--    ausencias. Entra "El Mago del Ritmo", que si es apodo suyo y personal.
-- ---------------------------------------------------------------------------
--
-- EL DATO TECNICO QUE FALTABA Y QUE ES LA RAZON DE SU IMPORTANCIA:
--
--   CAMBIO LA CONFORMACION DE LOS METALES DEL MERENGUE. La formacion clasica de
--   la epoca era DOS SAXOS, DOS TROMPETAS Y UN TROMBON. El la redujo a SOLO DOS
--   SAXOS, alternando alto, baritono, tenor y flauta.
--
-- Eso es lo que la ficha vieja intentaba decir con "a combination of musical
-- discipline and showmanship". No es una cuestion de estilo: es una decision de
-- orquestacion que cambio como suena el genero.
--
-- LO DEMAS QUE FALTABA:
--
--   EMPEZO A LOS QUINCE en la escuela municipal de musica de San Francisco de
--   Macoris. Emigro a Santo Domingo -- entonces Ciudad Trujillo -- y ENTRO EN LA
--   BANDA DE LA MARINA DE GUERRA, donde llego a oficial.
--
--   EN 1953 entro en la orquesta de ANTONIO MOREL, y despues trabajo con AMADO
--   VASQUEZ, AGUSTIN MERCIER y RAFAEL SOLANO.
--
--   EN 1964 FORMO "FELIX DEL ROSARIO Y SUS MAGOS DEL RITMO", que duro mas de
--   veinte anos. Por ella pasaron ANTONIO PENA, PAPITO BAZAN, QUICO MARCANO y
--   MANUEL PERDOMO, y cantaron FRANK CRUZ y "EL NEGRITO MACABI".
--
--   Mas tarde formo la SANTO DOMINGO ALL STAR y el GRUPO FELIX.
--
--   SUS MERENGUES: "PAPA BOCO", que compuso MANUEL SANCHEZ ACOSTA -- los dos
--   estan en el catalogo --, "Victor y Memelo", "Mal Pelao", "La Caperucita" y
--   "El Secuestro". Y "CARMEN", una guaracha cruzada con jazz latino.
--
--   LA NAVIDAD ES UNA PARTE ENORME DE SU CATALOGO y no estaba dicho: seis
--   discos navidenos entre 1968 y 1994 -- "Parrandas Navidenas en Ritmo de
--   Merengue", dos volumenes de "Exitos Navidenos", "El Tren de la Navidad",
--   "Felix Navidad" y "Navidad Criolla" --. Es un cuerpo de obra, no un
--   villancico suelto.
--
-- TRES RECONOCIMIENTOS, ninguno registrado: HIJO MERITORIO de su ciudad natal
-- en 1973, un CASANDRA ESPECIAL y la ORDEN DEL MERITO DE DUARTE, SANCHEZ Y
-- MELLA en 1995. Van en migracion aparte; las tres categorias ya existen.
--
-- MURIO EL 26 DE OCTUBRE DE 2012 en Santo Domingo, a los 78. LA CAUSA NO ENTRA:
-- las fuentes la dan y la regla la excluye.
--
-- occupations SE AFINA: sale 'musician', que es vago para un saxofonista, y
-- entra 'saxophonist'. instruments se llena con saxofon y flauta, que son los
-- que la fuente le atribuye.
--
-- `genres` YA TENIA 'jazz' Y ESTA BIEN. Se queda.
--
-- TRES ENLACES. Pocos, y es por una razon concreta: de los nueve musicos y
-- directores que las fuentes nombran a su alrededor, SIETE NO TIENEN FICHA.
--
-- FUENTES: Wikipedia en espanol, con discografia completa. EcuRed. El Dia, 27 de
-- octubre de 2012, obituario. El Ministerio de Cultura. El Nacional.
--
-- AUSENCIAS NUEVAS, y son muchas: SUS MAGOS DEL RITMO (la orquesta), SANTO
-- DOMINGO ALL STAR, GRUPO FELIX, ANTONIO MOREL, AMADO VASQUEZ, AGUSTIN MERCIER,
-- ANTONIO PENA, PAPITO BAZAN, QUICO MARCANO, MANUEL PERDOMO y "EL NEGRITO
-- MACABI".
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
       name = 'Félix del Rosario',
       sort_name = 'del Rosario, Félix',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'instrumentalist',
       primary_genre = 'merengue',
       date_of_birth = '1934-07-12',
       birth_year = 1934,
       date_of_death = '2012-10-26',
       birth_place = 'San Francisco de Macorís',
       province = 'Duarte',
       first_name = 'Félix',
       middle_name = NULL,
       last_name = 'del Rosario',
       second_last_name = NULL,
       stage_name = 'Félix del Rosario',
       aliases = ARRAY['El Mago del Ritmo']::text[],
       occupations = '["saxophonist","arranger","bandleader","composer"]'::jsonb,
       instruments = ARRAY['saxophone', 'flute']::text[],
       genres = ARRAY['jazz']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Saxophonist and bandleader of Los Magos del Ritmo; rewrote the horn section of merengue',
       bio_en = 'Félix del Rosario was a Dominican saxophonist, composer and bandleader. He led Félix del Rosario y Sus Magos del Ritmo for more than twenty years, and he changed the way merengue bands were scored: he cut the horn section down to two saxophones and brought Afro-Cuban jazz into a music that had not been written that way before. He died in Santo Domingo on 26 October 2012, at seventy-eight.

**The navy band**

He was born on 12 July 1934 in San Francisco de Macorís and began studying at fifteen at the municipal music school there. Still young, he moved to the capital — Ciudad Trujillo at the time — and joined the band of the Navy, where he rose to the rank of officer. Jazz took hold of him during those years.

In 1953 he joined the orchestra of Antonio Morel, and afterwards worked with Amado Vásquez, Agustín Mercier and Rafael Solano.

**Two saxophones**

The standard Dominican dance band of the period carried two saxophones, two trumpets and a trombone. Del Rosario reduced that to two saxophones and nothing else, alternating alto, baritone and tenor and adding flute, which gave his records a lighter and more mobile front line than the orchestras around him.

What he put in the space he had cleared was jazz. His playing draws on bossa nova and on Afro-Cuban jazz, and he wrote for himself as an improvising soloist rather than as a section leader. Carmen, a guaracha crossed with Latin jazz, is the clearest case.

**Los Magos del Ritmo**

He formed Félix del Rosario y Sus Magos del Ritmo in 1964, and it stayed in the front rank of Dominican popular music for more than two decades. Antonio Peña, Papito Bazán, Quico Marcano and Manuel Perdomo played in it, and Frank Cruz and El Negrito Macabí sang. He later put together the Santo Domingo All Star and the Grupo Félix.

The merengues that stayed in the repertoire are Papá Bocó, written for him by Manuel Sánchez Acosta, along with Víctor y Memelo, Mal Pelao, La Caperucita and El Secuestro.

**Christmas**

A large part of his catalogue is Christmas music, which is unusual in the size of the commitment: between 1968 and 1994 he released six albums of it — Parrandas Navideñas en Ritmo de Merengue, two volumes of Éxitos Navideños, El Tren de la Navidad, Félix Navidad and Navidad Criolla — all of it Christmas repertoire arranged as merengue.

**Distinctions**

San Francisco de Macorís named him a meritorious son of the city in 1973. He received a special Casandra award, and in 1995 the Dominican government gave him the Order of Merit of Duarte, Sánchez and Mella.',
       bio_es = 'Félix del Rosario fue un saxofonista, compositor y director de orquesta dominicano. Dirigió Félix del Rosario y Sus Magos del Ritmo durante más de veinte años, y cambió la manera de escribir para las orquestas de merengue: redujo la sección de metales a dos saxofones y metió el jazz afrocubano en una música que no se había escrito así. Murió en Santo Domingo el 26 de octubre de 2012, a los setenta y ocho.

**La banda de la Marina**

Nació el 12 de julio de 1934 en San Francisco de Macorís y empezó a estudiar a los quince en la escuela municipal de música de la ciudad. Todavía joven se fue a la capital —entonces Ciudad Trujillo— y entró en la Banda de la Marina de Guerra, donde llegó a oficial. El jazz se le metió dentro en esos años.

En 1953 entró en la orquesta de Antonio Morel, y después trabajó con Amado Vásquez, Agustín Mercier y Rafael Solano.

**Dos saxofones**

La orquesta bailable dominicana de la época llevaba dos saxofones, dos trompetas y un trombón. Del Rosario lo redujo a dos saxofones y nada más, alternando alto, barítono y tenor y añadiendo flauta, lo que le dio a sus discos un frente más liviano y más móvil que el de las orquestas de alrededor.

Lo que puso en el sitio que había despejado fue jazz. Su manera de tocar viene de la bossa nova y del jazz afrocubano, y escribía para sí mismo como solista improvisador y no como jefe de sección. Carmen, una guaracha cruzada con jazz latino, es el caso más claro.

**Los Magos del Ritmo**

Formó Félix del Rosario y Sus Magos del Ritmo en 1964, y la orquesta se mantuvo en primera línea de la música popular dominicana más de dos décadas. Tocaron en ella Antonio Peña, Papito Bazán, Quico Marcano y Manuel Perdomo, y cantaron Frank Cruz y El Negrito Macabí. Más adelante armó la Santo Domingo All Star y el Grupo Félix.

Los merengues que quedaron en el repertorio son Papá Bocó, que le escribió Manuel Sánchez Acosta, junto a Víctor y Memelo, Mal Pelao, La Caperucita y El Secuestro.

**La Navidad**

Una parte grande de su catálogo es música de Navidad, y llama la atención por el tamaño de la apuesta: entre 1968 y 1994 publicó seis discos —Parrandas Navideñas en Ritmo de Merengue, dos volúmenes de Éxitos Navideños, El Tren de la Navidad, Félix Navidad y Navidad Criolla—, todos ellos repertorio navideño arreglado como merengue.

**Distinciones**

San Francisco de Macorís lo declaró hijo meritorio de la ciudad en 1973. Recibió un Casandra especial y, en 1995, el Gobierno dominicano le concedió la Orden del Mérito de Duarte, Sánchez y Mella.',
       updated_at = now()
 WHERE slug = 'felix-del-rosario';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-del-rosario')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-del-rosario')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Félix del Rosario was a Dominican saxophonist, composer and bandleader. He led Félix del Rosario y Sus Magos del Ritmo for more than twenty years, and he changed the way merengue bands were scored: he cut the horn section down to two saxophones and brought Afro-Cuban jazz into a music that had not been written that way before. He died in Santo Domingo on 26 October 2012, at seventy-eight.","type":"text"}]},{"type":"paragraph","content":[{"text":"The navy band","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born on 12 July 1934 in San Francisco de Macorís and began studying at fifteen at the municipal music school there. Still young, he moved to the capital — Ciudad Trujillo at the time — and joined the band of the Navy, where he rose to the rank of officer. Jazz took hold of him during those years.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 1953 he joined the orchestra of Antonio Morel, and afterwards worked with Amado Vásquez, Agustín Mercier and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"149d6fb3-e83c-42b0-8fd0-a17675fbbdc9"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Two saxophones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The standard Dominican dance band of the period carried two saxophones, two trumpets and a trombone. Del Rosario reduced that to two saxophones and nothing else, alternating alto, baritone and tenor and adding flute, which gave his records a lighter and more mobile front line than the orchestras around him.","type":"text"}]},{"type":"paragraph","content":[{"text":"What he put in the space he had cleared was jazz. His playing draws on bossa nova and on Afro-Cuban jazz, and he wrote for himself as an improvising soloist rather than as a section leader. Carmen, a guaracha crossed with Latin jazz, is the clearest case.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Magos del Ritmo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He formed Félix del Rosario y Sus Magos del Ritmo in 1964, and it stayed in the front rank of Dominican popular music for more than two decades. Antonio Peña, Papito Bazán, Quico Marcano and Manuel Perdomo played in it, and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cb00350-16da-41b4-bec9-5c86b5d8438c","displayText":"Frank Cruz","occurrenceId":"8b024296-32e7-4310-8859-a091434f2e00"}},{"text":" and El Negrito Macabí sang. He later put together the Santo Domingo All Star and the Grupo Félix.","type":"text"}]},{"type":"paragraph","content":[{"text":"The merengues that stayed in the repertoire are Papá Bocó, written for him by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9f62f1e7-2aad-4690-8451-82df4dd3b587","displayText":"Manuel Sánchez Acosta","occurrenceId":"3632cf83-9fc7-4ae9-b542-5a35c946e868"}},{"text":", along with Víctor y Memelo, Mal Pelao, La Caperucita and El Secuestro.","type":"text"}]},{"type":"paragraph","content":[{"text":"Christmas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A large part of his catalogue is Christmas music, which is unusual in the size of the commitment: between 1968 and 1994 he released six albums of it — Parrandas Navideñas en Ritmo de Merengue, two volumes of Éxitos Navideños, El Tren de la Navidad, Félix Navidad and Navidad Criolla — all of it Christmas repertoire arranged as merengue.","type":"text"}]},{"type":"paragraph","content":[{"text":"Distinctions","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"San Francisco de Macorís named him a meritorious son of the city in 1973. He received a special Casandra award, and in 1995 the Dominican government gave him the Order of Merit of Duarte, Sánchez and Mella.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'felix-del-rosario'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Félix del Rosario fue un saxofonista, compositor y director de orquesta dominicano. Dirigió Félix del Rosario y Sus Magos del Ritmo durante más de veinte años, y cambió la manera de escribir para las orquestas de merengue: redujo la sección de metales a dos saxofones y metió el jazz afrocubano en una música que no se había escrito así. Murió en Santo Domingo el 26 de octubre de 2012, a los setenta y ocho.","type":"text"}]},{"type":"paragraph","content":[{"text":"La banda de la Marina","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació el 12 de julio de 1934 en San Francisco de Macorís y empezó a estudiar a los quince en la escuela municipal de música de la ciudad. Todavía joven se fue a la capital —entonces Ciudad Trujillo— y entró en la Banda de la Marina de Guerra, donde llegó a oficial. El jazz se le metió dentro en esos años.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 1953 entró en la orquesta de Antonio Morel, y después trabajó con Amado Vásquez, Agustín Mercier y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"9cd8244e-7e8d-43f7-b50d-da788aa65ff5"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Dos saxofones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La orquesta bailable dominicana de la época llevaba dos saxofones, dos trompetas y un trombón. Del Rosario lo redujo a dos saxofones y nada más, alternando alto, barítono y tenor y añadiendo flauta, lo que le dio a sus discos un frente más liviano y más móvil que el de las orquestas de alrededor.","type":"text"}]},{"type":"paragraph","content":[{"text":"Lo que puso en el sitio que había despejado fue jazz. Su manera de tocar viene de la bossa nova y del jazz afrocubano, y escribía para sí mismo como solista improvisador y no como jefe de sección. Carmen, una guaracha cruzada con jazz latino, es el caso más claro.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Magos del Ritmo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Formó Félix del Rosario y Sus Magos del Ritmo en 1964, y la orquesta se mantuvo en primera línea de la música popular dominicana más de dos décadas. Tocaron en ella Antonio Peña, Papito Bazán, Quico Marcano y Manuel Perdomo, y cantaron ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cb00350-16da-41b4-bec9-5c86b5d8438c","displayText":"Frank Cruz","occurrenceId":"7d3ca4c3-3735-4622-8b8b-12bec0435bbe"}},{"text":" y El Negrito Macabí. Más adelante armó la Santo Domingo All Star y el Grupo Félix.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los merengues que quedaron en el repertorio son Papá Bocó, que le escribió ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9f62f1e7-2aad-4690-8451-82df4dd3b587","displayText":"Manuel Sánchez Acosta","occurrenceId":"f4624907-ef74-4a40-b50d-0c6834ef579a"}},{"text":", junto a Víctor y Memelo, Mal Pelao, La Caperucita y El Secuestro.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Navidad","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Una parte grande de su catálogo es música de Navidad, y llama la atención por el tamaño de la apuesta: entre 1968 y 1994 publicó seis discos —Parrandas Navideñas en Ritmo de Merengue, dos volúmenes de Éxitos Navideños, El Tren de la Navidad, Félix Navidad y Navidad Criolla—, todos ellos repertorio navideño arreglado como merengue.","type":"text"}]},{"type":"paragraph","content":[{"text":"Distinciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"San Francisco de Macorís lo declaró hijo meritorio de la ciudad en 1973. Recibió un Casandra especial y, en 1995, el Gobierno dominicano le concedió la Orden del Mérito de Duarte, Sánchez y Mella.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'felix-del-rosario'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-del-rosario') AND locale = 'en'), '149d6fb3-e83c-42b0-8fd0-a17675fbbdc9', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-del-rosario') AND locale = 'en'), '3632cf83-9fc7-4ae9-b542-5a35c946e868', 'artist', '9f62f1e7-2aad-4690-8451-82df4dd3b587');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-del-rosario') AND locale = 'en'), '8b024296-32e7-4310-8859-a091434f2e00', 'artist', '2cb00350-16da-41b4-bec9-5c86b5d8438c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-del-rosario') AND locale = 'es'), '7d3ca4c3-3735-4622-8b8b-12bec0435bbe', 'artist', '2cb00350-16da-41b4-bec9-5c86b5d8438c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-del-rosario') AND locale = 'es'), '9cd8244e-7e8d-43f7-b50d-da788aa65ff5', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-del-rosario') AND locale = 'es'), 'f4624907-ef74-4a40-b50d-0c6834ef579a', 'artist', '9f62f1e7-2aad-4690-8451-82df4dd3b587');

COMMIT;
