BEGIN;

-- Indira Rubiera: cantante de merengue de Los Toros Band y excorista de Rubby Pérez y Fernando Villalona, no una soprano lírica como decía el relleno. La fila la escribía Indhira; la prensa (Univision, 10 abr. 2025; Listín USA, 5 jun. 2019) y sus propias cuentas usan Indira: el nombre pasa a Indira Rubiera y Indhira queda como alias (la ficha de Los Toros Band aún la escribe Indhira). Nadie enlazaba a la ficha. Lugar de nacimiento Santo Domingo sin respaldo: se vacía. Fuentes: Univision, Listín USA, biografía de su Instagram, página República Merengue, Apple Music (EP del musical Arcadia). Conflicto: la ficha de Los Toros Band la sitúa entre 2006 y 2012; una página de Facebook dice que fue parte fundamental de la banda en los noventa y hoy; su biografía dice 'fundadora'; Listín USA dice que la banda la fundaron los hermanos Díaz. El texto atribuye cada versión.

UPDATE artists SET name = 'Indira Rubiera', first_name = 'Indira', aliases = ARRAY['Indhira Rubiera']::text[], birth_place = NULL, province = NULL, primary_role = 'singer', primary_genre = 'merengue', occupations = '["actress","dancer"]'::jsonb, artist_tags = ARRAY['secular']::text[] WHERE slug = 'indhira-rubiera';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Indira Rubiera is a Dominican merengue singer, actress and dancer, known as the female voice of "},{"type":"artistReference","attrs":{"occurrenceId":"b9846e19-13c2-4da0-86d1-11c2c2e80542","artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band"}},{"type":"text","text":" and as a former backing vocalist of "},{"type":"artistReference","attrs":{"occurrenceId":"2929a9d4-68b8-4533-921d-706817e3bcd8","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"6f3f7169-27f4-466d-9e9c-6f2c618800e6","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Los Toros Band","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her own profile presents her as a founder of the orchestra, while the press describes it as founded by the brothers Gerardo and Juan Pablo Díaz; a merengue Facebook page calls her a fundamental part of the band in the 1990s and today. In June 2019 the newspaper Listín USA reported that the band released «Paisaje», a romantic bachata originally by the Italian singer Franco Simone, in her voice with the participation of Harold Adonis Lantigua. Gerardo Díaz said that he and his brother had spent two years looking for a song for her."}]},{"type":"paragraph","content":[{"type":"text","text":"With Rubby Pérez and Fernando Villalona","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her profile describes her as a former backing vocalist of "},{"type":"artistReference","attrs":{"occurrenceId":"c8da76ce-98e9-4be1-ac5b-3c5244900ba1","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"100bd1ff-11d7-4511-8d33-7dc3e53a3d79","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":". When Rubby Pérez died in April 2025, Univision New York interviewed her in her apartment in the Bronx, describing her as a member of his group for more than two decades. She said she had hoped to embrace him once more, and remembered him as an incomparable human being who looked out for the people around him."}]},{"type":"paragraph","content":[{"type":"text","text":"Beyond the orchestra","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She lives in New York and is listed as a guest vocalist on «Elixir Fatal», from the soundtrack EP of the musical «Arcadia, la batalla de las hadas». Her social profiles also describe her as an actress and a dancer."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her career is documented through press coverage of Los Toros Band and interviews with New York’s Dominican media."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'indhira-rubiera'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'indhira-rubiera' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'b9846e19-13c2-4da0-86d1-11c2c2e80542', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'indhira-rubiera' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '2929a9d4-68b8-4533-921d-706817e3bcd8', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'indhira-rubiera' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '6f3f7169-27f4-466d-9e9c-6f2c618800e6', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'indhira-rubiera' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c8da76ce-98e9-4be1-ac5b-3c5244900ba1', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'indhira-rubiera' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '100bd1ff-11d7-4511-8d33-7dc3e53a3d79', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'indhira-rubiera' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Indira Rubiera is a Dominican merengue singer, actress and dancer, known as the female voice of Los Toros Band and as a former backing vocalist of Rubby Pérez and Fernando Villalona.

**Los Toros Band**

Her own profile presents her as a founder of the orchestra, while the press describes it as founded by the brothers Gerardo and Juan Pablo Díaz; a merengue Facebook page calls her a fundamental part of the band in the 1990s and today. In June 2019 the newspaper Listín USA reported that the band released «Paisaje», a romantic bachata originally by the Italian singer Franco Simone, in her voice with the participation of Harold Adonis Lantigua. Gerardo Díaz said that he and his brother had spent two years looking for a song for her.

**With Rubby Pérez and Fernando Villalona**

Her profile describes her as a former backing vocalist of Fernando Villalona and Rubby Pérez. When Rubby Pérez died in April 2025, Univision New York interviewed her in her apartment in the Bronx, describing her as a member of his group for more than two decades. She said she had hoped to embrace him once more, and remembered him as an incomparable human being who looked out for the people around him.

**Beyond the orchestra**

She lives in New York and is listed as a guest vocalist on «Elixir Fatal», from the soundtrack EP of the musical «Arcadia, la batalla de las hadas». Her social profiles also describe her as an actress and a dancer.

**Legacy**

Her career is documented through press coverage of Los Toros Band and interviews with New York’s Dominican media.' WHERE slug = 'indhira-rubiera';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Indira Rubiera es una cantante, actriz y bailarina dominicana de merengue, conocida como la voz femenina de "},{"type":"artistReference","attrs":{"occurrenceId":"322f4a0a-df3a-4c35-984b-ba38406e7793","artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band"}},{"type":"text","text":" y como excorista de "},{"type":"artistReference","attrs":{"occurrenceId":"0ec31885-6cb3-4310-8a1d-023ae7164bd5","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"8039e69b-178c-4fba-84f8-3d7057b065b4","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Los Toros Band","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su propio perfil la presenta como fundadora de la orquesta, mientras que la prensa la describe como fundada por los hermanos Gerardo y Juan Pablo Díaz; una página de Facebook de merengue la llama parte fundamental de la banda en los años noventa y hoy en día. En junio de 2019 el periódico Listín USA informó que la agrupación estrenó «Paisaje», una bachata romántica original del cantante italiano Franco Simone, en su voz y con la participación de Harold Adonis Lantigua. Gerardo Díaz dijo que él y su hermano llevaban dos años buscando un tema para ella."}]},{"type":"paragraph","content":[{"type":"text","text":"Con Rubby Pérez y Fernando Villalona","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su perfil la describe como excorista de "},{"type":"artistReference","attrs":{"occurrenceId":"272c0705-1007-48ab-8450-9107c2eef816","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"a8253d44-6aee-45d1-b32d-ff315827b78a","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":". Cuando murió Rubby Pérez, en abril de 2025, Univision Nueva York la entrevistó en su apartamento del Bronx y la presentó como integrante de su grupo por más de dos décadas. Dijo que tenía la esperanza de darle un último abrazo y lo recordó como un ser humano incomparable que se preocupaba por quienes lo rodeaban."}]},{"type":"paragraph","content":[{"type":"text","text":"Más allá de la orquesta","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Vive en Nueva York y figura como voz invitada en «Elixir Fatal», del EP de la banda sonora del musical «Arcadia, la batalla de las hadas». Sus perfiles en redes la describen también como actriz y bailarina."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su trayectoria está documentada en la cobertura de prensa de Los Toros Band y en entrevistas con los medios dominicanos de Nueva York."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'indhira-rubiera'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'indhira-rubiera' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '322f4a0a-df3a-4c35-984b-ba38406e7793', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'indhira-rubiera' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '0ec31885-6cb3-4310-8a1d-023ae7164bd5', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'indhira-rubiera' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '8039e69b-178c-4fba-84f8-3d7057b065b4', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'indhira-rubiera' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '272c0705-1007-48ab-8450-9107c2eef816', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'indhira-rubiera' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'a8253d44-6aee-45d1-b32d-ff315827b78a', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'indhira-rubiera' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Indira Rubiera es una cantante, actriz y bailarina dominicana de merengue, conocida como la voz femenina de Los Toros Band y como excorista de Rubby Pérez y Fernando Villalona.

**Los Toros Band**

Su propio perfil la presenta como fundadora de la orquesta, mientras que la prensa la describe como fundada por los hermanos Gerardo y Juan Pablo Díaz; una página de Facebook de merengue la llama parte fundamental de la banda en los años noventa y hoy en día. En junio de 2019 el periódico Listín USA informó que la agrupación estrenó «Paisaje», una bachata romántica original del cantante italiano Franco Simone, en su voz y con la participación de Harold Adonis Lantigua. Gerardo Díaz dijo que él y su hermano llevaban dos años buscando un tema para ella.

**Con Rubby Pérez y Fernando Villalona**

Su perfil la describe como excorista de Fernando Villalona y Rubby Pérez. Cuando murió Rubby Pérez, en abril de 2025, Univision Nueva York la entrevistó en su apartamento del Bronx y la presentó como integrante de su grupo por más de dos décadas. Dijo que tenía la esperanza de darle un último abrazo y lo recordó como un ser humano incomparable que se preocupaba por quienes lo rodeaban.

**Más allá de la orquesta**

Vive en Nueva York y figura como voz invitada en «Elixir Fatal», del EP de la banda sonora del musical «Arcadia, la batalla de las hadas». Sus perfiles en redes la describen también como actriz y bailarina.

**Legado**

Su trayectoria está documentada en la cobertura de prensa de Los Toros Band y en entrevistas con los medios dominicanos de Nueva York.' WHERE slug = 'indhira-rubiera';

COMMIT;
