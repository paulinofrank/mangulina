BEGIN;

-- Ficha NUEVA: Chris Hierro. No existía previamente en el catálogo.
-- Productor, compositor y tecladista; hijo de Henry Hierro; tecladista de Alejandro Sanz.

INSERT INTO artists (name, sort_name, type, birth_year, first_name, last_name, stage_name,
                           birth_place, youtube, instagram, aliases,
                           occupations, instruments, genres, gender, ended, province, slug,
                           primary_role, artist_tags, status, primary_genre, has_image, id)
  VALUES ('Chris Hierro', 'Hierro, Chris', 'solo_artist', 1984, 'Chris', 'Hierro', 'Chris Hierro',
          'Estados Unidos', '@hierrochris', 'chris_hierro', '{}'::text[],
          '["songwriter","arranger","musical_director"]'::jsonb, ARRAY['keyboards','piano']::text[], ARRAY['bachata','fusion']::text[], 'male', false,
          'Nacido en el Exterior', 'chris-hierro', 'producer', ARRAY['secular']::text[], 'published', 'merengue', false, 'a7a55237-95c4-4e0c-b79d-be05506ebcb8');

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Chris Hierro —born in the United States in 1984 and raised between New York and the Dominican Republic— is a Dominican songwriter, producer, arranger and keyboardist, the son of the merengue arranger "},{"type":"artistReference","attrs":{"occurrenceId":"41bff6a5-f829-41cc-8a40-56e1aad896bd","artistId":"db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250","displayText":"Henry Hierro"}},{"type":"text","text":" and, for more than a decade, keyboardist and director of the band that accompanies the Spanish singer Alejandro Sanz."}]},{"type":"paragraph","content":[{"type":"text","text":"A musical family","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His father, "},{"type":"artistReference","attrs":{"occurrenceId":"798eb3c3-a9f2-431a-9a61-f7031e937b4e","artistId":"db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250","displayText":"Henry Hierro"}},{"type":"text","text":", was a founder of the New York merengue orchestra "},{"type":"artistReference","attrs":{"occurrenceId":"002bce9b-1649-4aea-9030-4504f775b30e","artistId":"908c3016-2aab-424e-9913-664e5f9a04ac","displayText":"Víctor Roque y La Gran Manzana"}},{"type":"text","text":", and his mother, Lucía Guzmán, was a singer, according to Beller Digital. In 2002 he worked on his father’s album «Volví con mi pianito». Living in New York, he formed the group «Nosotros 3» and worked as a vocalist, pianist and producer, singing backup and playing keyboards for Jerry Rivera, Obie Bermúdez and Alejandro Sanz; a BMI panel biography adds that he toured Europe, the United States and Mexico as a backing singer for those artists and for Thalía. In 2010 he founded the rock band «Taxi Amarillo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Writing, arranging and producing","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"BMI listed his early writing, arranging and production credits in 2015 as "},{"type":"artistReference","attrs":{"occurrenceId":"91dd65bd-1dbf-441d-a334-593b3842cd56","artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"6439cd28-1860-4ada-a40e-91ed23bcbe25","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":", Andy Andy and "},{"type":"artistReference","attrs":{"occurrenceId":"3a53a0ba-b1c4-4968-b7db-e1977b5a4f63","artistId":"7b9ee34b-4438-4032-b827-0b748086e223","displayText":"Wason Brazobán"}},{"type":"text","text":". He is credited as one of the musicians on Carlos Vives’s «Cumbiana» (2020), the album that won the Latin Grammy for Best Contemporary Tropical Album, and in May 2021 he co-wrote and produced "},{"type":"artistReference","attrs":{"occurrenceId":"92f4fb84-2405-4915-ae0b-074c9cf1284d","artistId":"f5937785-a6cb-432a-b1ea-6f6164a77e81","displayText":"Judy Santos"}},{"type":"text","text":"’s «No Me Rendiré», which reached number 24 on Billboard’s Tropical Airplay chart. In 2022 albums he produced for "},{"type":"artistReference","attrs":{"occurrenceId":"e11f39f6-607b-4a23-8430-191ad6b1c89a","artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada"}},{"type":"text","text":" («Resistirá», six songs arranged and produced by him, her sixth Latin Grammy nomination), "},{"type":"artistReference","attrs":{"occurrenceId":"5223e232-acc8-4bee-a2e8-71404d843a20","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":" («Este soy yo») and "},{"type":"artistReference","attrs":{"occurrenceId":"fea28dcd-3b12-41bc-8b38-1cf96f870be7","artistId":"34b63c95-f79a-4f7b-aa1d-426926d12959","displayText":"Pavel Núñez"}},{"type":"text","text":" («Trópico») were nominated for the Latin Grammy, and he also worked as programmer and arranger on Alejandro Sanz’s nominated album «Sanz»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Break Out the Crazy»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"With his wife, the singer and dancer Katya Diaz, he forms the New York duo «Break Out the Crazy». They began working together as backup musicians on Alejandro Sanz’s 2012 tour, and their 2024 EP «Vision» includes «Planta», with guitar by the Dominican musician Yasser Tejada."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As of 2026 he is on tour with Alejandro Sanz, according to his Instagram, and publishes a YouTube channel on music production."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'chris-hierro';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '41bff6a5-f829-41cc-8a40-56e1aad896bd', 'artist', 'db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '798eb3c3-a9f2-431a-9a61-f7031e937b4e', 'artist', 'db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '002bce9b-1649-4aea-9030-4504f775b30e', 'artist', '908c3016-2aab-424e-9913-664e5f9a04ac' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '91dd65bd-1dbf-441d-a334-593b3842cd56', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '6439cd28-1860-4ada-a40e-91ed23bcbe25', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '3a53a0ba-b1c4-4968-b7db-e1977b5a4f63', 'artist', '7b9ee34b-4438-4032-b827-0b748086e223' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '92f4fb84-2405-4915-ae0b-074c9cf1284d', 'artist', 'f5937785-a6cb-432a-b1ea-6f6164a77e81' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'e11f39f6-607b-4a23-8430-191ad6b1c89a', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '5223e232-acc8-4bee-a2e8-71404d843a20', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'fea28dcd-3b12-41bc-8b38-1cf96f870be7', 'artist', '34b63c95-f79a-4f7b-aa1d-426926d12959' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Chris Hierro —born in the United States in 1984 and raised between New York and the Dominican Republic— is a Dominican songwriter, producer, arranger and keyboardist, the son of the merengue arranger Henry Hierro and, for more than a decade, keyboardist and director of the band that accompanies the Spanish singer Alejandro Sanz.

**A musical family**

His father, Henry Hierro, was a founder of the New York merengue orchestra Víctor Roque y La Gran Manzana, and his mother, Lucía Guzmán, was a singer, according to Beller Digital. In 2002 he worked on his father’s album «Volví con mi pianito». Living in New York, he formed the group «Nosotros 3» and worked as a vocalist, pianist and producer, singing backup and playing keyboards for Jerry Rivera, Obie Bermúdez and Alejandro Sanz; a BMI panel biography adds that he toured Europe, the United States and Mexico as a backing singer for those artists and for Thalía. In 2010 he founded the rock band «Taxi Amarillo».

**Writing, arranging and producing**

BMI listed his early writing, arranging and production credits in 2015 as Los Toros Band, Rubby Pérez, Andy Andy and Wason Brazobán. He is credited as one of the musicians on Carlos Vives’s «Cumbiana» (2020), the album that won the Latin Grammy for Best Contemporary Tropical Album, and in May 2021 he co-wrote and produced Judy Santos’s «No Me Rendiré», which reached number 24 on Billboard’s Tropical Airplay chart. In 2022 albums he produced for Milly Quezada («Resistirá», six songs arranged and produced by him, her sixth Latin Grammy nomination), Héctor Acosta “El Torito” («Este soy yo») and Pavel Núñez («Trópico») were nominated for the Latin Grammy, and he also worked as programmer and arranger on Alejandro Sanz’s nominated album «Sanz».

**«Break Out the Crazy»**

With his wife, the singer and dancer Katya Diaz, he forms the New York duo «Break Out the Crazy». They began working together as backup musicians on Alejandro Sanz’s 2012 tour, and their 2024 EP «Vision» includes «Planta», with guitar by the Dominican musician Yasser Tejada.

**Legacy**

As of 2026 he is on tour with Alejandro Sanz, according to his Instagram, and publishes a YouTube channel on music production.' WHERE slug = 'chris-hierro';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Chris Hierro —nacido en Estados Unidos en 1984 y criado entre Nueva York y República Dominicana— es compositor, productor, arreglista y tecladista dominicano, hijo del arreglista de merengue "},{"type":"artistReference","attrs":{"occurrenceId":"d913be25-2091-40b9-8b27-6d47441f9336","artistId":"db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250","displayText":"Henry Hierro"}},{"type":"text","text":" y, desde hace más de una década, tecladista y director de la banda que acompaña al cantautor español Alejandro Sanz."}]},{"type":"paragraph","content":[{"type":"text","text":"Una familia de músicos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su padre, "},{"type":"artistReference","attrs":{"occurrenceId":"bab339a3-a3b3-4363-be0a-e92b851eff6a","artistId":"db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250","displayText":"Henry Hierro"}},{"type":"text","text":", fue uno de los fundadores de la orquesta neoyorquina de merengue "},{"type":"artistReference","attrs":{"occurrenceId":"7bc2fa7a-a876-4091-9d79-2d602dc02991","artistId":"908c3016-2aab-424e-9913-664e5f9a04ac","displayText":"Víctor Roque y La Gran Manzana"}},{"type":"text","text":", y su madre, Lucía Guzmán, era cantante, según Beller Digital. En 2002 trabajó en el álbum de su padre «Volví con mi pianito». Ya en Nueva York formó el grupo «Nosotros 3» y trabajó como vocalista, pianista y productor, cantando en los coros y tocando teclados para Jerry Rivera, Obie Bermúdez y Alejandro Sanz; una biografía de panelista de BMI añade que recorrió Europa, Estados Unidos y México como corista de esos artistas y de Thalía. En 2010 fundó la banda de rock «Taxi Amarillo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Composición, arreglos y producción","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"BMI enumeró en 2015 sus primeros créditos de composición, arreglos y producción: "},{"type":"artistReference","attrs":{"occurrenceId":"57c68c16-4be8-4761-99d9-ca0c8d39fc4a","artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"1da85bbf-a16c-4c05-ab6b-176b26471632","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":", Andy Andy y "},{"type":"artistReference","attrs":{"occurrenceId":"c9867a56-ea4a-4a12-8f16-84f753c942e3","artistId":"7b9ee34b-4438-4032-b827-0b748086e223","displayText":"Wason Brazobán"}},{"type":"text","text":". Figura como uno de los músicos de «Cumbiana» (2020), de Carlos Vives, álbum que ganó el Latin Grammy a Mejor Álbum Tropical Contemporáneo, y en mayo de 2021 coescribió y produjo «No Me Rendiré», de "},{"type":"artistReference","attrs":{"occurrenceId":"b3f9d73a-b5f9-494a-b660-b6df026b6e88","artistId":"f5937785-a6cb-432a-b1ea-6f6164a77e81","displayText":"Judy Santos"}},{"type":"text","text":", que llegó al puesto 24 del listado Tropical Airplay de Billboard. En 2022 fueron nominados al Latin Grammy álbumes que produjo para "},{"type":"artistReference","attrs":{"occurrenceId":"d5e4f7a8-fa70-48ce-b1b0-e361d9bf89a3","artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada"}},{"type":"text","text":" («Resistirá», seis canciones arregladas y producidas por él, su sexta nominación al Latin Grammy), "},{"type":"artistReference","attrs":{"occurrenceId":"e6897c3c-96cb-49e7-881c-9078e6f14787","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":" («Este soy yo») y "},{"type":"artistReference","attrs":{"occurrenceId":"3aae14f8-bde8-495f-aac7-473d5fd3c2c5","artistId":"34b63c95-f79a-4f7b-aa1d-426926d12959","displayText":"Pavel Núñez"}},{"type":"text","text":" («Trópico»), y además trabajó como programador y arreglista en «Sanz», álbum nominado de Alejandro Sanz."}]},{"type":"paragraph","content":[{"type":"text","text":"«Break Out the Crazy»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Con su esposa, la cantante y bailarina Katya Diaz, forma el dúo neoyorquino «Break Out the Crazy». Empezaron a trabajar juntos como músicos de apoyo en la gira de 2012 de Alejandro Sanz, y su EP de 2024, «Vision», incluye «Planta», con guitarra del músico dominicano Yasser Tejada."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2026 está de gira con Alejandro Sanz, según su Instagram, y publica un canal de YouTube sobre producción musical."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'chris-hierro';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd913be25-2091-40b9-8b27-6d47441f9336', 'artist', 'db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'bab339a3-a3b3-4363-be0a-e92b851eff6a', 'artist', 'db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '7bc2fa7a-a876-4091-9d79-2d602dc02991', 'artist', '908c3016-2aab-424e-9913-664e5f9a04ac' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '57c68c16-4be8-4761-99d9-ca0c8d39fc4a', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '1da85bbf-a16c-4c05-ab6b-176b26471632', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c9867a56-ea4a-4a12-8f16-84f753c942e3', 'artist', '7b9ee34b-4438-4032-b827-0b748086e223' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'b3f9d73a-b5f9-494a-b660-b6df026b6e88', 'artist', 'f5937785-a6cb-432a-b1ea-6f6164a77e81' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd5e4f7a8-fa70-48ce-b1b0-e361d9bf89a3', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'e6897c3c-96cb-49e7-881c-9078e6f14787', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '3aae14f8-bde8-495f-aac7-473d5fd3c2c5', 'artist', '34b63c95-f79a-4f7b-aa1d-426926d12959' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chris-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Chris Hierro —nacido en Estados Unidos en 1984 y criado entre Nueva York y República Dominicana— es compositor, productor, arreglista y tecladista dominicano, hijo del arreglista de merengue Henry Hierro y, desde hace más de una década, tecladista y director de la banda que acompaña al cantautor español Alejandro Sanz.

**Una familia de músicos**

Su padre, Henry Hierro, fue uno de los fundadores de la orquesta neoyorquina de merengue Víctor Roque y La Gran Manzana, y su madre, Lucía Guzmán, era cantante, según Beller Digital. En 2002 trabajó en el álbum de su padre «Volví con mi pianito». Ya en Nueva York formó el grupo «Nosotros 3» y trabajó como vocalista, pianista y productor, cantando en los coros y tocando teclados para Jerry Rivera, Obie Bermúdez y Alejandro Sanz; una biografía de panelista de BMI añade que recorrió Europa, Estados Unidos y México como corista de esos artistas y de Thalía. En 2010 fundó la banda de rock «Taxi Amarillo».

**Composición, arreglos y producción**

BMI enumeró en 2015 sus primeros créditos de composición, arreglos y producción: Los Toros Band, Rubby Pérez, Andy Andy y Wason Brazobán. Figura como uno de los músicos de «Cumbiana» (2020), de Carlos Vives, álbum que ganó el Latin Grammy a Mejor Álbum Tropical Contemporáneo, y en mayo de 2021 coescribió y produjo «No Me Rendiré», de Judy Santos, que llegó al puesto 24 del listado Tropical Airplay de Billboard. En 2022 fueron nominados al Latin Grammy álbumes que produjo para Milly Quezada («Resistirá», seis canciones arregladas y producidas por él, su sexta nominación al Latin Grammy), Héctor Acosta “El Torito” («Este soy yo») y Pavel Núñez («Trópico»), y además trabajó como programador y arreglista en «Sanz», álbum nominado de Alejandro Sanz.

**«Break Out the Crazy»**

Con su esposa, la cantante y bailarina Katya Diaz, forma el dúo neoyorquino «Break Out the Crazy». Empezaron a trabajar juntos como músicos de apoyo en la gira de 2012 de Alejandro Sanz, y su EP de 2024, «Vision», incluye «Planta», con guitarra del músico dominicano Yasser Tejada.

**Legado**

En 2026 está de gira con Alejandro Sanz, según su Instagram, y publica un canal de YouTube sobre producción musical.' WHERE slug = 'chris-hierro';

COMMIT;
