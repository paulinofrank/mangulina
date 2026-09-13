BEGIN;

-- Rewrite the catalogue entry for José Alberto "El Canario".
--
-- José Alberto "El Canario". Segunda de las dieciséis fichas publicadas que
-- estaban EN BLANCO. Un salsero con tres Latin Grammy ganados y su página no
-- decía una palabra.
--
-- LA FILA TENÍA LO ESENCIAL Y ESTÁ BIEN: 22 de diciembre de 1958, Villa
-- Consuelo, Distrito Nacional, salsa, José Alberto Justiniano. No se toca nada
-- de eso. Se completa el segundo apellido, ANDÚJAR, que Wikipedia da en el
-- nombre de nacimiento completo.
--
-- LOS TRES LATIN GRAMMY NO ESTÁN EN LA BASE y van en migración aparte, porque
-- artist_awards es otra tabla:
--
--   2013  Latin Grammy  Salsa Giants                          Mejor Álbum de Salsa
--   2015  Latin Grammy  Tributo a los Compadres               Mejor Álbum Tropical Tradicional
--   2018  Latin Grammy  A Mí Qué: Tributo a los Clásicos Cubanos  Mejor Álbum Tropical Tradicional
--   2005  Congo de Oro  Festival de Orquestas de Barranquilla Salsa
--
-- LA IDENTIDAD DE "LA INSUPERABLE" ESTUVO A PUNTO DE SALIR MAL, y por eso queda
-- escrito. En la base hay DOS artistas con ese apodo: la-insuperable, urbana de
-- dembow, y raquel-arias, "La Estrella del Merengue Típico", que lo lleva entre
-- sus alias. La colaboración de 2022 en "Pata Pata" es con la PRIMERA:
-- Radiomar, HoyNoticias y loquesucedio.com la llaman las tres "la exponente
-- urbana La Insuperable", y EDM Charts lista el tema junto al resto de su
-- catálogo urbano. Enlazar a la otra habría sido un error invisible.
--
-- SE ENLAZAN TRES: la-insuperable por "Pata Pata"; mario-rivera, el saxofonista
-- dominicano con quien Wikipedia lo lista trabajando; y raulin-rosendo, que fue
-- invitado a su concierto de treinta años en el United Palace en 2008.
--
-- SOLO ENTRA UNA RED, Y ES A PROPÓSITO. instagram josealbertoelcanario está
-- comprobado y activo, con publicaciones de este año. El handle de YouTube que
-- devuelven los buscadores es "@JoséAlbertoElCanario-l9u441" y AL PROBARLO DA
-- 404 -- el acento lo rompe o el buscador lo mutila. Prefiero dejar el campo
-- vacío que guardar algo que no resuelve, que es justo lo que el editor pidió
-- al preguntar si los handles están vivos. Facebook tampoco se pudo confirmar.
--
-- NO SE ESCRIBEN CIFRAS de seguidores ni de reproducciones.
--
-- UN CONFLICTO MENOR QUE SE EVITA: el texto de Wikipedia dice que su álbum
-- debut fue "Noches Calientes" de 1984, pero su propia discografía en el mismo
-- artículo no lo lista: da "Típicamente" (1983) y "Canta Canario" (1984). La
-- ficha no nombra un disco debut concreto.
--
-- FUENTES: Wikipedia en español, que está marcada como necesitada de
-- referencias pero cuya discografía y tabla de premios son detalladas y
-- verificables. Listín Diario, 4 de julio de 2022, para "Pata Pata". Radiomar,
-- HoyNoticias y loquesucedio.com para la identidad de la colaboradora. Sus
-- propias cuentas para la gira de 2026 y el concierto del cincuentenario.
--
-- NOMBRES NUEVOS PARA LA LISTA: Ralph Mercado, el productor dominicano-
-- estadounidense fundador de RMM Records, que es el sello de casi todos sus
-- discos grandes; Típica 73, la orquesta que dirigió; y Wilbert Taveras, con
-- quien grabó "Sansón Batalla".
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
       youtube = NULL,
       facebook = NULL,
       instagram = 'josealbertoelcanario',
       disambiguation = 'Salsa singer and bandleader; led Típica 73 and won three Latin Grammys',
       bio_en = 'José Alberto Justiniano Andújar, known as El Canario, is a Dominican salsa singer, songwriter and bandleader. He has been working since the early seventies, he has three Latin Grammys, and he is one of the very few Dominicans who reached the front rank of a music the world files as Puerto Rican and Cuban.

