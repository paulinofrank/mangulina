BEGIN;

-- Ficha de Manny Cruz.
--
-- La biografía de relleno no daba un solo hecho verificable.
-- Fecha de nacimiento: la fila decía 23 de abril; corregido a 26 (Wikipedia, El Caribe,
-- RC Noticias, República Merengue y Dura Informativa coinciden).
-- Premios: 7 filas, todas con ≥2 fuentes independientes (ver comentarios del script).
-- No registradas las nominaciones sin triunfo (Latin Grammy 2017-2023) ni el ASCAP 2018.

UPDATE artists SET date_of_birth = date_of_birth + interval '3 days' WHERE slug = 'manny-cruz';

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Tropical Song of the Year' FROM awards a WHERE a.name = 'Billboard Latin Music Awards'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Tropical Song of the Year');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2018, 'Deja Vu', true, 'notaclave.com (27 abr 2018); Diario Libre (27 abr 2018); elcaribe.com.do (28 abr 2018)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'manny-cruz' AND a.name = 'Billboard Latin Music Awards' AND cat.name = 'Tropical Song of the Year'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2018);

INSERT INTO awards (name, organization, country, description)
SELECT 'Latin American Music Awards', 'Telemundo', 'Estados Unidos',
       'Premios basados en el desempeño en las listas de Billboard/Nielsen para música latina.'
 WHERE NOT EXISTS (SELECT 1 FROM awards WHERE name = 'Latin American Music Awards');

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Canción del Año' FROM awards a WHERE a.name = 'Latin American Music Awards'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Canción del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2017, 'Deja Vu', true, 'proceso.com.do (27 oct 2017); El Vocero de Puerto Rico; radioechalesalsita.blogspot.com; showbuzzrd.com'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'manny-cruz' AND a.name = 'Latin American Music Awards' AND cat.name = 'Canción del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2017);

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Cantante Solista del Año' FROM awards a WHERE a.name = 'Premios Soberano'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Cantante Solista del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2017, NULL, true, 'Diario Libre; KienyKe; MinayaPR (28 mar 2017); showbuzzrd.com; StubHub'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'manny-cruz' AND a.name = 'Premios Soberano' AND cat.name = 'Cantante Solista del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2017);

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2019, 'Sobrenatural', true, 'Listín Diario; El Mismo Golpe con Jochy; Acento (21 mar 2019); Hoy Digital (20 mar 2019); Vanguardia del Pueblo'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'manny-cruz' AND a.name = 'Premios Soberano' AND cat.name = 'Álbum del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2019);

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2020, 'Santo Domingo', true, 'Listín Diario, El Día y Diario Digital Barahona (16 jun 2021), listando el premio como "Merengue del año 2020"'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'manny-cruz' AND a.name = 'Premios Soberano' AND cat.name = 'Merengue del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2020);

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2022, 'Estoy completo', true, 'Prensa y Gente; CanaldelaMona; El Nuevo Diario y Listín Diario (22-23 mar 2023)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'manny-cruz' AND a.name = 'Premios Soberano' AND cat.name = 'Merengue del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2022);

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2024, 'Llegaste (con Milly Quezada)', true, 'notidigitalrd.com.do; LAS TOP NEWS; Periódico Panorama; Más Vip; Hoy Digital (12-15 mar 2024)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'manny-cruz' AND a.name = 'Premios Soberano' AND cat.name = 'Colaboración del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2024);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manny Cruz — Emmanuel Cruz Sánchez, born in Santo Domingo on 26 April 1983 to a Dominican mother and a Cuban father — is a Dominican singer, songwriter and producer of romantic merengue, the youngest of three siblings and a brother of "},{"type":"artistReference","attrs":{"occurrenceId":"77fda670-197f-4190-9b78-03534f5720ee","artistId":"84aba9ce-ba69-4caa-b71b-2bedb2f848fc","displayText":"Daniel Santacruz"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Ten years in the United States","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He moved to the United States with his parents at fourteen, and in Miami studied music business under the saxophonist Ed Calle at Miami Dade College, singing lead in the college’s official band. After ten years abroad he came back to the Dominican Republic in 2007 to sing in a merengue orchestra, joining "},{"type":"artistReference","attrs":{"occurrenceId":"35e48182-1c9c-4f85-9cfa-7a87d63c285b","artistId":"c73737c2-0106-4a87-8dbe-5f1650d34342","displayText":"Kinito Méndez"}},{"type":"text","text":"’s band for two years and then "},{"type":"artistReference","attrs":{"occurrenceId":"03e4721b-4754-49e9-9233-ecf68c8166ce","artistId":"1cd11a22-573a-43b4-8f54-fbd08329a4e2","displayText":"Ilegales"}},{"type":"text","text":", touring Latin America, the United States and Europe. He also worked in advertising, recording jingles and modelling for national and international campaigns; a first solo attempt in 2010 did not take."}]},{"type":"paragraph","content":[{"type":"text","text":"«AURA» and the return to solo work","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In December 2011 he formed the trio AURA with JJ Sánchez and Javi Grullón; their first single, «Te lloro» (2012), was a national hit, and the group recorded mostly ballads for four years before splitting in 2016. That year Cruz went solo again with «Sobrenatural», the single and the album, earning a Latin Grammy nomination and hits such as «Sabes enamorarme» and «Dime que sí», both with "},{"type":"artistReference","attrs":{"occurrenceId":"c112d6f0-c47d-4e04-b1f8-528a4619c9d3","artistId":"1cd11a22-573a-43b4-8f54-fbd08329a4e2","displayText":"Ilegales"}},{"type":"text","text":", and «No me lo creo», with "},{"type":"artistReference","attrs":{"occurrenceId":"e3b539dc-9a67-4bf5-8889-5780e290d30a","artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Deja Vu»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"With "},{"type":"artistReference","attrs":{"occurrenceId":"418aa3ab-b114-4e4d-a77b-054c3c7f6d11","artistId":"84aba9ce-ba69-4caa-b71b-2bedb2f848fc","displayText":"Daniel Santacruz"}},{"type":"text","text":" he co-wrote «Deja Vu», recorded by "},{"type":"artistReference","attrs":{"occurrenceId":"6ed12f49-cd39-4b34-a292-ba83772e053e","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":" and Shakira, which won Song of the Year at the 2017 Latin American Music Awards and Tropical Song of the Year at the 2018 Billboard Latin Music Awards. His second album, «Bailando contigo» (2020), was nominated for Best Merengue/Bachata Album at the Latin Grammys, and that year he recorded «Imaginarme sin ti» with Elvis Crespo, «Yo quisiera ser» with "},{"type":"artistReference","attrs":{"occurrenceId":"55b118ab-7862-4c7b-a5cd-d55daa81c257","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":", and released «Santo Domingo», a merengue dedicated to his home city that went viral on Dominican radio."}]},{"type":"paragraph","content":[{"type":"text","text":"Merengue and bachata","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2021 he released his first bachata collaboration, «Las puertas del cielo», with "},{"type":"artistReference","attrs":{"occurrenceId":"80935584-a652-4525-a24e-36a774f011d5","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":", which reached the Billboard top ten, and his third album, «Love Dance Merengue». «Cuatro 26» followed in 2023. He has also performed in stage musicals, including «West Side Story», «Rent» and «Legally Blonde», and played the lead in the documentary «Hay un país en el mundo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cruz has been named Cantante Solista del Año at the Premios Soberano (2017), and his records have gone on to win Album of the Year for «Sobrenatural» (2019), Merengue of the Year for «Santo Domingo» (2020) and «Estoy completo» (2022), and Collaboration of the Year for «Llegaste», with "},{"type":"artistReference","attrs":{"occurrenceId":"40eba882-473e-470d-b546-65f186893e77","artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada"}},{"type":"text","text":" (2024) — a career built, after a decade abroad and one disbanded trio, on writing and singing romantic merengue for a Dominican audience that never stopped listening."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manny-cruz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manny-cruz' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '77fda670-197f-4190-9b78-03534f5720ee', 'artist', '84aba9ce-ba69-4caa-b71b-2bedb2f848fc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '35e48182-1c9c-4f85-9cfa-7a87d63c285b', 'artist', 'c73737c2-0106-4a87-8dbe-5f1650d34342' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '03e4721b-4754-49e9-9233-ecf68c8166ce', 'artist', '1cd11a22-573a-43b4-8f54-fbd08329a4e2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c112d6f0-c47d-4e04-b1f8-528a4619c9d3', 'artist', '1cd11a22-573a-43b4-8f54-fbd08329a4e2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e3b539dc-9a67-4bf5-8889-5780e290d30a', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '418aa3ab-b114-4e4d-a77b-054c3c7f6d11', 'artist', '84aba9ce-ba69-4caa-b71b-2bedb2f848fc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6ed12f49-cd39-4b34-a292-ba83772e053e', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '55b118ab-7862-4c7b-a5cd-d55daa81c257', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '80935584-a652-4525-a24e-36a774f011d5', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '40eba882-473e-470d-b546-65f186893e77', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Manny Cruz — Emmanuel Cruz Sánchez, born in Santo Domingo on 26 April 1983 to a Dominican mother and a Cuban father — is a Dominican singer, songwriter and producer of romantic merengue, the youngest of three siblings and a brother of Daniel Santacruz.

**Ten years in the United States**

He moved to the United States with his parents at fourteen, and in Miami studied music business under the saxophonist Ed Calle at Miami Dade College, singing lead in the college’s official band. After ten years abroad he came back to the Dominican Republic in 2007 to sing in a merengue orchestra, joining Kinito Méndez’s band for two years and then Ilegales, touring Latin America, the United States and Europe. He also worked in advertising, recording jingles and modelling for national and international campaigns; a first solo attempt in 2010 did not take.

**«AURA» and the return to solo work**

In December 2011 he formed the trio AURA with JJ Sánchez and Javi Grullón; their first single, «Te lloro» (2012), was a national hit, and the group recorded mostly ballads for four years before splitting in 2016. That year Cruz went solo again with «Sobrenatural», the single and the album, earning a Latin Grammy nomination and hits such as «Sabes enamorarme» and «Dime que sí», both with Ilegales, and «No me lo creo», with Eddy Herrera.

**«Deja Vu»**

With Daniel Santacruz he co-wrote «Deja Vu», recorded by Prince Royce and Shakira, which won Song of the Year at the 2017 Latin American Music Awards and Tropical Song of the Year at the 2018 Billboard Latin Music Awards. His second album, «Bailando contigo» (2020), was nominated for Best Merengue/Bachata Album at the Latin Grammys, and that year he recorded «Imaginarme sin ti» with Elvis Crespo, «Yo quisiera ser» with Miriam Cruz, and released «Santo Domingo», a merengue dedicated to his home city that went viral on Dominican radio.

**Merengue and bachata**

In 2021 he released his first bachata collaboration, «Las puertas del cielo», with Antony Santos, which reached the Billboard top ten, and his third album, «Love Dance Merengue». «Cuatro 26» followed in 2023. He has also performed in stage musicals, including «West Side Story», «Rent» and «Legally Blonde», and played the lead in the documentary «Hay un país en el mundo».

**Legacy**

Cruz has been named Cantante Solista del Año at the Premios Soberano (2017), and his records have gone on to win Album of the Year for «Sobrenatural» (2019), Merengue of the Year for «Santo Domingo» (2020) and «Estoy completo» (2022), and Collaboration of the Year for «Llegaste», with Milly Quezada (2024) — a career built, after a decade abroad and one disbanded trio, on writing and singing romantic merengue for a Dominican audience that never stopped listening.' WHERE slug = 'manny-cruz';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manny Cruz —Emmanuel Cruz Sánchez, nacido en Santo Domingo el 26 de abril de 1983, de madre dominicana y padre cubano— es un cantante, compositor y productor dominicano de merengue romántico, el menor de tres hermanos y hermano de "},{"type":"artistReference","attrs":{"occurrenceId":"7da839fe-ef27-4155-acec-589eb590abdb","artistId":"84aba9ce-ba69-4caa-b71b-2bedb2f848fc","displayText":"Daniel Santacruz"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Diez años en Estados Unidos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Emigró a Estados Unidos con sus padres a los catorce años, y en Miami estudió negocios de la música con el saxofonista Ed Calle en Miami Dade College, cantando como voz principal en la banda oficial de la universidad. Tras diez años fuera volvió a República Dominicana en 2007 para cantar en una orquesta de merengue, entró en la banda de "},{"type":"artistReference","attrs":{"occurrenceId":"1b9e53cd-21be-4f90-a956-088e24af35e9","artistId":"c73737c2-0106-4a87-8dbe-5f1650d34342","displayText":"Kinito Méndez"}},{"type":"text","text":" por dos años y después en "},{"type":"artistReference","attrs":{"occurrenceId":"6b0261c1-e69e-4f6d-8ca5-362327b15aea","artistId":"1cd11a22-573a-43b4-8f54-fbd08329a4e2","displayText":"Ilegales"}},{"type":"text","text":", con giras por Latinoamérica, Estados Unidos y Europa. También trabajó en publicidad, grabando jingles y como modelo de campañas nacionales e internacionales; un primer intento como solista en 2010 no cuajó."}]},{"type":"paragraph","content":[{"type":"text","text":"«AURA» y el regreso como solista","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En diciembre de 2011 formó el trío AURA con JJ Sánchez y Javi Grullón; su primer sencillo, «Te lloro» (2012), fue un éxito nacional, y el grupo grabó sobre todo baladas durante cuatro años antes de separarse en 2016. Ese año Cruz volvió como solista con «Sobrenatural», el sencillo y el álbum, que le valió una nominación al Latin Grammy y éxitos como «Sabes enamorarme» y «Dime que sí», ambos con "},{"type":"artistReference","attrs":{"occurrenceId":"aa365fef-13cf-49d7-b9f9-f2a2265c1c7f","artistId":"1cd11a22-573a-43b4-8f54-fbd08329a4e2","displayText":"Ilegales"}},{"type":"text","text":", y «No me lo creo», con "},{"type":"artistReference","attrs":{"occurrenceId":"2f46d90b-2efd-4fc1-bb48-de2b80b9007c","artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Deja Vu»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Con "},{"type":"artistReference","attrs":{"occurrenceId":"1d10118b-30c8-4051-a8b6-3e536196e653","artistId":"84aba9ce-ba69-4caa-b71b-2bedb2f848fc","displayText":"Daniel Santacruz"}},{"type":"text","text":" coescribió «Deja Vu», grabada por "},{"type":"artistReference","attrs":{"occurrenceId":"ec48cc53-bf64-41ac-9f27-bcdf213ba47f","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":" y Shakira, que ganó Canción del Año en los Latin American Music Awards de 2017 y Tropical Song of the Year en los Billboard Latin Music Awards de 2018. Su segundo álbum, «Bailando contigo» (2020), fue nominado a Mejor Álbum de Merengue/Bachata en los Latin Grammy, y ese año grabó «Imaginarme sin ti» con Elvis Crespo, «Yo quisiera ser» con "},{"type":"artistReference","attrs":{"occurrenceId":"d8ead9fa-aa64-4f1e-bd9a-6599f5f48395","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":", y lanzó «Santo Domingo», un merengue dedicado a su ciudad que se volvió viral en la radio dominicana."}]},{"type":"paragraph","content":[{"type":"text","text":"Merengue y bachata","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2021 lanzó su primera colaboración en bachata, «Las puertas del cielo», con "},{"type":"artistReference","attrs":{"occurrenceId":"6d9adf0d-1991-41f8-af0a-b11478d81fc7","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":", que entró al top diez de Billboard, y su tercer álbum, «Love Dance Merengue». «Cuatro 26» llegó en 2023. También ha actuado en musicales de teatro, entre ellos «West Side Story», «Rent» y «Legally Blonde», y protagonizó el documental «Hay un país en el mundo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cruz ha sido nombrado Cantante Solista del Año en los Premios Soberano (2017), y sus discos han ganado después Álbum del Año por «Sobrenatural» (2019), Merengue del Año por «Santo Domingo» (2020) y «Estoy completo» (2022), y Colaboración del Año por «Llegaste», con "},{"type":"artistReference","attrs":{"occurrenceId":"56507013-1437-4483-808b-08faf409cdf5","artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada"}},{"type":"text","text":" (2024) —una carrera construida, tras una década fuera del país y un trío disuelto, sobre escribir y cantar merengue romántico para un público dominicano que nunca dejó de escucharlo."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manny-cruz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manny-cruz' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7da839fe-ef27-4155-acec-589eb590abdb', 'artist', '84aba9ce-ba69-4caa-b71b-2bedb2f848fc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1b9e53cd-21be-4f90-a956-088e24af35e9', 'artist', 'c73737c2-0106-4a87-8dbe-5f1650d34342' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6b0261c1-e69e-4f6d-8ca5-362327b15aea', 'artist', '1cd11a22-573a-43b4-8f54-fbd08329a4e2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'aa365fef-13cf-49d7-b9f9-f2a2265c1c7f', 'artist', '1cd11a22-573a-43b4-8f54-fbd08329a4e2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2f46d90b-2efd-4fc1-bb48-de2b80b9007c', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1d10118b-30c8-4051-a8b6-3e536196e653', 'artist', '84aba9ce-ba69-4caa-b71b-2bedb2f848fc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ec48cc53-bf64-41ac-9f27-bcdf213ba47f', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd8ead9fa-aa64-4f1e-bd9a-6599f5f48395', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6d9adf0d-1991-41f8-af0a-b11478d81fc7', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '56507013-1437-4483-808b-08faf409cdf5', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manny-cruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Manny Cruz —Emmanuel Cruz Sánchez, nacido en Santo Domingo el 26 de abril de 1983, de madre dominicana y padre cubano— es un cantante, compositor y productor dominicano de merengue romántico, el menor de tres hermanos y hermano de Daniel Santacruz.

**Diez años en Estados Unidos**

Emigró a Estados Unidos con sus padres a los catorce años, y en Miami estudió negocios de la música con el saxofonista Ed Calle en Miami Dade College, cantando como voz principal en la banda oficial de la universidad. Tras diez años fuera volvió a República Dominicana en 2007 para cantar en una orquesta de merengue, entró en la banda de Kinito Méndez por dos años y después en Ilegales, con giras por Latinoamérica, Estados Unidos y Europa. También trabajó en publicidad, grabando jingles y como modelo de campañas nacionales e internacionales; un primer intento como solista en 2010 no cuajó.

**«AURA» y el regreso como solista**

En diciembre de 2011 formó el trío AURA con JJ Sánchez y Javi Grullón; su primer sencillo, «Te lloro» (2012), fue un éxito nacional, y el grupo grabó sobre todo baladas durante cuatro años antes de separarse en 2016. Ese año Cruz volvió como solista con «Sobrenatural», el sencillo y el álbum, que le valió una nominación al Latin Grammy y éxitos como «Sabes enamorarme» y «Dime que sí», ambos con Ilegales, y «No me lo creo», con Eddy Herrera.

**«Deja Vu»**

Con Daniel Santacruz coescribió «Deja Vu», grabada por Prince Royce y Shakira, que ganó Canción del Año en los Latin American Music Awards de 2017 y Tropical Song of the Year en los Billboard Latin Music Awards de 2018. Su segundo álbum, «Bailando contigo» (2020), fue nominado a Mejor Álbum de Merengue/Bachata en los Latin Grammy, y ese año grabó «Imaginarme sin ti» con Elvis Crespo, «Yo quisiera ser» con Miriam Cruz, y lanzó «Santo Domingo», un merengue dedicado a su ciudad que se volvió viral en la radio dominicana.

**Merengue y bachata**

En 2021 lanzó su primera colaboración en bachata, «Las puertas del cielo», con Antony Santos, que entró al top diez de Billboard, y su tercer álbum, «Love Dance Merengue». «Cuatro 26» llegó en 2023. También ha actuado en musicales de teatro, entre ellos «West Side Story», «Rent» y «Legally Blonde», y protagonizó el documental «Hay un país en el mundo».

**Legado**

Cruz ha sido nombrado Cantante Solista del Año en los Premios Soberano (2017), y sus discos han ganado después Álbum del Año por «Sobrenatural» (2019), Merengue del Año por «Santo Domingo» (2020) y «Estoy completo» (2022), y Colaboración del Año por «Llegaste», con Milly Quezada (2024) —una carrera construida, tras una década fuera del país y un trío disuelto, sobre escribir y cantar merengue romántico para un público dominicano que nunca dejó de escucharlo.' WHERE slug = 'manny-cruz';

COMMIT;
