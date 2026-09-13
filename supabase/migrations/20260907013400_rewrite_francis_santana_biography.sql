BEGIN;

-- Rewrite the catalogue entry for Francis Santana.
--
-- Francis Santana. Séptima de las dieciséis fichas publicadas que estaban EN
-- BLANCO. Sesenta y cinco años de carrera, de los tríos de radio de los años
-- cuarenta a los discos de bolero de 2010, y su página no decía nada.
--
-- LO QUE YA TENÍA LA FILA SE CONFIRMA Y NO SE TOCA: Juan Francisco Santana
-- Solís, 20 de junio de 1929, Santo Domingo; muerte el 11 de enero de 2014;
-- ended en true.
--
-- DOS ERRORES DE FUENTE QUE NO SE COPIAN:
--
--   1. El encabezado de Wikipedia dice que nació el 11 DE JUNIO. El cuerpo del
--      mismo artículo, EcuRed, La Crónica y El Caribe dicen el 20 DE JUNIO, que
--      es lo que la fila ya guardaba. Se queda el 20. El 11 parece contagio de
--      la fecha de muerte, que sí es 11 (de enero).
--
--   2. La Crónica dice que murió con 85 años. Nacido en junio de 1929 y muerto
--      en enero de 2014, tenía 84. Wikipedia también dice 84. La ficha dice 84.
--
-- NO SE ESCRIBE EL OFICIO DEL PADRE, aunque es el dato más tentador del
-- expediente: Wikipedia cuenta que era cantante y de las primeras personas en
-- grabar discos en el país. La regla de vida privada nombra expresamente los
-- oficios de los padres. Queda fuera. Tampoco entran esposa ni hijos.
--
-- SE AÑADE EL APODO "EL SONGO", que usan todas las fuentes y que la fila no
-- tenía.
--
-- GÉNERO, DECISIÓN DEL EDITOR: la fila dice bolero y NO LO CAMBIO, pero conste
-- que está en discusión. La Crónica sostiene que sus dos ritmos favoritos eran
-- el merengue y el son, y que "su carrera ganó reconocimiento gracias al
-- merengue"; el crítico José del Castillo Pichardo lo llama "un prodigio del
-- merengue, el son y el bolero". El bolero domina su última etapa y el infobox
-- de Wikipedia. Se agrega merengue en genres, que no repite el primario. Si se
-- quiere mover, la línea es primary_genre.
--
-- EL SON NO ENTRA EN genres porque no es uno de los nueve géneros de nivel 0
-- aprobados. Se cuenta en la prosa, que es donde cabe sin romper la taxonomía.
--
-- NO SE LE PONE COMPOSITOR pese a que BuenaMusica y PlusMusicas lo listan como
-- "cantante, compositor y músico". Todo lo que canta y que tiene autor
-- identificado es de otros: "Límpiate el bozo" es de Antonio Morel. Sin una
-- sola canción firmada por él, occupations queda vacío y primary_role singer
-- dice todo lo que se puede probar.
--
-- CUATRO ENLACES, TODOS DOCUMENTADOS: rafael-solano, en cuya orquesta trabajó
-- décadas; joseito-mateo, con quien compartió la Orquesta Caribe;
-- victor-victor y jorge-taveras, los dos detrás de "En son de felicidad".
--
-- SOBRE FREDDY BERAS-GOICO, que el editor pidió comprobar: vuelve a aparecer
-- aquí, pero otra vez como televisión. La Crónica lo menciona conduciendo
-- "Punto Final", el programa donde Santana se presentaba al final de su
-- carrera. NO ENCONTRÉ NINGÚN CRÉDITO MUSICAL suyo -- ni autoría, ni
-- producción de disco, ni interpretación. El criterio del editor se sostiene y
-- no se le abre ficha.
--
-- LOS PREMIOS VAN EN MIGRACIÓN APARTE: son tres y hay que crear tres entidades.
--
-- FUENTES: La Crónica, 11 de enero de 2014, obituario de Máximo Jiménez, que es
-- con diferencia la fuente más detallada. Wikipedia en español. EcuRed. El
-- Caribe.
--
-- NOMBRES NUEVOS PARA LA LISTA DE FALTANTES, y son un hueco de época entero:
-- Antonio Morel, Carlos Taylor y su trío Los Taylor, Rafael Colón, Paco
-- Escribano, Napoleón Zayas, la Orquesta Angelita y la Orquesta Caribe.
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
       name = 'Francis Santana',
       sort_name = 'Santana Solís, Juan Francisco',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'bolero',
       date_of_birth = '1929-06-20',
       birth_year = 1929,
       date_of_death = '2014-01-11',
       birth_place = 'Santo Domingo',
       province = 'Santo Domingo',
       first_name = 'Juan',
       middle_name = 'Francisco',
       last_name = 'Santana',
       second_last_name = 'Solís',
       stage_name = 'Francis Santana',
       aliases = ARRAY['El Songo']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY['merengue']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Singer known as El Songo; one of the first voices carried by Dominican radio and television, across merengue, son and bolero',
       bio_en = 'Juan Francisco Santana Solís, known as Francis Santana and nicknamed El Songo, was a Dominican singer. He worked for more than six decades in merengue, son and bolero, and he was among the first vocalists whose voice reached a national audience through Dominican radio and, later, television.