**Three countries before twenty**

He was born in Villa Consuelo, a working barrio of Santo Domingo, in 1958. At seven the family moved to Puerto Rico, where he trained his voice at a military academy — an unlikely place to learn to sing and evidently an effective one. In the early seventies he moved again, to New York, and started singing with whatever orchestra would have him.

That itinerary explains a great deal. A Dominican raised in San Juan and formed as a professional in New York arrives at salsa from inside rather than as a visitor, which is why he was never treated as a guest in it.

**Típica 73**

In October 1977 he took over the front of Típica 73, one of the most respected bands in New York Latin music, and that is where the wider world first heard him. He stayed until he began assembling his own band in 1983.

The nickname came from the voice. El Canario, the canary — high, clean and carrying, with the kind of agility that makes a singer worth listening to twice. What made his reputation among musicians was not the tone but the soneo: the improvised lines a sonero throws over the montuno, invented on the spot and expected to rhyme, scan and land. He is one of the great improvisers the music has had.

The company he kept says the rest. He recorded and shared stages with Mario Rivera, Celia Cruz, Oscar D’León and Nicky Marrero — the top of the profession, on their terms.

**Salsa romántica**

His run of albums through the late eighties and nineties made him a headliner across Latin America. Sueño Contigo in 1988, Mis Amores in 1989, Llegó la Hora in 1992 with Discúlpeme Señora, De Pueblo y Con Clase in 1994.

Dance With Me, in 1991, is the one usually credited with setting the shape of salsa romántica — the slower, sweeter, more sung form that would dominate the next decade. Whether one man can found a subgenre is arguable; that the record is where a lot of people first heard it is not.

In 2008 he filled a theatre in upper Manhattan to mark thirty years in the business, with Raulín Rosendo among the guests. That is the Dominican salsa network in one room, and most of it was based within a few subway stops of the stage.

**The tributes**

The second half of his career is largely acts of memory, and it is where the awards are. Back to the Mambo saluted Machito in 1997. Two decades later the Latin Grammys arrived in a cluster: one in 2013 for a collective salsa record, one in 2015 for a tribute to Los Compadres, and one in 2018 for A Mí Qué, a tribute to the Cuban classics.

There is a logic to a Dominican sonero spending his later years on Cuban repertoire. Salsa is what New York made of Cuban music, and someone who has spent fifty years inside it is entitled to go back and say so out loud.

**Pata Pata**

In 2022 he recorded a version of Miriam Makeba’s Pata Pata with La Insuperable, which the Dominican press called an unexpected duet and which is exactly the kind of thing a sonero with nothing left to prove does for fun.

He is still on the road. In 2026 alone he has played Peru, Panama, Colombia and a national tour at home, and he marked fifty years of singing with a concert built around it. The barrio was Villa Consuelo and the voice has held.',
       bio_es = 'José Alberto Justiniano Andújar, conocido como El Canario, es cantante, compositor y director de orquesta dominicano de salsa. Trabaja desde principios de los setenta, tiene tres Latin Grammy, y es uno de los poquísimos dominicanos que llegaron a la primera fila de una música que el mundo archiva como puertorriqueña y cubana.

**Tres países antes de los veinte**

Nació en Villa Consuelo, barrio trabajador de Santo Domingo, en 1958. A los siete años la familia se mudó a Puerto Rico, donde educó la voz en una academia militar: sitio improbable para aprender a cantar y evidentemente eficaz. A principios de los setenta se mudó otra vez, a Nueva York, y se puso a cantar con la orquesta que lo aceptara.

Ese itinerario explica bastante. Un dominicano criado en San Juan y hecho profesional en Nueva York llega a la salsa desde dentro y no de visita, y por eso nunca lo trataron como invitado en ella.

**Típica 73**

En octubre de 1977 se puso al frente de la Típica 73, una de las bandas más respetadas de la música latina neoyorquina, y ahí lo oyó por primera vez el mundo de afuera. Se quedó hasta que empezó a armar su propia orquesta, en 1983.

