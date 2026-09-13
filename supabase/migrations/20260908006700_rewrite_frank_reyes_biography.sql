BEGIN;

-- Rewrite the catalogue entry for Frank Reyes.
--
-- Frank Reyes. DECIMOTERCERA de las 211, con 12 enlaces entrantes. La ficha
-- vieja tenía 1.367 caracteres, tres párrafos y NI UNA CANCIÓN, NI UN DISCO, NI
-- UN AÑO que no fuera el de nacimiento.
--
-- Decía "tender and passionate, intimate and commanding", "his ability to
-- inhabit a song emotionally", "Frank Reyes represents the heart of bachata --
-- the vulnerability, the longing, the capacity for deep feeling". Cuatro
-- párrafos de adjetivos sobre un hombre que tiene SIETE Bachatero del Año.
--
-- ---------------------------------------------------------------------------
-- EL DATO QUE FALTABA ES EL QUE LO DEFINE: ES EL ARTISTA MÁS PREMIADO DE LA
-- HISTORIA DE SU PROPIA CATEGORÍA.
--
-- Siete Bachatero del Año -- 1999, 2002, 2003, 2005, 2015, 2017 y 2018 --, por
-- delante de Zacarías Ferreira (6), Antony Santos (5), Raulín Rodríguez (3),
-- Joe Veras (2) y de una estatuilla cada uno para Teodoro Reyes, Luis Miguel
-- del Amargue y Elvis Martínez. Más dos Bachata del Año en 2005 y 2007, y un
-- tercero en 2026. DIEZ ADJUDICACIONES, y la ficha no tenía ninguna.
-- ---------------------------------------------------------------------------
--
-- CONFLICTO DE FECHA DE NACIMIENTO QUE NO RESUELVO A FAVOR DE LA NUEVA FUENTE.
-- La fila y Wikipedia dan el 4 DE JUNIO de 1969; BuenaMusica da el 31 DE
-- DICIEMBRE de 1969. Mismo año, distinto día. NO TOCO LA FILA: Wikipedia lleva
-- referencia y la fila ya lo guardaba, y la nota de BuenaMusica del archivo de
-- memoria dice expresamente que sus fechas hay que verificarlas en otro sitio.
-- El texto no da el día, solo el año.
--
-- NO CAMBIO sort_name, y lo escribo porque estuve a punto. Su apellido legal es
-- LÓPEZ y "Reyes" es el materno, así que por la convención que vengo usando
-- tocaría 'López Reyes, Francisco'. PERO sus contemporáneos directos están
-- ordenados por el nombre artístico aunque el apellido legal sea otro: 'Santos,
-- Antony' (Domingo Santos), 'Vargas, Luis' (Valdez), 'Rodríguez, Raulín'
-- (Marte), 'Rodríguez, Kiko' (Henríquez). Moverlo lo sacaría del sitio donde
-- está toda su generación, y 'Reyes, Frank' no es un error. Se queda.
--
-- LOS ALIAS SE LIMPIAN. La fila guardaba:
--   'El Principe de la Bachata'  -> SIN TILDE. Se corrige a 'El Príncipe'.
--   'Francisco Lopez Reyes'      -> el nombre legal sin acentos y duplicando
--                                   first_name/last_name/second_last_name, que
--                                   es el patrón de 157 filas ya documentado.
--                                   Sale.
-- Y se añade 'El Príncipe del Amargue', su otro sobrenombre, que no estaba.
--
-- LO QUE FALTABA, QUE ES LA CARRERA ENTERA:
--
--   "TÚ SERÁS MI REINA" (1991), su primer disco, y una producción casi anual a
--   lo largo de los noventa.
--
--   "NADA DE NADA" (2002), con la que sale del país. Un año antes las cadenas
--   de radio y televisión dominicanas ya lo habían nombrado bachatero del año.
--
--   "NOCHE DE PASIÓN" (agosto de 2014): VEINTIDÓS SEMANAS en el Top Latin Songs
--   de Monitor Latino en la República Dominicana, con tercer puesto máximo.
--
--   "PAYASOS", en el disco "Utopía" de Romeo Santos (2019), donde también están
--   Luis Vargas, Joe Veras, Monchy & Alexandra y Raulín Rodríguez.
--
--   "DECIDÍ" (2020), letra de DANIEL MONCIÓN, que ya enlazaba hacia él.
--
--   "POR ÚLTIMA VEZ" (2021), a dúo con EDDY HERRERA. Es un merenguero grabando
--   bachata, y Listín Diario lo trató como el ejemplo reciente de ese cruce.
--
--   "QUIÉN TE DIO EL DERECHO", Bachata del Año en los Soberano de 2026,
--   compuesta por ÁNGELA MILAGROS SANTOS. No es suya la letra y así se dice.
--
-- NO SE ESCRIBEN LAS REPRODUCCIONES ni las ventas en unidades. SÍ ENTRAN las
-- semanas y el puesto en Monitor Latino, que son posiciones de lista.
--
-- LO QUE SE DEJA FUERA: su matrimonio de 2018, sus cinco hijos y sus nombres,
-- que BuenaMusica publica con detalle. Vida privada.
--
-- SU CANAL, INSTAGRAM Y FACEBOOK YA ESTABAN EN LA FILA y los tres son
-- '@FrankReyes809'. Comprobados: los tres responden. No había nada que
-- corregir, que es la primera vez en varias fichas.
--
-- TRECE ENLACES, todos por crédito o por la tabla de premios: los siete
-- bachateros con los que comparte el palmarés de Bachatero del Año, los cuatro
-- de "Utopía", Daniel Monción, Eddy Herrera y Don Miguelo -- en cuyo primer
-- disco, "Contra el Tiempo", él trabajó, enlace que puse ayer en la ficha de
-- Don Miguelo y que ahora es mutuo.
--
-- ROMEO SANTOS SE NOMBRA SIN ENLACE. Sigue sin ficha; es la quinta vez esta
-- semana.
--
-- FUENTES: Wikipedia en español. BuenaMusica, para la discografía y el sello,
-- con la fecha de nacimiento descartada. Bachata Republic (Luis Becker Cabrera,
-- 15 y 20 de julio de 2021), que publica los palmarés completos de Bachatero
-- del Año y Bachata del Año con referencias a ACROARTE, Listín Diario, Diario
-- Libre, Hoy y El Día -- es la fuente de las diez adjudicaciones. El Nuevo
-- Diario, Listín Diario y Conectate (18-20 de marzo de 2026) para el Soberano
-- de 2026. Diario Libre (25 de julio de 2021) y Listín Diario (23 de febrero de
-- 2022) para el dúo con Eddy Herrera.
--
-- DE PASO: las referencias de Bachata Republic CONFIRMAN CON PRENSA FECHADA dos
-- de los conflictos de PREMIOS_GRAN_SOBERANO.md -- Hoy del 22 de febrero de
-- 2005 titula "Frank Reyes, máximo ganador / Carlos Piantini recibe El
-- Soberano", y Hoy del 22 de marzo de 2006 titula "Rafael Solano gana El
-- Soberano". Anotado allí.
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
       name = 'Frank Reyes',
       sort_name = 'Reyes, Frank',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1969-06-04',
       birth_year = 1969,
       date_of_death = NULL,
       birth_place = 'Tenares',
       province = 'Hermanas Mirabal',
       first_name = 'Francisco',
       middle_name = NULL,
       last_name = 'López',
       second_last_name = 'Reyes',
       stage_name = 'Frank Reyes',
       aliases = ARRAY['El Príncipe de la Bachata', 'El Príncipe del Amargue']::text[],
       occupations = '["composer"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@FrankReyes809',
       facebook = 'FrankReyes809',
       instagram = 'FrankReyes809',
       disambiguation = 'Bachata singer billed as El Príncipe de la Bachata; record holder for Bachatero del Año',
       bio_en = 'Francisco López Reyes, who records as Frank Reyes, is a Dominican bachata singer and composer from Tenares. Billed as El Príncipe de la Bachata, he has won the Dominican award for bachata singer of the year seven times, more than any other performer in the history of the category.

