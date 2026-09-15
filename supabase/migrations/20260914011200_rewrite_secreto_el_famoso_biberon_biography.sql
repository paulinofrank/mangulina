BEGIN;

-- Ficha de Secreto "El Famoso Biberón". Sin cambios de campos.
--
-- Nacimiento: la fila dice 10 nov 1987; MAE Music Group y BuenaMusica (mismo texto)
-- dicen 4 nov 1987; musica.com, 4 dic 1987. Listín Diario (20 jul 2010) le da 22
-- años, compatible con cualquiera de las tres. Sin cambio; anotado.
-- Fuera: caso judicial de 2018, operación de cuerdas vocales (salud), vida familiar.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Secreto «El Famoso Biberón» — Odalis Pérez, born in Santo Domingo in 1987 and raised in the barrio of La Ciénaga — is a Dominican rapper and dembow artist. He made his name around 2010 with «Toy quillao», an aggressive street rap written, as he put it, to let off steam, and within a decade the press was describing him as one of the pillars of Dominican urban music."}]},{"type":"paragraph","content":[{"type":"text","text":"La Ciénaga","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Music ran in the family: his father, Olivo Pérez, was a bachata singer and his brother Alexander a mambo artist. What began, in his words, as a joke got him into trouble at home, where his mother waited up for him to come back from rapping and wanted him to finish secondary school. His lyrics took their subjects from what he saw around him — the street, money, sex, the feuds between rappers — and did not spare the swearing."}]},{"type":"paragraph","content":[{"type":"text","text":"Yakuza Records","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In July 2010, at twenty-two, he was working with a second voice, Lolo Jey, and DJ Johnny, and preparing a first album of some twenty songs for «Yakuza Records», among them «Toy quillao», «Me tienen para», «Paqueteros» and «Pa’ que te dé». He later credited the label with trusting him at a time when getting into a professional studio was hard. «Toy quillao» became his first hit as a solo artist, played in the barrios and in the clubs alike."}]},{"type":"paragraph","content":[{"type":"text","text":"A reference for newcomers","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Being brought onto one of his records came to count as promotion in itself. His «La vuelta», which also featured "},{"type":"artistReference","attrs":{"occurrenceId":"ba69e49c-ba1a-4e9d-9805-3c7e7e2ea496","artistId":"270ba4bb-287a-401d-b672-818fbe9477d3","displayText":"Nino Freestyle"}},{"type":"text","text":", was the record that first took "},{"type":"artistReference","attrs":{"occurrenceId":"22e53395-012a-4d14-830a-1327e0b8b3de","artistId":"fd3c8182-ba3a-4b0d-9c19-e7dfaa1658fb","displayText":"El Fecho RD"}},{"type":"text","text":" beyond his home scene; he recorded «Envidioso» with "},{"type":"artistReference","attrs":{"occurrenceId":"236070ea-dc73-4404-beeb-a8131f51e2d3","artistId":"518354a4-7cb9-4c39-a2b8-9fa4d18f50db","displayText":"El Mayor Clásico"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"50fd647d-fa54-49b7-9bf7-9695c35dfb45","artistId":"741eb4c0-4ab8-4ad5-8a64-2f156da6a395","displayText":"Ceky Viciny"}},{"type":"text","text":" and Bulova, and has worked with "},{"type":"artistReference","attrs":{"occurrenceId":"7219e7de-c59e-4aac-bcc3-ec598738a290","artistId":"350e5535-5229-4d49-903e-a5de047e7723","displayText":"Cromo X"}},{"type":"text","text":". In 2018, touring Europe, he released «Real guerrero», which passed eight million YouTube views in two weeks, and said he wanted his songs to carry messages of self-improvement as well as the party sound of the clubs."}]},{"type":"paragraph","content":[{"type":"text","text":"Recent years","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His most played songs now include «Trucha», recorded with "},{"type":"artistReference","attrs":{"occurrenceId":"37d25bbe-73cf-43b4-adeb-ab8d16ebfedc","artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala"}},{"type":"text","text":", Chucky73 and El Fother, and «Papá Dios me dijo». In 2026 he guested on «El Jaguar», the album by "},{"type":"artistReference","attrs":{"occurrenceId":"054c4f48-0ad7-4163-9723-18b4b4c522c0","artistId":"97610f30-fb92-4d77-8b98-ddec14d12afc","displayText":"Musicólogo the Libro"}},{"type":"text","text":", and released the single «Rata»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Secreto belongs to the generation of rappers from the poor neighbourhoods of Santo Domingo who turned their surroundings into the raw material of dembow. His motto, he says, is that unity is strength, and he has recorded with many of the younger artists who came up after him."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'secreto-el-famoso-biberon'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ba69e49c-ba1a-4e9d-9805-3c7e7e2ea496', 'artist', '270ba4bb-287a-401d-b672-818fbe9477d3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '22e53395-012a-4d14-830a-1327e0b8b3de', 'artist', 'fd3c8182-ba3a-4b0d-9c19-e7dfaa1658fb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '236070ea-dc73-4404-beeb-a8131f51e2d3', 'artist', '518354a4-7cb9-4c39-a2b8-9fa4d18f50db' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '50fd647d-fa54-49b7-9bf7-9695c35dfb45', 'artist', '741eb4c0-4ab8-4ad5-8a64-2f156da6a395' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7219e7de-c59e-4aac-bcc3-ec598738a290', 'artist', '350e5535-5229-4d49-903e-a5de047e7723' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '37d25bbe-73cf-43b4-adeb-ab8d16ebfedc', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '054c4f48-0ad7-4163-9723-18b4b4c522c0', 'artist', '97610f30-fb92-4d77-8b98-ddec14d12afc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Secreto «El Famoso Biberón» — Odalis Pérez, born in Santo Domingo in 1987 and raised in the barrio of La Ciénaga — is a Dominican rapper and dembow artist. He made his name around 2010 with «Toy quillao», an aggressive street rap written, as he put it, to let off steam, and within a decade the press was describing him as one of the pillars of Dominican urban music.

