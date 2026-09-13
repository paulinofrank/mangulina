BEGIN;

-- Rewrite the catalogue entry for Toño Rosario.
--
-- Toño Rosario. QUINTA de las 211, con 16 enlaces entrantes. Y la ficha MÁS
-- CORTA de todo el lote: 950 caracteres. Menos que Rafael Solano, que hasta hoy
-- tenía el récord.
--
-- No nombraba una canción, un disco, un año, un escenario ni un hermano. De uno
-- de los merengueros más vendedores de los noventa.
--
-- CASI BORRO UN HANDLE BUENO, Y CONVIENE DEJARLO ESCRITO. La fila guarda youtube
-- '@ToñoRosario-p8s'. El sufijo "-p8s" tiene toda la pinta de handle
-- autogenerado por YouTube, del mismo tipo que el de José Alberto "El Canario"
-- que rechacé hace días por dar 404. Lo probé con curl y DIO 404 TAMBIÉN.
--
-- Estuve a punto de vaciarlo. Antes fui al video de "Kulikitaka" y miré a qué
-- canal pertenece: pertenece a ese, con 596 mil suscriptores y es el oficial. Mi
-- prueba estaba mal: LA Ñ HAY QUE CODIFICARLA. Con %C3%B1 la URL responde. El
-- handle se queda. Lección para el resto de la corrida: los handles con
-- caracteres no ASCII no se prueban con curl sin codificar.
--
-- LOS OTROS DOS HANDLES TAMBIÉN ESTÁN VIVOS, comprobados: instagram
-- tonogalactico y facebook TonoRosarioGalactico, los dos dan 200.
--
-- EL NOMBRE LEGAL ESTABA A MEDIAS Y LOS ALIAS ESTABAN AL REVÉS. Se llama MÁXIMO
-- ANTONIO DEL ROSARIO ALMONTE: last_name debía ser "del Rosario" y
-- second_last_name "Almonte", que faltaba. Y aliases guardaba DOS VARIANTES DEL
-- NOMBRE LEGAL -- una con acentos y otra sin -- en vez de sus apodos reales.
-- DUODÉCIMO caso del patrón, y este además desperdiciaba el campo: le decían EL
-- CUCO y TU CUQUITO, que es de donde sale el título de su disco "La Magia del
-- Cuco" de 1999. Entran esos, y EL GALÁCTICO, que sale de sus propias cuentas
-- oficiales.
--
-- LA FICHA VIEJA DECÍA "born Antonio Rosario", que es el nombre a medias.
--
-- TRES ENLACES: los-hermanos-rosario, la orquesta familiar donde empezó;
-- rafa-rosario, su hermano, con quien sostuvo el grupo; y wilfrido-vargas, con
-- quien grabó el disco "Juntos" en 2002.
--
-- EL PARENTESCO CON RAFA VA A LA TABLA, no a la prosa: los dos están publicados,
-- así que es 'sibling' de manual. Migración aparte.
--
-- LA MUERTE DE PEPE ROSARIO SE ESCRIBE SIN CIRCUNSTANCIAS. Murió el 19 de marzo
-- de 1983 y la fuente dice que fue "en un confuso incidente en un centro
-- nocturno". Que un cantante fundador del grupo muriera en 1983 y que Toño y
-- Rafa sostuvieran la orquesta después es historia de la agrupación y entra. Lo
-- demás es asunto penal y no.
--
-- PEPE ROSARIO NO ESTÁ EN EL CATÁLOGO. Comprobado: hay siete filas con
-- "Rosario" y él no está. Va a la lista.
--
-- NO ESCRIBO QUE FUE EL PRIMER MERENGUERO EN LLENAR EL MADISON SQUARE GARDEN.
-- La fuente lo afirma, pero el artículo entero está marcado por Wikipedia como
-- necesitado de referencias desde 2011, y "el primero en" es justo la clase de
-- afirmación que hay que corroborar. SÍ ESCRIBO las salas, que son verificables
-- y dicen lo mismo sin arriesgar: United Palace, Altos de Chavón, la Plaza de
-- Toros de Madrid, el Estadio Centenario de Cuernavaca.
--
-- LO QUE SE DEJA FUERA: sus cuatro matrimonios, sus diez hijos con nombres, y
-- las dos polémicas que la fuente titula "Controversias" -- que dijo no conocer
-- a Milly Quezada en 2007 y que dijo en radio que su hermano Rafa cantaba mal en
-- 2009. Lo primero es anécdota de farándula; lo segundo es una pelea familiar
-- aireada, y este catálogo registra el trabajo, no los pleitos entre hermanos.
--
-- SIGUE ACTIVO Y LA FICHA LO DICE: su canal anuncia fechas de octubre de 2026 en
-- Nueva Jersey, el United Palace de Nueva York y Massachusetts.
--
-- FUENTES: Wikipedia en español, con la reserva dicha, para la biografía y una
-- discografía muy detallada con años. El canal oficial de YouTube para
-- comprobar el handle y las fechas de gira.
--
-- NOMBRES NUEVOS PARA LA LISTA: PEPE ROSARIO, cantante fundador de Los Hermanos
-- Rosario, muerto en 1983; y LUIS, TONY y FRANCIS ROSARIO, los otros hermanos
-- integrantes del grupo. Ninguno tiene ficha.
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
       name = 'Toño Rosario',
       sort_name = 'del Rosario Almonte, Máximo Antonio',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1955-11-03',
       birth_year = 1955,
       date_of_death = NULL,
       birth_place = 'Higüey',
       province = 'La Altagracia',
       first_name = 'Máximo',
       middle_name = 'Antonio',
       last_name = 'del Rosario',
       second_last_name = 'Almonte',
       stage_name = NULL,
       aliases = ARRAY['El Cuco', 'Tu Cuquito', 'El Galáctico']::text[],
       occupations = '["songwriter"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@ToñoRosario-p8s',
       facebook = 'TonoRosarioGalactico',
       instagram = 'tonogalactico',
       disambiguation = 'Merengue singer known as El Cuco; left Los Hermanos Rosario for the biggest solo career of the nineties',
       bio_en = 'Máximo Antonio del Rosario Almonte, known as Toño Rosario and called El Cuco, is a Dominican merengue singer. He came out of his own family’s orchestra and built the largest solo merengue career of the nineties on top of it, and he is still touring.

