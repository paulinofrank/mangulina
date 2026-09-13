BEGIN;

-- Reverts 20260908005600_rewrite_jorge_taveras_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

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

The records he worked on are where the career lives. He produced or arranged for Johnny Ventura, Wilfrido Vargas, Omar Franco, Olga Lara, Pochy y su Cocoband, Sonia Silvestre, José Antonio Rodríguez, Víctor Víctor, Miriam Cruz and Milly Quezada, among others.

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

Los discos en los que trabajó son donde vive la carrera. Produjo o arregló para Johnny Ventura, Wilfrido Vargas, Omar Franco, Olga Lara, Pochy y su Cocoband, Sonia Silvestre, José Antonio Rodríguez, Víctor Víctor, Miriam Cruz y Milly Quezada, entre otros.

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
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jorge Edmundo Taveras Andújar was a Dominican pianist, arranger, producer and conductor. He worked behind other people’s records and in front of television house orchestras rather than under his own name, which is why his catalogue is a list of other artists — and a long one.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ciudad Nueva","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Ciudad Nueva, Santo Domingo, in 1945, and began studying piano at the start of the fifties at the city’s elementary music school. In 1958 he joined a rock group led by Milton Peláez, and later entered the National Conservatory, where the company was serious instrumentalists.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 1962 he took a job as pianist in the orchestra at the Hotel Europa, which was his first professional work and the room where he learned the trade. He also kept trying to become something else: he enrolled in civil engineering at the Madre y Maestra, then business administration at the Autonomous University, which he left when the April revolution of 1965 shut the country down, and then two more universities in Puerto Rico. He said afterwards that he had been through six of them trying to get a degree, and that the music kept pulling him back.","type":"text"}]},{"type":"paragraph","content":[{"text":"While in Puerto Rico he enrolled at its conservatory instead, and came home at the end of 1966. He learned guitar, started going to the recording studios, and stopped trying to be anything other than a musician.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Caballeros Montecarlo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1967 the executives of the tobacco company called him to Santiago to direct their band, Los Caballeros Montecarlo. He stayed eleven years, which is longer than most Dominican musicians of his generation stayed anywhere.","type":"text"}]},{"type":"paragraph","content":[{"text":"The house orchestras","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1973 he joined the television programme Nosotros a las 8 as director of its house orchestra, and began producing advertising jingles alongside it. He went on to direct the house orchestras of De Noche, Punto Final and El Show del Mediodía — the programme ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"1c5f8b70-3fcf-4bbb-b4df-96a6d75300d6"}},{"text":" had built — and produced the Sunday show Fantástico.","type":"text"}]},{"type":"paragraph","content":[{"text":"He was also the man promoters called when an international artist came to play the country and needed a band that could read anything on short notice.","type":"text"}]},{"type":"paragraph","content":[{"text":"The productions","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The records he worked on are where the career lives. He produced or arranged for ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"3acc0b6a-e023-4486-a336-43c5b4ca0c7e"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"ef6ed693-dc49-4530-be5a-d075a72ddc8b"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d509de7c-64a1-4290-8e2f-6b066e230ff3","displayText":"Omar Franco","occurrenceId":"d5764c46-7cb5-41f8-950f-d9df25f0386b"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f84b208b-dd57-43ad-b2bf-d5099e2f0e0e","displayText":"Olga Lara","occurrenceId":"c542ae30-a80c-4785-85bc-40f0383de08a"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband","occurrenceId":"45b0c013-2e5a-46e0-a757-77a8772e1ea7"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre","occurrenceId":"55cf3262-311d-49da-bdde-b648806c96e4"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1","displayText":"José Antonio Rodríguez","occurrenceId":"59eb9be2-0314-41f5-926d-2ff1511ae7f5"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor","occurrenceId":"581b739e-e1e7-4300-ab7c-e1aba8f46a18"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz","occurrenceId":"c2f303f4-d1be-4be5-a7c7-e5ce9baeb7ed"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada","occurrenceId":"4a4f74ba-cb5b-44fe-b386-a4ce9d19a8f6"}},{"text":", among others.","type":"text"}]},{"type":"paragraph","content":[{"text":"That is merengue, bachata, balada and nueva canción in the same working life, and it is why his name turns up in the credits of records that otherwise have nothing in common.","type":"text"}]},{"type":"paragraph","content":[{"text":"The festivals","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He took the same three roles — director, arranger and composer — to the OTI song festivals held in Mexico, Brazil and Puerto Rico, and to the Onda Nueva festival that Aldemaro Romero ran in Venezuela.","type":"text"}]},{"type":"paragraph","content":[{"text":"He died on 3 December 2021 in Orlando, Florida, at seventy-six.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jorge-taveras'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jorge Edmundo Taveras Andújar fue un pianista, arreglista, productor y director de orquesta dominicano. Trabajó detrás de los discos ajenos y al frente de las orquestas de planta de la televisión, y no bajo su propio nombre, razón por la cual su catálogo es una lista de otros artistas, y bastante larga.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ciudad Nueva","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Ciudad Nueva, Santo Domingo, en 1945, y empezó a estudiar piano a principios de los cincuenta en la escuela elemental de música de la ciudad. En 1958 entró a un grupo de rock que dirigía Milton Peláez, y más adelante ingresó al Conservatorio Nacional, donde la compañía eran instrumentistas serios.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 1962 tomó un puesto de pianista en la orquesta del hotel Europa, que fue su primer trabajo profesional y la sala donde aprendió el oficio. Siguió además intentando ser otra cosa: se inscribió en Ingeniería Civil en la Madre y Maestra, después en Administración de Empresas en la Autónoma, que dejó cuando estalló la Revolución de Abril de 1965 y el país se paralizó, y luego en dos universidades más en Puerto Rico. Él mismo contó después que pasó por seis tratando de hacerse de una carrera, y que la música lo halaba de vuelta.","type":"text"}]},{"type":"paragraph","content":[{"text":"Estando en Puerto Rico se inscribió en cambio en su conservatorio, y regresó al país a finales de 1966. Aprendió guitarra, empezó a frecuentar los estudios de grabación, y dejó de intentar ser otra cosa que músico.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Caballeros Montecarlo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1967 los ejecutivos de la tabacalera lo llamaron a Santiago para dirigir su banda, Los Caballeros Montecarlo. Se quedó once años, que es más de lo que la mayoría de los músicos dominicanos de su generación se quedaba en ningún sitio.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las orquestas de planta","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1973 entró al programa de televisión Nosotros a las 8 como director de su orquesta de planta, y empezó en paralelo a producir jingles publicitarios. Después dirigió las orquestas de planta de De Noche, Punto Final y El Show del Mediodía —el programa que había armado ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"8e5f5416-4bef-4529-a824-8533625c8039"}},{"text":"— y produjo el dominical Fantástico.","type":"text"}]},{"type":"paragraph","content":[{"text":"Era además a quien llamaban los empresarios cuando venía un artista internacional a presentarse en el país y hacía falta una banda capaz de leer cualquier cosa con poco aviso.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las producciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Los discos en los que trabajó son donde vive la carrera. Produjo o arregló para ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"5f53964d-13a2-4f78-8f33-48543df48819"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"e0b58b77-f464-4da7-a1c2-e3facc5b2837"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d509de7c-64a1-4290-8e2f-6b066e230ff3","displayText":"Omar Franco","occurrenceId":"547a87c0-4032-44d0-bc90-81c6d1999bb0"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f84b208b-dd57-43ad-b2bf-d5099e2f0e0e","displayText":"Olga Lara","occurrenceId":"ede4c65b-01f0-45aa-8373-13d2a0ce30b4"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband","occurrenceId":"415e11d2-25b4-4fcc-a811-558216fbceb9"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre","occurrenceId":"4dfd3c3b-db66-4a24-aff0-6ee3b39926ba"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1","displayText":"José Antonio Rodríguez","occurrenceId":"9ba45a50-7682-4401-acdb-a35773323dea"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor","occurrenceId":"21382edc-9e1c-4b52-a59d-8c6834d14709"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz","occurrenceId":"51561b63-4e2d-4a28-aff4-91ef45fd38e8"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada","occurrenceId":"fda95f36-a7d6-4928-ab4e-e3077409a498"}},{"text":", entre otros.","type":"text"}]},{"type":"paragraph","content":[{"text":"Eso es merengue, bachata, balada y nueva canción en una misma vida de trabajo, y es la razón por la que su nombre aparece en los créditos de discos que por lo demás no tienen nada que ver entre sí.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los festivales","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Llevó los mismos tres oficios —director, arreglista y compositor— a los festivales OTI de la canción celebrados en México, Brasil y Puerto Rico, y al festival de Onda Nueva que Aldemaro Romero organizaba en Venezuela.","type":"text"}]},{"type":"paragraph","content":[{"text":"Murió el 3 de diciembre de 2021 en Orlando, Florida, a los setenta y seis años.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jorge-taveras'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '1c5f8b70-3fcf-4bbb-b4df-96a6d75300d6', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '3acc0b6a-e023-4486-a336-43c5b4ca0c7e', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '45b0c013-2e5a-46e0-a757-77a8772e1ea7', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '4a4f74ba-cb5b-44fe-b386-a4ce9d19a8f6', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '55cf3262-311d-49da-bdde-b648806c96e4', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '581b739e-e1e7-4300-ab7c-e1aba8f46a18', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), '59eb9be2-0314-41f5-926d-2ff1511ae7f5', 'artist', '25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), 'c2f303f4-d1be-4be5-a7c7-e5ce9baeb7ed', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), 'c542ae30-a80c-4785-85bc-40f0383de08a', 'artist', 'f84b208b-dd57-43ad-b2bf-d5099e2f0e0e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), 'd5764c46-7cb5-41f8-950f-d9df25f0386b', 'artist', 'd509de7c-64a1-4290-8e2f-6b066e230ff3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'en'), 'ef6ed693-dc49-4530-be5a-d075a72ddc8b', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '21382edc-9e1c-4b52-a59d-8c6834d14709', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '415e11d2-25b4-4fcc-a811-558216fbceb9', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '4dfd3c3b-db66-4a24-aff0-6ee3b39926ba', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '51561b63-4e2d-4a28-aff4-91ef45fd38e8', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '547a87c0-4032-44d0-bc90-81c6d1999bb0', 'artist', 'd509de7c-64a1-4290-8e2f-6b066e230ff3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '5f53964d-13a2-4f78-8f33-48543df48819', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '8e5f5416-4bef-4529-a824-8533625c8039', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), '9ba45a50-7682-4401-acdb-a35773323dea', 'artist', '25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), 'e0b58b77-f464-4da7-a1c2-e3facc5b2837', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), 'ede4c65b-01f0-45aa-8373-13d2a0ce30b4', 'artist', 'f84b208b-dd57-43ad-b2bf-d5099e2f0e0e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jorge-taveras') AND locale = 'es'), 'fda95f36-a7d6-4928-ab4e-e3077409a498', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878');

COMMIT;
