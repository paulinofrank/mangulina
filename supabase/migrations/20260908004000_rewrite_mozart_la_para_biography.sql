BEGIN;

-- Rewrite the catalogue entry for Mozart la Para.
--
-- Mozart La Para. TERCERA de las 211, con 26 enlaces entrantes. Y la ficha
-- vieja se equivocaba en lo más básico: CUÁNDO EMPEZÓ.
--
-- DECÍA "He emerged in the early 2010s". Lleva grabando DESDE 2002, cuando pagó
-- sus primeras grabaciones con el dinero que le daban para ir a la escuela, y
-- para 2007 ya era estrella del rap dominicano. Cuando firmó con Roc Nation, en
-- 2016, llevaba quince años de carrera. Poner su aparición una década tarde
-- borra la mitad de su historia y lo convierte en un artista de plataforma, que
-- es justo lo que no fue.
--
-- LA FICHA TAMPOCO NOMBRABA UNA SOLA CANCIÓN NI UN SOLO COLABORADOR, y en
-- cambio escribía que es "one of the most followed Dominican urban artists on
-- digital platforms". Eso es una cifra de seguidores metida en prosa. Fuera.
--
-- EL DATO MÁS GRANDE QUE FALTABA: FUE EL PRIMER ARTISTA EN FIRMAR CON LA
-- DIVISIÓN LATINA DE ROC NATION, en 2016. Lo dan Wikipedia citando a Billboard
-- y BuenaMusica. No aparecía por ningún lado.
--
-- EL SEGUNDO: HA ENTRADO CINCO VECES EN LAS LISTAS DE BILLBOARD. Posiciones de
-- lista, que sí se registran.
--
-- DE DÓNDE SALE EL NOMBRE, que es buenísimo y no estaba: "Mozart" porque al
-- principio le componía a otros exponentes; "La Para" por el miedo que le tenían
-- sus contrincantes en el freestyle cara a cara. Lo da BuenaMusica.
--
-- LA FILA GANA EL NOMBRE LEGAL COMPLETO: se llama ERICKSON RAFAEL FERNÁNDEZ
-- PANIAGUA. La fila solo tenía 'Erickson' y 'Fernández'; faltaban middle_name y
-- second_last_name. Y aliases traía 'Mozart la Para' -- SU PROPIO NOMBRE
-- ARTÍSTICO -- y 'Erickson Fernández', el legal. UNDÉCIMO caso del patrón. Los
-- dos salen.
--
-- ---------------------------------------------------------------------------
-- LA GRAFÍA DEL NOMBRE: LO REPORTO Y NO LO TOCO, Y EXPLICO POR QUÉ
--
-- La fila dice "Mozart la Para", con LA EN MINÚSCULA. Todo lo demás dice lo
-- contrario: Wikipedia titula "Mozart La Para", BuenaMusica escribe "Mozart La
-- Para", su canal es @MozartLaPara y su Instagram mozartlapara. La mayúscula
-- parece ser la correcta.
--
-- PERO name ES EL TEXTO QUE LOS ENLACES REPRODUCEN LITERALMENTE, y hay
-- VEINTISÉIS REFERENCIAS ENTRANTES a esta ficha desde otras biografías, cada
-- una con su displayText. Cambiar el campo obliga a tocar las veintiséis, y eso
-- es una migración de barrido con su propia herramienta, no algo que se hace de
-- paso mientras se escribe otra cosa.
--
-- Mismo criterio que apliqué con "Bermudez" sin tilde en René del Risco, donde
-- eran dos referencias. Aquí son veintiséis. Queda reportado como trabajo
-- aparte.
-- ---------------------------------------------------------------------------
--
-- EL SITIO WEB NO SE GUARDA. Wikipedia da mozartlaparaoficial.com y AL PROBARLO
-- NO RESPONDE, ni con www ni sin él. Prefiero el campo vacío a una URL muerta,
-- que es lo que el editor pidió cuando revisamos los handles.
--
-- LO QUE SE DEJA FUERA: sus dos matrimonios, el divorcio y su hija. Vida
-- privada. Su hermana menor tampoco entra.
--
-- NO SE ESCRIBEN LAS REPRODUCCIONES, que BuenaMusica repite tres veces.
--
-- EL CINE SÍ ENTRA, y es medio párrafo: "Pueto pa' Mi" (2015) es una PELÍCULA
-- BASADA EN SU VIDA en la que él hace de Aníbal, y ha actuado en otras cinco.
-- Es trabajo suyo, público y documentado.
--
-- CUATRO ENLACES, TODOS POR CRÉDITO: shelow-shaq ("Llegan los Montros Men"),
-- chimbala ("Bye Bye"), sharlene ("Juguete Enamorado") y lapiz-conciente, por la
-- batalla de rap de 2020 -- ENLACE RECÍPROCO, porque acabo de escribirla en la
-- ficha de Lápiz hace un rato.
--
-- NO SE ENLAZAN los extranjeros: Farruko, Nacho, Justin Quiles, Jowell y Randy.
-- Ni AVENTURA, con quienes se presentó en el Izod Center, PORQUE NO TIENE FICHA:
-- el catálogo tiene a Henry Santos, miembro fundador, pero no al grupo. Es el
-- hueco que llevo días anotando.
--
-- LOS PREMIOS VAN EN MIGRACIÓN APARTE. Tenía CERO y son NUEVE adjudicaciones.
--
-- FUENTES: Wikipedia en español, citando a Billboard, El Caribe, New York Daily
-- News y Chron, para Roc Nation, las listas y los premios. BuenaMusica para la
-- cronología musical, los colaboradores y el origen del nombre.
--
-- NOMBRES NUEVOS PARA LA LISTA: LIRO SHAQ, que grabó "Bye Bye" con él y no
-- está. Y AVENTURA vuelve a salir.
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
       name = 'Mozart la Para',
       sort_name = 'Fernández Paniagua, Erickson Rafael',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urban-rap-hip-hop',
       date_of_birth = '1988-01-31',
       birth_year = 1988,
       date_of_death = NULL,
       birth_place = 'Los Mina, Santo Domingo Este',
       province = 'Santo Domingo',
       first_name = 'Erickson',
       middle_name = 'Rafael',
       last_name = 'Fernández',
       second_last_name = 'Paniagua',
       stage_name = 'Mozart La Para',
       aliases = ARRAY[]::text[],
       occupations = '["songwriter","rapper","actor"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY['urban-reggaeton', 'urbano']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@MozartLaPara',
       facebook = 'MozartLaPara',
       instagram = 'mozartlapara',
       disambiguation = 'Rapper from Los Mina; the first artist signed to Roc Nation’s Latin division',
       bio_en = 'Erickson Rafael Fernández Paniagua, who records as Mozart La Para, is a Dominican rapper and singer. He came out of freestyle battling and has been recording since 2002, and in 2016 he became the first artist signed to the Latin division of Roc Nation.

