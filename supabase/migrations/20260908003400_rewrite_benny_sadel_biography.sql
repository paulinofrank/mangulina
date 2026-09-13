BEGIN;

-- Rewrite the catalogue entry for Benny Sadel.
--
-- Benny Sadel. DECIMOSÉPTIMA de las dieciocho. 1.259 caracteres de simpatía
-- -- "beloved", "warm", "joyful accessibility", "his personal charm" -- sin una
-- canción, sin un disco, sin una orquesta y sin un año.
--
-- El texto viejo decía que "his connection with fans was legendary in Dominican
-- entertainment circles". Eso puede escribirse de cualquiera. Lo que hace falta
-- saber de él es por dónde pasó, y su recorrido por orquestas es justamente lo
-- interesante: cinco agrupaciones antes de montar la suya.
--
-- LA FUENTE PRINCIPAL SE CONTRADICE A SÍ MISMA Y HAY QUE DECIRLO. El artículo
-- de Wikipedia en español da DOS NOMBRES LEGALES DISTINTOS en la misma página:
-- el cuadro lateral dice "Emmanuel Alberto Feliz Jiménez" y el cuerpo empieza
-- diciendo "Emmanuel González González", con padres apellidados González. Y dos
-- lugares: Tamayo en el cuadro, Uvilla en el cuerpo.
--
--   EL NOMBRE: la fila guarda "Emmanuel Jiménez" y BuenaMusica dice lo mismo.
--   Dos contra las dos variantes de Wikipedia. NO SE TOCA LA FILA.
--
--   EL LUGAR: no era contradicción sino precisión. BuenaMusica escribe "Uvilla,
--   Tamayo": Uvilla es un paraje DENTRO de Tamayo, así que las dos fuentes
--   tienen razón. Se afina el campo a "Uvilla, Tamayo", que es más exacto y no
--   contradice lo que había.
--
-- NO REGISTRO QUE FUERA PRIMO HERMANO DE RUBBY PÉREZ. El artículo de Wikipedia
-- lo afirma, y sería un parentesco entre dos artistas publicados de este mismo
-- catálogo, de los que además acabo de escribir uno hoy. PERO esa frase está
-- sin fuente, en un párrafo con un paréntesis sin cerrar, dentro del mismo
-- artículo que se equivoca dos veces con el nombre legal. BuenaMusica no lo
-- menciona y la ficha de Rubby Pérez tampoco. Queda reportado. Un parentesco
-- inventado en una tabla de parentescos es peor que un parentesco ausente.
--
-- LO QUE FALTABA, QUE ES SU CARRERA ENTERA:
--
--   1977, "Los X-1 del Sabor", la orquesta de su pueblo. Su maestro de música,
--   Arturo Méndez, le dijo que se fuera a la capital.
--
--   "Los Diamantes", contratado por Gerardo Veras al día siguiente de llegar.
--   Después "La Santo Domingo All Star Band".
--
--   "EL EQUIPO", donde lo metieron Dioni Fernández y Sandy Reyes cuando el
--   grupo se estaba formando.
--
--   VENEZUELA, donde montó "Los Jacarandosos de Benny Sadel" con músicos
--   dominicanos y venezolanos.
--
--   WILFRIDO VARGAS lo llamó y él volvió al país -- Y SOLO ALCANZÓ A HACER
--   CUATRO PRESENTACIONES, porque no le renovaron el visado a tiempo y se quedó
--   fuera de la gira internacional. Volvió a Venezuela. Es el dato más humano
--   de la ficha y no estaba.
--
--   1983, "La Organización Secreta" de Aramis Camilo, donde se hizo conocido en
--   el continente con "Ven Llévame Contigo" y "Querida".
--
--   1987, ORQUESTA PROPIA, formada en Boston. El primer disco se llama
--   "Caciquiando", de donde sale el apodo que la fila ya guardaba: El Cacique.
--
--   2008, "Los Toros Band", como figura principal.
--
-- LO QUE SE DEJA FUERA: la leucemia y el hospital. Diagnóstico médico. Sí entra
-- que murió en Nueva York el 5 de noviembre de 2015. Tampoco entran su esposa
-- ni los nombres de sus padres.
--
-- CINCO ENLACES, TODOS POR PASO DOCUMENTADO POR UNA ORQUESTA:
-- dioni-fernandez-y-el-equipo y sandy-reyes (El Equipo), wilfrido-vargas (las
-- cuatro presentaciones), los-toros-band (2008) y sergio-vargas, que cantó en
-- su velatorio.
--
-- REVISION 2, MISMO DÍA: ARAMIS CAMILO YA ESTÁ Y SE ENLAZA. Cuando escribi esta
-- ficha no existia en el catalogo, y lo deje anotado como ausencia prioritaria
-- por haber salido dos veces el mismo dia. El editor pidio crearlo de inmediato,
-- se creo, y esta ficha se reescribe para enlazarlo en vez de nombrarlo en texto
-- plano.
--
-- FUENTES: Wikipedia en español, con las reservas dichas, para la cronología de
-- orquestas y la discografía con años. BuenaMusica para el nombre, el lugar
-- preciso y la etapa de Boston. Las dos coinciden en el recorrido, que es lo
-- que se escribe.
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
       name = 'Benny Sadel',
       sort_name = 'Sadel, Benny',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1960-03-27',
       birth_year = 1960,
       date_of_death = '2015-11-05',
       birth_place = 'Uvilla, Tamayo',
       province = 'Bahoruco',
       first_name = 'Emmanuel',
       middle_name = NULL,
       last_name = 'Jiménez',
       second_last_name = NULL,
       stage_name = 'Benny Sadel',
       aliases = ARRAY['El Cacique', 'El Cacique del Merengue']::text[],
       occupations = '["bandleader"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Merengue singer known as El Cacique; passed through five orchestras before forming his own',
       bio_en = 'Benny Sadel was a Dominican merengue singer known as El Cacique. He spent a decade moving through other people’s orchestras before he built one of his own, and the route he took — a village band in the south, the capital, Venezuela, Boston and New York — is a fair map of how a Dominican singer of his generation made a career.

