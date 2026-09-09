BEGIN;

-- Ficha de Héctor Acosta "El Torito": documentos editoriales en y es,
-- referencias, espejo legacy, ocho Casandra sin registrar y limpieza de
-- alias cruzados entre la persona y la agrupación.

-- 1. Alias cruzados: cada entidad cargaba el nombre de la otra.
UPDATE artists SET aliases = array_remove(aliases, 'Los Toros Band') WHERE id = 'dee014d6-cb3c-4abb-9262-165538277a0d';
UPDATE artists SET aliases = array_remove(array_remove(aliases, 'Hector Acosta'), 'El Torito') WHERE id = '73032c71-e46c-45b1-b02c-8f4de18426ad';

-- 2. Relación de agrupación (ya aplicada; idempotente para reejecución).
INSERT INTO artist_relationships (source_artist_id, target_artist_id, relationship_type, start_year, end_year, notes)
SELECT 'dee014d6-cb3c-4abb-9262-165538277a0d', '73032c71-e46c-45b1-b02c-8f4de18426ad', 'member_of', 1990, 2005, 'Lead vocalist and conductor (vocalista líder y conductor)'
WHERE NOT EXISTS (SELECT 1 FROM artist_relationships WHERE source_artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND target_artist_id='73032c71-e46c-45b1-b02c-8f4de18426ad' AND relationship_type='member_of');

-- 3. Ocho adjudicaciones Casandra documentadas y no registradas.
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT 'dee014d6-cb3c-4abb-9262-165538277a0d', cat.award_id, cat.id, 2007, NULL, true, 'Gala del 27 de marzo de 2007; ACROARTE la anunció como Orquesta de Merengue del Año'
  FROM award_categories cat JOIN awards aw ON aw.id = cat.award_id
 WHERE aw.name = 'Premios Casandra' AND cat.name = 'Orquesta del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND w.category_id=cat.id AND w.year=2007);
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT 'dee014d6-cb3c-4abb-9262-165538277a0d', cat.award_id, cat.id, 2007, '¿Cómo me curo?', true, 'Gala del 27 de marzo de 2007'
  FROM award_categories cat JOIN awards aw ON aw.id = cat.award_id
 WHERE aw.name = 'Premios Casandra' AND cat.name = 'Merengue del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND w.category_id=cat.id AND w.year=2007);
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT 'dee014d6-cb3c-4abb-9262-165538277a0d', cat.award_id, cat.id, 2007, 'Sigo siendo yo', true, 'Gala del 27 de marzo de 2007'
  FROM award_categories cat JOIN awards aw ON aw.id = cat.award_id
 WHERE aw.name = 'Premios Casandra' AND cat.name = 'Álbum del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND w.category_id=cat.id AND w.year=2007);
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT 'dee014d6-cb3c-4abb-9262-165538277a0d', cat.award_id, cat.id, 2008, NULL, true, 'Gala del 10 de marzo de 2008'
  FROM award_categories cat JOIN awards aw ON aw.id = cat.award_id
 WHERE aw.name = 'Premios Casandra' AND cat.name = 'Orquesta del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND w.category_id=cat.id AND w.year=2008);
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT 'dee014d6-cb3c-4abb-9262-165538277a0d', cat.award_id, cat.id, 2008, 'Me voy', true, 'Gala del 10 de marzo de 2008'
  FROM award_categories cat JOIN awards aw ON aw.id = cat.award_id
 WHERE aw.name = 'Premios Casandra' AND cat.name = 'Bachata del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND w.category_id=cat.id AND w.year=2008);
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT 'dee014d6-cb3c-4abb-9262-165538277a0d', cat.award_id, cat.id, 2009, NULL, true, 'Gala del 23 de marzo de 2009; ACROARTE la anunció como Orquesta de Merengue del Año'
  FROM award_categories cat JOIN awards aw ON aw.id = cat.award_id
 WHERE aw.name = 'Premios Casandra' AND cat.name = 'Orquesta del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND w.category_id=cat.id AND w.year=2009);
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT 'dee014d6-cb3c-4abb-9262-165538277a0d', cat.award_id, cat.id, 2009, 'Mitad mitad', true, 'Gala del 23 de marzo de 2009'
  FROM award_categories cat JOIN awards aw ON aw.id = cat.award_id
 WHERE aw.name = 'Premios Casandra' AND cat.name = 'Álbum del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND w.category_id=cat.id AND w.year=2009);
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT 'dee014d6-cb3c-4abb-9262-165538277a0d', cat.award_id, cat.id, 2010, NULL, true, 'Gala del 16 de marzo de 2010; ACROARTE la anunció como Orquesta de Merengue del Año'
  FROM award_categories cat JOIN awards aw ON aw.id = cat.award_id
 WHERE aw.name = 'Premios Casandra' AND cat.name = 'Orquesta del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND w.category_id=cat.id AND w.year=2010);

