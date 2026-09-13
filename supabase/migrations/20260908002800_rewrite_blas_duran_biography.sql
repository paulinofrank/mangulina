BEGIN;

-- Rewrite the catalogue entry for Blas Durán.
--
-- Blas Durán. DECIMOCTAVA de las dieciocho, y la última. La ficha vieja era de
-- las mejores del lote -- nombraba "Consejo a las Mujeres" y hablaba del
-- merengue de guataca -- y aun así SE PERDÍA EL DATO CENTRAL DE SU VIDA.
--
-- LO QUE HIZO: METIÓ LA GUITARRA ELÉCTRICA EN LA BACHATA. En 1985 le añadió al
-- género guitarra eléctrica, percusión, trombón, sintetizador y piano, y en
-- 1986 grabó "Consejo a las Mujeres", que es donde eso se oye. Por ahí se le
-- llama el padre de la bachata moderna.
--
-- LA CONSECUENCIA ES MEDIBLE Y ES LO QUE HAY QUE ESCRIBIR: desde principios de
-- los noventa ningún bachatero comercialmente importante volvió a grabar con
-- requinto acústico. Cambió el sonido del género entero.
--
-- ESTO NO ES AFIRMACIÓN DE FAN, ESTÁ EN LA BIBLIOGRAFÍA ACADÉMICA. Wikipedia en
-- inglés lo sostiene citando a JULIE A. SELLERS en dos libros -- "Bachata and
-- Dominican Identity" (2014) y "The Modern Bachateros: 27 Interviews" (2017) --
-- y este último dice literalmente que Antony Santos y Raulín Rodríguez
-- construyeron sobre la innovación previa de Blas Durán de incorporar la
-- guitarra eléctrica. Eso convierte tres nombres del catálogo en enlaces con
-- fuente.
--
-- LA CENSURA ENTRA, Y ES LA MITAD DE SU HISTORIA. Su música fue criticada y
-- censurada en el país por su carga sexual, y tuvo escasa presencia en la radio
-- dominicana pese a su aceptación popular. Mismo criterio que con Tokischa y
-- "Desacato Escolar": cuando el medio actúa sobre la obra, es historia de la
-- obra. Y hay un matiz que la fuente señala y que conviene conservar: trabajaba
-- con el doble sentido y se cuidaba de no caer en lo abiertamente vulgar.
--
-- aliases traía 'Blas Durán y Sus Peluches' -- SU AGRUPACIÓN COMO ALIAS
-- PERSONAL. DÉCIMO caso de este defecto en la corrida. Sale, y el grupo se
-- nombra en la prosa, que es donde va. Queda para el inventario de separación.
--
-- EL LUGAR SE AFINA: nació en LAS COLMENAS, sección del municipio de Nagua, no
-- en el pueblo de Nagua.
--
-- CONFLICTO DE FECHA DENTRO DE LA MISMA PÁGINA: el cuadro lateral y la entrada
-- dicen 3 DE FEBRERO de 1941 y el cuerpo dice 3 DE SEPTIEMBRE. La fila guarda
-- febrero y Wikipedia en inglés también. Dos contra una: NO SE TOCA. (La
-- categoría de la Wikipedia inglesa dice además "1949 births", que contradice
-- su propio texto; es error de categoría y se ignora.)
--
-- NO REGISTRO EL PARENTESCO CON EDILIO PAREDES, Y ME CUESTA. La fuente dice que
-- en 1962 "visita a su PRIMO Edilio Paredes" y con él conoce los estudios de
-- grabación. Los dos están publicados en el catálogo, así que sería un
-- 'cousin' de manual. PERO el artículo está marcado por Wikipedia como escrito
-- en tono publicitario y necesitado de referencias, y es fuente única para el
-- parentesco. Mismo criterio que apliqué hace un rato con el supuesto primazgo
-- entre Benny Sadel y Rubby Pérez: no se inventan parentescos. SÍ SE ENLAZA a
-- Edilio Paredes por el hecho profesional, que es que fue quien lo metió en los
-- estudios. Queda reportado.
--
-- LO QUE SE DEJA FUERA: que era el menor y único varón de ocho hermanos y los
-- nombres de sus padres. Composición familiar. SÍ ENTRAN los oficios que tuvo
-- antes de cantar -- despachador de combustible y obrero de Obras Públicas --
-- porque son historia laboral y explican de dónde sale.
--
-- CUATRO ENLACES: edilio-paredes (lo introdujo en los estudios en 1962), y
-- luis-vargas, antony-santos y raulin-rodriguez, los tres bachateros que la
-- bibliografía nombra como continuadores de su innovación.
--
-- occupations CONSERVA 'guitarist' Y SE REPORTA. Ninguna de las dos Wikipedias
-- le atribuye la guitarra -- las dos ponen "voz" como instrumento -- pero el
-- campo codifica investigación anterior y no borro trabajo ajeno sin base. Se
-- añade 'producer', que sí está documentado: fue dueño y productor de su propio
-- programa de televisión.
--
-- FUENTES: Wikipedia en inglés, corta pero con bibliografía académica real
-- (Sellers 2014 y 2017, y "Sounds of Resistance" 2013). Wikipedia en español
-- para la cronología de sellos y las canciones, con la reserva de que el
-- artículo está marcado como publicitario y sin referencias suficientes: de ahí
-- se toman los hechos que la otra fuente confirma o que son verificables como
-- discografía, y no las valoraciones.
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
       name = 'Blas Durán',
       sort_name = 'Durán, Blas',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1941-02-03',
       birth_year = 1941,
       date_of_death = '2023-03-28',
       birth_place = 'Las Colmenas, Nagua',
       province = 'María Trinidad Sánchez',
       first_name = 'Blas',
       middle_name = NULL,
       last_name = 'Durán',
       second_last_name = NULL,
       stage_name = 'Blas Durán',
       aliases = ARRAY[]::text[],
       occupations = '["guitarist","songwriter","producer"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Bachatero who put the electric guitar into the genre and changed how every bachata after him sounds',
       bio_en = 'Blas Durán was a Dominican bachata and merengue singer. He is the reason bachata sounds the way it does: he brought the electric guitar into the genre in the middle of the eighties, and within a few years the acoustic requinto had effectively disappeared from commercial bachata records.

