BEGIN;

-- Ficha de Ángel Dior.
--
-- La biografía de relleno no daba un solo hecho verificable. Año de nacimiento: la fila
-- decía 2002; corregido a 2003 (Wikipedia, Diario Libre, Apple Music, Shazam, Rolling
-- Stone en Español). No se registra ningún premio: Wikipedia le atribuye un triunfo en los
-- Premios Heat 2023 que la lista oficial de Billboard contradice (ganó El Alfa).

UPDATE artists SET birth_year = 2003 WHERE slug = 'angel-dior';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Ángel Dior — Ángel Rosario, born in 2003 in the Villa María neighbourhood of Santo Domingo — is a Dominican dembow artist known as El Rey de la 42, who went from selling chocolates door to door to a viral career and a courtroom win against a French luxury conglomerate inside two years."}]},{"type":"paragraph","content":[{"type":"text","text":"«AIO»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Before music, Rosario sold chocolates around his neighbourhood. His debut single, «AIO» (September 2022), passed 40 million views on YouTube, and Rosalía and Cardi B both worked it into their own performances — Rosalía during a Louis Vuitton show at Paris Fashion Week, Cardi B at an MTV appearance. That same year he sang it live with Bad Bunny at the Estadio Olímpico Félix Sánchez, the performance that put his name in front of a national audience for the first time. «Piropi», released that October, passed 38 million views of its own."}]},{"type":"paragraph","content":[{"type":"text","text":"A run of features","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2023 he appeared on «Ojos Ferrari», from Karol G’s «Mañana Será Bonito», alongside Justin Quiles, and recorded «Tamo en nota» with Rauw Alejandro and «Wapae» with 6ix9ine, Lenier and "},{"type":"artistReference","attrs":{"occurrenceId":"a06cc042-42ce-4c18-9939-931fa7e8323f","artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47"}},{"type":"text","text":". A single with "},{"type":"artistReference","attrs":{"occurrenceId":"7b5ca22b-c321-42fd-8be1-98da1f824022","artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala"}},{"type":"text","text":", «Súbete a mi moto», and an appearance on "},{"type":"artistReference","attrs":{"occurrenceId":"98519aa8-0f1a-494b-929b-9eab2095328b","artistId":"1b072bb2-eeac-41da-956e-cd5bb576a901","displayText":"La Baby"}},{"type":"text","text":"’s planned EP «Niña Traviesa» followed."}]},{"type":"paragraph","content":[{"type":"text","text":"Fighting for the name","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In September 2022, as «Ángel Dior» began to spread, Parfums Christian Dior — a house owned by the luxury conglomerate LVMH — filed a formal opposition in the Dominican Republic against his registering the name as a trademark. The case ran nearly two years; on 5 April 2024, Dominican authorities rejected LVMH’s opposition and let Rosario keep the name he had built his career on."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"By the end of 2023 Rosario had picked up nominations at the Premios Heat, the Premios Juventud, the Premios Soberano and the Premios Tú Música Urbano, without yet converting any of them into a win — a run of recognition that, together with the Dior ruling, marked how far a chocolate seller from Villa María had travelled in barely two years."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'angel-dior'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'angel-dior' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a06cc042-42ce-4c18-9939-931fa7e8323f', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'angel-dior' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7b5ca22b-c321-42fd-8be1-98da1f824022', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'angel-dior' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '98519aa8-0f1a-494b-929b-9eab2095328b', 'artist', '1b072bb2-eeac-41da-956e-cd5bb576a901' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'angel-dior' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Ángel Dior — Ángel Rosario, born in 2003 in the Villa María neighbourhood of Santo Domingo — is a Dominican dembow artist known as El Rey de la 42, who went from selling chocolates door to door to a viral career and a courtroom win against a French luxury conglomerate inside two years.

**«AIO»**

Before music, Rosario sold chocolates around his neighbourhood. His debut single, «AIO» (September 2022), passed 40 million views on YouTube, and Rosalía and Cardi B both worked it into their own performances — Rosalía during a Louis Vuitton show at Paris Fashion Week, Cardi B at an MTV appearance. That same year he sang it live with Bad Bunny at the Estadio Olímpico Félix Sánchez, the performance that put his name in front of a national audience for the first time. «Piropi», released that October, passed 38 million views of its own.

**A run of features**

In 2023 he appeared on «Ojos Ferrari», from Karol G’s «Mañana Será Bonito», alongside Justin Quiles, and recorded «Tamo en nota» with Rauw Alejandro and «Wapae» with 6ix9ine, Lenier and Bulin 47. A single with Chimbala, «Súbete a mi moto», and an appearance on La Baby’s planned EP «Niña Traviesa» followed.

**Fighting for the name**

In September 2022, as «Ángel Dior» began to spread, Parfums Christian Dior — a house owned by the luxury conglomerate LVMH — filed a formal opposition in the Dominican Republic against his registering the name as a trademark. The case ran nearly two years; on 5 April 2024, Dominican authorities rejected LVMH’s opposition and let Rosario keep the name he had built his career on.

**Legacy**

