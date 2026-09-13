BEGIN;

-- Rewrite the catalogue entry for Bulin 47.
--
-- Bulin 47. CUARTA de las 211, con 20 enlaces entrantes. Y EL PEOR ERROR DE
-- DATO DE TODA LA CORRIDA: LA FILA GUARDABA UN NOMBRE LEGAL QUE NO EXISTE.
--
-- ---------------------------------------------------------------------------
-- EL NOMBRE LEGAL ERA FALSO
--
-- La fila decía first_name 'Hanthony', middle_name 'Dawson', last_name
-- 'Hurtado', y llevaba "Hanthony Hurtado" entre los alias.
--
-- SE LLAMA HANCEL TEODORO VARGAS REYNOSO. Lo dice EL CANAL OFICIAL DEL PROPIO
-- ARTISTA -- el mismo handle @Bulin47Music que la fila ya tenía guardado --, en
-- la primera línea de su página de información: "Hancel Teodoro Vargas Reynoso,
-- mejor conocido como Bulin 47". Lo fui a leer al origen, no al buscador.
-- BuenaMusica dice exactamente lo mismo.
--
-- Y AL REVÉS: buscar "Hanthony Dawson" en la web devuelve CERO RESULTADOS.
-- Buscar "Hanthony Hurtado Bulin 47" también. Ese nombre no existe en ninguna
-- parte fuera de esta base de datos.
--
-- Es más grave que un acento o una fecha: es la identidad civil de una persona
-- viva, publicada y equivocada. Se corrigen los cuatro campos y sale el alias.
-- ---------------------------------------------------------------------------
--
-- CONFLICTO DE FECHA QUE NO RESUELVO. La fila guarda el 20 DE NOVIEMBRE de 1989
-- y BuenaMusica dice el 23. Una fuente cada uno, y la de la fila acaba de
-- demostrarse poco fiable en el nombre, lo que no la desmiente pero tampoco la
-- respalda. NO TOCO EL CAMPO y el texto dice solo 1989. Queda para el editor.
--
-- LA FICHA VIEJA ERA 1.144 CARACTERES SIN UNA CANCIÓN, sin un año y sin un
-- colaborador, y encima NOMBRABA A LÁPIZ CONCIENTE EN PROSA SIN ENLAZARLO, en
-- una comparación que no venía de ninguna fuente: "a scene capacious enough to
-- accommodate both the lyrical seriousness of artists like Lápiz Conciente and
-- the playful energy of entertainers like Bulin 47". Eso es opinión del
-- redactor sobre dos artistas a la vez. Fuera. Lo curioso es que sí existe una
-- relación real entre ellos y no la contaba: GRABARON JUNTOS "El Que Sabe Sabe"
-- en 2022. Ahora va enlazada y con crédito.
--
-- LA DEMANDA POR "BAJO MUNDO" SÍ ENTRA. En 2021 Lio "El Más Duro" lo demandó
-- por cincuenta millones de pesos alegando plagio de ese tema, y él respondió
-- públicamente que "bajo mundo" es expresión de dominio público. ES UNA DISPUTA
-- DE CRÉDITOS Y AUTORÍA, que es de las cosas que este catálogo sí registra --
-- no es asunto penal, es una reclamación civil sobre quién escribió qué.
--
-- SU RESPUESTA SE PARAFRASEA y no se reproduce entera.
--
-- NO SE ESCRIBEN LAS REPRODUCCIONES ni los suscriptores, que su canal muestra
-- en grande.
--
-- OCHO ENLACES, TODOS POR CRÉDITO DOCUMENTADO: kiko-el-crazy ("Prendía"),
-- ceky-viciny ("Ta Talde Pah" y la tanda de 2020), don-miguelo,
-- el-mayor-clasico, yomel-el-meloso y rochy-rd (2020), lapiz-conciente ("El Que
-- Sabe Sabe", 2022) y tokischa ("CELOS", 2025 -- ENLACE RECÍPROCO, porque lo
-- escribí en la ficha de ella hace unas horas).
--
-- NO SE ENLAZAN los extranjeros: Myke Towers, Pitbull, IAmChino.
--
-- occupations estaba VACÍO para un cantautor que además es comediante. Entra
-- 'comedian', que el catálogo ya usa, porque el humor no es un adorno de su
-- carrera sino de dónde viene: se hizo conocido con videos de humor ANTES de
-- cantar.
--
-- FUENTES: la página de información del canal oficial @Bulin47Music, leída en
-- el origen, para el nombre legal. BuenaMusica para la cronología, los discos y
-- los colaboradores. El propio canal para lo más reciente. NO HAY artículo de
-- Wikipedia sobre él, ni en español ni en inglés: tercera ficha de la corrida en
-- esa situación, después de Carlos Piantini y Aramis Camilo.
--
-- NOMBRES NUEVOS PARA LA LISTA: BULOVA (ya estaba anotado), BRAULIO FOGÓN (ya
-- estaba), LIRO SHAQ (anotado ayer con Mozart) y AFRIKEN AN, que grabó con él
-- el "Leo Leo Remix" y no está.
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
       name = 'Bulin 47',
       sort_name = 'Vargas Reynoso, Hancel Teodoro',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urban-dembow',
       date_of_birth = '1989-11-20',
       birth_year = 1989,
       date_of_death = NULL,
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = 'Hancel',
       middle_name = 'Teodoro',
       last_name = 'Vargas',
       second_last_name = 'Reynoso',
       stage_name = 'Bulin 47',
       aliases = ARRAY[]::text[],
       occupations = '["songwriter","comedian"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY['urbano']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@Bulin47Music',
       facebook = 'Bulin47Oficcial',
       instagram = 'bulin47_oficial',
       disambiguation = 'Dembow singer and comedian; came to music through humour videos',
       bio_en = 'Hancel Teodoro Vargas Reynoso, who records as Bulin 47, is a Dominican dembow singer, songwriter and comedian. He arrived at music through comedy rather than the other way round, and the timing of a joke is still the thing his records are built on.

