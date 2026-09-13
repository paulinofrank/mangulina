BEGIN;

-- Rewrite the catalogue entry for Eladio Romero Santos.
--
-- Eladio Romero Santos. Quinta de las dieciséis fichas publicadas que estaban
-- EN BLANCO. Uno de los fundadores de la bachata grabada y el hombre que
-- sostuvo el merengue con guitarra cuando el género se había ido a las
-- orquestas, y su página no decía nada.
--
-- LO QUE YA TENÍA LA FILA SE CONFIRMA Y NO SE TOCA: 12 de febrero de 1937,
-- Cenoví, provincia Duarte; muerte el 24 de abril de 2001; ended en true.
-- Coinciden Wikipedia en español, Bachata Republic y el blog Gente que hacen la
-- historia. La edad de 64 años que da Wikipedia cuadra con las dos fechas.
--
-- SE COMPLETA EL NOMBRE: Eladio Antonio Romero Santos, que da el blog
-- biográfico. Y EL APODO, "EL MAESTRO", que Wikipedia registra como seudónimo.
--
-- NO SE ESCRIBE DE QUÉ MURIÓ. Wikipedia lo pone en el encabezado y hasta tiene
-- categoría para eso; aquí no va, por la regla de vida privada. La guarda de
-- mk.cjs lo rechazaría de todos modos.
--
-- TAMPOCO SE NOMBRA LA ENFERMEDAD DE 1995. Wikipedia dice que contrajo artritis
-- y que por eso dejó la guitarra. El HECHO PROFESIONAL sí entra -- desde
-- entonces se presentó solo como cantante --, porque cambia su oficio y es
-- verificable. El diagnóstico no.
--
-- UNA AFIRMACIÓN QUE REBAJO A PROPÓSITO. Wikipedia dice que en 1972 grabó "el
-- primer merengue con guitarra" y que fue "el único que cantaba merengue y
-- bachata". Las dos cosas son superlativos dudosos: el merengue de guitarra es
-- anterior a 1972 y no era el único que cruzaba géneros. Lo que sí sostienen
-- todas las fuentes, y es lo que se escribe, es que "La Muñeca" fue el disco
-- que lo hizo conocido dentro y fuera del país, y que mantuvo viva esa forma
-- cuando el merengue había pasado a las orquestas y al perico ripiao.
--
-- EL DATO MÁS INTERESANTE Y EL MENOS CONOCIDO: tocaba en clubes de campo y
-- fiestas patronales, y por eso NO SUFRIÓ LA MARGINACIÓN que cayó sobre otros
-- bachateros de su generación. Lo dicen Wikipedia en inglés y DBpedia. Explica
-- una carrera de cuarenta años sin el estigma que arrastraron sus colegas.
--
-- TRES ENLACES: jose-manuel-calderon y cuco-valoy, con quienes empezó a grabar
-- al mismo tiempo, según Wikipedia; y francisco-ulloa, que aparece acreditado
-- en el título mismo de su disco de 1981.
--
-- GENRES LLEVA MERENGUE. primary_genre se queda en bachata, que es correcto,
-- pero su obra es de los dos géneros y el campo genres existe justo para eso.
-- No repite el primario, así que no viola la higiene de campos.
--
-- OCCUPATIONS: guitarist. instruments: voz y guitarra. Aquí sí hay prueba --
-- Wikipedia lo lista como guitarrista, la biografía cuenta cómo aprendió, y
-- tiene un disco titulado "El Sabor de Mi Guitarra".
--
-- SIN REDES, Y ES LO CORRECTO: murió en 2001. No se le inventa una cuenta.
--
-- FUENTES: Wikipedia en español (biografía y discografía completa). Wikipedia
-- en inglés y DBpedia para los clubes de campo. Bachata Republic. El blog Gente
-- que hacen la historia para el nombre completo.
--
-- NOMBRES NUEVOS PARA LA LISTA DE FALTANTES: Juan Cesario, en cuyo trío empezó
-- tocando maracas; y el Conjunto San Rafael, que comparte el disco de 1981.
--
-- Applied directly over DATABASE_URL as part of an editorial pass. No Vercel
-- function ran and nothing was revalidated; the profile reaches the public site
-- on its own within the 31-day ISR fallback for artist profiles, or sooner if a
-- targeted revalidation is run for the slug.
--
-- This file reproduces the change from the pre-pass state. Both it and its
-- rollback were generated from state captured live either side of the write,
-- not reconstructed afterwards.