-- 4. Documentos editoriales, referencias y espejo markdown legacy.
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Héctor Elpidio Acosta Restituyo, known as El Torito, is a Dominican singer, composer and politician, born in Bonao on 23 May 1967. He spent fifteen years as the lead voice of "},{"type":"artistReference","attrs":{"occurrenceId":"b875c1cf-3168-4b72-b50d-259cb3abaae1","artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band"}},{"type":"text","text":" before a contested departure in 2005 opened a solo career that carried him from merengue into bachata and bolero. He has been senator for Monseñor Nouel since 2020."}]},{"type":"paragraph","content":[{"type":"text","text":"Bonao and the first groups","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He was born in the community of Los Arroces and grew up in the San Pablo barrio of Bonao, the elder of two sons of Elpidio Acosta, a schoolteacher. He sang in the parish choir as a boy while training for what he expected would be a career in baseball. In 1982 he took first place in a voice contest run by a local radio station, then spent two years with an amateur group called La Renovación Quisqueyana before leaving for Los Gentiles, where he played bass."}]},{"type":"paragraph","content":[{"type":"text","text":"Los Toros Band","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1987 he was on trial with "},{"type":"artistReference","attrs":{"occurrenceId":"31f7993c-3f7f-4c48-8bfc-e4a9a6fb1a5d","artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario"}},{"type":"text","text":" — about two months there, and another two with "},{"type":"artistReference","attrs":{"occurrenceId":"caa8fe64-679c-4312-9c08-75b0848200cf","artistId":"db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250","displayText":"Henry Hierro"}},{"type":"text","text":" — when the producer Gerardo \"el Toro\" Díaz heard him sing at one of the group’s dates in Bonao and offered him a place in a band that did not yet exist."}]},{"type":"paragraph","content":[{"type":"text","text":"Acosta joined the project in 1990, but only to record: Díaz kept the group off stage while the debut album ¡Se soltaron! ran for a year on Dominican radio. The band played in public for the first time on 4 May 1991, with Acosta out front as lead voice and leader, and the nickname El Torito dates from those years. "},{"type":"artistReference","attrs":{"occurrenceId":"75b8d464-1996-4e8c-ae5c-eeadd015db86","artistId":"1519cbca-ae0a-4ede-924b-244a49c9024e","displayText":"Henry Jiménez"}},{"type":"text","text":" arranged \"La Morenita\" for the group in 1991."}]},{"type":"paragraph","content":[{"type":"text","text":"Across roughly fifteen years the band put \"A pasito lento\", \"La nena del jean\", \"Las mujeres lo bailan bien\", \"Perdóname la vida\", \"Llegó tu marido\", \"Quizás sí, quizás no\" and \"Esa morenita\" into circulation."}]},{"type":"paragraph","content":[{"type":"text","text":"He left in 2005 over the group’s finances, saying he had never been told what a tour earned and had received nothing from Dominican record sales. A public contract fight followed with Los Toros Records, the company run by Gerardo Díaz and his brother Juan Pablo, which barred him from performing until it was resolved. He reached a settlement in February 2006 after paying a substantial sum."}]},{"type":"paragraph","content":[{"type":"text","text":"Héctor Acosta & su Orquesta","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He presented his own orchestra on 8 March 2006 at the Jet Set in Santo Domingo. Sigo siendo yo followed on 24 October and reached five tracks on Dominican radio at the same time, among them \"Lo que tiene ella\", \"Me voy\" and \"¿Cómo me curo?\". He had already cut a merengue típico record, Típico, for J&N in 2004, but it was in this period that the press began calling him a bachatero."}]},{"type":"paragraph","content":[{"type":"text","text":"Mitad mitad (2008) carried \"Sin perdón\" and \"Con qué ojos\", both of which entered Billboard’s Hot Latin Songs, and a remix of \"Me voy\" with Romeo Santos. Simplemente... El Torito (2009), Oblígame (2010) — the source of \"Me duele la cabeza\" — and Con el corazón abierto (2012) followed. He recorded \"Me vio llorar\" with the Colombian Jorge Celedón, his first vallenato, \"Se me va la voz\" with Alejandro Fernández and \"Perdóname\" with Pepe Aguilar. Merengue y sentimiento (2015) was nominated for a Latin Grammy for best contemporary tropical album, and Este soy yo appeared in 2022."}]},{"type":"paragraph","content":[{"type":"text","text":"He marked fifteen years on stage at the United Palace in New York in 2007 and appeared that September as a guest at Aventura’s Madison Square Garden concert; he returned to the Garden for two nights in August 2009 alongside Juanes, Alejandro Sanz, Enrique Iglesias, Luis Fonsi, Laura Pausini and "},{"type":"artistReference","attrs":{"occurrenceId":"c634aec3-d137-41a4-9c19-7e2fee91218c","artistId":"e8ba0f32-1d96-494d-9861-b1dc3937331e","displayText":"José Alberto \"El Canario\""}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Politics","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Acosta was artistic adviser to Hipólito Mejía’s government (2000–2004) and campaigned for Miguel Vargas Maldonado in 2008, whose slogan took up a phrase of his, \"¿Tiene mieo?\". In July of that year the Obama campaign named him a spokesman to turn out Hispanic voters in Miami and New York. At the Premios Lo Nuestro of 17 February 2011, while presenting an award, he unfurled a yellow pennant reading 4% — the share of gross domestic product Dominican campaigners were demanding for education. He announced a senate run in August 2013 and was elected senator for Monseñor Nouel on 16 August 2020, taking a second term in 2024."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"ACROARTE gave him El Gran Soberano, its highest distinction, in 2013, and Orquesta del Año in 2019; earlier, in the Casandra years, he won orchestra, merengue, bachata and album of the year between 2007 and 2010. His exit from Los Toros Band and the litigation that followed is one of the documented Dominican cases of a lead singer separating from a producer-owned group and sustaining a career on his own."}]}]}'::jsonb, 'published', 'dee014d6-cb3c-4abb-9262-165538277a0d', 1)
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id =
  (SELECT id FROM editorial_documents WHERE owner_artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND locale='en' AND document_type='artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT id, 'b875c1cf-3168-4b72-b50d-259cb3abaae1', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad' FROM editorial_documents
 WHERE owner_artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND locale='en' AND document_type='artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT id, '31f7993c-3f7f-4c48-8bfc-e4a9a6fb1a5d', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4' FROM editorial_documents
 WHERE owner_artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND locale='en' AND document_type='artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT id, 'caa8fe64-679c-4312-9c08-75b0848200cf', 'artist', 'db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250' FROM editorial_documents
 WHERE owner_artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND locale='en' AND document_type='artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT id, '75b8d464-1996-4e8c-ae5c-eeadd015db86', 'artist', '1519cbca-ae0a-4ede-924b-244a49c9024e' FROM editorial_documents
 WHERE owner_artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND locale='en' AND document_type='artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT id, 'c634aec3-d137-41a4-9c19-7e2fee91218c', 'artist', 'e8ba0f32-1d96-494d-9861-b1dc3937331e' FROM editorial_documents
 WHERE owner_artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND locale='en' AND document_type='artist_biography';
UPDATE artists SET bio_en = 'Héctor Elpidio Acosta Restituyo, known as El Torito, is a Dominican singer, composer and politician, born in Bonao on 23 May 1967. He spent fifteen years as the lead voice of Los Toros Band before a contested departure in 2005 opened a solo career that carried him from merengue into bachata and bolero. He has been senator for Monseñor Nouel since 2020.

**Bonao and the first groups**

He was born in the community of Los Arroces and grew up in the San Pablo barrio of Bonao, the elder of two sons of Elpidio Acosta, a schoolteacher. He sang in the parish choir as a boy while training for what he expected would be a career in baseball. In 1982 he took first place in a voice contest run by a local radio station, then spent two years with an amateur group called La Renovación Quisqueyana before leaving for Los Gentiles, where he played bass.

**Los Toros Band**

In 1987 he was on trial with Los Hermanos Rosario — about two months there, and another two with Henry Hierro — when the producer Gerardo "el Toro" Díaz heard him sing at one of the group’s dates in Bonao and offered him a place in a band that did not yet exist.

Acosta joined the project in 1990, but only to record: Díaz kept the group off stage while the debut album ¡Se soltaron! ran for a year on Dominican radio. The band played in public for the first time on 4 May 1991, with Acosta out front as lead voice and leader, and the nickname El Torito dates from those years. Henry Jiménez arranged "La Morenita" for the group in 1991.

Across roughly fifteen years the band put "A pasito lento", "La nena del jean", "Las mujeres lo bailan bien", "Perdóname la vida", "Llegó tu marido", "Quizás sí, quizás no" and "Esa morenita" into circulation.

He left in 2005 over the group’s finances, saying he had never been told what a tour earned and had received nothing from Dominican record sales. A public contract fight followed with Los Toros Records, the company run by Gerardo Díaz and his brother Juan Pablo, which barred him from performing until it was resolved. He reached a settlement in February 2006 after paying a substantial sum.

**Héctor Acosta & su Orquesta**

He presented his own orchestra on 8 March 2006 at the Jet Set in Santo Domingo. Sigo siendo yo followed on 24 October and reached five tracks on Dominican radio at the same time, among them "Lo que tiene ella", "Me voy" and "¿Cómo me curo?". He had already cut a merengue típico record, Típico, for J&N in 2004, but it was in this period that the press began calling him a bachatero.

Mitad mitad (2008) carried "Sin perdón" and "Con qué ojos", both of which entered Billboard’s Hot Latin Songs, and a remix of "Me voy" with Romeo Santos. Simplemente... El Torito (2009), Oblígame (2010) — the source of "Me duele la cabeza" — and Con el corazón abierto (2012) followed. He recorded "Me vio llorar" with the Colombian Jorge Celedón, his first vallenato, "Se me va la voz" with Alejandro Fernández and "Perdóname" with Pepe Aguilar. Merengue y sentimiento (2015) was nominated for a Latin Grammy for best contemporary tropical album, and Este soy yo appeared in 2022.

He marked fifteen years on stage at the United Palace in New York in 2007 and appeared that September as a guest at Aventura’s Madison Square Garden concert; he returned to the Garden for two nights in August 2009 alongside Juanes, Alejandro Sanz, Enrique Iglesias, Luis Fonsi, Laura Pausini and José Alberto "El Canario".

**Politics**

Acosta was artistic adviser to Hipólito Mejía’s government (2000–2004) and campaigned for Miguel Vargas Maldonado in 2008, whose slogan took up a phrase of his, "¿Tiene mieo?". In July of that year the Obama campaign named him a spokesman to turn out Hispanic voters in Miami and New York. At the Premios Lo Nuestro of 17 February 2011, while presenting an award, he unfurled a yellow pennant reading 4% — the share of gross domestic product Dominican campaigners were demanding for education. He announced a senate run in August 2013 and was elected senator for Monseñor Nouel on 16 August 2020, taking a second term in 2024.

**Legacy**

ACROARTE gave him El Gran Soberano, its highest distinction, in 2013, and Orquesta del Año in 2019; earlier, in the Casandra years, he won orchestra, merengue, bachata and album of the year between 2007 and 2010. His exit from Los Toros Band and the litigation that followed is one of the documented Dominican cases of a lead singer separating from a producer-owned group and sustaining a career on his own.' WHERE id = 'dee014d6-cb3c-4abb-9262-165538277a0d';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Héctor Elpidio Acosta Restituyo, conocido como El Torito, es un cantante, compositor y político dominicano nacido en Bonao el 23 de mayo de 1967. Fue la voz principal de "},{"type":"artistReference","attrs":{"occurrenceId":"a7c5e31f-dc2b-42ab-a1a5-af63a7888264","artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band"}},{"type":"text","text":" durante quince años; su salida en 2005, en medio de un litigio con la disquera del grupo, abrió una carrera como solista que lo llevó del merengue a la bachata y el bolero. Es senador por Monseñor Nouel desde 2020."}]},{"type":"paragraph","content":[{"type":"text","text":"Bonao y los primeros grupos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Nació en la comunidad de Los Arroces y se crió en el barrio San Pablo de Bonao, el mayor de dos hermanos e hijo de Elpidio Acosta, profesor de escuela. De niño cantó en el coro de la iglesia mientras se preparaba para ser pelotero. En 1982 ganó un festival de la voz de una emisora local y pasó dos años en un grupo aficionado, La Renovación Quisqueyana; después entró a Los Gentiles, donde tocó el bajo."}]},{"type":"paragraph","content":[{"type":"text","text":"Los Toros Band","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1987 estaba a prueba con "},{"type":"artistReference","attrs":{"occurrenceId":"01cd0c8f-d23b-4f0e-9830-65fde8fc89c1","artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario"}},{"type":"text","text":" —dos meses allí y otros dos con "},{"type":"artistReference","attrs":{"occurrenceId":"0ea3207e-3c6b-4097-9871-da1c76781272","artistId":"db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250","displayText":"Henry Hierro"}},{"type":"text","text":"— cuando el productor Gerardo «el Toro» Díaz lo escuchó cantar en una presentación del grupo en Bonao y le ofreció un puesto en una orquesta que todavía no existía."}]},{"type":"paragraph","content":[{"type":"text","text":"Acosta entró al proyecto en 1990, pero solo para grabar: Díaz mantuvo la agrupación fuera de los escenarios mientras el álbum debut, ¡Se soltaron!, sonaba durante un año en la radio dominicana. La orquesta se presentó en público por primera vez el 4 de mayo de 1991, con Acosta al frente como voz principal y líder, y de esos años viene el apodo. "},{"type":"artistReference","attrs":{"occurrenceId":"d1145dbd-fd54-47b3-bb0c-340951bd92cf","artistId":"1519cbca-ae0a-4ede-924b-244a49c9024e","displayText":"Henry Jiménez"}},{"type":"text","text":" le arregló «La Morenita» al grupo en 1991."}]},{"type":"paragraph","content":[{"type":"text","text":"En unos quince años la agrupación puso a circular «A pasito lento», «La nena del jean», «Las mujeres lo bailan bien», «Perdóname la vida», «Llegó tu marido», «Quizás sí, quizás no» y «Esa morenita»."}]},{"type":"paragraph","content":[{"type":"text","text":"Salió en 2005 por el manejo financiero del grupo: declaró que nunca se le informó cuánto producía una gira ni recibió nada del mercado dominicano del disco. Siguió un pleito público con Los Toros Records, la empresa de Gerardo Díaz y su hermano Juan Pablo, que le impidió presentarse hasta resolverlo. El acuerdo llegó en febrero de 2006, tras el pago de una suma considerable."}]},{"type":"paragraph","content":[{"type":"text","text":"Héctor Acosta & su Orquesta","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Estrenó orquesta propia el 8 de marzo de 2006 en el Jet Set de Santo Domingo. Sigo siendo yo salió el 24 de octubre y llegó a tener cinco temas sonando a la vez en la radio dominicana, entre ellos «Lo que tiene ella», «Me voy» y «¿Cómo me curo?». Había grabado antes un disco de merengue típico, Típico, para J&N en 2004, pero fue en esta etapa cuando la prensa empezó a llamarlo bachatero."}]},{"type":"paragraph","content":[{"type":"text","text":"De Mitad mitad (2008) salieron «Sin perdón» y «Con qué ojos», que entraron al Hot Latin Songs de Billboard, y un remix de «Me voy» con Romeo Santos. Después vinieron Simplemente... El Torito (2009), Oblígame (2010), de donde se desprendió «Me duele la cabeza», y Con el corazón abierto (2012). Grabó «Me vio llorar» con el colombiano Jorge Celedón —su primer vallenato—, «Se me va la voz» con Alejandro Fernández y «Perdóname» con Pepe Aguilar. Merengue y sentimiento (2015) fue nominado al Grammy Latino a mejor álbum tropical contemporáneo, y Este soy yo es de 2022."}]},{"type":"paragraph","content":[{"type":"text","text":"En 2007 celebró quince años de carrera en el United Palace de Nueva York y fue invitado ese septiembre al concierto de Aventura en el Madison Square Garden; volvió al Garden en agosto de 2009, dos noches, junto a Juanes, Alejandro Sanz, Enrique Iglesias, Luis Fonsi, Laura Pausini y "},{"type":"artistReference","attrs":{"occurrenceId":"8d92742f-3fff-4aa1-bf20-f57c76bc699d","artistId":"e8ba0f32-1d96-494d-9861-b1dc3937331e","displayText":"José Alberto \"El Canario\""}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Política","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fue asesor artístico del gobierno de Hipólito Mejía (2000-2004) y apoyó a Miguel Vargas Maldonado en la campaña de 2008, que adoptó como lema una frase suya, «¿Tiene mieo?». En julio de ese año el equipo de campaña de Barack Obama lo designó portavoz para movilizar el voto hispano en Miami y Nueva York. El 17 de febrero de 2011, mientras entregaba un premio en Premios Lo Nuestro, sacó un banderín amarillo con un 4 %, la porción del producto interno bruto que el movimiento dominicano por la educación reclamaba al gobierno. En agosto de 2013 anunció que buscaría la senaduría de Monseñor Nouel; fue electo senador el 16 de agosto de 2020 y reelegido en 2024."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"ACROARTE le entregó El Gran Soberano, su máxima distinción, en 2013, y Orquesta del Año en 2019; antes, en la época del Casandra, ganó entre 2007 y 2010 en orquesta, merengue, bachata y álbum del año. Su salida de Los Toros Band y el litigio que la siguió constituyen uno de los casos documentados de un vocalista dominicano que se separa de una agrupación propiedad de su productor y sostiene la carrera por su cuenta."}]}]}'::jsonb, 'published', 'dee014d6-cb3c-4abb-9262-165538277a0d', 1)
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id =
  (SELECT id FROM editorial_documents WHERE owner_artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND locale='es' AND document_type='artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT id, 'a7c5e31f-dc2b-42ab-a1a5-af63a7888264', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad' FROM editorial_documents
 WHERE owner_artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND locale='es' AND document_type='artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT id, '01cd0c8f-d23b-4f0e-9830-65fde8fc89c1', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4' FROM editorial_documents
 WHERE owner_artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND locale='es' AND document_type='artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT id, '0ea3207e-3c6b-4097-9871-da1c76781272', 'artist', 'db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250' FROM editorial_documents
 WHERE owner_artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND locale='es' AND document_type='artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT id, 'd1145dbd-fd54-47b3-bb0c-340951bd92cf', 'artist', '1519cbca-ae0a-4ede-924b-244a49c9024e' FROM editorial_documents
 WHERE owner_artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND locale='es' AND document_type='artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT id, '8d92742f-3fff-4aa1-bf20-f57c76bc699d', 'artist', 'e8ba0f32-1d96-494d-9861-b1dc3937331e' FROM editorial_documents
 WHERE owner_artist_id='dee014d6-cb3c-4abb-9262-165538277a0d' AND locale='es' AND document_type='artist_biography';
UPDATE artists SET bio_es = 'Héctor Elpidio Acosta Restituyo, conocido como El Torito, es un cantante, compositor y político dominicano nacido en Bonao el 23 de mayo de 1967. Fue la voz principal de Los Toros Band durante quince años; su salida en 2005, en medio de un litigio con la disquera del grupo, abrió una carrera como solista que lo llevó del merengue a la bachata y el bolero. Es senador por Monseñor Nouel desde 2020.

**Bonao y los primeros grupos**

Nació en la comunidad de Los Arroces y se crió en el barrio San Pablo de Bonao, el mayor de dos hermanos e hijo de Elpidio Acosta, profesor de escuela. De niño cantó en el coro de la iglesia mientras se preparaba para ser pelotero. En 1982 ganó un festival de la voz de una emisora local y pasó dos años en un grupo aficionado, La Renovación Quisqueyana; después entró a Los Gentiles, donde tocó el bajo.

**Los Toros Band**

En 1987 estaba a prueba con Los Hermanos Rosario —dos meses allí y otros dos con Henry Hierro— cuando el productor Gerardo «el Toro» Díaz lo escuchó cantar en una presentación del grupo en Bonao y le ofreció un puesto en una orquesta que todavía no existía.

Acosta entró al proyecto en 1990, pero solo para grabar: Díaz mantuvo la agrupación fuera de los escenarios mientras el álbum debut, ¡Se soltaron!, sonaba durante un año en la radio dominicana. La orquesta se presentó en público por primera vez el 4 de mayo de 1991, con Acosta al frente como voz principal y líder, y de esos años viene el apodo. Henry Jiménez le arregló «La Morenita» al grupo en 1991.

En unos quince años la agrupación puso a circular «A pasito lento», «La nena del jean», «Las mujeres lo bailan bien», «Perdóname la vida», «Llegó tu marido», «Quizás sí, quizás no» y «Esa morenita».

Salió en 2005 por el manejo financiero del grupo: declaró que nunca se le informó cuánto producía una gira ni recibió nada del mercado dominicano del disco. Siguió un pleito público con Los Toros Records, la empresa de Gerardo Díaz y su hermano Juan Pablo, que le impidió presentarse hasta resolverlo. El acuerdo llegó en febrero de 2006, tras el pago de una suma considerable.

**Héctor Acosta & su Orquesta**

Estrenó orquesta propia el 8 de marzo de 2006 en el Jet Set de Santo Domingo. Sigo siendo yo salió el 24 de octubre y llegó a tener cinco temas sonando a la vez en la radio dominicana, entre ellos «Lo que tiene ella», «Me voy» y «¿Cómo me curo?». Había grabado antes un disco de merengue típico, Típico, para J&N en 2004, pero fue en esta etapa cuando la prensa empezó a llamarlo bachatero.

De Mitad mitad (2008) salieron «Sin perdón» y «Con qué ojos», que entraron al Hot Latin Songs de Billboard, y un remix de «Me voy» con Romeo Santos. Después vinieron Simplemente... El Torito (2009), Oblígame (2010), de donde se desprendió «Me duele la cabeza», y Con el corazón abierto (2012). Grabó «Me vio llorar» con el colombiano Jorge Celedón —su primer vallenato—, «Se me va la voz» con Alejandro Fernández y «Perdóname» con Pepe Aguilar. Merengue y sentimiento (2015) fue nominado al Grammy Latino a mejor álbum tropical contemporáneo, y Este soy yo es de 2022.

En 2007 celebró quince años de carrera en el United Palace de Nueva York y fue invitado ese septiembre al concierto de Aventura en el Madison Square Garden; volvió al Garden en agosto de 2009, dos noches, junto a Juanes, Alejandro Sanz, Enrique Iglesias, Luis Fonsi, Laura Pausini y José Alberto "El Canario".

**Política**

Fue asesor artístico del gobierno de Hipólito Mejía (2000-2004) y apoyó a Miguel Vargas Maldonado en la campaña de 2008, que adoptó como lema una frase suya, «¿Tiene mieo?». En julio de ese año el equipo de campaña de Barack Obama lo designó portavoz para movilizar el voto hispano en Miami y Nueva York. El 17 de febrero de 2011, mientras entregaba un premio en Premios Lo Nuestro, sacó un banderín amarillo con un 4 %, la porción del producto interno bruto que el movimiento dominicano por la educación reclamaba al gobierno. En agosto de 2013 anunció que buscaría la senaduría de Monseñor Nouel; fue electo senador el 16 de agosto de 2020 y reelegido en 2024.

**Legado**

ACROARTE le entregó El Gran Soberano, su máxima distinción, en 2013, y Orquesta del Año en 2019; antes, en la época del Casandra, ganó entre 2007 y 2010 en orquesta, merengue, bachata y álbum del año. Su salida de Los Toros Band y el litigio que la siguió constituyen uno de los casos documentados de un vocalista dominicano que se separa de una agrupación propiedad de su productor y sostiene la carrera por su cuenta.' WHERE id = 'dee014d6-cb3c-4abb-9262-165538277a0d';

COMMIT;
