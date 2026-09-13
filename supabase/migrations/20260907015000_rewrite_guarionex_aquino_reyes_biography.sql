BEGIN;

-- Rewrite the catalogue entry for Guarionex Aquino Reyes.
--
-- Guarionex Aquino Reyes. Decimoquinta de las dieciséis fichas publicadas que
-- estaban EN BLANCO. Es el PADRE; su hijo tiene ficha aparte.
--
-- SE CORRIGE UN CARÁCTER CORRUPTO EN EL ALIAS. La fila guardaba "El Gran
-- Bar[U+00AD]tono Dominicano": la í se había convertido en un GUION SUAVE, un
-- carácter invisible que no se ve al leer pero que rompe cualquier búsqueda por
-- texto. Queda "El Gran Barítono Dominicano". Es la misma clase de daño que las
-- eñes perdidas que corregimos antes.
--
-- LO DEMÁS DE LA FILA SE CONFIRMA: 28 de febrero de 1924 en Mao, Valverde;
-- muerte el 24 de diciembre de 2010; ended en true; primary_genre
-- instrumental-classical, que es correcto para un barítono lírico.
--
-- CONFLICTO DE FECHA DE MUERTE QUE NO CAMBIO. Grokipedia dice 25 de diciembre
-- EN SU PRIMER PÁRRAFO y 24 de diciembre EN SU SECCIÓN DE MUERTE: se contradice
-- sola. IMDb y la descripción del video de "Amor Profundo" dicen 24. Se queda el
-- 24, que es lo que ya estaba guardado.
--
-- AVISO SOBRE GROKIPEDIA, que es la fuente más extensa que existe sobre él:
-- ADEMÁS DE CONTRADECIRSE EN LA FECHA, CONFUNDE AL PADRE CON EL HIJO. Le
-- atribuye al barítono los créditos de percusión de "Two Much" y "The Lost
-- City", que son del hijo percusionista. Es exactamente el problema de separar
-- personas que el editor marcó, apareciendo dentro de las propias fuentes. Por
-- eso esta ficha se apoya en Diógenes Céspedes y no en ella.
--
-- LA FUENTE BUENA ES ACADÉMICA: Diógenes Céspedes, "El barítono Guarionex
-- Aquino en el AGN", publicado en Areíto el 21 de abril de 2012, que cita el
-- libro "Por amor al arte" de Arístides Incháustegui (1995) con páginas
-- concretas. De ahí salen la descripción de la voz, el programa "Estampas de mi
-- Tierra" con sus años exactos, y el repertorio regional.
--
-- UN SOLO ENLACE, Y MUY BIEN DOCUMENTADO: julio-alberto-hernandez, cuya ficha
-- escribí hoy mismo. Tres fuentes independientes lo confirman como autor de
-- temas que Aquino grabó: Céspedes para "Amor Profundo" y "Mañanitas de San
-- Juan", y los archivos de Américo Mejía para "Cambió el Merengue" y "Mangos
-- Bajitos". El catálogo puede ahora mostrar la relación entre el compositor y
-- su intérprete por los dos lados.
--
-- NO SE ENLAZA A CASANDRA DAMIRÓN pese a estar en la base. Grokipedia dice que
-- Aquino giró por el exterior dentro de su grupo, pero es la única fuente y ya
-- demostró ser poco fiable en esta misma ficha. Una relación entre dos artistas
-- del catálogo no se afirma con eso.
--
-- TAMPOCO ENTRA la dramatización radial sobre la vida de Eduardo Brito que ella
-- le atribuye, por lo mismo, aunque sería un enlace atractivo.
--
-- SE DEJA FUERA LA VIDA PRIVADA: esposa, cuatro hijos y sus nombres. La
-- paternidad del percusionista SÍ se menciona, porque hay dos fichas con el
-- mismo nombre en este catálogo y no distinguirlas confundiría al lector. Se
-- dice lo mínimo para separarlas.
--
-- NO SE ESCRIBE DE QUÉ MURIÓ, aunque las fuentes lo detallan.
--
-- FUENTES: Diógenes Céspedes en Areíto, 21 de abril de 2012. Arístides
-- Incháustegui, "Por amor al arte", citado por él. Historia Dominicana en
-- Gráficas para la formación con Rafael Emilio Arté y las emisoras de Santiago.
-- Los Archivos de Américo Mejía para el repertorio.
--
-- NOMBRES NUEVOS PARA LA LISTA: Rafael Emilio Arté, su maestro español; Amada
-- Nivar de Pittaluga, la poeta de "Mañanitas de San Juan"; Guaroa Pérez Oviedo
-- y Julio Grautreau, autores de su repertorio regional; y Arístides
-- Incháustegui, tenor y musicógrafo, que además de cantar el mismo repertorio
-- es el historiador que lo documentó.
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
       name = 'Guarionex Aquino Reyes',
       sort_name = 'Aquino Reyes, Guarionex',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'instrumental-classical',
       date_of_birth = '1924-02-28',
       birth_year = 1924,
       date_of_death = '2010-12-24',
       birth_place = 'Santa Cruz de Mao',
       province = 'Valverde',
       first_name = 'Guarionex',
       middle_name = NULL,
       last_name = 'Aquino',
       second_last_name = 'Reyes',
       stage_name = 'Guarionex Aquino',
       aliases = ARRAY['El Gran Barítono Dominicano']::text[],
       occupations = '["music educator","producer","radio_host"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Lyric baritone of La Voz Dominicana; father of the percussionist of the same name',
       bio_en = 'Guarionex Aquino Reyes was a Dominican lyric baritone, radio producer and singing teacher. He was one of the leading concert voices of the country in the nineteen fifties and sixties, and he later devoted himself to broadcasting and to teaching. The percussionist of the same name is his son.

