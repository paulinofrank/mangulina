BEGIN;

-- Rewrite the catalogue entry for Monkey Black.
--
-- Monkey Black. VIGESIMOTERCERA de las 211. 1.294 caracteres, tres parrafos, y
-- ni una cancion ni un colaborador sobre un rapero con TREINTA SENCILLOS
-- listados.
--
-- Lo que hacia era describir el ambiente: "immersed in the street culture and
-- musical ferment of a neighborhood that was becoming central to the Dominican
-- urban music movement", "a language for expressing their experiences,
-- aspirations, and frustrations". Vale para cualquiera de los 160 urbanos del
-- catalogo.
--
-- LOS DOS ALIAS ERAN BASURA, uno de cada patron conocido:
--   'Monkey Black'                      -> su propio nombre. Patron de 89 filas.
--   'Leonardo Michael Flores Ozuna'     -> el nombre legal, que ya esta
--                                          repartido en los cuatro campos.
--                                          Patron de 157 filas.
-- Los dos salen y no entra ninguno: Wikipedia lista mas apodos pero detras de
-- un desplegable que no pude leer, y no invento.
--
-- LO QUE FALTABA:
--
--   GRABO SU PRIMER MATERIAL A LOS DIEZ ANOS, con El Sujeto. Despues emigro a
--   PUERTO RICO, donde se dedico a varios oficios antes de volver.
--
--   2006: LAPIZ CONCIENTE LO PONE EN LA PALESTRA con "TIENEN MIEDO", que
--   grabaron los dos con BIG K. Musixmatch acredita a los tres.
--
--   "EL SOL Y LA PLAYA" (2009), producida por NICO CLINICO, es la que lo saca
--   del pais.
--
--   "VA TENE QUE VOLA" (2010), con MOZART LA PARA y VILLANOSAM.
--
--   TREINTA SENCILLOS entre 2007 y 2014, de "Locotron" a "Si Yo Me Escapo", y
--   un album, "Ultra Mega Universal", que quedo semiinedito.
--
--   SUS MULETILLAS ERAN PARTE DEL PERSONAJE: "No te haga", "Tu ta clara de
--   huevo". La fuente las recoge como rasgo suyo y no como anecdota.
--
--   EN FEBRERO DE 2023, NUEVE ANOS DESPUES DE SU MUERTE, HARLEY BOYS
--   ENTERTAINMENT COMPRO LOS DERECHOS DE SU CATALOGO MUSICAL. Lo publica Listin
--   Diario. Es un dato de derechos y por tanto entra de lleno.
--
-- ---------------------------------------------------------------------------
-- LA MUERTE ENTRA; LA MANERA, NO. Y LO ESCRIBO PORQUE ES DISCUTIBLE.
--
-- Murio el 30 de abril de 2014 en San Adria de Besos, cerca de Barcelona, a los
-- veintisiete. Lo mataron. Las fuentes -- EFE, El Pais, El Mundo, La Vanguardia --
-- lo cuentan con detalle y Wikipedia lo categoriza entre los musicos asesinados.
--
-- NO ESCRIBO COMO MURIO. La regla del editor excluye los asuntos penales, y un
-- homicidio lo es aunque el artista sea la victima. El precedente propio es
-- PEPE ROSARIO, cuya muerte violenta deje en fecha y lugar hace unos dias.
--
-- SI ENTRA EL LUGAR, y no por morbo: se habia mudado a Espana cuatro anos antes
-- para crecer fuera, y llevaba viviendo alli desde entonces. Eso es carrera.
--
-- TAMBIEN ENTRA LA REPATRIACION -- el cuerpo llego al pais el 17 de mayo -- por
-- la misma razon por la que entro el velatorio de Pepe: es un hecho publico
-- documentado por la prensa, no un dato clinico.
--
-- SI EL EDITOR PREFIERE QUE SE DIGA, es una linea.
-- ---------------------------------------------------------------------------
--
-- NO ENLAZO A EL SUJETO, Y ES DELIBERADO. El catalogo tiene `sujeto-oro-24`
-- (Johan Manuel Nova), y la prensa dominicana usa "El Sujeto" y "El Sujeto Oro
-- 24" para el mismo hombre. PERO Monkey Black grabo con "El Sujeto" a los DIEZ
-- ANOS, o sea hacia 1996, y Sujeto Oro 24 es un artista de merengue urbano muy
-- posterior. No puedo afirmar que sean el mismo sin comprobarlo, asi que se
-- nombra sin enlace y queda anotado.
--
-- occupations ESTABA VACIO y entra 'rapper', que es lo unico que todas las
-- fuentes le dan.
--
-- `primary_role` DICE 'singer' Y NO LO TOCO, aunque es rapero, PORQUE EL
-- CATALOGO ESTA PARTIDO EN DOS sobre esto: Toxic Crow y Vakero son 'rapper',
-- pero Lapiz Conciente y Mozart la Para -- raperos canonicos -- son 'singer' con
-- 'rapper' en occupations. Es una revision de conjunto, no una fila. Va a
-- CONFLICTOS_DE_DATO.md junto a la del merengue tipico.
--
-- Es distinto del caso de Felix del Rosario, donde si cambie el rol: aquel no
-- cantaba en absoluto y 'singer' era falso; aqui es impreciso.
--
-- CUATRO ENLACES.
--
-- FUENTES: Wikipedia en espanol, muy bien referenciada -- El Pais, El Mundo, La
-- Vanguardia, EFE, Listin Diario, El Dia --. Musixmatch para los creditos de
-- "Tienen Miedo". Las lineas de credito de YouTube para las fechas de edicion.
--
-- AUSENCIAS NUEVAS: BIG K, que grabo con el y con Lapiz Conciente en 2006, y
-- los sellos PAPA NEGO PROMOTIONS y HARLEY BOYS ENTERTAINMENT.
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
       name = 'Monkey Black',
       sort_name = 'Black, Monkey',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'urban-dembow',
       date_of_birth = '1986-07-26',
       birth_year = 1986,
       date_of_death = '2014-04-30',
       birth_place = 'Santo Domingo Este',
       province = 'Santo Domingo',
       first_name = 'Leonardo',
       middle_name = 'Michael',
       last_name = 'Flores',
       second_last_name = 'Ozuna',
       stage_name = 'Monkey Black',
       aliases = ARRAY[]::text[],
       occupations = '["rapper"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY['urbano']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Rapper from Los Mina who recorded from 2006 until his death in Spain in 2014',
       bio_en = 'Leonardo Michael Flores Ozuna, who recorded as Monkey Black, was a Dominican rapper from Los Mina. He worked from 2006 until his death in 2014, at twenty-seven, and left around thirty singles and one album that was never fully released.

