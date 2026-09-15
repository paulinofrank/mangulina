BEGIN;

-- Ficha de Janina Rosado.
--
-- La biografía de relleno la llamaba "vocalist", contradiciendo los propios campos de la
-- fila (pianist, arranger, conductor, producer) y todas las fuentes: nunca ha sido cantante.
-- birth_place/province: Santiago Rodríguez (la fila decía Santo Domingo / Distrito Nacional;
-- coinciden Hoy Digital, El Caribe, Diario Libre y El Nacional). Año de nacimiento no
-- publicado por decisión propia de la artista: no se fija.

UPDATE artists SET birth_place = 'Santiago Rodríguez', province = 'Santiago Rodríguez' WHERE slug = 'janina-rosado';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2024, 'Mambo 23 (con Juan Luis Guerra Y 4.40)', true, 'IMDb (páginas de premios de Janina Rosado y de Juan Luis Guerra, crédito compartido)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'janina-rosado' AND a.name = 'Latin Grammy' AND cat.name = 'Record of the Year'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2024);

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2024, 'Radio Güira (con Juan Luis Guerra Y 4.40)', true, 'IMDb (páginas de premios de Janina Rosado y de Juan Luis Guerra, crédito compartido)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'janina-rosado' AND a.name = 'Latin Grammy' AND cat.name = 'Album of the Year'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2024);

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Leading Ladies of Entertainment' FROM awards a WHERE a.name = 'Latin Grammy'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Leading Ladies of Entertainment');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2022, 'Reconocimiento especial de la Academia Latina de la Grabación', true, 'Diario Libre (12 oct 2022); El Día (12 oct 2022); Noticias SIN (16 nov 2022); latingrammy.com'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'janina-rosado' AND a.name = 'Latin Grammy' AND cat.name = 'Leading Ladies of Entertainment'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2022);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Janina Rosado — born 17 December in Santiago Rodríguez — is a Dominican pianist, arranger and musical director, a nine-time Latin Grammy winner and one of the few women to have built a career of that scale among Dominican popular-music pianists."}]},{"type":"paragraph","content":[{"type":"text","text":"Her father’s ear","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her father, Juan Rosado, was one of the country’s most important music educators, and many leading Dominican musicians passed through his teaching. It was from him that she got her first musical training, in Santiago Rodríguez, in the country’s Línea Noroeste."}]},{"type":"paragraph","content":[{"type":"text","text":"Twelve years before the call","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She built her career in the capital through hard, largely unglamorous work: house pianist and arranger for hotel orchestras — including years as musical director at the Hotel Jaragua, supplying arrangements for its resident bands — and stints with orchestras such as "},{"type":"artistReference","attrs":{"occurrenceId":"3f3406e6-ceb8-4db4-ba0c-c351cdde756c","artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura"}},{"type":"text","text":"’s, playing nightly sets that often ran past four in the morning and, at points, directing three resident orchestras at once."}]},{"type":"paragraph","content":[{"type":"text","text":"«Juan Luis Guerra Y 4.40»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Since 1998 she has been "},{"type":"artistReference","attrs":{"occurrenceId":"f9628911-7faa-488a-b83e-3c2ccfc7b045","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":"’s pianist and musical director, and later a producer on his recordings — a role that put her name on the credits of «Mambo 23» and «Radio Güira», which won the Latin Grammy for Record of the Year and Album of the Year, respectively, in 2024. In 2022 the Latin Recording Academy gave her its Leading Ladies of Entertainment special recognition; by then the Academy itself was already describing her as a nine-time Latin Grammy winner."}]},{"type":"paragraph","content":[{"type":"text","text":"Off the stage","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2023 she published «El merengue contemporáneo, manual para la base del ritmo», the country’s first method book for the genre’s rhythm section, and she runs her own recording studio, where she works on other artists’ records."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A photograph of her at a piano in a hotel ballroom, decades ago, is still how most Dominicans first learned who Janina Rosado was; the credits on nine Latin Grammy trophies are how the rest of the world eventually caught up."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'janina-rosado'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'janina-rosado' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3f3406e6-ceb8-4db4-ba0c-c351cdde756c', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'janina-rosado' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f9628911-7faa-488a-b83e-3c2ccfc7b045', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'janina-rosado' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Janina Rosado — born 17 December in Santiago Rodríguez — is a Dominican pianist, arranger and musical director, a nine-time Latin Grammy winner and one of the few women to have built a career of that scale among Dominican popular-music pianists.

**Her father’s ear**

Her father, Juan Rosado, was one of the country’s most important music educators, and many leading Dominican musicians passed through his teaching. It was from him that she got her first musical training, in Santiago Rodríguez, in the country’s Línea Noroeste.

**Twelve years before the call**

She built her career in the capital through hard, largely unglamorous work: house pianist and arranger for hotel orchestras — including years as musical director at the Hotel Jaragua, supplying arrangements for its resident bands — and stints with orchestras such as Johnny Ventura’s, playing nightly sets that often ran past four in the morning and, at points, directing three resident orchestras at once.

**«Juan Luis Guerra Y 4.40»**

Since 1998 she has been Juan Luis Guerra 4.40’s pianist and musical director, and later a producer on his recordings — a role that put her name on the credits of «Mambo 23» and «Radio Güira», which won the Latin Grammy for Record of the Year and Album of the Year, respectively, in 2024. In 2022 the Latin Recording Academy gave her its Leading Ladies of Entertainment special recognition; by then the Academy itself was already describing her as a nine-time Latin Grammy winner.

