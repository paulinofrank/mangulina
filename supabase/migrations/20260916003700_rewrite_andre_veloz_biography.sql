BEGIN;

-- Ficha de Andre Veloz.
--
-- name "André Velóz" -> "Andre Veloz" (como se presenta ella); alias "La Velóz" (sin respaldo)
-- eliminado y "La Fosforera" añadido; nombre completo Andreina Martínez Hiraldo; nacida en St.
-- Croix, no en Santo Domingo; genres sin "bolero". Sin fecha de nacimiento (ella dijo que no
-- pusieran el año). Nominación a Revelación del Año, Premios Soberano 2019.

UPDATE artists SET name = 'Andre Veloz', sort_name = 'Veloz, Andre', stage_name = 'Andre Veloz',
       first_name = 'Andreina', last_name = 'Martínez', second_last_name = 'Hiraldo',
       aliases = ARRAY['La Fosforera','André Velóz']::text[],
       birth_place = 'St. Croix, Islas Vírgenes de EE. UU.', province = 'Nacido en el Exterior',
       genres = '{}'::text[], occupations = '["songwriter","actress"]'::jsonb
       WHERE slug = 'andre-veloz';

INSERT INTO award_categories (award_id, name)
  SELECT 'dec5d9e2-427b-414a-975f-41580488a7fd', 'Revelación del Año'
  WHERE NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd' AND name = 'Revelación del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT a.id, 'dec5d9e2-427b-414a-975f-41580488a7fd', (SELECT id FROM award_categories WHERE award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd' AND name = 'Revelación del Año'), 2019, NULL, false, 'Diario Libre (18 mar 2019) y El Caribe (28 ene 2019), listas de nominados; ganó Lo Blanquito (Listín Diario, 19 mar 2019; Acento, 20 mar 2019)'
  FROM artists a WHERE a.slug = 'andre-veloz';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Andre Veloz —born Andreina Martínez Hiraldo in St. Croix, U.S. Virgin Islands, in the 1980s, and nicknamed “La Fosforera”— is a Dominican singer, songwriter, painter and actress raised in Santiago de los Caballeros and based in New York, one of the few women singing traditional bachata."}]},{"type":"paragraph","content":[{"type":"text","text":"Between Santiago and the Bronx","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She was born in Christiansted, where her grandmother had a business, and was taken to the Dominican Republic as a baby; from about the age of eight she lived in Santiago, with stretches in Imbert and Las Canas. She began performing at fourteen with a garage band, «Los Horizontes Verticales», that debuted at her fifteenth birthday party, playing rock and jazz and, according to Bachata Republic, sharing the Santiago circuit with Fellé Vega, Patricia Pereyra and "},{"type":"artistReference","attrs":{"occurrenceId":"ad8e47d6-c084-41a2-ba59-95e2c7bbecea","artistId":"8e29188a-215b-4c6c-b34a-45b381765e46","displayText":"Xiomara Fortuna"}},{"type":"text","text":". At twenty-one she moved to the United States, where she worked and studied while singing in restaurants, clubs and Latin festivities in New York; the same source says she shared a stage there with the bachata requinto player "},{"type":"artistReference","attrs":{"occurrenceId":"2ab426e2-c9f6-484f-bb6f-150d42f7cd59","artistId":"cbda65a4-c7da-4762-8cf8-f29b942d2ac3","displayText":"Edilio Paredes"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Si la ves» and her first album","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2013 «IASO Records» signed her after hearing her sing «Si la ves», and in 2014 she released her first album, «Andre Veloz», which was well received among Dominican audiences in the United States. In May 2015 NY1 presented her as one of the few women performing traditional bachata. Having started in rock and jazz, she has described bachata as “the blues of us Dominicans”, with the same feeling and the same bitterness."}]},{"type":"paragraph","content":[{"type":"text","text":"«Eta’ que ta’ aquí» and the Soberano nomination","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2018 her single «Eta’ que ta’ aquí» went viral in the United States and the Dominican Republic; on 12 March 2018 El Nacional wrote that it was passing from mouth to mouth in streets, homes and offices despite its simple lyrics. She recorded a remix with "},{"type":"artistReference","attrs":{"occurrenceId":"47e35833-697f-4031-929c-3fa79ac46736","artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo"}},{"type":"text","text":" and followed it in December 2018 with «La Pendeja», a song about a romantic disappointment. At the 2019 Premios Soberano she was nominated for Revelación del Año, alongside «Lo Blanquito», El Deivy Jiménez, "},{"type":"artistReference","attrs":{"occurrenceId":"b87b2656-822e-4ddc-a93c-ab2ac3a71139","artistId":"71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb","displayText":"Rochy RD"}},{"type":"text","text":" and Lírico en la Casa; «Lo Blanquito» won."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She has kept releasing music, including «Juguito de Odio» in September 2025 and a further release in May 2026, and has been announced for a free festival in Greensboro. Bachata Republic adds that she teaches children with special needs, and the newspaper El Diario reported that she guided the Travel Channel host Andrew Zimmern through the Bronx’s culinary scene."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'andre-veloz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'andre-veloz' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'ad8e47d6-c084-41a2-ba59-95e2c7bbecea', 'artist', '8e29188a-215b-4c6c-b34a-45b381765e46' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'andre-veloz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '2ab426e2-c9f6-484f-bb6f-150d42f7cd59', 'artist', 'cbda65a4-c7da-4762-8cf8-f29b942d2ac3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'andre-veloz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '47e35833-697f-4031-929c-3fa79ac46736', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'andre-veloz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'b87b2656-822e-4ddc-a93c-ab2ac3a71139', 'artist', '71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'andre-veloz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Andre Veloz —born Andreina Martínez Hiraldo in St. Croix, U.S. Virgin Islands, in the 1980s, and nicknamed “La Fosforera”— is a Dominican singer, songwriter, painter and actress raised in Santiago de los Caballeros and based in New York, one of the few women singing traditional bachata.

**Between Santiago and the Bronx**

She was born in Christiansted, where her grandmother had a business, and was taken to the Dominican Republic as a baby; from about the age of eight she lived in Santiago, with stretches in Imbert and Las Canas. She began performing at fourteen with a garage band, «Los Horizontes Verticales», that debuted at her fifteenth birthday party, playing rock and jazz and, according to Bachata Republic, sharing the Santiago circuit with Fellé Vega, Patricia Pereyra and Xiomara Fortuna. At twenty-one she moved to the United States, where she worked and studied while singing in restaurants, clubs and Latin festivities in New York; the same source says she shared a stage there with the bachata requinto player Edilio Paredes.

**«Si la ves» and her first album**

In 2013 «IASO Records» signed her after hearing her sing «Si la ves», and in 2014 she released her first album, «Andre Veloz», which was well received among Dominican audiences in the United States. In May 2015 NY1 presented her as one of the few women performing traditional bachata. Having started in rock and jazz, she has described bachata as “the blues of us Dominicans”, with the same feeling and the same bitterness.

**«Eta’ que ta’ aquí» and the Soberano nomination**

In 2018 her single «Eta’ que ta’ aquí» went viral in the United States and the Dominican Republic; on 12 March 2018 El Nacional wrote that it was passing from mouth to mouth in streets, homes and offices despite its simple lyrics. She recorded a remix with Don Miguelo and followed it in December 2018 with «La Pendeja», a song about a romantic disappointment. At the 2019 Premios Soberano she was nominated for Revelación del Año, alongside «Lo Blanquito», El Deivy Jiménez, Rochy RD and Lírico en la Casa; «Lo Blanquito» won.

**Legacy**

She has kept releasing music, including «Juguito de Odio» in September 2025 and a further release in May 2026, and has been announced for a free festival in Greensboro. Bachata Republic adds that she teaches children with special needs, and the newspaper El Diario reported that she guided the Travel Channel host Andrew Zimmern through the Bronx’s culinary scene.' WHERE slug = 'andre-veloz';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Andre Veloz —nacida Andreina Martínez Hiraldo en St. Croix, Islas Vírgenes de Estados Unidos, en la década de 1980, y apodada “La Fosforera”— es cantante, compositora, pintora y actriz dominicana criada en Santiago de los Caballeros y radicada en Nueva York, una de las pocas mujeres que cantan bachata tradicional."}]},{"type":"paragraph","content":[{"type":"text","text":"Entre Santiago y el Bronx","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Nació en Christiansted, donde su abuela tenía un negocio, y la llevaron a República Dominicana siendo bebé; desde los ocho años más o menos vivió en Santiago, con temporadas en Imbert y Las Canas. Empezó a presentarse a los catorce años con una banda de garaje, «Los Horizontes Verticales», que debutó en su fiesta de quince, tocando rock y jazz y, según Bachata Republic, compartiendo el circuito santiaguero con Fellé Vega, Patricia Pereyra y "},{"type":"artistReference","attrs":{"occurrenceId":"fd72bbd8-90f6-4847-886d-bc68bc9ade99","artistId":"8e29188a-215b-4c6c-b34a-45b381765e46","displayText":"Xiomara Fortuna"}},{"type":"text","text":". A los veintiún años se mudó a Estados Unidos, donde trabajó y estudió mientras cantaba en restaurantes, discotecas y fiestas latinas de Nueva York; la misma fuente dice que allí compartió tarima con el requintista de bachata "},{"type":"artistReference","attrs":{"occurrenceId":"25218b63-c9fe-4689-9464-4298e69e4d65","artistId":"cbda65a4-c7da-4762-8cf8-f29b942d2ac3","displayText":"Edilio Paredes"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Si la ves» y su primer álbum","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2013 «IASO Records» la fichó tras escucharla cantar «Si la ves», y en 2014 publicó su primer álbum, «Andre Veloz», bien recibido entre el público dominicano en Estados Unidos. En mayo de 2015 NY1 la presentó como una de las pocas mujeres intérpretes de la bachata tradicional. Habiendo empezado en el rock y el jazz, ha descrito la bachata como “el blues de nosotros los dominicanos”, con el mismo sentimiento y la misma amargura."}]},{"type":"paragraph","content":[{"type":"text","text":"«Eta’ que ta’ aquí» y la nominación al Soberano","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2018 su sencillo «Eta’ que ta’ aquí» se volvió viral en Estados Unidos y República Dominicana; el 12 de marzo de 2018 El Nacional escribió que andaba de boca en boca en calles, casas y oficinas pese a sus letras sencillas. Grabó un remix con "},{"type":"artistReference","attrs":{"occurrenceId":"9ec28d8d-1042-41eb-863b-4e210d0d2f7e","artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo"}},{"type":"text","text":" y lo siguió en diciembre de 2018 con «La Pendeja», sobre una decepción amorosa. En los Premios Soberano 2019 fue nominada a Revelación del Año, junto a «Lo Blanquito», El Deivy Jiménez, "},{"type":"artistReference","attrs":{"occurrenceId":"ab103173-0c3a-4c59-a77c-f4c0a4b2116d","artistId":"71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb","displayText":"Rochy RD"}},{"type":"text","text":" y Lírico en la Casa; ganó «Lo Blanquito»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ha seguido publicando música, entre ella «Juguito de Odio» en septiembre de 2025 y otro lanzamiento en mayo de 2026, y se anunció su participación en un festival gratuito en Greensboro. Bachata Republic añade que da clases a niños con necesidades especiales, y el diario El Diario contó que guió al presentador de Travel Channel Andrew Zimmern por la oferta gastronómica del Bronx."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'andre-veloz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'andre-veloz' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'fd72bbd8-90f6-4847-886d-bc68bc9ade99', 'artist', '8e29188a-215b-4c6c-b34a-45b381765e46' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'andre-veloz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '25218b63-c9fe-4689-9464-4298e69e4d65', 'artist', 'cbda65a4-c7da-4762-8cf8-f29b942d2ac3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'andre-veloz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '9ec28d8d-1042-41eb-863b-4e210d0d2f7e', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'andre-veloz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'ab103173-0c3a-4c59-a77c-f4c0a4b2116d', 'artist', '71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'andre-veloz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Andre Veloz —nacida Andreina Martínez Hiraldo en St. Croix, Islas Vírgenes de Estados Unidos, en la década de 1980, y apodada “La Fosforera”— es cantante, compositora, pintora y actriz dominicana criada en Santiago de los Caballeros y radicada en Nueva York, una de las pocas mujeres que cantan bachata tradicional.

**Entre Santiago y el Bronx**

Nació en Christiansted, donde su abuela tenía un negocio, y la llevaron a República Dominicana siendo bebé; desde los ocho años más o menos vivió en Santiago, con temporadas en Imbert y Las Canas. Empezó a presentarse a los catorce años con una banda de garaje, «Los Horizontes Verticales», que debutó en su fiesta de quince, tocando rock y jazz y, según Bachata Republic, compartiendo el circuito santiaguero con Fellé Vega, Patricia Pereyra y Xiomara Fortuna. A los veintiún años se mudó a Estados Unidos, donde trabajó y estudió mientras cantaba en restaurantes, discotecas y fiestas latinas de Nueva York; la misma fuente dice que allí compartió tarima con el requintista de bachata Edilio Paredes.

**«Si la ves» y su primer álbum**

En 2013 «IASO Records» la fichó tras escucharla cantar «Si la ves», y en 2014 publicó su primer álbum, «Andre Veloz», bien recibido entre el público dominicano en Estados Unidos. En mayo de 2015 NY1 la presentó como una de las pocas mujeres intérpretes de la bachata tradicional. Habiendo empezado en el rock y el jazz, ha descrito la bachata como “el blues de nosotros los dominicanos”, con el mismo sentimiento y la misma amargura.

**«Eta’ que ta’ aquí» y la nominación al Soberano**

En 2018 su sencillo «Eta’ que ta’ aquí» se volvió viral en Estados Unidos y República Dominicana; el 12 de marzo de 2018 El Nacional escribió que andaba de boca en boca en calles, casas y oficinas pese a sus letras sencillas. Grabó un remix con Don Miguelo y lo siguió en diciembre de 2018 con «La Pendeja», sobre una decepción amorosa. En los Premios Soberano 2019 fue nominada a Revelación del Año, junto a «Lo Blanquito», El Deivy Jiménez, Rochy RD y Lírico en la Casa; ganó «Lo Blanquito».

**Legado**

Ha seguido publicando música, entre ella «Juguito de Odio» en septiembre de 2025 y otro lanzamiento en mayo de 2026, y se anunció su participación en un festival gratuito en Greensboro. Bachata Republic añade que da clases a niños con necesidades especiales, y el diario El Diario contó que guió al presentador de Travel Channel Andrew Zimmern por la oferta gastronómica del Bronx.' WHERE slug = 'andre-veloz';

COMMIT;
