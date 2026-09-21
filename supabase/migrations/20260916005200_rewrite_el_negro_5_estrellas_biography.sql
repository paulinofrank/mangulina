BEGIN;

-- Ficha de El Negro 5 Estrellas: de Santiago de los Caballeros (el relleno decía Santo Domingo), merengue urbano.
-- middle_name Alberto, primary_genre merengue con genres merengue-urbano, canal de YouTube @Negro5Estrellas.

UPDATE artists SET middle_name = 'Alberto', primary_genre = 'merengue', genres = ARRAY['merengue-urbano']::text[], youtube = '@Negro5Estrellas'
       WHERE slug = 'el-negro-5-estrellas';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"El Negro 5 Estrellas —Luis González, from Santiago de los Caballeros— is a Dominican singer and composer of merengue urbano, the street-oriented current of merengue that is also called merengue de calle or mambo, and has been active since 2010."}]},{"type":"paragraph","content":[{"type":"text","text":"«Plomo, plomo»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His breakthrough was «Plomo, plomo», released in September 2010. It gained notice at the Santiago basketball championship, where fans sang it whenever their team was winning, and it became a hit in the city; a video for it appeared on the label «Sunflower Entertainment». When the press profiled him that August he said the success had filled his week with bookings and surprised him. His first album already had songs ready, among them «Ella ta», «María va a la disco», «La vieja» and «A cualquiera le damos luz»."}]},{"type":"paragraph","content":[{"type":"text","text":"Early recognition","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The 2010 edition of the Esendom awards, a poll decided by the votes of its readers and of the magazine Esendom itself, nominated him for Revelación del Año, which went to Prince Royce, named «Plomo, plomo» its Merengue of the Year and shortlisted it for Song of the Year."}]},{"type":"paragraph","content":[{"type":"text","text":"Albums and collaborations","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Later releases listed on a music directory include «Cómo Tú» (2016) and, in 2017, «Si Lo Mete No Lo Saca», «Hagamos el Amor Con la Ropa» and «Pa la Calle». He appears on «Rulay», a group track with Sujeto, Químico, "},{"type":"artistReference","attrs":{"occurrenceId":"9c623f6c-0481-470c-8ff9-13f8cdb6c623","artistId":"9be0ed08-6eb6-4ca0-bb68-d5126190aeb1","displayText":"Kiko el Crazy"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"ad743690-8d38-4cc3-b8ba-90d7edc80946","artistId":"95e181f1-58e5-4537-a5e8-75a9f60c6aca","displayText":"Tivi Gunz"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"001a6a0f-3a10-4a68-9e49-6fdf6c3f890a","artistId":"b3841446-0bdb-48f5-9ace-b492db7d9be2","displayText":"Shadow Blow"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"df1366b4-7526-4428-9e34-7eb6558a3471","artistId":"2993cde1-f93d-4cf0-9668-fa1e54b09919","displayText":"Haraca Kiko"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A 2020 survey of new Dominican music by Radio Gladys Palmera placed him in the merengue and mambo scene of the street, alongside "},{"type":"artistReference","attrs":{"occurrenceId":"8508b036-e898-40ed-8d22-a839da7ed2f2","artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"7fab0b26-f321-47db-8340-f9070347b1e1","artistId":"6159dc70-bd8f-439d-bf17-5d690262e5cb","displayText":"Omega"}},{"type":"text","text":"."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'el-negro-5-estrellas'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '9c623f6c-0481-470c-8ff9-13f8cdb6c623', 'artist', '9be0ed08-6eb6-4ca0-bb68-d5126190aeb1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'ad743690-8d38-4cc3-b8ba-90d7edc80946', 'artist', '95e181f1-58e5-4537-a5e8-75a9f60c6aca' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '001a6a0f-3a10-4a68-9e49-6fdf6c3f890a', 'artist', 'b3841446-0bdb-48f5-9ace-b492db7d9be2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'df1366b4-7526-4428-9e34-7eb6558a3471', 'artist', '2993cde1-f93d-4cf0-9668-fa1e54b09919' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '8508b036-e898-40ed-8d22-a839da7ed2f2', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '7fab0b26-f321-47db-8340-f9070347b1e1', 'artist', '6159dc70-bd8f-439d-bf17-5d690262e5cb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'El Negro 5 Estrellas —Luis González, from Santiago de los Caballeros— is a Dominican singer and composer of merengue urbano, the street-oriented current of merengue that is also called merengue de calle or mambo, and has been active since 2010.

**«Plomo, plomo»**

His breakthrough was «Plomo, plomo», released in September 2010. It gained notice at the Santiago basketball championship, where fans sang it whenever their team was winning, and it became a hit in the city; a video for it appeared on the label «Sunflower Entertainment». When the press profiled him that August he said the success had filled his week with bookings and surprised him. His first album already had songs ready, among them «Ella ta», «María va a la disco», «La vieja» and «A cualquiera le damos luz».

**Early recognition**

The 2010 edition of the Esendom awards, a poll decided by the votes of its readers and of the magazine Esendom itself, nominated him for Revelación del Año, which went to Prince Royce, named «Plomo, plomo» its Merengue of the Year and shortlisted it for Song of the Year.

**Albums and collaborations**

Later releases listed on a music directory include «Cómo Tú» (2016) and, in 2017, «Si Lo Mete No Lo Saca», «Hagamos el Amor Con la Ropa» and «Pa la Calle». He appears on «Rulay», a group track with Sujeto, Químico, Kiko el Crazy, Tivi Gunz, Shadow Blow and Haraca Kiko.

**Legacy**

A 2020 survey of new Dominican music by Radio Gladys Palmera placed him in the merengue and mambo scene of the street, alongside El Alfa and Omega.' WHERE slug = 'el-negro-5-estrellas';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"El Negro 5 Estrellas —Luis González, de Santiago de los Caballeros— es un cantante y compositor dominicano de merengue urbano, la corriente callejera del merengue que también se llama merengue de calle o mambo, y está activo desde 2010."}]},{"type":"paragraph","content":[{"type":"text","text":"«Plomo, plomo»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su despegue fue «Plomo, plomo», lanzada en septiembre de 2010. Ganó notoriedad en el campeonato de baloncesto de Santiago, donde los fanáticos la cantaban cada vez que su equipo iba ganando, y se volvió un éxito en la ciudad; su video salió con el sello «Sunflower Entertainment». Cuando la prensa lo perfiló ese agosto contó que el éxito le había llenado la semana de contrataciones y lo había sorprendido. Su primer disco ya tenía canciones listas, entre ellas «Ella ta», «María va a la disco», «La vieja» y «A cualquiera le damos luz»."}]},{"type":"paragraph","content":[{"type":"text","text":"Primeros reconocimientos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La edición 2010 de los premios Esendom, una encuesta decidida por los votos de sus lectores y de la propia revista Esendom, lo nominó a Revelación del Año, que ganó Prince Royce, escogió «Plomo, plomo» como Merengue del Año y la incluyó entre las candidatas a Canción del Año."}]},{"type":"paragraph","content":[{"type":"text","text":"Discos y colaboraciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Entre sus lanzamientos posteriores que recoge un directorio musical están «Cómo Tú» (2016) y, en 2017, «Si Lo Mete No Lo Saca», «Hagamos el Amor Con la Ropa» y «Pa la Calle». Aparece en «Rulay», un tema colectivo con Sujeto, Químico, "},{"type":"artistReference","attrs":{"occurrenceId":"ecc9d85e-309e-41e9-a649-43042b754512","artistId":"9be0ed08-6eb6-4ca0-bb68-d5126190aeb1","displayText":"Kiko el Crazy"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"5dcfe845-dd3d-4cc8-a84d-934dfdd19407","artistId":"95e181f1-58e5-4537-a5e8-75a9f60c6aca","displayText":"Tivi Gunz"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"b4e0ad9b-c1ed-4721-bee9-732a72587c76","artistId":"b3841446-0bdb-48f5-9ace-b492db7d9be2","displayText":"Shadow Blow"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"1141eddd-2117-4c1e-94ef-4b0abab386d6","artistId":"2993cde1-f93d-4cf0-9668-fa1e54b09919","displayText":"Haraca Kiko"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Un repaso de 2020 sobre la nueva música dominicana, de Radio Gladys Palmera, lo ubicó en la escena del merengue y el mambo de la calle junto a "},{"type":"artistReference","attrs":{"occurrenceId":"3b341273-5b8d-4ba9-b468-97c3a75fbaf9","artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"f952371d-327f-47cf-8b95-6ab13a520e3d","artistId":"6159dc70-bd8f-439d-bf17-5d690262e5cb","displayText":"Omega"}},{"type":"text","text":"."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'el-negro-5-estrellas'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'ecc9d85e-309e-41e9-a649-43042b754512', 'artist', '9be0ed08-6eb6-4ca0-bb68-d5126190aeb1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '5dcfe845-dd3d-4cc8-a84d-934dfdd19407', 'artist', '95e181f1-58e5-4537-a5e8-75a9f60c6aca' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'b4e0ad9b-c1ed-4721-bee9-732a72587c76', 'artist', 'b3841446-0bdb-48f5-9ace-b492db7d9be2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '1141eddd-2117-4c1e-94ef-4b0abab386d6', 'artist', '2993cde1-f93d-4cf0-9668-fa1e54b09919' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '3b341273-5b8d-4ba9-b468-97c3a75fbaf9', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'f952371d-327f-47cf-8b95-6ab13a520e3d', 'artist', '6159dc70-bd8f-439d-bf17-5d690262e5cb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-negro-5-estrellas' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'El Negro 5 Estrellas —Luis González, de Santiago de los Caballeros— es un cantante y compositor dominicano de merengue urbano, la corriente callejera del merengue que también se llama merengue de calle o mambo, y está activo desde 2010.

**«Plomo, plomo»**

Su despegue fue «Plomo, plomo», lanzada en septiembre de 2010. Ganó notoriedad en el campeonato de baloncesto de Santiago, donde los fanáticos la cantaban cada vez que su equipo iba ganando, y se volvió un éxito en la ciudad; su video salió con el sello «Sunflower Entertainment». Cuando la prensa lo perfiló ese agosto contó que el éxito le había llenado la semana de contrataciones y lo había sorprendido. Su primer disco ya tenía canciones listas, entre ellas «Ella ta», «María va a la disco», «La vieja» y «A cualquiera le damos luz».

**Primeros reconocimientos**

La edición 2010 de los premios Esendom, una encuesta decidida por los votos de sus lectores y de la propia revista Esendom, lo nominó a Revelación del Año, que ganó Prince Royce, escogió «Plomo, plomo» como Merengue del Año y la incluyó entre las candidatas a Canción del Año.

**Discos y colaboraciones**

Entre sus lanzamientos posteriores que recoge un directorio musical están «Cómo Tú» (2016) y, en 2017, «Si Lo Mete No Lo Saca», «Hagamos el Amor Con la Ropa» y «Pa la Calle». Aparece en «Rulay», un tema colectivo con Sujeto, Químico, Kiko el Crazy, Tivi Gunz, Shadow Blow y Haraca Kiko.

**Legado**

Un repaso de 2020 sobre la nueva música dominicana, de Radio Gladys Palmera, lo ubicó en la escena del merengue y el mambo de la calle junto a El Alfa y Omega.' WHERE slug = 'el-negro-5-estrellas';

COMMIT;