**Off the stage**

In 2023 she published «El merengue contemporáneo, manual para la base del ritmo», the country’s first method book for the genre’s rhythm section, and she runs her own recording studio, where she works on other artists’ records.

**Legacy**

A photograph of her at a piano in a hotel ballroom, decades ago, is still how most Dominicans first learned who Janina Rosado was; the credits on nine Latin Grammy trophies are how the rest of the world eventually caught up.' WHERE slug = 'janina-rosado';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Janina Rosado —nacida el 17 de diciembre en Santiago Rodríguez— es pianista, arreglista y directora musical dominicana, ganadora de nueve Latin Grammy y una de las pocas mujeres que ha construido una carrera de esa escala entre los pianistas de la música popular dominicana."}]},{"type":"paragraph","content":[{"type":"text","text":"El oído de su padre","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su padre, Juan Rosado, fue uno de los educadores musicales más importantes del país, y por sus manos pasaron muchos de los grandes músicos dominicanos. De él recibió su primera formación musical, en Santiago Rodríguez, en la Línea Noroeste."}]},{"type":"paragraph","content":[{"type":"text","text":"Doce años antes de la llamada","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Construyó su carrera en la capital a base de trabajo duro y poco vistoso: pianista y arreglista de planta de orquestas de hotel —entre ellas varios años como directora musical del Hotel Jaragua, aportando arreglos a las bandas residentes— y pasos por orquestas como la de "},{"type":"artistReference","attrs":{"occurrenceId":"178ba8b5-60bc-42d7-bbb3-6f8c00b31cd6","artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura"}},{"type":"text","text":", tocando tandas nocturnas que a menudo terminaban pasadas las cuatro de la madrugada y, en algún momento, dirigiendo tres orquestas de planta a la vez."}]},{"type":"paragraph","content":[{"type":"text","text":"«Juan Luis Guerra Y 4.40»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Desde 1998 es la pianista y directora musical de "},{"type":"artistReference","attrs":{"occurrenceId":"e451cd47-c9f1-4593-bf3c-21250ad803ac","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":", y después productora de sus grabaciones —un papel que puso su nombre en los créditos de «Mambo 23» y «Radio Güira», ganadoras del Latin Grammy a Grabación del Año y Álbum del Año, respectivamente, en 2024. En 2022 la Academia Latina de la Grabación le entregó su reconocimiento especial Leading Ladies of Entertainment; para entonces la propia Academia ya la describía como ganadora de nueve Latin Grammy."}]},{"type":"paragraph","content":[{"type":"text","text":"Fuera del escenario","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2023 publicó «El merengue contemporáneo, manual para la base del ritmo», el primer método del país para la sección rítmica del género, y dirige su propio estudio de grabación, donde trabaja en discos de otros artistas."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Una fotografía suya al piano en el salón de un hotel, décadas atrás, sigue siendo cómo la mayoría de los dominicanos conoció por primera vez a Janina Rosado; los créditos en nueve trofeos del Latin Grammy son cómo el resto del mundo terminó por alcanzarla."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'janina-rosado'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'janina-rosado' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '178ba8b5-60bc-42d7-bbb3-6f8c00b31cd6', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'janina-rosado' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e451cd47-c9f1-4593-bf3c-21250ad803ac', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'janina-rosado' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Janina Rosado —nacida el 17 de diciembre en Santiago Rodríguez— es pianista, arreglista y directora musical dominicana, ganadora de nueve Latin Grammy y una de las pocas mujeres que ha construido una carrera de esa escala entre los pianistas de la música popular dominicana.

**El oído de su padre**

Su padre, Juan Rosado, fue uno de los educadores musicales más importantes del país, y por sus manos pasaron muchos de los grandes músicos dominicanos. De él recibió su primera formación musical, en Santiago Rodríguez, en la Línea Noroeste.

**Doce años antes de la llamada**

Construyó su carrera en la capital a base de trabajo duro y poco vistoso: pianista y arreglista de planta de orquestas de hotel —entre ellas varios años como directora musical del Hotel Jaragua, aportando arreglos a las bandas residentes— y pasos por orquestas como la de Johnny Ventura, tocando tandas nocturnas que a menudo terminaban pasadas las cuatro de la madrugada y, en algún momento, dirigiendo tres orquestas de planta a la vez.

**«Juan Luis Guerra Y 4.40»**

Desde 1998 es la pianista y directora musical de Juan Luis Guerra 4.40, y después productora de sus grabaciones —un papel que puso su nombre en los créditos de «Mambo 23» y «Radio Güira», ganadoras del Latin Grammy a Grabación del Año y Álbum del Año, respectivamente, en 2024. En 2022 la Academia Latina de la Grabación le entregó su reconocimiento especial Leading Ladies of Entertainment; para entonces la propia Academia ya la describía como ganadora de nueve Latin Grammy.

**Fuera del escenario**

En 2023 publicó «El merengue contemporáneo, manual para la base del ritmo», el primer método del país para la sección rítmica del género, y dirige su propio estudio de grabación, donde trabaja en discos de otros artistas.

**Legado**

Una fotografía suya al piano en el salón de un hotel, décadas atrás, sigue siendo cómo la mayoría de los dominicanos conoció por primera vez a Janina Rosado; los créditos en nueve trofeos del Latin Grammy son cómo el resto del mundo terminó por alcanzarla.' WHERE slug = 'janina-rosado';

COMMIT;
