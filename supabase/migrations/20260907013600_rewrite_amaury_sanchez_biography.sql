BEGIN;

-- Rewrite the catalogue entry for Amaury Sánchez.
--
-- Amaury Sánchez. Octava de las dieciséis fichas publicadas que estaban EN
-- BLANCO. Nueve Premios Casandra, veintitrés nominaciones más, el primer
-- dominicano que consiguió licencia de Disney para montar un musical, y su
-- página no decía nada.
--
-- NO TIENE ARTÍCULO EN WIKIPEDIA, ni en español ni en inglés. La fuente
-- principal es Conectate.com.do, del 27 de marzo de 2023, que trae biografía y
-- el listado de espectáculos año por año. Se complementa con Diario Libre.
--
-- LO QUE YA TENÍA LA FILA SE CONFIRMA Y NO SE TOCA: Luis Amaury Sánchez
-- Lembert, 22 de julio de 1963, Santo Domingo. primary_role instrumentalist y
-- primary_genre instrumental son adecuados para una carrera sinfónica y de
-- teatro musical, y se quedan.
--
-- DISCREPANCIA DE ORQUESTA QUE DEJO ANOTADA. Conectate dice que fundó la
-- ORQUESTA FILARMÓNICA DE SANTO DOMINGO y que es su director titular. Diario
-- Libre, en 2007, dice que fundó la ORQUESTA SANTO DOMINGO POPS. Pueden ser dos
-- agrupaciones distintas, o la misma con otro nombre en otra etapa. No encontré
-- nada que lo aclare, así que la prosa dice lo que sostiene la fuente más
-- reciente y detallada, sin negar la otra, y esto queda escrito para quien
-- pueda resolverlo.
--
-- LOS NUEVE CASANDRA NO SE PUEDEN FECHAR. Conectate dice que ganó nueve en
-- categorías de Arreglista del Año, Espectáculo Popular del Año, Mejor Musical
-- y Mejor Concierto "entre otras", pero NO DA UN SOLO AÑO, y no encontré
-- ninguna otra fuente que los desglose.
--
-- SE USA LA CONVENCIÓN QUE LA BASE YA TIENE PARA ESTO: la categoría "Multiple
-- Category Wins", con year en NULL y el detalle en el campo work. Así están ya
-- Johnny Ventura, Fernando Villalona y Eddy Herrera. Es preferible a inventar
-- nueve años o a dejar fuera nueve premios reales.
--
-- UN ENLACE, Y CON MOTIVO: fernando-villalona. Sánchez produjo el concierto
-- "Fernando Villalona Sinfónico", que ganó Concierto del Año en los Soberano
-- 2018. La misma edición en que él estaba nominado como arreglista.
--
-- NO SE ENLAZAN NI SE AÑADEN Danny Rivera (puertorriqueño), Alberto Cortés
-- (argentino) ni Plácido Domingo (español), aunque produjo sinfónicos con los
-- tres. No son música dominicana.
--
-- INSTRUMENTS SOLO PERCUSIÓN Y PIANO. Estudió percusión en el Conservatorio y
-- entró con ella a la Sinfónica Nacional, así que esa es segura. El piano lo
-- sostiene además su obra ("Fantasías Populares para piano y cuerdas"). LA
-- GUITARRA CLÁSICA LA ESTUDIÓ pero no hay prueba de que la toque en público:
-- va en la prosa y no en el campo.
--
-- OCCUPATIONS: se conservan conductor y composer, que ya estaban, y se agregan
-- arranger, producer y musical_director. Los cinco existen en el vocabulario.
--
-- LOS PREMIOS VAN EN MIGRACIÓN APARTE: hay que crear la entidad Jaycees.
--
-- FUENTES: Conectate.com.do, 27 de marzo de 2023. Diario Libre, Hombre del Año
-- 2007, y su reportaje del 29 de diciembre de 2024 sobre la academia.
--
-- NOMBRES NUEVOS PARA LA LISTA DE FALTANTES: la Orquesta Filarmónica de Santo
-- Domingo, que él dirige, y la Orquesta Sinfónica Nacional, que no está en el
-- catálogo pese a ser la institución sinfónica del país.
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
       name = 'Amaury Sánchez',
       sort_name = 'Sánchez Lembert, Luis Amaury',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'instrumentalist',
       primary_genre = 'instrumental',
       date_of_birth = '1963-07-22',
       birth_year = 1963,
       date_of_death = NULL,
       birth_place = 'Santo Domingo',
       province = 'Santo Domingo',
       first_name = 'Luis',
       middle_name = 'Amaury',
       last_name = 'Sánchez',
       second_last_name = 'Lembert',
       stage_name = 'Amaury Sánchez',
       aliases = ARRAY[]::text[],
       occupations = '["conductor","composer","arranger","producer","musical_director"]'::jsonb,
       instruments = ARRAY['percussion', 'piano']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = 'amaury.sanchez.566',
       instagram = 'amaurysanchez',
       disambiguation = 'Conductor, arranger and producer; the leading Dominican producer of stage musicals and symphonic concerts',
       bio_en = 'Luis Amaury Sánchez Lembert, known as Amaury Sánchez, is a Dominican conductor, arranger, composer and producer. He is the country’s leading producer of stage musicals and of symphonic concerts built around popular artists, and he has won nine awards from the Dominican critics’ association.

