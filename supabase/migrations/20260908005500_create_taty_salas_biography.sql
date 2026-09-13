BEGIN;

-- Create the catalogue entry for Taty Salas.
--
-- Taty Salas. FICHA NUEVA, a petición del editor. Salió hace un rato al
-- escribir a Jorge Taveras, entre los artistas para los que él produjo.
--
-- COMPROBADO ANTES DE CREAR, con '%tati%' y '%salas%' contra name, slug y
-- aliases: UNA sola coincidencia en todo el catálogo, tatico-henriquez, que
-- obviamente no es ella. No estaba.
--
-- ---------------------------------------------------------------------------
-- FICHA CORTA Y HONESTA SOBRE LO QUE NO SÉ
--
-- Esta es de las fichas más difíciles de la corrida, no por complicada sino por
-- escasa. NO HAY artículo de Wikipedia, NO HAY ficha en BuenaMusica, y NO
-- ENCONTRÉ ni su nombre legal, ni fecha de nacimiento, ni lugar. Los campos se
-- quedan vacíos en vez de rellenarse con suposiciones.
--
-- TAMPOCO SÉ SI VIVE, y por eso `ended` queda en NULL y no en false. Poner false
-- afirmaría que está viva, y en este catálogo ese campo significa eso. La única
-- fuente reciente habla de ella en presente, pero eso no es prueba. Es
-- exactamente el caso contrario al de Rafael Solano esta mañana, donde el campo
-- también estaba en NULL pero yo SÍ pude comprobar que vive y por eso lo llené.
-- ---------------------------------------------------------------------------
--
-- LO QUE SÍ ESTÁ DOCUMENTADO Y SOSTIENE LA FICHA:
--
--   REPRESENTÓ A LA REPÚBLICA DOMINICANA EN EL FESTIVAL OTI DE LA CANCIÓN DOS
--   VECES, en 1983 con "OLVIDAR, OLVIDAR" y en 1988 con "DE TU BOCA". Las dos
--   participaciones están registradas por el archivo de aficionados del festival
--   y las dos actuaciones circulan en video con esos títulos.
--
--   ESO LA CONECTA CON JORGE TAVERAS de dos maneras distintas y ambas
--   documentadas: él produjo para ella, y él fue director, arreglista y
--   compositor en los festivales OTI. Escribí su ficha hace una hora.
--
--   CANTÓ EN "EL SHOW DEL MEDIODÍA" Y EN "FIESTA", los programas donde se hacía
--   la carrera de un baladista dominicano en esos años. El Show del Mediodía es
--   el programa que creó Rafael Solano, de ahí el segundo enlace.
--
--   "CIUDAD CORAZÓN" es otra de sus canciones, y existe una recopilación suya
--   de veinte éxitos.
--
-- LA GRAFÍA DEL NOMBRE: name va como "TATY SALAS" y "Tati Salas" a aliases. Las
-- fuentes musicales -- los videos del archivo OTI, la recopilación, el club de
-- aficionados del festival -- escriben Taty con Y. La fuente que me la trajo,
-- Diario Libre citando a Fausto Polanco sobre Jorge Taveras, escribe Tati con I.
-- El club del OTI dice expresamente "también conocida como Tati Salas". Se
-- guardan las dos y queda anotado para el proceso de ortografía.
--
-- UNA OBSERVACIÓN QUE NO ESCRIBO EN LA BIO PERO SÍ AQUÍ. El video del Show del
-- Mediodía viene acompañado de un comentario del canal que se queja de que estas
-- voces románticas están hoy fuera de la radio dominicana. Es opinión de un
-- tercero sobre la programación radial, no un hecho sobre ella, y no entra.
--
-- DOS ENLACES: jorge-taveras, que produjo para ella y dirigió en los festivales
-- OTI, y rafael-solano, creador de El Show del Mediodía.
--
-- FUENTES: el club de aficionados del Festival OTI de la Canción, que la lista
-- como participante dominicana en 1983 y 1988 y da su descripción como
-- baladista popular en los ochenta y noventa. Los títulos de los videos de
-- archivo del propio festival, que dan las dos canciones. Diario Libre, 3 de
-- diciembre de 2021, citando la biografía de Jorge Taveras escrita por Fausto
-- Polanco, para el crédito de producción.
--
-- QUEDA PENDIENTE: nombre legal, fecha y lugar de nacimiento, discografía con
-- años, y si vive. Cualquiera de esas cosas mejora esta ficha bastante.
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
       name = 'Taty Salas',
       sort_name = 'Salas, Taty',
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = NULL,
       primary_role = 'singer',
       primary_genre = 'ballads',
       date_of_birth = NULL,
       birth_year = NULL,
       date_of_death = NULL,
       birth_place = NULL,
       province = NULL,
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = 'Taty Salas',
       aliases = ARRAY['Tati Salas']::text[],
       occupations = NULL,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Balada singer who represented the Dominican Republic twice at the OTI song festival',
       bio_en = 'Taty Salas is a Dominican balada singer who was widely heard through the eighties and nineties. She represented the Dominican Republic twice at the OTI song festival, which in those years was the main route by which a Spanish-language singer reached an audience outside their own country.

**The OTI festival**