**Tenares to the capital**

He was born in 1969 in Tenares, in the province of Hermanas Mirabal, and began singing as a boy in a group he put together with his brothers. At twelve he moved to Santo Domingo and took whatever work came while he looked for a way into music.

**Tú Serás Mi Reina**

His first album, Tú Serás Mi Reina, came out in 1991 and got him heard in the Dominican press. Through the rest of the decade he released almost one record a year — Si El Amor Condena, Estoy Condenado, Bachata Con Categoría, Regresó Mi Amor Bonito, El Antojito, El Príncipe, Vine A Decirte Adiós and Extraño Mi Pueblo. Vine A Decirte Adiós brought him his first award as bachata singer of the year, in 1999.

**Nada de Nada**

In 2001 the Dominican radio and television networks named him bachata artist of the year. The following year Nada de Nada took him outside the country: it worked across Latin America and among Spanish-speaking audiences in the United States and Europe, and it remains the record most people name first. He also turned up on the compilation Reggae Bachata 2003, where the song was reworked as a reggaetón remix with Zurdo.

**Seven statuettes**

He won bachata singer of the year in 1999, 2002, 2003 and 2005 under the Casandra awards, and again in 2015, 2017 and 2018 under the Soberano. The seven put him ahead of everyone else who has held the category: Zacarías Ferreira has six, Antony Santos five, Raulín Rodríguez three, Joe Veras two, and Teodoro Reyes, Luis Miguel del Amargue and Elvis Martínez one each.

