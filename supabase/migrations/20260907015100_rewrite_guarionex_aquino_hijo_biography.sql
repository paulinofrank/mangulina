BEGIN;

-- Rewrite the catalogue entry for Guarionex Aquino Hijo.
--
-- Guarionex Aquino Hijo. DECIMOSEXTA Y ÚLTIMA de las fichas publicadas que
-- estaban EN BLANCO. Es el HIJO del barítono, cuya ficha acabo de escribir.
--
-- EL NOMBRE DE LA FILA ES UNA DECISIÓN NUESTRA, NO SUYA. Todas las fuentes lo
-- llaman simplemente "Guarionex Aquino"; el "Hijo" es el desambiguador que el
-- catálogo necesitaba para no confundirlo con su padre. Lo dejo como está
-- porque cambiarlo movería el slug y la URL, PERO QUEDA ANOTADO: si el editor
-- prefiere otra forma de distinguirlos -- por ejemplo el nombre a secas más un
-- disambiguation -- esta es la fila.
--
-- LO QUE YA TENÍA SE CONFIRMA: 1 de junio de 1954, Santa Cruz de Mao, Valverde;
-- percusionista; instruments con bongos, drums, congas y tambora. La entrevista
-- confirma que la TAMBORA fue su primer instrumento.
--
-- LA FUENTE ES UNA ENTREVISTA DIRECTA, que es lo mejor que se puede tener:
-- Glenda Galán para dominicanaenmiami.com, con motivo del homenaje que le hizo
-- el South Florida Dominican Jazz Festival de 2014. Habla él.
--
-- TRES ENLACES, TODOS EN SUS PROPIAS PALABRAS:
--
--   michel-camilo -- lo llama "mi padrino de carrera", y con él tocó por
--   primera vez fuera del país, en Suiza, con una delegación dominicana. Además
--   Grokipedia lo acredita en la percusión de la banda sonora de "Two Much",
--   compuesta por Camilo. NOTA: es la misma ficha de Michel Camilo a la que hoy
--   le dejé el YouTube en NULL por estar muerto el handle.
--
--   julio-alberto-hernandez -- cuando le preguntan por una presentación
--   especial, responde que tocar con su papá a los nueve años, con Julio
--   Alberto Hernández al piano, un villancico de Navidad. Es el mismo
--   compositor cuyas canciones grababa su padre.
--
--   guarionex-aquino-reyes -- su padre. Con esto las dos fichas quedan
--   enlazadas y el lector puede distinguirlas.
--
-- SE MENCIONA EL PARENTESCO Y ES LA EXCEPCIÓN JUSTIFICADA a la regla de vida
-- privada: hay dos artistas con el mismo nombre en este catálogo, y no
-- distinguirlos crearía un error de identidad, que es peor. Se dice lo mínimo.
--
-- NO SE ATRIBUYEN AL HIJO LOS CRÉDITOS DE CINE SIN MÁS. Grokipedia mete los de
-- "Two Much", "The Lost City" y "Veneno" DENTRO DE LA FICHA DEL PADRE, que era
-- barítono y llevaba muerto ocho años cuando salió la última. Es una confusión
-- de la fuente, no un dato. Se escribe solo lo de "Two Much", que ella misma
-- detalla con los músicos acompañantes y que encaja con un percusionista.
--
-- PERCUTRONIC es su proyecto actual según la entrevista: trío de percusión con
-- Edgar Molina y Felle Vega. Ninguno de los dos está en el catálogo, ni el
-- trío, ni la agrupación Jazz 4+1 por la que también se le pregunta.
--
-- primary_genre fusion SE QUEDA. Trabaja jazz con folklore dominicano y él
-- mismo describe su paleta como el folklore y la campiña; fusion es la etiqueta
-- de nivel 0 que le corresponde.
--
-- FUENTES: entrevista de Glenda Galán en dominicanaenmiami.com. Grokipedia para
-- el crédito de "Two Much", con la reserva anotada arriba.
--
-- NOMBRES NUEVOS PARA LA LISTA: Edgar Molina y Felle Vega, sus socios en
-- Percutronic; el propio trío Percutronic; y la agrupación Jazz 4+1.
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
       name = 'Guarionex Aquino Hijo',
       sort_name = 'Aquino, Guarionex',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'musician',
       primary_genre = 'fusion',
       date_of_birth = '1954-06-01',
       birth_year = 1954,
       date_of_death = NULL,
       birth_place = 'Santa Cruz de Mao',
       province = 'Valverde',
       first_name = 'Guarionex',
       middle_name = NULL,
       last_name = 'Aquino',
       second_last_name = NULL,
       stage_name = 'Guarionex Aquino',
       aliases = ARRAY[]::text[],
       occupations = '["percussionist"]'::jsonb,
       instruments = ARRAY['bongos', 'drums', 'congas', 'tambora']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Jazz percussionist; son of the baritone of the same name',
       bio_en = 'Guarionex Aquino is a Dominican percussionist who works in jazz and in the fusion of jazz with Dominican folk rhythms. He is the son of Guarionex Aquino Reyes, the baritone of the same name, and is distinguished from him by the instrument: the father sang, the son plays.