**San Carlos**

He was born in 1929 in San Carlos, at the time a municipality of its own and today a barrio of Santo Domingo. He began singing at fourteen with Los Taylor, the trio led by the guitarist and composer Carlos Taylor, appearing on the radio station HIT. Through the forties he performed with Paco Escribano on the station HIZ and in the capital’s fashionable cabarets.

**The orchestras**

In 1947 he joined the Orquesta Antillana of Antonio Morel. He became an exclusive artist of La Voz Dominicana in 1951 and joined the Orquesta Ciudad Trujillo in 1953, touring the island Caribbean with it. He also sang with the Orquesta Angelita, carried merengue abroad with the orchestra of Napoleón Zayas, and shared the Orquesta Caribe with Joseíto Mateo.

His longest association was with the orchestra of Rafael Solano, where he sang for decades.

**Merengue**

Límpiate el Bozo, a composition by Morel released in 1951, is regarded as his first recorded merengue. Many followed: El Negro Feliz, El Cayetano Baila, Alevántate, La Maricutana, Caña Brava, Apágame la Vela, Arroyito Cristalino, Compadre Pedro Juan, Baitolina and Bambaraquiti among them.

Massá Massá, which he recorded in 1956, came from Haitian folklore and became one of the pieces most associated with his voice.

**Bolero**

The bolero occupied him just as long. Confesión de Amor, Magia, Está Bien, Confundidos, En la Oscuridad, Hay Noches and No Juegues con el Amor are among his recordings, and a late album gathered a wide selection of the Dominican bolero repertoire, including Sígueme, A Primera Vista, Paraíso Soñado, Dueña de Mí, Invernal, Tus Cabellos and Arenas del Desierto.

**En Son de Felicidad**

The album En Son de Felicidad, made with Víctor Víctor and Jorge Taveras, is the record of his that critics return to. In 2013 the Asociación de Cronistas de Arte placed it among the hundred essential albums of Dominican music. He also recorded a long-playing collection with the singer Rafael Colón.

**Recognition**

BanReservas named him a national musical reserve in 2005, an honour that came with a compilation of his recordings. The culture ministry declared him a national figure of popular art in 2007, marking sixty-three years in music, and the national council for the elderly honoured him in 2012. He performed only occasionally in his last years, appearing on television, and died in Santo Domingo in January 2014, at eighty-four.',
       bio_es = 'Juan Francisco Santana Solís, conocido como Francis Santana y apodado El Songo, fue un cantante dominicano. Trabajó más de seis décadas en el merengue, el son y el bolero, y fue de los primeros vocalistas cuya voz llegó a un público nacional a través de la radio dominicana y, más tarde, de la televisión.

