BEGIN;

-- Rewrite the catalogue entry for José Alberto "El Canario".
--
-- José Alberto "El Canario", SEGUNDA ESCRITURA. No cambia un solo dato: cambia
-- el registro. La versión anterior estaba escrita en el tono de una
-- conversación de trabajo y no en el de una ficha, y eso la sacaba del formato.
--
-- LO QUE ESTABA MAL, con los ejemplos exactos que se quitan:
--
--   - Comentario del redactor sobre lo que acaba de contar:
--       "Ese itinerario explica bastante."
--       "La compañía que tuvo dice el resto."
--       "Tiene su lógica que un sonero dominicano dedique..."
--       "Eso es la red de la salsa dominicana metida en un salón."
--   - Concesión retórica en pareja, que es una figura de argumentación oral:
--       "Que un solo hombre funde un subgénero es discutible; que ese disco
--        es donde mucha gente la oyó por primera vez, no."
--   - Juicio de valor coloquial:
--       "sitio improbable para aprender a cantar y evidentemente eficaz"
--       "es exactamente la clase de cosa que hace por gusto un sonero que ya
--        no tiene nada que demostrar"
--       "con esa agilidad que hace que a un cantante valga la pena oírlo dos veces"
--   - Cierre aforístico:
--       "El barrio era Villa Consuelo y la voz ha aguantado."
--
-- Todos los hechos que sostenían esas frases se conservan; lo que desaparece es
-- la voz que los comentaba. Donde la frase original solo aportaba tono, se
-- elimina; donde aportaba un hecho, se reformula en tercera persona informativa.
--
-- NINGUNA GUARDA DE mk.cjs ATRAPABA ESTO. La lista BANNED persigue frases
-- explícitas de meta-voz ("conviene decir", "quede escrito"); el problema aquí
-- no es una frase prohibida sino una manera de hablar. Se añade una guarda de
-- registro en el mismo commit, con los marcadores de arriba, y se pasa un
-- detector sobre todo el catálogo para medir cuántas fichas comparten el vicio.
--
-- SE MANTIENEN los tres enlaces (la-insuperable, mario-rivera, raulin-rosendo),
-- las mismas fuentes y la misma estructura de secciones. No se toca ningún
-- campo de la fila: los premios y los handles ya entraron por sus migraciones.
--
-- Applied directly over DATABASE_URL as part of an editorial pass. No Vercel
-- function ran and nothing was revalidated; the profile reaches the public site
-- on its own within the seven-day ISR fallback, or sooner if a batch sweep is
-- run at the end of the pass.
--
-- This file reproduces the change from the pre-pass state. Both it and its
-- rollback were generated from state captured live either side of the write,
-- not reconstructed afterwards.

UPDATE artists SET
       name = 'José Alberto "El Canario"',
       sort_name = 'Justiniano Andújar, José Alberto',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'salsa',
       date_of_birth = '1958-12-22',
       birth_year = 1958,
       date_of_death = NULL,
       birth_place = 'Villa Consuelo',
       province = 'Distrito Nacional',
       first_name = 'José',
       middle_name = 'Alberto',
       last_name = 'Justiniano',
       second_last_name = 'Andújar',
       stage_name = 'José Alberto "El Canario"',
       aliases = ARRAY['El Canario']::text[],
       occupations = '["composer","bandleader"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend', 'diaspora']::text[],
       website = NULL,
       youtube = '@JoséAlbertoElCanario-l9u',
       facebook = '100044419929906',
       instagram = 'josealbertoelcanario',
       disambiguation = 'Salsa singer and bandleader; led Típica 73 and won three Latin Grammys',
       bio_en = 'José Alberto Justiniano Andújar, known as El Canario, is a Dominican salsa singer, songwriter and bandleader. Active since the early seventies, he has won three Latin Grammy awards and ranks among the few Dominican artists to reach the front rank of a genre identified principally with Cuba and Puerto Rico.

