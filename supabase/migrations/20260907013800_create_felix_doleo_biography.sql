BEGIN;

-- Create the catalogue entry for Félix D'Oleo.
--
-- Félix D'Oleo. FICHA NUEVA, no una actualización: no existía en el catálogo.
-- El editor la marcó como obligatoria al aparecer en la ficha de Yaqui Núñez
-- del Risco, cuya canción "Hoy Somos Una Canción" él grabó.
--
-- LA GRAFÍA SE VERIFICÓ ANTES DE CREAR LA FILA, porque un nombre mal escrito de
-- entrada arrastra el slug, la URL y todas las citas. El editor lo escribió una
-- vez "Félix de Oleo" y otra "Félix D'Oleo". YouTube, Shazam, Diario Libre, El
-- Día y su propio Instagram usan todos D'OLEO. Va con apóstrofo.
--
-- EL APÓSTROFO ES EL RECTO (U+0027), no el tipográfico, siguiendo lo que la
-- base ya usa en "D'Soto" y "Juliana O'Neal".
--
-- LUGAR DE NACIMIENTO: HABÍA CONFLICTO Y SE RESUELVE. Una reseña de Facebook
-- dice que nació "en Neyba"; La Nación Dominicana dice Hondo Valle, "al pie de
-- la ladera norte de la Sierra de Neyba", y más adelante precisa que Hondo
-- Valle pertenece a la PROVINCIA ELÍAS PIÑA. No son dos versiones: la primera
-- confundió el pueblo con la cordillera vecina. Se guarda Hondo Valle,
-- Elías Piña.
--
-- NO SE GUARDA FECHA DE NACIMIENTO. La descripción de un video de YouTube dice
-- "nació el 06 de octubre del 1960" y no encontré una segunda fuente. Es
-- exactamente el mismo estándar que apliqué para no tocar los apellidos de
-- adriel-music: un dato específico con una sola fuente débil no entra. Queda
-- anotado como pendiente de verificar.
--
-- TRES ENLACES CON RELACIÓN DOCUMENTADA:
--   yaqui-nunez-del-risco -- autor de "Hoy Somos Una Canción", que D'Oleo grabó.
--   luisito-marti -- protagonista de "Nueva York", la película cuyo tema
--     musical fue "Se Fue", canción de D'Oleo.
--   ramon-orlando -- popularizó el merengue que D'Oleo releyó en balada en 2024.
--
-- OJO CON ramon-orlando: la fila se llama "Ramón Orlando & Orquesta
-- Internacional", así que el displayText tiene que decir eso entero para no
-- disparar el hallazgo de nombre divergente. QUEDA ANOTADO que esa fila
-- confunde a la persona con su orquesta, igual que angel-viloria y
-- primitivo-santos-y-su-orquesta. Es deuda de catálogo, no de esta ficha.
--
-- SE DEJA FUERA LA POLÍTICA: en 2009 aspiró a diputado por Elías Piña y no lo
-- admitieron en la boleta. Mismo criterio que con Yaqui Núñez del Risco.
--
-- SE DEJA FUERA EL DETALLE FAMILIAR de su llegada a Haina -- la casa de una
-- hermana, las reglas que le puso. El viaje sí entra: es cómo salió de su
-- pueblo. El trabajo agrícola y los empleos de estudiante también, como
-- historia laboral.
--
-- GÉNERO: primary_genre ballads, que es donde vive su repertorio romántico.
-- genres lleva bachata y merengue, los dos documentados con discos concretos
-- (el álbum "Del Alma" de 2011 y "Ven a Mi Casa Esta Navidad" de 2022).
--
-- INSTRUMENTS lleva guitarra, y esta vez con prueba de sobra: su primera clase
-- fue de guitarra, las fuentes hablan de "su inseparable guitarra", y llegó a
-- Haina "con una guitarra al hombro".
--
-- FUENTES: La Nación Dominicana, reportaje biográfico. Diario Libre, 5 de
-- diciembre de 2022 y 13 de noviembre de 2024. El Día, 14 de noviembre de 2024.
-- Su Instagram, comprobado: la cuenta @felix_doleo existe y resuelve.
--
-- NOMBRES NUEVOS PARA LA LISTA: Antonio María Gómez, el maestro de academia con
-- quien estudió; y Ángel Muñiz, el cineasta de "Nueva York".
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
       name = 'Félix D''Oleo',
       sort_name = 'D''Oleo, Félix',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'ballads',
       date_of_birth = NULL,
       birth_year = NULL,
       date_of_death = NULL,
       birth_place = 'Hondo Valle',
       province = 'Elías Piña',
       first_name = 'Félix',
       middle_name = NULL,
       last_name = 'D''Oleo',
       second_last_name = NULL,
       stage_name = 'Félix D''Oleo',
       aliases = NULL,
       occupations = '["composer","songwriter"]'::jsonb,
       instruments = ARRAY['voice', 'guitar']::text[],
       genres = ARRAY['bachata', 'merengue']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = 'felix_doleo',
       disambiguation = 'Singer-songwriter from Hondo Valle; his song "Se Fue" was the theme of the film Nueva York',
       bio_en = 'Félix D’Oleo is a Dominican singer-songwriter. He works in a romantic repertoire of ballad, bolero and bachata, accompanies himself on guitar, and writes most of what he records. His song Se Fue became widely known as the theme of a Dominican feature film at the end of the nineties.