**Los Mina**

He was born in 1988 in Los Mina, on the eastern side of Santo Domingo — the same barrio Lápiz Conciente comes from, which says something about how much of Dominican rap was made within a few streets of each other.

The stage name has two halves and two explanations. Mozart came from writing songs for other artists at the start, and La Para came from what happened when someone had to face him in a freestyle, which is that they stopped.

**Vamo en Dauran**

He paid for his first recordings in 2002 with the money he was given for school. By 2007 he was a name in Dominican rap, and in 2008 he took part in the Red Bull Batalla de los Gallos and released Vamo en Dauran, which is the record that moved him out of the battle circuit.

The touring started early. In 2009 he spent three months in Europe with more than thirty dates, then went to the United States and played forty-five in two months, appearing as a guest with Aventura at the Izod Center. He was also the first Dominican rapper to perform in Colombia, and went back three times.

**Pueto pa’ Mi**

Si Te Pego Cuerno, with the Puerto Rican Farruko, came next. In 2015 he released Pueto pa’ Mi, and a film of the same title was built around his life, with him playing the lead. That year he also appeared on Llegan los Montros Men by Shelow Shaq.

The film work kept going. He has appeared in Mi Angelito Favorito, No Hay Más Remedio, Los Paracaidistas, La Maravilla and Flow Calle, mostly as himself.

**Roc Nation**

He signed to Roc Nation in 2016, the first artist to join its Latin division, and released Juguete Enamorado with Sharlene and the Venezuelan Nacho. Bye Bye followed in 2017 with Chimbala and Liro Shaq, and in 2018 Mujeres with Justin Quiles, which was remixed with Farruko and Jowell y Randy.