He has also taken bachata of the year, the award for the song rather than the singer, three times: in 2005 for Quién eres tú, in 2007 for Princesa, written by Rafael Martín Céspedes, and again in 2026.

**Noche de Pasión**

Noche de Pasión, released in August 2014, spent twenty-two weeks on Monitor Latino’s Dominican Top Latin Songs chart and reached number three. Cómo Sanar followed in 2015 and Veneno in 2018, both of them near the top of the Dominican lists.

**Across the genre**

He sang Payasos on Utopía, the 2019 album on which Romeo Santos recorded with the bachata singers he had grown up hearing; Luis Vargas, Joe Veras, Monchy & Alexandra and Raulín Rodríguez were on it as well. Decidí, from 2020, was written for him by Daniel Monción.

A year later he recorded Por última vez with Eddy Herrera, a merengue singer working in bachata, which the Dominican press treated as the clearest recent case of that crossing. Earlier, he had contributed to Contra el Tiempo, the first album by Don Miguelo.

**Quién te dio el derecho**

Quién te dio el derecho, written by Ángela Milagros Santos, won bachata of the year at the Premios Soberano in March 2026, in a category where El Chaval de la Bachata and other singers of the following generation were also honoured that night.

He has recorded more than twenty productions. Soy Tuyo, Noche de Pasión, Devuélveme Mi Libertad and Aventurero belong to the later part of that run, followed by the four volumes of Mi Historia Musical and, in 2025, Descarada.',
       bio_es = 'Francisco López Reyes, que graba como Frank Reyes, es un cantante y compositor dominicano de bachata, natural de Tenares. Anunciado como El Príncipe de la Bachata, ha ganado siete veces el premio dominicano al bachatero del año, más que ningún otro intérprete en la historia de la categoría.

**De Tenares a la capital**

Nació en 1969 en Tenares, provincia Hermanas Mirabal, y empezó a cantar de niño en un grupo que armó con sus hermanos. A los doce se fue a Santo Domingo y tomó el trabajo que apareciera mientras buscaba la manera de entrar en la música.

**Tú Serás Mi Reina**

Su primer disco, Tú Serás Mi Reina, salió en 1991 y lo puso en la prensa dominicana. El resto de la década publicó casi un disco por año: Si El Amor Condena, Estoy Condenado, Bachata Con Categoría, Regresó Mi Amor Bonito, El Antojito, El Príncipe, Vine A Decirte Adiós y Extraño Mi Pueblo. Con Vine A Decirte Adiós llegó su primer premio como bachatero del año, en 1999.

**Nada de Nada**

En 2001 las cadenas de radio y televisión dominicanas lo nombraron artista bachatero del año. Al año siguiente Nada de Nada lo sacó del país: funcionó en varios países de América Latina y entre el público hispanohablante de Estados Unidos y Europa, y sigue siendo el tema que la gente nombra primero. Apareció además en el recopilatorio Reggae Bachata 2003, donde el tema se rehízo como remezcla de reguetón con Zurdo.

**Siete estatuillas**