UPDATE artists SET
       name = 'Eladio Romero Santos',
       sort_name = 'Romero Santos, Eladio Antonio',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1937-02-12',
       birth_year = 1937,
       date_of_death = '2001-04-24',
       birth_place = 'Cenoví',
       province = 'Duarte',
       first_name = 'Eladio',
       middle_name = 'Antonio',
       last_name = 'Romero',
       second_last_name = 'Santos',
       stage_name = 'Eladio Romero Santos',
       aliases = ARRAY['El Maestro']::text[],
       occupations = '["guitarist"]'::jsonb,
       instruments = ARRAY['voice', 'guitar']::text[],
       genres = ARRAY['merengue']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Bachata singer and guitarist known as El Maestro; sustained merengue played on guitar across four decades',
       bio_en = 'Eladio Antonio Romero Santos, known as El Maestro, was a Dominican bachata singer and guitarist. He began recording in the first years of the genre and worked for more than four decades, and he is remembered as much for sustaining merengue played on guitar as for his bachata.

**Cenoví**

He was born in 1937 in Cenoví, a rural community outside San Francisco de Macorís, in the province of Duarte. He started on maracas in a local trio, learned guitar by watching, and by fifteen was leading a trio of his own as its singer. He entered a festival at the San Francisco radio station La Voz del Progreso and placed third.

**The first recordings**

His first record, the bachata Tomando en Tu Mesa, appeared in 1966. He began recording at the same time as José Manuel Calderón and Cuco Valoy, in the years when bachata was first being committed to disc.

His guitar playing was plainer than that of other bachata guitarists of the period. It was also strongly rhythmic, built for dancing rather than for display, and that is the quality his records are known for.

**Merengue on guitar**

La Muñeca, recorded in 1972, was the record that carried his name across the country and abroad. It was a merengue played on guitar, at a point when merengue had moved to the orchestras on one side and to the accordion of perico ripiao on the other.

He went on working in that form for the rest of his career, and his catalogue is one of the main reasons guitar merengue survived as recorded music rather than only as a rural memory.

**The country clubs**

He played mostly at rural social clubs and at patron-saint festivals rather than in the city venues where bachata was treated as disreputable. That circuit spared him much of the marginalisation that fell on other bachateros of his generation, and it gave him an audience that stayed with him for forty years.

**The catalogue**

He recorded steadily from 1970 onward, with albums including El Zumbador, La Muñeca, Las Bailadoras, La Madrugadora, La Viuda, La Mujer Policía, El Sabor de Mi Guitarra and Muchacha Dominicana. A 1981 release presented the accordionist Francisco Ulloa alongside the Conjunto San Rafael.

**Last years**

From 1995 he stopped playing the guitar and appeared only as a singer, fronting his group. He kept performing until November 2000 and died the following April, at sixty-four.',
       bio_es = 'Eladio Antonio Romero Santos, conocido como El Maestro, fue un cantante y guitarrista de bachata dominicano. Empezó a grabar en los primeros años del género y trabajó durante más de cuatro décadas, y se le recuerda tanto por haber sostenido el merengue tocado con guitarra como por su bachata.

**Cenoví**

Nació en 1937 en Cenoví, una comunidad rural en las afueras de San Francisco de Macorís, en la provincia Duarte. Empezó tocando maracas en un trío del lugar, aprendió guitarra mirando tocar a otros, y a los quince años ya encabezaba un trío propio como cantante. Se presentó a un festival de la emisora franco-macorisana La Voz del Progreso y quedó en tercer lugar.

**Las primeras grabaciones**

Su primer disco, la bachata Tomando en Tu Mesa, salió en 1966. Empezó a grabar al mismo tiempo que José Manuel Calderón y Cuco Valoy, en los años en que la bachata recién se estaba llevando al disco.

Su manera de tocar la guitarra era más sencilla que la de otros guitarristas bachateros de la época. Era también muy rítmica, hecha para bailar y no para lucirse, y es la cualidad por la que se conocen sus discos.

**El merengue con guitarra**

