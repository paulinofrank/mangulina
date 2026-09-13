BEGIN;

-- Rewrite the catalogue entry for Víctor Víctor.
--
-- Víctor Víctor. OCTAVA de las dieciocho, y el ejemplo más puro de lo que le
-- pasa al lote de mayo: 1.578 caracteres de adjetivos sin UN SOLO TÍTULO DE
-- CANCIÓN, sin un disco, sin una fecha que no sea nacer y morir.
--
-- Decía "towering intellectual and artistic presence", "lyrics of extraordinary
-- literary quality", "vivid characters", "one of the great composers of his
-- era" -- y no nombraba "Mesita de Noche", que es la razón por la que el mundo
-- sabe quién es. Se puede leer entera sin enterarse de nada.
--
-- ADEMÁS TENÍA UN ERROR DE CRONOLOGÍA: "Coming of age during a period of
-- political repression under the Trujillo dictatorship". Nació en 1948 y
-- Trujillo murió en 1961, cuando él tenía doce años. Se formó DESPUÉS, que es
-- otra cosa y bastante más precisa: la generación de la canción protesta de los
-- setenta.
--
-- LO QUE FALTABA, QUE ES TODO:
--
--   "MESITA DE NOCHE", de Inspiraciones (1990). Es el disco con el que la
--   bachata deja de ser género marginal y empieza a viajar. Es EL dato de esta
--   ficha y no aparecía.
--
--   EL PREMIO ONDAS DE 1993. Verificado en la lista de premiados de ese año, no
--   solo en su ficha: "Mejor artista o grupo revelación latino". Es un premio
--   español mayor y el catálogo no lo tenía ni como entidad.
--
--   "EL CAMINO DE LOS AMANTES", de 1972, grabada cuando era percusionista y
--   guitarrista de la orquesta de Wilfrido Vargas. La llevó afuera FELIPE
--   PIRELA, y por ahí empezó a existir como compositor fuera del país.
--
--   NUEVA FORMA, el grupo que fundó con Sonia Silvestre, y Siete Días con el
--   Pueblo en 1974. La ficha hablaba de "protest ballads" en abstracto y no
--   nombraba ni el grupo ni el festival.
--
-- LOS VIAJES A CUBA SÍ ENTRAN. Fue de los primeros artistas dominicanos en ir
-- cuando el gobierno lo tenía prohibido. Es restricción estatal sobre la
-- circulación de músicos, mismo criterio por el que entró la cárcel de Ramón
-- Leonardo y la de Jerry Vargas: el Estado interviniendo sobre el trabajo
-- artístico. No es militancia partidaria.
--
-- LA CAUSA DE MUERTE NO ENTRA, y este caso es lo contrario del de Rubby Pérez.
-- Murió de COVID-19 en un hospital de Santo Domingo. Eso es diagnóstico, o sea
-- dato médico privado, y la regla lo excluye. Rubby murió sobre la tarima en un
-- derrumbe público durante su concierto, que es hecho público ocurrido en el
-- oficio. La prueba es dónde ocurrió, no si la palabra muerte aparece.
--
-- TAMPOCO ENTRAN los nombres de sus padres, que da la Wikipedia en español.
--
-- CUATRO DEFECTOS DE LA FILA:
--
--   aliases traía 'Victor Victor' -- su propio nombre SIN ACENTOS -- y 'Víctor
--   José Víctor Rojas', el nombre legal completo. Es el SÉPTIMO caso de nombre
--   legal metido en aliases. Los dos salen y el campo queda vacío, que es
--   preferible a que tenga cosas falsas.
--
--   last_name decía 'Victor' sin tilde y second_last_name estaba en NULL. Su
--   nombre legal es Víctor José Víctor Rojas: Víctor por el padre, Rojas por la
--   madre. Se corrigen los dos.
--
--   sort_name estaba en NULL. Pasa a 'Víctor Rojas, Víctor José'.
--
--   instruments estaba VACÍO para un guitarrista y percusionista. occupations
--   pierde 'musician', que no dice nada.
--
-- SIETE ENLACES, TODOS POR CRÉDITO DOCUMENTADO: wilfrido-vargas (su orquesta a
-- principios de los setenta), sonia-silvestre (cofundadora de Nueva Forma),
-- francis-santana (disco a dúo En Son de Felicidad, 1982), jose-antonio-
-- rodriguez (Artistas por la Paz / Cara o Cruz, 1986), juan-francisco-ordonez
-- (produjo Bachata Entre Amigos), y milly-quezada y rubby-perez, dos de los
-- intérpretes que grabaron canciones suyas. Las siete fichas están publicadas.
--
-- NO SE ENLAZAN los extranjeros que grabaron su obra y que no pertenecen al
-- catálogo: Felipe Pirela, Celia Cruz, Marc Anthony, Dyango, Azúcar Moreno, ni
-- los autores que versionó en Bachata Entre Amigos.
--
-- primary_genre = 'ballads' QUEDA COMO ESTÁ Y SE REPORTA. Es defendible: era
-- cantautor. Pero su peso histórico está en la bachata, y genres está vacío.
-- Decisión de género, o sea del editor.
--
-- EL PREMIO VA EN MIGRACIÓN APARTE porque hay que crear la entidad Premios
-- Ondas, que el catálogo no tiene.
--
-- FUENTES: Wikipedia en español para la biografía y la discografía. El anexo de
-- Premios Ondas 1993, que es página distinta, para el premio y su categoría
-- exacta. Los créditos de los discos compartidos, que la propia discografía
-- lista.
--
-- NOMBRE NUEVO PARA LA LISTA: NUEVA FORMA, el grupo de canción protesta que
-- fundó con Sonia Silvestre. No tiene ficha.
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
       name = 'Víctor Víctor',
       sort_name = 'Víctor Rojas, Víctor José',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'ballads',
       date_of_birth = '1948-12-11',
       birth_year = 1948,
       date_of_death = '2020-07-16',
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Víctor José',
       middle_name = NULL,
       last_name = 'Víctor',
       second_last_name = 'Rojas',
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '["composer","guitarist","percussionist"]'::jsonb,
       instruments = ARRAY['voice', 'guitar', 'percussion']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Singer-songwriter and guitarist; wrote Mesita de Noche and took bachata onto international stages',
       bio_en = 'Víctor José Víctor Rojas, who performed as Víctor Víctor, was a Dominican singer-songwriter and guitarist. He wrote Mesita de Noche, and the album that carried it did more than any other record of its moment to move bachata out of the margins of Dominican music and onto stages abroad.

