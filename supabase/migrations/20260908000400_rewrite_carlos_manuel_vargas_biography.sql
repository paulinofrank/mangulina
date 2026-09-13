BEGIN;

-- Rewrite the catalogue entry for Carlos Manuel Vargas.
--
-- Carlos Manuel Vargas. CUARTA de las dieciocho, y el caso más limpio hasta
-- ahora: la ficha del lote de mayo tenía contenido real y verificable, y la
-- fila NO TIENE NI UN DEFECTO. Nada que corregir, solo que estructurar,
-- enlazar y escribir en español.
--
-- Es la primera de las 229 en la que no encuentro un error. Conviene dejarlo
-- dicho, porque llevo seis fichas seguidas reportando fallos y el lote no es
-- uniformemente malo: es uniformemente POBRE, que no es lo mismo.
--
-- LO QUE SE VERIFICÓ, porque el centro de la ficha es un disco concreto:
-- "Souvenirs" existe, es de Navona Records con número de catálogo NV6615, salió
-- en 2024 y tiene trece pistas. Lo confirman la propia Navona, Presto Music,
-- AllMusic, Apple Music Classical y Spotify. Take Effect lo reseñó en abril de
-- 2025.
--
-- SE AÑADE UN COMPOSITOR QUE LA FICHA VIEJA NO NOMBRABA: el álbum abre con
-- "Impressões Seresteiras" de Heitor Villa-Lobos, según la reseña de Take
-- Effect. La lista que traía -- Poulenc, Scriabin, Gershwin y Landestoy -- era
-- correcta pero incompleta.
--
-- EL DATO DOMINICANO ES EL QUE IMPORTA AQUÍ, y Presto Music lo precisa: la
-- pieza es "Estudio en Zamba", de Rafael Bullumba Landestoy. Un pianista
-- dominicano metiendo a un compositor dominicano en un disco internacional de
-- repertorio clásico es exactamente lo que este catálogo existe para registrar.
--
-- OJO CON EL displayText: la fila se llama "Bullumba Landestoy" A SECAS, sin el
-- Rafael. El texto del enlace tiene que decir eso.
--
-- SE AÑADE 'music educator' A occupations. Es profesor asistente en Boston
-- Conservatory at Berklee, fundó un programa gratuito de piano para niños y
-- dirige una serie de conciertos. La enseñanza es la mitad de su trabajo y el
-- campo solo decía 'pianist'.
--
-- NO SE INVENTA FECHA DE NACIMIENTO. La fila la tiene vacía y no encontré
-- ninguna fuente que la dé.
--
-- EL SEGUNDO ÁLBUM SE CUENTA SIN TIEMPO VERBAL COMPROMETIDO. La ficha vieja
-- decía "In 2026, he was preparing Voyage". Hoy es septiembre de 2026 y no
-- encontré confirmación de que haya salido, así que se dice que lo ha estado
-- preparando, que es lo que la fuente sostiene, y no que exista.
--
-- SE DEJAN FUERA LOS EXTRANJEROS que se nombran y que no pertenecen al
-- catálogo: Karelia Escalante (su maestra cubana), Jonathan Bass (su profesor
-- en Boston), José Romero (violinista colombiano), y los compositores europeos
-- y americanos del repertorio.
--
-- FUENTES: Navona Records, Presto Music, AllMusic y Apple Music Classical para
-- el disco. Take Effect, abril de 2025, para la reseña y el orden del programa.
-- El propio texto del lote para la trayectoria académica, que es coherente y
-- específica.
--
-- NOMBRES NUEVOS PARA LA LISTA: ninguno dominicano. Comprobado con
-- verificar-faltantes.cjs: Karelia Escalante no está y no debe estar, por
-- cubana; José Romero tampoco, por colombiano.
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
       name = 'Carlos Manuel Vargas',
       sort_name = 'Vargas, Carlos Manuel',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'instrumentalist',
       primary_genre = 'instrumental-classical',
       date_of_birth = NULL,
       birth_year = NULL,
       date_of_death = NULL,
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Carlos',
       middle_name = 'Manuel',
       last_name = 'Vargas',
       second_last_name = NULL,
       stage_name = 'Carlos Manuel Vargas',
       aliases = ARRAY[]::text[],
       occupations = '["pianist","music educator"]'::jsonb,
       instruments = ARRAY['piano']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'instrumental']::text[],
       website = 'https://www.carlosmanuelvargas.com',
       youtube = '@carlosvpiano',
       facebook = 'carlosvpiano',
       instagram = 'carlosvpiano',
       disambiguation = 'Classical pianist and educator from Santiago; recorded Dominican repertoire alongside the European canon',
       bio_en = 'Carlos Manuel Vargas is a Dominican classical pianist, teacher and concert organiser from Santiago de los Caballeros. He works between the European piano repertoire and music written in the Americas, and he holds a full-time faculty post at a United States conservatory, which the Dominican press treated as a first for a pianist from the country.