**Las Colmenas**

He was born in 1941 in Las Colmenas, a section of the municipality of Nagua on the northeastern coast, and went to school there. He left for the capital at twelve and worked as an attendant at a fuel station and then as a labourer for the public works department while the interest in music kept growing.

**Clavelito**

In 1962 he visited Edilio Paredes, and through him saw the inside of a recording studio for the first time and began writing. His first single, Clavelito, came at the end of the sixties, and he went out selling the records town by town with the producer Bienvenido Rodríguez before the album reached Karen Records and a three-year contract.

A decade of label contracts followed — José Luis Records, Unidad Records, Mañón Records — and a first tour of the United States in 1978. He sang merengue in those years too, with the combo of Aníbal Bravo and with the Típica Dominicana.

**The electric guitar**

In 1985 he set out to change the genre. He added electric guitar, percussion, trombone, synthesiser and piano to a music that had been built on acoustic guitars, signed with Kubaney Records, and cut La Arepa, El Hueso, El Tornillo, El Salón de Belleza and Qué Le Pasa a Nico. The following year came El Motorcito and Consejo a las Mujeres, which is where the change is easiest to hear, and which is a bachata-merengue rather than a bachata.

The effect on the genre was total. From the start of the nineties no commercially significant bachatero was recording with an acoustic requinto any more, and the scholarship on the genre credits Luis Vargas, Antony Santos and Raulín Rodríguez with building the modern sound on top of what he had done. He formed the band Blas Durán y Los Peluches, with his son among its members, and toured Puerto Rico, the United States and later most of western Europe.

**Double meaning**

His records were criticised and censored at home for their sexual content, and he had very little presence on Dominican radio for a performer of his popularity. The work he was doing depended on double meaning rather than on plain vulgarity, and he was careful about the line: the songs run from the comic and the sly to the straightforwardly romantic.

That combination — banned from the radio and sung everywhere else — describes the position bachata itself occupied at the time, dismissed by the country’s cultural authorities and played constantly by everyone else.

**Noticiario Desinformativo**

