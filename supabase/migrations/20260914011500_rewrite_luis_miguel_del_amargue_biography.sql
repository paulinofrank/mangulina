BEGIN;

-- Ficha de Luis Miguel del Amargue.
--
-- last_name Fuentes -> Sisa: El Nacional (2009) da "Luis Miguel Sisa, nombre de pila";
-- Bachata Republic "Luis Miguel Sisa"; padres Manuela Paula y Santos A. Sisa en
-- Bachata Republic y BuenaMusica. second_last_name Paula ya estaba.
-- BuenaMusica lo llama "Robert Sisa Paula" en el texto: aislado, no usado.
--
-- Premios: Casandra Bachatero del Año 2010 y Soberano Bachatero del Año 2025.
-- BuenaMusica pone el Soberano en la "edición 2024": la prensa del 25 mar 2025
-- dice gala de 2025.

UPDATE artists SET last_name = 'Sisa' WHERE slug = 'luis-miguel-del-amargue';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2010, NULL, true, 'Hoy (7 jul 2011, "bachatero del Año de los Premios Casandra 2010"); merengala (2 may 2010); Bachata Republic'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'luis-miguel-del-amargue' AND a.name = 'Premios Casandra' AND cat.name = 'Bachatero del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2010);
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2025, NULL, true, 'El Caribe, El Nacional y El Nuevo Diario (25 mar 2025); gala del 24 mar 2025 en el Teatro Nacional; su primer Soberano (La Voz de la Noticia)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'luis-miguel-del-amargue' AND a.name = 'Premios Soberano' AND cat.name = 'Bachatero del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2025);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Luis Miguel del Amargue — Luis Miguel Sisa Paula, born in Azua on 12 March 1977 — is a Dominican bachata singer and songwriter. His album «Te echo de menos», released in Spain, made him the leading bachata name in Europe at a time when the genre was heard there mostly by Dominicans. At home he was named Bachatero del Año at the «Premios Casandra» in 2010 and, fifteen years later, at the «Premios Soberano»."}]},{"type":"paragraph","content":[{"type":"text","text":"Azua","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He is the second youngest of the eight children of Manuela Paula and Santos A. Sisa, a family of few means. He started singing at school at seven and, as a boy, entered voice contests in Azua and other towns of the south, winning the «Festival Regional del Sur». In the early 1990s he sang with a local group, «Los Auténticos del Sur», and in 1994 he went solo with «Entregado a ti», for the label «Shaira Records»."}]},{"type":"paragraph","content":[{"type":"text","text":"Bachata in Spain","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Luisa María» (1999) was the song that made his name. He had settled in Spain, and his next album, «Te echo de menos», released there, became his springboard abroad and earned gold and platinum records with «JM Records». When he arrived, he recalled in 2009, bachata in Spain was listened to only by Dominicans; his records caught on with Spaniards and spread across Europe, and he came to be called the king of bachata in Europe."}]},{"type":"paragraph","content":[{"type":"text","text":"«Casandra» and «Soberano»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Through the 2000s he released «Amor de locos», «Búscame», «De rodillas te pido» and «Mi regreso». In 2009 «Se acabó lo bonito» earned him nominations for Bachatero and Bachata del Año at the «Premios Casandra», and in 2010 he won Bachatero del Año. «Dispuesto a todo» followed in 2011, and later «Bachata sin límites» (2017) and «No me olvides» (2018). On 24 March 2025, at the Teatro Nacional, he received his first «Premios Soberano» award, again as Bachatero del Año."}]},{"type":"paragraph","content":[{"type":"text","text":"Recent work","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He has kept up a steady flow of singles, among them «El dueño del juego», a second volume of «De Azua pa’l mundo» and salsa versions of his hits such as «Devuélveme todo» (2025). In February 2025 he and "},{"type":"artistReference","attrs":{"occurrenceId":"c383b242-9783-4144-a030-905ea725d94f","artistId":"16a0162f-040a-427d-8bea-3a73a52afd0f","displayText":"Daniel Segura"}},{"type":"text","text":" released «Hoy», and he has also recorded with "},{"type":"artistReference","attrs":{"occurrenceId":"9036a65f-b31f-4a8a-a217-1bccac7b921a","artistId":"8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6","displayText":"El Chaval de la Bachata"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Luis Miguel del Amargue is one of the voices that took bachata to Spain before the genre’s international boom, and at home he remains a representative of traditional amargue — songs of heartbreak, spite and longing, sung with a powerful voice."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luis-miguel-del-amargue'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'luis-miguel-del-amargue' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c383b242-9783-4144-a030-905ea725d94f', 'artist', '16a0162f-040a-427d-8bea-3a73a52afd0f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luis-miguel-del-amargue' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9036a65f-b31f-4a8a-a217-1bccac7b921a', 'artist', '8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luis-miguel-del-amargue' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Luis Miguel del Amargue — Luis Miguel Sisa Paula, born in Azua on 12 March 1977 — is a Dominican bachata singer and songwriter. His album «Te echo de menos», released in Spain, made him the leading bachata name in Europe at a time when the genre was heard there mostly by Dominicans. At home he was named Bachatero del Año at the «Premios Casandra» in 2010 and, fifteen years later, at the «Premios Soberano».

