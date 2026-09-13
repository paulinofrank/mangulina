BEGIN;

-- Rewrite the catalogue entry for Elvis Martínez.
--
-- Elvis Martinez. VIGESIMOCUARTA de las 211. 1.262 caracteres, tres parrafos, y
-- la formula de siempre: "a string of hits that resonated with audiences", "his
-- voice -- expressive, versatile, and capable of conveying both heartbreak and
-- joy". Ni una cancion, ni un disco, ni un ano, ni un colaborador.
--
-- ---------------------------------------------------------------------------
-- PRIMERO, UNA TRAMPA DE BUSQUEDA QUE CASI ME CUESTA LA FICHA
--
-- "Elvis Martinez" en Wikipedia en espanol es UN FUTBOLISTA VENEZOLANO. El
-- bachatero esta en "Elvis Martinez (cantante)". Lo resolvio el `wikidata_id`
-- que la fila ya guardaba, Q5368204, que lleva al bueno; el futbolista es
-- Q1458410.
--
-- Es la nota de memoria sobre nombres artisticos que chocan, y esta vez la fila
-- traia el desempate dentro.
-- ---------------------------------------------------------------------------
--
-- CORRIJO UN ERROR DE LA WIKIPEDIA, Y ES DE LOS QUE IMPORTAN.
--
-- Su tabla de premios le atribuye CUATRO estatuillas en los Soberano de 2021:
-- Colaboracion del Ano, Bachatero del Ano, Concierto del Ano y Bachata del Ano
-- por "El placer del sexo".
--
-- LA LISTA DE GANADORES DE ESA GALA DICE OTRA COSA. El Dia, 16 de junio de
-- 2021, escribe expresamente "Elvis Martinez quien se alzo con DOS
-- estatuillas", y en el listado por renglones:
--
--   Colaboracion del ano 2019: "Millonario", Romeo Santos y Elvis Martinez  SI
--   Bachatero del ano: Elvis Martinez                                       SI
--   Concierto streaming del ano: "El Torito Mundial", HECTOR ACOSTA         NO
--   Bachata del ano 2019: "El beso que no le di", ROMEO SANTOS ft. KIKO     NO
--
-- Registro las dos que la prensa confirma y descarto las otras dos. La ficha
-- tampoco las menciona.
--
-- LOS ALIAS: la fila guardaba 'El Camaron', SIN TILDE. Se corrige a 'El
-- Camaron' con tilde en la o.
--
-- EL SEGUNDO APELLIDO FALTABA: se llama ELVIS MARTINEZ GONZALEZ.
--
-- CONFLICTO DE FECHA DENTRO DE LA MISMA FUENTE, que no resuelvo a favor de la
-- nueva: el infobox de Wikipedia da el 5 DE ENERO de 1976 -- igual que la fila y
-- que Wikidata con referencia -- y la primera linea del cuerpo dice "15 de marzo
-- del 1976". Es una contradiccion interna del articulo. La fila se queda.
--
-- LO QUE FALTABA, QUE ES TODO:
--
--   DE NINO TRABAJO DE LIMPIABOTAS Y DE AYUDANTE DE PANADERIA para aportar en
--   casa, y eso le impidio terminar la escuela. Historia laboral: entra, mismo
--   criterio que Joe Veras y El Chaval.
--
--   SE MUDO A NUEVA YORK a principios de los noventa, y ALLI LENNY SANTOS -- del
--   grupo que poco despues seria AVENTURA -- LE ENSENO A TOCAR GUITARRA. Ese es
--   el dato de formacion que explica el resto.
--
--   FIRMO CON PREMIUM LATIN MUSIC y debuto con "TODO SE PAGA" (1998), PRODUCIDO
--   POR LENNY SANTOS, con "Asi Fue" y "Me Seguiras Buscando". Le dio un PREMIO
--   ACE de Nueva York como revelacion del ano.
--
--   "DIRECTO AL CORAZON" (1999), "Tres Palabras" (2002), "ASI TE AMO" (2003) y
--   "Descontrolado" (2004).
--
--   "ASI TE AMO" GANO EL CASANDRA DE 2004. La compuso WASON BRAZOBAN, que esta
--   en el catalogo, y forma parte de la banda sonora de la pelicula "Que Leon".
--
--   PASO POR TRES SELLOS MAS: Univision Records, donde saco "YO SOY MAS GRANDE
--   QUE EL" (2005), SU DISCO MAS VENDIDO, con "Tu Traicion" y "Yo No Naci Para
--   Amar"; Universal, con "La Luz de Mis Ojos" (2007) y "Lento y Suave"; y de
--   vuelta a Premium con "Esperanza" (2012).
--
--   "MILLONARIO", en el "Utopia" de Romeo Santos (2019), TAMBIEN PRODUCIDA POR
--   LENNY SANTOS. Es la que le dio el Soberano a la colaboracion del ano.
--
--   "VETERANA" con PRINCE ROYCE (marzo de 2021).
--
--   "SACO E' SAL", bachata del ano en los Soberano de 2023, Y LA COMPUSO EL.
--
-- DISCREPANCIA DE NOMBRE DE CATEGORIA que anoto: Wikipedia llama al Casandra de
-- 2004 "Mejor Cancion del Ano" y el palmares de Bachata Republic lo registra
-- como "Bachata del Ano", que es la categoria que el catalogo tiene y la que
-- uso.
--
-- LO QUE SE DEJA FUERA: los nombres de sus padres, que crecio con doce hermanos
-- y, sobre todo, LA MUERTE DE UNO DE SUS HERMANOS en unos disturbios de 2011.
-- Es una muerte violenta de un familiar: vida privada y asunto penal a la vez.
--
-- occupations SE AFINA: 'musician' es vago y las fuentes coinciden en que toca
-- GUITARRA. instruments se llena con voz y guitarra.
--
-- LAS TRES REDES DE LA FILA RESPONDEN.
--
-- CUATRO ENLACES: Wason Brazoban por la composicion, Prince Royce y Luis Segura
-- por credito de dueto -- canta "Cuando Estoy Contigo" en el Anonado IV, disco
-- que describi entero hace dos dias --, y Frank Reyes por el palmares que
-- comparten.
--
-- FUENTES: Wikipedia en espanol, articulo del cantante, referenciada a AllMusic,
-- Billboard, Diario Libre y Listin Diario. **El Dia, 16 de junio de 2021**,
-- listado de ganadores, que es la que desmiente a la propia Wikipedia. Diario
-- Libre, Listin Diario y Acento, 22-23 de marzo de 2023, para la gala siguiente.
--
-- AUSENCIAS NUEVAS: LENNY SANTOS, guitarrista y productor, que le enseno a tocar
-- y le produjo el disco de debut y "Millonario" veinte anos despues -- es de los
-- nombres mas importantes que faltan --; AVENTURA, otra vez; y PREMIUM LATIN
-- MUSIC como sello.
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
       name = 'Elvis Martínez',
       sort_name = 'Martínez, Elvis',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1976-01-05',
       birth_year = 1976,
       date_of_death = NULL,
       birth_place = 'San Francisco de Macorís',
       province = 'Duarte',
       first_name = 'Elvis',
       middle_name = NULL,
       last_name = 'Martínez',
       second_last_name = 'González',
       stage_name = 'Elvis Martínez',
       aliases = ARRAY['El Camarón']::text[],
       occupations = '["composer","guitarist"]'::jsonb,
       instruments = ARRAY['voice', 'guitar']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@elvismartinez',
       facebook = 'elvismartinezeljefe',
       instagram = 'elvismartinezeljefe',
       disambiguation = 'Bachata singer billed as El Camarón; learned guitar in New York from Lenny Santos',
       bio_en = 'Elvis Martínez González, billed as El Camarón, is a Dominican bachata singer, composer and guitarist from San Francisco de Macorís. He has recorded since 1998 across four labels, and his songs have twice been named bachata of the year at the Dominican awards.