**Mao**

He was born in Mao, in the province of Valverde, in 1924. He took his first music lessons very young from the Spanish teacher Rafael Emilio Arté, and while still a boy moved to Santiago de los Caballeros, where he began appearing on the radio stations of the city and at the Café Yaque.

**The voice**

The musicographer Arístides Incháustegui, who was himself a tenor and sang some of the same repertoire, described the instrument in detail: a lyric baritone, round and intense, of great volume, reaching comfortably above the natural A, with a velvety timbre, careful diction and broad phrasing. He considered Aquino one of the most finished products of the La Voz Dominicana school.

**Concert and opera**

He built his reputation in the concert repertoire during the fifties, appearing in opera evenings in the capital with the national symphony and taking the baritone solo in sacred works. He also performed abroad during those years.

**Estampas de mi Tierra**

Between 1964 and 1965 he produced a programme on the state broadcaster for which he gathered a large body of songs dedicated to the provinces of the country and recorded them as singles. That project is the core of his recorded legacy, and it is why so much of his repertoire carries the name of a Dominican town.

Several of those pieces were written or arranged by Julio Alberto Hernández. Among them are Amor Profundo, built on a décima by the poet Juan Antonio Alix, and Mañanitas de San Juan, a setting of a poem by Amada Nivar de Pittaluga arranged as a guarapo.

**Radio and teaching**

He founded a cultural radio station in his home town of Mao, dedicated to Dominican music and traditions, and worked for years as a singing teacher, first at the academy of La Voz Dominicana and later at the audiovisual training centre of the state television, where he returned to teach at the end of the nineties.

**The archive**

The Archivo General de la Nación later issued a set of four compact discs of his recordings with an accompanying booklet, which is how the bulk of his work survives in accessible form. He died in Santo Domingo in December 2010, at eighty-six.',
       bio_es = 'Guarionex Aquino Reyes fue un barítono lírico, productor de radio y maestro de canto dominicano. Fue una de las voces de concierto principales del país en los años cincuenta y sesenta, y después se dedicó a la radiodifusión y a la enseñanza. El percusionista del mismo nombre es su hijo.

**Mao**

Nació en Mao, provincia de Valverde, en 1924. Tomó sus primeras clases de música muy niño con el maestro español Rafael Emilio Arté, y siendo todavía joven pasó a vivir a Santiago de los Caballeros, donde empezó a presentarse en las emisoras de la ciudad y en el Café Yaque.