In 1990 he moved into television as the producer and owner of his own comedy programme, Noticiario Desinformativo, broadcast on what was then Canal 6. It became the opening for a generation of Dominican comedians, among them Raymond Pozo, Miguel Céspedes, Frank Suero and Rafy Pérez.

He kept recording through the nineties for Discomundo Records, with Qué Se Cree Juanita, Dominicano Soy, Llegó Tu Motorista and El Chinero among the titles. He died in Santo Domingo Este on 28 March 2023, at eighty-two.',
       bio_es = 'Blas Durán fue un cantante dominicano de bachata y merengue. Es la razón por la que la bachata suena como suena: le metió la guitarra eléctrica al género a mediados de los ochenta, y en pocos años el requinto acústico había desaparecido de hecho de los discos comerciales de bachata.

**Las Colmenas**

Nació en 1941 en Las Colmenas, sección del municipio de Nagua, en la costa noreste, y allí hizo la escuela. Se fue a la capital a los doce años y trabajó de despachador en una estación de combustible y después de obrero en Obras Públicas, mientras el interés por la música le seguía creciendo.

**Clavelito**

En 1962 visitó a Edilio Paredes, y por él vio por dentro un estudio de grabación por primera vez y se puso a componer. Su primer sencillo, Clavelito, salió a finales de los sesenta, y anduvo vendiendo los discos pueblo por pueblo con el productor Bienvenido Rodríguez antes de que el álbum llegara a Karen Records y a un contrato de tres años.

Detrás vino una década de contratos discográficos — José Luis Records, Unidad Records, Mañón Records — y una primera gira por Estados Unidos en 1978. En esos años cantó también merengue, con el combo de Aníbal Bravo y con la Típica Dominicana.

**La guitarra eléctrica**

En 1985 se propuso cambiar el género. Le añadió guitarra eléctrica, percusión, trombón, sintetizador y piano a una música levantada sobre guitarras acústicas, firmó con Kubaney Records y grabó La Arepa, El Hueso, El Tornillo, El Salón de Belleza y Qué Le Pasa a Nico. Al año siguiente vinieron El Motorcito y Consejo a las Mujeres, que es donde el cambio se oye más claro, y que es una bachata-merengue antes que una bachata.

El efecto sobre el género fue total. Desde principios de los noventa ningún bachatero comercialmente importante volvió a grabar con requinto acústico, y la bibliografía del género acredita a Luis Vargas, Antony Santos y Raulín Rodríguez haber levantado el sonido moderno sobre lo que él hizo. Armó la agrupación Blas Durán y Los Peluches, con su hijo entre los integrantes, y giró por Puerto Rico, Estados Unidos y más tarde buena parte de Europa occidental.

**El doble sentido**

Sus discos fueron criticados y censurados en el país por su carga sexual, y tuvo muy poca presencia en la radio dominicana para lo popular que era. Lo que hacía se sostenía en el doble sentido y no en la vulgaridad abierta, y cuidaba esa raya: las canciones van de lo cómico y lo pícaro a lo abiertamente romántico.

Esa combinación — vetado en la radio y cantado en todas partes — describe la posición que ocupaba entonces la bachata misma, despreciada por las autoridades culturales del país y puesta a sonar sin parar por todo el mundo.

**Noticiario Desinformativo**

En 1990 pasó a la televisión como productor y dueño de su propio programa de humor, Noticiario Desinformativo, que salía por el entonces Canal 6. Fue la puerta de entrada de una generación de comediantes dominicanos, entre ellos Raymond Pozo, Miguel Céspedes, Frank Suero y Rafy Pérez.

