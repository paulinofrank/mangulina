BEGIN;

-- Ficha NUEVA: Chicho Severino. No existía previamente en el catálogo.
-- Bachatero dominicano, "El Millonario"; fuentes: Wikipedia (es), Bachata Republic, El Caribe.

INSERT INTO artists (name, sort_name, type, birth_year, first_name, last_name, stage_name,
                           date_of_birth, birth_place, youtube, facebook, instagram, aliases,
                           occupations, instruments, genres, gender, ended, province, slug,
                           primary_role, artist_tags, status, primary_genre, has_image, id)
  VALUES ('Chicho Severino', 'Severino, Chicho', 'solo_artist', 1973, 'Francisco', 'Severino', 'Chicho Severino',
          '1973-06-06', 'La Jagua de Yamasá', '@chichoseverinoMUNDIAL', 'chichoseverinomundial', 'chichoseverinooficial_',
          ARRAY['El Millonario']::text[], '["guitarist","composer"]'::jsonb, ARRAY['guitar']::text[], '{}'::text[], 'male', false, 'Monte Plata', 'chicho-severino',
          'singer', ARRAY['secular','legend']::text[], 'published', 'bachata', false, '42bde48e-872d-453e-9c6b-d400551918d0');

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Chicho Severino —born Francisco Severino in La Jagua de Yamasá, Monte Plata, on 6 June 1973— is a Dominican bachata singer and guitarist known as «El Millonario», one of the amargue-era artists whose breakthrough in the second half of the 1990s came alongside stars like "},{"type":"artistReference","attrs":{"occurrenceId":"b00e1dd9-b69b-4978-8209-661dfab6bd09","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":", Frank Reyes and Zacarías Ferreira."}]},{"type":"paragraph","content":[{"type":"text","text":"A guitar at twelve","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began playing guitar at twelve, inspired by the singer "},{"type":"artistReference","attrs":{"occurrenceId":"50c83da8-a048-439a-96de-e3e02e334826","artistId":"3ae30a9a-5369-4084-8162-b2d470263f1e","displayText":"Rafael Encarnación"}},{"type":"text","text":", and formed his first group as a young man in his native Yamasá."}]},{"type":"paragraph","content":[{"type":"text","text":"«Al Que le Debo que Se Aguante»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Signed to Nepo Núñez Récords, he released his debut single, «Al Que le Debo que Se Aguante», which sold more than 50,000 copies nationally and launched his career. The label followed it with «Ya Pagué», «Castigo de Amor» and «Millonario y Qué» — the last of which gave him the nickname that has stayed with him ever since. Severino has said he owes part of his career to "},{"type":"artistReference","attrs":{"occurrenceId":"d084fb10-c826-4712-a1a8-bb8739db3697","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":", who gave him an early chance to perform on a shared stage."}]},{"type":"paragraph","content":[{"type":"text","text":"Five albums since «17 Grandes Éxitos»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His studio albums since then include «17 Grandes Éxitos» (1996), «Millonario y Qué» (1998), «Me Enlié de Nuevo» (2000), «Nunca Me Faltes» (2005) and «Enfermo del Bolsillo» (2012). He now records for MMG Récords."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Severino returned to wide attention in 2023 and 2024 when «Goza Tu Vida» went viral, fueling hopes of recognition at the Premios Soberano, and again in 2026 with «I Love You», his first single sung entirely in English, which drew renewed domestic and international press coverage. He has since been honored for his trajectory at the Picardía Urbana Awards and continues to tour the Dominican diaspora in Puerto Rico and the northeastern United States."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'chicho-severino';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'b00e1dd9-b69b-4978-8209-661dfab6bd09', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chicho-severino' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '50c83da8-a048-439a-96de-e3e02e334826', 'artist', '3ae30a9a-5369-4084-8162-b2d470263f1e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chicho-severino' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd084fb10-c826-4712-a1a8-bb8739db3697', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chicho-severino' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Chicho Severino —born Francisco Severino in La Jagua de Yamasá, Monte Plata, on 6 June 1973— is a Dominican bachata singer and guitarist known as «El Millonario», one of the amargue-era artists whose breakthrough in the second half of the 1990s came alongside stars like Antony Santos, Frank Reyes and Zacarías Ferreira.

**A guitar at twelve**

He began playing guitar at twelve, inspired by the singer Rafael Encarnación, and formed his first group as a young man in his native Yamasá.

**«Al Que le Debo que Se Aguante»**

Signed to Nepo Núñez Récords, he released his debut single, «Al Que le Debo que Se Aguante», which sold more than 50,000 copies nationally and launched his career. The label followed it with «Ya Pagué», «Castigo de Amor» and «Millonario y Qué» — the last of which gave him the nickname that has stayed with him ever since. Severino has said he owes part of his career to Antony Santos, who gave him an early chance to perform on a shared stage.

**Five albums since «17 Grandes Éxitos»**

His studio albums since then include «17 Grandes Éxitos» (1996), «Millonario y Qué» (1998), «Me Enlié de Nuevo» (2000), «Nunca Me Faltes» (2005) and «Enfermo del Bolsillo» (2012). He now records for MMG Récords.

**Legacy**