**Los Mina and Puerto Rico**

He was born on 26 July 1986 in Los Mina, in Santo Domingo Este. He cut his first material at ten, alongside the rapper El Sujeto, and then left for Puerto Rico, where he worked at a series of trades before coming back.

**Tienen Miedo**

What put him in front of a Dominican audience was Lápiz Conciente. In 2006 the two of them recorded Tienen Miedo together with Big K, and the record moved him out of the local circuit.

El Sol y La Playa, produced by Nico Clínico and released in 2009, took him outside the country. Locotron had come in 2007 and Come To My Hood in 2008; Ay Dios, Algo de Mí and Entro Con La U followed in 2009, and Activo and La Polémica in 2010.

Va Tene Que Vola, from that same year, he made with Mozart la Para and Villanosam. After it came De Lo Mío, Punto de Vista and De un Plomaso, then Quién Como Yo, Más Que una Casa and, in the year he died, Capea el Dough Personal and Si Yo Me Escapo. The album Ultra Mega Universal was left largely unreleased.

**The phrases**

Part of what he was known for was verbal: the catchphrases he repeated on record and in interviews — No te haga, Tu ta clara de huevo — travelled further than some of the songs, and are the reason his delivery is recognisable to people who could not name a single title.

**Sant Adrià de Besòs**

He moved to Spain to build a career outside the Dominican Republic and had been living in Sant Adrià de Besòs, on the edge of Barcelona, for four years. He died there on 30 April 2014. His body was flown home on 17 May and he was buried in the Cementerio Cristo Salvador.

**The catalogue**

In February 2023, nine years after his death, the label Harley Boys Entertainment acquired the rights to his musical catalogue, which put the recordings back into circulation under a single owner.',
       bio_es = 'Leonardo Michael Flores Ozuna, que grababa como Monkey Black, fue un rapero dominicano de Los Mina. Trabajó desde 2006 hasta su muerte en 2014, a los veintisiete, y dejó una treintena de sencillos y un álbum que nunca llegó a publicarse entero.

**Los Mina y Puerto Rico**

Nació el 26 de julio de 1986 en Los Mina, en Santo Domingo Este. Grabó su primer material a los diez años, junto al rapero El Sujeto, y después se fue a Puerto Rico, donde se dedicó a varios oficios antes de volver.

**Tienen Miedo**

Quien lo puso delante del público dominicano fue Lápiz Conciente. En 2006 los dos grabaron Tienen Miedo junto a Big K, y el tema lo sacó del circuito local.