**From the conservatory to the symphony**

He was born in Santo Domingo in 1963 and studied percussion at the Conservatorio Nacional de Música, along with piano and classical guitar. In 1987 he joined the Orquesta Sinfónica Nacional, where he spent some fifteen years and was appointed assistant conductor.

He completed conducting studies in Spain, New York and Chile. He has conducted the national symphony on several occasions, founded a philharmonic orchestra in Santo Domingo which he directs, and has appeared as guest conductor of the Arturo Somohano Philharmonic in Puerto Rico.

**Musical theatre**

He began producing large stage shows in the mid-nineties and moved into book musicals with La Novicia Rebelde and Jesucristo Superstar. In 2006 he produced Disney’s Beauty and the Beast, becoming the first Dominican to obtain the licence to stage it. The run filled the house fourteen times, and Music Theatre International extended his licence to the rest of Latin America, which took the production to the Teatro Teresa Carreño in Venezuela.

The list that followed covers most of the standard repertoire: Evita, Peter Pan, Cabaret, Annie, Cats, Cenicienta, Chicago, Dream Girls, El Mago de Oz, In the Heights and Little Shop of Horrors, alongside revues built on disco, the eighties and symphonic rock.

**Composition**

His own catalogue includes La Misa Festiva Dominicana and Fantasías Populares para Piano y Cuerdas, and scores for Dominican cinema, among them Cuatro Hombres y un Ataúd, Los Inmortales, Negocios Son Negocios and Mi Novia Está de Madre. He also wrote the symphonic arrangements for a live concert DVD by the Puerto Rican singer Danny Rivera.

**The symphonic concerts**

A distinct strand of his work sets popular singers in front of an orchestra. He produced Fernando Villalona Sinfónico, a concert with Fernando Villalona that was named concert of the year, and has staged similar programmes with visiting artists.

**Teaching**

He runs an academy of artistic training in which singers, dancers and musicians are prepared for the stage, and much of the cast of his productions has come through it.

**Recognition**

He has won nine awards from the Asociación de Cronistas de Arte, in categories covering arrangement, popular show, best musical and best concert, with a further twenty-three nominations. In 2002 he received a Jaycees award as an outstanding young Dominican.',
       bio_es = 'Luis Amaury Sánchez Lembert, conocido como Amaury Sánchez, es un director de orquesta, arreglista, compositor y productor dominicano. Es el principal productor de teatro musical del país y de conciertos sinfónicos armados alrededor de artistas populares, y ha ganado nueve premios de la asociación dominicana de cronistas de arte.

**Del conservatorio a la sinfónica**

Nació en Santo Domingo en 1963 y estudió percusión en el Conservatorio Nacional de Música, además de piano y guitarra clásica. En 1987 entró a la Orquesta Sinfónica Nacional, donde pasó unos quince años y llegó a ser designado director asistente.

Completó estudios de dirección en España, Nueva York y Chile. Ha dirigido la sinfónica nacional en varias ocasiones, fundó una orquesta filarmónica en Santo Domingo que dirige, y ha sido director invitado de la Filarmónica Arturo Somohano de Puerto Rico.

**El teatro musical**

