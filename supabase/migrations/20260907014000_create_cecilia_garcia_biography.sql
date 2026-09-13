BEGIN;

-- Create the catalogue entry for Cecilia García.
--
-- Cecilia García. FICHA NUEVA: no existía en el catálogo. El editor la marcó
-- como obligatoria al aparecer en la ficha de Yaqui Núñez del Risco, cuya
-- canción "Hola Nuevo Día" ella grabó.
--
-- ES UNA FIGURA MAYOR Y LA FICHA SE ESCRIBE DESDE LA MÚSICA. Wikipedia la trata
-- sobre todo como actriz y productora de televisión, y lo es; pero canta desde
-- los dieciséis años, su carrera escénica es teatro MUSICAL, y este catálogo la
-- registra como cantante. La actuación entra porque es inseparable de su canto,
-- no como relleno.
--
-- NOMBRE COMPLETO: Cecilia Margarita García-Mella Castillo. El apellido paterno
-- lleva guion, García-Mella, y así se guarda. El nombre artístico es Cecilia
-- García, que es el que va en name.
--
-- SEUDÓNIMO "LA POLIFACÉTICA", que usan Wikipedia y EcuRed. Wikipedia menciona
-- además que el público la llamó "la Diva" tras el Gran Dorado de 1984; eso NO
-- va en aliases porque es una manera de referirse a ella en un momento, no un
-- nombre con el que se le acredite.
--
-- SE DEJA FUERA TODA LA VIDA PRIVADA, que en su caso es abundante y política:
-- cónyuge, hijo, los apellidos y la ascendencia de sus padres, y la genealogía
-- que Wikipedia detalla hasta emparentarla con Ramón Matías Mella. Nada de eso
-- es música.
--
-- SÍ ENTRA que su padre le puso como condición terminar la universidad: es el
-- hecho que explica por qué estudió psicología mientras empezaba a cantar. No
-- se nombra el oficio de ningún familiar.
--
-- DOS ENLACES: rafael-solano, con quien condujo "Cecilia y Solano" en 1978; y
-- yaqui-nunez-del-risco, autor de "Hola Nuevo Día".
--
-- GÉNERO: ballads. El teatro musical no es uno de los nueve géneros de nivel 0
-- aprobados, y su repertorio grabado es de canción romántica. Si el editor
-- prefiere otro, la línea es primary_genre.
--
-- OCCUPATIONS: actress, producer, television_host y comedian. Los cuatro
-- existen ya en el vocabulario y ninguno repite primary_role (singer). NO se
-- inventa "conductora" ni "productora teatral": television_host y producer los
-- cubren.
--
-- LOS PREMIOS VAN EN MIGRACIÓN APARTE. Son muchos y obligan a crear categorías
-- nuevas, incluida la del GRAN DORADO, que resulta ser el máximo galardón de
-- los mismos Premios El Dorado que creé ayer para Olga Lara. Va como categoría
-- dentro de ese premio, no como premio aparte.
--
-- FUENTES: Wikipedia en español, extensa y referenciada. Diario Libre, 29 de
-- julio de 2025, entrevista de repaso de carrera. EcuRed. tusolcaribe, 15 de
-- julio de 2026, para el homenaje del Centro Cultural Perelló.
--
-- NOMBRES NUEVOS PARA LA LISTA, y el primero es una omisión seria:
-- ÁNGELA CARRASCO, cantante dominicana de proyección internacional, que no está
-- en el catálogo. También Manuel Sánchez Acosta (el compositor que la inició),
-- Milton Peláez, Cuquín Victoria, Felipe Polanco y Rhina Ramírez, de su misma
-- generación televisiva.
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
       name = 'Cecilia García',
       sort_name = 'García-Mella Castillo, Cecilia Margarita',
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'ballads',
       date_of_birth = '1951-11-22',
       birth_year = 1951,
       date_of_death = NULL,
       birth_place = 'Santo Domingo',
       province = 'Santo Domingo',
       first_name = 'Cecilia',
       middle_name = 'Margarita',
       last_name = 'García-Mella',
       second_last_name = 'Castillo',
       stage_name = 'Cecilia García',
       aliases = ARRAY['La Polifacética']::text[],
       occupations = '["actress","producer","television_host","comedian"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Singer and actress known as La Polifacética; a central figure of Dominican musical theatre for over five decades',
       bio_en = 'Cecilia Margarita García-Mella Castillo, known as Cecilia García and nicknamed La Polifacética, is a Dominican singer, actress, television host and producer. She has worked for more than five decades and is the central figure of musical theatre in the Dominican Republic, where she has carried the leading role in most of the large productions staged at the national theatre.