El Sol y La Playa, producida por Nico Clínico y publicada en 2009, es la que lo saca del país. Locotron había salido en 2007 y Come To My Hood en 2008; Ay Dios, Algo de Mí y Entro Con La U llegaron en 2009, y Activo y La Polémica en 2010.

Va Tene Que Vola, de ese mismo año, la hizo con Mozart la Para y Villanosam. Detrás vinieron De Lo Mío, Punto de Vista y De un Plomaso, y después Quién Como Yo, Más Que una Casa y, el año en que murió, Capea el Dough Personal y Si Yo Me Escapo. El álbum Ultra Mega Universal quedó casi inédito.

**Las muletillas**

Parte de lo que lo hizo reconocible era verbal: las muletillas que repetía en los discos y en las entrevistas —No te haga, Tu ta clara de huevo— viajaron más lejos que algunas de las canciones, y son la razón de que se le reconozca la manera de hablar sin poder nombrar un solo título.

**San Adrián de Besós**

Se mudó a España para hacer carrera fuera de la República Dominicana y llevaba cuatro años viviendo en San Adrián de Besós, al lado de Barcelona. Murió allí el 30 de abril de 2014. Su cuerpo llegó al país el 17 de mayo y fue enterrado en el Cementerio Cristo Salvador.

**El catálogo**