She sang for the country at the OTI festival in 1983, with Olvidar, Olvidar, and again in 1988, with De Tu Boca. Two appearances is unusual: most countries sent a different performer each year, and being chosen twice across five years indicates the standing she had at home.

The festival connects her to Jorge Taveras twice over. He worked as director, arranger and composer at the OTI festivals, and he also produced records for her.

**Television**

The rest of her career ran through Dominican television, which is where a romantic singer of that generation built an audience. She appeared regularly on Fiesta and on El Show del Mediodía, the programme Rafael Solano had created, singing her own material. Ciudad Corazón is among the songs from those years, and a twenty-track collection of her hits circulates.',
       bio_es = 'Taty Salas es una cantante dominicana de balada que se oyó mucho a lo largo de los ochenta y los noventa. Representó dos veces a la República Dominicana en el Festival OTI de la Canción, que en esos años era la vía principal por la que un cantante en español llegaba a un público fuera de su propio país.

**El Festival OTI**

Cantó por el país en el Festival OTI de 1983, con Olvidar, Olvidar, y otra vez en 1988, con De Tu Boca. Dos participaciones no es lo común: casi todos los países mandaban un intérprete distinto cada año, y que la escogieran dos veces en cinco indica el lugar que ocupaba en casa.

El festival la conecta con Jorge Taveras por partida doble. Él trabajó como director, arreglista y compositor en los festivales OTI, y produjo además discos para ella.

**La televisión**

El resto de su carrera pasó por la televisión dominicana, que era donde un cantante romántico de esa generación se hacía el público. Se presentaba con regularidad en Fiesta y en El Show del Mediodía, el programa que había creado Rafael Solano, cantando su propio material. Ciudad Corazón está entre las canciones de esos años, y circula una recopilación suya de veinte éxitos.',
       updated_at = now()
 WHERE slug = 'taty-salas';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'taty-salas')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'taty-salas')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Taty Salas is a Dominican balada singer who was widely heard through the eighties and nineties. She represented the Dominican Republic twice at the OTI song festival, which in those years was the main route by which a Spanish-language singer reached an audience outside their own country.","type":"text"}]},{"type":"paragraph","content":[{"text":"The OTI festival","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She sang for the country at the OTI festival in 1983, with Olvidar, Olvidar, and again in 1988, with De Tu Boca. Two appearances is unusual: most countries sent a different performer each year, and being chosen twice across five years indicates the standing she had at home.","type":"text"}]},{"type":"paragraph","content":[{"text":"The festival connects her to ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c958758c-a949-4bd9-963d-6d48bc750b60","displayText":"Jorge Taveras","occurrenceId":"59d9689d-3a97-4eb2-a912-332f8062c240"}},{"text":" twice over. He worked as director, arranger and composer at the OTI festivals, and he also produced records for her.","type":"text"}]},{"type":"paragraph","content":[{"text":"Television","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The rest of her career ran through Dominican television, which is where a romantic singer of that generation built an audience. She appeared regularly on Fiesta and on El Show del Mediodía, the programme ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"ac62c876-f657-4857-9a1d-b6cc1818256b"}},{"text":" had created, singing her own material. Ciudad Corazón is among the songs from those years, and a twenty-track collection of her hits circulates.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'taty-salas'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Taty Salas es una cantante dominicana de balada que se oyó mucho a lo largo de los ochenta y los noventa. Representó dos veces a la República Dominicana en el Festival OTI de la Canción, que en esos años era la vía principal por la que un cantante en español llegaba a un público fuera de su propio país.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Festival OTI","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Cantó por el país en el Festival OTI de 1983, con Olvidar, Olvidar, y otra vez en 1988, con De Tu Boca. Dos participaciones no es lo común: casi todos los países mandaban un intérprete distinto cada año, y que la escogieran dos veces en cinco indica el lugar que ocupaba en casa.","type":"text"}]},{"type":"paragraph","content":[{"text":"El festival la conecta con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c958758c-a949-4bd9-963d-6d48bc750b60","displayText":"Jorge Taveras","occurrenceId":"d4fb8081-319a-4d3e-970c-aa67d09df6eb"}},{"text":" por partida doble. Él trabajó como director, arreglista y compositor en los festivales OTI, y produjo además discos para ella.","type":"text"}]},{"type":"paragraph","content":[{"text":"La televisión","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El resto de su carrera pasó por la televisión dominicana, que era donde un cantante romántico de esa generación se hacía el público. Se presentaba con regularidad en Fiesta y en El Show del Mediodía, el programa que había creado ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"8c527624-0ee5-42d6-8b6d-89d4a092e20b"}},{"text":", cantando su propio material. Ciudad Corazón está entre las canciones de esos años, y circula una recopilación suya de veinte éxitos.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'taty-salas'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'taty-salas') AND locale = 'en'), '59d9689d-3a97-4eb2-a912-332f8062c240', 'artist', 'c958758c-a949-4bd9-963d-6d48bc750b60');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'taty-salas') AND locale = 'en'), 'ac62c876-f657-4857-9a1d-b6cc1818256b', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'taty-salas') AND locale = 'es'), '8c527624-0ee5-42d6-8b6d-89d4a092e20b', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'taty-salas') AND locale = 'es'), 'd4fb8081-319a-4d3e-970c-aa67d09df6eb', 'artist', 'c958758c-a949-4bd9-963d-6d48bc750b60');

COMMIT;