**Santo Domingo, San Juan and New York**

He was born in Villa Consuelo, a working-class barrio of Santo Domingo, in 1958. The family moved to Puerto Rico when he was seven, and he received his first formal vocal training at a military academy on the island. In the early seventies he moved again, to New York, where he began performing with the orchestras of the city Latin music circuit.

That trajectory placed him inside the two principal centres of salsa rather than outside them. He was raised in San Juan and formed as a professional in New York, and he entered the genre as a working member of its scene.

**Típica 73**

In October 1977 he became the lead singer of Típica 73, one of the most respected bands in New York Latin music, and the association gave him his first international exposure. He remained with the orchestra until 1983, when he began assembling a band of his own.

The nickname describes his voice, which is high, clean and carrying, with a marked agility in the upper register. His standing among musicians rests above all on his soneo: the improvised lines a sonero delivers over the montuno, invented in performance and required to rhyme, scan and resolve. He is regarded as one of the leading improvisers the genre has produced.

He has recorded and shared stages with Mario Rivera, Celia Cruz, Oscar D’León and Nicky Marrero.

**Salsa romántica**

His run of albums through the late eighties and nineties made him a headliner across Latin America: Sueño Contigo in 1988, Mis Amores in 1989, Llegó la Hora in 1992 with Discúlpeme Señora, and De Pueblo y Con Clase in 1994.

Dance With Me, released in 1991, is frequently credited with setting the shape of salsa romántica, the slower and more melodic form that would dominate the following decade. The attribution to a single artist is disputed, but the record is widely cited as the point at which the style reached a broad audience.

In 2008 he marked thirty years of professional work with a concert at a theatre in upper Manhattan, with Raulín Rosendo among the guest performers.

**The tributes**

Much of the later part of his career has been given to tribute repertoire, and it is where his awards are concentrated. Back to the Mambo saluted Machito in 1997. The Latin Grammys came two decades afterward: one in 2013 for a collective salsa recording, one in 2015 for a tribute to Los Compadres, and one in 2018 for A Mí Qué, dedicated to the Cuban classics.

The emphasis on Cuban material follows the history of the genre itself, which took shape in New York out of Cuban forms. His tribute albums return to that source repertoire.

**Pata Pata**

In 2022 he recorded a version of Miriam Makeba’s Pata Pata with La Insuperable. The Dominican press treated the pairing as an unexpected one, given the distance between his repertoire and hers.

He continues to perform internationally. During 2026 he has appeared in Peru, Panama and Colombia and toured the Dominican Republic, and he marked fifty years as a singer with a commemorative concert.',
       bio_es = 'José Alberto Justiniano Andújar, conocido como El Canario, es cantante, compositor y director de orquesta dominicano de salsa. En activo desde principios de los setenta, ha ganado tres premios Latin Grammy y figura entre los pocos artistas dominicanos que alcanzaron la primera línea de un género identificado principalmente con Cuba y Puerto Rico.

**Santo Domingo, San Juan y Nueva York**

Nació en Villa Consuelo, barrio trabajador de Santo Domingo, en 1958. La familia se trasladó a Puerto Rico cuando él tenía siete años, y allí recibió su primera formación vocal en una academia militar. A principios de los setenta se mudó de nuevo, esta vez a Nueva York, donde empezó a cantar con las orquestas del circuito latino de la ciudad.

Ese recorrido lo situó dentro de los dos centros principales de la salsa y no fuera de ellos. Se crió en San Juan y se formó como profesional en Nueva York, y entró al género como parte activa de su ambiente.

**Típica 73**

En octubre de 1977 pasó a ser el cantante principal de la Típica 73, una de las bandas más respetadas de la música latina neoyorquina, y esa vinculación le dio su primera proyección internacional. Permaneció en la orquesta hasta 1983, cuando empezó a armar una agrupación propia.

