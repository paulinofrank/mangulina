BEGIN;

-- Rewrite the catalogue entry for Monchy Capricho.
--
-- Monchy Capricho. Decimotercera de las dieciséis fichas publicadas que estaban
-- EN BLANCO. Ya estaba enlazado desde la ficha de Tulile, que tocó en su
-- orquesta, así que este enlace cierra el circuito por los dos lados.
--
-- LO QUE YA TENÍA LA FILA SE CONFIRMA: 6 de julio de 1969. Coinciden Conectate,
-- República Merengue y el blog biográfico.
--
-- SE COMPLETA EL NOMBRE: RAMÓN ANTONIO JAVIER DEMORIZI. Javier es apellido
-- paterno y Demorizi materno.
--
-- SE AÑADE EL LUGAR DE NACIMIENTO, QUE ESTABA VACÍO, Y CON UN MATIZ. Conectate
-- lo llama "oriundo de Sabana de la Mar", pero dos fuentes más precisas
-- -- República Merengue y el blog -- coinciden en que NACIÓ EN SANTO DOMINGO y
-- que a los tres meses sus padres lo llevaron a Sabana de la Mar, donde se
-- crió. Se guarda Santo Domingo como lugar de nacimiento, que es el dato del
-- campo, y la crianza en Sabana de la Mar va en la prosa, que es donde se puede
-- explicar la diferencia.
--
-- TRES ENLACES: tulile, que fue contratado por su orquesta antes de ser
-- solista; sergio-vargas y ray-polanco, con quienes ha compartido escenario en
-- los espectáculos de aniversario y en la big band de merengue clásico.
--
-- NO SE ENLAZA "DARY DARY", que Conectate menciona como invitado del
-- espectáculo de 2010. En la base hay un "Dary Hezz" y NO SON EL MISMO NOMBRE.
-- Enlazar por parecido sería inventar una identidad.
--
-- EL GRUPO MERMELADA NO ESTÁ EN EL CATÁLOGO y es una ausencia grande: fue la
-- respuesta dominicana a Menudo y a Los Chamos, y de ahí salió él. Va a la
-- lista de faltantes.
--
-- EL RETIRO DE DIEZ AÑOS SÍ ENTRA. Él lo atribuyó al incumplimiento
-- promocional de su disquera. No es vida privada ni asunto penal: es una
-- disputa de negocio que explica un hueco de una década en su discografía, y un
-- catálogo de música existe justamente para explicar esos huecos. Se escribe
-- atribuido a él, que es como lo dice la fuente.
--
-- SU ORQUESTA ES OTRA ENTIDAD. AllMusic lo lista como "Monchy Capricho &
-- Orquesta Capricho". Esta fila es LA PERSONA y está bien tipada como
-- solo_artist; la Orquesta Capricho podría tener ficha propia. Se anota para el
-- trabajo de separación de personas y agrupaciones que el editor marcó.
--
-- LOS HANDLES YA ESTABAN Y NO SE TOCAN: youtube @monchycaprichooficial,
-- instagram monchycapricho, facebook monchycapricho.6.
--
-- FUENTES: Conectate.com.do, 6 de julio de 2023. República Merengue y el blog
-- monchycapricho.blogspot.com para el nombre completo y el nacimiento. Listín
-- USA, 17 de agosto de 2026, para su actividad actual.
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
       name = 'Monchy Capricho',
       sort_name = 'Javier Demorizi, Ramón Antonio',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue-orquesta',
       date_of_birth = '1969-07-06',
       birth_year = 1969,
       date_of_death = NULL,
       birth_place = 'Santo Domingo',
       province = 'Santo Domingo',
       first_name = 'Ramón',
       middle_name = 'Antonio',
       last_name = 'Javier',
       second_last_name = 'Demorizi',
       stage_name = 'Monchy Capricho',
       aliases = ARRAY[]::text[],
       occupations = '["bandleader"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@monchycaprichooficial',
       facebook = 'monchycapricho.6',
       instagram = 'monchycapricho',
       disambiguation = 'Merengue singer and bandleader; a teen idol of the late eighties who led Orquesta Capricho',
       bio_en = 'Ramón Antonio Javier Demorizi, known as Monchy Capricho, is a Dominican merengue singer and bandleader. He was one of the teen idols of the late eighties and early nineties, first with a youth band and then at the head of his own orchestra.

**Sabana de la Mar**

He was born in Santo Domingo in 1969 and was taken to Sabana de la Mar at three months old. That is the town he grew up in and the one he names as his own.

**Mermelada**

He became known with Mermelada, a youth group assembled as the Dominican answer to the boy bands then filling stadiums across Latin America, Menudo in Puerto Rico and Los Chamos in Venezuela among them. Robot, Angelito and Marielena are the songs from those years that stayed with the audience.

