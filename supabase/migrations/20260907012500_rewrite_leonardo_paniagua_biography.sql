BEGIN;

-- Rewrite the catalogue entry for Leonardo Paniagua.
--
-- Leonardo Paniagua. Tercera de las dieciséis fichas publicadas que estaban EN
-- BLANCO, y de las más llamativas: un pionero de la bachata con Soberano al
-- Mérito y su página no decía una palabra.
--
-- LO QUE YA TENÍA LA FILA ESTÁ BIEN Y SE CONFIRMA, no se toca: 5 de agosto de
-- 1945, Las Yayas, provincia La Vega, bachata, cantante. Cuatro fuentes
-- independientes coinciden en la fecha y el lugar -- Wikipedia en inglés,
-- Bachata Republic, el blog Pecalmo y Grokipedia.
--
-- SE COMPLETA EL NOMBRE: Leonardo Paniagua Acevedo. El segundo apellido lo dan
-- Bachata Republic y el blog de Los Mina. Y el apodo, EL CHIQUITITO, que sale
-- de su propio éxito y que la prensa usa constantemente.
--
-- NO SE LE PONE NI GUITARRA NI COMPOSITOR pese a que la ficha de Wikipedia en
-- inglés lista las dos cosas. Su obra documentada es de intérprete: vive de
-- versionar baladas y boleros ajenos, y no encontré una sola canción firmada
-- por él ni una foto suya tocando. Ante la duda, instruments va solo con voz y
-- occupations queda vacío. Es más fácil añadir un dato después que quitar uno
-- falso que ya leyó alguien.
--
-- DOS ENLACES, LOS DOS CON PRUEBA DIRECTA:
--
--   radhames-aracena -- es quien lo escucha y lo graba en la Guarachita. La
--   ficha de Aracena la escribí en esta misma corrida, así que el enlace cierra
--   el circuito por los dos lados.
--
--   edilio-paredes -- el "Conjunto Paredes" que acompaña media discografía es
--   el suyo. Bandcamp acredita "Leonardo Paniagua and Conjunto de Edilio
--   Paredes" en Prohibido, y en 2021 salió el álbum "Memorias Con Edilio
--   Paredes". No es una inferencia por apellido.
--
-- EL DISCO DE ORO SÍ ENTRA Y LA CIFRA DE VENTAS NO. Hoy Digital dice que el
-- premio se entregó en Miami por pasar de 75 mil copias internacionales. Una
-- certificación es un hecho de industria y va; el número exacto se parece
-- demasiado a las cifras que aquí no se escriben, y no aporta nada que no
-- aporte la palabra "oro".
--
-- SU DIAGNÓSTICO DEL GÉNERO ESTÁ DOCUMENTADO y por eso entra: en Hoy, en 2008,
-- sostuvo que a la bachata la estancó la hipocresía -- se oía en privado y se
-- negaba en público. No es opinión mía; es su tesis, publicada y firmada.
--
-- EL PREMIO VA EN MIGRACIÓN APARTE porque artist_awards es otra tabla. La
-- categoría "Soberano al Mérito" YA EXISTE bajo "Premios Soberano"; no hay que
-- crear nada. Confirmado por El Caribe, Hoy, La Crónica y Herrera Digital.
--
-- HANDLES COMPROBADOS HOY, LOS TRES VIVOS: youtube @LeonardoPaniagua (canal
-- oficial, llevado por LP Record), facebook e instagram leonardopaniagua01. El
-- Facebook tenía una publicación de hace una hora, de las fiestas patronales de
-- Baitoa. No se guardan cifras de seguidores.
--
-- SIGUE ACTIVO Y LA FICHA LO DICE: en su canal hay material reciente --
-- "Estuche de Ternura" y los visualizers de "Como Es Posible" y "Después De Ti
-- Qué" -- además de las presentaciones que anuncia él mismo.
--
-- LO QUE SE DEJA FUERA A PROPÓSITO: que es el penúltimo de catorce hermanos,
-- los nombres y orígenes de sus padres, y la pobreza de la casa. Son vida
-- privada. Los oficios que tuvo antes de cantar sí entran, porque explican de
-- dónde sale el cantante y son historia laboral, no intimidad.
--
-- FUENTES: Wikipedia en inglés (discografía y años). Bachata Republic, 23 de
-- agosto de 2021, de Luis Becker Cabrera, que es la biografía más detallada que
-- existe. Hoy Digital, 30 de junio de 2008, para el disco de oro y la tesis de
-- la hipocresía. El Caribe y La Crónica para el Soberano 2017. El Caribe, 5 de
-- julio de 2018, para el relato del descubrimiento. Sus propias cuentas para lo
-- reciente.
--
-- NOMBRES NUEVOS PARA LA LISTA DE FALTANTES: Danilo Rodríguez, el cantante y
-- barbero de Los Mina que lo llevó a la Guarachita; y Felipe Rodríguez, el
-- puertorriqueño autor de "Insaciable" (queda anotado que es extranjero y por
-- tanto NO entra al catálogo, solo se menciona).
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
       name = 'Leonardo Paniagua',
       sort_name = 'Paniagua Acevedo, Leonardo',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1945-08-05',
       birth_year = 1945,
       date_of_death = NULL,
       birth_place = 'Las Yayas',
       province = 'La Vega',
       first_name = 'Leonardo',
       middle_name = NULL,
       last_name = 'Paniagua',
       second_last_name = 'Acevedo',
       stage_name = 'Leonardo Paniagua',
       aliases = ARRAY['El Chiquitito']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@LeonardoPaniagua',
       facebook = 'leonardopaniagua01',
       instagram = 'leonardopaniagua01',
       disambiguation = 'Bachata singer known as El Chiquitito; his bachata version of "Chiquitita" carried the genre onto FM radio',
       bio_en = 'Leonardo Paniagua Acevedo, known as El Chiquitito, is a Dominican bachata singer. He built a long career on romantic reinterpretation rather than original composition, and his bachata version of ABBA’s "Chiquitita" is generally credited with carrying the genre onto Dominican FM radio at a time when stations avoided it.