En febrero de 2023, nueve años después de su muerte, el sello Harley Boys Entertainment compró los derechos de su catálogo musical, con lo que las grabaciones volvieron a circular bajo un solo dueño.',
       updated_at = now()
 WHERE slug = 'monkey-black';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monkey-black')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monkey-black')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Leonardo Michael Flores Ozuna, who recorded as Monkey Black, was a Dominican rapper from Los Mina. He worked from 2006 until his death in 2014, at twenty-seven, and left around thirty singles and one album that was never fully released.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Mina and Puerto Rico","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born on 26 July 1986 in Los Mina, in Santo Domingo Este. He cut his first material at ten, alongside the rapper El Sujeto, and then left for Puerto Rico, where he worked at a series of trades before coming back.","type":"text"}]},{"type":"paragraph","content":[{"text":"Tienen Miedo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"What put him in front of a Dominican audience was ","type":"text"},{"type":"artistReference","attrs":{"artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente","occurrenceId":"1766bc02-df4e-4f15-bc6c-7b322aa897ab"}},{"text":". In 2006 the two of them recorded Tienen Miedo together with Big K, and the record moved him out of the local circuit.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Sol y La Playa, produced by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"66512533-3c96-45f0-b248-d0d5e0e586d7","displayText":"Nico Clínico","occurrenceId":"a51736ec-e970-4420-a29e-7710793f1e26"}},{"text":" and released in 2009, took him outside the country. Locotron had come in 2007 and Come To My Hood in 2008; Ay Dios, Algo de Mí and Entro Con La U followed in 2009, and Activo and La Polémica in 2010.","type":"text"}]},{"type":"paragraph","content":[{"text":"Va Tene Que Vola, from that same year, he made with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fa9cc802-28ca-4695-b585-f75aa90a2b6c","displayText":"Mozart la Para","occurrenceId":"3913791c-097c-4167-8154-7be2c2943602"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"262f4f73-c480-47f9-8bc8-75cf2cd65413","displayText":"Villanosam","occurrenceId":"1811aecf-3e65-4126-9a82-9e8186884e4f"}},{"text":". After it came De Lo Mío, Punto de Vista and De un Plomaso, then Quién Como Yo, Más Que una Casa and, in the year he died, Capea el Dough Personal and Si Yo Me Escapo. The album Ultra Mega Universal was left largely unreleased.","type":"text"}]},{"type":"paragraph","content":[{"text":"The phrases","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Part of what he was known for was verbal: the catchphrases he repeated on record and in interviews — No te haga, Tu ta clara de huevo — travelled further than some of the songs, and are the reason his delivery is recognisable to people who could not name a single title.","type":"text"}]},{"type":"paragraph","content":[{"text":"Sant Adrià de Besòs","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He moved to Spain to build a career outside the Dominican Republic and had been living in Sant Adrià de Besòs, on the edge of Barcelona, for four years. He died there on 30 April 2014. His body was flown home on 17 May and he was buried in the Cementerio Cristo Salvador.","type":"text"}]},{"type":"paragraph","content":[{"text":"The catalogue","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In February 2023, nine years after his death, the label Harley Boys Entertainment acquired the rights to his musical catalogue, which put the recordings back into circulation under a single owner.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'monkey-black'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Leonardo Michael Flores Ozuna, que grababa como Monkey Black, fue un rapero dominicano de Los Mina. Trabajó desde 2006 hasta su muerte en 2014, a los veintisiete, y dejó una treintena de sencillos y un álbum que nunca llegó a publicarse entero.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Mina y Puerto Rico","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació el 26 de julio de 1986 en Los Mina, en Santo Domingo Este. Grabó su primer material a los diez años, junto al rapero El Sujeto, y después se fue a Puerto Rico, donde se dedicó a varios oficios antes de volver.","type":"text"}]},{"type":"paragraph","content":[{"text":"Tienen Miedo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Quien lo puso delante del público dominicano fue ","type":"text"},{"type":"artistReference","attrs":{"artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente","occurrenceId":"1016d49a-b1ab-4ba4-be33-553b35b12408"}},{"text":". En 2006 los dos grabaron Tienen Miedo junto a Big K, y el tema lo sacó del circuito local.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Sol y La Playa, producida por ","type":"text"},{"type":"artistReference","attrs":{"artistId":"66512533-3c96-45f0-b248-d0d5e0e586d7","displayText":"Nico Clínico","occurrenceId":"152b5330-0c6a-4fc4-b4f9-036331a3ce10"}},{"text":" y publicada en 2009, es la que lo saca del país. Locotron había salido en 2007 y Come To My Hood en 2008; Ay Dios, Algo de Mí y Entro Con La U llegaron en 2009, y Activo y La Polémica en 2010.","type":"text"}]},{"type":"paragraph","content":[{"text":"Va Tene Que Vola, de ese mismo año, la hizo con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fa9cc802-28ca-4695-b585-f75aa90a2b6c","displayText":"Mozart la Para","occurrenceId":"6e364a97-e551-4c65-b3dc-2ed4652c4cd5"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"262f4f73-c480-47f9-8bc8-75cf2cd65413","displayText":"Villanosam","occurrenceId":"06286078-c05b-4dfa-ad9d-1b7fb4593203"}},{"text":". Detrás vinieron De Lo Mío, Punto de Vista y De un Plomaso, y después Quién Como Yo, Más Que una Casa y, el año en que murió, Capea el Dough Personal y Si Yo Me Escapo. El álbum Ultra Mega Universal quedó casi inédito.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las muletillas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Parte de lo que lo hizo reconocible era verbal: las muletillas que repetía en los discos y en las entrevistas —No te haga, Tu ta clara de huevo— viajaron más lejos que algunas de las canciones, y son la razón de que se le reconozca la manera de hablar sin poder nombrar un solo título.","type":"text"}]},{"type":"paragraph","content":[{"text":"San Adrián de Besós","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se mudó a España para hacer carrera fuera de la República Dominicana y llevaba cuatro años viviendo en San Adrián de Besós, al lado de Barcelona. Murió allí el 30 de abril de 2014. Su cuerpo llegó al país el 17 de mayo y fue enterrado en el Cementerio Cristo Salvador.","type":"text"}]},{"type":"paragraph","content":[{"text":"El catálogo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En febrero de 2023, nueve años después de su muerte, el sello Harley Boys Entertainment compró los derechos de su catálogo musical, con lo que las grabaciones volvieron a circular bajo un solo dueño.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'monkey-black'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monkey-black') AND locale = 'en'), '1766bc02-df4e-4f15-bc6c-7b322aa897ab', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monkey-black') AND locale = 'en'), '1811aecf-3e65-4126-9a82-9e8186884e4f', 'artist', '262f4f73-c480-47f9-8bc8-75cf2cd65413');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monkey-black') AND locale = 'en'), '3913791c-097c-4167-8154-7be2c2943602', 'artist', 'fa9cc802-28ca-4695-b585-f75aa90a2b6c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monkey-black') AND locale = 'en'), 'a51736ec-e970-4420-a29e-7710793f1e26', 'artist', '66512533-3c96-45f0-b248-d0d5e0e586d7');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monkey-black') AND locale = 'es'), '06286078-c05b-4dfa-ad9d-1b7fb4593203', 'artist', '262f4f73-c480-47f9-8bc8-75cf2cd65413');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monkey-black') AND locale = 'es'), '1016d49a-b1ab-4ba4-be33-553b35b12408', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monkey-black') AND locale = 'es'), '152b5330-0c6a-4fc4-b4f9-036331a3ce10', 'artist', '66512533-3c96-45f0-b248-d0d5e0e586d7');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'monkey-black') AND locale = 'es'), '6e364a97-e551-4c65-b3dc-2ed4652c4cd5', 'artist', 'fa9cc802-28ca-4695-b585-f75aa90a2b6c');

COMMIT;