Karma, Te Amé, Papá Candelo and Son Malas came after, and El Cumple de La Para and Soy Calle in 2020. His records have entered the Billboard charts on five occasions.

**The battle**

In 2020 he went into a rap battle against Lápiz Conciente, the other rapper from Los Mina and the one the scene treats as its founder. It was followed as an event in its own right, and both of them released singles out of it.

**The awards**

The Premios Soberano named him urban artist of the year in 2013, 2016 and 2018, and he took the Soberano del Pueblo — the award decided by public vote — six years running from 2013 to 2018, which is a record of popularity rather than of jury approval and worth keeping separate for that reason.',
       bio_es = 'Erickson Rafael Fernández Paniagua, que graba como Mozart La Para, es un rapero y cantante dominicano. Salió de las batallas de freestyle, graba desde 2002, y en 2016 se convirtió en el primer artista firmado por la división latina de Roc Nation.

**Los Mina**

Nació en 1988 en Los Mina, al este de Santo Domingo, el mismo barrio del que viene Lápiz Conciente, lo que dice algo sobre cuánto del rap dominicano se hizo a unas pocas calles de distancia.

El nombre artístico tiene dos mitades y dos explicaciones. Mozart viene de componerle canciones a otros exponentes al principio, y La Para viene de lo que pasaba cuando alguien tenía que enfrentarlo en un freestyle, que es que se paraba.

**Vamo en Dauran**

Pagó sus primeras grabaciones en 2002 con el dinero que le daban para la escuela. Para 2007 ya era un nombre en el rap dominicano, y en 2008 participó en la Batalla de los Gallos de Red Bull y sacó Vamo en Dauran, que es el tema que lo saca del circuito de batallas.

Las giras empezaron temprano. En 2009 pasó tres meses en Europa con más de treinta fechas, después se fue a Estados Unidos y dio cuarenta y cinco en dos meses, presentándose como invitado con Aventura en el Izod Center. Fue además el primer rapero dominicano en presentarse en Colombia, adonde volvió tres veces.

**Pueto pa’ Mi**

Detrás vino Si Te Pego Cuerno, con el puertorriqueño Farruko. En 2015 sacó Pueto pa’ Mi, y alrededor de su vida se armó una película del mismo título en la que él hace el protagónico. Ese año apareció también en Llegan los Montros Men, de Shelow Shaq.

El cine siguió. Ha actuado en Mi Angelito Favorito, No Hay Más Remedio, Los Paracaidistas, La Maravilla y Flow Calle, casi siempre haciendo de sí mismo.

**Roc Nation**

Firmó con Roc Nation en 2016, primer artista en entrar a su división latina, y sacó Juguete Enamorado con Sharlene y el venezolano Nacho. En 2017 vino Bye Bye con Chimbala y Liro Shaq, y en 2018 Mujeres con Justin Quiles, que tuvo un remix con Farruko y Jowell y Randy.

Después llegaron Karma, Te Amé, Papá Candelo y Son Malas, y en 2020 El Cumple de La Para y Soy Calle. Sus temas han entrado cinco veces en las listas de Billboard.

**La batalla**

En 2020 se metió en una batalla de rap contra Lápiz Conciente, el otro rapero de Los Mina y al que la escena trata como su fundador. Se siguió como acontecimiento por derecho propio, y los dos sacaron sencillos de ahí.

**Los premios**

