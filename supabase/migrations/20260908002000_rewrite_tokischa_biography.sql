BEGIN;

-- Rewrite the catalogue entry for Tokischa.
--
-- Tokischa. DUODÉCIMA de las dieciocho. La ficha vieja era de las mejores del
-- lote -- nombraba "Perra", a J Balvin, Rosalía, Madonna y Cardi B -- y aun así
-- tenía CERO enlaces y no nombraba A UN SOLO DOMINICANO, cuando ocho de sus
-- colaboradores están publicados en este catálogo.
--
-- Es el patrón del lote entero visto en su forma más clara: la ficha mira hacia
-- afuera y no ve el país. Una artista dominicana descrita solo por sus
-- colaboraciones internacionales queda contada como producto de exportación y
-- no como parte de una escena.
--
-- EL NOMBRE LEGAL ESTABA MAL PARTIDO. last_name decía 'Altagracia', que es su
-- segundo nombre, no un apellido. Se llama TOKISCHA ALTAGRACIA PERALTA JUÁREZ:
-- Peralta y Juárez son los apellidos. Se corrigen los cuatro campos.
--
-- aliases traía 'Altagracia Peralta' y 'Tokischa Altagracia Peralta', las dos
-- formas incompletas del nombre legal. OCTAVO caso del mismo defecto. Salen.
--
-- LA CENSURA SÍ ENTRA, y por partida doble, porque es censura DE LA OBRA:
--
--   "DESACATO ESCOLAR", octubre de 2020, con Yomel el Meloso y Leo RD, fue
--   retirada de YouTube por su letra. Ella respondió con un argumento sobre el
--   género que vale la pena recoger: el dembow cuenta lo que pasa en el barrio,
--   y quien se escandaliza no discute la canción sino la realidad que nombra.
--   Se PARAFRASEA y no se cita, que la cita es larga.
--
--   "PERRA", 2021, con J Balvin: el gobierno colombiano ordenó retirar el video
--   por racista, sexista y misógino. Se escribe el hecho tal cual, sin
--   defenderlo ni adornarlo. Un catálogo no elige cuál censura le conviene
--   contar.
--
-- Mismo criterio que con Ramón Leonardo y Jerry Vargas: cuando el Estado o una
-- plataforma actúa sobre la obra, eso es historia de la obra.
--
-- LO QUE SE DEJA FUERA, Y ES BASTANTE. La Wikipedia en español detalla que su
-- madre emigró, que su padre estuvo preso, que ella ejerció el trabajo sexual a
-- los dieciocho y su relación con las drogas. Nada de eso entra: vida privada,
-- asunto penal de un tercero, e intimidad. TAMPOCO ENTRA cómo se identifica en
-- lo sexual. SÍ ENTRA que su obra trata abiertamente el deseo y la sexualidad,
-- que es descripción del trabajo, y que Billboard la incluyó en una lista de
-- artistas que cambiaron el juego para el público queer, que es reconocimiento
-- profesional público.
--
-- NO SE ESCRIBEN LAS VISTAS. La fuente da "un millón de vistas la primera
-- semana" para "Pícala" y "más de cinco millones" para "Twerk". Son cifras de
-- plataforma. SÍ ENTRAN las posiciones de lista y las certificaciones, que son
-- hechos de industria: "Chulo pt. 2" entró en Hot Latin Songs y en el Billboard
-- Global 200, y está certificada séxtuple platino latino por la RIAA y oro en
-- México por AMPROFON.
--
-- LA FUENTE SE CONTRADICE SOBRE DÓNDE NACIÓ. El cuadro lateral de Wikipedia
-- dice Puerto Plata; el cuerpo del artículo dice Santo Domingo. La fila guarda
-- "Los Frailes, Santo Domingo Este", que es más específico que las dos y
-- coincide con el cuerpo. NO SE TOCA. El cuadro lateral se alimenta de Wikidata
-- y ahí está el error.
--
-- NUEVE ENLACES, TODOS DOMINICANOS Y TODOS POR CRÉDITO: tivi-gunz (su debut
-- "Pícala", y "Hoy Amanecí"), quimico-ultra-mega ("Que Viva", "Bellaca
-- Putona"), dj-scuff (el EP Freestyle #007), rochy-rd ("El Rey de la Popola"),
-- yailin-la-mas-viral ("Yo No Me Voy Acostar"), yomel-el-meloso y leo-rd
-- ("Desacato Escolar", y Leo RD además produjo "Linda"), natti-natasha (el
-- remix de "NO PARE") y bulin-47 ("CELOS").
--
-- NO SE ENLAZAN los extranjeros, que son muchos: J Balvin, Rosalía, Madonna,
-- A$AP Rocky, Marshmello, Anuel AA, Ñengo Flow, Ozuna, Natanael Cano, Bad Gyal,
-- Young Miko, Nathy Peluso, Arca, Sexyy Red, Ice Spice, Villano Antillano,
-- Eladio Carrión, Jamby el Favo.
--
-- LOS PREMIOS VAN EN MIGRACIÓN APARTE. Tenía CERO.
--
-- FUENTES: Wikipedia en español, extensa y con citas. Los ocho colaboradores se
-- comprobaron con verificar-faltantes.cjs contra el catálogo.
--
-- NOMBRES NUEVOS PARA LA LISTA: LA PERVERSA (ya estaba anotada) y EL JINCHO,
-- que no está. RAYMI PAULUS, el fotógrafo y productor que la descubrió y dueño
-- de Paulus Music, tampoco tiene ficha; es productor, y si el editor quiere
-- productores en el catálogo, ese entra.
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
       name = 'Tokischa',
       sort_name = 'Peralta Juárez, Tokischa Altagracia',
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urban-reggaeton',
       date_of_birth = '1996-03-17',
       birth_year = 1996,
       date_of_death = NULL,
       birth_place = 'Los Frailes, Santo Domingo Este',
       province = 'Santo Domingo',
       first_name = 'Tokischa',
       middle_name = 'Altagracia',
       last_name = 'Peralta',
       second_last_name = 'Juárez',
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '["songwriter","rapper","model"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY['urban-dembow']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@Tokischa',
       facebook = 'tokischamusic',
       instagram = 'tokischa.sol',
       disambiguation = 'Dembow and reggaetón singer whose explicit writing made her the most argued-about Dominican artist of her generation',
       bio_en = 'Tokischa Altagracia Peralta Juárez, who records as Tokischa, is a Dominican singer, rapper and songwriter working in dembow and reggaetón. She writes about sex, money and the street in plain language and without apology, which has made her the most argued-about Dominican artist of her generation and one of the few to carry dembow into rooms where nobody had heard it.

**Los Frailes**

She grew up in Los Frailes, in Santo Domingo Este. She studied fine arts and dramaturgy, went into professional modelling at sixteen, and was working in front of a camera when she met the photographer and producer Raymi Paulus at a shoot in the capital. He put her in a studio, and she signed to his label, Paulus Music.

**Pícala**

She debuted in 2018 with Pícala, made with Tivi Gunz, and followed it the same year with Que Viva alongside Químico Ultra Mega. The next two years were spent building a local catalogue at speed: the EP Freestyle #007 with DJ Scuff, Empatillada, Twerk, Varón, El Rey de la Popola with Rochy RD, and in early 2021 Yo No Me Voy Acostar with Yailin La Más Viral and Bellaca Putona with Químico Ultra Mega, which went to the top of the Dominican charts.

**Desacato Escolar**

In October 2020 she released Desacato Escolar with Yomel el Meloso and Leo RD. The song was pulled from YouTube over its lyrics, and the removal did what removals usually do, which is to send people looking for it.

Her answer to the objection was an argument about the genre rather than about herself: dembow and urban music report what happens in the neighbourhood, trap talks about crime because crime exists, and someone offended by a song about sex work is arguing with the fact and not with the record.

**Perra and Linda**

The summer of 2021 took her out of the country. She recorded Perra with J Balvin and Linda with Rosalía, both videos shot in Santo Domingo and the second produced by Leo RD. She performed Linda with Rosalía at the Billboard Latin Music Awards that September, and her label had by then signed a distribution deal with Roc Nation’s independent arm.

Perra was withdrawn after the Colombian government ordered its video taken down, judging its imagery racist, sexist and misogynistic. The record and the objection to it both belong to the history of the song.

**The collaborations**

What followed was a run of international work unusual for a dembow artist: Delincuente with Anuel AA and Ñengo Flow, which Time picked among the year’s best songs; Estilazo with Marshmello; Somos Iguales with Ozuna; La Combi Versace on Rosalía’s Motomami; Kilos de Amor with Natanael Cano; and a remix of Madonna’s Hung Up rebuilt over a dembow rhythm.

Her widest record so far is Chulo pt. 2, alongside Bad Gyal and Young Miko, which entered Hot Latin Songs and the Billboard Global 200 and was certified six times platinum in the Latin field in the United States and gold in Mexico. She also appeared on the remix of NO PARE by Natti Natasha.

**Amor y Droga**

She left Paulus Music in 2024 to start a label of her own, backed by Warner Music Latina and Atlantic Records, and opened it with Sol, a song she had written as a party record and came to read as a statement about coming out the other side of a bad stretch. De Maravisha, with Nathy Peluso, brought her a first Latin Grammy nomination in 2025.

Her debut album, Amor y Droga, arrived in 2026, trailed by MIAMI and by CELOS with Bulin 47. Billboard has placed her among the artists who changed the game for queer audiences in Latin music, and her writing on desire and sexuality is the part of her work that criticism keeps returning to.',
       bio_es = 'Tokischa Altagracia Peralta Juárez, que graba como Tokischa, es una cantante, rapera y compositora dominicana de dembow y reguetón. Escribe sobre sexo, dinero y calle en lengua directa y sin disculparse, lo que la ha convertido en la artista dominicana más discutida de su generación y en una de las pocas que ha metido el dembow en salas donde nadie lo había oído.

**Los Frailes**

Se crió en Los Frailes, en Santo Domingo Este. Estudió bellas artes y dramaturgia, entró al modelaje profesional a los dieciséis, y estaba trabajando delante de una cámara cuando conoció al fotógrafo y productor Raymi Paulus en una sesión en la capital. Él la metió en un estudio, y ella firmó con su sello, Paulus Music.

**Pícala**

Debutó en 2018 con Pícala, hecha con Tivi Gunz, y ese mismo año sacó Que Viva junto a Químico Ultra Mega. Los dos años siguientes los pasó armando catálogo local a toda velocidad: el EP Freestyle #007 con DJ Scuff, Empatillada, Twerk, Varón, El Rey de la Popola con Rochy RD, y a principios de 2021 Yo No Me Voy Acostar con Yailin La Más Viral y Bellaca Putona con Químico Ultra Mega, que encabezó las listas dominicanas.

**Desacato Escolar**

En octubre de 2020 publicó Desacato Escolar con Yomel el Meloso y Leo RD. La canción fue retirada de YouTube por su letra, y el retiro hizo lo que suelen hacer los retiros, que es mandar a la gente a buscarla.

Su respuesta a la objeción fue un argumento sobre el género y no sobre ella: el dembow y la música urbana cuentan lo que pasa en el barrio, el trap habla de delincuencia porque la delincuencia existe, y quien se ofende con una canción sobre prostitución está discutiendo con el hecho y no con el disco.

**Perra y Linda**

El verano de 2021 la sacó del país. Grabó Perra con J Balvin y Linda con Rosalía, los dos videos rodados en Santo Domingo y el segundo producido por Leo RD. Cantó Linda junto a Rosalía en los Premios Billboard de la Música Latina ese septiembre, y su sello ya había firmado para entonces un acuerdo de distribución con el brazo independiente de Roc Nation.

Perra fue retirada después de que el gobierno colombiano ordenara bajar el video, por considerar sus imágenes racistas, sexistas y misóginas. El disco y la objeción que se le hizo pertenecen los dos a la historia de la canción.

**Las colaboraciones**

Detrás vino una racha de trabajo internacional poco común para una artista de dembow: Delincuente con Anuel AA y Ñengo Flow, que la revista Time escogió entre las mejores canciones del año; Estilazo con Marshmello; Somos Iguales con Ozuna; La Combi Versace dentro del Motomami de Rosalía; Kilos de Amor con Natanael Cano; y un remix del Hung Up de Madonna rearmado sobre un ritmo de dembow.

Su disco de mayor alcance hasta ahora es Chulo pt. 2, junto a Bad Gyal y Young Miko, que entró en Hot Latin Songs y en el Billboard Global 200 y está certificado séxtuple platino en el campo latino de Estados Unidos y oro en México. Estuvo además en el remix de NO PARE de Natti Natasha.

**Amor y Droga**

Dejó Paulus Music en 2024 para montar sello propio, respaldada por Warner Music Latina y Atlantic Records, y lo estrenó con Sol, una canción que había escrito como tema de fiesta y que terminó leyendo como una afirmación sobre salir de una mala racha. De Maravisha, con Nathy Peluso, le trajo su primera nominación al Latin Grammy en 2025.

Su álbum debut, Amor y Droga, salió en 2026, precedido por MIAMI y por CELOS con Bulin 47. Billboard la ha situado entre los artistas que cambiaron el juego para el público queer de la música latina, y su escritura sobre el deseo y la sexualidad es la parte de su obra sobre la que la crítica vuelve una y otra vez.',
       updated_at = now()
 WHERE slug = 'tokischa';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Tokischa Altagracia Peralta Juárez, who records as Tokischa, is a Dominican singer, rapper and songwriter working in dembow and reggaetón. She writes about sex, money and the street in plain language and without apology, which has made her the most argued-about Dominican artist of her generation and one of the few to carry dembow into rooms where nobody had heard it.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Frailes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She grew up in Los Frailes, in Santo Domingo Este. She studied fine arts and dramaturgy, went into professional modelling at sixteen, and was working in front of a camera when she met the photographer and producer Raymi Paulus at a shoot in the capital. He put her in a studio, and she signed to his label, Paulus Music.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pícala","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She debuted in 2018 with Pícala, made with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"95e181f1-58e5-4537-a5e8-75a9f60c6aca","displayText":"Tivi Gunz","occurrenceId":"3e1e58d4-bf80-428d-9a7b-976a61d7754c"}},{"text":", and followed it the same year with Que Viva alongside ","type":"text"},{"type":"artistReference","attrs":{"artistId":"de562eb7-a0fb-49c2-a3c8-db97a4be80e3","displayText":"Químico Ultra Mega","occurrenceId":"6669bb6f-9afa-4d1f-ba93-5ca14877aa13"}},{"text":". The next two years were spent building a local catalogue at speed: the EP Freestyle #007 with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9bf41d47-c5ab-45e3-b048-7bb7886b0912","displayText":"DJ Scuff","occurrenceId":"7f561afd-9801-48cd-82cb-98b33c1f9415"}},{"text":", Empatillada, Twerk, Varón, El Rey de la Popola with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb","displayText":"Rochy RD","occurrenceId":"947a11eb-3ed9-4ba6-b75c-41f3f2bac591"}},{"text":", and in early 2021 Yo No Me Voy Acostar with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"439bbc6c-f06e-447f-a1fa-b2130b885457","displayText":"Yailin La Más Viral","occurrenceId":"741b1b4c-56a1-4717-858b-8b492e6d292d"}},{"text":" and Bellaca Putona with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"de562eb7-a0fb-49c2-a3c8-db97a4be80e3","displayText":"Químico Ultra Mega","occurrenceId":"da45a139-7d22-4710-a098-0b5d080a0f9a"}},{"text":", which went to the top of the Dominican charts.","type":"text"}]},{"type":"paragraph","content":[{"text":"Desacato Escolar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In October 2020 she released Desacato Escolar with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bb07dcb8-444f-4a68-a668-21e9e038f335","displayText":"Yomel el Meloso","occurrenceId":"11541a21-4a35-4f57-9a8e-f1b94cbd303a"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5cbc8f2b-cb68-4ebd-8006-6837be54bbe4","displayText":"Leo RD","occurrenceId":"52c7cfd8-7d61-4968-9b08-56c44e7f9668"}},{"text":". The song was pulled from YouTube over its lyrics, and the removal did what removals usually do, which is to send people looking for it.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her answer to the objection was an argument about the genre rather than about herself: dembow and urban music report what happens in the neighbourhood, trap talks about crime because crime exists, and someone offended by a song about sex work is arguing with the fact and not with the record.","type":"text"}]},{"type":"paragraph","content":[{"text":"Perra and Linda","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The summer of 2021 took her out of the country. She recorded Perra with J Balvin and Linda with Rosalía, both videos shot in Santo Domingo and the second produced by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5cbc8f2b-cb68-4ebd-8006-6837be54bbe4","displayText":"Leo RD","occurrenceId":"b029527e-869e-4add-b10b-fd8163d18354"}},{"text":". She performed Linda with Rosalía at the Billboard Latin Music Awards that September, and her label had by then signed a distribution deal with Roc Nation’s independent arm.","type":"text"}]},{"type":"paragraph","content":[{"text":"Perra was withdrawn after the Colombian government ordered its video taken down, judging its imagery racist, sexist and misogynistic. The record and the objection to it both belong to the history of the song.","type":"text"}]},{"type":"paragraph","content":[{"text":"The collaborations","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"What followed was a run of international work unusual for a dembow artist: Delincuente with Anuel AA and Ñengo Flow, which Time picked among the year’s best songs; Estilazo with Marshmello; Somos Iguales with Ozuna; La Combi Versace on Rosalía’s Motomami; Kilos de Amor with Natanael Cano; and a remix of Madonna’s Hung Up rebuilt over a dembow rhythm.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her widest record so far is Chulo pt. 2, alongside Bad Gyal and Young Miko, which entered Hot Latin Songs and the Billboard Global 200 and was certified six times platinum in the Latin field in the United States and gold in Mexico. She also appeared on the remix of NO PARE by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"af726afa-c7a0-47da-99bb-a4c7669a8785","displayText":"Natti Natasha","occurrenceId":"c61b6542-3152-4614-8b3d-9e7f61c3c871"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Amor y Droga","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She left Paulus Music in 2024 to start a label of her own, backed by Warner Music Latina and Atlantic Records, and opened it with Sol, a song she had written as a party record and came to read as a statement about coming out the other side of a bad stretch. De Maravisha, with Nathy Peluso, brought her a first Latin Grammy nomination in 2025.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her debut album, Amor y Droga, arrived in 2026, trailed by MIAMI and by CELOS with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47","occurrenceId":"4711433b-d267-41b7-885e-7bfbd4317f4c"}},{"text":". Billboard has placed her among the artists who changed the game for queer audiences in Latin music, and her writing on desire and sexuality is the part of her work that criticism keeps returning to.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'tokischa'), 3)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Tokischa Altagracia Peralta Juárez, que graba como Tokischa, es una cantante, rapera y compositora dominicana de dembow y reguetón. Escribe sobre sexo, dinero y calle en lengua directa y sin disculparse, lo que la ha convertido en la artista dominicana más discutida de su generación y en una de las pocas que ha metido el dembow en salas donde nadie lo había oído.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Frailes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se crió en Los Frailes, en Santo Domingo Este. Estudió bellas artes y dramaturgia, entró al modelaje profesional a los dieciséis, y estaba trabajando delante de una cámara cuando conoció al fotógrafo y productor Raymi Paulus en una sesión en la capital. Él la metió en un estudio, y ella firmó con su sello, Paulus Music.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pícala","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Debutó en 2018 con Pícala, hecha con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"95e181f1-58e5-4537-a5e8-75a9f60c6aca","displayText":"Tivi Gunz","occurrenceId":"d5339e85-db48-4cec-acd4-6db470655f39"}},{"text":", y ese mismo año sacó Que Viva junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"de562eb7-a0fb-49c2-a3c8-db97a4be80e3","displayText":"Químico Ultra Mega","occurrenceId":"c0be34a8-8cdf-46fc-9f09-60d4d97a6a07"}},{"text":". Los dos años siguientes los pasó armando catálogo local a toda velocidad: el EP Freestyle #007 con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9bf41d47-c5ab-45e3-b048-7bb7886b0912","displayText":"DJ Scuff","occurrenceId":"153bd91d-fcec-4579-b80e-e4845f1f67ed"}},{"text":", Empatillada, Twerk, Varón, El Rey de la Popola con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb","displayText":"Rochy RD","occurrenceId":"c922e31b-fc5d-4108-97dc-378301d16be5"}},{"text":", y a principios de 2021 Yo No Me Voy Acostar con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"439bbc6c-f06e-447f-a1fa-b2130b885457","displayText":"Yailin La Más Viral","occurrenceId":"68b425a6-0c0a-4694-94a3-876bbcd47d6a"}},{"text":" y Bellaca Putona con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"de562eb7-a0fb-49c2-a3c8-db97a4be80e3","displayText":"Químico Ultra Mega","occurrenceId":"7b3d4fce-9756-4cf5-b4b3-6f8ae254563b"}},{"text":", que encabezó las listas dominicanas.","type":"text"}]},{"type":"paragraph","content":[{"text":"Desacato Escolar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En octubre de 2020 publicó Desacato Escolar con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bb07dcb8-444f-4a68-a668-21e9e038f335","displayText":"Yomel el Meloso","occurrenceId":"4c977d29-e745-4053-9579-3a5269816f13"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5cbc8f2b-cb68-4ebd-8006-6837be54bbe4","displayText":"Leo RD","occurrenceId":"f940bcd5-e5c6-4ac5-bd0e-77211e5841db"}},{"text":". La canción fue retirada de YouTube por su letra, y el retiro hizo lo que suelen hacer los retiros, que es mandar a la gente a buscarla.","type":"text"}]},{"type":"paragraph","content":[{"text":"Su respuesta a la objeción fue un argumento sobre el género y no sobre ella: el dembow y la música urbana cuentan lo que pasa en el barrio, el trap habla de delincuencia porque la delincuencia existe, y quien se ofende con una canción sobre prostitución está discutiendo con el hecho y no con el disco.","type":"text"}]},{"type":"paragraph","content":[{"text":"Perra y Linda","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El verano de 2021 la sacó del país. Grabó Perra con J Balvin y Linda con Rosalía, los dos videos rodados en Santo Domingo y el segundo producido por ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5cbc8f2b-cb68-4ebd-8006-6837be54bbe4","displayText":"Leo RD","occurrenceId":"0d359258-0913-4bfe-8cb1-20aa590c16cb"}},{"text":". Cantó Linda junto a Rosalía en los Premios Billboard de la Música Latina ese septiembre, y su sello ya había firmado para entonces un acuerdo de distribución con el brazo independiente de Roc Nation.","type":"text"}]},{"type":"paragraph","content":[{"text":"Perra fue retirada después de que el gobierno colombiano ordenara bajar el video, por considerar sus imágenes racistas, sexistas y misóginas. El disco y la objeción que se le hizo pertenecen los dos a la historia de la canción.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las colaboraciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Detrás vino una racha de trabajo internacional poco común para una artista de dembow: Delincuente con Anuel AA y Ñengo Flow, que la revista Time escogió entre las mejores canciones del año; Estilazo con Marshmello; Somos Iguales con Ozuna; La Combi Versace dentro del Motomami de Rosalía; Kilos de Amor con Natanael Cano; y un remix del Hung Up de Madonna rearmado sobre un ritmo de dembow.","type":"text"}]},{"type":"paragraph","content":[{"text":"Su disco de mayor alcance hasta ahora es Chulo pt. 2, junto a Bad Gyal y Young Miko, que entró en Hot Latin Songs y en el Billboard Global 200 y está certificado séxtuple platino en el campo latino de Estados Unidos y oro en México. Estuvo además en el remix de NO PARE de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"af726afa-c7a0-47da-99bb-a4c7669a8785","displayText":"Natti Natasha","occurrenceId":"60f7e5bd-58af-4afd-9185-2934c4bbfade"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Amor y Droga","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Dejó Paulus Music en 2024 para montar sello propio, respaldada por Warner Music Latina y Atlantic Records, y lo estrenó con Sol, una canción que había escrito como tema de fiesta y que terminó leyendo como una afirmación sobre salir de una mala racha. De Maravisha, con Nathy Peluso, le trajo su primera nominación al Latin Grammy en 2025.","type":"text"}]},{"type":"paragraph","content":[{"text":"Su álbum debut, Amor y Droga, salió en 2026, precedido por MIAMI y por CELOS con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47","occurrenceId":"b1eebe28-907d-4231-a260-c77ea686dbab"}},{"text":". Billboard la ha situado entre los artistas que cambiaron el juego para el público queer de la música latina, y su escritura sobre el deseo y la sexualidad es la parte de su obra sobre la que la crítica vuelve una y otra vez.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'tokischa'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'en'), '11541a21-4a35-4f57-9a8e-f1b94cbd303a', 'artist', 'bb07dcb8-444f-4a68-a668-21e9e038f335');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'en'), '3e1e58d4-bf80-428d-9a7b-976a61d7754c', 'artist', '95e181f1-58e5-4537-a5e8-75a9f60c6aca');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'en'), '4711433b-d267-41b7-885e-7bfbd4317f4c', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'en'), '52c7cfd8-7d61-4968-9b08-56c44e7f9668', 'artist', '5cbc8f2b-cb68-4ebd-8006-6837be54bbe4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'en'), '6669bb6f-9afa-4d1f-ba93-5ca14877aa13', 'artist', 'de562eb7-a0fb-49c2-a3c8-db97a4be80e3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'en'), '741b1b4c-56a1-4717-858b-8b492e6d292d', 'artist', '439bbc6c-f06e-447f-a1fa-b2130b885457');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'en'), '7f561afd-9801-48cd-82cb-98b33c1f9415', 'artist', '9bf41d47-c5ab-45e3-b048-7bb7886b0912');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'en'), '947a11eb-3ed9-4ba6-b75c-41f3f2bac591', 'artist', '71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'en'), 'b029527e-869e-4add-b10b-fd8163d18354', 'artist', '5cbc8f2b-cb68-4ebd-8006-6837be54bbe4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'en'), 'c61b6542-3152-4614-8b3d-9e7f61c3c871', 'artist', 'af726afa-c7a0-47da-99bb-a4c7669a8785');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'en'), 'da45a139-7d22-4710-a098-0b5d080a0f9a', 'artist', 'de562eb7-a0fb-49c2-a3c8-db97a4be80e3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'es'), '0d359258-0913-4bfe-8cb1-20aa590c16cb', 'artist', '5cbc8f2b-cb68-4ebd-8006-6837be54bbe4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'es'), '153bd91d-fcec-4579-b80e-e4845f1f67ed', 'artist', '9bf41d47-c5ab-45e3-b048-7bb7886b0912');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'es'), '4c977d29-e745-4053-9579-3a5269816f13', 'artist', 'bb07dcb8-444f-4a68-a668-21e9e038f335');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'es'), '60f7e5bd-58af-4afd-9185-2934c4bbfade', 'artist', 'af726afa-c7a0-47da-99bb-a4c7669a8785');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'es'), '68b425a6-0c0a-4694-94a3-876bbcd47d6a', 'artist', '439bbc6c-f06e-447f-a1fa-b2130b885457');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'es'), '7b3d4fce-9756-4cf5-b4b3-6f8ae254563b', 'artist', 'de562eb7-a0fb-49c2-a3c8-db97a4be80e3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'es'), 'b1eebe28-907d-4231-a260-c77ea686dbab', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'es'), 'c0be34a8-8cdf-46fc-9f09-60d4d97a6a07', 'artist', 'de562eb7-a0fb-49c2-a3c8-db97a4be80e3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'es'), 'c922e31b-fc5d-4108-97dc-378301d16be5', 'artist', '71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'es'), 'd5339e85-db48-4cec-acd4-6db470655f39', 'artist', '95e181f1-58e5-4537-a5e8-75a9f60c6aca');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tokischa') AND locale = 'es'), 'f940bcd5-e5c6-4ac5-bd0e-77211e5841db', 'artist', '5cbc8f2b-cb68-4ebd-8006-6837be54bbe4');

COMMIT;