**Uvilla**

He was born in 1960 in Uvilla, a settlement in Tamayo, in the southwestern province of Bahoruco. He started singing at birthdays and patron-saint festivals, and in 1977 joined Los X-1 del Sabor, the band of his own town. His music teacher there, Arturo Méndez, told him he would have to go to Santo Domingo, and he went.

**The orchestras**

He was hired by Gerardo Veras for Los Diamantes the day after he arrived in the capital, stayed two years, and moved on to the Santo Domingo All Star Band. When El Equipo was being put together, Dioni Fernández y El Equipo and Sandy Reyes brought him in as a vocalist, and he stayed a year and seven months.

He then went to Venezuela and formed his own group there, Los Jacarandosos de Benny Sadel, with Dominican and Venezuelan players. Wilfrido Vargas offered him a place in his orchestra and he came home for it, but his visa renewal was not processed in time and he was left out of the international tour after only four performances with the band. He went back to Venezuela and picked up his own group again.

In 1983 he joined La Organización Secreta, the orchestra of Aramis Camilo, and it was there that his name travelled: Ven Llévame Contigo and Querida were sung across the continent.

**Caciquiando**

He formed his own orchestra in 1987, putting it together in Boston, and named the first album Caciquiando, which is where the nickname comes from. Alza Tu Copa, Te He Prometido and Yo Soy Así came out of that first stretch, and the group worked Boston and then New York before going to Santo Domingo to record.

The records kept coming through the nineties: Escucha Escucha in 1988, Morenaza in 1992, Majao Majao in 1993, Seguimos Majando in 1995 and Llegó Papá in 1997. Majao Majao, Dicen, Cada Vez Más, Te Seguiré Queriendo, Algo de Mí, Maldita Sea and Amor Amor are the ones people still ask for. Tanto Amor followed in 1998 and Vuelve in 2005.