**La Ciénaga**

Music ran in the family: his father, Olivo Pérez, was a bachata singer and his brother Alexander a mambo artist. What began, in his words, as a joke got him into trouble at home, where his mother waited up for him to come back from rapping and wanted him to finish secondary school. His lyrics took their subjects from what he saw around him — the street, money, sex, the feuds between rappers — and did not spare the swearing.

**Yakuza Records**

In July 2010, at twenty-two, he was working with a second voice, Lolo Jey, and DJ Johnny, and preparing a first album of some twenty songs for «Yakuza Records», among them «Toy quillao», «Me tienen para», «Paqueteros» and «Pa’ que te dé». He later credited the label with trusting him at a time when getting into a professional studio was hard. «Toy quillao» became his first hit as a solo artist, played in the barrios and in the clubs alike.

**A reference for newcomers**

Being brought onto one of his records came to count as promotion in itself. His «La vuelta», which also featured Nino Freestyle, was the record that first took El Fecho RD beyond his home scene; he recorded «Envidioso» with El Mayor Clásico, Ceky Viciny and Bulova, and has worked with Cromo X. In 2018, touring Europe, he released «Real guerrero», which passed eight million YouTube views in two weeks, and said he wanted his songs to carry messages of self-improvement as well as the party sound of the clubs.

**Recent years**

His most played songs now include «Trucha», recorded with Chimbala, Chucky73 and El Fother, and «Papá Dios me dijo». In 2026 he guested on «El Jaguar», the album by Musicólogo the Libro, and released the single «Rata».

**Legacy**

