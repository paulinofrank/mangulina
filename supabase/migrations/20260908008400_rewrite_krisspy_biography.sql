BEGIN;

-- Rewrite the catalogue entry for Krisspy.
--
-- Krisspy. VIGESIMA de las 211. 891 caracteres en UN parrafo, y es el caso mas
-- puro de "ensayo sobre el genero con un nombre encima" que llevo encontrado.
--
-- El texto entero hablaba de Santiago, del acordeon, de la tambora, de la guira
-- y de "the commercial pressures that have often favored more electrified and
-- internationally oriented sounds". SOBRE EL no decia NADA: ni una cancion, ni
-- un disco, ni un ano, ni el nombre de su grupo.
--
-- ---------------------------------------------------------------------------
-- EL GENERO ESTA MAL Y NO LO TOCO, PERO EL PROBLEMA ES MAS GRANDE QUE EL SUYO
--
-- La fila guarda `primary_genre = 'merengue'`. Todas las fuentes, empezando por
-- su propio canal, lo llaman "artista del merengue TIPICO", y el catalogo TIENE
-- el valor: `merengue-perico-ripiao`, con diecisiete filas.
--
-- Al comprobarlo aparecio que la asignacion esta REPARTIDA SIN CRITERIO:
--
--   merengue-perico-ripiao : El Rubio Acordeon, La India Canela, Guandulito,
--                            Agapito Pascual, El Prodigio, El Cieguito de
--                            Nagua, Maria Diaz, Raquel Arias...
--   merengue (generico)    : TATICO HENRIQUEZ, FEFITA LA GRANDE,
--                            RAFAELITO ROMAN, KRISSPY
--
-- Es decir: el padre del tipico moderno y la acordeonista viva mas conocida del
-- pais estan fichados como merengue a secas, y sus discipulos como perico
-- ripiao. NO ES UN ERROR DE UNA FILA: es una revision de genero que hay que
-- hacer entera y de una vez.
--
-- EL GENERO LO DECIDE EL EDITOR. No cambio nada; queda en CONFLICTOS_DE_DATO.md
-- junto al de Ramon Cordero.
-- ---------------------------------------------------------------------------
--
-- CONFLICTO DE ORIGEN, TAMBIEN SIN TOCAR: la fila y Wikidata -- esta con
-- referencia -- dicen SANTIAGO DE LOS CABALLEROS. Wikipedia en ingles dice
-- "Loma de Cabrera, Las Jagua", sin referencia y con aviso de falta de fuentes
-- desde 2018. Dos contra una, y la que pierde es la que no cita nada. La fila
-- se queda y el texto dice Santiago.
--
-- NO TIENE FECHA DE NACIMIENTO Y NO SE LA ENCONTRE. Ni ano. Se queda vacia
-- antes que estimarla.
--
-- LO QUE FALTABA, QUE ES TODO:
--
--   SU GRUPO SE LLAMA "KRISSPY Y SU BOMBAZO TIPICO", y con el aparecia en
--   television en 2004, en "Ustedes y Nosotros".
--
--   SEIS DISCOS: "El Bombazo Tipico" (2004, Allegro Productions), "Tipico Live"
--   (2004), "Yo Soy el Flow" (2006), "El Guto Ta Aqui" (2012), "Homenajes
--   Tipico" (2013) y "Palos Tipicos" (2016).
--
--   ES EL AUTOR DE "EL MAIZ", y asi lo presenta El Nuevo Diario: "el autor del
--   tema El maiz". Es su cancion.
--
--   EL DATO CON NUMEROS, que es el que le faltaba a la ficha: SU HOMENAJE A
--   SANDY REYES se mantuvo TREINTA Y CINCO SEMANAS en el numero uno del tipico,
--   y a la vez en los puestos dos y tres de la lista general de merengue. Lo
--   dijo el mismo en television en septiembre de 2017 y lo recogio El Nuevo
--   Diario. Sandy Reyes esta en el catalogo.
--
--   "MI ULTIMO DESEO", adaptacion de un tema mexicano, con video.
--
--   GRABO CON RAYMOND POZO Y MIGUEL CESPEDES, los comicos, un tema "de los
--   animales". Ninguno de los dos esta en el catalogo y NO LOS ANOTO como
--   ausencias: son actores de comedia, no musicos.
--
--   "YO SOY EL FLOW" no es solo un titulo de disco: es como se presenta. La
--   fila de su Instagram dice "El Artista de los Tipicos". Lo que hizo fue
--   poner la puesta en escena de un artista urbano encima de una musica de
--   acordeon, guira y tambora, y eso es lo que la ficha vieja intentaba decir
--   con "capacity to hold together its folk roots and its contemporary popular
--   presence".
--
-- LO QUE SE DEJA FUERA: la biografia que circula copiada y pegada por Facebook
-- —"a los dos anos de edad inclino su amor por la musica"— no tiene fuente
-- identificable y la reproducen tanto su propia pagina como decenas de grupos
-- de aficionados. No entra nada de ahi.
--
-- EL PROYECTO CON PENA SUAZO Y YIYO SARANTE SE DICE COMO LO QUE ES: en 2017
-- ANUNCIO que grabaria un merengue con uno y una salsa con el otro. No encontre
-- que ninguna de las dos saliera, asi que va como anuncio y no como obra.
--
-- aliases GANA "El Artista de los Tipicos". NO se anade "Krisspi", la variante
-- que trae Wikipedia en ingles: es una grafia suelta sin respaldo. Anotada.
--
-- krisspy.net NO SE GUARDA COMO WEB: redirige a su Instagram, que ya esta en la
-- fila. Un dominio que reenvia a una red social no es un sitio propio.
--
-- LAS TRES REDES DE LA FILA RESPONDEN.
--
-- SIETE ENLACES. Los tres primeros por credito documentado -- Sandy Reyes por
-- el homenaje, y Tatico Henriquez y Rafaelito Roman por el homenaje conjunto --
-- y cuatro por el concierto en el que fueron sus invitados.
--
-- FUENTES: El Nuevo Diario, 14 de septiembre de 2017, entrevista de Richard
-- Hernandez en "Novedades", que es la unica fuente periodistica con datos duros
-- que encontre. Wikipedia en ingles para la discografia, con aviso de falta de
-- referencias y con el origen descartado. Wikidata. Apple Music para el sello y
-- las pistas de "El Bombazo Tipico". NO HAY ARTICULO EN ESPANOL EN WIKIPEDIA.
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
       name = 'Krisspy',
       sort_name = 'Krisspy',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = NULL,
       birth_year = NULL,
       date_of_death = NULL,
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Juan',
       middle_name = NULL,
       last_name = 'de los Santos',
       second_last_name = NULL,
       stage_name = 'Krisspy',
       aliases = ARRAY['El Artista de los Típicos']::text[],
       occupations = '["composer","bandleader"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@Krisspy',
       facebook = 'krisspyflow',
       instagram = 'krisspyflow',
       disambiguation = 'Merengue típico singer and composer who fronts Krisspy y su Bombazo Típico',
       bio_en = 'Juan de los Santos, who performs as Krisspy, is a Dominican merengue típico singer and composer from Santiago de los Caballeros. He fronts the group Krisspy y su Bombazo Típico, bills himself as El Artista de los Típicos, and has spent his career presenting accordion music with the staging and manner of an urban act.