El apodo salió de la voz. El Canario: aguda, limpia y con proyección, con esa agilidad que hace que a un cantante valga la pena oírlo dos veces. Pero lo que le hizo el nombre entre músicos no fue el timbre sino el soneo, esas líneas improvisadas que el sonero suelta sobre el montuno, inventadas en el momento y con la obligación de rimar, medir y caer bien. Es uno de los grandes improvisadores que ha dado esta música.

La compañía que tuvo dice el resto. Grabó y compartió tarima con Mario Rivera, Celia Cruz, Oscar D’León y Nicky Marrero: lo más alto del oficio, y en las condiciones de ellos.

**La salsa romántica**

Su tanda de discos de finales de los ochenta y los noventa lo convirtió en cabeza de cartel por toda América Latina. Sueño Contigo en 1988, Mis Amores en 1989, Llegó la Hora en 1992 con Discúlpeme Señora, De Pueblo y Con Clase en 1994.

A Dance With Me, de 1991, se le suele atribuir haber fijado la forma de la salsa romántica: esa versión más lenta, más dulce y más cantada que dominaría la década siguiente. Que un solo hombre funde un subgénero es discutible; que ese disco es donde mucha gente la oyó por primera vez, no.

En 2008 llenó un teatro del alto Manhattan para celebrar treinta años de oficio, con Raulín Rosendo entre los invitados. Eso es la red de la salsa dominicana metida en un salón, y casi toda vivía a pocas paradas de metro del escenario.

**Los tributos**

La segunda mitad de su carrera son en buena medida actos de memoria, y es donde están los premios. Back to the Mambo saludó a Machito en 1997. Dos décadas después los Latin Grammy llegaron en racimo: uno en 2013 por un disco colectivo de salsa, otro en 2015 por un tributo a Los Compadres, y otro en 2018 por A Mí Qué, homenaje a los clásicos cubanos.

Tiene su lógica que un sonero dominicano dedique los años tardíos al repertorio cubano. La salsa es lo que Nueva York hizo con la música cubana, y quien lleva cincuenta años metido ahí tiene derecho a volver sobre eso y decirlo en voz alta.

**Pata Pata**

En 2022 grabó una versión del Pata Pata de Miriam Makeba con La Insuperable, que la prensa dominicana llamó dúo inesperado y que es exactamente la clase de cosa que hace por gusto un sonero que ya no tiene nada que demostrar.