Severino returned to wide attention in 2023 and 2024 when «Goza Tu Vida» went viral, fueling hopes of recognition at the Premios Soberano, and again in 2026 with «I Love You», his first single sung entirely in English, which drew renewed domestic and international press coverage. He has since been honored for his trajectory at the Picardía Urbana Awards and continues to tour the Dominican diaspora in Puerto Rico and the northeastern United States.' WHERE slug = 'chicho-severino';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Chicho Severino —nacido Francisco Severino en La Jagua de Yamasá, Monte Plata, el 6 de junio de 1973— es cantante y guitarrista dominicano de bachata, conocido como «El Millonario», uno de los artistas de la época del amargue cuyo despegue en la segunda mitad de los años noventa llegó junto a figuras como "},{"type":"artistReference","attrs":{"occurrenceId":"500cfc70-6f15-4a0a-bc6a-9030f07f0017","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":", Frank Reyes y Zacarías Ferreira."}]},{"type":"paragraph","content":[{"type":"text","text":"Una guitarra a los doce años","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó a tocar guitarra a los doce años, inspirado por el cantante "},{"type":"artistReference","attrs":{"occurrenceId":"685006cf-2cfa-4919-adeb-700c17f80b2f","artistId":"3ae30a9a-5369-4084-8162-b2d470263f1e","displayText":"Rafael Encarnación"}},{"type":"text","text":", y formó su primera agrupación siendo joven en su Yamasá natal."}]},{"type":"paragraph","content":[{"type":"text","text":"«Al Que le Debo que Se Aguante»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Firmado con Nepo Núñez Récords, lanzó su sencillo debut, «Al Que le Debo que Se Aguante», que vendió más de 50 000 copias a nivel nacional y lanzó su carrera. El sello lo siguió con «Ya Pagué», «Castigo de Amor» y «Millonario y Qué» —esta última le dio el apodo que lo ha acompañado desde entonces—. Severino ha dicho que le debe parte de su carrera a "},{"type":"artistReference","attrs":{"occurrenceId":"7043267b-98bb-4ab6-837d-88fb100fdf61","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":", quien le dio una oportunidad temprana de presentarse en una tarima compartida."}]},{"type":"paragraph","content":[{"type":"text","text":"Cinco discos desde «17 Grandes Éxitos»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Sus álbumes de estudio desde entonces incluyen «17 Grandes Éxitos» (1996), «Millonario y Qué» (1998), «Me Enlié de Nuevo» (2000), «Nunca Me Faltes» (2005) y «Enfermo del Bolsillo» (2012). Actualmente graba para MMG Récords."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Severino volvió a la atención masiva en 2023 y 2024 cuando «Goza Tu Vida» se volvió viral, alimentando la esperanza de un reconocimiento en los Premios Soberano, y de nuevo en 2026 con «I Love You», su primer sencillo cantado íntegramente en inglés, que atrajo renovada cobertura de prensa nacional e internacional. Desde entonces ha sido reconocido por su trayectoria en los Picardía Urbana Awards y continúa de gira por la diáspora dominicana en Puerto Rico y el noreste de Estados Unidos."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'chicho-severino';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '500cfc70-6f15-4a0a-bc6a-9030f07f0017', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chicho-severino' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '685006cf-2cfa-4919-adeb-700c17f80b2f', 'artist', '3ae30a9a-5369-4084-8162-b2d470263f1e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chicho-severino' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '7043267b-98bb-4ab6-837d-88fb100fdf61', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chicho-severino' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Chicho Severino —nacido Francisco Severino en La Jagua de Yamasá, Monte Plata, el 6 de junio de 1973— es cantante y guitarrista dominicano de bachata, conocido como «El Millonario», uno de los artistas de la época del amargue cuyo despegue en la segunda mitad de los años noventa llegó junto a figuras como Antony Santos, Frank Reyes y Zacarías Ferreira.

**Una guitarra a los doce años**

Empezó a tocar guitarra a los doce años, inspirado por el cantante Rafael Encarnación, y formó su primera agrupación siendo joven en su Yamasá natal.

**«Al Que le Debo que Se Aguante»**

Firmado con Nepo Núñez Récords, lanzó su sencillo debut, «Al Que le Debo que Se Aguante», que vendió más de 50 000 copias a nivel nacional y lanzó su carrera. El sello lo siguió con «Ya Pagué», «Castigo de Amor» y «Millonario y Qué» —esta última le dio el apodo que lo ha acompañado desde entonces—. Severino ha dicho que le debe parte de su carrera a Antony Santos, quien le dio una oportunidad temprana de presentarse en una tarima compartida.

**Cinco discos desde «17 Grandes Éxitos»**

Sus álbumes de estudio desde entonces incluyen «17 Grandes Éxitos» (1996), «Millonario y Qué» (1998), «Me Enlié de Nuevo» (2000), «Nunca Me Faltes» (2005) y «Enfermo del Bolsillo» (2012). Actualmente graba para MMG Récords.

**Legado**

Severino volvió a la atención masiva en 2023 y 2024 cuando «Goza Tu Vida» se volvió viral, alimentando la esperanza de un reconocimiento en los Premios Soberano, y de nuevo en 2026 con «I Love You», su primer sencillo cantado íntegramente en inglés, que atrajo renovada cobertura de prensa nacional e internacional. Desde entonces ha sido reconocido por su trayectoria en los Picardía Urbana Awards y continúa de gira por la diáspora dominicana en Puerto Rico y el noreste de Estados Unidos.' WHERE slug = 'chicho-severino';

COMMIT;