**Los Pepines**

He was born in 1948 in Los Pepines, a neighbourhood of Santiago de los Caballeros. He came to music as a percussionist and guitarist rather than as a singer, and at the start of the seventies he was working inside the orchestra of Wilfrido Vargas.

There, in 1972, he recorded El Camino de los Amantes. The Venezuelan singer Felipe Pirela took the song up shortly afterwards and carried it across the continent, which is how his name first travelled: as an author, before anyone outside the country had heard him sing.

**Nueva Forma**

He belonged to the generation that turned Dominican song political after the dictatorship rather than during it. With Sonia Silvestre he founded Nueva Forma, a group working in the protest song of the seventies, and the two of them were on the bill of the festival Siete Días con el Pueblo in 1974.

He was also among the first Dominican musicians to travel to Cuba while the government forbade it. Álbum Rojo, Chile Vive and Neruda Raíz y Geografía came out of those years, and he kept returning to that material for the rest of his life: Verde y Negro, in 2007, was built entirely from songs about the people who fought for Dominican freedom.

He recorded shared albums with other Dominican musicians of the same conviction, En Son de Felicidad with Francis Santana and Cara o Cruz with José Antonio Rodríguez.

**Mesita de Noche**

Inspiraciones appeared in 1990 and changed the standing of a whole genre. Bachata had been treated at home as music of the poor and the cantina; the record put it in a different register without softening it, and Mesita de Noche went out across Latin America and Spain. In 1993 the Premios Ondas named him the year’s revelation among Latin artists.

Albums followed through the nineties and two thousands: Tu Corazón, Un Chin de Veneno, Alma de Barrio, Cajita de Música and Pisando Rayas.

**The songwriter**

Much of his catalogue reached the public in other people’s voices. Milly Quezada and Rubby Pérez recorded him at home, and abroad his songs were taken up by Celia Cruz, Marc Anthony, Dyango and Azúcar Moreno.