El apodo describe su voz, aguda, limpia y de buena proyección, con una agilidad notable en el registro alto. Su prestigio entre músicos descansa sobre todo en el soneo: las líneas improvisadas que el sonero coloca sobre el montuno, inventadas en el momento y obligadas a rimar, medir y resolver. Se le considera uno de los mayores improvisadores que ha dado el género.

Ha grabado y compartido escenario con Mario Rivera, Celia Cruz, Oscar D’León y Nicky Marrero.

**La salsa romántica**

Su serie de discos de finales de los ochenta y los noventa lo convirtió en cabeza de cartel en toda América Latina: Sueño Contigo en 1988, Mis Amores en 1989, Llegó la Hora en 1992 con Discúlpeme Señora, y De Pueblo y Con Clase en 1994.

A Dance With Me, publicado en 1991, se le atribuye con frecuencia haber fijado la forma de la salsa romántica, la variante más lenta y melódica que dominaría la década siguiente. La atribución a un solo artista es discutida, pero el disco se cita de manera generalizada como el punto en que el estilo llegó a un público amplio.

En 2008 celebró treinta años de trayectoria con un concierto en un teatro del alto Manhattan, con Raulín Rosendo entre los artistas invitados.

**Los tributos**

Buena parte de la etapa tardía de su carrera se ha dedicado al repertorio de homenaje, y es donde se concentran sus premios. Back to the Mambo saludó a Machito en 1997. Los Latin Grammy llegaron dos décadas después: uno en 2013 por un disco colectivo de salsa, otro en 2015 por un tributo a Los Compadres y otro en 2018 por A Mí Qué, dedicado a los clásicos cubanos.

El énfasis en el material cubano sigue la propia historia del género, que se formó en Nueva York a partir de formas cubanas. Sus discos de homenaje regresan a ese repertorio de origen.

**Pata Pata**

En 2022 grabó una versión del Pata Pata de Miriam Makeba junto a La Insuperable. La prensa dominicana calificó la colaboración de inesperada, por la distancia entre el repertorio de uno y el de la otra.

