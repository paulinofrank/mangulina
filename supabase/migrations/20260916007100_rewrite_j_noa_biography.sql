BEGIN;

-- J NOA (Nohelys Jiménez): rapera de San Cristóbal, cuatro nominaciones al Latin Grammy (2023-2026). Fuentes: base oficial de los Latin Grammy (cuatro nominaciones, ninguna ganada), Diario AS (Edgar Núñez, 1 jun. 2024), El País English (16 nov. 2023), Billboard y TODAY (nominados 2023), nota de prensa de su agencia (16 sep. 2026: Antisistema, RecOrTa y PeGa, Los 5 Golpe, SummerStage/LAMC, NPR Tiny Desk, COLORS). Nacimiento 17 oct. 2005 (fila y MusicBrainz). Campos: primary_role rapper, tag emerging fuera. Premios: cuatro nominaciones Latin Grammy (2023 Autodidacta, 2024 Cabecear, 2025 Sudor y Tinta con Vakeró, 2026 Antisistema; la gala de 2026 es el 12 nov. 2026, sin resultado). Sudor y Tinta figura con el autor Samuel Wilfredo Dilone Castillo, probablemente el civil de Sammy The Greatest: sin enlazar.

INSERT INTO award_categories (award_id, name) SELECT '1d8267d6-ad99-4ca6-8425-1315545ad86e', 'Best Rap/Hip Hop Song' WHERE NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Rap/Hip Hop Song');