**Bachata Entre Amigos**

In 2006 he made Bachata Entre Amigos, produced by the guitarist Juan Francisco Ordóñez. The record sets songs by Joan Manuel Serrat, Joaquín Sabina, Silvio Rodríguez and Fito Páez as bachatas, sung as duets with their authors, so that several of them heard their own work in the rhythm for the first time.

He died in Santo Domingo on 16 July 2020, at seventy-one.',
       bio_es = 'Víctor José Víctor Rojas, que se presentaba como Víctor Víctor, fue un cantautor y guitarrista dominicano. Escribió Mesita de Noche, y el disco que la llevaba hizo más que ningún otro de su momento por sacar la bachata del margen de la música dominicana y ponerla en escenarios de afuera.

**Los Pepines**

Nació en 1948 en Los Pepines, barrio de Santiago de los Caballeros. Llegó a la música como percusionista y guitarrista antes que como cantante, y a principios de los setenta trabajaba dentro de la orquesta de Wilfrido Vargas.

Ahí grabó, en 1972, El Camino de los Amantes. El venezolano Felipe Pirela la tomó poco después y la llevó por el continente, y así fue como su nombre salió primero: como autor, antes de que nadie fuera del país lo hubiera oído cantar.

**Nueva Forma**

Pertenece a la generación que politizó la canción dominicana después de la dictadura y no durante ella. Con Sonia Silvestre fundó Nueva Forma, grupo de la canción protesta de los setenta, y los dos estuvieron en el cartel del festival Siete Días con el Pueblo en 1974.

Fue además de los primeros músicos dominicanos en viajar a Cuba mientras el gobierno lo prohibía. De esos años salieron Álbum Rojo, Chile Vive y Neruda Raíz y Geografía, y volvió a ese material toda su vida: Verde y Negro, de 2007, está armado entero con canciones sobre quienes pelearon por la libertad del país.

Grabó discos compartidos con otros músicos dominicanos de la misma convicción, En Son de Felicidad con Francis Santana y Cara o Cruz con José Antonio Rodríguez.

**Mesita de Noche**

Inspiraciones salió en 1990 y le cambió el estatus a un género entero. La bachata se trataba en el país como música de pobres y de cantina; el disco la puso en otro registro sin suavizarla, y Mesita de Noche salió por toda América Latina y España. En 1993 los Premios Ondas lo nombraron revelación del año entre los artistas latinos.

Detrás vinieron discos a lo largo de los noventa y los dos mil: Tu Corazón, Un Chin de Veneno, Alma de Barrio, Cajita de Música y Pisando Rayas.

**El compositor**

Buena parte de su catálogo llegó al público en voces ajenas. Milly Quezada y Rubby Pérez lo grabaron en el país, y afuera tomaron sus canciones Celia Cruz, Marc Anthony, Dyango y Azúcar Moreno.

**Bachata Entre Amigos**

En 2006 hizo Bachata Entre Amigos, producido por el guitarrista Juan Francisco Ordóñez. El disco pone en bachata canciones de Joan Manuel Serrat, Joaquín Sabina, Silvio Rodríguez y Fito Páez, cantadas a dúo con sus autores, de modo que varios de ellos oyeron su propia obra en ese ritmo por primera vez.