By the end of 2023 Rosario had picked up nominations at the Premios Heat, the Premios Juventud, the Premios Soberano and the Premios Tú Música Urbano, without yet converting any of them into a win — a run of recognition that, together with the Dior ruling, marked how far a chocolate seller from Villa María had travelled in barely two years.' WHERE slug = 'angel-dior';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Ángel Dior —Ángel Rosario, nacido en 2003 en el sector Villa María, Santo Domingo— es un artista de dembow dominicano conocido como El Rey de la 42, que pasó de vender chocolates de puerta en puerta a una carrera viral y a ganarle un litigio a un conglomerado francés de lujo en apenas dos años."}]},{"type":"paragraph","content":[{"type":"text","text":"«AIO»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Antes de la música, Rosario vendía chocolates por su barrio. Su sencillo debut, «AIO» (septiembre de 2022), pasó los 40 millones de reproducciones en YouTube, y tanto Rosalía como Cardi B lo metieron en sus propias presentaciones —Rosalía en un desfile de Louis Vuitton en la Semana de la Moda de París, Cardi B en una aparición en los MTV—. Ese mismo año la cantó en vivo con Bad Bunny en el Estadio Olímpico Félix Sánchez, la presentación que puso su nombre por primera vez frente a un público nacional. «Piropi», lanzada ese octubre, pasó también los 38 millones de reproducciones."}]},{"type":"paragraph","content":[{"type":"text","text":"Una racha de colaboraciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2023 apareció en «Ojos Ferrari», de «Mañana Será Bonito», de Karol G, junto a Justin Quiles, y grabó «Tamo en nota» con Rauw Alejandro y «Wapae» con 6ix9ine, Lenier y "},{"type":"artistReference","attrs":{"occurrenceId":"13fb0e89-bd65-4260-93fb-0c59757f61cc","artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47"}},{"type":"text","text":". Le siguieron un sencillo con "},{"type":"artistReference","attrs":{"occurrenceId":"e90ea223-deaf-485a-8aa7-7bd0fe8cd3ad","artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala"}},{"type":"text","text":", «Súbete a mi moto», y una participación en el EP que prepara "},{"type":"artistReference","attrs":{"occurrenceId":"2306e2bd-83ee-4cad-b74b-d7fd9f1e0290","artistId":"1b072bb2-eeac-41da-956e-cd5bb576a901","displayText":"La Baby"}},{"type":"text","text":", «Niña Traviesa»."}]},{"type":"paragraph","content":[{"type":"text","text":"La pelea por el nombre","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En septiembre de 2022, cuando «Ángel Dior» empezaba a sonar, Parfums Christian Dior —una casa del conglomerado de lujo LVMH— presentó en República Dominicana una oposición formal al registro de ese nombre como marca. El proceso duró casi dos años; el 5 de abril de 2024 las autoridades dominicanas rechazaron la oposición de LVMH y dejaron a Rosario quedarse con el nombre sobre el que había construido su carrera."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Para fines de 2023 Rosario había sumado nominaciones en los Premios Heat, los Premios Juventud, los Premios Soberano y los Premios Tú Música Urbano, sin convertir todavía ninguna en triunfo —un reconocimiento que, junto con el fallo frente a Dior, marca lo lejos que había llegado en apenas dos años un vendedor de chocolates de Villa María."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'angel-dior'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'angel-dior' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '13fb0e89-bd65-4260-93fb-0c59757f61cc', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'angel-dior' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e90ea223-deaf-485a-8aa7-7bd0fe8cd3ad', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'angel-dior' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2306e2bd-83ee-4cad-b74b-d7fd9f1e0290', 'artist', '1b072bb2-eeac-41da-956e-cd5bb576a901' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'angel-dior' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Ángel Dior —Ángel Rosario, nacido en 2003 en el sector Villa María, Santo Domingo— es un artista de dembow dominicano conocido como El Rey de la 42, que pasó de vender chocolates de puerta en puerta a una carrera viral y a ganarle un litigio a un conglomerado francés de lujo en apenas dos años.

**«AIO»**

Antes de la música, Rosario vendía chocolates por su barrio. Su sencillo debut, «AIO» (septiembre de 2022), pasó los 40 millones de reproducciones en YouTube, y tanto Rosalía como Cardi B lo metieron en sus propias presentaciones —Rosalía en un desfile de Louis Vuitton en la Semana de la Moda de París, Cardi B en una aparición en los MTV—. Ese mismo año la cantó en vivo con Bad Bunny en el Estadio Olímpico Félix Sánchez, la presentación que puso su nombre por primera vez frente a un público nacional. «Piropi», lanzada ese octubre, pasó también los 38 millones de reproducciones.

**Una racha de colaboraciones**

En 2023 apareció en «Ojos Ferrari», de «Mañana Será Bonito», de Karol G, junto a Justin Quiles, y grabó «Tamo en nota» con Rauw Alejandro y «Wapae» con 6ix9ine, Lenier y Bulin 47. Le siguieron un sencillo con Chimbala, «Súbete a mi moto», y una participación en el EP que prepara La Baby, «Niña Traviesa».

**La pelea por el nombre**

En septiembre de 2022, cuando «Ángel Dior» empezaba a sonar, Parfums Christian Dior —una casa del conglomerado de lujo LVMH— presentó en República Dominicana una oposición formal al registro de ese nombre como marca. El proceso duró casi dos años; el 5 de abril de 2024 las autoridades dominicanas rechazaron la oposición de LVMH y dejaron a Rosario quedarse con el nombre sobre el que había construido su carrera.

**Legado**

Para fines de 2023 Rosario había sumado nominaciones en los Premios Heat, los Premios Juventud, los Premios Soberano y los Premios Tú Música Urbano, sin convertir todavía ninguna en triunfo —un reconocimiento que, junto con el fallo frente a Dior, marca lo lejos que había llegado en apenas dos años un vendedor de chocolates de Villa María.' WHERE slug = 'angel-dior';

COMMIT;