**Shoeshine and bakery**

He was born in 1976 in San Francisco de Macorís. As a boy he worked shining shoes and then as a bakery assistant, among other jobs he took to bring money home, and the work kept him from finishing school.

He moved to New York in the early nineties, and it was there that he learned his instrument: Lenny Santos, of the group that would shortly become Aventura, taught him to play the guitar.

**Todo Se Paga**

He signed with Premium Latin Music in the mid-nineties and released his first album, Todo Se Paga, in 1998, with Lenny Santos producing. Así Fue and Me Seguirás Buscando came off it, and the record won him a Premio ACE in New York as revelation of the year.

Directo Al Corazón followed in 1999, carrying Bailando Con Él, Tú Sabes Bien and the title track. Tres Palabras, Así Te Amo and Descontrolado came out on the same label over the next five years.

**Así Te Amo**

The title song of the 2003 album took the Casandra award for bachata of the year in 2004. It was written by Wason Brazobán, and it later turned up on the soundtrack of the film Qué León. The same year he was nominated at the Premio Lo Nuestro awards as traditional tropical artist.

He then moved through labels. Univision Records released Yo Soy Más Grande Que Él in 2005, which remains his best-selling album and produced Tu Traición and Yo No Nací Para Amar. Universal followed with La Luz de Mis Ojos in 2007, and Lento y Suave off it. He returned to Premium for Esperanza in 2012.

