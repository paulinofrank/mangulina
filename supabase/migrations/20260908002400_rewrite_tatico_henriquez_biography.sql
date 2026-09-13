BEGIN;

-- Rewrite the catalogue entry for Tatico Henríquez.
--
-- Tatico Henríquez. DECIMOQUINTA de las dieciocho. La ficha vieja tenía 1.253
-- caracteres de elogio -- "virtuosity that astonished contemporaries", "a
-- genius of Dominican traditional music" -- y NO DECÍA QUÉ HIZO.
--
-- LO QUE HIZO, Y ES CONCRETO: CAMBIÓ LA INSTRUMENTACIÓN DEL CONJUNTO TÍPICO. El
-- conjunto de su época era acordeón diatónico, güira, tambora, marimba haciendo
-- de bajo y a veces un saxofón. Tatico le metió CONGAS, DOS SAXOFONES
-- armonizando con el acordeón, y BAJO ELÉCTRICO en lugar de la marimba. Esa es
-- la formación con la que se toca el típico desde entonces. La ficha decía
-- "innovations in technique and style", que no dice nada.
--
-- EL SEGUNDO DATO GRANDE QUE FALTABA: según Huchi Lora y Rafael Chaljub Mejía,
-- después del ajusticiamiento de Trujillo en 1961 el merengue entró en una
-- crisis que amenazó con desaparecerlo, y Tatico fue de los que lo rescataron.
-- Eso sitúa por qué importa, y no aparecía.
--
-- SU NOMBRE LEGAL NO ESTABA EN NINGÚN CAMPO. Los cuatro en NULL. Se llamaba
-- DOMINGO GARCÍA HENRÍQUEZ: García por el padre, Henríquez por la madre. Su
-- nombre artístico usa el apellido MATERNO, cosa poco común y que conviene
-- tener registrada para que nadie "corrija" la fila más adelante.
--
-- aliases estaba vacío, occupations decía 'musician' -- que no dice nada -- e
-- instruments estaba VACÍO para el acordeonista más influyente del género.
--
-- primary_role SE QUEDA EN 'singer' Y NO ES ERROR. Es la regla del catálogo
-- para los acordeonistas de típico, fijada en la migración de septiembre que
-- corrigió a Fefita, Polonia y Magdalena: cantan primero y el acordeón va en
-- occupations. Aquí se cumple: entra 'accordionist' en occupations.
--
-- EL LUGAR SE PRECISA: nació en MATA BONITA, un paraje de Nagua, no en el
-- pueblo. Y murió EN SANTIAGO, no en Nagua.
--
-- LA MUERTE: MISMO CRITERIO QUE CON RUBBY PÉREZ. Murió en un accidente de
-- tránsito en Santiago, el 23 de mayo de 1976, a los treinta y dos años. NO ES
-- DATO MÉDICO: es un hecho público, y es la razón por la que su obra dura seis
-- años y no cuarenta. Se escribe el hecho, sin el detalle del carro ni de la
-- avenida, que serían morbo. La causa médica no existe aquí y no hay nada que
-- omitir.
--
-- LA EDAD YA ESTABA CORREGIDA. La ficha decía "at thirty-two" y las fechas dan
-- treinta y dos; fue una de las cuatro que arreglé en la auditoría de fechas
-- completas. Se conserva.
--
-- EL PADRE ENTRA COMO FORMACIÓN MUSICAL, NO COMO OFICIO DE PADRE. Juan
-- Henríquez, alias Bolo, era acordeonista y fue quien le puso el instrumento en
-- las manos; después perfeccionó con Ramón Mezquita. Mismo criterio que apliqué
-- con el padre de Johnny Pacheco: el instrumento heredado es de dónde sale el
-- músico. NO ENTRAN su matrimonio de 1972 ni su hijo.
--
-- SEIS ENLACES, TODOS DOCUMENTADOS: los cinco típicos a los que influyó
-- directamente y que la fuente nombra -- fefita-la-grande,
-- el-cieguito-de-nagua, rafaelito-roman, francisco-ulloa y agapito-pascual --
-- más fernando-villalona, que le grabó un tema en su memoria. El enlace a
-- Villalona cierra además un circuito bonito: en la ficha de los-kenton está
-- contado que Villalona se hizo un nombre CON UN TEMA DE TATICO.
--
-- OJO CON LA GRAFÍA: la fuente escribe "Rafelito Román" y la fila del catálogo
-- se llama "Rafaelito Román", con A. El displayText va como la fila.
--
-- UN HUECO GRANDE QUE QUEDA REPORTADO: de los siete nombres que rodean su
-- historia, SIETE NO ESTÁN EN EL CATÁLOGO, y entre ellos ÑICO LORA, que es
-- fundacional -- Tatico grabó merengues suyos. También faltan el TRÍO REYNOSO,
-- donde entró en 1966 al morir su acordeonista PEDRO REYNOSO; sus hermanos
-- ISAÍAS "SACO" y JULIO HENRÍQUEZ, que tocaron con él; CHICHE BELLO; y RAMÓN
-- MEZQUITA, su maestro. Es el hueco más grande de merengue típico que he visto.
--
-- FUENTES: Wikipedia en español, que cita el libro de Rafael Chaljub Mejía
-- "Antes de que te vayas... Historia del merengue folklórico" (2002), iASO
-- Records, Hoy Digital y El Nacional.
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
       name = 'Tatico Henríquez',
       sort_name = 'García Henríquez, Domingo',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1943-07-30',
       birth_year = 1943,
       date_of_death = '1976-05-23',
       birth_place = 'Mata Bonita, Nagua',
       province = 'María Trinidad Sánchez',
       first_name = 'Domingo',
       middle_name = NULL,
       last_name = 'García',
       second_last_name = 'Henríquez',
       stage_name = NULL,
       aliases = ARRAY['Tatico']::text[],
       occupations = '["accordionist"]'::jsonb,
       instruments = ARRAY['accordion', 'voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Accordionist who rebuilt the típico ensemble and set the shape merengue típico still has',
       bio_en = 'Domingo García Henríquez, known everywhere as Tatico, was a Dominican accordionist and singer. He worked for barely a decade and left merengue típico permanently changed: the instrumentation the genre still uses is the one he assembled.

**Mata Bonita**

He was born in 1943 in Mata Bonita, a settlement outside Nagua on the northern coast, into a farming family. His father, the accordionist Juan Henríquez, put the instrument in his hands, and he went on to sharpen his technique under Ramón Mezquita. He first became known playing the religious festivals and processions of his district, where folk music was the working repertoire rather than a heritage exercise.

**Trío Reynoso**

In 1966 the Trío Reynoso lost its accordionist, Pedro Reynoso, and took Tatico on. He played his first date with them at the Teatro Agua y Luz in Santo Domingo. He did not stay long: he left to form a band of his own, Tatico y sus Muchachos, and it was there that he did the work he is remembered for.

**The ensemble he rebuilt**

The típico group of his day ran on diatonic accordion, güira, tambora, a marimba standing in for a bass, and now and then a saxophone. Tatico kept the accordion, the güira and the tambora and added congas, two saxophones harmonising with the accordion, and an electric bass in place of the marimba.

That line-up is what a típico band looks like today. The change is often described as modernisation, but it was closer to an argument: he made the folk ensemble loud and flexible enough to hold a dance floor without giving up the accordion at its centre.

**Rescuing the genre**

The journalist Huchi Lora and the writer Rafael Chaljub Mejía have both argued that merengue entered a crisis after the killing of Trujillo in 1961, deep enough to threaten the form itself, and that musicians like Tatico brought it back by taking the country merengue and moving it forward from inside its own rhythm rather than replacing it.

He recorded a great many típico merengues, his own and those of composers such as Ñico Lora, along with old traditional pieces like El Telefonema. He also made a record with his brother Isaías, on which he only sang while Isaías played the accordion. Merengues..! appeared in 1970 and was followed by two further volumes and by A Gozar Con Tatico in 1974; the recordings issued after his death kept appearing for another three decades.

**What came after**

He died in a road accident in Santiago on 23 May 1976, at thirty-two. The players who came up behind him carry his mark: Fefita la Grande, El Cieguito de Nagua, Rafaelito Román, Francisco Ulloa and Agapito Pascual were all named as his heirs, and Fernando Villalona recorded a song in his memory.

A bust of him was unveiled in 2001 in the park that carries his name, opposite the town hall in Nagua, and a documentary about him appeared five years later.',
       bio_es = 'Domingo García Henríquez, conocido en todas partes como Tatico, fue un acordeonista y cantante dominicano. Trabajó apenas una década y dejó el merengue típico cambiado para siempre: la instrumentación con la que se toca el género todavía hoy es la que él armó.

**Mata Bonita**

Nació en 1943 en Mata Bonita, un paraje de Nagua, en la costa norte, en una familia campesina. Su padre, el acordeonista Juan Henríquez, le puso el instrumento en las manos, y después afinó la técnica con Ramón Mezquita. Empezó a darse a conocer en las fiestas patronales y las procesiones de su comarca, donde la música folclórica era repertorio de trabajo y no ejercicio de rescate.

**Trío Reynoso**

En 1966 el Trío Reynoso perdió a su acordeonista, Pedro Reynoso, y tomó a Tatico. Su primera presentación con ellos fue en el Teatro Agua y Luz de Santo Domingo. No se quedó mucho: se fue a montar grupo propio, Tatico y sus Muchachos, y ahí hizo el trabajo por el que se le recuerda.

**El conjunto que rearmó**

El conjunto típico de su tiempo iba con acordeón diatónico, güira, tambora, una marimba haciendo de bajo y de vez en cuando un saxofón. Tatico conservó el acordeón, la güira y la tambora, y añadió congas, dos saxofones armonizando con el acordeón, y un bajo eléctrico en lugar de la marimba.

Esa alineación es la que tiene hoy cualquier conjunto típico. El cambio suele contarse como modernización, pero se parece más a un argumento: hizo el conjunto folclórico lo bastante sonoro y flexible para sostener una pista de baile sin renunciar al acordeón en el centro.

**El rescate del género**

El periodista Huchi Lora y el escritor Rafael Chaljub Mejía han sostenido los dos que el merengue entró en crisis tras el ajusticiamiento de Trujillo en 1961, una crisis honda como para amenazar al género mismo, y que músicos como Tatico lo devolvieron a la vida tomando el merengue campesino y haciéndolo evolucionar desde su propia rítmica en vez de sustituirla.

Grabó una cantidad enorme de merengues típicos, suyos y de compositores como Ñico Lora, además de piezas tradicionales viejas como El Telefonema. Hizo también un disco con su hermano Isaías en el que él solo cantaba mientras Isaías tocaba el acordeón. Merengues..! salió en 1970 y detrás vinieron dos volúmenes más y A Gozar Con Tatico en 1974; las grabaciones publicadas después de su muerte siguieron saliendo durante tres décadas.

**Lo que vino después**

Murió en un accidente de tránsito en Santiago el 23 de mayo de 1976, a los treinta y dos años. Los que vinieron detrás llevan su marca: Fefita la Grande, El Cieguito de Nagua, Rafaelito Román, Francisco Ulloa y Agapito Pascual han sido señalados como sus herederos, y Fernando Villalona le grabó un tema en su memoria.

En 2001 se develó un busto suyo en el parque que lleva su nombre, frente al ayuntamiento de Nagua, y cinco años después salió un documental sobre él.',
       updated_at = now()
 WHERE slug = 'tatico-henriquez';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Domingo García Henríquez, known everywhere as Tatico, was a Dominican accordionist and singer. He worked for barely a decade and left merengue típico permanently changed: the instrumentation the genre still uses is the one he assembled.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mata Bonita","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1943 in Mata Bonita, a settlement outside Nagua on the northern coast, into a farming family. His father, the accordionist Juan Henríquez, put the instrument in his hands, and he went on to sharpen his technique under Ramón Mezquita. He first became known playing the religious festivals and processions of his district, where folk music was the working repertoire rather than a heritage exercise.","type":"text"}]},{"type":"paragraph","content":[{"text":"Trío Reynoso","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1966 the Trío Reynoso lost its accordionist, Pedro Reynoso, and took Tatico on. He played his first date with them at the Teatro Agua y Luz in Santo Domingo. He did not stay long: he left to form a band of his own, Tatico y sus Muchachos, and it was there that he did the work he is remembered for.","type":"text"}]},{"type":"paragraph","content":[{"text":"The ensemble he rebuilt","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The típico group of his day ran on diatonic accordion, güira, tambora, a marimba standing in for a bass, and now and then a saxophone. Tatico kept the accordion, the güira and the tambora and added congas, two saxophones harmonising with the accordion, and an electric bass in place of the marimba.","type":"text"}]},{"type":"paragraph","content":[{"text":"That line-up is what a típico band looks like today. The change is often described as modernisation, but it was closer to an argument: he made the folk ensemble loud and flexible enough to hold a dance floor without giving up the accordion at its centre.","type":"text"}]},{"type":"paragraph","content":[{"text":"Rescuing the genre","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The journalist Huchi Lora and the writer Rafael Chaljub Mejía have both argued that merengue entered a crisis after the killing of Trujillo in 1961, deep enough to threaten the form itself, and that musicians like Tatico brought it back by taking the country merengue and moving it forward from inside its own rhythm rather than replacing it.","type":"text"}]},{"type":"paragraph","content":[{"text":"He recorded a great many típico merengues, his own and those of composers such as Ñico Lora, along with old traditional pieces like El Telefonema. He also made a record with his brother Isaías, on which he only sang while Isaías played the accordion. Merengues..! appeared in 1970 and was followed by two further volumes and by A Gozar Con Tatico in 1974; the recordings issued after his death kept appearing for another three decades.","type":"text"}]},{"type":"paragraph","content":[{"text":"What came after","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He died in a road accident in Santiago on 23 May 1976, at thirty-two. The players who came up behind him carry his mark: ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9333da06-ad03-44eb-9b81-c21d0ccdd0ea","displayText":"Fefita la Grande","occurrenceId":"c173bfe8-1df1-45c0-9d25-3fd37e1eafe8"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ac087719-147c-47fa-9bb0-801f7a039ca7","displayText":"El Cieguito de Nagua","occurrenceId":"49a631ee-712b-4584-8473-71dfe628a6bd"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7a92e4df-157c-49d9-9905-17ac0f740c4e","displayText":"Rafaelito Román","occurrenceId":"1bf1ed34-84f7-4f73-ae0e-7604e324121f"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3680fc10-c3fd-42c4-ad54-90d79b226a7d","displayText":"Francisco Ulloa","occurrenceId":"97435912-dcf2-4cd8-9c22-0df214443591"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9127e809-a19c-44b8-a6e6-cee9335941bb","displayText":"Agapito Pascual","occurrenceId":"2cba7821-0764-45af-af1f-958b821de893"}},{"text":" were all named as his heirs, and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"4ef6e1e8-7096-4d74-9cce-4dd2302eeb7f"}},{"text":" recorded a song in his memory.","type":"text"}]},{"type":"paragraph","content":[{"text":"A bust of him was unveiled in 2001 in the park that carries his name, opposite the town hall in Nagua, and a documentary about him appeared five years later.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'tatico-henriquez'), 3)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Domingo García Henríquez, conocido en todas partes como Tatico, fue un acordeonista y cantante dominicano. Trabajó apenas una década y dejó el merengue típico cambiado para siempre: la instrumentación con la que se toca el género todavía hoy es la que él armó.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mata Bonita","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1943 en Mata Bonita, un paraje de Nagua, en la costa norte, en una familia campesina. Su padre, el acordeonista Juan Henríquez, le puso el instrumento en las manos, y después afinó la técnica con Ramón Mezquita. Empezó a darse a conocer en las fiestas patronales y las procesiones de su comarca, donde la música folclórica era repertorio de trabajo y no ejercicio de rescate.","type":"text"}]},{"type":"paragraph","content":[{"text":"Trío Reynoso","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1966 el Trío Reynoso perdió a su acordeonista, Pedro Reynoso, y tomó a Tatico. Su primera presentación con ellos fue en el Teatro Agua y Luz de Santo Domingo. No se quedó mucho: se fue a montar grupo propio, Tatico y sus Muchachos, y ahí hizo el trabajo por el que se le recuerda.","type":"text"}]},{"type":"paragraph","content":[{"text":"El conjunto que rearmó","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El conjunto típico de su tiempo iba con acordeón diatónico, güira, tambora, una marimba haciendo de bajo y de vez en cuando un saxofón. Tatico conservó el acordeón, la güira y la tambora, y añadió congas, dos saxofones armonizando con el acordeón, y un bajo eléctrico en lugar de la marimba.","type":"text"}]},{"type":"paragraph","content":[{"text":"Esa alineación es la que tiene hoy cualquier conjunto típico. El cambio suele contarse como modernización, pero se parece más a un argumento: hizo el conjunto folclórico lo bastante sonoro y flexible para sostener una pista de baile sin renunciar al acordeón en el centro.","type":"text"}]},{"type":"paragraph","content":[{"text":"El rescate del género","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El periodista Huchi Lora y el escritor Rafael Chaljub Mejía han sostenido los dos que el merengue entró en crisis tras el ajusticiamiento de Trujillo en 1961, una crisis honda como para amenazar al género mismo, y que músicos como Tatico lo devolvieron a la vida tomando el merengue campesino y haciéndolo evolucionar desde su propia rítmica en vez de sustituirla.","type":"text"}]},{"type":"paragraph","content":[{"text":"Grabó una cantidad enorme de merengues típicos, suyos y de compositores como Ñico Lora, además de piezas tradicionales viejas como El Telefonema. Hizo también un disco con su hermano Isaías en el que él solo cantaba mientras Isaías tocaba el acordeón. Merengues..! salió en 1970 y detrás vinieron dos volúmenes más y A Gozar Con Tatico en 1974; las grabaciones publicadas después de su muerte siguieron saliendo durante tres décadas.","type":"text"}]},{"type":"paragraph","content":[{"text":"Lo que vino después","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Murió en un accidente de tránsito en Santiago el 23 de mayo de 1976, a los treinta y dos años. Los que vinieron detrás llevan su marca: ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9333da06-ad03-44eb-9b81-c21d0ccdd0ea","displayText":"Fefita la Grande","occurrenceId":"1ea21a42-0bbd-41cf-8511-d3d4354fd288"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ac087719-147c-47fa-9bb0-801f7a039ca7","displayText":"El Cieguito de Nagua","occurrenceId":"ed412e95-0903-4ed4-ae10-a0ffc3a0c6a1"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7a92e4df-157c-49d9-9905-17ac0f740c4e","displayText":"Rafaelito Román","occurrenceId":"015e4660-c56c-4d86-97d6-998423b6198d"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3680fc10-c3fd-42c4-ad54-90d79b226a7d","displayText":"Francisco Ulloa","occurrenceId":"bbd508d8-2ad9-42c7-aef6-4fc02539deed"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9127e809-a19c-44b8-a6e6-cee9335941bb","displayText":"Agapito Pascual","occurrenceId":"ec692016-58f9-47db-b5fa-e6e224e7a800"}},{"text":" han sido señalados como sus herederos, y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"b82fa014-5a96-433b-9bd2-8f8a32d4c509"}},{"text":" le grabó un tema en su memoria.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 2001 se develó un busto suyo en el parque que lleva su nombre, frente al ayuntamiento de Nagua, y cinco años después salió un documental sobre él.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'tatico-henriquez'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez') AND locale = 'en'), '1bf1ed34-84f7-4f73-ae0e-7604e324121f', 'artist', '7a92e4df-157c-49d9-9905-17ac0f740c4e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez') AND locale = 'en'), '2cba7821-0764-45af-af1f-958b821de893', 'artist', '9127e809-a19c-44b8-a6e6-cee9335941bb');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez') AND locale = 'en'), '49a631ee-712b-4584-8473-71dfe628a6bd', 'artist', 'ac087719-147c-47fa-9bb0-801f7a039ca7');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez') AND locale = 'en'), '4ef6e1e8-7096-4d74-9cce-4dd2302eeb7f', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez') AND locale = 'en'), '97435912-dcf2-4cd8-9c22-0df214443591', 'artist', '3680fc10-c3fd-42c4-ad54-90d79b226a7d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez') AND locale = 'en'), 'c173bfe8-1df1-45c0-9d25-3fd37e1eafe8', 'artist', '9333da06-ad03-44eb-9b81-c21d0ccdd0ea');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez') AND locale = 'es'), '015e4660-c56c-4d86-97d6-998423b6198d', 'artist', '7a92e4df-157c-49d9-9905-17ac0f740c4e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez') AND locale = 'es'), '1ea21a42-0bbd-41cf-8511-d3d4354fd288', 'artist', '9333da06-ad03-44eb-9b81-c21d0ccdd0ea');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez') AND locale = 'es'), 'b82fa014-5a96-433b-9bd2-8f8a32d4c509', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez') AND locale = 'es'), 'bbd508d8-2ad9-42c7-aef6-4fc02539deed', 'artist', '3680fc10-c3fd-42c4-ad54-90d79b226a7d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez') AND locale = 'es'), 'ec692016-58f9-47db-b5fa-e6e224e7a800', 'artist', '9127e809-a19c-44b8-a6e6-cee9335941bb');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tatico-henriquez') AND locale = 'es'), 'ed412e95-0903-4ed4-ae10-a0ffc3a0c6a1', 'artist', 'ac087719-147c-47fa-9bb0-801f7a039ca7');

COMMIT;