**San Carlos**

Nació en 1929 en San Carlos, entonces municipio propio y hoy barrio de Santo Domingo. Empezó a cantar a los catorce años con Los Taylor, el trío que dirigía el guitarrista y compositor Carlos Taylor, presentándose en la emisora HIT. Durante los cuarenta actuó junto a Paco Escribano en la emisora HIZ y en los cabarés de moda de la capital.

**Las orquestas**

En 1947 entró a la Orquesta Antillana de Antonio Morel. En 1951 pasó a ser artista exclusivo de La Voz Dominicana y en 1953 se integró a la Orquesta Ciudad Trujillo, con la que recorrió el Caribe insular. Cantó también con la Orquesta Angelita, llevó el merengue al exterior con la orquesta de Napoleón Zayas, y compartió la Orquesta Caribe con Joseíto Mateo.

Su vínculo más largo fue con la orquesta de Rafael Solano, donde cantó durante décadas.

**El merengue**

Límpiate el Bozo, composición de Morel publicada en 1951, se tiene por su primer merengue grabado. Detrás vinieron muchos: El Negro Feliz, El Cayetano Baila, Alevántate, La Maricutana, Caña Brava, Apágame la Vela, Arroyito Cristalino, Compadre Pedro Juan, Baitolina y Bambaraquiti, entre otros.

Massá Massá, que grabó en 1956, venía del folklore haitiano y quedó como una de las piezas más asociadas a su voz.

**El bolero**

El bolero lo ocupó igual de tiempo. Confesión de Amor, Magia, Está Bien, Confundidos, En la Oscuridad, Hay Noches y No Juegues con el Amor están entre sus grabaciones, y un álbum tardío reunió una selección amplia del repertorio bolerístico dominicano, con Sígueme, A Primera Vista, Paraíso Soñado, Dueña de Mí, Invernal, Tus Cabellos y Arenas del Desierto.

**En son de felicidad**

El álbum En Son de Felicidad, hecho junto a Víctor Víctor y Jorge Taveras, es el disco suyo al que vuelve la crítica. En 2013 la Asociación de Cronistas de Arte lo situó entre los cien álbumes esenciales de la música dominicana. Grabó además un larga duración junto al cantante Rafael Colón.

**Reconocimientos**