**From Las Yayas to the capital**

He was born in Las Yayas, a rural community in the province of La Vega, in 1945. He moved to Santo Domingo at fifteen and worked outside music for years: first as a gardener, then as a messenger for a pharmacy, and later in the same trade for the national water institute.

**The audition at Guarachita**

He came to recording by accident. Waiting his turn at the barbershop of his friend Danilo Rodríguez in Los Mina, he was asked to stay for a rehearsal, and Rodríguez took him the following day to Radhamés Aracena, who ran Radio Guarachita and its label. Paniagua sang "Amada Amante", the Roberto Carlos song, and was asked for a second: he recorded "Insaciable", by the Puerto Rican Felipe Rodríguez.

The method was set from that first session. Where most bachata of the seventies drew on barrio life and was dismissed as coarse, Paniagua sang boleros and ballads from the wider Latin repertoire over bachata guitar, in a soft register that reached listeners the genre had not reached before.

**Chiquitita and the FM barrier**

His version of "Chiquitita" appeared at the end of the seventies and became the record his career is measured by. It earned him a gold record, presented in Miami for international sales, and it is cited as the point at which Dominican FM stations began programming bachata, having previously treated the genre as unbroadcastable.

He has been direct about what held the music back. In the Dominican press he argued that bachata was stalled by hypocrisy: audiences listened to it privately and denied it in public, and the radio followed the denial rather than the listening.

**The catalogue**

His recorded output is unusually large. From the early seventies to the early nineties he released a long run of numbered volumes, many of them backed by the conjunto of Edilio Paredes. Among the titles that stayed in circulation are "Mi Secreto", "Ella Se Llamaba Marta", "Un Beso y Una Flor", "Amada Amante" and "Brunilda". The partnership lasted: an album of remade material with the same guitarist appeared decades later.

**Recognition**

The Asociación de Cronistas de Arte gave him the Soberano al Mérito for his career in bachata. He continues to record and to perform, with recent studio material issued through his own channel and appearances at town festivals and abroad.',
       bio_es = 'Leonardo Paniagua Acevedo, conocido como El Chiquitito, es un cantante de bachata dominicano. Construyó una carrera larga sobre la reinterpretación romántica antes que sobre la composición propia, y a su versión en bachata de "Chiquitita", de ABBA, se le atribuye en general haber llevado el género a la radio FM dominicana en una época en que las emisoras lo evitaban.

**De Las Yayas a la capital**

Nació en Las Yayas, una comunidad rural de la provincia La Vega, en 1945. Se mudó a Santo Domingo a los quince años y trabajó fuera de la música durante años: primero como jardinero, después como mensajero de una farmacia y más adelante en el mismo oficio para el instituto nacional de aguas.

**La audición en la Guarachita**

Llegó a grabar por casualidad. Esperando su turno en la barbería de su amigo Danilo Rodríguez, en Los Mina, le pidieron que se quedara a un ensayo, y Rodríguez lo llevó al día siguiente ante Radhamés Aracena, que dirigía Radio Guarachita y su sello. Paniagua cantó "Amada Amante", la canción de Roberto Carlos, y le pidieron una segunda: grabó "Insaciable", del puertorriqueño Felipe Rodríguez.