Mantiene actividad internacional. Durante 2026 se ha presentado en Perú, Panamá y Colombia y ha realizado una gira por la República Dominicana, y conmemoró cincuenta años como cantante con un concierto de aniversario.',
       updated_at = now()
 WHERE slug = 'jose-alberto-el-canario';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José Alberto Justiniano Andújar, known as El Canario, is a Dominican salsa singer, songwriter and bandleader. Active since the early seventies, he has won three Latin Grammy awards and ranks among the few Dominican artists to reach the front rank of a genre identified principally with Cuba and Puerto Rico.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santo Domingo, San Juan and New York","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Villa Consuelo, a working-class barrio of Santo Domingo, in 1958. The family moved to Puerto Rico when he was seven, and he received his first formal vocal training at a military academy on the island. In the early seventies he moved again, to New York, where he began performing with the orchestras of the city Latin music circuit.","type":"text"}]},{"type":"paragraph","content":[{"text":"That trajectory placed him inside the two principal centres of salsa rather than outside them. He was raised in San Juan and formed as a professional in New York, and he entered the genre as a working member of its scene.","type":"text"}]},{"type":"paragraph","content":[{"text":"Típica 73","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In October 1977 he became the lead singer of Típica 73, one of the most respected bands in New York Latin music, and the association gave him his first international exposure. He remained with the orchestra until 1983, when he began assembling a band of his own.","type":"text"}]},{"type":"paragraph","content":[{"text":"The nickname describes his voice, which is high, clean and carrying, with a marked agility in the upper register. His standing among musicians rests above all on his soneo: the improvised lines a sonero delivers over the montuno, invented in performance and required to rhyme, scan and resolve. He is regarded as one of the leading improvisers the genre has produced.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has recorded and shared stages with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f0a5c773-b904-4feb-bf20-9d938bead0b1","displayText":"Mario Rivera","occurrenceId":"63860b9c-6ab2-492e-ace7-967841480cec"}},{"text":", Celia Cruz, Oscar D’León and Nicky Marrero.","type":"text"}]},{"type":"paragraph","content":[{"text":"Salsa romántica","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His run of albums through the late eighties and nineties made him a headliner across Latin America: Sueño Contigo in 1988, Mis Amores in 1989, Llegó la Hora in 1992 with Discúlpeme Señora, and De Pueblo y Con Clase in 1994.","type":"text"}]},{"type":"paragraph","content":[{"text":"Dance With Me, released in 1991, is frequently credited with setting the shape of salsa romántica, the slower and more melodic form that would dominate the following decade. The attribution to a single artist is disputed, but the record is widely cited as the point at which the style reached a broad audience.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 2008 he marked thirty years of professional work with a concert at a theatre in upper Manhattan, with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faf3e4cb-808e-419c-87ff-5126eed85e73","displayText":"Raulín Rosendo","occurrenceId":"721a4a11-c741-42ca-9abe-05ba817d99e1"}},{"text":" among the guest performers.","type":"text"}]},{"type":"paragraph","content":[{"text":"The tributes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Much of the later part of his career has been given to tribute repertoire, and it is where his awards are concentrated. Back to the Mambo saluted Machito in 1997. The Latin Grammys came two decades afterward: one in 2013 for a collective salsa recording, one in 2015 for a tribute to Los Compadres, and one in 2018 for A Mí Qué, dedicated to the Cuban classics.","type":"text"}]},{"type":"paragraph","content":[{"text":"The emphasis on Cuban material follows the history of the genre itself, which took shape in New York out of Cuban forms. His tribute albums return to that source repertoire.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pata Pata","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2022 he recorded a version of Miriam Makeba’s Pata Pata with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d08f2c85-7f47-449e-a486-a19ba3b5841a","displayText":"La Insuperable","occurrenceId":"5cee629d-dc2a-4a46-84f0-f9a16391bcba"}},{"text":". The Dominican press treated the pairing as an unexpected one, given the distance between his repertoire and hers.","type":"text"}]},{"type":"paragraph","content":[{"text":"He continues to perform internationally. During 2026 he has appeared in Peru, Panama and Colombia and toured the Dominican Republic, and he marked fifty years as a singer with a commemorative concert.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José Alberto Justiniano Andújar, conocido como El Canario, es cantante, compositor y director de orquesta dominicano de salsa. En activo desde principios de los setenta, ha ganado tres premios Latin Grammy y figura entre los pocos artistas dominicanos que alcanzaron la primera línea de un género identificado principalmente con Cuba y Puerto Rico.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santo Domingo, San Juan y Nueva York","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Villa Consuelo, barrio trabajador de Santo Domingo, en 1958. La familia se trasladó a Puerto Rico cuando él tenía siete años, y allí recibió su primera formación vocal en una academia militar. A principios de los setenta se mudó de nuevo, esta vez a Nueva York, donde empezó a cantar con las orquestas del circuito latino de la ciudad.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ese recorrido lo situó dentro de los dos centros principales de la salsa y no fuera de ellos. Se crió en San Juan y se formó como profesional en Nueva York, y entró al género como parte activa de su ambiente.","type":"text"}]},{"type":"paragraph","content":[{"text":"Típica 73","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En octubre de 1977 pasó a ser el cantante principal de la Típica 73, una de las bandas más respetadas de la música latina neoyorquina, y esa vinculación le dio su primera proyección internacional. Permaneció en la orquesta hasta 1983, cuando empezó a armar una agrupación propia.","type":"text"}]},{"type":"paragraph","content":[{"text":"El apodo describe su voz, aguda, limpia y de buena proyección, con una agilidad notable en el registro alto. Su prestigio entre músicos descansa sobre todo en el soneo: las líneas improvisadas que el sonero coloca sobre el montuno, inventadas en el momento y obligadas a rimar, medir y resolver. Se le considera uno de los mayores improvisadores que ha dado el género.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ha grabado y compartido escenario con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f0a5c773-b904-4feb-bf20-9d938bead0b1","displayText":"Mario Rivera","occurrenceId":"5ea95e83-cb47-43b0-bfd0-f63b9196b440"}},{"text":", Celia Cruz, Oscar D’León y Nicky Marrero.","type":"text"}]},{"type":"paragraph","content":[{"text":"La salsa romántica","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su serie de discos de finales de los ochenta y los noventa lo convirtió en cabeza de cartel en toda América Latina: Sueño Contigo en 1988, Mis Amores en 1989, Llegó la Hora en 1992 con Discúlpeme Señora, y De Pueblo y Con Clase en 1994.","type":"text"}]},{"type":"paragraph","content":[{"text":"A Dance With Me, publicado en 1991, se le atribuye con frecuencia haber fijado la forma de la salsa romántica, la variante más lenta y melódica que dominaría la década siguiente. La atribución a un solo artista es discutida, pero el disco se cita de manera generalizada como el punto en que el estilo llegó a un público amplio.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 2008 celebró treinta años de trayectoria con un concierto en un teatro del alto Manhattan, con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faf3e4cb-808e-419c-87ff-5126eed85e73","displayText":"Raulín Rosendo","occurrenceId":"11c99afa-1f74-486d-8911-e6556681d994"}},{"text":" entre los artistas invitados.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los tributos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Buena parte de la etapa tardía de su carrera se ha dedicado al repertorio de homenaje, y es donde se concentran sus premios. Back to the Mambo saludó a Machito en 1997. Los Latin Grammy llegaron dos décadas después: uno en 2013 por un disco colectivo de salsa, otro en 2015 por un tributo a Los Compadres y otro en 2018 por A Mí Qué, dedicado a los clásicos cubanos.","type":"text"}]},{"type":"paragraph","content":[{"text":"El énfasis en el material cubano sigue la propia historia del género, que se formó en Nueva York a partir de formas cubanas. Sus discos de homenaje regresan a ese repertorio de origen.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pata Pata","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2022 grabó una versión del Pata Pata de Miriam Makeba junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d08f2c85-7f47-449e-a486-a19ba3b5841a","displayText":"La Insuperable","occurrenceId":"28614dab-8389-4bd3-b75f-05f3b5a6c557"}},{"text":". La prensa dominicana calificó la colaboración de inesperada, por la distancia entre el repertorio de uno y el de la otra.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mantiene actividad internacional. Durante 2026 se ha presentado en Perú, Panamá y Colombia y ha realizado una gira por la República Dominicana, y conmemoró cincuenta años como cantante con un concierto de aniversario.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario'), 2)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario') AND locale = 'en'), '5cee629d-dc2a-4a46-84f0-f9a16391bcba', 'artist', 'd08f2c85-7f47-449e-a486-a19ba3b5841a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario') AND locale = 'en'), '63860b9c-6ab2-492e-ace7-967841480cec', 'artist', 'f0a5c773-b904-4feb-bf20-9d938bead0b1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario') AND locale = 'en'), '721a4a11-c741-42ca-9abe-05ba817d99e1', 'artist', 'faf3e4cb-808e-419c-87ff-5126eed85e73');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario') AND locale = 'es'), '11c99afa-1f74-486d-8911-e6556681d994', 'artist', 'faf3e4cb-808e-419c-87ff-5126eed85e73');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario') AND locale = 'es'), '28614dab-8389-4bd3-b75f-05f3b5a6c557', 'artist', 'd08f2c85-7f47-449e-a486-a19ba3b5841a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario') AND locale = 'es'), '5ea95e83-cb47-43b0-bfd0-f63b9196b440', 'artist', 'f0a5c773-b904-4feb-bf20-9d938bead0b1');

COMMIT;