**Santiago and Boston**

He began his piano studies in the Dominican Republic with the Cuban pianist and teacher Karelia Escalante. A scholarship took him to the Boston Conservatory in 2005, where he completed both a bachelor’s and a master’s degree in piano performance under Jonathan Bass.

He is now an assistant professor in the instrumental studies and piano departments at Boston Conservatory at Berklee.

**The concert work**

He has played in the United States, South America and Europe, including a solo recital debut in Germany, and appeared with the National Symphony of Ecuador in Rachmaninoff’s second piano concerto.

**Souvenirs**

His first album was released by Navona Records in 2024. It is a deliberately mixed programme of thirteen pieces gathered across several countries and two centuries, opening with Villa-Lobos and taking in Poulenc, Scriabin and Gershwin.

It also carries Estudio en Zamba, by the Dominican composer Bullumba Landestoy. Placing a Dominican piece inside an international classical release is the part of the record that matters most from here: it puts the national repertoire on the same programme as the canon rather than in a bracket of its own.

He has been preparing a second album, Voyage, built around composers writing in Spanish, among them Enrique Granados, Federico Mompou, Aldo López-Gavilán and Andrea Casarrubios.

**Roxbury**

Half of his work is teaching. In 2008 he founded a programme of free music lessons for children in Roxbury and the neighbouring Boston communities, and in 2019 he received a Berklee award for that service. He is artistic director of a concert series in the same neighbourhood.

He also cofounded a chamber music organisation with the Colombian violinist José Romero, which has toured the Dominican Republic, Colombia, Ecuador, Mexico and Turkey.',
       bio_es = 'Carlos Manuel Vargas es un pianista clásico, profesor y organizador de conciertos dominicano, nacido en Santiago de los Caballeros. Trabaja entre el repertorio pianístico europeo y la música escrita en América, y ocupa una plaza de profesor a tiempo completo en un conservatorio estadounidense, cosa que la prensa dominicana trató como una primera vez para un pianista del país.

**Santiago y Boston**

Empezó sus estudios de piano en la República Dominicana con la pianista y pedagoga cubana Karelia Escalante. Una beca lo llevó al Conservatorio de Boston en 2005, donde completó una licenciatura y una maestría en interpretación pianística bajo la guía de Jonathan Bass.

Hoy es profesor asistente en los departamentos de estudios instrumentales y piano del Boston Conservatory at Berklee.

**El concierto**

Se ha presentado en Estados Unidos, Suramérica y Europa, con un debut en recital solista en Alemania, y actuó con la Orquesta Sinfónica Nacional de Ecuador en el segundo concierto para piano de Rachmaninoff.

**Souvenirs**

Su primer álbum salió por Navona Records en 2024. Es un programa deliberadamente mezclado, de trece piezas reunidas entre varios países y dos siglos, que abre con Villa-Lobos y recorre a Poulenc, Scriabin y Gershwin.

Incluye además Estudio en Zamba, del compositor dominicano Bullumba Landestoy. Meter una pieza dominicana dentro de un disco internacional de repertorio clásico es lo que más importa del álbum visto desde aquí: pone el repertorio nacional en el mismo programa que el canon y no en un apartado propio.

Ha estado preparando un segundo álbum, Voyage, armado alrededor de compositores que escriben en español, entre ellos Enrique Granados, Federico Mompou, Aldo López-Gavilán y Andrea Casarrubios.

**Roxbury**

La mitad de su trabajo es enseñar. En 2008 fundó un programa de clases de música gratuitas para niños en Roxbury y las comunidades vecinas de Boston, y en 2019 recibió un premio de Berklee por esa labor. Dirige artísticamente una serie de conciertos en ese mismo barrio.