Murió en Santo Domingo el 16 de julio de 2020, a los setenta y un años.',
       updated_at = now()
 WHERE slug = 'victor-victor';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Víctor José Víctor Rojas, who performed as Víctor Víctor, was a Dominican singer-songwriter and guitarist. He wrote Mesita de Noche, and the album that carried it did more than any other record of its moment to move bachata out of the margins of Dominican music and onto stages abroad.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Pepines","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1948 in Los Pepines, a neighbourhood of Santiago de los Caballeros. He came to music as a percussionist and guitarist rather than as a singer, and at the start of the seventies he was working inside the orchestra of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"52122d2a-5ff6-491a-9111-f1c279192b1c"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"There, in 1972, he recorded El Camino de los Amantes. The Venezuelan singer Felipe Pirela took the song up shortly afterwards and carried it across the continent, which is how his name first travelled: as an author, before anyone outside the country had heard him sing.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nueva Forma","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He belonged to the generation that turned Dominican song political after the dictatorship rather than during it. With ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre","occurrenceId":"e970adf2-2572-431d-8b7a-ba485abacead"}},{"text":" he founded Nueva Forma, a group working in the protest song of the seventies, and the two of them were on the bill of the festival Siete Días con el Pueblo in 1974.","type":"text"}]},{"type":"paragraph","content":[{"text":"He was also among the first Dominican musicians to travel to Cuba while the government forbade it. Álbum Rojo, Chile Vive and Neruda Raíz y Geografía came out of those years, and he kept returning to that material for the rest of his life: Verde y Negro, in 2007, was built entirely from songs about the people who fought for Dominican freedom.","type":"text"}]},{"type":"paragraph","content":[{"text":"He recorded shared albums with other Dominican musicians of the same conviction, En Son de Felicidad with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3a69af3c-1b9a-402b-8a3f-66e51dacdffe","displayText":"Francis Santana","occurrenceId":"ffdce1ef-c078-4e41-a882-163db8f73a21"}},{"text":" and Cara o Cruz with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1","displayText":"José Antonio Rodríguez","occurrenceId":"a1f0be30-98e1-4410-9b3f-b2f9fbf0ac16"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Mesita de Noche","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Inspiraciones appeared in 1990 and changed the standing of a whole genre. Bachata had been treated at home as music of the poor and the cantina; the record put it in a different register without softening it, and Mesita de Noche went out across Latin America and Spain. In 1993 the Premios Ondas named him the year’s revelation among Latin artists.","type":"text"}]},{"type":"paragraph","content":[{"text":"Albums followed through the nineties and two thousands: Tu Corazón, Un Chin de Veneno, Alma de Barrio, Cajita de Música and Pisando Rayas.","type":"text"}]},{"type":"paragraph","content":[{"text":"The songwriter","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Much of his catalogue reached the public in other people’s voices. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada","occurrenceId":"78cb5372-3c9b-438e-9dd7-0a2472e8c390"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez","occurrenceId":"2efe2b42-63e6-46ca-ad62-fd77ca6e500a"}},{"text":" recorded him at home, and abroad his songs were taken up by Celia Cruz, Marc Anthony, Dyango and Azúcar Moreno.","type":"text"}]},{"type":"paragraph","content":[{"text":"Bachata Entre Amigos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2006 he made Bachata Entre Amigos, produced by the guitarist ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8769e02a-52d7-4818-ac19-e5dd46d7075f","displayText":"Juan Francisco Ordóñez","occurrenceId":"f081767d-6122-4b1e-934e-2b1c3d64738d"}},{"text":". The record sets songs by Joan Manuel Serrat, Joaquín Sabina, Silvio Rodríguez and Fito Páez as bachatas, sung as duets with their authors, so that several of them heard their own work in the rhythm for the first time.","type":"text"}]},{"type":"paragraph","content":[{"text":"He died in Santo Domingo on 16 July 2020, at seventy-one.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'victor-victor'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Víctor José Víctor Rojas, que se presentaba como Víctor Víctor, fue un cantautor y guitarrista dominicano. Escribió Mesita de Noche, y el disco que la llevaba hizo más que ningún otro de su momento por sacar la bachata del margen de la música dominicana y ponerla en escenarios de afuera.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Pepines","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1948 en Los Pepines, barrio de Santiago de los Caballeros. Llegó a la música como percusionista y guitarrista antes que como cantante, y a principios de los setenta trabajaba dentro de la orquesta de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"eed7437a-8ea9-4600-968b-becca6be6e94"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Ahí grabó, en 1972, El Camino de los Amantes. El venezolano Felipe Pirela la tomó poco después y la llevó por el continente, y así fue como su nombre salió primero: como autor, antes de que nadie fuera del país lo hubiera oído cantar.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nueva Forma","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Pertenece a la generación que politizó la canción dominicana después de la dictadura y no durante ella. Con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre","occurrenceId":"08e95137-be82-4f55-abd2-7087207147ff"}},{"text":" fundó Nueva Forma, grupo de la canción protesta de los setenta, y los dos estuvieron en el cartel del festival Siete Días con el Pueblo en 1974.","type":"text"}]},{"type":"paragraph","content":[{"text":"Fue además de los primeros músicos dominicanos en viajar a Cuba mientras el gobierno lo prohibía. De esos años salieron Álbum Rojo, Chile Vive y Neruda Raíz y Geografía, y volvió a ese material toda su vida: Verde y Negro, de 2007, está armado entero con canciones sobre quienes pelearon por la libertad del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Grabó discos compartidos con otros músicos dominicanos de la misma convicción, En Son de Felicidad con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3a69af3c-1b9a-402b-8a3f-66e51dacdffe","displayText":"Francis Santana","occurrenceId":"eaf7f708-bd63-4b7a-837f-ca82e73fd46b"}},{"text":" y Cara o Cruz con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1","displayText":"José Antonio Rodríguez","occurrenceId":"10912a32-8f3d-4d5c-b835-1079972fe399"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Mesita de Noche","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Inspiraciones salió en 1990 y le cambió el estatus a un género entero. La bachata se trataba en el país como música de pobres y de cantina; el disco la puso en otro registro sin suavizarla, y Mesita de Noche salió por toda América Latina y España. En 1993 los Premios Ondas lo nombraron revelación del año entre los artistas latinos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Detrás vinieron discos a lo largo de los noventa y los dos mil: Tu Corazón, Un Chin de Veneno, Alma de Barrio, Cajita de Música y Pisando Rayas.","type":"text"}]},{"type":"paragraph","content":[{"text":"El compositor","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Buena parte de su catálogo llegó al público en voces ajenas. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada","occurrenceId":"17fdf573-42da-45b6-b276-ce7ea51b1abb"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez","occurrenceId":"f6622e9c-55b4-4c49-a812-e0f4b280609a"}},{"text":" lo grabaron en el país, y afuera tomaron sus canciones Celia Cruz, Marc Anthony, Dyango y Azúcar Moreno.","type":"text"}]},{"type":"paragraph","content":[{"text":"Bachata Entre Amigos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2006 hizo Bachata Entre Amigos, producido por el guitarrista ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8769e02a-52d7-4818-ac19-e5dd46d7075f","displayText":"Juan Francisco Ordóñez","occurrenceId":"398158f7-673a-4489-8721-ccb9680b2751"}},{"text":". El disco pone en bachata canciones de Joan Manuel Serrat, Joaquín Sabina, Silvio Rodríguez y Fito Páez, cantadas a dúo con sus autores, de modo que varios de ellos oyeron su propia obra en ese ritmo por primera vez.","type":"text"}]},{"type":"paragraph","content":[{"text":"Murió en Santo Domingo el 16 de julio de 2020, a los setenta y un años.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'victor-victor'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'en'), '2efe2b42-63e6-46ca-ad62-fd77ca6e500a', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'en'), '52122d2a-5ff6-491a-9111-f1c279192b1c', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'en'), '78cb5372-3c9b-438e-9dd7-0a2472e8c390', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'en'), 'a1f0be30-98e1-4410-9b3f-b2f9fbf0ac16', 'artist', '25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'en'), 'e970adf2-2572-431d-8b7a-ba485abacead', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'en'), 'f081767d-6122-4b1e-934e-2b1c3d64738d', 'artist', '8769e02a-52d7-4818-ac19-e5dd46d7075f');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'en'), 'ffdce1ef-c078-4e41-a882-163db8f73a21', 'artist', '3a69af3c-1b9a-402b-8a3f-66e51dacdffe');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'es'), '08e95137-be82-4f55-abd2-7087207147ff', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'es'), '10912a32-8f3d-4d5c-b835-1079972fe399', 'artist', '25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'es'), '17fdf573-42da-45b6-b276-ce7ea51b1abb', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'es'), '398158f7-673a-4489-8721-ccb9680b2751', 'artist', '8769e02a-52d7-4818-ac19-e5dd46d7075f');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'es'), 'eaf7f708-bd63-4b7a-837f-ca82e73fd46b', 'artist', '3a69af3c-1b9a-402b-8a3f-66e51dacdffe');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'es'), 'eed7437a-8ea9-4600-968b-becca6be6e94', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor') AND locale = 'es'), 'f6622e9c-55b4-4c49-a812-e0f4b280609a', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0');

COMMIT;
