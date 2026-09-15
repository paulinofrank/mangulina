BEGIN;

-- Ficha de DJ Adoni.
--
-- La biografía de relleno lo describía en términos genéricos, sin nombrar un solo tema,
-- colaborador o premio. Seis premios registrados (dos nominaciones, cuatro victorias).

INSERT INTO awards (name) SELECT 'Lo Máximo Productions' WHERE NOT EXISTS (SELECT 1 FROM awards WHERE name = 'Lo Máximo Productions');

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'DJ del Año' FROM awards a WHERE a.name = 'Lo Máximo Productions'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'DJ del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2018, NULL, true, 'Wikipedia (es), con referencia'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'dj-adoni' AND a.name = 'Lo Máximo Productions' AND cat.name = 'DJ del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2018);

INSERT INTO awards (name) SELECT 'iHeartRadio Music Awards' WHERE NOT EXISTS (SELECT 1 FROM awards WHERE name = 'iHeartRadio Music Awards');

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Latin Pop/Reggaeton Song of the Year' FROM awards a WHERE a.name = 'iHeartRadio Music Awards'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Latin Pop/Reggaeton Song of the Year');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2021, 'El incomprendido (con Farruko y DJ Víctor Cárdenas)', false, 'Wikipedia (es), con referencia'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'dj-adoni' AND a.name = 'iHeartRadio Music Awards' AND cat.name = 'Latin Pop/Reggaeton Song of the Year'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2021);

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Latin Airplay Song of the Year' FROM awards a WHERE a.name = 'Billboard Latin Music Awards'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Latin Airplay Song of the Year');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2021, 'El incomprendido', false, 'Wikipedia (es), con referencia a Billboard'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'dj-adoni' AND a.name = 'Billboard Latin Music Awards' AND cat.name = 'Latin Airplay Song of the Year'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2021);

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2022, 'El incomprendido', true, 'Wikipedia (es), con referencia a Univision'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'dj-adoni' AND a.name = 'Premios Juventud' AND cat.name = 'La Mezcla Perfecta'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2022);

INSERT INTO awards (name) SELECT 'Premios Lo Nuestro' WHERE NOT EXISTS (SELECT 1 FROM awards WHERE name = 'Premios Lo Nuestro');

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'DJ del Año' FROM awards a WHERE a.name = 'Premios Lo Nuestro'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'DJ del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2022, NULL, true, 'Wikipedia (es), con referencia a Diario Libre'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'dj-adoni' AND a.name = 'Premios Lo Nuestro' AND cat.name = 'DJ del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2022);