**El Bombazo Típico**

His first album, El Bombazo Típico, came out in 2004 on Allegro Productions and carried Chequeando, Las Mujeres de Ojos Grandes, La Paga and La Calambrina. A live record followed the same year, and the band was appearing on Dominican television with it by then. Yo Soy el Flow came in 2006, and after it El Guto Ta Aquí, Homenajes Típico and Palos Típicos.

The song most closely attached to him is El Maíz, which he wrote. Cuándo Volverás, El Gallo Mojao, Ojo Grande, El Pompo and Uno No Sabe Lo Que Tiene belong to the same run, and Mi Último Deseo, an adaptation of a Mexican song, was among his most played.

**Yo soy el flow**

The phrase he built the act on is the point of it. Merengue típico is accordion, güira and tambora, played by musicians who mostly present themselves as countrymen; Krisspy took that instrumentation and put an urban performer’s bearing on top of it, which is what brought him a younger audience than the genre usually reaches. He describes himself as versatile and records outside típico when it suits him.

**The tribute to Sandy Reyes**

His homage to Sandy Reyes, the veteran merengue singer, was the record that gave him his longest run: it held the top of the típico chart for thirty-five weeks and sat at two and three on the general merengue list at the same time.

He has kept up that line of work. With Rafaelito Román he recorded a tribute to Tatico Henríquez, the accordionist on whose playing the modern form of the genre is built, and he cut a novelty number with the comedians Raymond Pozo and Miguel Céspedes. In 2017 he announced a merengue with José Peña Suazo y La Banda Gorda and a salsa with the salsa singer Yiyo Sarante.