**Los Toros Band**

In 2008 he joined Los Toros Band as its lead figure, which took him back into a large orchestra after two decades of running his own. He died in New York on 5 November 2015, at fifty-five. Sergio Vargas sang at his wake.',
       bio_es = 'Benny Sadel fue un cantante de merengue dominicano conocido como El Cacique. Pasó una década por orquestas ajenas antes de montar la suya, y el camino que recorrió — una banda de pueblo en el sur, la capital, Venezuela, Boston y Nueva York — es un mapa bastante fiel de cómo se hacía una carrera siendo cantante dominicano de su generación.

**Uvilla**

Nació en 1960 en Uvilla, un paraje de Tamayo, en la provincia sureña de Bahoruco. Empezó cantando en cumpleaños y fiestas patronales, y en 1977 entró a Los X-1 del Sabor, la orquesta de su propio pueblo. Su maestro de música allí, Arturo Méndez, le dijo que tenía que irse a Santo Domingo, y se fue.

**Las orquestas**

Gerardo Veras lo contrató para Los Diamantes al día siguiente de llegar a la capital, se quedó dos años y pasó a la Santo Domingo All Star Band. Cuando se estaba armando El Equipo, Dioni Fernández y El Equipo y Sandy Reyes lo metieron como vocalista, y estuvo un año y siete meses.

Después se fue a Venezuela y montó allá su propio grupo, Los Jacarandosos de Benny Sadel, con músicos dominicanos y venezolanos. Wilfrido Vargas le ofreció un puesto en su orquesta y él volvió al país por eso, pero no le renovaron el visado a tiempo y se quedó fuera de la gira internacional después de apenas cuatro presentaciones con la banda. Regresó a Venezuela y retomó su grupo.

En 1983 entró a La Organización Secreta, la orquesta de Aramis Camilo, y ahí fue donde su nombre viajó: Ven Llévame Contigo y Querida se cantaron por todo el continente.

**Caciquiando**

Montó orquesta propia en 1987, armándola en Boston, y llamó al primer disco Caciquiando, de donde sale el apodo. Alza Tu Copa, Te He Prometido y Yo Soy Así salieron de esa primera tanda, y el grupo trabajó Boston y luego Nueva York antes de ir a Santo Domingo a grabar.

Los discos siguieron saliendo a lo largo de los noventa: Escucha Escucha en 1988, Morenaza en 1992, Majao Majao en 1993, Seguimos Majando en 1995 y Llegó Papá en 1997. Majao Majao, Dicen, Cada Vez Más, Te Seguiré Queriendo, Algo de Mí, Maldita Sea y Amor Amor son las que la gente sigue pidiendo. Tanto Amor vino en 1998 y Vuelve en 2005.

**Los Toros Band**