**La voz**

El musicógrafo Arístides Incháustegui, que era tenor y cantó parte del mismo repertorio, describió el instrumento con detalle: un barítono lírico, redondo e intenso, de gran volumen, capaz de sobrepasar con holgura el la natural, de timbre aterciopelado, dicción cuidada y fraseo amplio. Lo consideró uno de los productos más acabados de la escuela de La Voz Dominicana.

**El concierto y la ópera**

Construyó su prestigio en el repertorio de concierto durante los cincuenta, con presentaciones en noches de ópera en la capital junto a la sinfónica nacional y como solista barítono en obra sacra. En esos mismos años se presentó también en el exterior.

**Estampas de mi Tierra**

Entre 1964 y 1965 produjo un programa en la radiotelevisión oficial para el cual reunió un conjunto amplio de canciones dedicadas a las provincias del país y las grabó en sencillos. Ese proyecto es el núcleo de su legado grabado, y explica que buena parte de su repertorio lleve el nombre de un pueblo dominicano.

Varias de esas piezas son de la autoría o del arreglo de Julio Alberto Hernández. Entre ellas están Amor Profundo, levantada sobre una décima del poeta Juan Antonio Alix, y Mañanitas de San Juan, musicalización de un poema de Amada Nivar de Pittaluga arreglada como guarapo.

**La radio y la enseñanza**

Fundó en Mao, su pueblo, una emisora cultural dedicada a la música y las tradiciones dominicanas, y trabajó durante años como profesor de canto, primero en la academia de La Voz Dominicana y después en el centro de formación audiovisual de la televisión estatal, adonde volvió a dar clases a finales de los noventa.

**El archivo**