Secreto belongs to the generation of rappers from the poor neighbourhoods of Santo Domingo who turned their surroundings into the raw material of dembow. His motto, he says, is that unity is strength, and he has recorded with many of the younger artists who came up after him.' WHERE slug = 'secreto-el-famoso-biberon';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Secreto «El Famoso Biberón» —Odalis Pérez, nacido en Santo Domingo en 1987 y criado en el barrio de La Ciénaga— es rapero y exponente del dembow dominicano. Se dio a conocer hacia 2010 con «Toy quillao», un rap callejero y agresivo que él mismo describía como su desahogo, y en menos de una década la prensa ya lo contaba entre los pilares de la música urbana del país."}]},{"type":"paragraph","content":[{"type":"text","text":"La Ciénaga","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La música venía de familia: su padre, Olivo Pérez, era bachatero, y su hermano Alexander, mambero. Lo que empezó, según cuenta, como un relajo le trajo problemas en casa, donde su madre lo esperaba despierta cuando volvía de rapear y quería que terminara el bachillerato. Sus letras tomaban los temas de lo que veía alrededor —la calle, el dinero, el sexo, las tiraeras— y no se ahorraban las malas palabras."}]},{"type":"paragraph","content":[{"type":"text","text":"Yakuza Records","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En julio de 2010, con veintidós años, trabajaba con una segunda voz, Lolo Jey, y con DJ Johnny, y preparaba un primer disco de unos veinte temas para «Yakuza Records», entre ellos «Toy quillao», «Me tienen para», «Paqueteros» y «Pa’ que te dé». Años después le agradeció al sello haber confiado en él cuando entrar a un estudio profesional era difícil. «Toy quillao» fue su primer éxito como solista y sonó por igual en los barrios y en las discotecas."}]},{"type":"paragraph","content":[{"type":"text","text":"Referencia para los nuevos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Que Secreto te llamara a uno de sus discos llegó a valer como promoción. Su «La vuelta», en la que también participó "},{"type":"artistReference","attrs":{"occurrenceId":"df49a1d9-c35d-4472-9578-19b31118a156","artistId":"270ba4bb-287a-401d-b672-818fbe9477d3","displayText":"Nino Freestyle"}},{"type":"text","text":", fue el disco que sacó por primera vez a "},{"type":"artistReference","attrs":{"occurrenceId":"1fa158a6-dc3f-4d36-a34f-fa76209a4fe4","artistId":"fd3c8182-ba3a-4b0d-9c19-e7dfaa1658fb","displayText":"El Fecho RD"}},{"type":"text","text":" de su circuito; grabó «Envidioso» con "},{"type":"artistReference","attrs":{"occurrenceId":"aec8fc18-2d11-4a31-8602-2d85e59e8b88","artistId":"518354a4-7cb9-4c39-a2b8-9fa4d18f50db","displayText":"El Mayor Clásico"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"323fb7b0-9dc7-47ba-9f94-570b1b74c2fb","artistId":"741eb4c0-4ab8-4ad5-8a64-2f156da6a395","displayText":"Ceky Viciny"}},{"type":"text","text":" y Bulova, y ha trabajado con "},{"type":"artistReference","attrs":{"occurrenceId":"53be2b25-e3bc-4ba8-9449-72193da9b005","artistId":"350e5535-5229-4d49-903e-a5de047e7723","displayText":"Cromo X"}},{"type":"text","text":". En 2018, de gira por Europa, lanzó «Real guerrero», que pasó de ocho millones de vistas en YouTube en dos semanas, y dijo que quería que sus canciones llevaran mensajes de superación además del sonido de fiesta de las discotecas."}]},{"type":"paragraph","content":[{"type":"text","text":"Los últimos años","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Entre sus canciones más escuchadas están hoy «Trucha», grabada con "},{"type":"artistReference","attrs":{"occurrenceId":"6b9bdcff-971b-4e20-90f5-1a6e46bb2cfa","artistId":"cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b","displayText":"Chimbala"}},{"type":"text","text":", Chucky73 y El Fother, y «Papá Dios me dijo». En 2026 participó en «El Jaguar», el disco de "},{"type":"artistReference","attrs":{"occurrenceId":"e84e3c7b-52dd-429c-9a9f-184355d74801","artistId":"97610f30-fb92-4d77-8b98-ddec14d12afc","displayText":"Musicólogo the Libro"}},{"type":"text","text":", y lanzó el sencillo «Rata»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Secreto pertenece a la generación de raperos de los barrios pobres de Santo Domingo que convirtió su entorno en la materia prima del dembow. Su lema, dice, es que en la unión está la fuerza, y ha grabado con muchos de los artistas jóvenes que vinieron después de él."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'secreto-el-famoso-biberon'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'df49a1d9-c35d-4472-9578-19b31118a156', 'artist', '270ba4bb-287a-401d-b672-818fbe9477d3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1fa158a6-dc3f-4d36-a34f-fa76209a4fe4', 'artist', 'fd3c8182-ba3a-4b0d-9c19-e7dfaa1658fb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'aec8fc18-2d11-4a31-8602-2d85e59e8b88', 'artist', '518354a4-7cb9-4c39-a2b8-9fa4d18f50db' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '323fb7b0-9dc7-47ba-9f94-570b1b74c2fb', 'artist', '741eb4c0-4ab8-4ad5-8a64-2f156da6a395' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '53be2b25-e3bc-4ba8-9449-72193da9b005', 'artist', '350e5535-5229-4d49-903e-a5de047e7723' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6b9bdcff-971b-4e20-90f5-1a6e46bb2cfa', 'artist', 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e84e3c7b-52dd-429c-9a9f-184355d74801', 'artist', '97610f30-fb92-4d77-8b98-ddec14d12afc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'secreto-el-famoso-biberon' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Secreto «El Famoso Biberón» —Odalis Pérez, nacido en Santo Domingo en 1987 y criado en el barrio de La Ciénaga— es rapero y exponente del dembow dominicano. Se dio a conocer hacia 2010 con «Toy quillao», un rap callejero y agresivo que él mismo describía como su desahogo, y en menos de una década la prensa ya lo contaba entre los pilares de la música urbana del país.

