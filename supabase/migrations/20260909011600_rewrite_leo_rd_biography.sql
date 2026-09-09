BEGIN;

-- Ficha de Leo RD.
--
-- El relleno lo describía como cantante de dembow. Es productor, que es lo
-- que ya decía primary_role y lo que dicen sus tres cuentas (Produciendo).
--
-- Corrección de nombre legal, con tres fuentes independientes que escriben
-- "Leonardo Felipe Yasmil Garcés": la página de Roc Nation, su sello; una
-- nota de Noticias País del 2 de marzo de 2025; y MusicBrainz, que lo trae
-- tipado como Legal name bajo el mbid que la propia fila guarda. La fila
-- decía Castillo.
--
-- "Yasmil" queda en middle_name y no en second_last_name: las tres fuentes
-- escriben el nombre como una sola cadena sin desglosar, y no hay con qué
-- decidir si es tercer nombre de pila o primer apellido.
--
-- La fecha de nacimiento sale solo de Roc Nation; MusicBrainz no la tiene.

-- 1. Nombre legal, nacimiento y barrio
UPDATE artists
   SET last_name     = 'Garcés',
       middle_name   = 'Felipe Yasmil',
       date_of_birth = '1985-03-28',
       birth_year    = 1985,
       birth_place   = 'Los Guandules, Santo Domingo'
 WHERE slug = 'leo-rd';