El Archivo General de la Nación publicó más tarde un juego de cuatro discos compactos con sus grabaciones y un librito que los acompaña, que es como sobrevive en forma accesible el grueso de su obra. Murió en Santo Domingo en diciembre de 2010, a los ochenta y seis años.',
       updated_at = now()
 WHERE slug = 'guarionex-aquino-reyes';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-reyes')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-reyes')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Guarionex Aquino Reyes was a Dominican lyric baritone, radio producer and singing teacher. He was one of the leading concert voices of the country in the nineteen fifties and sixties, and he later devoted himself to broadcasting and to teaching. The percussionist of the same name is his son.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mao","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Mao, in the province of Valverde, in 1924. He took his first music lessons very young from the Spanish teacher Rafael Emilio Arté, and while still a boy moved to Santiago de los Caballeros, where he began appearing on the radio stations of the city and at the Café Yaque.","type":"text"}]},{"type":"paragraph","content":[{"text":"The voice","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The musicographer Arístides Incháustegui, who was himself a tenor and sang some of the same repertoire, described the instrument in detail: a lyric baritone, round and intense, of great volume, reaching comfortably above the natural A, with a velvety timbre, careful diction and broad phrasing. He considered Aquino one of the most finished products of the La Voz Dominicana school.","type":"text"}]},{"type":"paragraph","content":[{"text":"Concert and opera","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He built his reputation in the concert repertoire during the fifties, appearing in opera evenings in the capital with the national symphony and taking the baritone solo in sacred works. He also performed abroad during those years.","type":"text"}]},{"type":"paragraph","content":[{"text":"Estampas de mi Tierra","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Between 1964 and 1965 he produced a programme on the state broadcaster for which he gathered a large body of songs dedicated to the provinces of the country and recorded them as singles. That project is the core of his recorded legacy, and it is why so much of his repertoire carries the name of a Dominican town.","type":"text"}]},{"type":"paragraph","content":[{"text":"Several of those pieces were written or arranged by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0e61046c-e96d-400b-819c-f9de8cbacba1","displayText":"Julio Alberto Hernández","occurrenceId":"548e20a4-7296-4b24-81d3-4c53b09bbcef"}},{"text":". Among them are Amor Profundo, built on a décima by the poet Juan Antonio Alix, and Mañanitas de San Juan, a setting of a poem by Amada Nivar de Pittaluga arranged as a guarapo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Radio and teaching","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He founded a cultural radio station in his home town of Mao, dedicated to Dominican music and traditions, and worked for years as a singing teacher, first at the academy of La Voz Dominicana and later at the audiovisual training centre of the state television, where he returned to teach at the end of the nineties.","type":"text"}]},{"type":"paragraph","content":[{"text":"The archive","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The Archivo General de la Nación later issued a set of four compact discs of his recordings with an accompanying booklet, which is how the bulk of his work survives in accessible form. He died in Santo Domingo in December 2010, at eighty-six.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'guarionex-aquino-reyes'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Guarionex Aquino Reyes fue un barítono lírico, productor de radio y maestro de canto dominicano. Fue una de las voces de concierto principales del país en los años cincuenta y sesenta, y después se dedicó a la radiodifusión y a la enseñanza. El percusionista del mismo nombre es su hijo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mao","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Mao, provincia de Valverde, en 1924. Tomó sus primeras clases de música muy niño con el maestro español Rafael Emilio Arté, y siendo todavía joven pasó a vivir a Santiago de los Caballeros, donde empezó a presentarse en las emisoras de la ciudad y en el Café Yaque.","type":"text"}]},{"type":"paragraph","content":[{"text":"La voz","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El musicógrafo Arístides Incháustegui, que era tenor y cantó parte del mismo repertorio, describió el instrumento con detalle: un barítono lírico, redondo e intenso, de gran volumen, capaz de sobrepasar con holgura el la natural, de timbre aterciopelado, dicción cuidada y fraseo amplio. Lo consideró uno de los productos más acabados de la escuela de La Voz Dominicana.","type":"text"}]},{"type":"paragraph","content":[{"text":"El concierto y la ópera","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Construyó su prestigio en el repertorio de concierto durante los cincuenta, con presentaciones en noches de ópera en la capital junto a la sinfónica nacional y como solista barítono en obra sacra. En esos mismos años se presentó también en el exterior.","type":"text"}]},{"type":"paragraph","content":[{"text":"Estampas de mi Tierra","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Entre 1964 y 1965 produjo un programa en la radiotelevisión oficial para el cual reunió un conjunto amplio de canciones dedicadas a las provincias del país y las grabó en sencillos. Ese proyecto es el núcleo de su legado grabado, y explica que buena parte de su repertorio lleve el nombre de un pueblo dominicano.","type":"text"}]},{"type":"paragraph","content":[{"text":"Varias de esas piezas son de la autoría o del arreglo de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0e61046c-e96d-400b-819c-f9de8cbacba1","displayText":"Julio Alberto Hernández","occurrenceId":"1efb5314-a013-46da-ac80-baeee0948dfe"}},{"text":". Entre ellas están Amor Profundo, levantada sobre una décima del poeta Juan Antonio Alix, y Mañanitas de San Juan, musicalización de un poema de Amada Nivar de Pittaluga arreglada como guarapo.","type":"text"}]},{"type":"paragraph","content":[{"text":"La radio y la enseñanza","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Fundó en Mao, su pueblo, una emisora cultural dedicada a la música y las tradiciones dominicanas, y trabajó durante años como profesor de canto, primero en la academia de La Voz Dominicana y después en el centro de formación audiovisual de la televisión estatal, adonde volvió a dar clases a finales de los noventa.","type":"text"}]},{"type":"paragraph","content":[{"text":"El archivo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El Archivo General de la Nación publicó más tarde un juego de cuatro discos compactos con sus grabaciones y un librito que los acompaña, que es como sobrevive en forma accesible el grueso de su obra. Murió en Santo Domingo en diciembre de 2010, a los ochenta y seis años.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'guarionex-aquino-reyes'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-reyes') AND locale = 'en'), '548e20a4-7296-4b24-81d3-4c53b09bbcef', 'artist', '0e61046c-e96d-400b-819c-f9de8cbacba1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'guarionex-aquino-reyes') AND locale = 'es'), '1efb5314-a013-46da-ac80-baeee0948dfe', 'artist', '0e61046c-e96d-400b-819c-f9de8cbacba1');

COMMIT;
