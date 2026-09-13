BEGIN;

-- Rewrite the catalogue entry for Jorge Taveras.
--
-- Jorge Taveras. NOVENA de las 211, con 14 enlaces entrantes. 747 CARACTERES,
-- la segunda ficha más corta del lote después de la plantilla de Pochy.
--
-- Y era relleno del principio al final: "contributed to the rich tapestry of
-- Dominican sound", "endeared him to audiences at home and in the Dominican
-- diaspora", "a committed artist whose voice had been part of the soundtrack of
-- Dominican life for generations".
--
-- ESA ÚLTIMA FRASE ADEMÁS LO EQUIVOCA DE OFICIO. Habla de SU VOZ. Jorge Taveras
-- no era cantante: era PIANISTA, ARREGLISTA, PRODUCTOR Y DIRECTOR DE ORQUESTA.
-- La propia fila lo dice -- primary_role 'instrumentalist', occupations con
-- arranger, conductor y composer -- y el texto publicado la contradecía. Es el
-- tipo de error que delata que el molde se escribió sin mirar la fila.
--
-- LO QUE ERA, Y NO APARECÍA POR NINGÚN LADO:
--
--   ESTUVO DETRÁS DE MEDIA MÚSICA DOMINICANA. Trabajó en producciones para
--   Johnny Ventura, Wilfrido Vargas, Omar Franco, Olga Lara, Tati Salas, la
--   Coco Band, Sonia Silvestre, José Antonio Rodríguez, Víctor Víctor, Miriam
--   Cruz y Milly Quezada. ONCE de esos artistas están publicados en este
--   catálogo y ninguno estaba enlazado.
--
--   DIRIGIÓ LAS ORQUESTAS DE PLANTA DE LA TELEVISIÓN DOMINICANA: "Nosotros a
--   las 8" desde 1973, y después El Show del Mediodía, De Noche y Punto Final.
--   Fue además productor del programa dominical Fantástico.
--
--   ONCE AÑOS AL FRENTE DE LOS CABALLEROS MONTECARLO en Santiago, adonde lo
--   llamaron los ejecutivos de La Tabacalera en 1967.
--
--   LOS FESTIVALES OTI de México, Brasil y Puerto Rico como director,
--   arreglista y compositor, y el Festival de Onda Nueva de Aldemaro Romero en
--   Venezuela.
--
-- EL DETALLE HUMANO QUE VALE LA FICHA: intentó seis carreras universitarias y no
-- terminó ninguna. Ingeniería Civil en la Madre y Maestra, Administración en la
-- UASD -- que abandonó cuando estalló la Revolución de Abril de 1965 y se
-- paralizó el país --, Río Piedras y la Universidad Mundial en Puerto Rico. Él
-- mismo lo resumió: estuvo en seis universidades tratando de hacerse de una
-- carrera, pero la música lo halaba. Se parafrasea, no se cita entero.
--
-- EL NOMBRE LEGAL ESTABA A MEDIAS: se llamaba JORGE EDMUNDO TAVERAS ANDÚJAR.
-- Faltaban middle_name y second_last_name. Y nació en CIUDAD NUEVA, no
-- genéricamente en Santo Domingo.
--
-- instruments estaba VACÍO para un pianista. Tocaba además guitarra, que
-- aprendió al volver de Puerto Rico.
--
-- LA CAUSA DE MUERTE NO ENTRA. La fuente detalla una enfermedad cerebral
-- agravada por COVID y la unidad de cuidados intensivos. Es historia clínica. Sí
-- entra que murió el 3 de diciembre de 2021 en Orlando, a los 76 años.
--
-- TAMPOCO ENTRAN sus dos matrimonios ni sus nueve hijos, que la fuente nombra
-- uno por uno.
--
-- ONCE ENLACES, TODOS POR CRÉDITO DE PRODUCCIÓN DOCUMENTADO, más
-- rafael-solano: El Show del Mediodía, cuya orquesta de planta dirigió Taveras,
-- es el programa que creó Solano. Los dos hechos vienen de fuentes distintas y
-- se cruzan en el mismo estudio.
--
-- SOBRE LA COCO BAND: la fuente escribe "La Coco Band" y el enlace va a
-- pochy-y-su-cocoband, que es la fila que el catálogo tiene para esa orquesta.
--
-- FUENTE PRINCIPAL: Diario Libre, 3 de diciembre de 2021, que reproduce la
-- biografía escrita por el periodista FAUSTO POLANCO para su libro "Célebres
-- Músicos Dominicanos", auspiciado por Sodaie. Es el mismo Fausto Polanco cuya
-- biografía de Aramis Camilo usé esta mañana: conviene tenerlo fichado como
-- fuente recurrente y fiable para músicos dominicanos sin Wikipedia.
--
-- NOMBRES NUEVOS PARA LA LISTA: TATI SALAS, artista para quien produjo; MILTON
-- PELÁEZ, líder del grupo de rock al que entró en 1958; y LOS CABALLEROS
-- MONTECARLO, la orquesta de Santiago que dirigió once años.
-- EL GATE BANNED ME PARO Y TENIA RAZON. Habia escrito "the list of records he
-- worked on is the argument for THIS ENTRY". Eso es hablarle al lector sobre la
-- ficha en vez de contarle al musico, que es justo lo que esa lista de frases
-- prohibidas existe para atrapar. Reescrito sin mencionar la ficha.
-- REVISION POSTERIOR EL MISMO DIA: TATY SALAS YA EXISTE. Cuando escribi esta
-- ficha, ella era una de las ausencias que anote; el editor pidio crearla y la
-- cree. Ahora aparece nombrada y enlazada en la lista de artistas para los que
-- Taveras produjo, en vez de quedar escondida bajo "entre otros". Misma regla
-- que apliqué con Aramis Camilo: cuando una ausencia se llena, se reescriben las
-- fichas que la nombraban.
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
       name = 'Jorge Taveras',
       sort_name = 'Taveras Andújar, Jorge Edmundo',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'instrumentalist',
       primary_genre = 'merengue',
       date_of_birth = '1945-04-23',
       birth_year = 1945,
       date_of_death = '2021-12-03',
       birth_place = 'Ciudad Nueva, Santo Domingo',
       province = 'Distrito Nacional',
       first_name = 'Jorge',
       middle_name = 'Edmundo',
       last_name = 'Taveras',
       second_last_name = 'Andújar',
       stage_name = 'Jorge Taveras',
       aliases = NULL,
       occupations = '["arranger","conductor","composer","pianist","producer"]'::jsonb,
       instruments = ARRAY['piano', 'guitar']::text[],
       genres = ARRAY['ballads']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Pianist, arranger and conductor; led the house orchestras of Dominican television and produced for a generation',
       bio_en = 'Jorge Edmundo Taveras Andújar was a Dominican pianist, arranger, producer and conductor. He worked behind other people’s records and in front of television house orchestras rather than under his own name, which is why his catalogue is a list of other artists — and a long one.

