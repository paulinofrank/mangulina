BEGIN;

-- Ficha de Martín Valoy.
--
-- La biografía de relleno decía que cofundó Los Virtuosos: la fundó Cuco en 1975 y Martín tocó
-- el bajo en ella (Discogs, «Tiza!» 1980 y «Chévere» 1982). Su dúo con Cuco fue Los Ahijados.
-- occupations: bassist, guitarist, composer (sustituye musician). instruments: bass, guitar
-- (el tres queda en la prosa). aliases: El Ahijado.
-- Muerte 2 jul 2013 (merengala dice día 3). primary_genre salsa se deja; ver CONFLICTOS_DE_DATO.md.

UPDATE artists SET occupations = '["bassist","guitarist","composer"]'::jsonb, instruments = ARRAY['bass', 'guitar']::text[], aliases = ARRAY['El Ahijado']::text[] WHERE slug = 'martin-valoy';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Martín Valoy (died 2 July 2013), known as El Ahijado, was a Dominican bassist, guitarist, tres player, singer and composer. With his older brother "},{"type":"artistReference","attrs":{"occurrenceId":"28c6bf59-4fc6-4023-80e0-db3b277f5798","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" he formed "},{"type":"artistReference","attrs":{"occurrenceId":"d4756a40-fdfb-40d2-bd91-fa86e918a9dc","artistId":"f6f95f0f-e008-47b9-8b4c-10fe5508bfd9","displayText":"Los Ahijados"}},{"type":"text","text":", the duo that made its name with Cuban-style sones montunos in the 1960s, and he later played bass in «Los Virtuosos», the orchestra his brother founded in 1975."}]},{"type":"paragraph","content":[{"type":"text","text":"Los Ahijados","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The brothers began at the end of the 1950s — in 1958, by most accounts — as a duo singing serenades and the hits of the day. In the 1960s "},{"type":"artistReference","attrs":{"occurrenceId":"b9e556d7-e283-41b3-a35c-58de6bded303","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" turned the repertoire towards Cuban sones montunos, and the duo took the name "},{"type":"artistReference","attrs":{"occurrenceId":"e5869c0a-6265-4799-a446-69de3628f5ac","artistId":"f6f95f0f-e008-47b9-8b4c-10fe5508bfd9","displayText":"Los Ahijados"}},{"type":"text","text":", a reply to Cuba’s «Los Compadres». Cuco sang lead and played second guitar; Martín, credited as the duo’s soloist, played guitar and tres and sang the harmonies. Their records for the Kubaney label included «Vuelven... Los Ahijados», and numbers such as «Timoteo», «El lunar», «El hombre misterioso», «El paso de la jaiba» and «Vaivén» kept returning in compilations such as «20 éxitos de Los Ahijados». Their repertoire also took in «Qué será de mí», by "},{"type":"artistReference","attrs":{"occurrenceId":"6d140748-732d-427c-9701-b9525206ca83","artistId":"4b85d1eb-ebaa-42b5-9901-5e2805af9138","displayText":"Bienvenido Fabián"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los Virtuosos»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"When "},{"type":"artistReference","attrs":{"occurrenceId":"b0c02291-63a1-4ba8-b3e8-1a6add64fb1c","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" built «Los Virtuosos» in 1975 — the orchestra later renamed «La Tribu» — Martín moved to the bass and sang in the chorus. He is credited on bass on «Tiza!» (1980), where "},{"type":"artistReference","attrs":{"occurrenceId":"d97797f4-f195-440b-a9d6-932050b15953","artistId":"fb068903-a085-4a3f-b846-0be0b3e28934","displayText":"Henry García"}},{"type":"text","text":" was among the singers, and on «Chévere» (1982). Writing after his death, Joseph Cáceres described him as his brother’s second: low-key, and a solid presence at the bass."}]},{"type":"paragraph","content":[{"type":"text","text":"«Hagan coro señores, llegó el Ahijado»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1981 he released his only solo album, «Hagan coro señores, llegó el Ahijado», issued in the United States by Discolor and in Venezuela by Evesol: eight sones, among them «Yo no perdono», «El guardia del arsenal» and «Canta». The brothers came back together as "},{"type":"artistReference","attrs":{"occurrenceId":"4baad363-1a68-4cb1-8d32-962bd99d5f0c","artistId":"f6f95f0f-e008-47b9-8b4c-10fe5508bfd9","displayText":"Los Ahijados"}},{"type":"text","text":" for «De nuevo al son», a 1997 album on which both are credited as lead vocalists."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Martín Valoy died on 2 July 2013, and, as Cáceres noted at the time, his death passed almost unnoticed in the press. His work sits in two of the family’s main projects: the son montuno of "},{"type":"artistReference","attrs":{"occurrenceId":"9ea9d69f-9bbd-4323-9c08-540f9c6220b7","artistId":"f6f95f0f-e008-47b9-8b4c-10fe5508bfd9","displayText":"Los Ahijados"}},{"type":"text","text":" in the 1960s, and the rhythm section of «Los Virtuosos» in the years of «Tiza!» and «Chévere»."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'martin-valoy'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'martin-valoy' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '28c6bf59-4fc6-4023-80e0-db3b277f5798', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd4756a40-fdfb-40d2-bd91-fa86e918a9dc', 'artist', 'f6f95f0f-e008-47b9-8b4c-10fe5508bfd9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b9e556d7-e283-41b3-a35c-58de6bded303', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e5869c0a-6265-4799-a446-69de3628f5ac', 'artist', 'f6f95f0f-e008-47b9-8b4c-10fe5508bfd9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6d140748-732d-427c-9701-b9525206ca83', 'artist', '4b85d1eb-ebaa-42b5-9901-5e2805af9138' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b0c02291-63a1-4ba8-b3e8-1a6add64fb1c', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd97797f4-f195-440b-a9d6-932050b15953', 'artist', 'fb068903-a085-4a3f-b846-0be0b3e28934' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4baad363-1a68-4cb1-8d32-962bd99d5f0c', 'artist', 'f6f95f0f-e008-47b9-8b4c-10fe5508bfd9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9ea9d69f-9bbd-4323-9c08-540f9c6220b7', 'artist', 'f6f95f0f-e008-47b9-8b4c-10fe5508bfd9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Martín Valoy (died 2 July 2013), known as El Ahijado, was a Dominican bassist, guitarist, tres player, singer and composer. With his older brother Cuco Valoy he formed Los Ahijados, the duo that made its name with Cuban-style sones montunos in the 1960s, and he later played bass in «Los Virtuosos», the orchestra his brother founded in 1975.

**Los Ahijados**

The brothers began at the end of the 1950s — in 1958, by most accounts — as a duo singing serenades and the hits of the day. In the 1960s Cuco Valoy turned the repertoire towards Cuban sones montunos, and the duo took the name Los Ahijados, a reply to Cuba’s «Los Compadres». Cuco sang lead and played second guitar; Martín, credited as the duo’s soloist, played guitar and tres and sang the harmonies. Their records for the Kubaney label included «Vuelven... Los Ahijados», and numbers such as «Timoteo», «El lunar», «El hombre misterioso», «El paso de la jaiba» and «Vaivén» kept returning in compilations such as «20 éxitos de Los Ahijados». Their repertoire also took in «Qué será de mí», by Bienvenido Fabián.

**«Los Virtuosos»**

When Cuco Valoy built «Los Virtuosos» in 1975 — the orchestra later renamed «La Tribu» — Martín moved to the bass and sang in the chorus. He is credited on bass on «Tiza!» (1980), where Henry García was among the singers, and on «Chévere» (1982). Writing after his death, Joseph Cáceres described him as his brother’s second: low-key, and a solid presence at the bass.

**«Hagan coro señores, llegó el Ahijado»**

In 1981 he released his only solo album, «Hagan coro señores, llegó el Ahijado», issued in the United States by Discolor and in Venezuela by Evesol: eight sones, among them «Yo no perdono», «El guardia del arsenal» and «Canta». The brothers came back together as Los Ahijados for «De nuevo al son», a 1997 album on which both are credited as lead vocalists.

**Legacy**

Martín Valoy died on 2 July 2013, and, as Cáceres noted at the time, his death passed almost unnoticed in the press. His work sits in two of the family’s main projects: the son montuno of Los Ahijados in the 1960s, and the rhythm section of «Los Virtuosos» in the years of «Tiza!» and «Chévere».' WHERE slug = 'martin-valoy';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Martín Valoy (fallecido el 2 de julio de 2013), conocido como El Ahijado, fue un bajista, guitarrista, tresista, cantante y compositor dominicano. Con su hermano mayor "},{"type":"artistReference","attrs":{"occurrenceId":"ef2631d7-40d5-4ec5-bcc8-70d57a1c56a5","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" formó "},{"type":"artistReference","attrs":{"occurrenceId":"37491de2-55f6-4ce9-8259-da340784da32","artistId":"f6f95f0f-e008-47b9-8b4c-10fe5508bfd9","displayText":"Los Ahijados"}},{"type":"text","text":", el dúo que se hizo un nombre con sones montunos de corte cubano en los años sesenta, y después tocó el bajo en «Los Virtuosos», la orquesta que su hermano fundó en 1975."}]},{"type":"paragraph","content":[{"type":"text","text":"Los Ahijados","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los hermanos empezaron a finales de los cincuenta —en 1958, según la mayoría de las fuentes— como un dúo de serenatas y éxitos del momento. En los sesenta "},{"type":"artistReference","attrs":{"occurrenceId":"3027123d-c1fa-4225-8460-02f1715863d7","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" orientó el repertorio hacia los sones montunos cubanos y el dúo adoptó el nombre de "},{"type":"artistReference","attrs":{"occurrenceId":"22f7f1ce-7c21-45a4-8f6f-301475b4e0a9","artistId":"f6f95f0f-e008-47b9-8b4c-10fe5508bfd9","displayText":"Los Ahijados"}},{"type":"text","text":", en respuesta a «Los Compadres» de Cuba. Cuco llevaba la voz principal y la segunda guitarra; Martín, acreditado como solista del dúo, tocaba guitarra y tres y hacía las segundas voces. Entre sus discos para el sello Kubaney estuvo «Vuelven... Los Ahijados», y temas como «Timoteo», «El lunar», «El hombre misterioso», «El paso de la jaiba» y «Vaivén» siguieron volviendo en recopilaciones como «20 éxitos de Los Ahijados». Su repertorio incluyó también «Qué será de mí», de "},{"type":"artistReference","attrs":{"occurrenceId":"599a313b-0e46-40db-830b-2bcac4b019be","artistId":"4b85d1eb-ebaa-42b5-9901-5e2805af9138","displayText":"Bienvenido Fabián"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los Virtuosos»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cuando "},{"type":"artistReference","attrs":{"occurrenceId":"c4b00c92-7cd1-4fe6-acca-431884bfbbee","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" formó «Los Virtuosos» en 1975 —la orquesta que después pasó a llamarse «La Tribu»—, Martín se fue al bajo y cantó en los coros. Aparece acreditado en el bajo en «Tiza!» (1980), donde "},{"type":"artistReference","attrs":{"occurrenceId":"97abd6f3-faac-4661-bc6f-220005c21ff0","artistId":"fb068903-a085-4a3f-b846-0be0b3e28934","displayText":"Henry García"}},{"type":"text","text":" figuraba entre los cantantes, y en «Chévere» (1982). Tras su muerte, Joseph Cáceres lo describió como el segundo de su hermano: de perfil bajo y sólido en el bajo."}]},{"type":"paragraph","content":[{"type":"text","text":"«Hagan coro señores, llegó el Ahijado»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1981 publicó su único álbum como solista, «Hagan coro señores, llegó el Ahijado», editado en Estados Unidos por Discolor y en Venezuela por Evesol: ocho sones, entre ellos «Yo no perdono», «El guardia del arsenal» y «Canta». Los hermanos volvieron a juntarse como "},{"type":"artistReference","attrs":{"occurrenceId":"41cbd753-1400-476c-a16d-f2b5cf02fd9b","artistId":"f6f95f0f-e008-47b9-8b4c-10fe5508bfd9","displayText":"Los Ahijados"}},{"type":"text","text":" en «De nuevo al son», un disco de 1997 en el que ambos aparecen acreditados como voces principales."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Martín Valoy murió el 2 de julio de 2013 y, como señaló Cáceres entonces, su muerte pasó casi desapercibida en la prensa. Su obra está en dos de los proyectos principales de la familia: el son montuno de "},{"type":"artistReference","attrs":{"occurrenceId":"7c7d4ad4-0714-4b6f-ac2c-dbd6608a1e00","artistId":"f6f95f0f-e008-47b9-8b4c-10fe5508bfd9","displayText":"Los Ahijados"}},{"type":"text","text":" en los sesenta y la base rítmica de «Los Virtuosos» en los años de «Tiza!» y «Chévere»."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'martin-valoy'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'martin-valoy' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ef2631d7-40d5-4ec5-bcc8-70d57a1c56a5', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '37491de2-55f6-4ce9-8259-da340784da32', 'artist', 'f6f95f0f-e008-47b9-8b4c-10fe5508bfd9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3027123d-c1fa-4225-8460-02f1715863d7', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '22f7f1ce-7c21-45a4-8f6f-301475b4e0a9', 'artist', 'f6f95f0f-e008-47b9-8b4c-10fe5508bfd9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '599a313b-0e46-40db-830b-2bcac4b019be', 'artist', '4b85d1eb-ebaa-42b5-9901-5e2805af9138' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c4b00c92-7cd1-4fe6-acca-431884bfbbee', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '97abd6f3-faac-4661-bc6f-220005c21ff0', 'artist', 'fb068903-a085-4a3f-b846-0be0b3e28934' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '41cbd753-1400-476c-a16d-f2b5cf02fd9b', 'artist', 'f6f95f0f-e008-47b9-8b4c-10fe5508bfd9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7c7d4ad4-0714-4b6f-ac2c-dbd6608a1e00', 'artist', 'f6f95f0f-e008-47b9-8b4c-10fe5508bfd9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'martin-valoy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Martín Valoy (fallecido el 2 de julio de 2013), conocido como El Ahijado, fue un bajista, guitarrista, tresista, cantante y compositor dominicano. Con su hermano mayor Cuco Valoy formó Los Ahijados, el dúo que se hizo un nombre con sones montunos de corte cubano en los años sesenta, y después tocó el bajo en «Los Virtuosos», la orquesta que su hermano fundó en 1975.

**Los Ahijados**

Los hermanos empezaron a finales de los cincuenta —en 1958, según la mayoría de las fuentes— como un dúo de serenatas y éxitos del momento. En los sesenta Cuco Valoy orientó el repertorio hacia los sones montunos cubanos y el dúo adoptó el nombre de Los Ahijados, en respuesta a «Los Compadres» de Cuba. Cuco llevaba la voz principal y la segunda guitarra; Martín, acreditado como solista del dúo, tocaba guitarra y tres y hacía las segundas voces. Entre sus discos para el sello Kubaney estuvo «Vuelven... Los Ahijados», y temas como «Timoteo», «El lunar», «El hombre misterioso», «El paso de la jaiba» y «Vaivén» siguieron volviendo en recopilaciones como «20 éxitos de Los Ahijados». Su repertorio incluyó también «Qué será de mí», de Bienvenido Fabián.

**«Los Virtuosos»**

Cuando Cuco Valoy formó «Los Virtuosos» en 1975 —la orquesta que después pasó a llamarse «La Tribu»—, Martín se fue al bajo y cantó en los coros. Aparece acreditado en el bajo en «Tiza!» (1980), donde Henry García figuraba entre los cantantes, y en «Chévere» (1982). Tras su muerte, Joseph Cáceres lo describió como el segundo de su hermano: de perfil bajo y sólido en el bajo.

**«Hagan coro señores, llegó el Ahijado»**

En 1981 publicó su único álbum como solista, «Hagan coro señores, llegó el Ahijado», editado en Estados Unidos por Discolor y en Venezuela por Evesol: ocho sones, entre ellos «Yo no perdono», «El guardia del arsenal» y «Canta». Los hermanos volvieron a juntarse como Los Ahijados en «De nuevo al son», un disco de 1997 en el que ambos aparecen acreditados como voces principales.

**Legado**

Martín Valoy murió el 2 de julio de 2013 y, como señaló Cáceres entonces, su muerte pasó casi desapercibida en la prensa. Su obra está en dos de los proyectos principales de la familia: el son montuno de Los Ahijados en los sesenta y la base rítmica de «Los Virtuosos» en los años de «Tiza!» y «Chévere».' WHERE slug = 'martin-valoy';

COMMIT;