**The rehearsals**

He was born in Santa Cruz de Mao, in Valverde, in 1954. He has said that his interest began by watching his father’s rehearsals as a small child, and that the musicians in those orchestras struck him as supernatural. The first instrument he played was the tambora.

The performance he names as the one he remembers above others is early: playing beside his father at the age of nine, with Julio Alberto Hernández at the piano, on a Christmas carol.

**Michel Camilo**

He calls Michel Camilo the godfather of his career. His first performance outside the country was in Switzerland with Camilo, as part of a Dominican delegation, and he played percussion on the film soundtrack Camilo composed for Two Much, alongside a group of Caribbean and North American players.

**The palette**

He describes his own approach in visual terms, choosing the instruments he needs to paint the countryside, the green and the folklore he comes from, and he names the tumbadora as the sound that means the Caribbean to him. Asked whether any genre fails to interest him, he has answered that all of them do.

**Percutronic**

He was honoured at the South Florida Dominican Jazz Festival in 2014, at an edition dedicated to him. He has since worked in Percutronic, a percussion trio, and continues to appear as a sideman, a role he describes as a matter of restraint, colour and dynamics.',
       bio_es = 'Guarionex Aquino es un percusionista dominicano que trabaja el jazz y la fusión del jazz con los ritmos folclóricos dominicanos. Es hijo de Guarionex Aquino Reyes, el barítono del mismo nombre, y se distingue de él por el instrumento: el padre cantaba, el hijo toca.

**Los ensayos**

Nació en Santa Cruz de Mao, en Valverde, en 1954. Ha contado que su interés empezó viendo los ensayos de su padre siendo muy niño, y que los músicos de aquellas orquestas le parecían sobrenaturales. El primer instrumento que tocó fue la tambora.

La presentación que nombra como la que más recuerda es temprana: tocar junto a su padre a los nueve años, con Julio Alberto Hernández al piano, un villancico de Navidad.

**Michel Camilo**

A Michel Camilo lo llama el padrino de su carrera. Su primera presentación fuera del país fue en Suiza junto a él, con una delegación dominicana, y tocó la percusión en la banda sonora que Camilo compuso para la película Two Much, acompañado por un grupo de músicos caribeños y norteamericanos.

**La paleta**

Describe su propio trabajo en términos visuales: escoge los instrumentos que necesita para pintar su campiña, su verde y el folklore del que viene, y nombra la tumbadora como el sonido que le significa el Caribe. Preguntado por si algún género no le interesa, ha respondido que todos le interesan.

**Percutronic**