**Azua**

He is the second youngest of the eight children of Manuela Paula and Santos A. Sisa, a family of few means. He started singing at school at seven and, as a boy, entered voice contests in Azua and other towns of the south, winning the «Festival Regional del Sur». In the early 1990s he sang with a local group, «Los Auténticos del Sur», and in 1994 he went solo with «Entregado a ti», for the label «Shaira Records».

**Bachata in Spain**

«Luisa María» (1999) was the song that made his name. He had settled in Spain, and his next album, «Te echo de menos», released there, became his springboard abroad and earned gold and platinum records with «JM Records». When he arrived, he recalled in 2009, bachata in Spain was listened to only by Dominicans; his records caught on with Spaniards and spread across Europe, and he came to be called the king of bachata in Europe.

**«Casandra» and «Soberano»**

Through the 2000s he released «Amor de locos», «Búscame», «De rodillas te pido» and «Mi regreso». In 2009 «Se acabó lo bonito» earned him nominations for Bachatero and Bachata del Año at the «Premios Casandra», and in 2010 he won Bachatero del Año. «Dispuesto a todo» followed in 2011, and later «Bachata sin límites» (2017) and «No me olvides» (2018). On 24 March 2025, at the Teatro Nacional, he received his first «Premios Soberano» award, again as Bachatero del Año.

**Recent work**

He has kept up a steady flow of singles, among them «El dueño del juego», a second volume of «De Azua pa’l mundo» and salsa versions of his hits such as «Devuélveme todo» (2025). In February 2025 he and Daniel Segura released «Hoy», and he has also recorded with El Chaval de la Bachata.

**Legacy**