**Among the merengueros**

He belongs to the generation of típico players who came up after the genre had won its argument with respectable opinion, and he moves easily among the orchestra merengueros: Bonny Cepeda, Miriam Cruz and Yovanny Polanco have appeared as guests at his concerts.',
       bio_es = 'Juan de los Santos, que se presenta como Krisspy, es un cantante y compositor dominicano de merengue típico, de Santiago de los Caballeros. Encabeza el grupo Krisspy y su Bombazo Típico, se anuncia como El Artista de los Típicos, y ha pasado la carrera presentando música de acordeón con la puesta en escena y los modos de un artista urbano.

**El Bombazo Típico**

Su primer disco, El Bombazo Típico, salió en 2004 con Allegro Productions y traía Chequeando, Las Mujeres de Ojos Grandes, La Paga y La Calambrina. Ese mismo año publicó un disco en vivo, y para entonces el grupo ya salía en la televisión dominicana. Yo Soy el Flow llegó en 2006, y detrás El Guto Ta Aquí, Homenajes Típico y Palos Típicos.

La canción que más se le asocia es El Maíz, que es suya. Cuándo Volverás, El Gallo Mojao, Ojo Grande, El Pompo y Uno No Sabe Lo Que Tiene son de la misma tanda, y Mi Último Deseo, adaptación de un tema mexicano, estuvo entre las más puestas.

**Yo soy el flow**

La frase sobre la que armó el proyecto es de lo que se trata. El merengue típico es acordeón, güira y tambora, y lo tocan músicos que en su mayoría se presentan como hombres de campo; Krisspy tomó esa instrumentación y le puso encima el porte de un artista urbano, que es lo que le trajo un público más joven del que el género suele alcanzar. Se define versátil y graba fuera del típico cuando le conviene.

**El homenaje a Sandy Reyes**

Su homenaje a Sandy Reyes, el veterano del merengue, fue el disco que le dio su racha más larga: se mantuvo treinta y cinco semanas en el primer puesto de la lista de típico y a la vez en el segundo y el tercero de la lista general de merengue.

Ha seguido en esa línea. Con Rafaelito Román grabó un homenaje a Tatico Henríquez, el acordeonista sobre cuya manera de tocar se levanta la forma moderna del género, e hizo un tema de humor con los cómicos Raymond Pozo y Miguel Céspedes. En 2017 anunció un merengue con José Peña Suazo y La Banda Gorda y una salsa con el salsero Yiyo Sarante.

**Entre los merengueros**