El método quedó fijado desde esa primera sesión. Mientras la mayor parte de la bachata de los setenta se nutría de la vida de barrio y era despachada como música vulgar, Paniagua cantaba boleros y baladas del repertorio latino amplio sobre guitarra de bachata, en un registro suave que alcanzó a oyentes a los que el género no había llegado.

**Chiquitita y la barrera de la FM**

Su versión de "Chiquitita" apareció a finales de los setenta y se convirtió en el disco con el que se mide su carrera. Le valió un disco de oro, entregado en Miami por ventas internacionales, y se cita como el momento en que las emisoras dominicanas de FM empezaron a programar bachata, después de haber tratado el género como material no radiable.

Ha sido directo sobre lo que frenó a esta música. En la prensa dominicana sostuvo que a la bachata la estancó la hipocresía: el público la oía en privado y la negaba en público, y la radio siguió la negación y no la escucha.

**El catálogo**

Su obra grabada es de un tamaño poco corriente. Desde principios de los setenta hasta principios de los noventa publicó una larga serie de volúmenes numerados, muchos de ellos respaldados por el conjunto de Edilio Paredes. Entre los títulos que se mantuvieron en circulación están "Mi Secreto", "Ella Se Llamaba Marta", "Un Beso y Una Flor", "Amada Amante" y "Brunilda". La sociedad duró: décadas más tarde salió un álbum de material rehecho con el mismo guitarrista.

**Reconocimiento**

