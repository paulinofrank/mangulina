BEGIN;

-- Ficha de Bienvenido Fabián.
--
-- La biografía de relleno lo presentaba como cantante de bolero sin obra. Era compositor, pianista
-- y locutor: «Goza negra» y «Tuya más que tuya» para Celia Cruz y La Sonora Matancera, y
-- «Condena» («Qué será de mí»), grabada por José Manuel Calderón.
-- occupations: pianist, singer, bandleader (Discogs, Alci de la Rosa 2013, Puly Gómez).
-- instruments: piano, guitar (Américo Mejía y Puly Gómez: guitarrista).
-- No usado: «Dos almas», que Wikipedia (en) le atribuye y es de Don Fabián (Argentina).

UPDATE artists SET occupations = '["pianist","singer","bandleader"]'::jsonb, instruments = ARRAY['piano', 'guitar']::text[] WHERE slug = 'bienvenido-fabian';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Bienvenido Fabián (San Pedro de Macorís, 20 March 1920 – Santo Domingo, 23 November 2000) was a Dominican composer, pianist, singer and radio announcer. In the 1950s his songs reached Celia Cruz and «La Sonora Matancera» in Havana, and his «Condena», also titled «Qué será de mí», is one of the songs on the recording counted as the beginning of bachata’s discography."}]},{"type":"paragraph","content":[{"type":"text","text":"Merengue at the piano","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As a player he made his name in the 1950s with two piano pieces, «Merengue en concierto» and «Ritmo de merengue», recordings noted for his fingerwork on the keyboard. He also played the guitar, worked as a radio announcer and led a group of his own, credited on record as «Bienvenido Fabián y su Combo» and «Bienvenido Fabián y su Conjunto», with which he recorded numbers such as «Chanflín»."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Sonora Matancera»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The Cuban band recorded his «Goza negra» with Celia Cruz as lead voice in the mid-1950s, and Cruz also sang his «Tuya más que tuya», a bolero cha-cha-chá. Decades later "},{"type":"artistReference","attrs":{"occurrenceId":"7a30beba-f50e-43ba-a301-fe18d57abcce","artistId":"d9ef5d29-573a-4812-b717-18a783d95a70","displayText":"Michel el Buenón"}},{"type":"text","text":" recorded the song again, as «Tuyo más que tuyo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Dominican voices","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"At home, the singer who recorded the most of his songs was "},{"type":"artistReference","attrs":{"occurrenceId":"b9784292-551d-48af-afa2-a9b012d1330c","artistId":"8da26ee1-8079-4232-b9a2-66eccee08cb3","displayText":"Elenita Santos"}},{"type":"text","text":": «Besarte», «Mi estrella», «Quién si no tú», «Al fin te fuiste». An LP issued under her name, «Piensa en mí», credits Fabián alongside «Ángel Bussi y su Conjunto». His catalogue also includes the boleros «Mi noche fatal», «Di que no», «Lo que te pido» and «De qué color son tus ojos», and "},{"type":"artistReference","attrs":{"occurrenceId":"15c0d541-016e-405c-bc66-ef1fe8b9e729","artistId":"0daa71b6-6cca-471d-961f-e65f6caa2db1","displayText":"Isidoro Flores"}},{"type":"text","text":" and his conjunto drew on his compositions for the album «La Sabrosona»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Condena»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"When "},{"type":"artistReference","attrs":{"occurrenceId":"cd168f63-5442-4d84-b146-2d2a57912bd9","artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón"}},{"type":"text","text":" went into the studio for the sides now counted as the first recorded bachatas, one of the songs was Fabián’s «Condena», which also circulates as «Qué será de mí»; in 2017 Calderón named Fabián as its author. According to the broadcaster Alci de la Rosa, Fabián accompanied Calderón at the piano on several of his hits. The song was later taken up by "},{"type":"artistReference","attrs":{"occurrenceId":"d7527927-d5cd-40af-9549-1130b852280c","artistId":"f6f95f0f-e008-47b9-8b4c-10fe5508bfd9","displayText":"Los Ahijados"}},{"type":"text","text":", the duo of "},{"type":"artistReference","attrs":{"occurrenceId":"f8add068-2a15-4f51-b50a-796ba7ae334f","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"a36ece8c-3de1-4eed-918c-77f089238b38","artistId":"6eccc3e7-82bf-435f-8ae1-ea7e8a721560","displayText":"Martín Valoy"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fabián died in Santo Domingo on 23 November 2000, at the age of 80. His work runs through three currents of Dominican popular music at mid-century — the concert merengue for piano, the bolero taken up by Cuba’s best-known sonora, and the song at the start of recorded bachata."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bienvenido-fabian'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7a30beba-f50e-43ba-a301-fe18d57abcce', 'artist', 'd9ef5d29-573a-4812-b717-18a783d95a70' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b9784292-551d-48af-afa2-a9b012d1330c', 'artist', '8da26ee1-8079-4232-b9a2-66eccee08cb3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '15c0d541-016e-405c-bc66-ef1fe8b9e729', 'artist', '0daa71b6-6cca-471d-961f-e65f6caa2db1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cd168f63-5442-4d84-b146-2d2a57912bd9', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd7527927-d5cd-40af-9549-1130b852280c', 'artist', 'f6f95f0f-e008-47b9-8b4c-10fe5508bfd9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f8add068-2a15-4f51-b50a-796ba7ae334f', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a36ece8c-3de1-4eed-918c-77f089238b38', 'artist', '6eccc3e7-82bf-435f-8ae1-ea7e8a721560' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Bienvenido Fabián (San Pedro de Macorís, 20 March 1920 – Santo Domingo, 23 November 2000) was a Dominican composer, pianist, singer and radio announcer. In the 1950s his songs reached Celia Cruz and «La Sonora Matancera» in Havana, and his «Condena», also titled «Qué será de mí», is one of the songs on the recording counted as the beginning of bachata’s discography.

**Merengue at the piano**

As a player he made his name in the 1950s with two piano pieces, «Merengue en concierto» and «Ritmo de merengue», recordings noted for his fingerwork on the keyboard. He also played the guitar, worked as a radio announcer and led a group of his own, credited on record as «Bienvenido Fabián y su Combo» and «Bienvenido Fabián y su Conjunto», with which he recorded numbers such as «Chanflín».

**«La Sonora Matancera»**

The Cuban band recorded his «Goza negra» with Celia Cruz as lead voice in the mid-1950s, and Cruz also sang his «Tuya más que tuya», a bolero cha-cha-chá. Decades later Michel el Buenón recorded the song again, as «Tuyo más que tuyo».

**Dominican voices**

At home, the singer who recorded the most of his songs was Elenita Santos: «Besarte», «Mi estrella», «Quién si no tú», «Al fin te fuiste». An LP issued under her name, «Piensa en mí», credits Fabián alongside «Ángel Bussi y su Conjunto». His catalogue also includes the boleros «Mi noche fatal», «Di que no», «Lo que te pido» and «De qué color son tus ojos», and Isidoro Flores and his conjunto drew on his compositions for the album «La Sabrosona».

**«Condena»**

When José Manuel Calderón went into the studio for the sides now counted as the first recorded bachatas, one of the songs was Fabián’s «Condena», which also circulates as «Qué será de mí»; in 2017 Calderón named Fabián as its author. According to the broadcaster Alci de la Rosa, Fabián accompanied Calderón at the piano on several of his hits. The song was later taken up by Los Ahijados, the duo of Cuco Valoy and Martín Valoy.

**Legacy**

Fabián died in Santo Domingo on 23 November 2000, at the age of 80. His work runs through three currents of Dominican popular music at mid-century — the concert merengue for piano, the bolero taken up by Cuba’s best-known sonora, and the song at the start of recorded bachata.' WHERE slug = 'bienvenido-fabian';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Bienvenido Fabián (San Pedro de Macorís, 20 de marzo de 1920 – Santo Domingo, 23 de noviembre de 2000) fue un compositor, pianista, cantante y locutor dominicano. En los años cincuenta sus canciones llegaron a Celia Cruz y a «La Sonora Matancera», en La Habana, y su «Condena», también titulada «Qué será de mí», es uno de los temas de la grabación que se cuenta como el comienzo de la discografía de la bachata."}]},{"type":"paragraph","content":[{"type":"text","text":"El merengue al piano","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Como intérprete se hizo un nombre en los años cincuenta con dos piezas para piano, «Merengue en concierto» y «Ritmo de merengue», grabaciones recordadas por su digitación sobre el teclado. También tocaba la guitarra, trabajó como locutor y dirigió un grupo propio, acreditado en los discos como «Bienvenido Fabián y su Combo» y «Bienvenido Fabián y su Conjunto», con el que grabó temas como «Chanflín»."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Sonora Matancera»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La agrupación cubana grabó su «Goza negra» con Celia Cruz como voz principal a mediados de los años cincuenta, y Cruz cantó también su «Tuya más que tuya», un bolero chachachá. Décadas después "},{"type":"artistReference","attrs":{"occurrenceId":"826fc887-4a25-4c1c-901a-2004de651b53","artistId":"d9ef5d29-573a-4812-b717-18a783d95a70","displayText":"Michel el Buenón"}},{"type":"text","text":" volvió a grabar la canción, como «Tuyo más que tuyo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Voces dominicanas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En el país, la cantante que más temas le grabó fue "},{"type":"artistReference","attrs":{"occurrenceId":"075fed7d-0702-4930-83af-2066efadde2a","artistId":"8da26ee1-8079-4232-b9a2-66eccee08cb3","displayText":"Elenita Santos"}},{"type":"text","text":": «Besarte», «Mi estrella», «Quién si no tú», «Al fin te fuiste». Un LP publicado a nombre de ella, «Piensa en mí», acredita a Fabián junto a «Ángel Bussi y su Conjunto». Su catálogo incluye además los boleros «Mi noche fatal», «Di que no», «Lo que te pido» y «De qué color son tus ojos», e "},{"type":"artistReference","attrs":{"occurrenceId":"371fdaaf-b0a8-4a21-9b80-aa1d873bae1e","artistId":"0daa71b6-6cca-471d-961f-e65f6caa2db1","displayText":"Isidoro Flores"}},{"type":"text","text":" y su conjunto recurrieron a sus composiciones para el álbum «La Sabrosona»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Condena»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cuando "},{"type":"artistReference","attrs":{"occurrenceId":"5c1aecba-76d6-4c6f-8a43-944ecb970829","artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón"}},{"type":"text","text":" entró al estudio para grabar los temas que hoy se cuentan como las primeras bachatas grabadas, una de las canciones fue «Condena», de Fabián, que circula también como «Qué será de mí»; en 2017 Calderón lo señaló como su autor. Según el locutor Alci de la Rosa, Fabián acompañó al piano a Calderón en varios de sus éxitos. La canción la retomaron después "},{"type":"artistReference","attrs":{"occurrenceId":"2a4c9631-6ee7-4f02-8c89-b53f68d7397f","artistId":"f6f95f0f-e008-47b9-8b4c-10fe5508bfd9","displayText":"Los Ahijados"}},{"type":"text","text":", el dúo de "},{"type":"artistReference","attrs":{"occurrenceId":"e969e3d1-b43b-47c5-8b3d-6e45ba3d2fd1","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"bc6ff4a6-2f08-4f0f-874a-a286c2a8435b","artistId":"6eccc3e7-82bf-435f-8ae1-ea7e8a721560","displayText":"Martín Valoy"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fabián murió en Santo Domingo el 23 de noviembre de 2000, a los 80 años. Su obra atraviesa tres corrientes de la música popular dominicana de mediados de siglo —el merengue de concierto para piano, el bolero que adoptó la sonora más conocida de Cuba y la canción con que empieza la bachata grabada."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bienvenido-fabian'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '826fc887-4a25-4c1c-901a-2004de651b53', 'artist', 'd9ef5d29-573a-4812-b717-18a783d95a70' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '075fed7d-0702-4930-83af-2066efadde2a', 'artist', '8da26ee1-8079-4232-b9a2-66eccee08cb3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '371fdaaf-b0a8-4a21-9b80-aa1d873bae1e', 'artist', '0daa71b6-6cca-471d-961f-e65f6caa2db1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5c1aecba-76d6-4c6f-8a43-944ecb970829', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2a4c9631-6ee7-4f02-8c89-b53f68d7397f', 'artist', 'f6f95f0f-e008-47b9-8b4c-10fe5508bfd9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e969e3d1-b43b-47c5-8b3d-6e45ba3d2fd1', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'bc6ff4a6-2f08-4f0f-874a-a286c2a8435b', 'artist', '6eccc3e7-82bf-435f-8ae1-ea7e8a721560' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-fabian' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Bienvenido Fabián (San Pedro de Macorís, 20 de marzo de 1920 – Santo Domingo, 23 de noviembre de 2000) fue un compositor, pianista, cantante y locutor dominicano. En los años cincuenta sus canciones llegaron a Celia Cruz y a «La Sonora Matancera», en La Habana, y su «Condena», también titulada «Qué será de mí», es uno de los temas de la grabación que se cuenta como el comienzo de la discografía de la bachata.

**El merengue al piano**

Como intérprete se hizo un nombre en los años cincuenta con dos piezas para piano, «Merengue en concierto» y «Ritmo de merengue», grabaciones recordadas por su digitación sobre el teclado. También tocaba la guitarra, trabajó como locutor y dirigió un grupo propio, acreditado en los discos como «Bienvenido Fabián y su Combo» y «Bienvenido Fabián y su Conjunto», con el que grabó temas como «Chanflín».

**«La Sonora Matancera»**

La agrupación cubana grabó su «Goza negra» con Celia Cruz como voz principal a mediados de los años cincuenta, y Cruz cantó también su «Tuya más que tuya», un bolero chachachá. Décadas después Michel el Buenón volvió a grabar la canción, como «Tuyo más que tuyo».

**Voces dominicanas**

En el país, la cantante que más temas le grabó fue Elenita Santos: «Besarte», «Mi estrella», «Quién si no tú», «Al fin te fuiste». Un LP publicado a nombre de ella, «Piensa en mí», acredita a Fabián junto a «Ángel Bussi y su Conjunto». Su catálogo incluye además los boleros «Mi noche fatal», «Di que no», «Lo que te pido» y «De qué color son tus ojos», e Isidoro Flores y su conjunto recurrieron a sus composiciones para el álbum «La Sabrosona».

**«Condena»**

Cuando José Manuel Calderón entró al estudio para grabar los temas que hoy se cuentan como las primeras bachatas grabadas, una de las canciones fue «Condena», de Fabián, que circula también como «Qué será de mí»; en 2017 Calderón lo señaló como su autor. Según el locutor Alci de la Rosa, Fabián acompañó al piano a Calderón en varios de sus éxitos. La canción la retomaron después Los Ahijados, el dúo de Cuco Valoy y Martín Valoy.

**Legado**

Fabián murió en Santo Domingo el 23 de noviembre de 2000, a los 80 años. Su obra atraviesa tres corrientes de la música popular dominicana de mediados de siglo —el merengue de concierto para piano, el bolero que adoptó la sonora más conocida de Cuba y la canción con que empieza la bachata grabada.' WHERE slug = 'bienvenido-fabian';

COMMIT;