**Higüey**

He was born in 1955 in Higüey, the seat of La Altagracia province in the east of the country. He and his brothers were making instruments out of bottle caps and plastic containers as children and playing them in the neighbourhood, and what began there became a band.

**Los Hermanos Rosario**

The group was Los Hermanos Rosario. Pepe, Toño and Rafa Rosario sang; Luis, Tony and Francis made up the rest. Pepe died in March 1983, and Toño and Rafa kept the orchestra in front, taking it through the decade in which it became one of the biggest merengue bands in the country and outside it.

**Coliseo Roberto Clemente**

He left the family band to form his own orchestra and made his solo debut on 14 April 1990 at the Coliseo Roberto Clemente in San Juan, Puerto Rico. The records came fast after that: Y Más… that same year, Atado a Ti in 1991, Retorno a las Raíces in 1992, Amor Jollao in 1993, Me Olvidé de Vivir in 1994 and Quiero Volver a Empezar in 1995.

Seguiré followed in 1997, Exclusivo in 1998, La Magia del Cuco in 1999 — named for what everyone calls him — and Yo Soy Toño in 2000. He kept releasing through the two thousands with Toño en América, Resistiré and A Tu Gusto.

**Kulikitaka**

The songs people sing back to him run across all of it: La Gozadera, which he numbered and kept remaking; Kulikitaka; Bárbara; Víbora del Mar; Jenny; La Última Copa; Me Olvidé de Vivir; Alegría; Quiero Volver a Empezar; Desnúdate, Mujer; and Ábreme la Puerta.

He has also recorded across the genre’s borders. Traigo la Bomba, in 1992, was made with the Puerto Rican rapper Vico C at a point when merengue and rap were not yet in the habit of sharing a record, and in 2002 he made the album Juntos with Wilfrido Vargas.

**The rooms**

The venues are the measure of the solo career. He has filled the United Palace in New York, Altos de Chavón at home, the Plaza de Toros in Madrid and the Estadio Centenario in Cuernavaca, and he has played Madison Square Garden.

He is still working. His own channel lists dates for late 2026 in New Jersey, at the United Palace and in Massachusetts, which puts the touring career past fifty years counting from the family band.',
       bio_es = 'Máximo Antonio del Rosario Almonte, conocido como Toño Rosario y llamado El Cuco, es un cantante de merengue dominicano. Salió de la orquesta de su propia familia y levantó encima la carrera solista de merengue más grande de los noventa, y sigue de gira.

**Higüey**

Nació en 1955 en Higüey, cabecera de la provincia La Altagracia, al este del país. Él y sus hermanos hacían instrumentos con tapas de botella y envases de plástico cuando eran niños y los tocaban por el barrio, y lo que empezó ahí terminó siendo una orquesta.

**Los Hermanos Rosario**

El grupo era Los Hermanos Rosario. Cantaban Pepe, Toño y Rafa Rosario; Luis, Tony y Francis completaban el resto. Pepe murió en marzo de 1983, y Toño y Rafa sostuvieron la orquesta al frente, llevándola por la década en que se convirtió en una de las bandas de merengue más grandes del país y de fuera.