**Ciudad Nueva**

He was born in Ciudad Nueva, Santo Domingo, in 1945, and began studying piano at the start of the fifties at the city’s elementary music school. In 1958 he joined a rock group led by Milton Peláez, and later entered the National Conservatory, where the company was serious instrumentalists.

In 1962 he took a job as pianist in the orchestra at the Hotel Europa, which was his first professional work and the room where he learned the trade. He also kept trying to become something else: he enrolled in civil engineering at the Madre y Maestra, then business administration at the Autonomous University, which he left when the April revolution of 1965 shut the country down, and then two more universities in Puerto Rico. He said afterwards that he had been through six of them trying to get a degree, and that the music kept pulling him back.

While in Puerto Rico he enrolled at its conservatory instead, and came home at the end of 1966. He learned guitar, started going to the recording studios, and stopped trying to be anything other than a musician.

**Los Caballeros Montecarlo**

In 1967 the executives of the tobacco company called him to Santiago to direct their band, Los Caballeros Montecarlo. He stayed eleven years, which is longer than most Dominican musicians of his generation stayed anywhere.

**The house orchestras**

In 1973 he joined the television programme Nosotros a las 8 as director of its house orchestra, and began producing advertising jingles alongside it. He went on to direct the house orchestras of De Noche, Punto Final and El Show del Mediodía — the programme Rafael Solano had built — and produced the Sunday show Fantástico.