Fue homenajeado en el South Florida Dominican Jazz Festival de 2014, en una edición dedicada a él. Desde entonces ha trabajado en Percutronic, un trío de percusión, y sigue presentándose como acompañante, oficio que describe como una cuestión de mesura, colores y dinámica.',
       updated_at = now()
 WHERE slug = 'guarionex-aquino-hijo';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-hijo')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-hijo')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Guarionex Aquino is a Dominican percussionist who works in jazz and in the fusion of jazz with Dominican folk rhythms. He is the son of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2d8316d2-1e25-4b42-a44e-873ec1711672","displayText":"Guarionex Aquino Reyes","occurrenceId":"f6eef508-c284-433a-a466-8e92f0be9dbd"}},{"text":", the baritone of the same name, and is distinguished from him by the instrument: the father sang, the son plays.","type":"text"}]},{"type":"paragraph","content":[{"text":"The rehearsals","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Santa Cruz de Mao, in Valverde, in 1954. He has said that his interest began by watching his father’s rehearsals as a small child, and that the musicians in those orchestras struck him as supernatural. The first instrument he played was the tambora.","type":"text"}]},{"type":"paragraph","content":[{"text":"The performance he names as the one he remembers above others is early: playing beside his father at the age of nine, with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0e61046c-e96d-400b-819c-f9de8cbacba1","displayText":"Julio Alberto Hernández","occurrenceId":"76388489-b4b5-4846-ae14-11431a856359"}},{"text":" at the piano, on a Christmas carol.","type":"text"}]},{"type":"paragraph","content":[{"text":"Michel Camilo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He calls ","type":"text"},{"type":"artistReference","attrs":{"artistId":"da791d26-8bab-45e4-b7d1-f09314869f09","displayText":"Michel Camilo","occurrenceId":"97be9c37-7d51-4a96-8cef-72c6829638a7"}},{"text":" the godfather of his career. His first performance outside the country was in Switzerland with Camilo, as part of a Dominican delegation, and he played percussion on the film soundtrack Camilo composed for Two Much, alongside a group of Caribbean and North American players.","type":"text"}]},{"type":"paragraph","content":[{"text":"The palette","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He describes his own approach in visual terms, choosing the instruments he needs to paint the countryside, the green and the folklore he comes from, and he names the tumbadora as the sound that means the Caribbean to him. Asked whether any genre fails to interest him, he has answered that all of them do.","type":"text"}]},{"type":"paragraph","content":[{"text":"Percutronic","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was honoured at the South Florida Dominican Jazz Festival in 2014, at an edition dedicated to him. He has since worked in Percutronic, a percussion trio, and continues to appear as a sideman, a role he describes as a matter of restraint, colour and dynamics.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'guarionex-aquino-hijo'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Guarionex Aquino es un percusionista dominicano que trabaja el jazz y la fusión del jazz con los ritmos folclóricos dominicanos. Es hijo de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2d8316d2-1e25-4b42-a44e-873ec1711672","displayText":"Guarionex Aquino Reyes","occurrenceId":"c4e510f1-9b71-4ee0-8806-0e2cafd4f214"}},{"text":", el barítono del mismo nombre, y se distingue de él por el instrumento: el padre cantaba, el hijo toca.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los ensayos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santa Cruz de Mao, en Valverde, en 1954. Ha contado que su interés empezó viendo los ensayos de su padre siendo muy niño, y que los músicos de aquellas orquestas le parecían sobrenaturales. El primer instrumento que tocó fue la tambora.","type":"text"}]},{"type":"paragraph","content":[{"text":"La presentación que nombra como la que más recuerda es temprana: tocar junto a su padre a los nueve años, con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0e61046c-e96d-400b-819c-f9de8cbacba1","displayText":"Julio Alberto Hernández","occurrenceId":"c2c80077-8934-4242-997e-4a62a66c0745"}},{"text":" al piano, un villancico de Navidad.","type":"text"}]},{"type":"paragraph","content":[{"text":"Michel Camilo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A ","type":"text"},{"type":"artistReference","attrs":{"artistId":"da791d26-8bab-45e4-b7d1-f09314869f09","displayText":"Michel Camilo","occurrenceId":"dd4426a0-5fa9-4e63-b6a0-b9e8ad3ccb88"}},{"text":" lo llama el padrino de su carrera. Su primera presentación fuera del país fue en Suiza junto a él, con una delegación dominicana, y tocó la percusión en la banda sonora que Camilo compuso para la película Two Much, acompañado por un grupo de músicos caribeños y norteamericanos.","type":"text"}]},{"type":"paragraph","content":[{"text":"La paleta","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Describe su propio trabajo en términos visuales: escoge los instrumentos que necesita para pintar su campiña, su verde y el folklore del que viene, y nombra la tumbadora como el sonido que le significa el Caribe. Preguntado por si algún género no le interesa, ha respondido que todos le interesan.","type":"text"}]},{"type":"paragraph","content":[{"text":"Percutronic","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Fue homenajeado en el South Florida Dominican Jazz Festival de 2014, en una edición dedicada a él. Desde entonces ha trabajado en Percutronic, un trío de percusión, y sigue presentándose como acompañante, oficio que describe como una cuestión de mesura, colores y dinámica.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'guarionex-aquino-hijo'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-hijo') AND locale = 'en'), '76388489-b4b5-4846-ae14-11431a856359', 'artist', '0e61046c-e96d-400b-819c-f9de8cbacba1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-hijo') AND locale = 'en'), '97be9c37-7d51-4a96-8cef-72c6829638a7', 'artist', 'da791d26-8bab-45e4-b7d1-f09314869f09');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-hijo') AND locale = 'en'), 'f6eef508-c284-433a-a466-8e92f0be9dbd', 'artist', '2d8316d2-1e25-4b42-a44e-873ec1711672');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-hijo') AND locale = 'es'), 'c2c80077-8934-4242-997e-4a62a66c0745', 'artist', '0e61046c-e96d-400b-819c-f9de8cbacba1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-hijo') AND locale = 'es'), 'c4e510f1-9b71-4ee0-8806-0e2cafd4f214', 'artist', '2d8316d2-1e25-4b42-a44e-873ec1711672');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-hijo') AND locale = 'es'), 'dd4426a0-5fa9-4e63-b6a0-b9e8ad3ccb88', 'artist', 'da791d26-8bab-45e4-b7d1-f09314869f09');

COMMIT;