**From the videos**

He was born in 1989 and made his name with humour videos before he sang anything. That order matters: the comic persona was already established when the music started, and it gave him a way into the genre that did not depend on out-toughing anyone.

The first songs went up on his own social accounts in 2016 — 7 Pollos, Lo Que Fue, El Licey and Bélico y Maquillaje — and the audience that had come for the jokes stayed for them.

**El Rey de las Dagor**

The album El Rey de las Dagor followed in 2017. Quién Lo Vio, Deja de Hablar de Mí, Chupirupi and Va Seguí came over the next two years, along with Prendía, made with Kiko el Crazy.

**The collaborations**

In 2020 he worked across most of the Dominican urban scene at once, recording with Don Miguelo, Ceky Viciny, El Mayor Clásico, Yomel el Meloso and Rochy RD. Bajo Mundo, Lo Cualto Tan Hecho, Si Hay Mujeres, Piki Pau and Pa’ Que Respete came in 2021, the last of them alongside a run of dates in Miami.

El Que Sabe Sabe, in 2022, was made with Lápiz Conciente, which put the comedian next to the man the scene treats as its founder. Mi Tranza, Vivo por Palomo and Fundia followed in 2023, and he recorded Party with IAmChino and Pitbull. A new version of Mi Tranza with the Puerto Rican Myke Towers came in 2024.

In 2025 he appeared on CELOS with Tokischa. His own recent records — Calorazo, Me La Sube, Ta Talde Pah with Ceky Viciny, the Leo Leo remix with Afriken An and Toy Al 100 — have kept him among the most played dembow artists in the country.

**Bajo Mundo**

In 2021 the artist Lio El Más Duro brought a claim against him over Bajo Mundo, asking fifty million pesos and alleging that the song was plagiarised. Bulin answered in public that bajo mundo is an expression in common use and that it had been popularised by a television programme rather than by any songwriter, and asked what exactly the plagiarism was supposed to be.

The dispute is worth recording because it is about authorship rather than about conduct: it turns on whether a phrase everybody says can belong to anyone, which is a question dembow raises constantly and settles rarely.',
       bio_es = 'Hancel Teodoro Vargas Reynoso, que graba como Bulin 47, es un cantante, compositor y comediante dominicano de dembow. Llegó a la música desde el humor y no al revés, y el tiempo de un chiste sigue siendo aquello sobre lo que están armados sus discos.

**Desde los videos**

Nació en 1989 y se hizo un nombre con videos de humor antes de cantar nada. Ese orden importa: el personaje cómico ya estaba hecho cuando empezó la música, y le dio una entrada al género que no dependía de ser más duro que nadie.