**Hondo Valle**

He was born in Hondo Valle, in the province of Elías Piña, on the northern slope of the Sierra de Neyba. He grew up among coffee groves and worked in agriculture, and the music around him was that of palos gatherings, carnival and school events. His first guitar lessons came from a religious sister known as Sol Lola, who heard him sing at school and taught him chords.

**Haina and the guitar**

He left the town in the back of a truck loaded with farm produce and settled in Haina. He earned a diploma in electrical technology and lived on occasional work while studying, took lessons at a music academy under the teacher Antonio María Gómez, and in the early eighties worked as an instructor at the national school for the blind. He sang at student gatherings, including at the Universidad Autónoma de Santo Domingo.

**New York**

Invited by a Hispanic student and cultural organisation, he travelled to the United States and settled in New York, and it was from there that he built his recording career.

**Se Fue**

At the end of the nineties his composition Se Fue was chosen as the theme of the film Nueva York, directed by Ángel Muñiz and starring Luisito Martí. The film travelled widely among Dominican and Latin American audiences, and its success opened stages for him at home, on television and in concert.

**The repertoire**

His recordings include Me Falta Todo, Soy Como Soy, Allí Estaré, De Ahí Vengo Yo, Murmullos, No Me Importa No and Andando de Noche Sola, alongside his reading of Roberto Carlos’s Dos Amantes. He also recorded Hoy Somos Una Canción, written by Yaqui Núñez del Risco.

**Across the genres**

He has moved his own material between rhythms rather than staying in one. In 2011 he released a bachata album, Del Alma. In 2022 he recorded Ven a Mi Casa Esta Navidad as a merengue, having first known it as a bolero and a ballad. In 2024 he took the opposite direction, turning a merengue popularised by Ramón Orlando & Orquesta Internacional into a ballad.

**Still working**

During the pandemic he gave a series of free concerts. He revisited El Retrato de Mamá in 2023, and has continued to release new material as an advance on a further album.',
       bio_es = 'Félix D’Oleo es un cantautor dominicano. Trabaja un repertorio romántico de balada, bolero y bachata, se acompaña con la guitarra y escribe casi todo lo que graba. Su canción Se Fue se hizo conocida como tema de una película dominicana a finales de los noventa.

**Hondo Valle**

Nació en Hondo Valle, en la provincia Elías Piña, sobre la ladera norte de la Sierra de Neyba. Se crió entre cafetales y trabajó en la agricultura, y la música que tenía alrededor era la de las fiestas de palos, el carnaval y los actos escolares. Sus primeras clases de guitarra se las dio una religiosa conocida como Sol Lola, que lo oyó cantar en la escuela y le enseñó los acordes.

**Haina y la guitarra**

Salió del pueblo en la parte de atrás de una camioneta cargada de provisiones agrícolas y se estableció en Haina. Sacó un diploma de tecnología eléctrica y vivió de empleos esporádicos mientras estudiaba, tomó clases en una academia de música con el maestro Antonio María Gómez, y a principios de los ochenta trabajó como instructor en la escuela nacional de ciegos. Cantaba en reuniones de estudiantes, entre ellas las de la Universidad Autónoma de Santo Domingo.

**Nueva York**

Invitado por una entidad estudiantil y cultural hispana, viajó a Estados Unidos y se estableció en Nueva York, y fue desde allí que armó su carrera discográfica.

**Se Fue**

