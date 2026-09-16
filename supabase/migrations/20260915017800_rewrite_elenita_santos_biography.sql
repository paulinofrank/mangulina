BEGIN;

-- Ficha de Elenita Santos.
--
-- La biografía de relleno hablaba en términos genéricos de "preservación del folclor" sin
-- nombrar una sola canción, colaborador o programa de televisión.
-- birth_place/province corregidos de Santo Domingo/Distrito Nacional a Moca/Espaillat
-- (Wikipedia y el begin-area de su propia ficha de MusicBrainz coinciden). primary_genre
-- corregido de folklore a folklore-salve (valor ya usado en este catálogo). genres
-- ampliado con bolero; occupations con producer y actress.

UPDATE artists SET birth_place = 'Moca', province = 'Espaillat', primary_genre = 'folklore-salve',
       genres = ARRAY['merengue','bolero']::text[], occupations = '["producer","actress"]'::jsonb
       WHERE slug = 'elenita-santos';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Gilem Nazir Cabalem, known as Elenita Santos, was born on 14 April 1933 in the rural village of Juan López, in Moca, Espaillat province, to Lebanese immigrant parents. Known as «La Reina de la Salve» and «El Rayito de Sol», she became a pioneer of Dominican television and, for generations, practically the exclusive interpreter of the folk-religious salve."}]},{"type":"paragraph","content":[{"type":"text","text":"From «La Voz Dominicana» to San Juan","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She took her first lessons in solfège and singing at the school run by the state station La Voz Dominicana, began performing at thirteen, made her debut at its Radio Teatro, and immediately recorded «Besarte», written by "},{"type":"artistReference","attrs":{"occurrenceId":"9438748b-3b43-4c79-89cd-384b2df7b756","artistId":"4b85d1eb-ebaa-42b5-9901-5e2805af9138","displayText":"Bienvenido Fabián"}},{"type":"text","text":". At seventeen she was hired to sing at the Caribe Hilton in San Juan, Puerto Rico, and later performed in New York alongside the Chilean singer Lucho Gatica."}]},{"type":"paragraph","content":[{"type":"text","text":"A pioneer of Dominican television","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"From 1952 she worked extensively in Dominican television, sharing stages with artists such as "},{"type":"artistReference","attrs":{"occurrenceId":"9d412aad-0ed6-43cf-beb8-5b9a3b42381b","artistId":"2d8316d2-1e25-4b42-a44e-873ec1711672","displayText":"Guarionex Aquino Reyes"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"42cc8b4d-2d0d-4817-a9cb-1bd1debd574a","artistId":"1410b448-6357-4895-a32a-58708697e10d","displayText":"Alberto Beltrán"}},{"type":"text","text":", Tirso Guerrero, Lucía Félix and Milagros Lanti, and producing her own programs, among them «El Especial de Elenita Santos» and «Elenita en Escena»."}]},{"type":"paragraph","content":[{"type":"text","text":"The Queen of the Salve","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"What defined her as a singer was her interpretation of salve; for generations she was practically its only recording artist, immortalizing songs by "},{"type":"artistReference","attrs":{"occurrenceId":"f952fd85-7694-4cd7-8fd0-273c579a0e88","artistId":"0daa71b6-6cca-471d-961f-e65f6caa2db1","displayText":"Isidoro Flores"}},{"type":"text","text":" and by "},{"type":"artistReference","attrs":{"occurrenceId":"5523162f-fa17-43b3-ae64-b70813ae323c","artistId":"19e6c6f8-bdd7-4137-953f-0657b8617259","displayText":"Bienvenido Brens"}},{"type":"text","text":", whose «Pensando», «Peregrina Sin Amor», «Al Retorno» and «Mar de Insomnio» she recorded among many others. Over eighteen LPs — salves, merengues and boleros — she also interpreted "},{"type":"artistReference","attrs":{"occurrenceId":"2123ee1f-f96c-42ad-9284-ad0a3b13aab5","artistId":"dab6636c-21fd-4e34-a0a2-e59e9e147bbd","displayText":"Luis Kalaff"}},{"type":"text","text":" and composers Papa Molina, Héctor Cabral Ortega, Rafael Colón and Armando Cabrera."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Elenita Santos retired after roughly fifty years in Dominican popular culture, remembered as one of the country’s first television stars and as the voice most identified with salve’s survival as a living, recorded tradition rather than a purely oral one."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'elenita-santos'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'elenita-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9438748b-3b43-4c79-89cd-384b2df7b756', 'artist', '4b85d1eb-ebaa-42b5-9901-5e2805af9138' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'elenita-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9d412aad-0ed6-43cf-beb8-5b9a3b42381b', 'artist', '2d8316d2-1e25-4b42-a44e-873ec1711672' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'elenita-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '42cc8b4d-2d0d-4817-a9cb-1bd1debd574a', 'artist', '1410b448-6357-4895-a32a-58708697e10d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'elenita-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f952fd85-7694-4cd7-8fd0-273c579a0e88', 'artist', '0daa71b6-6cca-471d-961f-e65f6caa2db1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'elenita-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5523162f-fa17-43b3-ae64-b70813ae323c', 'artist', '19e6c6f8-bdd7-4137-953f-0657b8617259' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'elenita-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2123ee1f-f96c-42ad-9284-ad0a3b13aab5', 'artist', 'dab6636c-21fd-4e34-a0a2-e59e9e147bbd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'elenita-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Gilem Nazir Cabalem, known as Elenita Santos, was born on 14 April 1933 in the rural village of Juan López, in Moca, Espaillat province, to Lebanese immigrant parents. Known as «La Reina de la Salve» and «El Rayito de Sol», she became a pioneer of Dominican television and, for generations, practically the exclusive interpreter of the folk-religious salve.

**From «La Voz Dominicana» to San Juan**

She took her first lessons in solfège and singing at the school run by the state station La Voz Dominicana, began performing at thirteen, made her debut at its Radio Teatro, and immediately recorded «Besarte», written by Bienvenido Fabián. At seventeen she was hired to sing at the Caribe Hilton in San Juan, Puerto Rico, and later performed in New York alongside the Chilean singer Lucho Gatica.

**A pioneer of Dominican television**

From 1952 she worked extensively in Dominican television, sharing stages with artists such as Guarionex Aquino Reyes, Alberto Beltrán, Tirso Guerrero, Lucía Félix and Milagros Lanti, and producing her own programs, among them «El Especial de Elenita Santos» and «Elenita en Escena».

**The Queen of the Salve**

What defined her as a singer was her interpretation of salve; for generations she was practically its only recording artist, immortalizing songs by Isidoro Flores and by Bienvenido Brens, whose «Pensando», «Peregrina Sin Amor», «Al Retorno» and «Mar de Insomnio» she recorded among many others. Over eighteen LPs — salves, merengues and boleros — she also interpreted Luis Kalaff and composers Papa Molina, Héctor Cabral Ortega, Rafael Colón and Armando Cabrera.

**Legacy**

Elenita Santos retired after roughly fifty years in Dominican popular culture, remembered as one of the country’s first television stars and as the voice most identified with salve’s survival as a living, recorded tradition rather than a purely oral one.' WHERE slug = 'elenita-santos';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Gilem Nazir Cabalem, conocida como Elenita Santos, nació el 14 de abril de 1933 en el poblado rural de Juan López, en Moca, provincia Espaillat, hija de inmigrantes libaneses. Conocida como «La Reina de la Salve» y «El Rayito de Sol», se convirtió en pionera de la televisión dominicana y, durante generaciones, en prácticamente la intérprete exclusiva de la salve folclórico-religiosa."}]},{"type":"paragraph","content":[{"type":"text","text":"De «La Voz Dominicana» a San Juan","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Recibió sus primeras nociones de solfeo y canto en la escuela de la emisora estatal La Voz Dominicana, comenzó a cantar a los trece años, debutó en su Radio Teatro, y grabó de inmediato «Besarte», de la autoría de "},{"type":"artistReference","attrs":{"occurrenceId":"ffedfb3f-6de8-4698-aca1-75e779258c81","artistId":"4b85d1eb-ebaa-42b5-9901-5e2805af9138","displayText":"Bienvenido Fabián"}},{"type":"text","text":". A los diecisiete fue contratada como cantante en el Caribe Hilton de San Juan, Puerto Rico, y más tarde se presentó en Nueva York junto al chileno Lucho Gatica."}]},{"type":"paragraph","content":[{"type":"text","text":"Pionera de la televisión dominicana","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A partir de 1952 trabajó intensamente en la televisión dominicana, compartiendo tarima con artistas como "},{"type":"artistReference","attrs":{"occurrenceId":"b97153bf-0e49-417f-9f90-8ee4cbfc9f94","artistId":"2d8316d2-1e25-4b42-a44e-873ec1711672","displayText":"Guarionex Aquino Reyes"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"d1aee751-b517-41e6-a6b8-1c14ae005abe","artistId":"1410b448-6357-4895-a32a-58708697e10d","displayText":"Alberto Beltrán"}},{"type":"text","text":", Tirso Guerrero, Lucía Félix y Milagros Lanti, y produciendo sus propios programas, entre ellos «El Especial de Elenita Santos» y «Elenita en Escena»."}]},{"type":"paragraph","content":[{"type":"text","text":"La Reina de la Salve","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Lo que la definió como cantante fue su interpretación de la salve; durante generaciones fue prácticamente su única intérprete grabada, inmortalizando canciones de "},{"type":"artistReference","attrs":{"occurrenceId":"29dc706c-1690-413b-b8d2-5beeb37317d2","artistId":"0daa71b6-6cca-471d-961f-e65f6caa2db1","displayText":"Isidoro Flores"}},{"type":"text","text":" y de "},{"type":"artistReference","attrs":{"occurrenceId":"70ed74ee-651a-4027-88f2-c638a96ba6e0","artistId":"19e6c6f8-bdd7-4137-953f-0657b8617259","displayText":"Bienvenido Brens"}},{"type":"text","text":", de quien grabó «Pensando», «Peregrina Sin Amor», «Al Retorno» y «Mar de Insomnio», entre muchas otras. En dieciocho discos de larga duración —salves, merengues y boleros— también interpretó a "},{"type":"artistReference","attrs":{"occurrenceId":"2b88035e-5133-4d84-bf50-2937d72752b7","artistId":"dab6636c-21fd-4e34-a0a2-e59e9e147bbd","displayText":"Luis Kalaff"}},{"type":"text","text":" y a los compositores Papa Molina, Héctor Cabral Ortega, Rafael Colón y Armando Cabrera."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Elenita Santos se retiró tras unos cincuenta años en la cultura popular dominicana, recordada como una de las primeras estrellas de la televisión del país y como la voz más identificada con la supervivencia de la salve como tradición viva y grabada, y no solo oral."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'elenita-santos'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'elenita-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ffedfb3f-6de8-4698-aca1-75e779258c81', 'artist', '4b85d1eb-ebaa-42b5-9901-5e2805af9138' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'elenita-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b97153bf-0e49-417f-9f90-8ee4cbfc9f94', 'artist', '2d8316d2-1e25-4b42-a44e-873ec1711672' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'elenita-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd1aee751-b517-41e6-a6b8-1c14ae005abe', 'artist', '1410b448-6357-4895-a32a-58708697e10d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'elenita-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '29dc706c-1690-413b-b8d2-5beeb37317d2', 'artist', '0daa71b6-6cca-471d-961f-e65f6caa2db1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'elenita-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '70ed74ee-651a-4027-88f2-c638a96ba6e0', 'artist', '19e6c6f8-bdd7-4137-953f-0657b8617259' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'elenita-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2b88035e-5133-4d84-bf50-2937d72752b7', 'artist', 'dab6636c-21fd-4e34-a0a2-e59e9e147bbd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'elenita-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Gilem Nazir Cabalem, conocida como Elenita Santos, nació el 14 de abril de 1933 en el poblado rural de Juan López, en Moca, provincia Espaillat, hija de inmigrantes libaneses. Conocida como «La Reina de la Salve» y «El Rayito de Sol», se convirtió en pionera de la televisión dominicana y, durante generaciones, en prácticamente la intérprete exclusiva de la salve folclórico-religiosa.

**De «La Voz Dominicana» a San Juan**

Recibió sus primeras nociones de solfeo y canto en la escuela de la emisora estatal La Voz Dominicana, comenzó a cantar a los trece años, debutó en su Radio Teatro, y grabó de inmediato «Besarte», de la autoría de Bienvenido Fabián. A los diecisiete fue contratada como cantante en el Caribe Hilton de San Juan, Puerto Rico, y más tarde se presentó en Nueva York junto al chileno Lucho Gatica.

**Pionera de la televisión dominicana**

A partir de 1952 trabajó intensamente en la televisión dominicana, compartiendo tarima con artistas como Guarionex Aquino Reyes, Alberto Beltrán, Tirso Guerrero, Lucía Félix y Milagros Lanti, y produciendo sus propios programas, entre ellos «El Especial de Elenita Santos» y «Elenita en Escena».

**La Reina de la Salve**

Lo que la definió como cantante fue su interpretación de la salve; durante generaciones fue prácticamente su única intérprete grabada, inmortalizando canciones de Isidoro Flores y de Bienvenido Brens, de quien grabó «Pensando», «Peregrina Sin Amor», «Al Retorno» y «Mar de Insomnio», entre muchas otras. En dieciocho discos de larga duración —salves, merengues y boleros— también interpretó a Luis Kalaff y a los compositores Papa Molina, Héctor Cabral Ortega, Rafael Colón y Armando Cabrera.

**Legado**

Elenita Santos se retiró tras unos cincuenta años en la cultura popular dominicana, recordada como una de las primeras estrellas de la televisión del país y como la voz más identificada con la supervivencia de la salve como tradición viva y grabada, y no solo oral.' WHERE slug = 'elenita-santos';

COMMIT;