En 2008 entró a Los Toros Band como figura principal, lo que lo devolvió a una orquesta grande después de dos décadas al frente de la suya. Murió en Nueva York el 5 de noviembre de 2015, a los cincuenta y cinco años. Sergio Vargas cantó en su velatorio.',
       updated_at = now()
 WHERE slug = 'benny-sadel';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Benny Sadel was a Dominican merengue singer known as El Cacique. He spent a decade moving through other people’s orchestras before he built one of his own, and the route he took — a village band in the south, the capital, Venezuela, Boston and New York — is a fair map of how a Dominican singer of his generation made a career.","type":"text"}]},{"type":"paragraph","content":[{"text":"Uvilla","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1960 in Uvilla, a settlement in Tamayo, in the southwestern province of Bahoruco. He started singing at birthdays and patron-saint festivals, and in 1977 joined Los X-1 del Sabor, the band of his own town. His music teacher there, Arturo Méndez, told him he would have to go to Santo Domingo, and he went.","type":"text"}]},{"type":"paragraph","content":[{"text":"The orchestras","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was hired by Gerardo Veras for Los Diamantes the day after he arrived in the capital, stayed two years, and moved on to the Santo Domingo All Star Band. When El Equipo was being put together, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fb2c703f-5362-47dd-ada0-7c6d5e106f3b","displayText":"Dioni Fernández y El Equipo","occurrenceId":"9fd0b951-b0b9-4713-908e-a25e104b4fdd"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"49f8aae7-e066-4b01-a836-126082163c52","displayText":"Sandy Reyes","occurrenceId":"c5737814-8483-485e-9300-dbb0e65c6d29"}},{"text":" brought him in as a vocalist, and he stayed a year and seven months.","type":"text"}]},{"type":"paragraph","content":[{"text":"He then went to Venezuela and formed his own group there, Los Jacarandosos de Benny Sadel, with Dominican and Venezuelan players. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"e7fe386a-dca1-41cc-bd97-c7b687b2dc0f"}},{"text":" offered him a place in his orchestra and he came home for it, but his visa renewal was not processed in time and he was left out of the international tour after only four performances with the band. He went back to Venezuela and picked up his own group again.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 1983 he joined La Organización Secreta, the orchestra of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e5129444-0923-4e06-b77d-f82f14c02b7d","displayText":"Aramis Camilo","occurrenceId":"4ac9bcac-b2d4-4e33-b703-b557f384f3b5"}},{"text":", and it was there that his name travelled: Ven Llévame Contigo and Querida were sung across the continent.","type":"text"}]},{"type":"paragraph","content":[{"text":"Caciquiando","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He formed his own orchestra in 1987, putting it together in Boston, and named the first album Caciquiando, which is where the nickname comes from. Alza Tu Copa, Te He Prometido and Yo Soy Así came out of that first stretch, and the group worked Boston and then New York before going to Santo Domingo to record.","type":"text"}]},{"type":"paragraph","content":[{"text":"The records kept coming through the nineties: Escucha Escucha in 1988, Morenaza in 1992, Majao Majao in 1993, Seguimos Majando in 1995 and Llegó Papá in 1997. Majao Majao, Dicen, Cada Vez Más, Te Seguiré Queriendo, Algo de Mí, Maldita Sea and Amor Amor are the ones people still ask for. Tanto Amor followed in 1998 and Vuelve in 2005.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Toros Band","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2008 he joined ","type":"text"},{"type":"artistReference","attrs":{"artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band","occurrenceId":"fca3f206-2fb1-484a-bd5b-702755ccde6f"}},{"text":" as its lead figure, which took him back into a large orchestra after two decades of running his own. He died in New York on 5 November 2015, at fifty-five. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"742223a4-9322-4e63-a3c9-2296cbd9bab7"}},{"text":" sang at his wake.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'benny-sadel'), 3)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Benny Sadel fue un cantante de merengue dominicano conocido como El Cacique. Pasó una década por orquestas ajenas antes de montar la suya, y el camino que recorrió — una banda de pueblo en el sur, la capital, Venezuela, Boston y Nueva York — es un mapa bastante fiel de cómo se hacía una carrera siendo cantante dominicano de su generación.","type":"text"}]},{"type":"paragraph","content":[{"text":"Uvilla","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1960 en Uvilla, un paraje de Tamayo, en la provincia sureña de Bahoruco. Empezó cantando en cumpleaños y fiestas patronales, y en 1977 entró a Los X-1 del Sabor, la orquesta de su propio pueblo. Su maestro de música allí, Arturo Méndez, le dijo que tenía que irse a Santo Domingo, y se fue.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las orquestas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Gerardo Veras lo contrató para Los Diamantes al día siguiente de llegar a la capital, se quedó dos años y pasó a la Santo Domingo All Star Band. Cuando se estaba armando El Equipo, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fb2c703f-5362-47dd-ada0-7c6d5e106f3b","displayText":"Dioni Fernández y El Equipo","occurrenceId":"f0dcd830-072c-4689-a4a0-08d8e7c898f3"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"49f8aae7-e066-4b01-a836-126082163c52","displayText":"Sandy Reyes","occurrenceId":"2d14af7b-0d3e-4ddd-acab-49eb54db3bbb"}},{"text":" lo metieron como vocalista, y estuvo un año y siete meses.","type":"text"}]},{"type":"paragraph","content":[{"text":"Después se fue a Venezuela y montó allá su propio grupo, Los Jacarandosos de Benny Sadel, con músicos dominicanos y venezolanos. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"b3f6e240-4621-438f-98b0-413a550493fb"}},{"text":" le ofreció un puesto en su orquesta y él volvió al país por eso, pero no le renovaron el visado a tiempo y se quedó fuera de la gira internacional después de apenas cuatro presentaciones con la banda. Regresó a Venezuela y retomó su grupo.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 1983 entró a La Organización Secreta, la orquesta de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e5129444-0923-4e06-b77d-f82f14c02b7d","displayText":"Aramis Camilo","occurrenceId":"0ad48bc4-4d33-4602-a860-625b6c9e6118"}},{"text":", y ahí fue donde su nombre viajó: Ven Llévame Contigo y Querida se cantaron por todo el continente.","type":"text"}]},{"type":"paragraph","content":[{"text":"Caciquiando","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Montó orquesta propia en 1987, armándola en Boston, y llamó al primer disco Caciquiando, de donde sale el apodo. Alza Tu Copa, Te He Prometido y Yo Soy Así salieron de esa primera tanda, y el grupo trabajó Boston y luego Nueva York antes de ir a Santo Domingo a grabar.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los discos siguieron saliendo a lo largo de los noventa: Escucha Escucha en 1988, Morenaza en 1992, Majao Majao en 1993, Seguimos Majando en 1995 y Llegó Papá en 1997. Majao Majao, Dicen, Cada Vez Más, Te Seguiré Queriendo, Algo de Mí, Maldita Sea y Amor Amor son las que la gente sigue pidiendo. Tanto Amor vino en 1998 y Vuelve en 2005.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Toros Band","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2008 entró a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band","occurrenceId":"7e896bbb-0071-44e5-b9f3-be502304af56"}},{"text":" como figura principal, lo que lo devolvió a una orquesta grande después de dos décadas al frente de la suya. Murió en Nueva York el 5 de noviembre de 2015, a los cincuenta y cinco años. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"511cc743-0712-4735-a17b-08650a0ced57"}},{"text":" cantó en su velatorio.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'benny-sadel'), 2)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'en'), '4ac9bcac-b2d4-4e33-b703-b557f384f3b5', 'artist', 'e5129444-0923-4e06-b77d-f82f14c02b7d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'en'), '742223a4-9322-4e63-a3c9-2296cbd9bab7', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'en'), '9fd0b951-b0b9-4713-908e-a25e104b4fdd', 'artist', 'fb2c703f-5362-47dd-ada0-7c6d5e106f3b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'en'), 'c5737814-8483-485e-9300-dbb0e65c6d29', 'artist', '49f8aae7-e066-4b01-a836-126082163c52');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'en'), 'e7fe386a-dca1-41cc-bd97-c7b687b2dc0f', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'en'), 'fca3f206-2fb1-484a-bd5b-702755ccde6f', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'es'), '0ad48bc4-4d33-4602-a860-625b6c9e6118', 'artist', 'e5129444-0923-4e06-b77d-f82f14c02b7d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'es'), '2d14af7b-0d3e-4ddd-acab-49eb54db3bbb', 'artist', '49f8aae7-e066-4b01-a836-126082163c52');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'es'), '511cc743-0712-4735-a17b-08650a0ced57', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'es'), '7e896bbb-0071-44e5-b9f3-be502304af56', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'es'), 'b3f6e240-4621-438f-98b0-413a550493fb', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'es'), 'f0dcd830-072c-4689-a4a0-08d8e7c898f3', 'artist', 'fb2c703f-5362-47dd-ada0-7c6d5e106f3b');

COMMIT;