**La Ciénaga**

La música venía de familia: su padre, Olivo Pérez, era bachatero, y su hermano Alexander, mambero. Lo que empezó, según cuenta, como un relajo le trajo problemas en casa, donde su madre lo esperaba despierta cuando volvía de rapear y quería que terminara el bachillerato. Sus letras tomaban los temas de lo que veía alrededor —la calle, el dinero, el sexo, las tiraeras— y no se ahorraban las malas palabras.

**Yakuza Records**

En julio de 2010, con veintidós años, trabajaba con una segunda voz, Lolo Jey, y con DJ Johnny, y preparaba un primer disco de unos veinte temas para «Yakuza Records», entre ellos «Toy quillao», «Me tienen para», «Paqueteros» y «Pa’ que te dé». Años después le agradeció al sello haber confiado en él cuando entrar a un estudio profesional era difícil. «Toy quillao» fue su primer éxito como solista y sonó por igual en los barrios y en las discotecas.

**Referencia para los nuevos**

Que Secreto te llamara a uno de sus discos llegó a valer como promoción. Su «La vuelta», en la que también participó Nino Freestyle, fue el disco que sacó por primera vez a El Fecho RD de su circuito; grabó «Envidioso» con El Mayor Clásico, Ceky Viciny y Bulova, y ha trabajado con Cromo X. En 2018, de gira por Europa, lanzó «Real guerrero», que pasó de ocho millones de vistas en YouTube en dos semanas, y dijo que quería que sus canciones llevaran mensajes de superación además del sonido de fiesta de las discotecas.

**Los últimos años**

Entre sus canciones más escuchadas están hoy «Trucha», grabada con Chimbala, Chucky73 y El Fother, y «Papá Dios me dijo». En 2026 participó en «El Jaguar», el disco de Musicólogo the Libro, y lanzó el sencillo «Rata».

**Legado**

Secreto pertenece a la generación de raperos de los barrios pobres de Santo Domingo que convirtió su entorno en la materia prima del dembow. Su lema, dice, es que en la unión está la fuerza, y ha grabado con muchos de los artistas jóvenes que vinieron después de él.' WHERE slug = 'secreto-el-famoso-biberon';

COMMIT;