Las primeras canciones las subió a sus propias redes en 2016 — 7 Pollos, Lo Que Fue, El Licey y Bélico y Maquillaje — y el público que había llegado por los chistes se quedó con ellas.

**El Rey de las Dagor**

El disco El Rey de las Dagor salió en 2017. Detrás vinieron, en los dos años siguientes, Quién Lo Vio, Deja de Hablar de Mí, Chupirupi y Va Seguí, además de Prendía, hecha con Kiko el Crazy.

**Las colaboraciones**

En 2020 trabajó con media escena urbana dominicana a la vez, grabando con Don Miguelo, Ceky Viciny, El Mayor Clásico, Yomel el Meloso y Rochy RD. Bajo Mundo, Lo Cualto Tan Hecho, Si Hay Mujeres, Piki Pau y Pa’ Que Respete salieron en 2021, la última junto a una tanda de presentaciones en Miami.

El Que Sabe Sabe, de 2022, la hizo con Lápiz Conciente, lo que puso al comediante al lado del hombre al que la escena trata como su fundador. Mi Tranza, Vivo por Palomo y Fundia vinieron en 2023, y grabó Party con IAmChino y Pitbull. Una versión nueva de Mi Tranza con el puertorriqueño Myke Towers salió en 2024.

En 2025 apareció en CELOS con Tokischa. Sus discos recientes — Calorazo, Me La Sube, Ta Talde Pah con Ceky Viciny, el remix de Leo Leo con Afriken An y Toy Al 100 — lo han mantenido entre los artistas de dembow que más suenan en el país.

**Bajo Mundo**

En 2021 el artista Lio El Más Duro le puso una demanda por Bajo Mundo, pidiendo cincuenta millones de pesos y alegando plagio. Bulin respondió en público que bajo mundo es una expresión de uso común y que quien la popularizó fue un programa de televisión y no ningún compositor, y preguntó dónde estaba exactamente el plagio.