BanReservas lo declaró Reserva Musical Nacional en 2005, honor que vino acompañado de una recopilación de sus grabaciones. La cartera de Cultura lo declaró Gloria Nacional del Arte Popular en 2007, al cumplir sesenta y tres años en la música, y el consejo nacional de la persona envejeciente lo distinguió en 2012. En sus últimos años se presentaba solo de manera ocasional, sobre todo en televisión, y murió en Santo Domingo en enero de 2014, a los ochenta y cuatro años.',
       updated_at = now()
 WHERE slug = 'francis-santana';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'francis-santana')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'francis-santana')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan Francisco Santana Solís, known as Francis Santana and nicknamed El Songo, was a Dominican singer. He worked for more than six decades in merengue, son and bolero, and he was among the first vocalists whose voice reached a national audience through Dominican radio and, later, television.","type":"text"}]},{"type":"paragraph","content":[{"text":"San Carlos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1929 in San Carlos, at the time a municipality of its own and today a barrio of Santo Domingo. He began singing at fourteen with Los Taylor, the trio led by the guitarist and composer Carlos Taylor, appearing on the radio station HIT. Through the forties he performed with Paco Escribano on the station HIZ and in the capital’s fashionable cabarets.","type":"text"}]},{"type":"paragraph","content":[{"text":"The orchestras","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1947 he joined the Orquesta Antillana of Antonio Morel. He became an exclusive artist of La Voz Dominicana in 1951 and joined the Orquesta Ciudad Trujillo in 1953, touring the island Caribbean with it. He also sang with the Orquesta Angelita, carried merengue abroad with the orchestra of Napoleón Zayas, and shared the Orquesta Caribe with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8c784f57-4ee4-41b5-b140-c45d0da1c5f6","displayText":"Joseíto Mateo","occurrenceId":"7cd7195b-c4a4-49e9-ad1e-39f3cd7566ae"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"His longest association was with the orchestra of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"5b114817-2f33-4432-8ac3-a2a3b38c8b43"}},{"text":", where he sang for decades.","type":"text"}]},{"type":"paragraph","content":[{"text":"Merengue","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Límpiate el Bozo, a composition by Morel released in 1951, is regarded as his first recorded merengue. Many followed: El Negro Feliz, El Cayetano Baila, Alevántate, La Maricutana, Caña Brava, Apágame la Vela, Arroyito Cristalino, Compadre Pedro Juan, Baitolina and Bambaraquiti among them.","type":"text"}]},{"type":"paragraph","content":[{"text":"Massá Massá, which he recorded in 1956, came from Haitian folklore and became one of the pieces most associated with his voice.","type":"text"}]},{"type":"paragraph","content":[{"text":"Bolero","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The bolero occupied him just as long. Confesión de Amor, Magia, Está Bien, Confundidos, En la Oscuridad, Hay Noches and No Juegues con el Amor are among his recordings, and a late album gathered a wide selection of the Dominican bolero repertoire, including Sígueme, A Primera Vista, Paraíso Soñado, Dueña de Mí, Invernal, Tus Cabellos and Arenas del Desierto.","type":"text"}]},{"type":"paragraph","content":[{"text":"En Son de Felicidad","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The album En Son de Felicidad, made with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor","occurrenceId":"164e84d6-2593-478c-8897-3221eb55d595"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c958758c-a949-4bd9-963d-6d48bc750b60","displayText":"Jorge Taveras","occurrenceId":"5a28765c-4cd9-477f-af07-243b0bb4aa81"}},{"text":", is the record of his that critics return to. In 2013 the Asociación de Cronistas de Arte placed it among the hundred essential albums of Dominican music. He also recorded a long-playing collection with the singer Rafael Colón.","type":"text"}]},{"type":"paragraph","content":[{"text":"Recognition","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"BanReservas named him a national musical reserve in 2005, an honour that came with a compilation of his recordings. The culture ministry declared him a national figure of popular art in 2007, marking sixty-three years in music, and the national council for the elderly honoured him in 2012. He performed only occasionally in his last years, appearing on television, and died in Santo Domingo in January 2014, at eighty-four.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'francis-santana'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan Francisco Santana Solís, conocido como Francis Santana y apodado El Songo, fue un cantante dominicano. Trabajó más de seis décadas en el merengue, el son y el bolero, y fue de los primeros vocalistas cuya voz llegó a un público nacional a través de la radio dominicana y, más tarde, de la televisión.","type":"text"}]},{"type":"paragraph","content":[{"text":"San Carlos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1929 en San Carlos, entonces municipio propio y hoy barrio de Santo Domingo. Empezó a cantar a los catorce años con Los Taylor, el trío que dirigía el guitarrista y compositor Carlos Taylor, presentándose en la emisora HIT. Durante los cuarenta actuó junto a Paco Escribano en la emisora HIZ y en los cabarés de moda de la capital.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las orquestas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1947 entró a la Orquesta Antillana de Antonio Morel. En 1951 pasó a ser artista exclusivo de La Voz Dominicana y en 1953 se integró a la Orquesta Ciudad Trujillo, con la que recorrió el Caribe insular. Cantó también con la Orquesta Angelita, llevó el merengue al exterior con la orquesta de Napoleón Zayas, y compartió la Orquesta Caribe con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8c784f57-4ee4-41b5-b140-c45d0da1c5f6","displayText":"Joseíto Mateo","occurrenceId":"a8df8b99-b98f-460e-adc9-78a74ff2fec7"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Su vínculo más largo fue con la orquesta de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"5d37a853-f580-4651-b942-7492248c66fc"}},{"text":", donde cantó durante décadas.","type":"text"}]},{"type":"paragraph","content":[{"text":"El merengue","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Límpiate el Bozo, composición de Morel publicada en 1951, se tiene por su primer merengue grabado. Detrás vinieron muchos: El Negro Feliz, El Cayetano Baila, Alevántate, La Maricutana, Caña Brava, Apágame la Vela, Arroyito Cristalino, Compadre Pedro Juan, Baitolina y Bambaraquiti, entre otros.","type":"text"}]},{"type":"paragraph","content":[{"text":"Massá Massá, que grabó en 1956, venía del folklore haitiano y quedó como una de las piezas más asociadas a su voz.","type":"text"}]},{"type":"paragraph","content":[{"text":"El bolero","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El bolero lo ocupó igual de tiempo. Confesión de Amor, Magia, Está Bien, Confundidos, En la Oscuridad, Hay Noches y No Juegues con el Amor están entre sus grabaciones, y un álbum tardío reunió una selección amplia del repertorio bolerístico dominicano, con Sígueme, A Primera Vista, Paraíso Soñado, Dueña de Mí, Invernal, Tus Cabellos y Arenas del Desierto.","type":"text"}]},{"type":"paragraph","content":[{"text":"En son de felicidad","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El álbum En Son de Felicidad, hecho junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor","occurrenceId":"75c24550-bc5a-465d-b8ef-61021aded0a1"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c958758c-a949-4bd9-963d-6d48bc750b60","displayText":"Jorge Taveras","occurrenceId":"a9c49a92-c7a7-420e-8480-be0cb0618e11"}},{"text":", es el disco suyo al que vuelve la crítica. En 2013 la Asociación de Cronistas de Arte lo situó entre los cien álbumes esenciales de la música dominicana. Grabó además un larga duración junto al cantante Rafael Colón.","type":"text"}]},{"type":"paragraph","content":[{"text":"Reconocimientos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"BanReservas lo declaró Reserva Musical Nacional en 2005, honor que vino acompañado de una recopilación de sus grabaciones. La cartera de Cultura lo declaró Gloria Nacional del Arte Popular en 2007, al cumplir sesenta y tres años en la música, y el consejo nacional de la persona envejeciente lo distinguió en 2012. En sus últimos años se presentaba solo de manera ocasional, sobre todo en televisión, y murió en Santo Domingo en enero de 2014, a los ochenta y cuatro años.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'francis-santana'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'francis-santana') AND locale = 'en'), '164e84d6-2593-478c-8897-3221eb55d595', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'francis-santana') AND locale = 'en'), '5a28765c-4cd9-477f-af07-243b0bb4aa81', 'artist', 'c958758c-a949-4bd9-963d-6d48bc750b60');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'francis-santana') AND locale = 'en'), '5b114817-2f33-4432-8ac3-a2a3b38c8b43', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'francis-santana') AND locale = 'en'), '7cd7195b-c4a4-49e9-ad1e-39f3cd7566ae', 'artist', '8c784f57-4ee4-41b5-b140-c45d0da1c5f6');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'francis-santana') AND locale = 'es'), '5d37a853-f580-4651-b942-7492248c66fc', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'francis-santana') AND locale = 'es'), '75c24550-bc5a-465d-b8ef-61021aded0a1', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'francis-santana') AND locale = 'es'), 'a8df8b99-b98f-460e-adc9-78a74ff2fec7', 'artist', '8c784f57-4ee4-41b5-b140-c45d0da1c5f6');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'francis-santana') AND locale = 'es'), 'a9c49a92-c7a7-420e-8480-be0cb0618e11', 'artist', 'c958758c-a949-4bd9-963d-6d48bc750b60');

COMMIT;