-- 2. Documentos editoriales, referencias y espejo markdown legacy
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Leo RD is a Dominican record producer and one of the central figures in dembow. Born Leonardo Felipe Yasmil Garcés in Los Guandules, Santo Domingo, on 28 March 1985, he built his first studio in a bathroom and has since produced a large share of the genre’s hits, among them \"Linda\", the 2021 record by "},{"type":"artistReference","attrs":{"occurrenceId":"915bda3e-89cf-4a35-8437-23bcfa8c4ea8","artistId":"3e1718be-c12d-42f5-85e7-2156d9574940","displayText":"Tokischa"}},{"type":"text","text":" and Rosalía. He is signed to Roc Nation and still keeps his studio in the neighbourhood where he grew up."}]},{"type":"paragraph","content":[{"type":"text","text":"Los Guandules","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Garcés came to music at nineteen. His first recording room was a bathroom in Los Guandules, soundproofed with egg cartons. For years he worked as an orderly at a gynaecology and obstetrics clinic and recorded around the shift — out of the studio at six in the morning, at the clinic by eight. He charged five hundred or a thousand pesos a session, and often nothing at all, because the artists he was recording had no money either. His first hit was \"991\", with J Fran; it took over the street and earned nothing."}]},{"type":"paragraph","content":[{"type":"text","text":"The room in the neighbourhood","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The turn came when the records began to hold. \"Dejen su loquera\", \"La gallina\", \"Curuleca\" and \"La pámpara\" kept him on the street continuously, and when he counted more than ten songs charting at once he left the clinic. Most of dembow’s names passed through the Los Guandules room on the way up, among them "},{"type":"artistReference","attrs":{"occurrenceId":"c424c90c-6e84-4f63-a160-008c6597c12f","artistId":"71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb","displayText":"Rochy RD"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"93332a16-fb12-41af-916c-06146634ccdb","artistId":"518354a4-7cb9-4c39-a2b8-9fa4d18f50db","displayText":"El Mayor Clásico"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"fbae6ff8-68ad-4a71-a11e-db32d3847ac9","artistId":"9be0ed08-6eb6-4ca0-bb68-d5126190aeb1","displayText":"Kiko el Crazy"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"92ce1c72-6811-4915-92d5-3b2f6819ec70","artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"f003cb21-1b24-4652-98d3-5183b3ea668e","artistId":"bb07dcb8-444f-4a68-a668-21e9e038f335","displayText":"Yomel el Meloso"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"28bff8e0-ec6d-4d58-ab49-6d67f7d8c738","artistId":"0b2e1a39-b265-42d6-95d5-85ad930eee84","displayText":"El Cherry Scom"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"76cd0a96-df91-4f2e-a437-9ff7a35fce62","artistId":"2993cde1-f93d-4cf0-9668-fa1e54b09919","displayText":"Haraca Kiko"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"e6dfceae-929f-4fc0-b967-cefbe0224b8f","artistId":"95e181f1-58e5-4537-a5e8-75a9f60c6aca","displayText":"Tivi Gunz"}},{"type":"text","text":". He has kept the studio there rather than move it."}]},{"type":"paragraph","content":[{"type":"text","text":"Linda","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In October 2020 he produced \"Desacato Escolar\" for Tokischa and Yomel el Meloso; YouTube pulled it over the lyrics, which sent people looking for it. The following year he produced \"Linda\", Tokischa’s record with Rosalía, shot in Santo Domingo and performed at the Billboard Latin Music Awards that September. He has since worked with J Balvin, Ozuna, Anuel AA, Myke Towers, De La Ghetto and Jowell y Randy, and his credits include \"Corre Corre\", \"Alta Gama\", \"Pikilao\", \"La Cuarentena\", \"Rumba\" and \"La Máxima\"."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Leo RD is among the producers who gave dembow the sound it now exports. He works by preference with new artists, which is why a large part of the genre’s roster made its first recordings in a room in Los Guandules rather than in a commercial studio."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'leo-rd'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'leo-rd' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '915bda3e-89cf-4a35-8437-23bcfa8c4ea8', 'artist', '3e1718be-c12d-42f5-85e7-2156d9574940'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c424c90c-6e84-4f63-a160-008c6597c12f', 'artist', '71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '93332a16-fb12-41af-916c-06146634ccdb', 'artist', '518354a4-7cb9-4c39-a2b8-9fa4d18f50db'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'fbae6ff8-68ad-4a71-a11e-db32d3847ac9', 'artist', '9be0ed08-6eb6-4ca0-bb68-d5126190aeb1'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '92ce1c72-6811-4915-92d5-3b2f6819ec70', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f003cb21-1b24-4652-98d3-5183b3ea668e', 'artist', 'bb07dcb8-444f-4a68-a668-21e9e038f335'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '28bff8e0-ec6d-4d58-ab49-6d67f7d8c738', 'artist', '0b2e1a39-b265-42d6-95d5-85ad930eee84'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '76cd0a96-df91-4f2e-a437-9ff7a35fce62', 'artist', '2993cde1-f93d-4cf0-9668-fa1e54b09919'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e6dfceae-929f-4fc0-b967-cefbe0224b8f', 'artist', '95e181f1-58e5-4537-a5e8-75a9f60c6aca'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Leo RD is a Dominican record producer and one of the central figures in dembow. Born Leonardo Felipe Yasmil Garcés in Los Guandules, Santo Domingo, on 28 March 1985, he built his first studio in a bathroom and has since produced a large share of the genre’s hits, among them "Linda", the 2021 record by Tokischa and Rosalía. He is signed to Roc Nation and still keeps his studio in the neighbourhood where he grew up.

**Los Guandules**

Garcés came to music at nineteen. His first recording room was a bathroom in Los Guandules, soundproofed with egg cartons. For years he worked as an orderly at a gynaecology and obstetrics clinic and recorded around the shift — out of the studio at six in the morning, at the clinic by eight. He charged five hundred or a thousand pesos a session, and often nothing at all, because the artists he was recording had no money either. His first hit was "991", with J Fran; it took over the street and earned nothing.

**The room in the neighbourhood**

The turn came when the records began to hold. "Dejen su loquera", "La gallina", "Curuleca" and "La pámpara" kept him on the street continuously, and when he counted more than ten songs charting at once he left the clinic. Most of dembow’s names passed through the Los Guandules room on the way up, among them Rochy RD, El Mayor Clásico, Kiko el Crazy, Chimbala, Yomel el Meloso, El Cherry Scom, Haraca Kiko and Tivi Gunz. He has kept the studio there rather than move it.

**Linda**

In October 2020 he produced "Desacato Escolar" for Tokischa and Yomel el Meloso; YouTube pulled it over the lyrics, which sent people looking for it. The following year he produced "Linda", Tokischa’s record with Rosalía, shot in Santo Domingo and performed at the Billboard Latin Music Awards that September. He has since worked with J Balvin, Ozuna, Anuel AA, Myke Towers, De La Ghetto and Jowell y Randy, and his credits include "Corre Corre", "Alta Gama", "Pikilao", "La Cuarentena", "Rumba" and "La Máxima".

**Legacy**

Leo RD is among the producers who gave dembow the sound it now exports. He works by preference with new artists, which is why a large part of the genre’s roster made its first recordings in a room in Los Guandules rather than in a commercial studio.' WHERE slug = 'leo-rd';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Leo RD es productor discográfico dominicano y una de las figuras centrales del dembow. Nació como Leonardo Felipe Yasmil Garcés en Los Guandules, Santo Domingo, el 28 de marzo de 1985, montó su primer estudio en un baño y desde entonces ha producido buena parte de los éxitos del género, entre ellos «Linda», el tema de 2021 de "},{"type":"artistReference","attrs":{"occurrenceId":"2cdccc07-8ce6-4e68-8798-1e6664843fe1","artistId":"3e1718be-c12d-42f5-85e7-2156d9574940","displayText":"Tokischa"}},{"type":"text","text":" con Rosalía. Está firmado con Roc Nation y mantiene su estudio en el barrio donde se crió."}]},{"type":"paragraph","content":[{"type":"text","text":"Los Guandules","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Garcés llegó a la música a los diecinueve años. Su primera sala de grabación fue un baño en Los Guandules, aislado con cartones de huevos. Durante años trabajó de camillero en una clínica de ginecología y obstetricia y grababa alrededor del turno: salía del estudio a las seis de la mañana y a las ocho estaba en la clínica. Cobraba quinientos o mil pesos por grabación, y muchas veces nada, porque los artistas que grababa tampoco tenían. Su primer éxito fue «991», con J Fran; se apoderó de la calle y no dejó dinero."}]},{"type":"paragraph","content":[{"type":"text","text":"El cuarto del barrio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El giro llegó cuando los temas empezaron a sostenerse. «Dejen su loquera», «La gallina», «Curuleca» y «La pámpara» lo mantuvieron sonando sin pausa, y cuando contó más de diez canciones pegadas a la vez dejó la clínica. Por el cuarto de Los Guandules pasó de subida casi toda la nómina del dembow, entre ellos "},{"type":"artistReference","attrs":{"occurrenceId":"3757e66b-02af-48ca-8a16-4f63297e922f","artistId":"71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb","displayText":"Rochy RD"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"ea35a7b3-7e02-44f1-a822-eb2aeb5b3fea","artistId":"518354a4-7cb9-4c39-a2b8-9fa4d18f50db","displayText":"El Mayor Clásico"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"157bfff9-7dc6-429f-843a-b5b6bda49952","artistId":"9be0ed08-6eb6-4ca0-bb68-d5126190aeb1","displayText":"Kiko el Crazy"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"80843624-0f3a-4084-8de4-be7c037ee558","artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"28876779-cea4-4a5c-a9cf-c75259bdc260","artistId":"bb07dcb8-444f-4a68-a668-21e9e038f335","displayText":"Yomel el Meloso"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"a1f84043-c6bd-45ee-b641-665706b8e9e3","artistId":"0b2e1a39-b265-42d6-95d5-85ad930eee84","displayText":"El Cherry Scom"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"31d04aaf-9c1e-41d5-8c12-801e7c8a50ec","artistId":"2993cde1-f93d-4cf0-9668-fa1e54b09919","displayText":"Haraca Kiko"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"92517097-31ba-451e-b49e-87d8c769abb8","artistId":"95e181f1-58e5-4537-a5e8-75a9f60c6aca","displayText":"Tivi Gunz"}},{"type":"text","text":". El estudio sigue ahí; no lo movió."}]},{"type":"paragraph","content":[{"type":"text","text":"Linda","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En octubre de 2020 produjo «Desacato Escolar», de Tokischa con Yomel el Meloso; YouTube la retiró por la letra, y el retiro mandó a la gente a buscarla. Al año siguiente produjo «Linda», el tema de Tokischa con Rosalía, rodado en Santo Domingo e interpretado en los Premios Billboard de la Música Latina ese septiembre. Desde entonces ha trabajado con J Balvin, Ozuna, Anuel AA, Myke Towers, De La Ghetto y Jowell y Randy, y entre sus créditos están «Corre Corre», «Alta Gama», «Pikilao», «La Cuarentena», «Rumba» y «La Máxima»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Leo RD está entre los productores que le dieron al dembow el sonido que hoy exporta. Trabaja por preferencia con artistas nuevos, y de ahí que buena parte de la nómina del género tenga sus primeras grabaciones en un cuarto de Los Guandules y no en un estudio comercial."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'leo-rd'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'leo-rd' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2cdccc07-8ce6-4e68-8798-1e6664843fe1', 'artist', '3e1718be-c12d-42f5-85e7-2156d9574940'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3757e66b-02af-48ca-8a16-4f63297e922f', 'artist', '71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ea35a7b3-7e02-44f1-a822-eb2aeb5b3fea', 'artist', '518354a4-7cb9-4c39-a2b8-9fa4d18f50db'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '157bfff9-7dc6-429f-843a-b5b6bda49952', 'artist', '9be0ed08-6eb6-4ca0-bb68-d5126190aeb1'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '80843624-0f3a-4084-8de4-be7c037ee558', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '28876779-cea4-4a5c-a9cf-c75259bdc260', 'artist', 'bb07dcb8-444f-4a68-a668-21e9e038f335'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a1f84043-c6bd-45ee-b641-665706b8e9e3', 'artist', '0b2e1a39-b265-42d6-95d5-85ad930eee84'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '31d04aaf-9c1e-41d5-8c12-801e7c8a50ec', 'artist', '2993cde1-f93d-4cf0-9668-fa1e54b09919'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '92517097-31ba-451e-b49e-87d8c769abb8', 'artist', '95e181f1-58e5-4537-a5e8-75a9f60c6aca'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leo-rd' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Leo RD es productor discográfico dominicano y una de las figuras centrales del dembow. Nació como Leonardo Felipe Yasmil Garcés en Los Guandules, Santo Domingo, el 28 de marzo de 1985, montó su primer estudio en un baño y desde entonces ha producido buena parte de los éxitos del género, entre ellos «Linda», el tema de 2021 de Tokischa con Rosalía. Está firmado con Roc Nation y mantiene su estudio en el barrio donde se crió.

**Los Guandules**

Garcés llegó a la música a los diecinueve años. Su primera sala de grabación fue un baño en Los Guandules, aislado con cartones de huevos. Durante años trabajó de camillero en una clínica de ginecología y obstetricia y grababa alrededor del turno: salía del estudio a las seis de la mañana y a las ocho estaba en la clínica. Cobraba quinientos o mil pesos por grabación, y muchas veces nada, porque los artistas que grababa tampoco tenían. Su primer éxito fue «991», con J Fran; se apoderó de la calle y no dejó dinero.

**El cuarto del barrio**

El giro llegó cuando los temas empezaron a sostenerse. «Dejen su loquera», «La gallina», «Curuleca» y «La pámpara» lo mantuvieron sonando sin pausa, y cuando contó más de diez canciones pegadas a la vez dejó la clínica. Por el cuarto de Los Guandules pasó de subida casi toda la nómina del dembow, entre ellos Rochy RD, El Mayor Clásico, Kiko el Crazy, Chimbala, Yomel el Meloso, El Cherry Scom, Haraca Kiko y Tivi Gunz. El estudio sigue ahí; no lo movió.

**Linda**

En octubre de 2020 produjo «Desacato Escolar», de Tokischa con Yomel el Meloso; YouTube la retiró por la letra, y el retiro mandó a la gente a buscarla. Al año siguiente produjo «Linda», el tema de Tokischa con Rosalía, rodado en Santo Domingo e interpretado en los Premios Billboard de la Música Latina ese septiembre. Desde entonces ha trabajado con J Balvin, Ozuna, Anuel AA, Myke Towers, De La Ghetto y Jowell y Randy, y entre sus créditos están «Corre Corre», «Alta Gama», «Pikilao», «La Cuarentena», «Rumba» y «La Máxima».

**Legado**

Leo RD está entre los productores que le dieron al dembow el sonido que hoy exporta. Trabaja por preferencia con artistas nuevos, y de ahí que buena parte de la nómina del género tenga sus primeras grabaciones en un cuarto de Los Guandules y no en un estudio comercial.' WHERE slug = 'leo-rd';

COMMIT;