La disputa vale la pena registrarla porque es sobre autoría y no sobre conducta: se juega en si una frase que dice todo el mundo puede pertenecerle a alguien, que es una pregunta que el dembow plantea todo el tiempo y resuelve pocas veces.',
       updated_at = now()
 WHERE slug = 'bulin-47';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Hancel Teodoro Vargas Reynoso, who records as Bulin 47, is a Dominican dembow singer, songwriter and comedian. He arrived at music through comedy rather than the other way round, and the timing of a joke is still the thing his records are built on.","type":"text"}]},{"type":"paragraph","content":[{"text":"From the videos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1989 and made his name with humour videos before he sang anything. That order matters: the comic persona was already established when the music started, and it gave him a way into the genre that did not depend on out-toughing anyone.","type":"text"}]},{"type":"paragraph","content":[{"text":"The first songs went up on his own social accounts in 2016 — 7 Pollos, Lo Que Fue, El Licey and Bélico y Maquillaje — and the audience that had come for the jokes stayed for them.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Rey de las Dagor","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The album El Rey de las Dagor followed in 2017. Quién Lo Vio, Deja de Hablar de Mí, Chupirupi and Va Seguí came over the next two years, along with Prendía, made with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9be0ed08-6eb6-4ca0-bb68-d5126190aeb1","displayText":"Kiko el Crazy","occurrenceId":"2438449f-885f-47d1-808e-9a1cdc039282"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"The collaborations","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2020 he worked across most of the Dominican urban scene at once, recording with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"514f6e5e-8f70-4028-a462-019a3319628c"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"741eb4c0-4ab8-4ad5-8a64-2f156da6a395","displayText":"Ceky Viciny","occurrenceId":"13f98b37-d0a0-4c4c-8d24-9b906865bcb1"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"518354a4-7cb9-4c39-a2b8-9fa4d18f50db","displayText":"El Mayor Clásico","occurrenceId":"dd7c030d-c97e-41f2-a3a4-f543bd25e962"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bb07dcb8-444f-4a68-a668-21e9e038f335","displayText":"Yomel el Meloso","occurrenceId":"66f52d95-ed4f-41ae-9e41-cb67e5c10d41"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb","displayText":"Rochy RD","occurrenceId":"1d35a53e-0400-4b39-8809-e0d92f6a2097"}},{"text":". Bajo Mundo, Lo Cualto Tan Hecho, Si Hay Mujeres, Piki Pau and Pa’ Que Respete came in 2021, the last of them alongside a run of dates in Miami.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Que Sabe Sabe, in 2022, was made with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente","occurrenceId":"41eed155-e937-4b18-8f76-e7d3186a84a9"}},{"text":", which put the comedian next to the man the scene treats as its founder. Mi Tranza, Vivo por Palomo and Fundia followed in 2023, and he recorded Party with IAmChino and Pitbull. A new version of Mi Tranza with the Puerto Rican Myke Towers came in 2024.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 2025 he appeared on CELOS with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3e1718be-c12d-42f5-85e7-2156d9574940","displayText":"Tokischa","occurrenceId":"d63f109a-b30a-49be-9e41-143f29b9c0f1"}},{"text":". His own recent records — Calorazo, Me La Sube, Ta Talde Pah with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"741eb4c0-4ab8-4ad5-8a64-2f156da6a395","displayText":"Ceky Viciny","occurrenceId":"8dc07975-d273-4df4-b649-fb582087e643"}},{"text":", the Leo Leo remix with Afriken An and Toy Al 100 — have kept him among the most played dembow artists in the country.","type":"text"}]},{"type":"paragraph","content":[{"text":"Bajo Mundo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2021 the artist Lio El Más Duro brought a claim against him over Bajo Mundo, asking fifty million pesos and alleging that the song was plagiarised. Bulin answered in public that bajo mundo is an expression in common use and that it had been popularised by a television programme rather than by any songwriter, and asked what exactly the plagiarism was supposed to be.","type":"text"}]},{"type":"paragraph","content":[{"text":"The dispute is worth recording because it is about authorship rather than about conduct: it turns on whether a phrase everybody says can belong to anyone, which is a question dembow raises constantly and settles rarely.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'bulin-47'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Hancel Teodoro Vargas Reynoso, que graba como Bulin 47, es un cantante, compositor y comediante dominicano de dembow. Llegó a la música desde el humor y no al revés, y el tiempo de un chiste sigue siendo aquello sobre lo que están armados sus discos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Desde los videos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1989 y se hizo un nombre con videos de humor antes de cantar nada. Ese orden importa: el personaje cómico ya estaba hecho cuando empezó la música, y le dio una entrada al género que no dependía de ser más duro que nadie.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las primeras canciones las subió a sus propias redes en 2016 — 7 Pollos, Lo Que Fue, El Licey y Bélico y Maquillaje — y el público que había llegado por los chistes se quedó con ellas.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Rey de las Dagor","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El disco El Rey de las Dagor salió en 2017. Detrás vinieron, en los dos años siguientes, Quién Lo Vio, Deja de Hablar de Mí, Chupirupi y Va Seguí, además de Prendía, hecha con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9be0ed08-6eb6-4ca0-bb68-d5126190aeb1","displayText":"Kiko el Crazy","occurrenceId":"970d1968-d52d-4000-b8ca-7b232172556e"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Las colaboraciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2020 trabajó con media escena urbana dominicana a la vez, grabando con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"ffa55ec2-b035-4148-be66-ec0b0c293488"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"741eb4c0-4ab8-4ad5-8a64-2f156da6a395","displayText":"Ceky Viciny","occurrenceId":"78fe3064-8ef4-489a-a4d0-9ebe1ffecb41"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"518354a4-7cb9-4c39-a2b8-9fa4d18f50db","displayText":"El Mayor Clásico","occurrenceId":"d861beb3-be0e-4ee8-868f-074886d83842"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bb07dcb8-444f-4a68-a668-21e9e038f335","displayText":"Yomel el Meloso","occurrenceId":"822aa93e-02cd-48f7-ab0f-6cbbbb51f5bf"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb","displayText":"Rochy RD","occurrenceId":"7a144ecc-7612-4de9-9ecb-2611564c8d8c"}},{"text":". Bajo Mundo, Lo Cualto Tan Hecho, Si Hay Mujeres, Piki Pau y Pa’ Que Respete salieron en 2021, la última junto a una tanda de presentaciones en Miami.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Que Sabe Sabe, de 2022, la hizo con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente","occurrenceId":"9eede19d-c29c-47c9-9697-64e9b078d5fe"}},{"text":", lo que puso al comediante al lado del hombre al que la escena trata como su fundador. Mi Tranza, Vivo por Palomo y Fundia vinieron en 2023, y grabó Party con IAmChino y Pitbull. Una versión nueva de Mi Tranza con el puertorriqueño Myke Towers salió en 2024.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 2025 apareció en CELOS con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3e1718be-c12d-42f5-85e7-2156d9574940","displayText":"Tokischa","occurrenceId":"2d299fbd-acf6-41bb-9fbb-b7044db0d2ec"}},{"text":". Sus discos recientes — Calorazo, Me La Sube, Ta Talde Pah con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"741eb4c0-4ab8-4ad5-8a64-2f156da6a395","displayText":"Ceky Viciny","occurrenceId":"332a058c-dc02-4e6c-aa02-873d8a453f81"}},{"text":", el remix de Leo Leo con Afriken An y Toy Al 100 — lo han mantenido entre los artistas de dembow que más suenan en el país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Bajo Mundo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2021 el artista Lio El Más Duro le puso una demanda por Bajo Mundo, pidiendo cincuenta millones de pesos y alegando plagio. Bulin respondió en público que bajo mundo es una expresión de uso común y que quien la popularizó fue un programa de televisión y no ningún compositor, y preguntó dónde estaba exactamente el plagio.","type":"text"}]},{"type":"paragraph","content":[{"text":"La disputa vale la pena registrarla porque es sobre autoría y no sobre conducta: se juega en si una frase que dice todo el mundo puede pertenecerle a alguien, que es una pregunta que el dembow plantea todo el tiempo y resuelve pocas veces.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'bulin-47'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'en'), '13f98b37-d0a0-4c4c-8d24-9b906865bcb1', 'artist', '741eb4c0-4ab8-4ad5-8a64-2f156da6a395');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'en'), '1d35a53e-0400-4b39-8809-e0d92f6a2097', 'artist', '71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'en'), '2438449f-885f-47d1-808e-9a1cdc039282', 'artist', '9be0ed08-6eb6-4ca0-bb68-d5126190aeb1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'en'), '41eed155-e937-4b18-8f76-e7d3186a84a9', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'en'), '514f6e5e-8f70-4028-a462-019a3319628c', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'en'), '66f52d95-ed4f-41ae-9e41-cb67e5c10d41', 'artist', 'bb07dcb8-444f-4a68-a668-21e9e038f335');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'en'), '8dc07975-d273-4df4-b649-fb582087e643', 'artist', '741eb4c0-4ab8-4ad5-8a64-2f156da6a395');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'en'), 'd63f109a-b30a-49be-9e41-143f29b9c0f1', 'artist', '3e1718be-c12d-42f5-85e7-2156d9574940');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'en'), 'dd7c030d-c97e-41f2-a3a4-f543bd25e962', 'artist', '518354a4-7cb9-4c39-a2b8-9fa4d18f50db');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'es'), '2d299fbd-acf6-41bb-9fbb-b7044db0d2ec', 'artist', '3e1718be-c12d-42f5-85e7-2156d9574940');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'es'), '332a058c-dc02-4e6c-aa02-873d8a453f81', 'artist', '741eb4c0-4ab8-4ad5-8a64-2f156da6a395');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'es'), '78fe3064-8ef4-489a-a4d0-9ebe1ffecb41', 'artist', '741eb4c0-4ab8-4ad5-8a64-2f156da6a395');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'es'), '7a144ecc-7612-4de9-9ecb-2611564c8d8c', 'artist', '71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'es'), '822aa93e-02cd-48f7-ab0f-6cbbbb51f5bf', 'artist', 'bb07dcb8-444f-4a68-a668-21e9e038f335');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'es'), '970d1968-d52d-4000-b8ca-7b232172556e', 'artist', '9be0ed08-6eb6-4ca0-bb68-d5126190aeb1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'es'), '9eede19d-c29c-47c9-9697-64e9b078d5fe', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'es'), 'd861beb3-be0e-4ee8-868f-074886d83842', 'artist', '518354a4-7cb9-4c39-a2b8-9fa4d18f50db');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bulin-47') AND locale = 'es'), 'ffa55ec2-b035-4148-be66-ec0b0c293488', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

COMMIT;