**Millonario**

In 2019 he sang Millonario on Romeo Santos’s album Utopía, with Lenny Santos producing again, twenty years after the debut. The record won collaboration of the year at the Premios Soberano in 2021, the same night he was named bachata singer of the year — the category Frank Reyes has taken more often than anyone.

In March 2021 he released Veterana with Prince Royce. He also sings Cuando Estoy Contigo on the four-volume record with which Luis Segura closed his career.

**Saco e’ sal**

At the Premios Soberano held in March 2023, which covered two years at once, Saco e’ sal took bachata of the year and he was again named bachata singer of the year. He wrote Saco e’ sal himself, which is not the rule in a genre where the best-known singers often record other people’s material.',
       bio_es = 'Elvis Martínez González, anunciado como El Camarón, es un cantante, compositor y guitarrista dominicano de bachata, de San Francisco de Macorís. Graba desde 1998 y ha pasado por cuatro sellos, y dos de sus canciones han sido bachata del año en los premios dominicanos.

**Limpiabotas y panadería**

Nació en 1976 en San Francisco de Macorís. De niño trabajó de limpiabotas y después de ayudante de panadería, entre otros trabajos que tomó para aportar en casa, y eso le impidió terminar la escuela.

Se mudó a Nueva York a principios de los noventa, y fue allí donde aprendió su instrumento: Lenny Santos, del grupo que poco después sería Aventura, le enseñó a tocar guitarra.

**Todo Se Paga**

Firmó con Premium Latin Music a mediados de los noventa y publicó su primer disco, Todo Se Paga, en 1998, con Lenny Santos en la producción. De ahí salieron Así Fue y Me Seguirás Buscando, y el disco le valió un Premio ACE de Nueva York como revelación del año.

Directo Al Corazón llegó en 1999, con Bailando Con Él, Tú Sabes Bien y el tema que le da título. Tres Palabras, Así Te Amo y Descontrolado salieron con el mismo sello en los cinco años siguientes.

**Así Te Amo**

La canción que da título al disco de 2003 se llevó el Casandra a la bachata del año en 2004. La compuso Wason Brazobán, y más adelante apareció en la banda sonora de la película Qué León. Ese mismo año fue nominado en los Premio Lo Nuestro como artista tropical tradicional.

Después fue cambiando de sello. Univision Records publicó Yo Soy Más Grande Que Él en 2005, que sigue siendo su disco más vendido y del que salieron Tu Traición y Yo No Nací Para Amar. Universal siguió con La Luz de Mis Ojos, de 2007, y con Lento y Suave. Volvió a Premium para Esperanza, en 2012.

**Millonario**

En 2019 cantó Millonario en el disco Utopía de Romeo Santos, otra vez con Lenny Santos produciendo, veinte años después del debut. El tema ganó la colaboración del año en los Premios Soberano de 2021, la misma noche en que fue nombrado bachatero del año, categoría que Frank Reyes ha ganado más veces que nadie.

En marzo de 2021 publicó Veterana con Prince Royce. Canta además Cuando Estoy Contigo en el disco de cuatro volúmenes con el que Luis Segura cerró su carrera.

**Saco e’ sal**