**Coliseo Roberto Clemente**

Dejó la agrupación familiar para montar orquesta propia y debutó como solista el 14 de abril de 1990 en el Coliseo Roberto Clemente de San Juan, Puerto Rico. Los discos vinieron rápido detrás: Y Más… ese mismo año, Atado a Ti en 1991, Retorno a las Raíces en 1992, Amor Jollao en 1993, Me Olvidé de Vivir en 1994 y Quiero Volver a Empezar en 1995.

Seguiré salió en 1997, Exclusivo en 1998, La Magia del Cuco en 1999 —titulado por como lo llama todo el mundo— y Yo Soy Toño en 2000. Siguió publicando a lo largo de los dos mil con Toño en América, Resistiré y A Tu Gusto.

**Kulikitaka**

Las canciones que le devuelve cantadas la gente atraviesan todo eso: La Gozadera, que numeró y siguió rehaciendo; Kulikitaka; Bárbara; Víbora del Mar; Jenny; La Última Copa; Me Olvidé de Vivir; Alegría; Quiero Volver a Empezar; Desnúdate, Mujer; y Ábreme la Puerta.

Ha grabado además cruzando las fronteras del género. Traigo la Bomba, de 1992, lo hizo con el rapero puertorriqueño Vico C cuando el merengue y el rap todavía no tenían la costumbre de compartir disco, y en 2002 hizo el álbum Juntos con Wilfrido Vargas.

**Las salas**

Los escenarios son la medida de la carrera solista. Ha llenado el United Palace de Nueva York, Altos de Chavón en el país, la Plaza de Toros de Madrid y el Estadio Centenario de Cuernavaca, y se ha presentado en el Madison Square Garden.