Ganó el premio al bachatero del año en 1999, 2002, 2003 y 2005 bajo los Casandra, y otra vez en 2015, 2017 y 2018 bajo los Soberano. Las siete lo ponen por delante de todos los que han tenido la categoría: Zacarías Ferreira tiene seis, Antony Santos cinco, Raulín Rodríguez tres, Joe Veras dos, y Teodoro Reyes, Luis Miguel del Amargue y Elvis Martínez una cada uno.

También se ha llevado tres veces la bachata del año, que premia la canción y no al cantante: en 2005 por Quién eres tú, en 2007 por Princesa, escrita por Rafael Martín Céspedes, y de nuevo en 2026.

**Noche de Pasión**

Noche de Pasión, publicada en agosto de 2014, se mantuvo veintidós semanas en la lista Top Latin Songs de Monitor Latino en la República Dominicana y llegó al tercer puesto. Cómo Sanar salió en 2015 y Veneno en 2018, las dos en los primeros lugares de las listas del país.

**Dentro del género**

Cantó Payasos en Utopía, el disco de 2019 en el que Romeo Santos grabó con los bachateros que había crecido oyendo; también estaban ahí Luis Vargas, Joe Veras, Monchy & Alexandra y Raulín Rodríguez. Decidí, de 2020, se la escribió Daniel Monción.

Un año después grabó Por última vez con Eddy Herrera, un merenguero metido en la bachata, cruce que la prensa dominicana tomó como el ejemplo más reciente de ese movimiento. Antes había trabajado en Contra el Tiempo, el primer disco de Don Miguelo.

**Quién te dio el derecho**

Quién te dio el derecho, compuesta por Ángela Milagros Santos, ganó la bachata del año en los Premios Soberano de marzo de 2026, en una noche en la que también fueron premiados El Chaval de la Bachata y otros cantantes de la generación siguiente.