**A house full of instruments**

She was born in Santo Domingo in 1951 and grew up surrounded by instruments, singing and dancing at school events. She wanted to be a singer from childhood, and at sixteen her family agreed on one condition: that she finish her schooling and go to university. She kept the bargain, graduating from secondary school and studying psychology while her performing career was already under way.

**Television**

She started on the programme La Taberna de Babín, on the state channel, brought in by the composer Manuel Sánchez Acosta. She belonged to the generation of television performers that included Milton Peláez, Cuquín Victoria, Felipe Polanco and Ángela Carrasco, and she also built a parallel career in advertising, recording jingles and voice characterisations for the country’s largest campaigns.

Between 1970 and 1974 she was part of the comic cast of Telemundo in San Juan, Puerto Rico. She co-produced her first programme, 3x3, in 1974, and in 1978 hosted Cecilia y Solano with Rafael Solano. She produced Esta Noche Cecilia in 1980 and was part of the daily El Show del Mediodía until 1985.

The programme she is most identified with is Cecilia en Facetas, which she produced from 1985 and which ran for a decade, mixing television specials, interviews, musical numbers and drama. She later produced Donde Quiera que Estés, which reunited Dominicans living abroad with their families and ran until 2003.

**Musical theatre**

Her stage career began in drama, with El Último Instante by Franklin Domínguez at the national theatre in 1974, and moved decisively into the musical with Evita in 1988, which drew the largest audience the house had seen and brought her a first award for production of the year.

In 2005 she starred in the first Spanish-language production of Victor Victoria staged anywhere in the world. She went on to lead El Beso de la Mujer Araña, appeared as Fantine in Les Misérables, and marked fifty years on stage playing Judy Garland in Al Final del Arcoíris. In 2025 she took the title role in the first Dominican production of Hello, Dolly! at the Teatro Nacional.

**The singing**

Her recorded work is inseparable from the stage. Among the songs she has taken into her repertoire is Hola Nuevo Día, written by Yaqui Núñez del Risco.

**Recognition**

She was the first woman to win the Gran Dorado, the highest artistic award of its era in the country, and the first to win it three times. In 1975 she took two El Dorado awards in the same year, for comic actress and for producing the best show, the first time a woman had received the latter. Her stage work has since brought her several awards from the Dominican critics’ association, and in 2017 she received the first Soberano awarded for the performing arts.

**Cinema**

She made her film debut in Biodegradable, directed by Juan Basanta, in 2013.',
       bio_es = 'Cecilia Margarita García-Mella Castillo, conocida como Cecilia García y apodada La Polifacética, es una cantante, actriz, conductora y productora dominicana. Trabaja desde hace más de cinco décadas y es la figura central del teatro musical en la República Dominicana, donde ha llevado el papel principal de casi todas las grandes producciones montadas en el teatro nacional.

**Una casa con instrumentos**

Nació en Santo Domingo en 1951 y se crió rodeada de instrumentos, cantando y bailando en las veladas del colegio. Quiso ser cantante desde niña, y a los dieciséis años su familia accedió con una condición: que terminara sus estudios y llegara a la universidad. Cumplió el trato, se graduó de bachiller y estudió psicología mientras su carrera artística ya estaba en marcha.

**La televisión**

Empezó en el programa La Taberna de Babín, del canal estatal, de la mano del compositor Manuel Sánchez Acosta. Perteneció a la generación de figuras televisivas que integraron Milton Peláez, Cuquín Victoria, Felipe Polanco y Ángela Carrasco, y armó además una carrera paralela en publicidad, grabando jingles y caracterizaciones de voz para las campañas más grandes del país.

Entre 1970 y 1974 formó parte del elenco cómico de Telemundo en San Juan, Puerto Rico. Coprodujo su primer programa, 3x3, en 1974, y en 1978 condujo Cecilia y Solano junto a Rafael Solano. Produjo Esta Noche Cecilia en 1980 y fue parte del diario El Show del Mediodía hasta 1985.

El programa con el que más se la identifica es Cecilia en Facetas, que produjo desde 1985 y que estuvo una década al aire, mezclando especiales de televisión, entrevistas, números musicales y actuación. Después produjo Donde Quiera que Estés, que reunía a dominicanos residentes en el exterior con sus familias y se mantuvo hasta 2003.

**El teatro musical**

Su carrera de escenario empezó en el drama, con El Último Instante, de Franklin Domínguez, en el teatro nacional en 1974, y pasó de lleno al musical con Evita en 1988, que convocó el público más numeroso que la sala había visto y le valió un primer premio al espectáculo del año.