INSERT INTO awards (name) SELECT 'Premios Latin Plug' WHERE NOT EXISTS (SELECT 1 FROM awards WHERE name = 'Premios Latin Plug');

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'DJ del Año' FROM awards a WHERE a.name = 'Premios Latin Plug'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'DJ del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2022, NULL, true, 'Wikipedia (es), con referencia a Diario Libre'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'dj-adoni' AND a.name = 'Premios Latin Plug' AND cat.name = 'DJ del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2022);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"DJ Adoni — Julio Adonis Gross, born 17 November 1994 in Santo Domingo Este — is a Dominican DJ, producer and singer who went from playing free sets in Los Mina to topping Billboard’s Latin Airplay chart."}]},{"type":"paragraph","content":[{"type":"text","text":"From Los Mina to a warehouse in North Carolina","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He grew up in Los Mina immersed in merengue, salsa, bachata and tropical music, and moved to the United States at sixteen, working factory and warehouse jobs in North Carolina while DJing for free at clubs and events to build a name. He turned that apprenticeship into steady work producing and releasing mixes across genres, and in 2018 Lo Máximo Productions named him DJ of the Year."}]},{"type":"paragraph","content":[{"type":"text","text":"«El incomprendido»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began releasing his own singles as an artist in the early 2020s and broke through in 2021 with «El incomprendido», a collaboration with the Puerto Rican reggaetonero Farruko and the DJ Víctor Cárdenas: it topped Billboard’s Latin Airplay chart, earned nominations at the Billboard Latin Music Awards and the iHeartRadio Music Awards, and won him the Premio Juventud for La Mezcla Perfecta."}]},{"type":"paragraph","content":[{"type":"text","text":"A run of collaborations","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The Farruko partnership continued through «Mi Romo (Remix)» (2021) and «La opinión es tuya» (2022, also featuring "},{"type":"artistReference","attrs":{"occurrenceId":"03872af5-24e5-40cf-986f-781b6e88ed8e","artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa"}},{"type":"text","text":"), while Adoni built a parallel run of dembow features: «Que me aconseje» with "},{"type":"artistReference","attrs":{"occurrenceId":"77df00db-3f08-45d9-9cb5-41c9a643fa42","artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala"}},{"type":"text","text":", «Gugle» with "},{"type":"artistReference","attrs":{"occurrenceId":"cce36d42-77b9-4788-b672-bfe86d82a8cf","artistId":"725f7cd5-de62-4e76-b382-0d55c160d51f","displayText":"Flow 28"}},{"type":"text","text":", «10 muchacho» with Chimbala and "},{"type":"artistReference","attrs":{"occurrenceId":"30aded13-3558-4d02-824a-95067bf83f61","artistId":"3455ed64-1860-47d5-bd2a-c6b86d0b513e","displayText":"El Rubio Acordeón"}},{"type":"text","text":", and «Pin Pon» with "},{"type":"artistReference","attrs":{"occurrenceId":"e2433c17-83a5-4d55-9988-ecb4d380d991","artistId":"71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb","displayText":"Rochy RD"}},{"type":"text","text":". In 2022 he appeared alongside "},{"type":"artistReference","attrs":{"occurrenceId":"fb501dd1-b60d-46f2-8237-dd1626060e48","artistId":"6302aca6-2203-456f-ad96-6bd2f26ee9b3","displayText":"Luis Miguel del Amargue"}},{"type":"text","text":" as a guest on "},{"type":"artistReference","attrs":{"occurrenceId":"40ebf0c3-8fe5-4c20-a72c-42c8a65f71e0","artistId":"8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3","displayText":"Romeo Santos"}},{"type":"text","text":"’s «La última vez», from «Fórmula, Vol. 3»."}]},{"type":"paragraph","content":[{"type":"text","text":"Awards and a stage of his own","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"That same year he was named DJ of the Year at both the Premios Lo Nuestro and the Premios Latin Plug, and performed live at the Premios Tu Música Urbano. A 2023 tour took him through the United States, Panama, the Dominican Republic and Puerto Rico, where his first headline concert sold out."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2024 he released «El Reemplazo» with "},{"type":"artistReference","attrs":{"occurrenceId":"1aa9ae4d-d99e-4c87-aade-f14bda63bb73","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":" and Darell, debuting it live at the Premios Juventud — a decade after leaving Los Mina for a warehouse in North Carolina, still building the same catalogue of features that got him started."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dj-adoni'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'dj-adoni' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '03872af5-24e5-40cf-986f-781b6e88ed8e', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '77df00db-3f08-45d9-9cb5-41c9a643fa42', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cce36d42-77b9-4788-b672-bfe86d82a8cf', 'artist', '725f7cd5-de62-4e76-b382-0d55c160d51f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '30aded13-3558-4d02-824a-95067bf83f61', 'artist', '3455ed64-1860-47d5-bd2a-c6b86d0b513e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e2433c17-83a5-4d55-9988-ecb4d380d991', 'artist', '71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'fb501dd1-b60d-46f2-8237-dd1626060e48', 'artist', '6302aca6-2203-456f-ad96-6bd2f26ee9b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '40ebf0c3-8fe5-4c20-a72c-42c8a65f71e0', 'artist', '8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1aa9ae4d-d99e-4c87-aade-f14bda63bb73', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'DJ Adoni — Julio Adonis Gross, born 17 November 1994 in Santo Domingo Este — is a Dominican DJ, producer and singer who went from playing free sets in Los Mina to topping Billboard’s Latin Airplay chart.

**From Los Mina to a warehouse in North Carolina**

He grew up in Los Mina immersed in merengue, salsa, bachata and tropical music, and moved to the United States at sixteen, working factory and warehouse jobs in North Carolina while DJing for free at clubs and events to build a name. He turned that apprenticeship into steady work producing and releasing mixes across genres, and in 2018 Lo Máximo Productions named him DJ of the Year.

**«El incomprendido»**

He began releasing his own singles as an artist in the early 2020s and broke through in 2021 with «El incomprendido», a collaboration with the Puerto Rican reggaetonero Farruko and the DJ Víctor Cárdenas: it topped Billboard’s Latin Airplay chart, earned nominations at the Billboard Latin Music Awards and the iHeartRadio Music Awards, and won him the Premio Juventud for La Mezcla Perfecta.

**A run of collaborations**

The Farruko partnership continued through «Mi Romo (Remix)» (2021) and «La opinión es tuya» (2022, also featuring El Alfa), while Adoni built a parallel run of dembow features: «Que me aconseje» with Chimbala, «Gugle» with Flow 28, «10 muchacho» with Chimbala and El Rubio Acordeón, and «Pin Pon» with Rochy RD. In 2022 he appeared alongside Luis Miguel del Amargue as a guest on Romeo Santos’s «La última vez», from «Fórmula, Vol. 3».

**Awards and a stage of his own**

That same year he was named DJ of the Year at both the Premios Lo Nuestro and the Premios Latin Plug, and performed live at the Premios Tu Música Urbano. A 2023 tour took him through the United States, Panama, the Dominican Republic and Puerto Rico, where his first headline concert sold out.

**Legacy**

In 2024 he released «El Reemplazo» with Prince Royce and Darell, debuting it live at the Premios Juventud — a decade after leaving Los Mina for a warehouse in North Carolina, still building the same catalogue of features that got him started.' WHERE slug = 'dj-adoni';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"DJ Adoni —Julio Adonis Gross, nacido el 17 de noviembre de 1994 en Santo Domingo Este— es DJ, productor y cantante dominicano que pasó de tocar gratis en Los Mina a encabezar la lista Latin Airplay de Billboard."}]},{"type":"paragraph","content":[{"type":"text","text":"De Los Mina a un almacén en Carolina del Norte","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Creció en Los Mina, inmerso en el merengue, la salsa, la bachata y la música tropical, y se mudó a Estados Unidos a los dieciséis años, trabajando en fábricas y almacenes en Carolina del Norte mientras pinchaba gratis en discotecas y eventos para hacerse un nombre. Convirtió ese aprendizaje en trabajo constante produciendo y publicando mezclas de varios géneros, y en 2018 Lo Máximo Productions lo nombró DJ del Año."}]},{"type":"paragraph","content":[{"type":"text","text":"«El incomprendido»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó a publicar sencillos propios como artista a inicios de la década de 2020 y dio el golpe en 2021 con «El incomprendido», colaboración con el reguetonero puertorriqueño Farruko y el DJ Víctor Cárdenas: encabezó la lista Latin Airplay de Billboard, consiguió nominaciones en los Billboard Latin Music Awards y en los iHeartRadio Music Awards, y le ganó el Premio Juventud a La Mezcla Perfecta."}]},{"type":"paragraph","content":[{"type":"text","text":"Una racha de colaboraciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La sociedad con Farruko siguió con «Mi Romo (Remix)» (2021) y «La opinión es tuya» (2022, con "},{"type":"artistReference","attrs":{"occurrenceId":"9059bcbd-d035-4693-98ce-5c06fa18a989","artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa"}},{"type":"text","text":" también en el tema), mientras Adoni armaba en paralelo una racha de temas de dembow: «Que me aconseje» con "},{"type":"artistReference","attrs":{"occurrenceId":"ffbeb0bc-4f55-480f-b877-4c58417e44d9","artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala"}},{"type":"text","text":", «Gugle» con "},{"type":"artistReference","attrs":{"occurrenceId":"3e2661fa-2c88-4320-b35c-29dbc54cd07f","artistId":"725f7cd5-de62-4e76-b382-0d55c160d51f","displayText":"Flow 28"}},{"type":"text","text":", «10 muchacho» con Chimbala y "},{"type":"artistReference","attrs":{"occurrenceId":"479a3783-82ad-4a7d-a071-383d553215e9","artistId":"3455ed64-1860-47d5-bd2a-c6b86d0b513e","displayText":"El Rubio Acordeón"}},{"type":"text","text":", y «Pin Pon» con "},{"type":"artistReference","attrs":{"occurrenceId":"9928c977-a8aa-4b06-ad7c-6758460052ae","artistId":"71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb","displayText":"Rochy RD"}},{"type":"text","text":". En 2022 apareció junto a "},{"type":"artistReference","attrs":{"occurrenceId":"0f26742e-5333-4273-baa4-de3726cb886c","artistId":"6302aca6-2203-456f-ad96-6bd2f26ee9b3","displayText":"Luis Miguel del Amargue"}},{"type":"text","text":" como invitado en «La última vez», de "},{"type":"artistReference","attrs":{"occurrenceId":"f65ad874-2bdf-47ff-b28c-e090172abeae","artistId":"8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3","displayText":"Romeo Santos"}},{"type":"text","text":", del disco «Fórmula, Vol. 3»."}]},{"type":"paragraph","content":[{"type":"text","text":"Premios y tarima propia","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ese mismo año fue nombrado DJ del Año en los Premios Lo Nuestro y en los Premios Latin Plug, y se presentó en vivo en los Premios Tu Música Urbano. Una gira de 2023 lo llevó por Estados Unidos, Panamá, República Dominicana y Puerto Rico, donde su primer concierto como cabeza de cartel agotó boletas."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2024 sacó «El Reemplazo» con "},{"type":"artistReference","attrs":{"occurrenceId":"6a558ab1-0f85-4ff8-a584-9526733622f4","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":" y Darell, estrenándolo en vivo en los Premios Juventud —una década después de dejar Los Mina por un almacén en Carolina del Norte, todavía armando el mismo catálogo de colaboraciones con el que empezó."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dj-adoni'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'dj-adoni' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9059bcbd-d035-4693-98ce-5c06fa18a989', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ffbeb0bc-4f55-480f-b877-4c58417e44d9', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3e2661fa-2c88-4320-b35c-29dbc54cd07f', 'artist', '725f7cd5-de62-4e76-b382-0d55c160d51f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '479a3783-82ad-4a7d-a071-383d553215e9', 'artist', '3455ed64-1860-47d5-bd2a-c6b86d0b513e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9928c977-a8aa-4b06-ad7c-6758460052ae', 'artist', '71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0f26742e-5333-4273-baa4-de3726cb886c', 'artist', '6302aca6-2203-456f-ad96-6bd2f26ee9b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f65ad874-2bdf-47ff-b28c-e090172abeae', 'artist', '8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6a558ab1-0f85-4ff8-a584-9526733622f4', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dj-adoni' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'DJ Adoni —Julio Adonis Gross, nacido el 17 de noviembre de 1994 en Santo Domingo Este— es DJ, productor y cantante dominicano que pasó de tocar gratis en Los Mina a encabezar la lista Latin Airplay de Billboard.

**De Los Mina a un almacén en Carolina del Norte**

Creció en Los Mina, inmerso en el merengue, la salsa, la bachata y la música tropical, y se mudó a Estados Unidos a los dieciséis años, trabajando en fábricas y almacenes en Carolina del Norte mientras pinchaba gratis en discotecas y eventos para hacerse un nombre. Convirtió ese aprendizaje en trabajo constante produciendo y publicando mezclas de varios géneros, y en 2018 Lo Máximo Productions lo nombró DJ del Año.

**«El incomprendido»**

Empezó a publicar sencillos propios como artista a inicios de la década de 2020 y dio el golpe en 2021 con «El incomprendido», colaboración con el reguetonero puertorriqueño Farruko y el DJ Víctor Cárdenas: encabezó la lista Latin Airplay de Billboard, consiguió nominaciones en los Billboard Latin Music Awards y en los iHeartRadio Music Awards, y le ganó el Premio Juventud a La Mezcla Perfecta.

**Una racha de colaboraciones**

La sociedad con Farruko siguió con «Mi Romo (Remix)» (2021) y «La opinión es tuya» (2022, con El Alfa también en el tema), mientras Adoni armaba en paralelo una racha de temas de dembow: «Que me aconseje» con Chimbala, «Gugle» con Flow 28, «10 muchacho» con Chimbala y El Rubio Acordeón, y «Pin Pon» con Rochy RD. En 2022 apareció junto a Luis Miguel del Amargue como invitado en «La última vez», de Romeo Santos, del disco «Fórmula, Vol. 3».

**Premios y tarima propia**

Ese mismo año fue nombrado DJ del Año en los Premios Lo Nuestro y en los Premios Latin Plug, y se presentó en vivo en los Premios Tu Música Urbano. Una gira de 2023 lo llevó por Estados Unidos, Panamá, República Dominicana y Puerto Rico, donde su primer concierto como cabeza de cartel agotó boletas.

**Legado**

En 2024 sacó «El Reemplazo» con Prince Royce y Darell, estrenándolo en vivo en los Premios Juventud —una década después de dejar Los Mina por un almacén en Carolina del Norte, todavía armando el mismo catálogo de colaboraciones con el que empezó.' WHERE slug = 'dj-adoni';

COMMIT;