Sigue trabajando. Su propio canal anuncia fechas de finales de 2026 en Nueva Jersey, en el United Palace y en Massachusetts, lo que pone la carrera de tarima por encima de los cincuenta años contando desde la orquesta familiar.',
       updated_at = now()
 WHERE slug = 'tono-rosario';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tono-rosario')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tono-rosario')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Máximo Antonio del Rosario Almonte, known as Toño Rosario and called El Cuco, is a Dominican merengue singer. He came out of his own family’s orchestra and built the largest solo merengue career of the nineties on top of it, and he is still touring.","type":"text"}]},{"type":"paragraph","content":[{"text":"Higüey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1955 in Higüey, the seat of La Altagracia province in the east of the country. He and his brothers were making instruments out of bottle caps and plastic containers as children and playing them in the neighbourhood, and what began there became a band.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Hermanos Rosario","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The group was ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario","occurrenceId":"783ddab7-afa5-4cf7-a40c-1f3669fdc1da"}},{"text":". Pepe, Toño and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fb033f0-4f8b-4101-a67d-1d445f316dc4","displayText":"Rafa Rosario","occurrenceId":"dbb28dec-372c-4457-a21f-ce527644aaf8"}},{"text":" sang; Luis, Tony and Francis made up the rest. Pepe died in March 1983, and Toño and Rafa kept the orchestra in front, taking it through the decade in which it became one of the biggest merengue bands in the country and outside it.","type":"text"}]},{"type":"paragraph","content":[{"text":"Coliseo Roberto Clemente","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He left the family band to form his own orchestra and made his solo debut on 14 April 1990 at the Coliseo Roberto Clemente in San Juan, Puerto Rico. The records came fast after that: Y Más… that same year, Atado a Ti in 1991, Retorno a las Raíces in 1992, Amor Jollao in 1993, Me Olvidé de Vivir in 1994 and Quiero Volver a Empezar in 1995.","type":"text"}]},{"type":"paragraph","content":[{"text":"Seguiré followed in 1997, Exclusivo in 1998, La Magia del Cuco in 1999 — named for what everyone calls him — and Yo Soy Toño in 2000. He kept releasing through the two thousands with Toño en América, Resistiré and A Tu Gusto.","type":"text"}]},{"type":"paragraph","content":[{"text":"Kulikitaka","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The songs people sing back to him run across all of it: La Gozadera, which he numbered and kept remaking; Kulikitaka; Bárbara; Víbora del Mar; Jenny; La Última Copa; Me Olvidé de Vivir; Alegría; Quiero Volver a Empezar; Desnúdate, Mujer; and Ábreme la Puerta.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has also recorded across the genre’s borders. Traigo la Bomba, in 1992, was made with the Puerto Rican rapper Vico C at a point when merengue and rap were not yet in the habit of sharing a record, and in 2002 he made the album Juntos with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"d45d634c-6929-4087-b5f2-623466272ce6"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"The rooms","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The venues are the measure of the solo career. He has filled the United Palace in New York, Altos de Chavón at home, the Plaza de Toros in Madrid and the Estadio Centenario in Cuernavaca, and he has played Madison Square Garden.","type":"text"}]},{"type":"paragraph","content":[{"text":"He is still working. His own channel lists dates for late 2026 in New Jersey, at the United Palace and in Massachusetts, which puts the touring career past fifty years counting from the family band.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'tono-rosario'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Máximo Antonio del Rosario Almonte, conocido como Toño Rosario y llamado El Cuco, es un cantante de merengue dominicano. Salió de la orquesta de su propia familia y levantó encima la carrera solista de merengue más grande de los noventa, y sigue de gira.","type":"text"}]},{"type":"paragraph","content":[{"text":"Higüey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1955 en Higüey, cabecera de la provincia La Altagracia, al este del país. Él y sus hermanos hacían instrumentos con tapas de botella y envases de plástico cuando eran niños y los tocaban por el barrio, y lo que empezó ahí terminó siendo una orquesta.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Hermanos Rosario","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El grupo era ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario","occurrenceId":"f0dcab7c-e08b-4ee0-b5a0-a6ca5fbd61f4"}},{"text":". Cantaban Pepe, Toño y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fb033f0-4f8b-4101-a67d-1d445f316dc4","displayText":"Rafa Rosario","occurrenceId":"8eb191ef-0dac-4d0b-abc1-1305e1a5824d"}},{"text":"; Luis, Tony y Francis completaban el resto. Pepe murió en marzo de 1983, y Toño y Rafa sostuvieron la orquesta al frente, llevándola por la década en que se convirtió en una de las bandas de merengue más grandes del país y de fuera.","type":"text"}]},{"type":"paragraph","content":[{"text":"Coliseo Roberto Clemente","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Dejó la agrupación familiar para montar orquesta propia y debutó como solista el 14 de abril de 1990 en el Coliseo Roberto Clemente de San Juan, Puerto Rico. Los discos vinieron rápido detrás: Y Más… ese mismo año, Atado a Ti en 1991, Retorno a las Raíces en 1992, Amor Jollao en 1993, Me Olvidé de Vivir en 1994 y Quiero Volver a Empezar en 1995.","type":"text"}]},{"type":"paragraph","content":[{"text":"Seguiré salió en 1997, Exclusivo en 1998, La Magia del Cuco en 1999 —titulado por como lo llama todo el mundo— y Yo Soy Toño en 2000. Siguió publicando a lo largo de los dos mil con Toño en América, Resistiré y A Tu Gusto.","type":"text"}]},{"type":"paragraph","content":[{"text":"Kulikitaka","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Las canciones que le devuelve cantadas la gente atraviesan todo eso: La Gozadera, que numeró y siguió rehaciendo; Kulikitaka; Bárbara; Víbora del Mar; Jenny; La Última Copa; Me Olvidé de Vivir; Alegría; Quiero Volver a Empezar; Desnúdate, Mujer; y Ábreme la Puerta.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ha grabado además cruzando las fronteras del género. Traigo la Bomba, de 1992, lo hizo con el rapero puertorriqueño Vico C cuando el merengue y el rap todavía no tenían la costumbre de compartir disco, y en 2002 hizo el álbum Juntos con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"0945b689-4a0a-4e62-89b8-a1ebdbcb21b2"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Las salas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Los escenarios son la medida de la carrera solista. Ha llenado el United Palace de Nueva York, Altos de Chavón en el país, la Plaza de Toros de Madrid y el Estadio Centenario de Cuernavaca, y se ha presentado en el Madison Square Garden.","type":"text"}]},{"type":"paragraph","content":[{"text":"Sigue trabajando. Su propio canal anuncia fechas de finales de 2026 en Nueva Jersey, en el United Palace y en Massachusetts, lo que pone la carrera de tarima por encima de los cincuenta años contando desde la orquesta familiar.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'tono-rosario'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tono-rosario') AND locale = 'en'), '783ddab7-afa5-4cf7-a40c-1f3669fdc1da', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tono-rosario') AND locale = 'en'), 'd45d634c-6929-4087-b5f2-623466272ce6', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tono-rosario') AND locale = 'en'), 'dbb28dec-372c-4457-a21f-ce527644aaf8', 'artist', '6fb033f0-4f8b-4101-a67d-1d445f316dc4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tono-rosario') AND locale = 'es'), '0945b689-4a0a-4e62-89b8-a1ebdbcb21b2', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tono-rosario') AND locale = 'es'), '8eb191ef-0dac-4d0b-abc1-1305e1a5824d', 'artist', '6fb033f0-4f8b-4101-a67d-1d445f316dc4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tono-rosario') AND locale = 'es'), 'f0dcab7c-e08b-4ee0-b5a0-a6ca5fbd61f4', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4');

COMMIT;