He was also the man promoters called when an international artist came to play the country and needed a band that could read anything on short notice.

**The productions**

The records he worked on are where the career lives. He produced or arranged for Johnny Ventura, Wilfrido Vargas, Omar Franco, Olga Lara, Pochy y su Cocoband, Sonia Silvestre, José Antonio Rodríguez, Víctor Víctor, Miriam Cruz, Milly Quezada and Taty Salas, among others.

That is merengue, bachata, balada and nueva canción in the same working life, and it is why his name turns up in the credits of records that otherwise have nothing in common.

**The festivals**

He took the same three roles — director, arranger and composer — to the OTI song festivals held in Mexico, Brazil and Puerto Rico, and to the Onda Nueva festival that Aldemaro Romero ran in Venezuela.

He died on 3 December 2021 in Orlando, Florida, at seventy-six.',
       bio_es = 'Jorge Edmundo Taveras Andújar fue un pianista, arreglista, productor y director de orquesta dominicano. Trabajó detrás de los discos ajenos y al frente de las orquestas de planta de la televisión, y no bajo su propio nombre, razón por la cual su catálogo es una lista de otros artistas, y bastante larga.

**Ciudad Nueva**

Nació en Ciudad Nueva, Santo Domingo, en 1945, y empezó a estudiar piano a principios de los cincuenta en la escuela elemental de música de la ciudad. En 1958 entró a un grupo de rock que dirigía Milton Peláez, y más adelante ingresó al Conservatorio Nacional, donde la compañía eran instrumentistas serios.

En 1962 tomó un puesto de pianista en la orquesta del hotel Europa, que fue su primer trabajo profesional y la sala donde aprendió el oficio. Siguió además intentando ser otra cosa: se inscribió en Ingeniería Civil en la Madre y Maestra, después en Administración de Empresas en la Autónoma, que dejó cuando estalló la Revolución de Abril de 1965 y el país se paralizó, y luego en dos universidades más en Puerto Rico. Él mismo contó después que pasó por seis tratando de hacerse de una carrera, y que la música lo halaba de vuelta.

Estando en Puerto Rico se inscribió en cambio en su conservatorio, y regresó al país a finales de 1966. Aprendió guitarra, empezó a frecuentar los estudios de grabación, y dejó de intentar ser otra cosa que músico.

**Los Caballeros Montecarlo**

En 1967 los ejecutivos de la tabacalera lo llamaron a Santiago para dirigir su banda, Los Caballeros Montecarlo. Se quedó once años, que es más de lo que la mayoría de los músicos dominicanos de su generación se quedaba en ningún sitio.

**Las orquestas de planta**

En 1973 entró al programa de televisión Nosotros a las 8 como director de su orquesta de planta, y empezó en paralelo a producir jingles publicitarios. Después dirigió las orquestas de planta de De Noche, Punto Final y El Show del Mediodía —el programa que había armado Rafael Solano— y produjo el dominical Fantástico.

Era además a quien llamaban los empresarios cuando venía un artista internacional a presentarse en el país y hacía falta una banda capaz de leer cualquier cosa con poco aviso.

**Las producciones**

Los discos en los que trabajó son donde vive la carrera. Produjo o arregló para Johnny Ventura, Wilfrido Vargas, Omar Franco, Olga Lara, Pochy y su Cocoband, Sonia Silvestre, José Antonio Rodríguez, Víctor Víctor, Miriam Cruz, Milly Quezada y Taty Salas, entre otros.