Empezó a producir grandes espectáculos de escenario a mediados de los noventa y pasó al musical con libreto con La Novicia Rebelde y Jesucristo Superstar. En 2006 produjo La Bella y la Bestia, de Disney, y fue el primer dominicano en obtener la licencia para montarla. La temporada llenó la sala catorce veces, y Music Theatre International le extendió el permiso al resto de América Latina, lo que llevó el montaje al Teatro Teresa Carreño de Venezuela.

La lista que vino después cubre buena parte del repertorio corriente: Evita, Peter Pan, Cabaret, Annie, Cats, Cenicienta, Chicago, Dream Girls, El Mago de Oz, In the Heights y La Tiendita del Horror, junto a revistas armadas sobre la música disco, los ochenta y el rock sinfónico.

**La composición**

Su catálogo propio incluye La Misa Festiva Dominicana y Fantasías Populares para Piano y Cuerdas, además de música para el cine dominicano, entre ella Cuatro Hombres y un Ataúd, Los Inmortales, Negocios Son Negocios y Mi Novia Está de Madre. Escribió también los arreglos sinfónicos para un DVD en vivo del cantante puertorriqueño Danny Rivera.

**Los sinfónicos**

Una línea aparte de su trabajo pone a cantantes populares delante de una orquesta. Produjo Fernando Villalona Sinfónico, un concierto con Fernando Villalona que fue nombrado concierto del año, y ha montado programas parecidos con artistas visitantes.

**La enseñanza**

Dirige una academia de formación artística donde se prepara para el escenario a cantantes, bailarines y músicos, y buena parte del elenco de sus producciones ha salido de ahí.

**Reconocimientos**