La Asociación de Cronistas de Arte le entregó el Soberano al Mérito por su trayectoria en la bachata. Sigue grabando y presentándose, con material de estudio reciente publicado por su propio canal y actuaciones en fiestas patronales y en el exterior.',
       updated_at = now()
 WHERE slug = 'leonardo-paniagua';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'leonardo-paniagua')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'leonardo-paniagua')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Leonardo Paniagua Acevedo, known as El Chiquitito, is a Dominican bachata singer. He built a long career on romantic reinterpretation rather than original composition, and his bachata version of ABBA’s \"Chiquitita\" is generally credited with carrying the genre onto Dominican FM radio at a time when stations avoided it.","type":"text"}]},{"type":"paragraph","content":[{"text":"From Las Yayas to the capital","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Las Yayas, a rural community in the province of La Vega, in 1945. He moved to Santo Domingo at fifteen and worked outside music for years: first as a gardener, then as a messenger for a pharmacy, and later in the same trade for the national water institute.","type":"text"}]},{"type":"paragraph","content":[{"text":"The audition at Guarachita","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He came to recording by accident. Waiting his turn at the barbershop of his friend Danilo Rodríguez in Los Mina, he was asked to stay for a rehearsal, and Rodríguez took him the following day to ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena","occurrenceId":"c65710e7-d067-4f3e-b8ec-dbe6d8b59720"}},{"text":", who ran Radio Guarachita and its label. Paniagua sang \"Amada Amante\", the Roberto Carlos song, and was asked for a second: he recorded \"Insaciable\", by the Puerto Rican Felipe Rodríguez.","type":"text"}]},{"type":"paragraph","content":[{"text":"The method was set from that first session. Where most bachata of the seventies drew on barrio life and was dismissed as coarse, Paniagua sang boleros and ballads from the wider Latin repertoire over bachata guitar, in a soft register that reached listeners the genre had not reached before.","type":"text"}]},{"type":"paragraph","content":[{"text":"Chiquitita and the FM barrier","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His version of \"Chiquitita\" appeared at the end of the seventies and became the record his career is measured by. It earned him a gold record, presented in Miami for international sales, and it is cited as the point at which Dominican FM stations began programming bachata, having previously treated the genre as unbroadcastable.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has been direct about what held the music back. In the Dominican press he argued that bachata was stalled by hypocrisy: audiences listened to it privately and denied it in public, and the radio followed the denial rather than the listening.","type":"text"}]},{"type":"paragraph","content":[{"text":"The catalogue","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His recorded output is unusually large. From the early seventies to the early nineties he released a long run of numbered volumes, many of them backed by the conjunto of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cbda65a4-c7da-4762-8cf8-f29b942d2ac3","displayText":"Edilio Paredes","occurrenceId":"c683324e-61ed-4131-9074-822db59cd784"}},{"text":". Among the titles that stayed in circulation are \"Mi Secreto\", \"Ella Se Llamaba Marta\", \"Un Beso y Una Flor\", \"Amada Amante\" and \"Brunilda\". The partnership lasted: an album of remade material with the same guitarist appeared decades later.","type":"text"}]},{"type":"paragraph","content":[{"text":"Recognition","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The Asociación de Cronistas de Arte gave him the Soberano al Mérito for his career in bachata. He continues to record and to perform, with recent studio material issued through his own channel and appearances at town festivals and abroad.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'leonardo-paniagua'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Leonardo Paniagua Acevedo, conocido como El Chiquitito, es un cantante de bachata dominicano. Construyó una carrera larga sobre la reinterpretación romántica antes que sobre la composición propia, y a su versión en bachata de \"Chiquitita\", de ABBA, se le atribuye en general haber llevado el género a la radio FM dominicana en una época en que las emisoras lo evitaban.","type":"text"}]},{"type":"paragraph","content":[{"text":"De Las Yayas a la capital","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Las Yayas, una comunidad rural de la provincia La Vega, en 1945. Se mudó a Santo Domingo a los quince años y trabajó fuera de la música durante años: primero como jardinero, después como mensajero de una farmacia y más adelante en el mismo oficio para el instituto nacional de aguas.","type":"text"}]},{"type":"paragraph","content":[{"text":"La audición en la Guarachita","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Llegó a grabar por casualidad. Esperando su turno en la barbería de su amigo Danilo Rodríguez, en Los Mina, le pidieron que se quedara a un ensayo, y Rodríguez lo llevó al día siguiente ante ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena","occurrenceId":"0c0fe31d-b0ad-4773-b6f0-df694b17e8d5"}},{"text":", que dirigía Radio Guarachita y su sello. Paniagua cantó \"Amada Amante\", la canción de Roberto Carlos, y le pidieron una segunda: grabó \"Insaciable\", del puertorriqueño Felipe Rodríguez.","type":"text"}]},{"type":"paragraph","content":[{"text":"El método quedó fijado desde esa primera sesión. Mientras la mayor parte de la bachata de los setenta se nutría de la vida de barrio y era despachada como música vulgar, Paniagua cantaba boleros y baladas del repertorio latino amplio sobre guitarra de bachata, en un registro suave que alcanzó a oyentes a los que el género no había llegado.","type":"text"}]},{"type":"paragraph","content":[{"text":"Chiquitita y la barrera de la FM","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su versión de \"Chiquitita\" apareció a finales de los setenta y se convirtió en el disco con el que se mide su carrera. Le valió un disco de oro, entregado en Miami por ventas internacionales, y se cita como el momento en que las emisoras dominicanas de FM empezaron a programar bachata, después de haber tratado el género como material no radiable.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ha sido directo sobre lo que frenó a esta música. En la prensa dominicana sostuvo que a la bachata la estancó la hipocresía: el público la oía en privado y la negaba en público, y la radio siguió la negación y no la escucha.","type":"text"}]},{"type":"paragraph","content":[{"text":"El catálogo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su obra grabada es de un tamaño poco corriente. Desde principios de los setenta hasta principios de los noventa publicó una larga serie de volúmenes numerados, muchos de ellos respaldados por el conjunto de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cbda65a4-c7da-4762-8cf8-f29b942d2ac3","displayText":"Edilio Paredes","occurrenceId":"ab1116bd-235e-45fb-bbcb-7a1666909dcb"}},{"text":". Entre los títulos que se mantuvieron en circulación están \"Mi Secreto\", \"Ella Se Llamaba Marta\", \"Un Beso y Una Flor\", \"Amada Amante\" y \"Brunilda\". La sociedad duró: décadas más tarde salió un álbum de material rehecho con el mismo guitarrista.","type":"text"}]},{"type":"paragraph","content":[{"text":"Reconocimiento","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La Asociación de Cronistas de Arte le entregó el Soberano al Mérito por su trayectoria en la bachata. Sigue grabando y presentándose, con material de estudio reciente publicado por su propio canal y actuaciones en fiestas patronales y en el exterior.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'leonardo-paniagua'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'leonardo-paniagua') AND locale = 'en'), 'c65710e7-d067-4f3e-b8ec-dbe6d8b59720', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'leonardo-paniagua') AND locale = 'en'), 'c683324e-61ed-4131-9074-822db59cd784', 'artist', 'cbda65a4-c7da-4762-8cf8-f29b942d2ac3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'leonardo-paniagua') AND locale = 'es'), '0c0fe31d-b0ad-4773-b6f0-df694b17e8d5', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'leonardo-paniagua') AND locale = 'es'), 'ab1116bd-235e-45fb-bbcb-7a1666909dcb', 'artist', 'cbda65a4-c7da-4762-8cf8-f29b942d2ac3');

COMMIT;