**Orquesta Capricho**

At the end of the eighties he left the group to form a merengue orchestra of his own, and the move worked. Adolescente, Chiquilla Malcriada, Nuestro Amor, Volvamos a Vivir, Siervo de Amor and Rodando come from that period, which is when his name reached its widest audience.

The orchestra was also a school for younger players. Tulile was hired into it as a saxophonist years before recording under his own name.

**Ten years away**

He then disappeared from the radio and from the stage for about a decade. He has attributed the absence to his record company, which he says failed to promote the material it had released, and has described the retirement as one he did not choose.

**The return**

He came back to the country in 2008 after years living in the United States, and in 2010 staged a concert marking twenty-three years of work, with Sergio Vargas among the guests. Mátala followed, and in 2013 he released a merengue reading of a song by the Spanish composer Manuel Alejandro.

He has kept working since. He appears in the big band programmes devoted to the golden years of merengue, alongside Ray Polanco and other singers of his generation.',
       bio_es = 'Ramón Antonio Javier Demorizi, conocido como Monchy Capricho, es un cantante y director de orquesta de merengue dominicano. Fue uno de los ídolos juveniles de finales de los ochenta y principios de los noventa, primero con una agrupación juvenil y después al frente de su propia orquesta.

**Sabana de la Mar**

Nació en Santo Domingo en 1969 y a los tres meses lo llevaron a Sabana de la Mar. Ese es el pueblo donde se crió y el que nombra como suyo.

**Mermelada**

Se dio a conocer con Mermelada, un grupo juvenil armado como la respuesta dominicana a las bandas de muchachos que entonces llenaban estadios en América Latina, entre ellas Menudo en Puerto Rico y Los Chamos en Venezuela. Robot, Angelito y Marielena son las canciones de aquellos años que le quedaron al público.

**La Orquesta Capricho**

A finales de los ochenta dejó el grupo para formar una orquesta de merengue propia, y le funcionó. Adolescente, Chiquilla Malcriada, Nuestro Amor, Volvamos a Vivir, Siervo de Amor y Rodando son de esa etapa, que es cuando su nombre llegó a su público más amplio.

La orquesta fue además escuela de músicos más jóvenes. A Tulile lo contrató como saxofonista años antes de que grabara con su propio nombre.

**Diez años fuera**

Después desapareció de la radio y de la tarima durante cerca de una década. Ha atribuido la ausencia a su disquera, que según él incumplió con la promoción del material que ya había publicado, y ha descrito ese retiro como uno que no escogió.

**El regreso**

Volvió al país en 2008, tras años residiendo en Estados Unidos, y en 2010 montó un concierto por sus veintitrés años de trayectoria, con Sergio Vargas entre los invitados. Detrás vino Mátala, y en 2013 publicó una lectura en merengue de una canción del compositor español Manuel Alejandro.