Siguió grabando a lo largo de los noventa para Discomundo Records, con Qué Se Cree Juanita, Dominicano Soy, Llegó Tu Motorista y El Chinero entre los títulos. Murió en Santo Domingo Este el 28 de marzo de 2023, a los ochenta y dos años.',
       updated_at = now()
 WHERE slug = 'blas-duran';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'blas-duran')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'blas-duran')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Blas Durán was a Dominican bachata and merengue singer. He is the reason bachata sounds the way it does: he brought the electric guitar into the genre in the middle of the eighties, and within a few years the acoustic requinto had effectively disappeared from commercial bachata records.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las Colmenas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1941 in Las Colmenas, a section of the municipality of Nagua on the northeastern coast, and went to school there. He left for the capital at twelve and worked as an attendant at a fuel station and then as a labourer for the public works department while the interest in music kept growing.","type":"text"}]},{"type":"paragraph","content":[{"text":"Clavelito","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1962 he visited ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cbda65a4-c7da-4762-8cf8-f29b942d2ac3","displayText":"Edilio Paredes","occurrenceId":"83e29083-0207-48ed-ab19-97d58039e360"}},{"text":", and through him saw the inside of a recording studio for the first time and began writing. His first single, Clavelito, came at the end of the sixties, and he went out selling the records town by town with the producer Bienvenido Rodríguez before the album reached Karen Records and a three-year contract.","type":"text"}]},{"type":"paragraph","content":[{"text":"A decade of label contracts followed — José Luis Records, Unidad Records, Mañón Records — and a first tour of the United States in 1978. He sang merengue in those years too, with the combo of Aníbal Bravo and with the Típica Dominicana.","type":"text"}]},{"type":"paragraph","content":[{"text":"The electric guitar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1985 he set out to change the genre. He added electric guitar, percussion, trombone, synthesiser and piano to a music that had been built on acoustic guitars, signed with Kubaney Records, and cut La Arepa, El Hueso, El Tornillo, El Salón de Belleza and Qué Le Pasa a Nico. The following year came El Motorcito and Consejo a las Mujeres, which is where the change is easiest to hear, and which is a bachata-merengue rather than a bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"The effect on the genre was total. From the start of the nineties no commercially significant bachatero was recording with an acoustic requinto any more, and the scholarship on the genre credits ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas","occurrenceId":"f63f1f15-7b10-4a03-9cfe-147a0e510990"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos","occurrenceId":"0d662860-d06e-474f-88f8-15b9b992a7d8"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"4d9abc55-7d2d-4c40-96eb-3b6cdd2de326"}},{"text":" with building the modern sound on top of what he had done. He formed the band Blas Durán y Los Peluches, with his son among its members, and toured Puerto Rico, the United States and later most of western Europe.","type":"text"}]},{"type":"paragraph","content":[{"text":"Double meaning","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His records were criticised and censored at home for their sexual content, and he had very little presence on Dominican radio for a performer of his popularity. The work he was doing depended on double meaning rather than on plain vulgarity, and he was careful about the line: the songs run from the comic and the sly to the straightforwardly romantic.","type":"text"}]},{"type":"paragraph","content":[{"text":"That combination — banned from the radio and sung everywhere else — describes the position bachata itself occupied at the time, dismissed by the country’s cultural authorities and played constantly by everyone else.","type":"text"}]},{"type":"paragraph","content":[{"text":"Noticiario Desinformativo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1990 he moved into television as the producer and owner of his own comedy programme, Noticiario Desinformativo, broadcast on what was then Canal 6. It became the opening for a generation of Dominican comedians, among them Raymond Pozo, Miguel Céspedes, Frank Suero and Rafy Pérez.","type":"text"}]},{"type":"paragraph","content":[{"text":"He kept recording through the nineties for Discomundo Records, with Qué Se Cree Juanita, Dominicano Soy, Llegó Tu Motorista and El Chinero among the titles. He died in Santo Domingo Este on 28 March 2023, at eighty-two.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'blas-duran'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Blas Durán fue un cantante dominicano de bachata y merengue. Es la razón por la que la bachata suena como suena: le metió la guitarra eléctrica al género a mediados de los ochenta, y en pocos años el requinto acústico había desaparecido de hecho de los discos comerciales de bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las Colmenas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1941 en Las Colmenas, sección del municipio de Nagua, en la costa noreste, y allí hizo la escuela. Se fue a la capital a los doce años y trabajó de despachador en una estación de combustible y después de obrero en Obras Públicas, mientras el interés por la música le seguía creciendo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Clavelito","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1962 visitó a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cbda65a4-c7da-4762-8cf8-f29b942d2ac3","displayText":"Edilio Paredes","occurrenceId":"636a8043-71dc-4f3d-b50f-00348e23883f"}},{"text":", y por él vio por dentro un estudio de grabación por primera vez y se puso a componer. Su primer sencillo, Clavelito, salió a finales de los sesenta, y anduvo vendiendo los discos pueblo por pueblo con el productor Bienvenido Rodríguez antes de que el álbum llegara a Karen Records y a un contrato de tres años.","type":"text"}]},{"type":"paragraph","content":[{"text":"Detrás vino una década de contratos discográficos — José Luis Records, Unidad Records, Mañón Records — y una primera gira por Estados Unidos en 1978. En esos años cantó también merengue, con el combo de Aníbal Bravo y con la Típica Dominicana.","type":"text"}]},{"type":"paragraph","content":[{"text":"La guitarra eléctrica","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1985 se propuso cambiar el género. Le añadió guitarra eléctrica, percusión, trombón, sintetizador y piano a una música levantada sobre guitarras acústicas, firmó con Kubaney Records y grabó La Arepa, El Hueso, El Tornillo, El Salón de Belleza y Qué Le Pasa a Nico. Al año siguiente vinieron El Motorcito y Consejo a las Mujeres, que es donde el cambio se oye más claro, y que es una bachata-merengue antes que una bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"El efecto sobre el género fue total. Desde principios de los noventa ningún bachatero comercialmente importante volvió a grabar con requinto acústico, y la bibliografía del género acredita a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas","occurrenceId":"802dc731-334c-40fe-9963-cf8d795fa990"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos","occurrenceId":"396b1adf-7a96-4492-bfb7-fdee543b0258"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"58a77ea2-56c1-49b1-acd0-bc8f8b386f9e"}},{"text":" haber levantado el sonido moderno sobre lo que él hizo. Armó la agrupación Blas Durán y Los Peluches, con su hijo entre los integrantes, y giró por Puerto Rico, Estados Unidos y más tarde buena parte de Europa occidental.","type":"text"}]},{"type":"paragraph","content":[{"text":"El doble sentido","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Sus discos fueron criticados y censurados en el país por su carga sexual, y tuvo muy poca presencia en la radio dominicana para lo popular que era. Lo que hacía se sostenía en el doble sentido y no en la vulgaridad abierta, y cuidaba esa raya: las canciones van de lo cómico y lo pícaro a lo abiertamente romántico.","type":"text"}]},{"type":"paragraph","content":[{"text":"Esa combinación — vetado en la radio y cantado en todas partes — describe la posición que ocupaba entonces la bachata misma, despreciada por las autoridades culturales del país y puesta a sonar sin parar por todo el mundo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Noticiario Desinformativo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1990 pasó a la televisión como productor y dueño de su propio programa de humor, Noticiario Desinformativo, que salía por el entonces Canal 6. Fue la puerta de entrada de una generación de comediantes dominicanos, entre ellos Raymond Pozo, Miguel Céspedes, Frank Suero y Rafy Pérez.","type":"text"}]},{"type":"paragraph","content":[{"text":"Siguió grabando a lo largo de los noventa para Discomundo Records, con Qué Se Cree Juanita, Dominicano Soy, Llegó Tu Motorista y El Chinero entre los títulos. Murió en Santo Domingo Este el 28 de marzo de 2023, a los ochenta y dos años.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'blas-duran'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'blas-duran') AND locale = 'en'), '0d662860-d06e-474f-88f8-15b9b992a7d8', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'blas-duran') AND locale = 'en'), '4d9abc55-7d2d-4c40-96eb-3b6cdd2de326', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'blas-duran') AND locale = 'en'), '83e29083-0207-48ed-ab19-97d58039e360', 'artist', 'cbda65a4-c7da-4762-8cf8-f29b942d2ac3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'blas-duran') AND locale = 'en'), 'f63f1f15-7b10-4a03-9cfe-147a0e510990', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'blas-duran') AND locale = 'es'), '396b1adf-7a96-4492-bfb7-fdee543b0258', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'blas-duran') AND locale = 'es'), '58a77ea2-56c1-49b1-acd0-bc8f8b386f9e', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'blas-duran') AND locale = 'es'), '636a8043-71dc-4f3d-b50f-00348e23883f', 'artist', 'cbda65a4-c7da-4762-8cf8-f29b942d2ac3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'blas-duran') AND locale = 'es'), '802dc731-334c-40fe-9963-cf8d795fa990', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa');

COMMIT;