La Muñeca, grabada en 1972, fue el disco que llevó su nombre por todo el país y al exterior. Era un merengue tocado con guitarra, en un momento en que el merengue se había ido por un lado a las orquestas y por el otro al acordeón del perico ripiao.

Siguió trabajando esa forma el resto de su carrera, y su catálogo es una de las razones principales de que el merengue de guitarra sobreviviera como música grabada y no solo como memoria del campo.

**Los clubes de campo**

Tocaba sobre todo en clubes sociales rurales y en fiestas patronales, y no en los locales de ciudad donde la bachata se tenía por música de mala fama. Ese circuito le ahorró buena parte de la marginación que cayó sobre otros bachateros de su generación, y le dio un público que lo acompañó durante cuarenta años.

**El catálogo**

Grabó de manera sostenida desde 1970, con discos como El Zumbador, La Muñeca, Las Bailadoras, La Madrugadora, La Viuda, La Mujer Policía, El Sabor de Mi Guitarra y Muchacha Dominicana. Una edición de 1981 presentó al acordeonista Francisco Ulloa junto al Conjunto San Rafael.

**Los últimos años**

Desde 1995 dejó de tocar la guitarra y se presentó únicamente como cantante, al frente de su grupo. Siguió actuando hasta noviembre de 2000 y murió en abril del año siguiente, a los sesenta y cuatro años.',
       updated_at = now()
 WHERE slug = 'eladio-romero-santos';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eladio-romero-santos')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eladio-romero-santos')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Eladio Antonio Romero Santos, known as El Maestro, was a Dominican bachata singer and guitarist. He began recording in the first years of the genre and worked for more than four decades, and he is remembered as much for sustaining merengue played on guitar as for his bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cenoví","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1937 in Cenoví, a rural community outside San Francisco de Macorís, in the province of Duarte. He started on maracas in a local trio, learned guitar by watching, and by fifteen was leading a trio of his own as its singer. He entered a festival at the San Francisco radio station La Voz del Progreso and placed third.","type":"text"}]},{"type":"paragraph","content":[{"text":"The first recordings","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His first record, the bachata Tomando en Tu Mesa, appeared in 1966. He began recording at the same time as ","type":"text"},{"type":"artistReference","attrs":{"artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón","occurrenceId":"b991935d-89b9-490f-b297-71dffaeee8a7"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy","occurrenceId":"3a3866ce-2c2b-4d79-8089-8090b7fa8aa0"}},{"text":", in the years when bachata was first being committed to disc.","type":"text"}]},{"type":"paragraph","content":[{"text":"His guitar playing was plainer than that of other bachata guitarists of the period. It was also strongly rhythmic, built for dancing rather than for display, and that is the quality his records are known for.","type":"text"}]},{"type":"paragraph","content":[{"text":"Merengue on guitar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La Muñeca, recorded in 1972, was the record that carried his name across the country and abroad. It was a merengue played on guitar, at a point when merengue had moved to the orchestras on one side and to the accordion of perico ripiao on the other.","type":"text"}]},{"type":"paragraph","content":[{"text":"He went on working in that form for the rest of his career, and his catalogue is one of the main reasons guitar merengue survived as recorded music rather than only as a rural memory.","type":"text"}]},{"type":"paragraph","content":[{"text":"The country clubs","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He played mostly at rural social clubs and at patron-saint festivals rather than in the city venues where bachata was treated as disreputable. That circuit spared him much of the marginalisation that fell on other bachateros of his generation, and it gave him an audience that stayed with him for forty years.","type":"text"}]},{"type":"paragraph","content":[{"text":"The catalogue","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He recorded steadily from 1970 onward, with albums including El Zumbador, La Muñeca, Las Bailadoras, La Madrugadora, La Viuda, La Mujer Policía, El Sabor de Mi Guitarra and Muchacha Dominicana. A 1981 release presented the accordionist ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3680fc10-c3fd-42c4-ad54-90d79b226a7d","displayText":"Francisco Ulloa","occurrenceId":"cbc16ca8-57fc-4510-99c1-60427113866b"}},{"text":" alongside the Conjunto San Rafael.","type":"text"}]},{"type":"paragraph","content":[{"text":"Last years","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"From 1995 he stopped playing the guitar and appeared only as a singer, fronting his group. He kept performing until November 2000 and died the following April, at sixty-four.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'eladio-romero-santos'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Eladio Antonio Romero Santos, conocido como El Maestro, fue un cantante y guitarrista de bachata dominicano. Empezó a grabar en los primeros años del género y trabajó durante más de cuatro décadas, y se le recuerda tanto por haber sostenido el merengue tocado con guitarra como por su bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cenoví","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1937 en Cenoví, una comunidad rural en las afueras de San Francisco de Macorís, en la provincia Duarte. Empezó tocando maracas en un trío del lugar, aprendió guitarra mirando tocar a otros, y a los quince años ya encabezaba un trío propio como cantante. Se presentó a un festival de la emisora franco-macorisana La Voz del Progreso y quedó en tercer lugar.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las primeras grabaciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su primer disco, la bachata Tomando en Tu Mesa, salió en 1966. Empezó a grabar al mismo tiempo que ","type":"text"},{"type":"artistReference","attrs":{"artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón","occurrenceId":"a1cfdd65-7252-4549-965f-d6dcfaffeec7"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy","occurrenceId":"9a5d7f57-7867-4799-bc22-fb501d9b5215"}},{"text":", en los años en que la bachata recién se estaba llevando al disco.","type":"text"}]},{"type":"paragraph","content":[{"text":"Su manera de tocar la guitarra era más sencilla que la de otros guitarristas bachateros de la época. Era también muy rítmica, hecha para bailar y no para lucirse, y es la cualidad por la que se conocen sus discos.","type":"text"}]},{"type":"paragraph","content":[{"text":"El merengue con guitarra","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La Muñeca, grabada en 1972, fue el disco que llevó su nombre por todo el país y al exterior. Era un merengue tocado con guitarra, en un momento en que el merengue se había ido por un lado a las orquestas y por el otro al acordeón del perico ripiao.","type":"text"}]},{"type":"paragraph","content":[{"text":"Siguió trabajando esa forma el resto de su carrera, y su catálogo es una de las razones principales de que el merengue de guitarra sobreviviera como música grabada y no solo como memoria del campo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los clubes de campo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Tocaba sobre todo en clubes sociales rurales y en fiestas patronales, y no en los locales de ciudad donde la bachata se tenía por música de mala fama. Ese circuito le ahorró buena parte de la marginación que cayó sobre otros bachateros de su generación, y le dio un público que lo acompañó durante cuarenta años.","type":"text"}]},{"type":"paragraph","content":[{"text":"El catálogo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Grabó de manera sostenida desde 1970, con discos como El Zumbador, La Muñeca, Las Bailadoras, La Madrugadora, La Viuda, La Mujer Policía, El Sabor de Mi Guitarra y Muchacha Dominicana. Una edición de 1981 presentó al acordeonista ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3680fc10-c3fd-42c4-ad54-90d79b226a7d","displayText":"Francisco Ulloa","occurrenceId":"feb03d67-7d7e-438c-b94c-99c42fb9fa45"}},{"text":" junto al Conjunto San Rafael.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los últimos años","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Desde 1995 dejó de tocar la guitarra y se presentó únicamente como cantante, al frente de su grupo. Siguió actuando hasta noviembre de 2000 y murió en abril del año siguiente, a los sesenta y cuatro años.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'eladio-romero-santos'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eladio-romero-santos') AND locale = 'en'), '3a3866ce-2c2b-4d79-8089-8090b7fa8aa0', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eladio-romero-santos') AND locale = 'en'), 'b991935d-89b9-490f-b297-71dffaeee8a7', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eladio-romero-santos') AND locale = 'en'), 'cbc16ca8-57fc-4510-99c1-60427113866b', 'artist', '3680fc10-c3fd-42c4-ad54-90d79b226a7d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eladio-romero-santos') AND locale = 'es'), '9a5d7f57-7867-4799-bc22-fb501d9b5215', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eladio-romero-santos') AND locale = 'es'), 'a1cfdd65-7252-4549-965f-d6dcfaffeec7', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eladio-romero-santos') AND locale = 'es'), 'feb03d67-7d7e-438c-b94c-99c42fb9fa45', 'artist', '3680fc10-c3fd-42c4-ad54-90d79b226a7d');

COMMIT;