Cofundó además una agrupación de música de cámara junto al violinista colombiano José Romero, que ha girado por la República Dominicana, Colombia, Ecuador, México y Turquía.',
       updated_at = now()
 WHERE slug = 'carlos-manuel-vargas';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'carlos-manuel-vargas')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'carlos-manuel-vargas')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Carlos Manuel Vargas is a Dominican classical pianist, teacher and concert organiser from Santiago de los Caballeros. He works between the European piano repertoire and music written in the Americas, and he holds a full-time faculty post at a United States conservatory, which the Dominican press treated as a first for a pianist from the country.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santiago and Boston","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He began his piano studies in the Dominican Republic with the Cuban pianist and teacher Karelia Escalante. A scholarship took him to the Boston Conservatory in 2005, where he completed both a bachelor’s and a master’s degree in piano performance under Jonathan Bass.","type":"text"}]},{"type":"paragraph","content":[{"text":"He is now an assistant professor in the instrumental studies and piano departments at Boston Conservatory at Berklee.","type":"text"}]},{"type":"paragraph","content":[{"text":"The concert work","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He has played in the United States, South America and Europe, including a solo recital debut in Germany, and appeared with the National Symphony of Ecuador in Rachmaninoff’s second piano concerto.","type":"text"}]},{"type":"paragraph","content":[{"text":"Souvenirs","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His first album was released by Navona Records in 2024. It is a deliberately mixed programme of thirteen pieces gathered across several countries and two centuries, opening with Villa-Lobos and taking in Poulenc, Scriabin and Gershwin.","type":"text"}]},{"type":"paragraph","content":[{"text":"It also carries Estudio en Zamba, by the Dominican composer ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e8f0b2fb-1aa1-4c68-b806-89ff0b85bf4c","displayText":"Bullumba Landestoy","occurrenceId":"a407bc1d-fc4b-4677-9054-70a2b1e1dded"}},{"text":". Placing a Dominican piece inside an international classical release is the part of the record that matters most from here: it puts the national repertoire on the same programme as the canon rather than in a bracket of its own.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has been preparing a second album, Voyage, built around composers writing in Spanish, among them Enrique Granados, Federico Mompou, Aldo López-Gavilán and Andrea Casarrubios.","type":"text"}]},{"type":"paragraph","content":[{"text":"Roxbury","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Half of his work is teaching. In 2008 he founded a programme of free music lessons for children in Roxbury and the neighbouring Boston communities, and in 2019 he received a Berklee award for that service. He is artistic director of a concert series in the same neighbourhood.","type":"text"}]},{"type":"paragraph","content":[{"text":"He also cofounded a chamber music organisation with the Colombian violinist José Romero, which has toured the Dominican Republic, Colombia, Ecuador, Mexico and Turkey.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'carlos-manuel-vargas'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Carlos Manuel Vargas es un pianista clásico, profesor y organizador de conciertos dominicano, nacido en Santiago de los Caballeros. Trabaja entre el repertorio pianístico europeo y la música escrita en América, y ocupa una plaza de profesor a tiempo completo en un conservatorio estadounidense, cosa que la prensa dominicana trató como una primera vez para un pianista del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santiago y Boston","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Empezó sus estudios de piano en la República Dominicana con la pianista y pedagoga cubana Karelia Escalante. Una beca lo llevó al Conservatorio de Boston en 2005, donde completó una licenciatura y una maestría en interpretación pianística bajo la guía de Jonathan Bass.","type":"text"}]},{"type":"paragraph","content":[{"text":"Hoy es profesor asistente en los departamentos de estudios instrumentales y piano del Boston Conservatory at Berklee.","type":"text"}]},{"type":"paragraph","content":[{"text":"El concierto","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se ha presentado en Estados Unidos, Suramérica y Europa, con un debut en recital solista en Alemania, y actuó con la Orquesta Sinfónica Nacional de Ecuador en el segundo concierto para piano de Rachmaninoff.","type":"text"}]},{"type":"paragraph","content":[{"text":"Souvenirs","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su primer álbum salió por Navona Records en 2024. Es un programa deliberadamente mezclado, de trece piezas reunidas entre varios países y dos siglos, que abre con Villa-Lobos y recorre a Poulenc, Scriabin y Gershwin.","type":"text"}]},{"type":"paragraph","content":[{"text":"Incluye además Estudio en Zamba, del compositor dominicano ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e8f0b2fb-1aa1-4c68-b806-89ff0b85bf4c","displayText":"Bullumba Landestoy","occurrenceId":"6ae3301e-a553-472c-92c1-daec149087c8"}},{"text":". Meter una pieza dominicana dentro de un disco internacional de repertorio clásico es lo que más importa del álbum visto desde aquí: pone el repertorio nacional en el mismo programa que el canon y no en un apartado propio.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ha estado preparando un segundo álbum, Voyage, armado alrededor de compositores que escriben en español, entre ellos Enrique Granados, Federico Mompou, Aldo López-Gavilán y Andrea Casarrubios.","type":"text"}]},{"type":"paragraph","content":[{"text":"Roxbury","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La mitad de su trabajo es enseñar. En 2008 fundó un programa de clases de música gratuitas para niños en Roxbury y las comunidades vecinas de Boston, y en 2019 recibió un premio de Berklee por esa labor. Dirige artísticamente una serie de conciertos en ese mismo barrio.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cofundó además una agrupación de música de cámara junto al violinista colombiano José Romero, que ha girado por la República Dominicana, Colombia, Ecuador, México y Turquía.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'carlos-manuel-vargas'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'carlos-manuel-vargas') AND locale = 'en'), 'a407bc1d-fc4b-4677-9054-70a2b1e1dded', 'artist', 'e8f0b2fb-1aa1-4c68-b806-89ff0b85bf4c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'carlos-manuel-vargas') AND locale = 'es'), '6ae3301e-a553-472c-92c1-daec149087c8', 'artist', 'e8f0b2fb-1aa1-4c68-b806-89ff0b85bf4c');

COMMIT;