En los Premios Soberano de marzo de 2023, que premiaron dos años a la vez, Saco e’ sal se llevó la bachata del año y él volvió a ser nombrado bachatero del año. Saco e’ sal la escribió él mismo, cosa que no es la norma en un género donde los cantantes más conocidos suelen grabar material ajeno.',
       updated_at = now()
 WHERE slug = 'elvis-martinez';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'elvis-martinez')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'elvis-martinez')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Elvis Martínez González, billed as El Camarón, is a Dominican bachata singer, composer and guitarist from San Francisco de Macorís. He has recorded since 1998 across four labels, and his songs have twice been named bachata of the year at the Dominican awards.","type":"text"}]},{"type":"paragraph","content":[{"text":"Shoeshine and bakery","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1976 in San Francisco de Macorís. As a boy he worked shining shoes and then as a bakery assistant, among other jobs he took to bring money home, and the work kept him from finishing school.","type":"text"}]},{"type":"paragraph","content":[{"text":"He moved to New York in the early nineties, and it was there that he learned his instrument: Lenny Santos, of the group that would shortly become Aventura, taught him to play the guitar.","type":"text"}]},{"type":"paragraph","content":[{"text":"Todo Se Paga","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He signed with Premium Latin Music in the mid-nineties and released his first album, Todo Se Paga, in 1998, with Lenny Santos producing. Así Fue and Me Seguirás Buscando came off it, and the record won him a Premio ACE in New York as revelation of the year.","type":"text"}]},{"type":"paragraph","content":[{"text":"Directo Al Corazón followed in 1999, carrying Bailando Con Él, Tú Sabes Bien and the title track. Tres Palabras, Así Te Amo and Descontrolado came out on the same label over the next five years.","type":"text"}]},{"type":"paragraph","content":[{"text":"Así Te Amo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The title song of the 2003 album took the Casandra award for bachata of the year in 2004. It was written by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7b9ee34b-4438-4032-b827-0b748086e223","displayText":"Wason Brazobán","occurrenceId":"4452ea07-39bc-4bac-9add-6195d84c2372"}},{"text":", and it later turned up on the soundtrack of the film Qué León. The same year he was nominated at the Premio Lo Nuestro awards as traditional tropical artist.","type":"text"}]},{"type":"paragraph","content":[{"text":"He then moved through labels. Univision Records released Yo Soy Más Grande Que Él in 2005, which remains his best-selling album and produced Tu Traición and Yo No Nací Para Amar. Universal followed with La Luz de Mis Ojos in 2007, and Lento y Suave off it. He returned to Premium for Esperanza in 2012.","type":"text"}]},{"type":"paragraph","content":[{"text":"Millonario","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2019 he sang Millonario on Romeo Santos’s album Utopía, with Lenny Santos producing again, twenty years after the debut. The record won collaboration of the year at the Premios Soberano in 2021, the same night he was named bachata singer of the year — the category ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes","occurrenceId":"b0c4ab0b-187b-4225-9fed-7bcd664c3c27"}},{"text":" has taken more often than anyone.","type":"text"}]},{"type":"paragraph","content":[{"text":"In March 2021 he released Veterana with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce","occurrenceId":"d164fc40-379a-4130-9903-391a9f7a4e42"}},{"text":". He also sings Cuando Estoy Contigo on the four-volume record with which ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"5f4f1a7a-fb4b-4a7d-9065-363a8bebe7c2"}},{"text":" closed his career.","type":"text"}]},{"type":"paragraph","content":[{"text":"Saco e’ sal","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"At the Premios Soberano held in March 2023, which covered two years at once, Saco e’ sal took bachata of the year and he was again named bachata singer of the year. He wrote Saco e’ sal himself, which is not the rule in a genre where the best-known singers often record other people’s material.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'elvis-martinez'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Elvis Martínez González, anunciado como El Camarón, es un cantante, compositor y guitarrista dominicano de bachata, de San Francisco de Macorís. Graba desde 1998 y ha pasado por cuatro sellos, y dos de sus canciones han sido bachata del año en los premios dominicanos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Limpiabotas y panadería","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1976 en San Francisco de Macorís. De niño trabajó de limpiabotas y después de ayudante de panadería, entre otros trabajos que tomó para aportar en casa, y eso le impidió terminar la escuela.","type":"text"}]},{"type":"paragraph","content":[{"text":"Se mudó a Nueva York a principios de los noventa, y fue allí donde aprendió su instrumento: Lenny Santos, del grupo que poco después sería Aventura, le enseñó a tocar guitarra.","type":"text"}]},{"type":"paragraph","content":[{"text":"Todo Se Paga","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Firmó con Premium Latin Music a mediados de los noventa y publicó su primer disco, Todo Se Paga, en 1998, con Lenny Santos en la producción. De ahí salieron Así Fue y Me Seguirás Buscando, y el disco le valió un Premio ACE de Nueva York como revelación del año.","type":"text"}]},{"type":"paragraph","content":[{"text":"Directo Al Corazón llegó en 1999, con Bailando Con Él, Tú Sabes Bien y el tema que le da título. Tres Palabras, Así Te Amo y Descontrolado salieron con el mismo sello en los cinco años siguientes.","type":"text"}]},{"type":"paragraph","content":[{"text":"Así Te Amo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La canción que da título al disco de 2003 se llevó el Casandra a la bachata del año en 2004. La compuso ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7b9ee34b-4438-4032-b827-0b748086e223","displayText":"Wason Brazobán","occurrenceId":"f13fa8ec-4feb-44c0-85d7-ff3b4edadd81"}},{"text":", y más adelante apareció en la banda sonora de la película Qué León. Ese mismo año fue nominado en los Premio Lo Nuestro como artista tropical tradicional.","type":"text"}]},{"type":"paragraph","content":[{"text":"Después fue cambiando de sello. Univision Records publicó Yo Soy Más Grande Que Él en 2005, que sigue siendo su disco más vendido y del que salieron Tu Traición y Yo No Nací Para Amar. Universal siguió con La Luz de Mis Ojos, de 2007, y con Lento y Suave. Volvió a Premium para Esperanza, en 2012.","type":"text"}]},{"type":"paragraph","content":[{"text":"Millonario","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2019 cantó Millonario en el disco Utopía de Romeo Santos, otra vez con Lenny Santos produciendo, veinte años después del debut. El tema ganó la colaboración del año en los Premios Soberano de 2021, la misma noche en que fue nombrado bachatero del año, categoría que ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes","occurrenceId":"db9a9cc0-e0fa-4a60-8f6c-baf8c5dbb5e7"}},{"text":" ha ganado más veces que nadie.","type":"text"}]},{"type":"paragraph","content":[{"text":"En marzo de 2021 publicó Veterana con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce","occurrenceId":"bae8a6f8-d822-49db-9d36-278d9745708a"}},{"text":". Canta además Cuando Estoy Contigo en el disco de cuatro volúmenes con el que ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"e9d6adeb-2e54-4d4f-a52b-dc210ac4c58a"}},{"text":" cerró su carrera.","type":"text"}]},{"type":"paragraph","content":[{"text":"Saco e’ sal","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En los Premios Soberano de marzo de 2023, que premiaron dos años a la vez, Saco e’ sal se llevó la bachata del año y él volvió a ser nombrado bachatero del año. Saco e’ sal la escribió él mismo, cosa que no es la norma en un género donde los cantantes más conocidos suelen grabar material ajeno.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'elvis-martinez'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'elvis-martinez') AND locale = 'en'), '4452ea07-39bc-4bac-9add-6195d84c2372', 'artist', '7b9ee34b-4438-4032-b827-0b748086e223');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'elvis-martinez') AND locale = 'en'), '5f4f1a7a-fb4b-4a7d-9065-363a8bebe7c2', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'elvis-martinez') AND locale = 'en'), 'b0c4ab0b-187b-4225-9fed-7bcd664c3c27', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'elvis-martinez') AND locale = 'en'), 'd164fc40-379a-4130-9903-391a9f7a4e42', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'elvis-martinez') AND locale = 'es'), 'bae8a6f8-d822-49db-9d36-278d9745708a', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'elvis-martinez') AND locale = 'es'), 'db9a9cc0-e0fa-4a60-8f6c-baf8c5dbb5e7', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'elvis-martinez') AND locale = 'es'), 'e9d6adeb-2e54-4d4f-a52b-dc210ac4c58a', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'elvis-martinez') AND locale = 'es'), 'f13fa8ec-4feb-44c0-85d7-ff3b4edadd81', 'artist', '7b9ee34b-4438-4032-b827-0b748086e223');

COMMIT;