Pertenece a la generación de tipiqueros que llegó cuando el género ya había ganado su discusión con la opinión respetable, y se mueve con soltura entre los merengueros de orquesta: Bonny Cepeda, Miriam Cruz y Yovanny Polanco han sido invitados en sus conciertos.',
       updated_at = now()
 WHERE slug = 'krisspy';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan de los Santos, who performs as Krisspy, is a Dominican merengue típico singer and composer from Santiago de los Caballeros. He fronts the group Krisspy y su Bombazo Típico, bills himself as El Artista de los Típicos, and has spent his career presenting accordion music with the staging and manner of an urban act.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Bombazo Típico","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His first album, El Bombazo Típico, came out in 2004 on Allegro Productions and carried Chequeando, Las Mujeres de Ojos Grandes, La Paga and La Calambrina. A live record followed the same year, and the band was appearing on Dominican television with it by then. Yo Soy el Flow came in 2006, and after it El Guto Ta Aquí, Homenajes Típico and Palos Típicos.","type":"text"}]},{"type":"paragraph","content":[{"text":"The song most closely attached to him is El Maíz, which he wrote. Cuándo Volverás, El Gallo Mojao, Ojo Grande, El Pompo and Uno No Sabe Lo Que Tiene belong to the same run, and Mi Último Deseo, an adaptation of a Mexican song, was among his most played.","type":"text"}]},{"type":"paragraph","content":[{"text":"Yo soy el flow","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The phrase he built the act on is the point of it. Merengue típico is accordion, güira and tambora, played by musicians who mostly present themselves as countrymen; Krisspy took that instrumentation and put an urban performer’s bearing on top of it, which is what brought him a younger audience than the genre usually reaches. He describes himself as versatile and records outside típico when it suits him.","type":"text"}]},{"type":"paragraph","content":[{"text":"The tribute to Sandy Reyes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His homage to ","type":"text"},{"type":"artistReference","attrs":{"artistId":"49f8aae7-e066-4b01-a836-126082163c52","displayText":"Sandy Reyes","occurrenceId":"4a15f945-eff8-4075-acab-7d770ba605c2"}},{"text":", the veteran merengue singer, was the record that gave him his longest run: it held the top of the típico chart for thirty-five weeks and sat at two and three on the general merengue list at the same time.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has kept up that line of work. With ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7a92e4df-157c-49d9-9905-17ac0f740c4e","displayText":"Rafaelito Román","occurrenceId":"e37203f6-9926-40d1-802d-ec0670936e20"}},{"text":" he recorded a tribute to ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9b15dfca-0f60-49b3-a139-100a5a329741","displayText":"Tatico Henríquez","occurrenceId":"1599f57f-b539-41d9-912a-d1246c117fc0"}},{"text":", the accordionist on whose playing the modern form of the genre is built, and he cut a novelty number with the comedians Raymond Pozo and Miguel Céspedes. In 2017 he announced a merengue with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"b41d4bd2-9303-4834-885e-e7dee35a0287","displayText":"José Peña Suazo y La Banda Gorda","occurrenceId":"e5433df4-14ce-437f-b134-42e5a1058225"}},{"text":" and a salsa with the salsa singer Yiyo Sarante.","type":"text"}]},{"type":"paragraph","content":[{"text":"Among the merengueros","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He belongs to the generation of típico players who came up after the genre had won its argument with respectable opinion, and he moves easily among the orchestra merengueros: ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc4db4c6-c96f-4eb7-af95-ac637785c5bf","displayText":"Bonny Cepeda","occurrenceId":"7a7031fe-079d-432d-8123-af844d934072"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz","occurrenceId":"2520c909-6d40-43df-9235-1a688b02a5b2"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"76c3c113-eea0-4dbd-8e71-c7dc6662c86c","displayText":"Yovanny Polanco","occurrenceId":"a69767e8-37cc-43d1-a59f-35b6ae94010f"}},{"text":" have appeared as guests at his concerts.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'krisspy'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan de los Santos, que se presenta como Krisspy, es un cantante y compositor dominicano de merengue típico, de Santiago de los Caballeros. Encabeza el grupo Krisspy y su Bombazo Típico, se anuncia como El Artista de los Típicos, y ha pasado la carrera presentando música de acordeón con la puesta en escena y los modos de un artista urbano.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Bombazo Típico","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su primer disco, El Bombazo Típico, salió en 2004 con Allegro Productions y traía Chequeando, Las Mujeres de Ojos Grandes, La Paga y La Calambrina. Ese mismo año publicó un disco en vivo, y para entonces el grupo ya salía en la televisión dominicana. Yo Soy el Flow llegó en 2006, y detrás El Guto Ta Aquí, Homenajes Típico y Palos Típicos.","type":"text"}]},{"type":"paragraph","content":[{"text":"La canción que más se le asocia es El Maíz, que es suya. Cuándo Volverás, El Gallo Mojao, Ojo Grande, El Pompo y Uno No Sabe Lo Que Tiene son de la misma tanda, y Mi Último Deseo, adaptación de un tema mexicano, estuvo entre las más puestas.","type":"text"}]},{"type":"paragraph","content":[{"text":"Yo soy el flow","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La frase sobre la que armó el proyecto es de lo que se trata. El merengue típico es acordeón, güira y tambora, y lo tocan músicos que en su mayoría se presentan como hombres de campo; Krisspy tomó esa instrumentación y le puso encima el porte de un artista urbano, que es lo que le trajo un público más joven del que el género suele alcanzar. Se define versátil y graba fuera del típico cuando le conviene.","type":"text"}]},{"type":"paragraph","content":[{"text":"El homenaje a Sandy Reyes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su homenaje a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"49f8aae7-e066-4b01-a836-126082163c52","displayText":"Sandy Reyes","occurrenceId":"e6d6473c-7d9d-4713-99da-61ffce93a06f"}},{"text":", el veterano del merengue, fue el disco que le dio su racha más larga: se mantuvo treinta y cinco semanas en el primer puesto de la lista de típico y a la vez en el segundo y el tercero de la lista general de merengue.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ha seguido en esa línea. Con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7a92e4df-157c-49d9-9905-17ac0f740c4e","displayText":"Rafaelito Román","occurrenceId":"2bcbb1fd-2349-4f9b-bdec-1b351aedc372"}},{"text":" grabó un homenaje a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9b15dfca-0f60-49b3-a139-100a5a329741","displayText":"Tatico Henríquez","occurrenceId":"15594bce-3307-401b-8dc6-45fb0aa8fde0"}},{"text":", el acordeonista sobre cuya manera de tocar se levanta la forma moderna del género, e hizo un tema de humor con los cómicos Raymond Pozo y Miguel Céspedes. En 2017 anunció un merengue con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"b41d4bd2-9303-4834-885e-e7dee35a0287","displayText":"José Peña Suazo y La Banda Gorda","occurrenceId":"3150f699-5211-4e43-9507-6860bb1e5791"}},{"text":" y una salsa con el salsero Yiyo Sarante.","type":"text"}]},{"type":"paragraph","content":[{"text":"Entre los merengueros","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Pertenece a la generación de tipiqueros que llegó cuando el género ya había ganado su discusión con la opinión respetable, y se mueve con soltura entre los merengueros de orquesta: ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc4db4c6-c96f-4eb7-af95-ac637785c5bf","displayText":"Bonny Cepeda","occurrenceId":"ef911fa0-0548-4bc9-8a09-2c6fc735090a"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz","occurrenceId":"9eb02c54-e745-4049-9840-3591dec77c2d"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"76c3c113-eea0-4dbd-8e71-c7dc6662c86c","displayText":"Yovanny Polanco","occurrenceId":"7df65e95-dc74-4caf-97a4-227fe8c5041a"}},{"text":" han sido invitados en sus conciertos.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'krisspy'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'en'), '1599f57f-b539-41d9-912a-d1246c117fc0', 'artist', '9b15dfca-0f60-49b3-a139-100a5a329741');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'en'), '2520c909-6d40-43df-9235-1a688b02a5b2', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'en'), '4a15f945-eff8-4075-acab-7d770ba605c2', 'artist', '49f8aae7-e066-4b01-a836-126082163c52');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'en'), '7a7031fe-079d-432d-8123-af844d934072', 'artist', 'bc4db4c6-c96f-4eb7-af95-ac637785c5bf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'en'), 'a69767e8-37cc-43d1-a59f-35b6ae94010f', 'artist', '76c3c113-eea0-4dbd-8e71-c7dc6662c86c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'en'), 'e37203f6-9926-40d1-802d-ec0670936e20', 'artist', '7a92e4df-157c-49d9-9905-17ac0f740c4e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'en'), 'e5433df4-14ce-437f-b134-42e5a1058225', 'artist', 'b41d4bd2-9303-4834-885e-e7dee35a0287');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'es'), '15594bce-3307-401b-8dc6-45fb0aa8fde0', 'artist', '9b15dfca-0f60-49b3-a139-100a5a329741');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'es'), '2bcbb1fd-2349-4f9b-bdec-1b351aedc372', 'artist', '7a92e4df-157c-49d9-9905-17ac0f740c4e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'es'), '3150f699-5211-4e43-9507-6860bb1e5791', 'artist', 'b41d4bd2-9303-4834-885e-e7dee35a0287');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'es'), '7df65e95-dc74-4caf-97a4-227fe8c5041a', 'artist', '76c3c113-eea0-4dbd-8e71-c7dc6662c86c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'es'), '9eb02c54-e745-4049-9840-3591dec77c2d', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'es'), 'e6d6473c-7d9d-4713-99da-61ffce93a06f', 'artist', '49f8aae7-e066-4b01-a836-126082163c52');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'krisspy') AND locale = 'es'), 'ef911fa0-0548-4bc9-8a09-2c6fc735090a', 'artist', 'bc4db4c6-c96f-4eb7-af95-ac637785c5bf');

COMMIT;
