BEGIN;

-- Ficha NUEVA: El Blachy. No existía previamente en el catálogo.
-- Cantante y compositor de merengue típico; Premios Soberano, Conjunto Típico, 2024 y 2025.

INSERT INTO artists (name, sort_name, type, birth_year, first_name, middle_name, last_name, stage_name,
                           birth_place, youtube, instagram, aliases,
                           occupations, instruments, genres, gender, ended, province, slug,
                           primary_role, artist_tags, status, primary_genre, has_image, id)
  VALUES ('El Blachy', 'Fragoso, Blas Darío', 'solo_artist', 1981, 'Blas', 'Darío', 'Fragoso', 'El Blachy',
          'Santo Domingo', '@elblachy', 'elblachy', ARRAY['El Blachy y su Romantiqueo Típico']::text[],
          '["composer","bandleader"]'::jsonb, '{}'::text[], ARRAY['merengue-perico-ripiao']::text[], 'male', false, 'Distrito Nacional', 'el-blachy',
          'singer', ARRAY['secular']::text[], 'published', 'merengue', false, '691170b7-9e7d-43b4-b00a-319d2bbeaf37');

INSERT INTO award_categories (award_id, name)
  SELECT 'dec5d9e2-427b-414a-975f-41580488a7fd', 'Conjunto Típico del Año'
  WHERE NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd' AND name = 'Conjunto Típico del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT a.id, 'dec5d9e2-427b-414a-975f-41580488a7fd', (SELECT id FROM award_categories WHERE award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd' AND name = 'Conjunto Típico del Año'), 2024, NULL, true, 'Listín Diario (12 mar 2024); El Día y Teleuniverso (12-13 mar 2024); Listín Diario, entrevista del 11 nov 2024'
  FROM artists a WHERE a.slug = 'el-blachy';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT a.id, 'dec5d9e2-427b-414a-975f-41580488a7fd', (SELECT id FROM award_categories WHERE award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd' AND name = 'Conjunto Típico del Año'), 2025, NULL, true, 'El Caribe (25 mar 2025); Eco del Pueblo (26 mar 2025)'
  FROM artists a WHERE a.slug = 'el-blachy';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"El Blachy —born Blas Darío Fragoso in Santo Domingo in 1981 and raised in Santiago de los Caballeros— is a Dominican merengue típico singer and songwriter who became one of the genre’s leading names in the 2020s, winning the Premios Soberano for Conjunto Típico in 2024 and 2025."}]},{"type":"paragraph","content":[{"type":"text","text":"Years in the big orchestras","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began in the «Merengue Band», the house orchestra of the «Hotel Jaragua», where he stayed a year, then spent five years in the orchestra of "},{"type":"artistReference","attrs":{"occurrenceId":"0d18731e-68e1-41df-96b0-b23026e0202e","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":" and nine with "},{"type":"artistReference","attrs":{"occurrenceId":"04d87c3a-6c6f-4c46-9d74-bf2e3dcc9dce","artistId":"76c3c113-eea0-4dbd-8e71-c7dc6662c86c","displayText":"Yovanny Polanco"}},{"type":"text","text":", whom he later described as being like a father to him. He also passed through "},{"type":"artistReference","attrs":{"occurrenceId":"3805b745-2c2c-419a-bcd4-d5f71f3051db","artistId":"d133f2df-cb21-4dd4-8673-8efb63e6cc5d","displayText":"Banda Real"}},{"type":"text","text":", which he calls his “university” and where he recorded «Perdido sin ti», a song he also wrote. His nickname comes from his grandfather, who was known by the same name."}]},{"type":"paragraph","content":[{"type":"text","text":"A solo project","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"When "},{"type":"artistReference","attrs":{"occurrenceId":"9e2fed47-6035-4d10-9c26-39edfbea6856","artistId":"76c3c113-eea0-4dbd-8e71-c7dc6662c86c","displayText":"Yovanny Polanco"}},{"type":"text","text":" announced a break from the stage shortly before the pandemic, El Blachy struck out on his own. After a 2020 ballad-crossover tour, «En Romantiqueo Tours», he presented his own típico group in December 2020, «El Blachy y su Romantiqueo Típico», debuting with a típico cover of «La Nochecita», a song by Lenier and El Micha with Jacob Forever, arranged by Israel Almonte."}]},{"type":"paragraph","content":[{"type":"text","text":"«Hola perdida» and the Soberano","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His breakthrough came with a merengue típico version of «Hola perdida», a song by the Argentine artist Luck Ra, after an earlier single, «A qué vuelves», went largely unnoticed. He also turned Maluma’s «Sobrio» into típico, and recorded «Pa’ Perderte» with "},{"type":"artistReference","attrs":{"occurrenceId":"a5bce6bd-1939-443e-8e9b-a19829fccb2f","artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz"}},{"type":"text","text":". At the March 2024 Premios Soberano he won Conjunto Típico, reported at the time as beating "},{"type":"artistReference","attrs":{"occurrenceId":"fb89ac17-1414-4e7e-925e-119603d4d78b","artistId":"76c3c113-eea0-4dbd-8e71-c7dc6662c86c","displayText":"Yovanny Polanco"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"c264faad-b7b4-4404-ad3c-68a489726249","artistId":"15c08a48-b94b-41c8-99d8-53144397c787","displayText":"Krisspy"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"4e9f2bc2-c691-480b-9856-0d3b9287fbb5","artistId":"d133f2df-cb21-4dd4-8673-8efb63e6cc5d","displayText":"Banda Real"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"6a0c589f-334f-4fed-8aa0-f9629b22ea05","artistId":"f07fcc6b-a888-4e97-ac50-6ce6ea37a714","displayText":"El Prodigio"}},{"type":"text","text":"; he won the category again in 2025. He has said he keeps his lyrics clean because children are among his listeners."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"By late 2024 El Blachy was booking around forty parties in November and sixty in December, and had announced collaborations with "},{"type":"artistReference","attrs":{"occurrenceId":"dde104ae-bb94-4701-a7e2-8e736e393344","artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"e8b6025a-2f28-4022-882f-28ea7636fb0e","artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47"}},{"type":"text","text":". In August 2026 he filled the Coca-Cola Music Hall in Puerto Rico, part of a run of international dates that includes a tour of the United States."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'el-blachy';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '0d18731e-68e1-41df-96b0-b23026e0202e', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '04d87c3a-6c6f-4c46-9d74-bf2e3dcc9dce', 'artist', '76c3c113-eea0-4dbd-8e71-c7dc6662c86c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '3805b745-2c2c-419a-bcd4-d5f71f3051db', 'artist', 'd133f2df-cb21-4dd4-8673-8efb63e6cc5d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '9e2fed47-6035-4d10-9c26-39edfbea6856', 'artist', '76c3c113-eea0-4dbd-8e71-c7dc6662c86c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'a5bce6bd-1939-443e-8e9b-a19829fccb2f', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'fb89ac17-1414-4e7e-925e-119603d4d78b', 'artist', '76c3c113-eea0-4dbd-8e71-c7dc6662c86c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c264faad-b7b4-4404-ad3c-68a489726249', 'artist', '15c08a48-b94b-41c8-99d8-53144397c787' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '4e9f2bc2-c691-480b-9856-0d3b9287fbb5', 'artist', 'd133f2df-cb21-4dd4-8673-8efb63e6cc5d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '6a0c589f-334f-4fed-8aa0-f9629b22ea05', 'artist', 'f07fcc6b-a888-4e97-ac50-6ce6ea37a714' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'dde104ae-bb94-4701-a7e2-8e736e393344', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'e8b6025a-2f28-4022-882f-28ea7636fb0e', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'El Blachy —born Blas Darío Fragoso in Santo Domingo in 1981 and raised in Santiago de los Caballeros— is a Dominican merengue típico singer and songwriter who became one of the genre’s leading names in the 2020s, winning the Premios Soberano for Conjunto Típico in 2024 and 2025.

**Years in the big orchestras**

He began in the «Merengue Band», the house orchestra of the «Hotel Jaragua», where he stayed a year, then spent five years in the orchestra of Wilfrido Vargas and nine with Yovanny Polanco, whom he later described as being like a father to him. He also passed through Banda Real, which he calls his “university” and where he recorded «Perdido sin ti», a song he also wrote. His nickname comes from his grandfather, who was known by the same name.

**A solo project**

When Yovanny Polanco announced a break from the stage shortly before the pandemic, El Blachy struck out on his own. After a 2020 ballad-crossover tour, «En Romantiqueo Tours», he presented his own típico group in December 2020, «El Blachy y su Romantiqueo Típico», debuting with a típico cover of «La Nochecita», a song by Lenier and El Micha with Jacob Forever, arranged by Israel Almonte.

**«Hola perdida» and the Soberano**

His breakthrough came with a merengue típico version of «Hola perdida», a song by the Argentine artist Luck Ra, after an earlier single, «A qué vuelves», went largely unnoticed. He also turned Maluma’s «Sobrio» into típico, and recorded «Pa’ Perderte» with Manny Cruz. At the March 2024 Premios Soberano he won Conjunto Típico, reported at the time as beating Yovanny Polanco, Krisspy, Banda Real and El Prodigio; he won the category again in 2025. He has said he keeps his lyrics clean because children are among his listeners.

**Legacy**

By late 2024 El Blachy was booking around forty parties in November and sixty in December, and had announced collaborations with Chimbala and Bulin 47. In August 2026 he filled the Coca-Cola Music Hall in Puerto Rico, part of a run of international dates that includes a tour of the United States.' WHERE slug = 'el-blachy';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"El Blachy —nacido Blas Darío Fragoso en Santo Domingo en 1981 y criado en Santiago de los Caballeros— es cantante y compositor dominicano de merengue típico que se convirtió en uno de los nombres principales del género en la década de 2020, ganando el Premio Soberano a Conjunto Típico en 2024 y 2025."}]},{"type":"paragraph","content":[{"type":"text","text":"Años en las grandes orquestas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó en la «Merengue Band», la orquesta del «Hotel Jaragua», donde estuvo un año, y luego pasó cinco años en la orquesta de "},{"type":"artistReference","attrs":{"occurrenceId":"388c3ced-0171-4bbf-b2ff-845d872ce286","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":" y nueve con "},{"type":"artistReference","attrs":{"occurrenceId":"ae50117f-eeb7-442c-b7d8-59f580e8d442","artistId":"76c3c113-eea0-4dbd-8e71-c7dc6662c86c","displayText":"Yovanny Polanco"}},{"type":"text","text":", a quien después describió como un padre para él. También pasó por "},{"type":"artistReference","attrs":{"occurrenceId":"1749856e-dcf0-4cce-a4e0-6d1d151f8f63","artistId":"d133f2df-cb21-4dd4-8673-8efb63e6cc5d","displayText":"Banda Real"}},{"type":"text","text":", que llama su “universidad” y donde grabó «Perdido sin ti», tema del que además es autor. Su apodo viene de su abuelo, a quien llamaban igual."}]},{"type":"paragraph","content":[{"type":"text","text":"Un proyecto en solitario","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cuando "},{"type":"artistReference","attrs":{"occurrenceId":"9922b92e-060e-4c32-822e-39ba9f29490f","artistId":"76c3c113-eea0-4dbd-8e71-c7dc6662c86c","displayText":"Yovanny Polanco"}},{"type":"text","text":" anunció un descanso de los escenarios poco antes de la pandemia, El Blachy siguió por su cuenta. Tras una gira de 2020 con incursión en la balada, «En Romantiqueo Tours», presentó en diciembre de 2020 su propia agrupación típica, «El Blachy y su Romantiqueo Típico», debutando con una versión en típico de «La Nochecita», canción de Lenier y El Micha con Jacob Forever, con arreglos de Israel Almonte."}]},{"type":"paragraph","content":[{"type":"text","text":"«Hola perdida» y el Soberano","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su despegue llegó con una versión en merengue típico de «Hola perdida», tema del artista argentino Luck Ra, después de que un sencillo anterior, «A qué vuelves», pasara casi inadvertido. También llevó a típico «Sobrio», de Maluma, y grabó «Pa’ Perderte» con "},{"type":"artistReference","attrs":{"occurrenceId":"5554ab02-62e4-4692-a263-0eb7a472d29e","artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz"}},{"type":"text","text":". En los Premios Soberano de marzo de 2024 ganó Conjunto Típico, según se reportó entonces frente a "},{"type":"artistReference","attrs":{"occurrenceId":"2eac9003-3a07-4b70-94a1-ad0a023d72f2","artistId":"76c3c113-eea0-4dbd-8e71-c7dc6662c86c","displayText":"Yovanny Polanco"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"15c33702-4858-44ef-bb74-7a5cafcdfc26","artistId":"15c08a48-b94b-41c8-99d8-53144397c787","displayText":"Krisspy"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"870b363d-56d8-49d0-b63b-67d46d6ad709","artistId":"d133f2df-cb21-4dd4-8673-8efb63e6cc5d","displayText":"Banda Real"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"094ed886-3bd3-421f-b13c-5af69573fd4e","artistId":"f07fcc6b-a888-4e97-ac50-6ce6ea37a714","displayText":"El Prodigio"}},{"type":"text","text":"; volvió a ganar la categoría en 2025. Ha dicho que mantiene sus letras limpias porque entre su público hay niños."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A finales de 2024 El Blachy tenía agendadas unas cuarenta fiestas en noviembre y sesenta en diciembre, y había anunciado colaboraciones con "},{"type":"artistReference","attrs":{"occurrenceId":"2e5292d5-2040-4be3-8295-dc497cf4f80b","artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"22641f80-98ff-47bf-a45d-84ee00cb0e40","artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47"}},{"type":"text","text":". En agosto de 2026 llenó el Coca-Cola Music Hall de Puerto Rico, parte de una serie de fechas internacionales que incluye una gira por Estados Unidos."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'el-blachy';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '388c3ced-0171-4bbf-b2ff-845d872ce286', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'ae50117f-eeb7-442c-b7d8-59f580e8d442', 'artist', '76c3c113-eea0-4dbd-8e71-c7dc6662c86c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '1749856e-dcf0-4cce-a4e0-6d1d151f8f63', 'artist', 'd133f2df-cb21-4dd4-8673-8efb63e6cc5d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '9922b92e-060e-4c32-822e-39ba9f29490f', 'artist', '76c3c113-eea0-4dbd-8e71-c7dc6662c86c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '5554ab02-62e4-4692-a263-0eb7a472d29e', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '2eac9003-3a07-4b70-94a1-ad0a023d72f2', 'artist', '76c3c113-eea0-4dbd-8e71-c7dc6662c86c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '15c33702-4858-44ef-bb74-7a5cafcdfc26', 'artist', '15c08a48-b94b-41c8-99d8-53144397c787' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '870b363d-56d8-49d0-b63b-67d46d6ad709', 'artist', 'd133f2df-cb21-4dd4-8673-8efb63e6cc5d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '094ed886-3bd3-421f-b13c-5af69573fd4e', 'artist', 'f07fcc6b-a888-4e97-ac50-6ce6ea37a714' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '2e5292d5-2040-4be3-8295-dc497cf4f80b', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '22641f80-98ff-47bf-a45d-84ee00cb0e40', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'El Blachy —nacido Blas Darío Fragoso en Santo Domingo en 1981 y criado en Santiago de los Caballeros— es cantante y compositor dominicano de merengue típico que se convirtió en uno de los nombres principales del género en la década de 2020, ganando el Premio Soberano a Conjunto Típico en 2024 y 2025.

**Años en las grandes orquestas**

Empezó en la «Merengue Band», la orquesta del «Hotel Jaragua», donde estuvo un año, y luego pasó cinco años en la orquesta de Wilfrido Vargas y nueve con Yovanny Polanco, a quien después describió como un padre para él. También pasó por Banda Real, que llama su “universidad” y donde grabó «Perdido sin ti», tema del que además es autor. Su apodo viene de su abuelo, a quien llamaban igual.

**Un proyecto en solitario**

Cuando Yovanny Polanco anunció un descanso de los escenarios poco antes de la pandemia, El Blachy siguió por su cuenta. Tras una gira de 2020 con incursión en la balada, «En Romantiqueo Tours», presentó en diciembre de 2020 su propia agrupación típica, «El Blachy y su Romantiqueo Típico», debutando con una versión en típico de «La Nochecita», canción de Lenier y El Micha con Jacob Forever, con arreglos de Israel Almonte.

**«Hola perdida» y el Soberano**

Su despegue llegó con una versión en merengue típico de «Hola perdida», tema del artista argentino Luck Ra, después de que un sencillo anterior, «A qué vuelves», pasara casi inadvertido. También llevó a típico «Sobrio», de Maluma, y grabó «Pa’ Perderte» con Manny Cruz. En los Premios Soberano de marzo de 2024 ganó Conjunto Típico, según se reportó entonces frente a Yovanny Polanco, Krisspy, Banda Real y El Prodigio; volvió a ganar la categoría en 2025. Ha dicho que mantiene sus letras limpias porque entre su público hay niños.

**Legado**

A finales de 2024 El Blachy tenía agendadas unas cuarenta fiestas en noviembre y sesenta en diciembre, y había anunciado colaboraciones con Chimbala y Bulin 47. En agosto de 2026 llenó el Coca-Cola Music Hall de Puerto Rico, parte de una serie de fechas internacionales que incluye una gira por Estados Unidos.' WHERE slug = 'el-blachy';

COMMIT;