INSERT INTO award_categories (award_id, name) SELECT '1d8267d6-ad99-4ca6-8425-1315545ad86e', 'Best Alternative Song' WHERE NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Alternative Song');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT x.id, '1d8267d6-ad99-4ca6-8425-1315545ad86e', (SELECT id FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Rap/Hip Hop Song'), 2023, 'Autodidacta', false, 'latingrammy.com (archivo de la artista, 24.ª edición); Billboard y TODAY (lista de nominados, 2023)'
  FROM artists x WHERE x.slug = 'j-noa';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT x.id, '1d8267d6-ad99-4ca6-8425-1315545ad86e', (SELECT id FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Alternative Song'), 2024, 'Cabecear', false, 'latingrammy.com (archivo de la artista, 25.ª edición)'
  FROM artists x WHERE x.slug = 'j-noa';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT x.id, '1d8267d6-ad99-4ca6-8425-1315545ad86e', (SELECT id FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Rap/Hip Hop Song'), 2025, 'Sudor y Tinta', false, 'latingrammy.com (archivo de la artista, 26.ª edición)'
  FROM artists x WHERE x.slug = 'j-noa';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT x.id, '1d8267d6-ad99-4ca6-8425-1315545ad86e', (SELECT id FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Rap/Hip Hop Song'), 2026, 'Antisistema', false, 'latingrammy.com (archivo de la artista, 27.ª edición; gala el 12 nov 2026, sin resultado)'
  FROM artists x WHERE x.slug = 'j-noa';

UPDATE artists SET primary_role = 'rapper', artist_tags = ARRAY['secular']::text[] WHERE slug = 'j-noa';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"J Noa —Nohelys Jiménez, born on 17 October 2005 in San Cristóbal— is a Dominican rapper and songwriter known as “la hija del rap”, the daughter of rap, who records for Sony Music."}]},{"type":"paragraph","content":[{"type":"text","text":"From San Cristóbal","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She comes from the neighborhood of 5 de Abril in San Cristóbal, where as a child she began rapping in the circles of kids on the street. In a 2024 interview she said she raps about social subjects such as bullying and teenage pregnancy and refuses to follow dembow, the most popular genre in the country, by showing her body to get attention."}]},{"type":"paragraph","content":[{"type":"text","text":"Records","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her 2023 release «Autodidacta» is described as her debut album or debut EP depending on the outlet, and her second album, «Mátense por la Corona», came out on 30 May 2024. She has performed «Arrogante» for the COLORS series (2024) and on NPR Tiny Desk. In 2026 she released the single «Antisistema» in May and the project «RecOrTa y PeGa», and played SummerStage in New York’s Central Park as part of the Latin Alternative Music Conference; her most recent EP, «Los 5 Golpe», brings together Dominican rap figures."}]},{"type":"paragraph","content":[{"type":"text","text":"Latin Grammy nominations","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She has been nominated for a Latin Grammy four years running, 2023 to 2026, and had not won as of the announcement of the fourth nomination in September 2026: in 2023 for Best Rap/Hip Hop Song with «Autodidacta», in 2024 for Best Alternative Song with «Cabecear», in 2025 for Best Rap/Hip Hop Song with «Sudor y Tinta», recorded with "},{"type":"artistReference","attrs":{"occurrenceId":"70cdbb20-fa69-4b8c-904b-0b6b5fc49946","artistId":"ec8ba439-3772-49ff-a218-05f5dc615763","displayText":"Vakeró"}},{"type":"text","text":", and in 2026 for Best Rap/Hip Hop Song with «Antisistema»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"When she was eighteen, the Spanish newspaper Diario AS titled its profile of her “the chosen one” of Dominican rap and noted that she already had a Latin Grammy nomination, a Tiny Desk performance and campaigns for clothing brands."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'j-noa'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'j-noa' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '70cdbb20-fa69-4b8c-904b-0b6b5fc49946', 'artist', 'ec8ba439-3772-49ff-a218-05f5dc615763' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'j-noa' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'J Noa —Nohelys Jiménez, born on 17 October 2005 in San Cristóbal— is a Dominican rapper and songwriter known as “la hija del rap”, the daughter of rap, who records for Sony Music.

**From San Cristóbal**

She comes from the neighborhood of 5 de Abril in San Cristóbal, where as a child she began rapping in the circles of kids on the street. In a 2024 interview she said she raps about social subjects such as bullying and teenage pregnancy and refuses to follow dembow, the most popular genre in the country, by showing her body to get attention.

**Records**

Her 2023 release «Autodidacta» is described as her debut album or debut EP depending on the outlet, and her second album, «Mátense por la Corona», came out on 30 May 2024. She has performed «Arrogante» for the COLORS series (2024) and on NPR Tiny Desk. In 2026 she released the single «Antisistema» in May and the project «RecOrTa y PeGa», and played SummerStage in New York’s Central Park as part of the Latin Alternative Music Conference; her most recent EP, «Los 5 Golpe», brings together Dominican rap figures.

**Latin Grammy nominations**

She has been nominated for a Latin Grammy four years running, 2023 to 2026, and had not won as of the announcement of the fourth nomination in September 2026: in 2023 for Best Rap/Hip Hop Song with «Autodidacta», in 2024 for Best Alternative Song with «Cabecear», in 2025 for Best Rap/Hip Hop Song with «Sudor y Tinta», recorded with Vakeró, and in 2026 for Best Rap/Hip Hop Song with «Antisistema».

**Legacy**

When she was eighteen, the Spanish newspaper Diario AS titled its profile of her “the chosen one” of Dominican rap and noted that she already had a Latin Grammy nomination, a Tiny Desk performance and campaigns for clothing brands.' WHERE slug = 'j-noa';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"J Noa —Nohelys Jiménez, nacida el 17 de octubre de 2005 en San Cristóbal— es una rapera y compositora dominicana conocida como “la hija del rap”, que graba con Sony Music."}]},{"type":"paragraph","content":[{"type":"text","text":"Desde San Cristóbal","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Viene del barrio 5 de Abril de San Cristóbal, donde de niña empezó a rapear en los corrillos de niños de la calle. En una entrevista de 2024 dijo que rapea sobre temas sociales como el bullying y los embarazos adolescentes y que se niega a seguir el dembow, el género más popular del país, mostrando su cuerpo para llamar la atención."}]},{"type":"paragraph","content":[{"type":"text","text":"Grabaciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su lanzamiento de 2023 «Autodidacta» se describe como su álbum debut o su EP debut según el medio, y su segundo álbum, «Mátense por la Corona», salió el 30 de mayo de 2024. Ha interpretado «Arrogante» para la serie COLORS (2024) y en NPR Tiny Desk. En 2026 publicó en mayo el sencillo «Antisistema» y el proyecto «RecOrTa y PeGa», y tocó en el SummerStage del Central Park de Nueva York dentro de la Latin Alternative Music Conference; su EP más reciente, «Los 5 Golpe», reúne a figuras del rap dominicano."}]},{"type":"paragraph","content":[{"type":"text","text":"Nominaciones al Latin Grammy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ha sido nominada al Latin Grammy cuatro años seguidos, de 2023 a 2026, y no había ganado cuando se anunció la cuarta nominación, en septiembre de 2026: en 2023 a Mejor Canción de Rap/Hip Hop con «Autodidacta», en 2024 a Mejor Canción Alternativa con «Cabecear», en 2025 a Mejor Canción de Rap/Hip Hop con «Sudor y Tinta», grabada con "},{"type":"artistReference","attrs":{"occurrenceId":"97ee5090-2814-4bc6-92ff-a3ed81bcb095","artistId":"ec8ba439-3772-49ff-a218-05f5dc615763","displayText":"Vakeró"}},{"type":"text","text":", y en 2026 a Mejor Canción de Rap/Hip Hop con «Antisistema»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cuando tenía dieciocho años, el diario español AS tituló su perfil de ella «the chosen one» del rap dominicano y señaló que ya contaba con una nominación al Latin Grammy, una presentación en Tiny Desk y campañas para marcas de ropa."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'j-noa'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'j-noa' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '97ee5090-2814-4bc6-92ff-a3ed81bcb095', 'artist', 'ec8ba439-3772-49ff-a218-05f5dc615763' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'j-noa' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'J Noa —Nohelys Jiménez, nacida el 17 de octubre de 2005 en San Cristóbal— es una rapera y compositora dominicana conocida como “la hija del rap”, que graba con Sony Music.

**Desde San Cristóbal**

Viene del barrio 5 de Abril de San Cristóbal, donde de niña empezó a rapear en los corrillos de niños de la calle. En una entrevista de 2024 dijo que rapea sobre temas sociales como el bullying y los embarazos adolescentes y que se niega a seguir el dembow, el género más popular del país, mostrando su cuerpo para llamar la atención.

**Grabaciones**

Su lanzamiento de 2023 «Autodidacta» se describe como su álbum debut o su EP debut según el medio, y su segundo álbum, «Mátense por la Corona», salió el 30 de mayo de 2024. Ha interpretado «Arrogante» para la serie COLORS (2024) y en NPR Tiny Desk. En 2026 publicó en mayo el sencillo «Antisistema» y el proyecto «RecOrTa y PeGa», y tocó en el SummerStage del Central Park de Nueva York dentro de la Latin Alternative Music Conference; su EP más reciente, «Los 5 Golpe», reúne a figuras del rap dominicano.

**Nominaciones al Latin Grammy**

Ha sido nominada al Latin Grammy cuatro años seguidos, de 2023 a 2026, y no había ganado cuando se anunció la cuarta nominación, en septiembre de 2026: en 2023 a Mejor Canción de Rap/Hip Hop con «Autodidacta», en 2024 a Mejor Canción Alternativa con «Cabecear», en 2025 a Mejor Canción de Rap/Hip Hop con «Sudor y Tinta», grabada con Vakeró, y en 2026 a Mejor Canción de Rap/Hip Hop con «Antisistema».

**Legado**

Cuando tenía dieciocho años, el diario español AS tituló su perfil de ella «the chosen one» del rap dominicano y señaló que ya contaba con una nominación al Latin Grammy, una presentación en Tiny Desk y campañas para marcas de ropa.' WHERE slug = 'j-noa';

COMMIT;