En 2005 protagonizó la primera versión en español de Victor Victoria montada en cualquier parte del mundo. Después encabezó El Beso de la Mujer Araña, apareció como Fantine en Los Miserables, y cumplió cincuenta años de escena interpretando a Judy Garland en Al Final del Arcoíris. En 2025 asumió el papel principal de la primera producción dominicana de Hello, Dolly! en el Teatro Nacional.

**El canto**

Su obra grabada es inseparable del escenario. Entre las canciones que ha llevado a su repertorio está Hola Nuevo Día, escrita por Yaqui Núñez del Risco.

**Reconocimientos**

Fue la primera mujer en ganar el Gran Dorado, el máximo galardón artístico del país en su época, y la primera en obtenerlo tres veces. En 1975 se llevó dos premios El Dorado el mismo año, como actriz cómica y como realizadora del mejor espectáculo, la primera vez que una mujer recibía este último. Su trabajo escénico le ha valido desde entonces varios premios de la asociación dominicana de cronistas de arte, y en 2017 recibió el primer Soberano entregado a las artes escénicas.

**El cine**

Debutó en el cine con Biodegradable, dirigida por Juan Basanta, en 2013.',
       updated_at = now()
 WHERE slug = 'cecilia-garcia';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cecilia-garcia')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cecilia-garcia')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Cecilia Margarita García-Mella Castillo, known as Cecilia García and nicknamed La Polifacética, is a Dominican singer, actress, television host and producer. She has worked for more than five decades and is the central figure of musical theatre in the Dominican Republic, where she has carried the leading role in most of the large productions staged at the national theatre.","type":"text"}]},{"type":"paragraph","content":[{"text":"A house full of instruments","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She was born in Santo Domingo in 1951 and grew up surrounded by instruments, singing and dancing at school events. She wanted to be a singer from childhood, and at sixteen her family agreed on one condition: that she finish her schooling and go to university. She kept the bargain, graduating from secondary school and studying psychology while her performing career was already under way.","type":"text"}]},{"type":"paragraph","content":[{"text":"Television","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She started on the programme La Taberna de Babín, on the state channel, brought in by the composer Manuel Sánchez Acosta. She belonged to the generation of television performers that included Milton Peláez, Cuquín Victoria, Felipe Polanco and Ángela Carrasco, and she also built a parallel career in advertising, recording jingles and voice characterisations for the country’s largest campaigns.","type":"text"}]},{"type":"paragraph","content":[{"text":"Between 1970 and 1974 she was part of the comic cast of Telemundo in San Juan, Puerto Rico. She co-produced her first programme, 3x3, in 1974, and in 1978 hosted Cecilia y Solano with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"3411b192-d988-46bb-8afd-e3c7aa64c4f0"}},{"text":". She produced Esta Noche Cecilia in 1980 and was part of the daily El Show del Mediodía until 1985.","type":"text"}]},{"type":"paragraph","content":[{"text":"The programme she is most identified with is Cecilia en Facetas, which she produced from 1985 and which ran for a decade, mixing television specials, interviews, musical numbers and drama. She later produced Donde Quiera que Estés, which reunited Dominicans living abroad with their families and ran until 2003.","type":"text"}]},{"type":"paragraph","content":[{"text":"Musical theatre","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Her stage career began in drama, with El Último Instante by Franklin Domínguez at the national theatre in 1974, and moved decisively into the musical with Evita in 1988, which drew the largest audience the house had seen and brought her a first award for production of the year.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 2005 she starred in the first Spanish-language production of Victor Victoria staged anywhere in the world. She went on to lead El Beso de la Mujer Araña, appeared as Fantine in Les Misérables, and marked fifty years on stage playing Judy Garland in Al Final del Arcoíris. In 2025 she took the title role in the first Dominican production of Hello, Dolly! at the Teatro Nacional.","type":"text"}]},{"type":"paragraph","content":[{"text":"The singing","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Her recorded work is inseparable from the stage. Among the songs she has taken into her repertoire is Hola Nuevo Día, written by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faff18bd-3dbc-477a-bc38-859d611887f0","displayText":"Yaqui Núñez del Risco","occurrenceId":"098c7441-f209-4756-a95c-1b9ca5087e5f"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Recognition","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She was the first woman to win the Gran Dorado, the highest artistic award of its era in the country, and the first to win it three times. In 1975 she took two El Dorado awards in the same year, for comic actress and for producing the best show, the first time a woman had received the latter. Her stage work has since brought her several awards from the Dominican critics’ association, and in 2017 she received the first Soberano awarded for the performing arts.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cinema","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She made her film debut in Biodegradable, directed by Juan Basanta, in 2013.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'cecilia-garcia'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Cecilia Margarita García-Mella Castillo, conocida como Cecilia García y apodada La Polifacética, es una cantante, actriz, conductora y productora dominicana. Trabaja desde hace más de cinco décadas y es la figura central del teatro musical en la República Dominicana, donde ha llevado el papel principal de casi todas las grandes producciones montadas en el teatro nacional.","type":"text"}]},{"type":"paragraph","content":[{"text":"Una casa con instrumentos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santo Domingo en 1951 y se crió rodeada de instrumentos, cantando y bailando en las veladas del colegio. Quiso ser cantante desde niña, y a los dieciséis años su familia accedió con una condición: que terminara sus estudios y llegara a la universidad. Cumplió el trato, se graduó de bachiller y estudió psicología mientras su carrera artística ya estaba en marcha.","type":"text"}]},{"type":"paragraph","content":[{"text":"La televisión","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Empezó en el programa La Taberna de Babín, del canal estatal, de la mano del compositor Manuel Sánchez Acosta. Perteneció a la generación de figuras televisivas que integraron Milton Peláez, Cuquín Victoria, Felipe Polanco y Ángela Carrasco, y armó además una carrera paralela en publicidad, grabando jingles y caracterizaciones de voz para las campañas más grandes del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Entre 1970 y 1974 formó parte del elenco cómico de Telemundo en San Juan, Puerto Rico. Coprodujo su primer programa, 3x3, en 1974, y en 1978 condujo Cecilia y Solano junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"c91d38bb-618b-42b7-ad33-3143976927f7"}},{"text":". Produjo Esta Noche Cecilia en 1980 y fue parte del diario El Show del Mediodía hasta 1985.","type":"text"}]},{"type":"paragraph","content":[{"text":"El programa con el que más se la identifica es Cecilia en Facetas, que produjo desde 1985 y que estuvo una década al aire, mezclando especiales de televisión, entrevistas, números musicales y actuación. Después produjo Donde Quiera que Estés, que reunía a dominicanos residentes en el exterior con sus familias y se mantuvo hasta 2003.","type":"text"}]},{"type":"paragraph","content":[{"text":"El teatro musical","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su carrera de escenario empezó en el drama, con El Último Instante, de Franklin Domínguez, en el teatro nacional en 1974, y pasó de lleno al musical con Evita en 1988, que convocó el público más numeroso que la sala había visto y le valió un primer premio al espectáculo del año.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 2005 protagonizó la primera versión en español de Victor Victoria montada en cualquier parte del mundo. Después encabezó El Beso de la Mujer Araña, apareció como Fantine en Los Miserables, y cumplió cincuenta años de escena interpretando a Judy Garland en Al Final del Arcoíris. En 2025 asumió el papel principal de la primera producción dominicana de Hello, Dolly! en el Teatro Nacional.","type":"text"}]},{"type":"paragraph","content":[{"text":"El canto","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su obra grabada es inseparable del escenario. Entre las canciones que ha llevado a su repertorio está Hola Nuevo Día, escrita por ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faff18bd-3dbc-477a-bc38-859d611887f0","displayText":"Yaqui Núñez del Risco","occurrenceId":"beb6db2e-eb92-4bb4-8575-e065f35727b6"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Reconocimientos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Fue la primera mujer en ganar el Gran Dorado, el máximo galardón artístico del país en su época, y la primera en obtenerlo tres veces. En 1975 se llevó dos premios El Dorado el mismo año, como actriz cómica y como realizadora del mejor espectáculo, la primera vez que una mujer recibía este último. Su trabajo escénico le ha valido desde entonces varios premios de la asociación dominicana de cronistas de arte, y en 2017 recibió el primer Soberano entregado a las artes escénicas.","type":"text"}]},{"type":"paragraph","content":[{"text":"El cine","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Debutó en el cine con Biodegradable, dirigida por Juan Basanta, en 2013.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'cecilia-garcia'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cecilia-garcia') AND locale = 'en'), '098c7441-f209-4756-a95c-1b9ca5087e5f', 'artist', 'faff18bd-3dbc-477a-bc38-859d611887f0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cecilia-garcia') AND locale = 'en'), '3411b192-d988-46bb-8afd-e3c7aa64c4f0', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cecilia-garcia') AND locale = 'es'), 'beb6db2e-eb92-4bb4-8575-e065f35727b6', 'artist', 'faff18bd-3dbc-477a-bc38-859d611887f0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cecilia-garcia') AND locale = 'es'), 'c91d38bb-618b-42b7-ad33-3143976927f7', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

COMMIT;