Ha ganado nueve premios de la Asociación de Cronistas de Arte, en categorías de arreglo, espectáculo popular, mejor musical y mejor concierto, con otras veintitrés nominaciones. En 2002 recibió un premio Jaycees como joven dominicano sobresaliente.',
       updated_at = now()
 WHERE slug = 'amaury-sanchez';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'amaury-sanchez')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'amaury-sanchez')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Luis Amaury Sánchez Lembert, known as Amaury Sánchez, is a Dominican conductor, arranger, composer and producer. He is the country’s leading producer of stage musicals and of symphonic concerts built around popular artists, and he has won nine awards from the Dominican critics’ association.","type":"text"}]},{"type":"paragraph","content":[{"text":"From the conservatory to the symphony","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Santo Domingo in 1963 and studied percussion at the Conservatorio Nacional de Música, along with piano and classical guitar. In 1987 he joined the Orquesta Sinfónica Nacional, where he spent some fifteen years and was appointed assistant conductor.","type":"text"}]},{"type":"paragraph","content":[{"text":"He completed conducting studies in Spain, New York and Chile. He has conducted the national symphony on several occasions, founded a philharmonic orchestra in Santo Domingo which he directs, and has appeared as guest conductor of the Arturo Somohano Philharmonic in Puerto Rico.","type":"text"}]},{"type":"paragraph","content":[{"text":"Musical theatre","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He began producing large stage shows in the mid-nineties and moved into book musicals with La Novicia Rebelde and Jesucristo Superstar. In 2006 he produced Disney’s Beauty and the Beast, becoming the first Dominican to obtain the licence to stage it. The run filled the house fourteen times, and Music Theatre International extended his licence to the rest of Latin America, which took the production to the Teatro Teresa Carreño in Venezuela.","type":"text"}]},{"type":"paragraph","content":[{"text":"The list that followed covers most of the standard repertoire: Evita, Peter Pan, Cabaret, Annie, Cats, Cenicienta, Chicago, Dream Girls, El Mago de Oz, In the Heights and Little Shop of Horrors, alongside revues built on disco, the eighties and symphonic rock.","type":"text"}]},{"type":"paragraph","content":[{"text":"Composition","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His own catalogue includes La Misa Festiva Dominicana and Fantasías Populares para Piano y Cuerdas, and scores for Dominican cinema, among them Cuatro Hombres y un Ataúd, Los Inmortales, Negocios Son Negocios and Mi Novia Está de Madre. He also wrote the symphonic arrangements for a live concert DVD by the Puerto Rican singer Danny Rivera.","type":"text"}]},{"type":"paragraph","content":[{"text":"The symphonic concerts","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A distinct strand of his work sets popular singers in front of an orchestra. He produced Fernando Villalona Sinfónico, a concert with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"add846b2-5a06-44ea-9ada-f79d63e958eb"}},{"text":" that was named concert of the year, and has staged similar programmes with visiting artists.","type":"text"}]},{"type":"paragraph","content":[{"text":"Teaching","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He runs an academy of artistic training in which singers, dancers and musicians are prepared for the stage, and much of the cast of his productions has come through it.","type":"text"}]},{"type":"paragraph","content":[{"text":"Recognition","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He has won nine awards from the Asociación de Cronistas de Arte, in categories covering arrangement, popular show, best musical and best concert, with a further twenty-three nominations. In 2002 he received a Jaycees award as an outstanding young Dominican.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'amaury-sanchez'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Luis Amaury Sánchez Lembert, conocido como Amaury Sánchez, es un director de orquesta, arreglista, compositor y productor dominicano. Es el principal productor de teatro musical del país y de conciertos sinfónicos armados alrededor de artistas populares, y ha ganado nueve premios de la asociación dominicana de cronistas de arte.","type":"text"}]},{"type":"paragraph","content":[{"text":"Del conservatorio a la sinfónica","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santo Domingo en 1963 y estudió percusión en el Conservatorio Nacional de Música, además de piano y guitarra clásica. En 1987 entró a la Orquesta Sinfónica Nacional, donde pasó unos quince años y llegó a ser designado director asistente.","type":"text"}]},{"type":"paragraph","content":[{"text":"Completó estudios de dirección en España, Nueva York y Chile. Ha dirigido la sinfónica nacional en varias ocasiones, fundó una orquesta filarmónica en Santo Domingo que dirige, y ha sido director invitado de la Filarmónica Arturo Somohano de Puerto Rico.","type":"text"}]},{"type":"paragraph","content":[{"text":"El teatro musical","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Empezó a producir grandes espectáculos de escenario a mediados de los noventa y pasó al musical con libreto con La Novicia Rebelde y Jesucristo Superstar. En 2006 produjo La Bella y la Bestia, de Disney, y fue el primer dominicano en obtener la licencia para montarla. La temporada llenó la sala catorce veces, y Music Theatre International le extendió el permiso al resto de América Latina, lo que llevó el montaje al Teatro Teresa Carreño de Venezuela.","type":"text"}]},{"type":"paragraph","content":[{"text":"La lista que vino después cubre buena parte del repertorio corriente: Evita, Peter Pan, Cabaret, Annie, Cats, Cenicienta, Chicago, Dream Girls, El Mago de Oz, In the Heights y La Tiendita del Horror, junto a revistas armadas sobre la música disco, los ochenta y el rock sinfónico.","type":"text"}]},{"type":"paragraph","content":[{"text":"La composición","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su catálogo propio incluye La Misa Festiva Dominicana y Fantasías Populares para Piano y Cuerdas, además de música para el cine dominicano, entre ella Cuatro Hombres y un Ataúd, Los Inmortales, Negocios Son Negocios y Mi Novia Está de Madre. Escribió también los arreglos sinfónicos para un DVD en vivo del cantante puertorriqueño Danny Rivera.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los sinfónicos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Una línea aparte de su trabajo pone a cantantes populares delante de una orquesta. Produjo Fernando Villalona Sinfónico, un concierto con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"00dd5af8-2ed4-43b0-8f6d-570d7d8670a2"}},{"text":" que fue nombrado concierto del año, y ha montado programas parecidos con artistas visitantes.","type":"text"}]},{"type":"paragraph","content":[{"text":"La enseñanza","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Dirige una academia de formación artística donde se prepara para el escenario a cantantes, bailarines y músicos, y buena parte del elenco de sus producciones ha salido de ahí.","type":"text"}]},{"type":"paragraph","content":[{"text":"Reconocimientos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Ha ganado nueve premios de la Asociación de Cronistas de Arte, en categorías de arreglo, espectáculo popular, mejor musical y mejor concierto, con otras veintitrés nominaciones. En 2002 recibió un premio Jaycees como joven dominicano sobresaliente.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'amaury-sanchez'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'amaury-sanchez') AND locale = 'en'), 'add846b2-5a06-44ea-9ada-f79d63e958eb', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'amaury-sanchez') AND locale = 'es'), '00dd5af8-2ed4-43b0-8f6d-570d7d8670a2', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

COMMIT;