A finales de los noventa su composición Se Fue fue escogida como tema de la película Nueva York, dirigida por Ángel Muñiz y protagonizada por Luisito Martí. La cinta circuló mucho entre el público dominicano y latinoamericano, y su éxito le abrió escenarios en el país, en la televisión y en concierto.

**El repertorio**

Entre sus grabaciones están Me Falta Todo, Soy Como Soy, Allí Estaré, De Ahí Vengo Yo, Murmullos, No Me Importa No y Andando de Noche Sola, además de su lectura de Dos Amantes, de Roberto Carlos. Grabó también Hoy Somos Una Canción, escrita por Yaqui Núñez del Risco.

**Entre géneros**

Ha movido su propio material entre ritmos en vez de quedarse en uno. En 2011 publicó un álbum de bachata, Del Alma. En 2022 grabó Ven a Mi Casa Esta Navidad como merengue, después de haberla conocido en bolero y en balada. En 2024 hizo el camino contrario y llevó a balada un merengue que popularizó Ramón Orlando & Orquesta Internacional.

**En activo**

Durante la pandemia ofreció una serie de conciertos gratuitos. Retomó El Retrato de Mamá en 2023, y ha seguido publicando material nuevo como adelanto de otro álbum.',
       updated_at = now()
 WHERE slug = 'felix-doleo';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-doleo')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-doleo')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Félix D’Oleo is a Dominican singer-songwriter. He works in a romantic repertoire of ballad, bolero and bachata, accompanies himself on guitar, and writes most of what he records. His song Se Fue became widely known as the theme of a Dominican feature film at the end of the nineties.","type":"text"}]},{"type":"paragraph","content":[{"text":"Hondo Valle","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Hondo Valle, in the province of Elías Piña, on the northern slope of the Sierra de Neyba. He grew up among coffee groves and worked in agriculture, and the music around him was that of palos gatherings, carnival and school events. His first guitar lessons came from a religious sister known as Sol Lola, who heard him sing at school and taught him chords.","type":"text"}]},{"type":"paragraph","content":[{"text":"Haina and the guitar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He left the town in the back of a truck loaded with farm produce and settled in Haina. He earned a diploma in electrical technology and lived on occasional work while studying, took lessons at a music academy under the teacher Antonio María Gómez, and in the early eighties worked as an instructor at the national school for the blind. He sang at student gatherings, including at the Universidad Autónoma de Santo Domingo.","type":"text"}]},{"type":"paragraph","content":[{"text":"New York","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Invited by a Hispanic student and cultural organisation, he travelled to the United States and settled in New York, and it was from there that he built his recording career.","type":"text"}]},{"type":"paragraph","content":[{"text":"Se Fue","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"At the end of the nineties his composition Se Fue was chosen as the theme of the film Nueva York, directed by Ángel Muñiz and starring ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bd631179-2de1-4db3-809d-a896b591ca1d","displayText":"Luisito Martí","occurrenceId":"0ca126c9-ffca-4777-a29d-a9956bf34d90"}},{"text":". The film travelled widely among Dominican and Latin American audiences, and its success opened stages for him at home, on television and in concert.","type":"text"}]},{"type":"paragraph","content":[{"text":"The repertoire","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His recordings include Me Falta Todo, Soy Como Soy, Allí Estaré, De Ahí Vengo Yo, Murmullos, No Me Importa No and Andando de Noche Sola, alongside his reading of Roberto Carlos’s Dos Amantes. He also recorded Hoy Somos Una Canción, written by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faff18bd-3dbc-477a-bc38-859d611887f0","displayText":"Yaqui Núñez del Risco","occurrenceId":"7556f480-ccc6-4d8c-99e7-2aed7026041e"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Across the genres","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He has moved his own material between rhythms rather than staying in one. In 2011 he released a bachata album, Del Alma. In 2022 he recorded Ven a Mi Casa Esta Navidad as a merengue, having first known it as a bolero and a ballad. In 2024 he took the opposite direction, turning a merengue popularised by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional","occurrenceId":"aae52993-0eea-4946-8e3c-25142117b7bf"}},{"text":" into a ballad.","type":"text"}]},{"type":"paragraph","content":[{"text":"Still working","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"During the pandemic he gave a series of free concerts. He revisited El Retrato de Mamá in 2023, and has continued to release new material as an advance on a further album.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'felix-doleo'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Félix D’Oleo es un cantautor dominicano. Trabaja un repertorio romántico de balada, bolero y bachata, se acompaña con la guitarra y escribe casi todo lo que graba. Su canción Se Fue se hizo conocida como tema de una película dominicana a finales de los noventa.","type":"text"}]},{"type":"paragraph","content":[{"text":"Hondo Valle","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Hondo Valle, en la provincia Elías Piña, sobre la ladera norte de la Sierra de Neyba. Se crió entre cafetales y trabajó en la agricultura, y la música que tenía alrededor era la de las fiestas de palos, el carnaval y los actos escolares. Sus primeras clases de guitarra se las dio una religiosa conocida como Sol Lola, que lo oyó cantar en la escuela y le enseñó los acordes.","type":"text"}]},{"type":"paragraph","content":[{"text":"Haina y la guitarra","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Salió del pueblo en la parte de atrás de una camioneta cargada de provisiones agrícolas y se estableció en Haina. Sacó un diploma de tecnología eléctrica y vivió de empleos esporádicos mientras estudiaba, tomó clases en una academia de música con el maestro Antonio María Gómez, y a principios de los ochenta trabajó como instructor en la escuela nacional de ciegos. Cantaba en reuniones de estudiantes, entre ellas las de la Universidad Autónoma de Santo Domingo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nueva York","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Invitado por una entidad estudiantil y cultural hispana, viajó a Estados Unidos y se estableció en Nueva York, y fue desde allí que armó su carrera discográfica.","type":"text"}]},{"type":"paragraph","content":[{"text":"Se Fue","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A finales de los noventa su composición Se Fue fue escogida como tema de la película Nueva York, dirigida por Ángel Muñiz y protagonizada por ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bd631179-2de1-4db3-809d-a896b591ca1d","displayText":"Luisito Martí","occurrenceId":"d0dbfea2-8a43-4aa8-833b-8012d4d41cb1"}},{"text":". La cinta circuló mucho entre el público dominicano y latinoamericano, y su éxito le abrió escenarios en el país, en la televisión y en concierto.","type":"text"}]},{"type":"paragraph","content":[{"text":"El repertorio","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Entre sus grabaciones están Me Falta Todo, Soy Como Soy, Allí Estaré, De Ahí Vengo Yo, Murmullos, No Me Importa No y Andando de Noche Sola, además de su lectura de Dos Amantes, de Roberto Carlos. Grabó también Hoy Somos Una Canción, escrita por ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faff18bd-3dbc-477a-bc38-859d611887f0","displayText":"Yaqui Núñez del Risco","occurrenceId":"f6bbe396-a1c1-4653-a7fd-05470edfdeac"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Entre géneros","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Ha movido su propio material entre ritmos en vez de quedarse en uno. En 2011 publicó un álbum de bachata, Del Alma. En 2022 grabó Ven a Mi Casa Esta Navidad como merengue, después de haberla conocido en bolero y en balada. En 2024 hizo el camino contrario y llevó a balada un merengue que popularizó ","type":"text"},{"type":"artistReference","attrs":{"artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional","occurrenceId":"42fad99f-99ef-4634-a3ad-2cf04812d8b6"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"En activo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Durante la pandemia ofreció una serie de conciertos gratuitos. Retomó El Retrato de Mamá en 2023, y ha seguido publicando material nuevo como adelanto de otro álbum.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'felix-doleo'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-doleo') AND locale = 'en'), '0ca126c9-ffca-4777-a29d-a9956bf34d90', 'artist', 'bd631179-2de1-4db3-809d-a896b591ca1d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-doleo') AND locale = 'en'), '7556f480-ccc6-4d8c-99e7-2aed7026041e', 'artist', 'faff18bd-3dbc-477a-bc38-859d611887f0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-doleo') AND locale = 'en'), 'aae52993-0eea-4946-8e3c-25142117b7bf', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-doleo') AND locale = 'es'), '42fad99f-99ef-4634-a3ad-2cf04812d8b6', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-doleo') AND locale = 'es'), 'd0dbfea2-8a43-4aa8-833b-8012d4d41cb1', 'artist', 'bd631179-2de1-4db3-809d-a896b591ca1d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'felix-doleo') AND locale = 'es'), 'f6bbe396-a1c1-4653-a7fd-05470edfdeac', 'artist', 'faff18bd-3dbc-477a-bc38-859d611887f0');

COMMIT;