Eso es merengue, bachata, balada y nueva canción en una misma vida de trabajo, y es la razón por la que su nombre aparece en los créditos de discos que por lo demás no tienen nada que ver entre sí.

**Los festivales**

Llevó los mismos tres oficios —director, arreglista y compositor— a los festivales OTI de la canción celebrados en México, Brasil y Puerto Rico, y al festival de Onda Nueva que Aldemaro Romero organizaba en Venezuela.

Murió el 3 de diciembre de 2021 en Orlando, Florida, a los setenta y seis años.',
       updated_at = now()
 WHERE slug = 'jorge-taveras';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jorge Edmundo Taveras Andújar was a Dominican pianist, arranger, producer and conductor. He worked behind other people’s records and in front of television house orchestras rather than under his own name, which is why his catalogue is a list of other artists — and a long one.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ciudad Nueva","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Ciudad Nueva, Santo Domingo, in 1945, and began studying piano at the start of the fifties at the city’s elementary music school. In 1958 he joined a rock group led by Milton Peláez, and later entered the National Conservatory, where the company was serious instrumentalists.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 1962 he took a job as pianist in the orchestra at the Hotel Europa, which was his first professional work and the room where he learned the trade. He also kept trying to become something else: he enrolled in civil engineering at the Madre y Maestra, then business administration at the Autonomous University, which he left when the April revolution of 1965 shut the country down, and then two more universities in Puerto Rico. He said afterwards that he had been through six of them trying to get a degree, and that the music kept pulling him back.","type":"text"}]},{"type":"paragraph","content":[{"text":"While in Puerto Rico he enrolled at its conservatory instead, and came home at the end of 1966. He learned guitar, started going to the recording studios, and stopped trying to be anything other than a musician.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Caballeros Montecarlo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1967 the executives of the tobacco company called him to Santiago to direct their band, Los Caballeros Montecarlo. He stayed eleven years, which is longer than most Dominican musicians of his generation stayed anywhere.","type":"text"}]},{"type":"paragraph","content":[{"text":"The house orchestras","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1973 he joined the television programme Nosotros a las 8 as director of its house orchestra, and began producing advertising jingles alongside it. He went on to direct the house orchestras of De Noche, Punto Final and El Show del Mediodía — the programme ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"0ba26b07-b3d2-4c2c-9a1e-b5591ceb5b4f"}},{"text":" had built — and produced the Sunday show Fantástico.","type":"text"}]},{"type":"paragraph","content":[{"text":"He was also the man promoters called when an international artist came to play the country and needed a band that could read anything on short notice.","type":"text"}]},{"type":"paragraph","content":[{"text":"The productions","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The records he worked on are where the career lives. He produced or arranged for ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"a5c1cae5-2c7c-44e2-8a54-2d6fe2983599"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"55936936-bc46-40ea-ba14-e061f8697aa5"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d509de7c-64a1-4290-8e2f-6b066e230ff3","displayText":"Omar Franco","occurrenceId":"34e649b3-f52e-4f92-b970-7a5eea317ad4"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f84b208b-dd57-43ad-b2bf-d5099e2f0e0e","displayText":"Olga Lara","occurrenceId":"41065236-2bea-4e3d-9b5e-f7c4ea206efe"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband","occurrenceId":"69bda842-88c2-4fa3-9d9f-51f83207eb5d"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre","occurrenceId":"9812f101-c7b6-42f0-a23e-8af1cefeb371"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1","displayText":"José Antonio Rodríguez","occurrenceId":"f85e0d3b-b829-46f2-b554-696df77bd302"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor","occurrenceId":"6617fc6d-463c-4103-81d0-f37172c3f58e"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz","occurrenceId":"14de5652-5d70-4a33-8939-fdedc932bedd"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada","occurrenceId":"b1e9c1ba-7cb1-43c1-94a7-8be745be29ed"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7cbac8c5-5bf1-46b6-b66a-b372827a6dc9","displayText":"Taty Salas","occurrenceId":"7476648c-99ae-4be9-8ae2-2c8e7aedcb44"}},{"text":", among others.","type":"text"}]},{"type":"paragraph","content":[{"text":"That is merengue, bachata, balada and nueva canción in the same working life, and it is why his name turns up in the credits of records that otherwise have nothing in common.","type":"text"}]},{"type":"paragraph","content":[{"text":"The festivals","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He took the same three roles — director, arranger and composer — to the OTI song festivals held in Mexico, Brazil and Puerto Rico, and to the Onda Nueva festival that Aldemaro Romero ran in Venezuela.","type":"text"}]},{"type":"paragraph","content":[{"text":"He died on 3 December 2021 in Orlando, Florida, at seventy-six.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jorge-taveras'), 3)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jorge Edmundo Taveras Andújar fue un pianista, arreglista, productor y director de orquesta dominicano. Trabajó detrás de los discos ajenos y al frente de las orquestas de planta de la televisión, y no bajo su propio nombre, razón por la cual su catálogo es una lista de otros artistas, y bastante larga.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ciudad Nueva","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Ciudad Nueva, Santo Domingo, en 1945, y empezó a estudiar piano a principios de los cincuenta en la escuela elemental de música de la ciudad. En 1958 entró a un grupo de rock que dirigía Milton Peláez, y más adelante ingresó al Conservatorio Nacional, donde la compañía eran instrumentistas serios.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 1962 tomó un puesto de pianista en la orquesta del hotel Europa, que fue su primer trabajo profesional y la sala donde aprendió el oficio. Siguió además intentando ser otra cosa: se inscribió en Ingeniería Civil en la Madre y Maestra, después en Administración de Empresas en la Autónoma, que dejó cuando estalló la Revolución de Abril de 1965 y el país se paralizó, y luego en dos universidades más en Puerto Rico. Él mismo contó después que pasó por seis tratando de hacerse de una carrera, y que la música lo halaba de vuelta.","type":"text"}]},{"type":"paragraph","content":[{"text":"Estando en Puerto Rico se inscribió en cambio en su conservatorio, y regresó al país a finales de 1966. Aprendió guitarra, empezó a frecuentar los estudios de grabación, y dejó de intentar ser otra cosa que músico.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Caballeros Montecarlo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1967 los ejecutivos de la tabacalera lo llamaron a Santiago para dirigir su banda, Los Caballeros Montecarlo. Se quedó once años, que es más de lo que la mayoría de los músicos dominicanos de su generación se quedaba en ningún sitio.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las orquestas de planta","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1973 entró al programa de televisión Nosotros a las 8 como director de su orquesta de planta, y empezó en paralelo a producir jingles publicitarios. Después dirigió las orquestas de planta de De Noche, Punto Final y El Show del Mediodía —el programa que había armado ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"9842539a-4354-4be1-8491-f0e92aeb6acb"}},{"text":"— y produjo el dominical Fantástico.","type":"text"}]},{"type":"paragraph","content":[{"text":"Era además a quien llamaban los empresarios cuando venía un artista internacional a presentarse en el país y hacía falta una banda capaz de leer cualquier cosa con poco aviso.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las producciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Los discos en los que trabajó son donde vive la carrera. Produjo o arregló para ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"e991f7ca-dd5d-4c65-97a6-293a7ef4cd9a"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"ad436380-f3db-41f4-bf65-b1c17443608b"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d509de7c-64a1-4290-8e2f-6b066e230ff3","displayText":"Omar Franco","occurrenceId":"bad88937-b160-419e-9986-28ad17ed03c7"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f84b208b-dd57-43ad-b2bf-d5099e2f0e0e","displayText":"Olga Lara","occurrenceId":"74c7728c-3dd0-4b6c-ad9d-791ca2e43739"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband","occurrenceId":"47795353-f09c-4175-b988-b1693a006c56"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre","occurrenceId":"e3233b08-29bc-4e72-bed0-b0541314b7f2"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1","displayText":"José Antonio Rodríguez","occurrenceId":"7d846845-2b73-4174-b5a5-b90332d68f29"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor","occurrenceId":"4e86a6c4-9f66-4dd7-97f1-8751092af617"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz","occurrenceId":"35da0842-9f19-492b-9c0b-69dbb1dafa72"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada","occurrenceId":"1aae33f5-9caa-4867-b4f1-fb5ebd7b822a"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7cbac8c5-5bf1-46b6-b66a-b372827a6dc9","displayText":"Taty Salas","occurrenceId":"3170823d-7afc-4eea-841b-2f6e8a32d478"}},{"text":", entre otros.","type":"text"}]},{"type":"paragraph","content":[{"text":"Eso es merengue, bachata, balada y nueva canción en una misma vida de trabajo, y es la razón por la que su nombre aparece en los créditos de discos que por lo demás no tienen nada que ver entre sí.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los festivales","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Llevó los mismos tres oficios —director, arreglista y compositor— a los festivales OTI de la canción celebrados en México, Brasil y Puerto Rico, y al festival de Onda Nueva que Aldemaro Romero organizaba en Venezuela.","type":"text"}]},{"type":"paragraph","content":[{"text":"Murió el 3 de diciembre de 2021 en Orlando, Florida, a los setenta y seis años.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jorge-taveras'), 2)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '0ba26b07-b3d2-4c2c-9a1e-b5591ceb5b4f', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '14de5652-5d70-4a33-8939-fdedc932bedd', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '34e649b3-f52e-4f92-b970-7a5eea317ad4', 'artist', 'd509de7c-64a1-4290-8e2f-6b066e230ff3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '41065236-2bea-4e3d-9b5e-f7c4ea206efe', 'artist', 'f84b208b-dd57-43ad-b2bf-d5099e2f0e0e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '55936936-bc46-40ea-ba14-e061f8697aa5', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '6617fc6d-463c-4103-81d0-f37172c3f58e', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '69bda842-88c2-4fa3-9d9f-51f83207eb5d', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '7476648c-99ae-4be9-8ae2-2c8e7aedcb44', 'artist', '7cbac8c5-5bf1-46b6-b66a-b372827a6dc9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '9812f101-c7b6-42f0-a23e-8af1cefeb371', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), 'a5c1cae5-2c7c-44e2-8a54-2d6fe2983599', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), 'b1e9c1ba-7cb1-43c1-94a7-8be745be29ed', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), 'f85e0d3b-b829-46f2-b554-696df77bd302', 'artist', '25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '1aae33f5-9caa-4867-b4f1-fb5ebd7b822a', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '3170823d-7afc-4eea-841b-2f6e8a32d478', 'artist', '7cbac8c5-5bf1-46b6-b66a-b372827a6dc9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '35da0842-9f19-492b-9c0b-69dbb1dafa72', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '47795353-f09c-4175-b988-b1693a006c56', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '4e86a6c4-9f66-4dd7-97f1-8751092af617', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '74c7728c-3dd0-4b6c-ad9d-791ca2e43739', 'artist', 'f84b208b-dd57-43ad-b2bf-d5099e2f0e0e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '7d846845-2b73-4174-b5a5-b90332d68f29', 'artist', '25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '9842539a-4354-4be1-8491-f0e92aeb6acb', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), 'ad436380-f3db-41f4-bf65-b1c17443608b', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), 'bad88937-b160-419e-9986-28ad17ed03c7', 'artist', 'd509de7c-64a1-4290-8e2f-6b066e230ff3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), 'e3233b08-29bc-4e72-bed0-b0541314b7f2', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), 'e991f7ca-dd5d-4c65-97a6-293a7ef4cd9a', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

COMMIT;