Sigue en carretera. Solo en 2026 ha tocado en Perú, Panamá, Colombia y una gira nacional en el país, y celebró cincuenta años cantando con un concierto montado alrededor de eso. El barrio era Villa Consuelo y la voz ha aguantado.',
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
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José Alberto Justiniano Andújar, known as El Canario, is a Dominican salsa singer, songwriter and bandleader. He has been working since the early seventies, he has three Latin Grammys, and he is one of the very few Dominicans who reached the front rank of a music the world files as Puerto Rican and Cuban.","type":"text"}]},{"type":"paragraph","content":[{"text":"Three countries before twenty","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Villa Consuelo, a working barrio of Santo Domingo, in 1958. At seven the family moved to Puerto Rico, where he trained his voice at a military academy — an unlikely place to learn to sing and evidently an effective one. In the early seventies he moved again, to New York, and started singing with whatever orchestra would have him.","type":"text"}]},{"type":"paragraph","content":[{"text":"That itinerary explains a great deal. A Dominican raised in San Juan and formed as a professional in New York arrives at salsa from inside rather than as a visitor, which is why he was never treated as a guest in it.","type":"text"}]},{"type":"paragraph","content":[{"text":"Típica 73","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In October 1977 he took over the front of Típica 73, one of the most respected bands in New York Latin music, and that is where the wider world first heard him. He stayed until he began assembling his own band in 1983.","type":"text"}]},{"type":"paragraph","content":[{"text":"The nickname came from the voice. El Canario, the canary — high, clean and carrying, with the kind of agility that makes a singer worth listening to twice. What made his reputation among musicians was not the tone but the soneo: the improvised lines a sonero throws over the montuno, invented on the spot and expected to rhyme, scan and land. He is one of the great improvisers the music has had.","type":"text"}]},{"type":"paragraph","content":[{"text":"The company he kept says the rest. He recorded and shared stages with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f0a5c773-b904-4feb-bf20-9d938bead0b1","displayText":"Mario Rivera","occurrenceId":"b8d82306-4170-4c94-858a-d5b0574539bb"}},{"text":", Celia Cruz, Oscar D’León and Nicky Marrero — the top of the profession, on their terms.","type":"text"}]},{"type":"paragraph","content":[{"text":"Salsa romántica","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His run of albums through the late eighties and nineties made him a headliner across Latin America. Sueño Contigo in 1988, Mis Amores in 1989, Llegó la Hora in 1992 with Discúlpeme Señora, De Pueblo y Con Clase in 1994.","type":"text"}]},{"type":"paragraph","content":[{"text":"Dance With Me, in 1991, is the one usually credited with setting the shape of salsa romántica — the slower, sweeter, more sung form that would dominate the next decade. Whether one man can found a subgenre is arguable; that the record is where a lot of people first heard it is not.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 2008 he filled a theatre in upper Manhattan to mark thirty years in the business, with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faf3e4cb-808e-419c-87ff-5126eed85e73","displayText":"Raulín Rosendo","occurrenceId":"9e6721ed-b0e1-4ffb-9b74-cc0b28f5d9a8"}},{"text":" among the guests. That is the Dominican salsa network in one room, and most of it was based within a few subway stops of the stage.","type":"text"}]},{"type":"paragraph","content":[{"text":"The tributes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The second half of his career is largely acts of memory, and it is where the awards are. Back to the Mambo saluted Machito in 1997. Two decades later the Latin Grammys arrived in a cluster: one in 2013 for a collective salsa record, one in 2015 for a tribute to Los Compadres, and one in 2018 for A Mí Qué, a tribute to the Cuban classics.","type":"text"}]},{"type":"paragraph","content":[{"text":"There is a logic to a Dominican sonero spending his later years on Cuban repertoire. Salsa is what New York made of Cuban music, and someone who has spent fifty years inside it is entitled to go back and say so out loud.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pata Pata","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2022 he recorded a version of Miriam Makeba’s Pata Pata with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d08f2c85-7f47-449e-a486-a19ba3b5841a","displayText":"La Insuperable","occurrenceId":"5f997102-99f6-4932-85b8-28339d79cfe5"}},{"text":", which the Dominican press called an unexpected duet and which is exactly the kind of thing a sonero with nothing left to prove does for fun.","type":"text"}]},{"type":"paragraph","content":[{"text":"He is still on the road. In 2026 alone he has played Peru, Panama, Colombia and a national tour at home, and he marked fifty years of singing with a concert built around it. The barrio was Villa Consuelo and the voice has held.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José Alberto Justiniano Andújar, conocido como El Canario, es cantante, compositor y director de orquesta dominicano de salsa. Trabaja desde principios de los setenta, tiene tres Latin Grammy, y es uno de los poquísimos dominicanos que llegaron a la primera fila de una música que el mundo archiva como puertorriqueña y cubana.","type":"text"}]},{"type":"paragraph","content":[{"text":"Tres países antes de los veinte","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Villa Consuelo, barrio trabajador de Santo Domingo, en 1958. A los siete años la familia se mudó a Puerto Rico, donde educó la voz en una academia militar: sitio improbable para aprender a cantar y evidentemente eficaz. A principios de los setenta se mudó otra vez, a Nueva York, y se puso a cantar con la orquesta que lo aceptara.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ese itinerario explica bastante. Un dominicano criado en San Juan y hecho profesional en Nueva York llega a la salsa desde dentro y no de visita, y por eso nunca lo trataron como invitado en ella.","type":"text"}]},{"type":"paragraph","content":[{"text":"Típica 73","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En octubre de 1977 se puso al frente de la Típica 73, una de las bandas más respetadas de la música latina neoyorquina, y ahí lo oyó por primera vez el mundo de afuera. Se quedó hasta que empezó a armar su propia orquesta, en 1983.","type":"text"}]},{"type":"paragraph","content":[{"text":"El apodo salió de la voz. El Canario: aguda, limpia y con proyección, con esa agilidad que hace que a un cantante valga la pena oírlo dos veces. Pero lo que le hizo el nombre entre músicos no fue el timbre sino el soneo, esas líneas improvisadas que el sonero suelta sobre el montuno, inventadas en el momento y con la obligación de rimar, medir y caer bien. Es uno de los grandes improvisadores que ha dado esta música.","type":"text"}]},{"type":"paragraph","content":[{"text":"La compañía que tuvo dice el resto. Grabó y compartió tarima con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f0a5c773-b904-4feb-bf20-9d938bead0b1","displayText":"Mario Rivera","occurrenceId":"bc027c4e-55dd-4269-bfd1-08e4d9a3c25e"}},{"text":", Celia Cruz, Oscar D’León y Nicky Marrero: lo más alto del oficio, y en las condiciones de ellos.","type":"text"}]},{"type":"paragraph","content":[{"text":"La salsa romántica","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su tanda de discos de finales de los ochenta y los noventa lo convirtió en cabeza de cartel por toda América Latina. Sueño Contigo en 1988, Mis Amores en 1989, Llegó la Hora en 1992 con Discúlpeme Señora, De Pueblo y Con Clase en 1994.","type":"text"}]},{"type":"paragraph","content":[{"text":"A Dance With Me, de 1991, se le suele atribuir haber fijado la forma de la salsa romántica: esa versión más lenta, más dulce y más cantada que dominaría la década siguiente. Que un solo hombre funde un subgénero es discutible; que ese disco es donde mucha gente la oyó por primera vez, no.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 2008 llenó un teatro del alto Manhattan para celebrar treinta años de oficio, con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faf3e4cb-808e-419c-87ff-5126eed85e73","displayText":"Raulín Rosendo","occurrenceId":"ae648a98-d468-4d91-a0b0-945f54a0b4a3"}},{"text":" entre los invitados. Eso es la red de la salsa dominicana metida en un salón, y casi toda vivía a pocas paradas de metro del escenario.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los tributos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La segunda mitad de su carrera son en buena medida actos de memoria, y es donde están los premios. Back to the Mambo saludó a Machito en 1997. Dos décadas después los Latin Grammy llegaron en racimo: uno en 2013 por un disco colectivo de salsa, otro en 2015 por un tributo a Los Compadres, y otro en 2018 por A Mí Qué, homenaje a los clásicos cubanos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Tiene su lógica que un sonero dominicano dedique los años tardíos al repertorio cubano. La salsa es lo que Nueva York hizo con la música cubana, y quien lleva cincuenta años metido ahí tiene derecho a volver sobre eso y decirlo en voz alta.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pata Pata","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2022 grabó una versión del Pata Pata de Miriam Makeba con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d08f2c85-7f47-449e-a486-a19ba3b5841a","displayText":"La Insuperable","occurrenceId":"9063e884-d22d-46d6-87dc-60ee27a574fa"}},{"text":", que la prensa dominicana llamó dúo inesperado y que es exactamente la clase de cosa que hace por gusto un sonero que ya no tiene nada que demostrar.","type":"text"}]},{"type":"paragraph","content":[{"text":"Sigue en carretera. Solo en 2026 ha tocado en Perú, Panamá, Colombia y una gira nacional en el país, y celebró cincuenta años cantando con un concierto montado alrededor de eso. El barrio era Villa Consuelo y la voz ha aguantado.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario') AND locale = 'en'), '5f997102-99f6-4932-85b8-28339d79cfe5', 'artist', 'd08f2c85-7f47-449e-a486-a19ba3b5841a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario') AND locale = 'en'), '9e6721ed-b0e1-4ffb-9b74-cc0b28f5d9a8', 'artist', 'faf3e4cb-808e-419c-87ff-5126eed85e73');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario') AND locale = 'en'), 'b8d82306-4170-4c94-858a-d5b0574539bb', 'artist', 'f0a5c773-b904-4feb-bf20-9d938bead0b1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario') AND locale = 'es'), '9063e884-d22d-46d6-87dc-60ee27a574fa', 'artist', 'd08f2c85-7f47-449e-a486-a19ba3b5841a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario') AND locale = 'es'), 'ae648a98-d468-4d91-a0b0-945f54a0b4a3', 'artist', 'faf3e4cb-808e-419c-87ff-5126eed85e73');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario') AND locale = 'es'), 'bc027c4e-55dd-4269-bfd1-08e4d9a3c25e', 'artist', 'f0a5c773-b904-4feb-bf20-9d938bead0b1');

COMMIT;