Lleva más de veinte producciones grabadas. Soy Tuyo, Noche de Pasión, Devuélveme Mi Libertad y Aventurero pertenecen al tramo más reciente, seguidos por los cuatro volúmenes de Mi Historia Musical y, en 2025, Descarada.',
       updated_at = now()
 WHERE slug = 'frank-reyes';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Francisco López Reyes, who records as Frank Reyes, is a Dominican bachata singer and composer from Tenares. Billed as El Príncipe de la Bachata, he has won the Dominican award for bachata singer of the year seven times, more than any other performer in the history of the category.","type":"text"}]},{"type":"paragraph","content":[{"text":"Tenares to the capital","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1969 in Tenares, in the province of Hermanas Mirabal, and began singing as a boy in a group he put together with his brothers. At twelve he moved to Santo Domingo and took whatever work came while he looked for a way into music.","type":"text"}]},{"type":"paragraph","content":[{"text":"Tú Serás Mi Reina","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His first album, Tú Serás Mi Reina, came out in 1991 and got him heard in the Dominican press. Through the rest of the decade he released almost one record a year — Si El Amor Condena, Estoy Condenado, Bachata Con Categoría, Regresó Mi Amor Bonito, El Antojito, El Príncipe, Vine A Decirte Adiós and Extraño Mi Pueblo. Vine A Decirte Adiós brought him his first award as bachata singer of the year, in 1999.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nada de Nada","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2001 the Dominican radio and television networks named him bachata artist of the year. The following year Nada de Nada took him outside the country: it worked across Latin America and among Spanish-speaking audiences in the United States and Europe, and it remains the record most people name first. He also turned up on the compilation Reggae Bachata 2003, where the song was reworked as a reggaetón remix with Zurdo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Seven statuettes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He won bachata singer of the year in 1999, 2002, 2003 and 2005 under the Casandra awards, and again in 2015, 2017 and 2018 under the Soberano. The seven put him ahead of everyone else who has held the category: ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a77079ce-351a-4eb5-baef-de02dc1b62ce","displayText":"Zacarías Ferreira","occurrenceId":"769d656d-a0f7-4a27-822c-bc2ac66895f6"}},{"text":" has six, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos","occurrenceId":"d856b9cd-5573-491e-ae72-6f606c29947b"}},{"text":" five, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"3c2e0101-407b-4e4b-8b1a-a5b42a4f57bc"}},{"text":" three, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aec32df5-cc5a-43c2-ac33-02bc8caa1cf5","displayText":"Joe Veras","occurrenceId":"4f68c5d4-a7a0-416a-94f8-ae15344f1481"}},{"text":" two, and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"97aba7a6-2428-4540-8ddd-79ea8c487e36","displayText":"Teodoro Reyes","occurrenceId":"88b437ce-9e88-49ed-8330-27f321720cd1"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6302aca6-2203-456f-ad96-6bd2f26ee9b3","displayText":"Luis Miguel del Amargue","occurrenceId":"66863703-88db-40ac-baf6-2366f6636d5a"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e566c763-02c1-4f96-8a82-edbba9fc0bb2","displayText":"Elvis Martínez","occurrenceId":"48bbabb7-ba6d-49ee-aa3e-1fe69be2e961"}},{"text":" one each.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has also taken bachata of the year, the award for the song rather than the singer, three times: in 2005 for Quién eres tú, in 2007 for Princesa, written by Rafael Martín Céspedes, and again in 2026.","type":"text"}]},{"type":"paragraph","content":[{"text":"Noche de Pasión","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Noche de Pasión, released in August 2014, spent twenty-two weeks on Monitor Latino’s Dominican Top Latin Songs chart and reached number three. Cómo Sanar followed in 2015 and Veneno in 2018, both of them near the top of the Dominican lists.","type":"text"}]},{"type":"paragraph","content":[{"text":"Across the genre","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He sang Payasos on Utopía, the 2019 album on which Romeo Santos recorded with the bachata singers he had grown up hearing; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas","occurrenceId":"53006f24-cfff-4dd3-a027-5bf8ceb3189a"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aec32df5-cc5a-43c2-ac33-02bc8caa1cf5","displayText":"Joe Veras","occurrenceId":"c2f0a579-3f3f-453a-9a16-8749efa4e0f2"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra","occurrenceId":"12737de7-7ed9-402e-a4a6-9f79a67c473a"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"b13dbf32-b979-4a5d-a5ee-7ce0c889f3b0"}},{"text":" were on it as well. Decidí, from 2020, was written for him by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"998fcf05-a3bd-48b5-a95e-4e7cd6cb96b4","displayText":"Daniel Monción","occurrenceId":"32191a30-20dc-40bc-bf9a-ca4fc90a29b7"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"A year later he recorded Por última vez with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera","occurrenceId":"790ca8ff-8042-49f3-b7a1-f76ed12fd902"}},{"text":", a merengue singer working in bachata, which the Dominican press treated as the clearest recent case of that crossing. Earlier, he had contributed to Contra el Tiempo, the first album by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"b1204c5c-f89b-4d33-91ce-40d500ae4f95"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Quién te dio el derecho","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Quién te dio el derecho, written by Ángela Milagros Santos, won bachata of the year at the Premios Soberano in March 2026, in a category where ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6","displayText":"El Chaval de la Bachata","occurrenceId":"c0f60f58-c8b7-4f85-ae5c-851b9da8ab67"}},{"text":" and other singers of the following generation were also honoured that night.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has recorded more than twenty productions. Soy Tuyo, Noche de Pasión, Devuélveme Mi Libertad and Aventurero belong to the later part of that run, followed by the four volumes of Mi Historia Musical and, in 2025, Descarada.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'frank-reyes'), 3)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Francisco López Reyes, que graba como Frank Reyes, es un cantante y compositor dominicano de bachata, natural de Tenares. Anunciado como El Príncipe de la Bachata, ha ganado siete veces el premio dominicano al bachatero del año, más que ningún otro intérprete en la historia de la categoría.","type":"text"}]},{"type":"paragraph","content":[{"text":"De Tenares a la capital","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1969 en Tenares, provincia Hermanas Mirabal, y empezó a cantar de niño en un grupo que armó con sus hermanos. A los doce se fue a Santo Domingo y tomó el trabajo que apareciera mientras buscaba la manera de entrar en la música.","type":"text"}]},{"type":"paragraph","content":[{"text":"Tú Serás Mi Reina","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su primer disco, Tú Serás Mi Reina, salió en 1991 y lo puso en la prensa dominicana. El resto de la década publicó casi un disco por año: Si El Amor Condena, Estoy Condenado, Bachata Con Categoría, Regresó Mi Amor Bonito, El Antojito, El Príncipe, Vine A Decirte Adiós y Extraño Mi Pueblo. Con Vine A Decirte Adiós llegó su primer premio como bachatero del año, en 1999.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nada de Nada","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2001 las cadenas de radio y televisión dominicanas lo nombraron artista bachatero del año. Al año siguiente Nada de Nada lo sacó del país: funcionó en varios países de América Latina y entre el público hispanohablante de Estados Unidos y Europa, y sigue siendo el tema que la gente nombra primero. Apareció además en el recopilatorio Reggae Bachata 2003, donde el tema se rehízo como remezcla de reguetón con Zurdo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Siete estatuillas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Ganó el premio al bachatero del año en 1999, 2002, 2003 y 2005 bajo los Casandra, y otra vez en 2015, 2017 y 2018 bajo los Soberano. Las siete lo ponen por delante de todos los que han tenido la categoría: ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a77079ce-351a-4eb5-baef-de02dc1b62ce","displayText":"Zacarías Ferreira","occurrenceId":"87ceb438-8791-4e7a-93bc-1ede2a34a01b"}},{"text":" tiene seis, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos","occurrenceId":"ed0c3c30-2972-4708-aa6d-daa2e48109ee"}},{"text":" cinco, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"6194596a-8e7a-41f9-b3e4-63cafb40803f"}},{"text":" tres, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aec32df5-cc5a-43c2-ac33-02bc8caa1cf5","displayText":"Joe Veras","occurrenceId":"5f051ce4-e78e-413e-a409-84986e100e6b"}},{"text":" dos, y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"97aba7a6-2428-4540-8ddd-79ea8c487e36","displayText":"Teodoro Reyes","occurrenceId":"1626e889-d88a-4f05-8329-c3c06d6a465b"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6302aca6-2203-456f-ad96-6bd2f26ee9b3","displayText":"Luis Miguel del Amargue","occurrenceId":"e40ea79f-97b7-4d0f-ba50-012443b38011"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e566c763-02c1-4f96-8a82-edbba9fc0bb2","displayText":"Elvis Martínez","occurrenceId":"22a60a77-525f-496f-8ef6-4bf12609b996"}},{"text":" una cada uno.","type":"text"}]},{"type":"paragraph","content":[{"text":"También se ha llevado tres veces la bachata del año, que premia la canción y no al cantante: en 2005 por Quién eres tú, en 2007 por Princesa, escrita por Rafael Martín Céspedes, y de nuevo en 2026.","type":"text"}]},{"type":"paragraph","content":[{"text":"Noche de Pasión","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Noche de Pasión, publicada en agosto de 2014, se mantuvo veintidós semanas en la lista Top Latin Songs de Monitor Latino en la República Dominicana y llegó al tercer puesto. Cómo Sanar salió en 2015 y Veneno en 2018, las dos en los primeros lugares de las listas del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Dentro del género","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Cantó Payasos en Utopía, el disco de 2019 en el que Romeo Santos grabó con los bachateros que había crecido oyendo; también estaban ahí ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas","occurrenceId":"b4de1e6c-ecac-442e-84af-87e857fd5001"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aec32df5-cc5a-43c2-ac33-02bc8caa1cf5","displayText":"Joe Veras","occurrenceId":"dacf15c8-c086-4cd6-afea-3de52905cdb4"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra","occurrenceId":"28cd8919-2f85-40d8-889e-1c9d613baf13"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"1dc647df-3429-4df2-a3f0-f263667840ea"}},{"text":". Decidí, de 2020, se la escribió ","type":"text"},{"type":"artistReference","attrs":{"artistId":"998fcf05-a3bd-48b5-a95e-4e7cd6cb96b4","displayText":"Daniel Monción","occurrenceId":"7e3caa6e-b596-429c-a67c-05b5c75435b5"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Un año después grabó Por última vez con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera","occurrenceId":"900dae0a-a585-4aae-b5e2-0758cb027769"}},{"text":", un merenguero metido en la bachata, cruce que la prensa dominicana tomó como el ejemplo más reciente de ese movimiento. Antes había trabajado en Contra el Tiempo, el primer disco de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"cd290196-940e-4be4-ac16-2987fc5e3c64"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Quién te dio el derecho","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Quién te dio el derecho, compuesta por Ángela Milagros Santos, ganó la bachata del año en los Premios Soberano de marzo de 2026, en una noche en la que también fueron premiados ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6","displayText":"El Chaval de la Bachata","occurrenceId":"518e3f20-4409-4d17-9bbd-dc6140f7e3ec"}},{"text":" y otros cantantes de la generación siguiente.","type":"text"}]},{"type":"paragraph","content":[{"text":"Lleva más de veinte producciones grabadas. Soy Tuyo, Noche de Pasión, Devuélveme Mi Libertad y Aventurero pertenecen al tramo más reciente, seguidos por los cuatro volúmenes de Mi Historia Musical y, en 2025, Descarada.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'frank-reyes'), 2)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '12737de7-7ed9-402e-a4a6-9f79a67c473a', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '32191a30-20dc-40bc-bf9a-ca4fc90a29b7', 'artist', '998fcf05-a3bd-48b5-a95e-4e7cd6cb96b4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '3c2e0101-407b-4e4b-8b1a-a5b42a4f57bc', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '48bbabb7-ba6d-49ee-aa3e-1fe69be2e961', 'artist', 'e566c763-02c1-4f96-8a82-edbba9fc0bb2');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '4f68c5d4-a7a0-416a-94f8-ae15344f1481', 'artist', 'aec32df5-cc5a-43c2-ac33-02bc8caa1cf5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '53006f24-cfff-4dd3-a027-5bf8ceb3189a', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '66863703-88db-40ac-baf6-2366f6636d5a', 'artist', '6302aca6-2203-456f-ad96-6bd2f26ee9b3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '769d656d-a0f7-4a27-822c-bc2ac66895f6', 'artist', 'a77079ce-351a-4eb5-baef-de02dc1b62ce');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '790ca8ff-8042-49f3-b7a1-f76ed12fd902', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '88b437ce-9e88-49ed-8330-27f321720cd1', 'artist', '97aba7a6-2428-4540-8ddd-79ea8c487e36');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'b1204c5c-f89b-4d33-91ce-40d500ae4f95', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'b13dbf32-b979-4a5d-a5ee-7ce0c889f3b0', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'c0f60f58-c8b7-4f85-ae5c-851b9da8ab67', 'artist', '8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'c2f0a579-3f3f-453a-9a16-8749efa4e0f2', 'artist', 'aec32df5-cc5a-43c2-ac33-02bc8caa1cf5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'd856b9cd-5573-491e-ae72-6f606c29947b', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '1626e889-d88a-4f05-8329-c3c06d6a465b', 'artist', '97aba7a6-2428-4540-8ddd-79ea8c487e36');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '1dc647df-3429-4df2-a3f0-f263667840ea', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '22a60a77-525f-496f-8ef6-4bf12609b996', 'artist', 'e566c763-02c1-4f96-8a82-edbba9fc0bb2');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '28cd8919-2f85-40d8-889e-1c9d613baf13', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '518e3f20-4409-4d17-9bbd-dc6140f7e3ec', 'artist', '8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '5f051ce4-e78e-413e-a409-84986e100e6b', 'artist', 'aec32df5-cc5a-43c2-ac33-02bc8caa1cf5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '6194596a-8e7a-41f9-b3e4-63cafb40803f', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '7e3caa6e-b596-429c-a67c-05b5c75435b5', 'artist', '998fcf05-a3bd-48b5-a95e-4e7cd6cb96b4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '87ceb438-8791-4e7a-93bc-1ede2a34a01b', 'artist', 'a77079ce-351a-4eb5-baef-de02dc1b62ce');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '900dae0a-a585-4aae-b5e2-0758cb027769', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'b4de1e6c-ecac-442e-84af-87e857fd5001', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'cd290196-940e-4be4-ac16-2987fc5e3c64', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'dacf15c8-c086-4cd6-afea-3de52905cdb4', 'artist', 'aec32df5-cc5a-43c2-ac33-02bc8caa1cf5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'e40ea79f-97b7-4d0f-ba50-012443b38011', 'artist', '6302aca6-2203-456f-ad96-6bd2f26ee9b3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'ed0c3c30-2972-4708-aa6d-daa2e48109ee', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8');

COMMIT;
