BEGIN;

-- Ficha de Henry García.
--
-- Campos: middle_name Hilton y second_last_name Rosario (nombre legal en Zona
-- Rumbera y en el perfil de Discogs). occupations pasa de [arranger] a
-- [songwriter, bandleader, arranger]: autor de «Me mata la soledad» y «En las
-- nubes» (AllMusic, Discogs), director de «Henry García y Orquesta» desde 1984,
-- arreglista de coros (Discogs).
--
-- La ficha de Isabelle Valdez lo enlaza entre sus colaboradores cristianos; no
-- se encontró fuente de esa colaboración y puede tratarse de un homónimo.
-- Anotado en CONFLICTOS_DE_DATO; no se tocó.

UPDATE artists SET middle_name = 'Hilton', second_last_name = 'Rosario',
       occupations = '["songwriter","bandleader","arranger"]'::jsonb WHERE slug = 'henry-garcia';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Henry García — Henry Hilton García Rosario, born in Santo Domingo on 13 September 1955 — is a Dominican singer and songwriter. He was the lead voice of "},{"type":"artistReference","attrs":{"occurrenceId":"7d28b6a4-e8c2-4a55-8b96-b5f3f787f488","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":"’s orchestra in the late 1970s, when it sang «Nació varón» and «Cuatro personas», and has since led his own orchestra, sung with "},{"type":"artistReference","attrs":{"occurrenceId":"9615ab2e-aa9a-4a07-bb9e-155a96035cfd","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"4c8d1c0c-67ef-4511-8224-192b6183642c","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":", spent decades as one of the busiest backing singers in Dominican studios, and written hits for other voices, among them «Me mata la soledad» for Tito Rojas and «En las nubes» for Manny Manuel."}]},{"type":"paragraph","content":[{"type":"text","text":"Guitar lessons and La Barrica","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He started studying music and guitar at fifteen. At nineteen he turned professional with the group of "},{"type":"artistReference","attrs":{"occurrenceId":"f582cd35-a4f7-434f-8a81-7f033c849805","artistId":"a4b2104e-5b76-4e04-b9ac-dfe3f25ea71d","displayText":"Julito Deschamps"}},{"type":"text","text":" at La Barrica, a Santo Domingo nightspot, where he spent about a year sharing the stage with experienced players."}]},{"type":"paragraph","content":[{"type":"text","text":"The voice of Los Virtuosos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"On 19 February 1977 he joined «Los Virtuosos», the band "},{"type":"artistReference","attrs":{"occurrenceId":"bf8ab12a-5996-4cb7-aac3-08ead7c27bda","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" had built in the seventies and that later took the name «La Tribu» after a tour of Panama. García became its main singer. «Nació varón» and «Cuatro personas», from the band’s third album, «Un momento... llegaron los Virtuosos», are still credited to his voice, alongside «Se fue Daniel», «La temperatura» and «Morina», and the orchestra took them on tour through the United States, Central and South America and Europe. In 1980 "},{"type":"artistReference","attrs":{"occurrenceId":"2c1cc3b3-11c5-472c-b1d1-275453796734","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":"’s orchestra also recorded the first song García wrote, «Cuando te entregué mi amor»."}]},{"type":"paragraph","content":[{"type":"text","text":"His own orchestra and the Internacional","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1984 he left to form «Henry García y Orquesta». The first album featured «Marcela», by "},{"type":"artistReference","attrs":{"occurrenceId":"86b860b4-3db1-4f6e-bbd9-c45ec04a45df","artistId":"29832daf-f093-4ccb-820d-441cdc3f48c0","displayText":"Fernando Echavarría"}},{"type":"text","text":", and «Volverte a encontrar», one of his own. In 1986 he and "},{"type":"artistReference","attrs":{"occurrenceId":"766a5101-9ea1-47f6-b582-2b2ba0bd13eb","artistId":"bb114227-a160-4f45-960e-b6c1710fbeef","displayText":"Peter Cruz"}},{"type":"text","text":" were the voices of "},{"type":"artistReference","attrs":{"occurrenceId":"eacd6f85-66ad-42cc-8a24-53a63777d62b","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":", whose hits of that stage include «Lágrimas de amor» and «Cómo te atreves». He then went back to his own band for «El consentido» (1987), with «Hada madrina», and «Quédate ya» (1988)."}]},{"type":"paragraph","content":[{"type":"text","text":"The studio voice","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Alongside his own records García built a long career as a studio backing singer and chorus arranger. His voice is on sessions for "},{"type":"artistReference","attrs":{"occurrenceId":"af784520-5fa4-416b-92a9-e3fe806ee2a1","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"904120d3-8f86-42f1-b487-5595683b3cdb","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"19ece5b6-42cf-4adc-b7ad-207fab36d809","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"422c659a-dea1-4d5e-933c-71a5031b9c0a","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"523b7a81-0aee-4c62-b396-e2b598f79a4d","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"b162380d-4da6-4042-b954-cabd84be61fa","artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario"}},{"type":"text","text":", among many others. From 1992 to 1994 he toured with "},{"type":"artistReference","attrs":{"occurrenceId":"4e5256fa-fe96-48c1-912a-bde9e988ec34","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":", and with it recorded «Salsa con coco» and his own «Corazón programado»."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs for other voices","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1990 the Puerto Rican salsero Tito Rojas included «Me mata la soledad», written by García, on his album «Sensual», and the song became an international hit. In 1999 Manny Manuel opened «Lleno de vida» with García’s «En las nubes», a record on which García also sang in the chorus."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Henry García’s career runs through three of the central institutions of Dominican dance music — the orchestras of "},{"type":"artistReference","attrs":{"occurrenceId":"e0faeddd-0235-47aa-9bf8-028528639781","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"c193f181-bfc4-4558-8901-1e797dc4ed60","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"e2df70e4-4b22-478c-8b13-e178a08f1912","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":" — and through the studios where much of the country’s merengue was recorded. His songs have travelled furthest in other voices, and «Nació varón» remains the recording most closely tied to his own."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'henry-garcia'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7d28b6a4-e8c2-4a55-8b96-b5f3f787f488', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9615ab2e-aa9a-4a07-bb9e-155a96035cfd', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4c8d1c0c-67ef-4511-8224-192b6183642c', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f582cd35-a4f7-434f-8a81-7f033c849805', 'artist', 'a4b2104e-5b76-4e04-b9ac-dfe3f25ea71d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'bf8ab12a-5996-4cb7-aac3-08ead7c27bda', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2c1cc3b3-11c5-472c-b1d1-275453796734', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '86b860b4-3db1-4f6e-bbd9-c45ec04a45df', 'artist', '29832daf-f093-4ccb-820d-441cdc3f48c0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '766a5101-9ea1-47f6-b582-2b2ba0bd13eb', 'artist', 'bb114227-a160-4f45-960e-b6c1710fbeef' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'eacd6f85-66ad-42cc-8a24-53a63777d62b', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'af784520-5fa4-416b-92a9-e3fe806ee2a1', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '904120d3-8f86-42f1-b487-5595683b3cdb', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '19ece5b6-42cf-4adc-b7ad-207fab36d809', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '422c659a-dea1-4d5e-933c-71a5031b9c0a', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '523b7a81-0aee-4c62-b396-e2b598f79a4d', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b162380d-4da6-4042-b954-cabd84be61fa', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4e5256fa-fe96-48c1-912a-bde9e988ec34', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e0faeddd-0235-47aa-9bf8-028528639781', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c193f181-bfc4-4558-8901-1e797dc4ed60', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e2df70e4-4b22-478c-8b13-e178a08f1912', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Henry García — Henry Hilton García Rosario, born in Santo Domingo on 13 September 1955 — is a Dominican singer and songwriter. He was the lead voice of Cuco Valoy’s orchestra in the late 1970s, when it sang «Nació varón» and «Cuatro personas», and has since led his own orchestra, sung with Ramón Orlando & Orquesta Internacional and Pochy y su Cocoband, spent decades as one of the busiest backing singers in Dominican studios, and written hits for other voices, among them «Me mata la soledad» for Tito Rojas and «En las nubes» for Manny Manuel.

**Guitar lessons and La Barrica**

He started studying music and guitar at fifteen. At nineteen he turned professional with the group of Julito Deschamps at La Barrica, a Santo Domingo nightspot, where he spent about a year sharing the stage with experienced players.

**The voice of Los Virtuosos**

On 19 February 1977 he joined «Los Virtuosos», the band Cuco Valoy had built in the seventies and that later took the name «La Tribu» after a tour of Panama. García became its main singer. «Nació varón» and «Cuatro personas», from the band’s third album, «Un momento... llegaron los Virtuosos», are still credited to his voice, alongside «Se fue Daniel», «La temperatura» and «Morina», and the orchestra took them on tour through the United States, Central and South America and Europe. In 1980 Cuco Valoy’s orchestra also recorded the first song García wrote, «Cuando te entregué mi amor».

**His own orchestra and the Internacional**

In 1984 he left to form «Henry García y Orquesta». The first album featured «Marcela», by Fernando Echavarría, and «Volverte a encontrar», one of his own. In 1986 he and Peter Cruz were the voices of Ramón Orlando & Orquesta Internacional, whose hits of that stage include «Lágrimas de amor» and «Cómo te atreves». He then went back to his own band for «El consentido» (1987), with «Hada madrina», and «Quédate ya» (1988).

**The studio voice**

Alongside his own records García built a long career as a studio backing singer and chorus arranger. His voice is on sessions for Juan Luis Guerra 4.40, Wilfrido Vargas, Sergio Vargas, Fernando Villalona, Rubby Pérez and Los Hermanos Rosario, among many others. From 1992 to 1994 he toured with Pochy y su Cocoband, and with it recorded «Salsa con coco» and his own «Corazón programado».

**Songs for other voices**

In 1990 the Puerto Rican salsero Tito Rojas included «Me mata la soledad», written by García, on his album «Sensual», and the song became an international hit. In 1999 Manny Manuel opened «Lleno de vida» with García’s «En las nubes», a record on which García also sang in the chorus.

**Legacy**

Henry García’s career runs through three of the central institutions of Dominican dance music — the orchestras of Cuco Valoy, Ramón Orlando & Orquesta Internacional and Pochy y su Cocoband — and through the studios where much of the country’s merengue was recorded. His songs have travelled furthest in other voices, and «Nació varón» remains the recording most closely tied to his own.' WHERE slug = 'henry-garcia';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Henry García —Henry Hilton García Rosario, nacido en Santo Domingo el 13 de septiembre de 1955— es cantante y compositor dominicano. Fue la voz principal de la orquesta de "},{"type":"artistReference","attrs":{"occurrenceId":"c7a6847f-425d-481d-add7-3a8f188ff3cb","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" a finales de los setenta, la de «Nació varón» y «Cuatro personas», y desde entonces ha dirigido su propia orquesta, ha cantado con "},{"type":"artistReference","attrs":{"occurrenceId":"cbd9ea5c-1e7b-44df-89a1-b07f9796c36f","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":" y con "},{"type":"artistReference","attrs":{"occurrenceId":"6248f3a8-c082-4e04-b419-528a960d1c9b","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":", ha pasado décadas como uno de los coristas más solicitados de los estudios dominicanos y ha escrito éxitos para otras voces, entre ellos «Me mata la soledad» para Tito Rojas y «En las nubes» para Manny Manuel."}]},{"type":"paragraph","content":[{"type":"text","text":"La guitarra y La Barrica","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó a estudiar música y guitarra a los quince años. A los diecinueve se hizo profesional con el grupo de "},{"type":"artistReference","attrs":{"occurrenceId":"92fba4f7-7585-4a41-ae71-e0d6791eff31","artistId":"a4b2104e-5b76-4e04-b9ac-dfe3f25ea71d","displayText":"Julito Deschamps"}},{"type":"text","text":" en La Barrica, un local nocturno de Santo Domingo, donde pasó cerca de un año compartiendo tarima con músicos de oficio."}]},{"type":"paragraph","content":[{"type":"text","text":"La voz de Los Virtuosos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El 19 de febrero de 1977 entró en «Los Virtuosos», la banda que "},{"type":"artistReference","attrs":{"occurrenceId":"57f5aa35-3e19-4f67-bfc6-2ffb99270b91","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" había armado en los setenta y que después se llamaría «La Tribu», a raíz de una gira por Panamá. García pasó a ser su cantante principal. «Nació varón» y «Cuatro personas», del tercer disco del grupo, «Un momento... llegaron los Virtuosos», siguen acreditadas a su voz, junto a «Se fue Daniel», «La temperatura» y «Morina», y con ellas la orquesta recorrió Estados Unidos, Centroamérica, Suramérica y Europa. En 1980 la orquesta de "},{"type":"artistReference","attrs":{"occurrenceId":"cc8009fb-86a8-4f05-b6ea-48d30cd8633c","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" grabó también la primera canción que escribió García, «Cuando te entregué mi amor»."}]},{"type":"paragraph","content":[{"type":"text","text":"Orquesta propia y la Internacional","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1984 se independizó y formó «Henry García y Orquesta». El primer disco trajo «Marcela», de "},{"type":"artistReference","attrs":{"occurrenceId":"6042c471-23fb-4f1e-aa2a-88b5c70c2617","artistId":"29832daf-f093-4ccb-820d-441cdc3f48c0","displayText":"Fernando Echavarría"}},{"type":"text","text":", y «Volverte a encontrar», de su autoría. En 1986 él y "},{"type":"artistReference","attrs":{"occurrenceId":"690ef3ad-33cc-4770-83d8-6ed22c197b77","artistId":"bb114227-a160-4f45-960e-b6c1710fbeef","displayText":"Peter Cruz"}},{"type":"text","text":" fueron las voces de "},{"type":"artistReference","attrs":{"occurrenceId":"7917393b-d788-4d65-9171-8815fdd285ef","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":", que en esa etapa sacó «Lágrimas de amor» y «Cómo te atreves». Luego volvió a su orquesta para grabar «El consentido» (1987), con «Hada madrina», y «Quédate ya» (1988)."}]},{"type":"paragraph","content":[{"type":"text","text":"La voz del estudio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En paralelo a sus discos, García levantó una larga carrera como corista y arreglista de coros. Su voz está en grabaciones de "},{"type":"artistReference","attrs":{"occurrenceId":"b91b3727-1862-4481-b400-94b8b9ed10f2","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"4112b1fa-3118-48c3-8909-7da68881075f","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"61db5bdd-ecad-4fcc-957a-3ac740235e2d","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"1547ee25-9450-4499-a81a-a3d083a10931","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"0e19f05d-cf49-4912-949a-8e4e8f00fac9","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"f53438cf-5e9a-4b03-a601-65884a9c0666","artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario"}},{"type":"text","text":", entre muchos otros. De 1992 a 1994 anduvo de gira con "},{"type":"artistReference","attrs":{"occurrenceId":"dcbf12ce-600a-493f-962a-579da04a8892","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":", con la que grabó «Salsa con coco» y su propia «Corazón programado»."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones para otras voces","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1990 el salsero puertorriqueño Tito Rojas incluyó «Me mata la soledad», de García, en su disco «Sensual», y la canción fue un éxito internacional. En 1999 Manny Manuel abrió «Lleno de vida» con «En las nubes», también suya, un disco en el que García además hizo coros."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La carrera de Henry García atraviesa tres instituciones centrales del baile dominicano —las orquestas de "},{"type":"artistReference","attrs":{"occurrenceId":"d2f48afd-6289-474e-849b-e4a0d46752a7","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"b17ea859-bc1c-401f-88ba-d656bb90d270","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"34a45ebe-61a2-4939-99a5-6f9a8c204659","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":"— y los estudios donde se grabó buena parte del merengue del país. Sus canciones han llegado más lejos en otras voces, y «Nació varón» sigue siendo la grabación que más se asocia con la suya."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'henry-garcia'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c7a6847f-425d-481d-add7-3a8f188ff3cb', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cbd9ea5c-1e7b-44df-89a1-b07f9796c36f', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6248f3a8-c082-4e04-b419-528a960d1c9b', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '92fba4f7-7585-4a41-ae71-e0d6791eff31', 'artist', 'a4b2104e-5b76-4e04-b9ac-dfe3f25ea71d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '57f5aa35-3e19-4f67-bfc6-2ffb99270b91', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cc8009fb-86a8-4f05-b6ea-48d30cd8633c', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6042c471-23fb-4f1e-aa2a-88b5c70c2617', 'artist', '29832daf-f093-4ccb-820d-441cdc3f48c0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '690ef3ad-33cc-4770-83d8-6ed22c197b77', 'artist', 'bb114227-a160-4f45-960e-b6c1710fbeef' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7917393b-d788-4d65-9171-8815fdd285ef', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b91b3727-1862-4481-b400-94b8b9ed10f2', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4112b1fa-3118-48c3-8909-7da68881075f', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '61db5bdd-ecad-4fcc-957a-3ac740235e2d', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1547ee25-9450-4499-a81a-a3d083a10931', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0e19f05d-cf49-4912-949a-8e4e8f00fac9', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f53438cf-5e9a-4b03-a601-65884a9c0666', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dcbf12ce-600a-493f-962a-579da04a8892', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd2f48afd-6289-474e-849b-e4a0d46752a7', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b17ea859-bc1c-401f-88ba-d656bb90d270', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '34a45ebe-61a2-4939-99a5-6f9a8c204659', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Henry García —Henry Hilton García Rosario, nacido en Santo Domingo el 13 de septiembre de 1955— es cantante y compositor dominicano. Fue la voz principal de la orquesta de Cuco Valoy a finales de los setenta, la de «Nació varón» y «Cuatro personas», y desde entonces ha dirigido su propia orquesta, ha cantado con Ramón Orlando & Orquesta Internacional y con Pochy y su Cocoband, ha pasado décadas como uno de los coristas más solicitados de los estudios dominicanos y ha escrito éxitos para otras voces, entre ellos «Me mata la soledad» para Tito Rojas y «En las nubes» para Manny Manuel.

**La guitarra y La Barrica**

Empezó a estudiar música y guitarra a los quince años. A los diecinueve se hizo profesional con el grupo de Julito Deschamps en La Barrica, un local nocturno de Santo Domingo, donde pasó cerca de un año compartiendo tarima con músicos de oficio.

**La voz de Los Virtuosos**

El 19 de febrero de 1977 entró en «Los Virtuosos», la banda que Cuco Valoy había armado en los setenta y que después se llamaría «La Tribu», a raíz de una gira por Panamá. García pasó a ser su cantante principal. «Nació varón» y «Cuatro personas», del tercer disco del grupo, «Un momento... llegaron los Virtuosos», siguen acreditadas a su voz, junto a «Se fue Daniel», «La temperatura» y «Morina», y con ellas la orquesta recorrió Estados Unidos, Centroamérica, Suramérica y Europa. En 1980 la orquesta de Cuco Valoy grabó también la primera canción que escribió García, «Cuando te entregué mi amor».

**Orquesta propia y la Internacional**

En 1984 se independizó y formó «Henry García y Orquesta». El primer disco trajo «Marcela», de Fernando Echavarría, y «Volverte a encontrar», de su autoría. En 1986 él y Peter Cruz fueron las voces de Ramón Orlando & Orquesta Internacional, que en esa etapa sacó «Lágrimas de amor» y «Cómo te atreves». Luego volvió a su orquesta para grabar «El consentido» (1987), con «Hada madrina», y «Quédate ya» (1988).

**La voz del estudio**

En paralelo a sus discos, García levantó una larga carrera como corista y arreglista de coros. Su voz está en grabaciones de Juan Luis Guerra 4.40, Wilfrido Vargas, Sergio Vargas, Fernando Villalona, Rubby Pérez y Los Hermanos Rosario, entre muchos otros. De 1992 a 1994 anduvo de gira con Pochy y su Cocoband, con la que grabó «Salsa con coco» y su propia «Corazón programado».

**Canciones para otras voces**

En 1990 el salsero puertorriqueño Tito Rojas incluyó «Me mata la soledad», de García, en su disco «Sensual», y la canción fue un éxito internacional. En 1999 Manny Manuel abrió «Lleno de vida» con «En las nubes», también suya, un disco en el que García además hizo coros.

**Legado**

La carrera de Henry García atraviesa tres instituciones centrales del baile dominicano —las orquestas de Cuco Valoy, Ramón Orlando & Orquesta Internacional y Pochy y su Cocoband— y los estudios donde se grabó buena parte del merengue del país. Sus canciones han llegado más lejos en otras voces, y «Nació varón» sigue siendo la grabación que más se asocia con la suya.' WHERE slug = 'henry-garcia';

COMMIT;