Los Premios Soberano lo nombraron artista urbano del año en 2013, 2016 y 2018, y ganó el Soberano del Pueblo — el que decide el voto del público — seis años seguidos, de 2013 a 2018, que es un registro de popularidad y no de aprobación de jurado y conviene tenerlo aparte por eso mismo.',
       updated_at = now()
 WHERE slug = 'mozart-la-para';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Erickson Rafael Fernández Paniagua, who records as Mozart La Para, is a Dominican rapper and singer. He came out of freestyle battling and has been recording since 2002, and in 2016 he became the first artist signed to the Latin division of Roc Nation.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Mina","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1988 in Los Mina, on the eastern side of Santo Domingo — the same barrio ","type":"text"},{"type":"artistReference","attrs":{"artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente","occurrenceId":"2b6cdd9c-f6c6-4ce9-9908-e4d010c52752"}},{"text":" comes from, which says something about how much of Dominican rap was made within a few streets of each other.","type":"text"}]},{"type":"paragraph","content":[{"text":"The stage name has two halves and two explanations. Mozart came from writing songs for other artists at the start, and La Para came from what happened when someone had to face him in a freestyle, which is that they stopped.","type":"text"}]},{"type":"paragraph","content":[{"text":"Vamo en Dauran","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He paid for his first recordings in 2002 with the money he was given for school. By 2007 he was a name in Dominican rap, and in 2008 he took part in the Red Bull Batalla de los Gallos and released Vamo en Dauran, which is the record that moved him out of the battle circuit.","type":"text"}]},{"type":"paragraph","content":[{"text":"The touring started early. In 2009 he spent three months in Europe with more than thirty dates, then went to the United States and played forty-five in two months, appearing as a guest with Aventura at the Izod Center. He was also the first Dominican rapper to perform in Colombia, and went back three times.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pueto pa’ Mi","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Si Te Pego Cuerno, with the Puerto Rican Farruko, came next. In 2015 he released Pueto pa’ Mi, and a film of the same title was built around his life, with him playing the lead. That year he also appeared on Llegan los Montros Men by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cadebd75-4af4-4519-9599-6ec606694a36","displayText":"Shelow Shaq","occurrenceId":"d270fc6b-cf51-4b0d-b032-99207bbd2a43"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"The film work kept going. He has appeared in Mi Angelito Favorito, No Hay Más Remedio, Los Paracaidistas, La Maravilla and Flow Calle, mostly as himself.","type":"text"}]},{"type":"paragraph","content":[{"text":"Roc Nation","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He signed to Roc Nation in 2016, the first artist to join its Latin division, and released Juguete Enamorado with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"112ab16f-a56b-4a93-8562-120bfee1c70b","displayText":"Sharlene","occurrenceId":"a9145927-a016-4b6f-894d-ac811c474618"}},{"text":" and the Venezuelan Nacho. Bye Bye followed in 2017 with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala","occurrenceId":"b3f049d2-9bd4-4d9e-9013-b9e11043c02a"}},{"text":" and Liro Shaq, and in 2018 Mujeres with Justin Quiles, which was remixed with Farruko and Jowell y Randy.","type":"text"}]},{"type":"paragraph","content":[{"text":"Karma, Te Amé, Papá Candelo and Son Malas came after, and El Cumple de La Para and Soy Calle in 2020. His records have entered the Billboard charts on five occasions.","type":"text"}]},{"type":"paragraph","content":[{"text":"The battle","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2020 he went into a rap battle against ","type":"text"},{"type":"artistReference","attrs":{"artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente","occurrenceId":"8d2f9ef7-dcfe-464b-9416-cefedbb5b762"}},{"text":", the other rapper from Los Mina and the one the scene treats as its founder. It was followed as an event in its own right, and both of them released singles out of it.","type":"text"}]},{"type":"paragraph","content":[{"text":"The awards","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The Premios Soberano named him urban artist of the year in 2013, 2016 and 2018, and he took the Soberano del Pueblo — the award decided by public vote — six years running from 2013 to 2018, which is a record of popularity rather than of jury approval and worth keeping separate for that reason.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'mozart-la-para'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Erickson Rafael Fernández Paniagua, que graba como Mozart La Para, es un rapero y cantante dominicano. Salió de las batallas de freestyle, graba desde 2002, y en 2016 se convirtió en el primer artista firmado por la división latina de Roc Nation.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Mina","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1988 en Los Mina, al este de Santo Domingo, el mismo barrio del que viene ","type":"text"},{"type":"artistReference","attrs":{"artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente","occurrenceId":"8b323573-e54e-499f-8432-07eef5cdef2a"}},{"text":", lo que dice algo sobre cuánto del rap dominicano se hizo a unas pocas calles de distancia.","type":"text"}]},{"type":"paragraph","content":[{"text":"El nombre artístico tiene dos mitades y dos explicaciones. Mozart viene de componerle canciones a otros exponentes al principio, y La Para viene de lo que pasaba cuando alguien tenía que enfrentarlo en un freestyle, que es que se paraba.","type":"text"}]},{"type":"paragraph","content":[{"text":"Vamo en Dauran","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Pagó sus primeras grabaciones en 2002 con el dinero que le daban para la escuela. Para 2007 ya era un nombre en el rap dominicano, y en 2008 participó en la Batalla de los Gallos de Red Bull y sacó Vamo en Dauran, que es el tema que lo saca del circuito de batallas.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las giras empezaron temprano. En 2009 pasó tres meses en Europa con más de treinta fechas, después se fue a Estados Unidos y dio cuarenta y cinco en dos meses, presentándose como invitado con Aventura en el Izod Center. Fue además el primer rapero dominicano en presentarse en Colombia, adonde volvió tres veces.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pueto pa’ Mi","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Detrás vino Si Te Pego Cuerno, con el puertorriqueño Farruko. En 2015 sacó Pueto pa’ Mi, y alrededor de su vida se armó una película del mismo título en la que él hace el protagónico. Ese año apareció también en Llegan los Montros Men, de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cadebd75-4af4-4519-9599-6ec606694a36","displayText":"Shelow Shaq","occurrenceId":"13dffd6d-1c14-4e3f-a440-865ecb455cd2"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"El cine siguió. Ha actuado en Mi Angelito Favorito, No Hay Más Remedio, Los Paracaidistas, La Maravilla y Flow Calle, casi siempre haciendo de sí mismo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Roc Nation","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Firmó con Roc Nation en 2016, primer artista en entrar a su división latina, y sacó Juguete Enamorado con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"112ab16f-a56b-4a93-8562-120bfee1c70b","displayText":"Sharlene","occurrenceId":"c7ea62cb-364f-4d01-8ec9-958af83aca03"}},{"text":" y el venezolano Nacho. En 2017 vino Bye Bye con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala","occurrenceId":"6b484946-7ee8-47cf-8777-219907eb3a8e"}},{"text":" y Liro Shaq, y en 2018 Mujeres con Justin Quiles, que tuvo un remix con Farruko y Jowell y Randy.","type":"text"}]},{"type":"paragraph","content":[{"text":"Después llegaron Karma, Te Amé, Papá Candelo y Son Malas, y en 2020 El Cumple de La Para y Soy Calle. Sus temas han entrado cinco veces en las listas de Billboard.","type":"text"}]},{"type":"paragraph","content":[{"text":"La batalla","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2020 se metió en una batalla de rap contra ","type":"text"},{"type":"artistReference","attrs":{"artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente","occurrenceId":"54c94923-48ca-4237-afc8-9e157b6c6245"}},{"text":", el otro rapero de Los Mina y al que la escena trata como su fundador. Se siguió como acontecimiento por derecho propio, y los dos sacaron sencillos de ahí.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los premios","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Los Premios Soberano lo nombraron artista urbano del año en 2013, 2016 y 2018, y ganó el Soberano del Pueblo — el que decide el voto del público — seis años seguidos, de 2013 a 2018, que es un registro de popularidad y no de aprobación de jurado y conviene tenerlo aparte por eso mismo.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'mozart-la-para'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para') AND locale = 'en'), '2b6cdd9c-f6c6-4ce9-9908-e4d010c52752', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para') AND locale = 'en'), '8d2f9ef7-dcfe-464b-9416-cefedbb5b762', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para') AND locale = 'en'), 'a9145927-a016-4b6f-894d-ac811c474618', 'artist', '112ab16f-a56b-4a93-8562-120bfee1c70b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para') AND locale = 'en'), 'b3f049d2-9bd4-4d9e-9013-b9e11043c02a', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para') AND locale = 'en'), 'd270fc6b-cf51-4b0d-b032-99207bbd2a43', 'artist', 'cadebd75-4af4-4519-9599-6ec606694a36');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para') AND locale = 'es'), '13dffd6d-1c14-4e3f-a440-865ecb455cd2', 'artist', 'cadebd75-4af4-4519-9599-6ec606694a36');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para') AND locale = 'es'), '54c94923-48ca-4237-afc8-9e157b6c6245', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para') AND locale = 'es'), '6b484946-7ee8-47cf-8777-219907eb3a8e', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para') AND locale = 'es'), '8b323573-e54e-499f-8432-07eef5cdef2a', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'mozart-la-para') AND locale = 'es'), 'c7ea62cb-364f-4d01-8ec9-958af83aca03', 'artist', '112ab16f-a56b-4a93-8562-120bfee1c70b');

COMMIT;
