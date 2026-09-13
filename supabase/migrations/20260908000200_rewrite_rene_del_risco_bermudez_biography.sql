BEGIN;

-- Rewrite the catalogue entry for René del Risco Bermudez.
--
-- René del Risco Bermúdez.
--
-- YO PROPUSE SACARLO DEL CATÁLOGO Y ME EQUIVOQUÉ. El editor preguntó lo obvio:
-- si alguien grabó algo escrito por él, es compositor. Lo es, y con creces.
--
-- Mi "no encontré nada musical" salió de UNA búsqueda con demasiados operadores
-- que DuckDuckGo devolvió vacía. Con una consulta simple aparece de todo. Es el
-- mismo error que cometí con Luis Días esta mañana: dar por ausente lo que no
-- supe buscar.
--
-- LA PRUEBA, QUE ADEMÁS ES UNA CANCIÓN CANÓNICA:
--
--   "UNA PRIMAVERA PARA EL MUNDO" -- letra de René del Risco, MÚSICA DE RAFAEL
--   SOLANO. La estrenó Fernando Casado, que además cuenta que fue él quien le
--   puso el título al terminar de escribir el texto que Del Risco le dictó. La
--   grabó también Niní Cáffaro. Se cantó en "Siete Días con el Pueblo" en 1974.
--   Lo sostienen Acento (dos artículos), El Día, los Archivos de Américo Mejía
--   y YouTube Music.
--
--   "ASÍ TAN SENCILLAMENTE" -- poema suyo llevado al canto popular por SONIA
--   SILVESTRE, según Diario Libre del 30 de abril de 2020.
--
--   Hay además un concierto entero, "Poesía Viva", dedicado a musicalizar su
--   obra, y poemas suyos cantados por Susana Silfa, Covi Quintana y María del
--   Mar. Existe una Fundación René del Risco que los difunde.
--
-- Diario Libre se refiere a él, en otro artículo, como "el finado POETA Y
-- COMPOSITOR". El primary_role = composer de la fila estaba bien puesto.
--
-- ES EXACTAMENTE EL PRECEDENTE DE BALAGUER: un escritor que no compone música
-- pero cuyos versos los compositores fueron a buscar. La diferencia con Freddy
-- Beras-Goico, que sí quedó fuera, es que de aquel no aparece ningún crédito
-- musical y de este aparecen varios.
--
-- LO QUE LA FICHA VIEJA NO DECÍA: ni una sola de estas canciones. Tenía cuatro
-- párrafos sobre su importancia literaria y una frase de relleno diciendo que
-- "entendía que el merengue, la poesía y la narración eran ramas del mismo
-- árbol". La razón real por la que pertenece a este catálogo no aparecía.
--
-- LAS FECHAS YA LAS CORREGÍ en la migración anterior: nació el 9 de mayo de
-- 1937, no el 2 de octubre, y murió a los 35, no a los 34.
--
-- NO SE TOCA EL CAMPO name, que guarda "Bermudez" SIN TILDE. Wikipedia titula
-- "Bermúdez" y es casi seguro lo correcto, pero name es el texto que los
-- enlaces deben reproducir literalmente y DOS FICHAS YA LO CITAN. Cambiarlo
-- obliga a revisar esas dos. Queda reportado como decisión aparte.
--
-- SE DEJA FUERA: la prisión y deportación a Puerto Rico en 1960, su paso por el
-- Movimiento 14 de Junio y su participación en la Guerra de Abril. Es historia
-- política y personal. SÍ ENTRA que escribió bajo la dictadura y después de
-- ella, porque es el marco de la obra. Mismo criterio que con Ramón Leonardo,
-- donde la cárcel SÍ entró: allí lo encarcelaron POR SUS CANCIONES y aquí la
-- militancia es anterior e independiente de la obra musical.
--
-- TAMPOCO ENTRA la causa de la muerte, ya retirada en la migración anterior.
--
-- CUATRO ENLACES, TODOS POR CRÉDITO DOCUMENTADO: rafael-solano (música de "Una
-- Primavera para el Mundo"), fernando-casado (la estrenó y la tituló),
-- nini-caffaro (la grabó) y sonia-silvestre (llevó "Así tan sencillamente" al
-- canto popular). Las cuatro fichas están en el catálogo y tres de ellas las
-- escribí o revisé en esta corrida.
--
-- SU PARENTESCO CON YAQUI NÚÑEZ DEL RISCO va a la tabla de familia, no a la
-- prosa: eran primos y él lo introdujo en la publicidad. Migración aparte.
--
-- FUENTES: Acento, "Una primavera para el mundo: la utopía en la canción".
-- Acento sobre el testimonio de Fernando Casado. El Día, "Casado tituló tema de
-- René del Risco". Diario Libre, 30 de abril de 2020. Wikipedia en español para
-- la obra literaria y las fechas.
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
       name = 'René del Risco Bermudez',
       sort_name = 'del Risco Bermúdez, René',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'composer',
       primary_genre = 'ballads',
       date_of_birth = '1937-05-09',
       birth_year = 1937,
       date_of_death = '1972-12-20',
       birth_place = 'San Pedro de Macorís',
       province = 'San Pedro de Macorís',
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '["lyricist","writer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Poet and lyricist; wrote the words of Una Primavera para el Mundo',
       bio_en = 'René del Risco Bermúdez was a Dominican poet, short-story writer and lyricist. He belongs in a record of Dominican music for a specific reason: composers went to his verses. The words of Una Primavera para el Mundo, one of the country’s canonical songs, are his.

**San Pedro de Macorís**

He was born in San Pedro de Macorís in 1937, into a family with a literary tradition — his grandfather Federico Bermúdez was the first Dominican social poet. He moved to the capital at the end of the fifties to study law, and by the early sixties had turned to writing full time.

**El Puño**

He founded the cultural group El Puño alongside Marcio Veloz Maggiolo, Miguel Alfonseca and Ramón Francisco, and won the prizes of the La Máscara competition three years running. His poems and stories carried ordinary Dominican speech into literature, and the story Ahora que Vuelvo, Ton became one of the most widely read texts in the country.

He also worked in radio, presenting programmes on two of the capital’s stations, and later in advertising, where he founded his own agency.

**Una Primavera para el Mundo**

At the start of the seventies he wrote words for a melody by Rafael Solano. The song was first performed by Fernando Casado, who has said that he was the one who gave it its title, writing down the text as Del Risco dictated it. Niní Cáffaro also recorded it, and it was sung at the festival Siete Días con el Pueblo in 1974.

It is a song of address, written in the second person, and it has outlived its moment: it circulated again half a century later, during the pandemic, without anyone having to explain it.

**Así Tan Sencillamente**

His poem Así Tan Sencillamente was taken into popular song by Sonia Silvestre. Others have followed: a concert series devoted to setting his poems to music has brought several of them to singers of later generations, and the foundation that carries his name keeps circulating them.

**The work**

His published books are few because he died young: a collection of poems, a book of stories issued after his death, and a novel that stayed unpublished for twenty-five years. He died in Santo Domingo in December 1972, at thirty-five. His work is taught in Dominican schools, and the songs built on it are sung by people who have never read the books.',
       bio_es = 'René del Risco Bermúdez fue un poeta, cuentista y letrista dominicano. Pertenece a un registro de la música dominicana por una razón concreta: los compositores fueron a buscar sus versos. La letra de Una Primavera para el Mundo, una de las canciones canónicas del país, es suya.

**San Pedro de Macorís**

Nació en San Pedro de Macorís en 1937, en una familia de tradición literaria: su abuelo Federico Bermúdez fue el primer poeta social dominicano. Se trasladó a la capital a finales de los cincuenta para estudiar derecho, y a principios de los sesenta ya se dedicaba de lleno a escribir.

**El Puño**

Fundó el grupo cultural El Puño junto a Marcio Veloz Maggiolo, Miguel Alfonseca y Ramón Francisco, y ganó los premios del concurso La Máscara tres años seguidos. Sus poemas y cuentos metieron el habla dominicana corriente en la literatura, y el cuento Ahora que Vuelvo, Ton se convirtió en uno de los textos más leídos del país.

Trabajó además en la radio, conduciendo programas en dos emisoras de la capital, y más tarde en la publicidad, donde fundó su propia agencia.

**Una Primavera para el Mundo**

A principios de los setenta le puso letra a una melodía de Rafael Solano. La estrenó Fernando Casado, que ha contado que fue él quien le puso el título, mientras anotaba el texto que Del Risco le dictaba. Niní Cáffaro también la grabó, y se cantó en el festival Siete Días con el Pueblo en 1974.

Es una canción de interpelación, escrita en segunda persona, y ha sobrevivido a su momento: volvió a circular medio siglo después, durante la pandemia, sin que nadie tuviera que explicarla.

**Así Tan Sencillamente**

Su poema Así Tan Sencillamente lo llevó al canto popular Sonia Silvestre. Otros vinieron detrás: una serie de conciertos dedicada a musicalizar su obra ha puesto varios de sus poemas en voces de generaciones posteriores, y la fundación que lleva su nombre los sigue haciendo circular.

**La obra**

Sus libros publicados son pocos porque murió joven: un poemario, un libro de cuentos que salió después de su muerte, y una novela que quedó inédita veinticinco años. Murió en Santo Domingo en diciembre de 1972, a los treinta y cinco. Su obra se estudia en las escuelas dominicanas, y las canciones levantadas sobre ella las canta gente que nunca leyó los libros.',
       updated_at = now()
 WHERE slug = 'rene-del-risco-bermudez';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"René del Risco Bermúdez was a Dominican poet, short-story writer and lyricist. He belongs in a record of Dominican music for a specific reason: composers went to his verses. The words of Una Primavera para el Mundo, one of the country’s canonical songs, are his.","type":"text"}]},{"type":"paragraph","content":[{"text":"San Pedro de Macorís","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in San Pedro de Macorís in 1937, into a family with a literary tradition — his grandfather Federico Bermúdez was the first Dominican social poet. He moved to the capital at the end of the fifties to study law, and by the early sixties had turned to writing full time.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Puño","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He founded the cultural group El Puño alongside Marcio Veloz Maggiolo, Miguel Alfonseca and Ramón Francisco, and won the prizes of the La Máscara competition three years running. His poems and stories carried ordinary Dominican speech into literature, and the story Ahora que Vuelvo, Ton became one of the most widely read texts in the country.","type":"text"}]},{"type":"paragraph","content":[{"text":"He also worked in radio, presenting programmes on two of the capital’s stations, and later in advertising, where he founded his own agency.","type":"text"}]},{"type":"paragraph","content":[{"text":"Una Primavera para el Mundo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"At the start of the seventies he wrote words for a melody by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"03a21731-a55f-466b-93e3-1935c6a584bd"}},{"text":". The song was first performed by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1131dfe6-f404-44b4-8d0d-f8120dc6f71a","displayText":"Fernando Casado","occurrenceId":"7e57dcaf-d194-419b-8df9-a845445e1707"}},{"text":", who has said that he was the one who gave it its title, writing down the text as Del Risco dictated it. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"19124a2a-a49c-435e-989e-049b5dc3726c","displayText":"Niní Cáffaro","occurrenceId":"ad32ca6f-7a4a-428f-8dad-3052e76f6128"}},{"text":" also recorded it, and it was sung at the festival Siete Días con el Pueblo in 1974.","type":"text"}]},{"type":"paragraph","content":[{"text":"It is a song of address, written in the second person, and it has outlived its moment: it circulated again half a century later, during the pandemic, without anyone having to explain it.","type":"text"}]},{"type":"paragraph","content":[{"text":"Así Tan Sencillamente","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His poem Así Tan Sencillamente was taken into popular song by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre","occurrenceId":"7258b05f-94ac-4757-8f93-116f996a5bf3"}},{"text":". Others have followed: a concert series devoted to setting his poems to music has brought several of them to singers of later generations, and the foundation that carries his name keeps circulating them.","type":"text"}]},{"type":"paragraph","content":[{"text":"The work","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His published books are few because he died young: a collection of poems, a book of stories issued after his death, and a novel that stayed unpublished for twenty-five years. He died in Santo Domingo in December 1972, at thirty-five. His work is taught in Dominican schools, and the songs built on it are sung by people who have never read the books.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez'), 4)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"René del Risco Bermúdez fue un poeta, cuentista y letrista dominicano. Pertenece a un registro de la música dominicana por una razón concreta: los compositores fueron a buscar sus versos. La letra de Una Primavera para el Mundo, una de las canciones canónicas del país, es suya.","type":"text"}]},{"type":"paragraph","content":[{"text":"San Pedro de Macorís","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en San Pedro de Macorís en 1937, en una familia de tradición literaria: su abuelo Federico Bermúdez fue el primer poeta social dominicano. Se trasladó a la capital a finales de los cincuenta para estudiar derecho, y a principios de los sesenta ya se dedicaba de lleno a escribir.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Puño","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Fundó el grupo cultural El Puño junto a Marcio Veloz Maggiolo, Miguel Alfonseca y Ramón Francisco, y ganó los premios del concurso La Máscara tres años seguidos. Sus poemas y cuentos metieron el habla dominicana corriente en la literatura, y el cuento Ahora que Vuelvo, Ton se convirtió en uno de los textos más leídos del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Trabajó además en la radio, conduciendo programas en dos emisoras de la capital, y más tarde en la publicidad, donde fundó su propia agencia.","type":"text"}]},{"type":"paragraph","content":[{"text":"Una Primavera para el Mundo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A principios de los setenta le puso letra a una melodía de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"d9373eba-2021-4e79-aeb1-caeefd61dde8"}},{"text":". La estrenó ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1131dfe6-f404-44b4-8d0d-f8120dc6f71a","displayText":"Fernando Casado","occurrenceId":"7d7a24ed-3019-45d0-be2e-91d1320d9bd4"}},{"text":", que ha contado que fue él quien le puso el título, mientras anotaba el texto que Del Risco le dictaba. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"19124a2a-a49c-435e-989e-049b5dc3726c","displayText":"Niní Cáffaro","occurrenceId":"daa42848-ef11-4a4a-8d5b-ad59ddf43d4f"}},{"text":" también la grabó, y se cantó en el festival Siete Días con el Pueblo en 1974.","type":"text"}]},{"type":"paragraph","content":[{"text":"Es una canción de interpelación, escrita en segunda persona, y ha sobrevivido a su momento: volvió a circular medio siglo después, durante la pandemia, sin que nadie tuviera que explicarla.","type":"text"}]},{"type":"paragraph","content":[{"text":"Así Tan Sencillamente","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su poema Así Tan Sencillamente lo llevó al canto popular ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre","occurrenceId":"67b9d830-b0bc-4051-a564-854c79584556"}},{"text":". Otros vinieron detrás: una serie de conciertos dedicada a musicalizar su obra ha puesto varios de sus poemas en voces de generaciones posteriores, y la fundación que lleva su nombre los sigue haciendo circular.","type":"text"}]},{"type":"paragraph","content":[{"text":"La obra","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Sus libros publicados son pocos porque murió joven: un poemario, un libro de cuentos que salió después de su muerte, y una novela que quedó inédita veinticinco años. Murió en Santo Domingo en diciembre de 1972, a los treinta y cinco. Su obra se estudia en las escuelas dominicanas, y las canciones levantadas sobre ella las canta gente que nunca leyó los libros.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez') AND locale = 'en'), '03a21731-a55f-466b-93e3-1935c6a584bd', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez') AND locale = 'en'), '7258b05f-94ac-4757-8f93-116f996a5bf3', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez') AND locale = 'en'), '7e57dcaf-d194-419b-8df9-a845445e1707', 'artist', '1131dfe6-f404-44b4-8d0d-f8120dc6f71a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez') AND locale = 'en'), 'ad32ca6f-7a4a-428f-8dad-3052e76f6128', 'artist', '19124a2a-a49c-435e-989e-049b5dc3726c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez') AND locale = 'es'), '67b9d830-b0bc-4051-a564-854c79584556', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez') AND locale = 'es'), '7d7a24ed-3019-45d0-be2e-91d1320d9bd4', 'artist', '1131dfe6-f404-44b4-8d0d-f8120dc6f71a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez') AND locale = 'es'), 'd9373eba-2021-4e79-aeb1-caeefd61dde8', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez') AND locale = 'es'), 'daa42848-ef11-4a4a-8d5b-ad59ddf43d4f', 'artist', '19124a2a-a49c-435e-989e-049b5dc3726c');

COMMIT;