Desde entonces se ha mantenido activo. Participa en los espectáculos de big band dedicados a los años dorados del merengue, junto a Ray Polanco y a otros cantantes de su generación.',
       updated_at = now()
 WHERE slug = 'monchy-capricho';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monchy-capricho')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monchy-capricho')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ramón Antonio Javier Demorizi, known as Monchy Capricho, is a Dominican merengue singer and bandleader. He was one of the teen idols of the late eighties and early nineties, first with a youth band and then at the head of his own orchestra.","type":"text"}]},{"type":"paragraph","content":[{"text":"Sabana de la Mar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Santo Domingo in 1969 and was taken to Sabana de la Mar at three months old. That is the town he grew up in and the one he names as his own.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mermelada","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He became known with Mermelada, a youth group assembled as the Dominican answer to the boy bands then filling stadiums across Latin America, Menudo in Puerto Rico and Los Chamos in Venezuela among them. Robot, Angelito and Marielena are the songs from those years that stayed with the audience.","type":"text"}]},{"type":"paragraph","content":[{"text":"Orquesta Capricho","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"At the end of the eighties he left the group to form a merengue orchestra of his own, and the move worked. Adolescente, Chiquilla Malcriada, Nuestro Amor, Volvamos a Vivir, Siervo de Amor and Rodando come from that period, which is when his name reached its widest audience.","type":"text"}]},{"type":"paragraph","content":[{"text":"The orchestra was also a school for younger players. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a9377ef8-237f-462a-bcb0-6013fd6ac76b","displayText":"Tulile","occurrenceId":"e4b0e4a6-6fff-4dbd-8b52-02c1e03dba9f"}},{"text":" was hired into it as a saxophonist years before recording under his own name.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ten years away","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He then disappeared from the radio and from the stage for about a decade. He has attributed the absence to his record company, which he says failed to promote the material it had released, and has described the retirement as one he did not choose.","type":"text"}]},{"type":"paragraph","content":[{"text":"The return","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He came back to the country in 2008 after years living in the United States, and in 2010 staged a concert marking twenty-three years of work, with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"4ff909ec-a6f6-43aa-a367-6b35b8ae6919"}},{"text":" among the guests. Mátala followed, and in 2013 he released a merengue reading of a song by the Spanish composer Manuel Alejandro.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has kept working since. He appears in the big band programmes devoted to the golden years of merengue, alongside ","type":"text"},{"type":"artistReference","attrs":{"artistId":"69289f21-4168-4fb5-af44-90438e068e3a","displayText":"Ray Polanco","occurrenceId":"8e973c24-69b6-4dec-80f7-ce57f34293c2"}},{"text":" and other singers of his generation.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'monchy-capricho'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ramón Antonio Javier Demorizi, conocido como Monchy Capricho, es un cantante y director de orquesta de merengue dominicano. Fue uno de los ídolos juveniles de finales de los ochenta y principios de los noventa, primero con una agrupación juvenil y después al frente de su propia orquesta.","type":"text"}]},{"type":"paragraph","content":[{"text":"Sabana de la Mar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santo Domingo en 1969 y a los tres meses lo llevaron a Sabana de la Mar. Ese es el pueblo donde se crió y el que nombra como suyo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mermelada","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se dio a conocer con Mermelada, un grupo juvenil armado como la respuesta dominicana a las bandas de muchachos que entonces llenaban estadios en América Latina, entre ellas Menudo en Puerto Rico y Los Chamos en Venezuela. Robot, Angelito y Marielena son las canciones de aquellos años que le quedaron al público.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Orquesta Capricho","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A finales de los ochenta dejó el grupo para formar una orquesta de merengue propia, y le funcionó. Adolescente, Chiquilla Malcriada, Nuestro Amor, Volvamos a Vivir, Siervo de Amor y Rodando son de esa etapa, que es cuando su nombre llegó a su público más amplio.","type":"text"}]},{"type":"paragraph","content":[{"text":"La orquesta fue además escuela de músicos más jóvenes. A ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a9377ef8-237f-462a-bcb0-6013fd6ac76b","displayText":"Tulile","occurrenceId":"e7dbbea1-c87a-457f-b395-5159b2f73d97"}},{"text":" lo contrató como saxofonista años antes de que grabara con su propio nombre.","type":"text"}]},{"type":"paragraph","content":[{"text":"Diez años fuera","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Después desapareció de la radio y de la tarima durante cerca de una década. Ha atribuido la ausencia a su disquera, que según él incumplió con la promoción del material que ya había publicado, y ha descrito ese retiro como uno que no escogió.","type":"text"}]},{"type":"paragraph","content":[{"text":"El regreso","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Volvió al país en 2008, tras años residiendo en Estados Unidos, y en 2010 montó un concierto por sus veintitrés años de trayectoria, con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"e177e811-a7e9-4646-963c-d57fc17a2ec9"}},{"text":" entre los invitados. Detrás vino Mátala, y en 2013 publicó una lectura en merengue de una canción del compositor español Manuel Alejandro.","type":"text"}]},{"type":"paragraph","content":[{"text":"Desde entonces se ha mantenido activo. Participa en los espectáculos de big band dedicados a los años dorados del merengue, junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"69289f21-4168-4fb5-af44-90438e068e3a","displayText":"Ray Polanco","occurrenceId":"43fe8de8-2cea-4c79-a6ee-b61e29490344"}},{"text":" y a otros cantantes de su generación.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'monchy-capricho'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monchy-capricho') AND locale = 'en'), '4ff909ec-a6f6-43aa-a367-6b35b8ae6919', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monchy-capricho') AND locale = 'en'), '8e973c24-69b6-4dec-80f7-ce57f34293c2', 'artist', '69289f21-4168-4fb5-af44-90438e068e3a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monchy-capricho') AND locale = 'en'), 'e4b0e4a6-6fff-4dbd-8b52-02c1e03dba9f', 'artist', 'a9377ef8-237f-462a-bcb0-6013fd6ac76b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monchy-capricho') AND locale = 'es'), '43fe8de8-2cea-4c79-a6ee-b61e29490344', 'artist', '69289f21-4168-4fb5-af44-90438e068e3a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monchy-capricho') AND locale = 'es'), 'e177e811-a7e9-4646-963c-d57fc17a2ec9', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monchy-capricho') AND locale = 'es'), 'e7dbbea1-c87a-457f-b395-5159b2f73d97', 'artist', 'a9377ef8-237f-462a-bcb0-6013fd6ac76b');

COMMIT;