Luis Miguel del Amargue is one of the voices that took bachata to Spain before the genre’s international boom, and at home he remains a representative of traditional amargue — songs of heartbreak, spite and longing, sung with a powerful voice.' WHERE slug = 'luis-miguel-del-amargue';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Luis Miguel del Amargue —Luis Miguel Sisa Paula, nacido en Azua el 12 de marzo de 1977— es cantante y compositor dominicano de bachata. Su disco «Te echo de menos», editado en España, lo convirtió en el nombre principal de la bachata en Europa cuando allí el género todavía lo escuchaban sobre todo los dominicanos. En el país fue Bachatero del Año en los «Premios Casandra» de 2010 y, quince años después, en los «Premios Soberano»."}]},{"type":"paragraph","content":[{"type":"text","text":"Azua","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Es el penúltimo de los ocho hijos de Manuela Paula y Santos A. Sisa, una familia de pocos recursos. Empezó a cantar en la escuela a los siete años y de muchacho se presentó en festivales de la voz en Azua y otros pueblos del sur, y ganó el «Festival Regional del Sur». A principios de los noventa cantó con un grupo local, «Los Auténticos del Sur», y en 1994 se lanzó como solista con «Entregado a ti», para el sello «Shaira Records»."}]},{"type":"paragraph","content":[{"type":"text","text":"La bachata en España","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Luisa María» (1999) fue la canción que lo dio a conocer. Ya se había establecido en España, y su siguiente producción, «Te echo de menos», editada allí, fue su trampolín internacional y le valió discos de oro y platino con «JM Records». Cuando llegó, contaba en 2009, la bachata en España solo la escuchaban los dominicanos; sus discos engancharon a los españoles y se extendieron por Europa, y le ganaron el apodo de rey de la bachata en Europa."}]},{"type":"paragraph","content":[{"type":"text","text":"«Casandra» y «Soberano»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Durante los años 2000 publicó «Amor de locos», «Búscame», «De rodillas te pido» y «Mi regreso». En 2009 «Se acabó lo bonito» le valió las nominaciones a Bachatero y Bachata del Año en los «Premios Casandra», y en 2010 ganó Bachatero del Año. Luego vinieron «Dispuesto a todo» (2011), «Bachata sin límites» (2017) y «No me olvides» (2018). El 24 de marzo de 2025, en el Teatro Nacional, recibió su primer premio de los «Premios Soberano», otra vez como Bachatero del Año."}]},{"type":"paragraph","content":[{"type":"text","text":"Trabajo reciente","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ha mantenido un flujo constante de sencillos, entre ellos «El dueño del juego», un segundo volumen de «De Azua pa’l mundo» y versiones en salsa de sus éxitos como «Devuélveme todo» (2025). En febrero de 2025 lanzó «Hoy» con "},{"type":"artistReference","attrs":{"occurrenceId":"69a2a579-c2e9-4d79-9f43-71dfa1e3a8e3","artistId":"16a0162f-040a-427d-8bea-3a73a52afd0f","displayText":"Daniel Segura"}},{"type":"text","text":", y ha grabado también con "},{"type":"artistReference","attrs":{"occurrenceId":"0dab1653-6131-41d4-91a4-d23df08bc118","artistId":"8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6","displayText":"El Chaval de la Bachata"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Luis Miguel del Amargue es una de las voces que llevaron la bachata a España antes del auge internacional del género, y en el país sigue representando el amargue tradicional: canciones de desamor, despecho y melancolía, con una voz potente."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luis-miguel-del-amargue'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'luis-miguel-del-amargue' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '69a2a579-c2e9-4d79-9f43-71dfa1e3a8e3', 'artist', '16a0162f-040a-427d-8bea-3a73a52afd0f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luis-miguel-del-amargue' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0dab1653-6131-41d4-91a4-d23df08bc118', 'artist', '8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luis-miguel-del-amargue' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Luis Miguel del Amargue —Luis Miguel Sisa Paula, nacido en Azua el 12 de marzo de 1977— es cantante y compositor dominicano de bachata. Su disco «Te echo de menos», editado en España, lo convirtió en el nombre principal de la bachata en Europa cuando allí el género todavía lo escuchaban sobre todo los dominicanos. En el país fue Bachatero del Año en los «Premios Casandra» de 2010 y, quince años después, en los «Premios Soberano».

**Azua**

Es el penúltimo de los ocho hijos de Manuela Paula y Santos A. Sisa, una familia de pocos recursos. Empezó a cantar en la escuela a los siete años y de muchacho se presentó en festivales de la voz en Azua y otros pueblos del sur, y ganó el «Festival Regional del Sur». A principios de los noventa cantó con un grupo local, «Los Auténticos del Sur», y en 1994 se lanzó como solista con «Entregado a ti», para el sello «Shaira Records».

**La bachata en España**

«Luisa María» (1999) fue la canción que lo dio a conocer. Ya se había establecido en España, y su siguiente producción, «Te echo de menos», editada allí, fue su trampolín internacional y le valió discos de oro y platino con «JM Records». Cuando llegó, contaba en 2009, la bachata en España solo la escuchaban los dominicanos; sus discos engancharon a los españoles y se extendieron por Europa, y le ganaron el apodo de rey de la bachata en Europa.

**«Casandra» y «Soberano»**

Durante los años 2000 publicó «Amor de locos», «Búscame», «De rodillas te pido» y «Mi regreso». En 2009 «Se acabó lo bonito» le valió las nominaciones a Bachatero y Bachata del Año en los «Premios Casandra», y en 2010 ganó Bachatero del Año. Luego vinieron «Dispuesto a todo» (2011), «Bachata sin límites» (2017) y «No me olvides» (2018). El 24 de marzo de 2025, en el Teatro Nacional, recibió su primer premio de los «Premios Soberano», otra vez como Bachatero del Año.

**Trabajo reciente**

Ha mantenido un flujo constante de sencillos, entre ellos «El dueño del juego», un segundo volumen de «De Azua pa’l mundo» y versiones en salsa de sus éxitos como «Devuélveme todo» (2025). En febrero de 2025 lanzó «Hoy» con Daniel Segura, y ha grabado también con El Chaval de la Bachata.

**Legado**

Luis Miguel del Amargue es una de las voces que llevaron la bachata a España antes del auge internacional del género, y en el país sigue representando el amargue tradicional: canciones de desamor, despecho y melancolía, con una voz potente.' WHERE slug = 'luis-miguel-del-amargue';

COMMIT;
