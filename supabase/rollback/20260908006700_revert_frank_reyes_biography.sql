BEGIN;

-- Reverts 20260908006700_rewrite_frank_reyes_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

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

His first album, Tú Serás Mi Reina, came out in 1991 and got him heard in the Dominican press. Through the rest of the decade he released almost one record a year — Si El Amor Condena, Estoy Condenado, Bachata Con Categoría, Regresó Mi Amor Bonito, El Antojito, El Príncipe, Vine A Decirte Adiós and Extraño Mi Pueblo. The last of those brought him his first award as bachata singer of the year, in 1999.

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

Su primer disco, Tú Serás Mi Reina, salió en 1991 y lo puso en la prensa dominicana. El resto de la década publicó casi un disco por año: Si El Amor Condena, Estoy Condenado, Bachata Con Categoría, Regresó Mi Amor Bonito, El Antojito, El Príncipe, Vine A Decirte Adiós y Extraño Mi Pueblo. Con el penúltimo llegó su primer premio como bachatero del año, en 1999.

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
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Francisco López Reyes, who records as Frank Reyes, is a Dominican bachata singer and composer from Tenares. Billed as El Príncipe de la Bachata, he has won the Dominican award for bachata singer of the year seven times, more than any other performer in the history of the category.","type":"text"}]},{"type":"paragraph","content":[{"text":"Tenares to the capital","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1969 in Tenares, in the province of Hermanas Mirabal, and began singing as a boy in a group he put together with his brothers. At twelve he moved to Santo Domingo and took whatever work came while he looked for a way into music.","type":"text"}]},{"type":"paragraph","content":[{"text":"Tú Serás Mi Reina","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His first album, Tú Serás Mi Reina, came out in 1991 and got him heard in the Dominican press. Through the rest of the decade he released almost one record a year — Si El Amor Condena, Estoy Condenado, Bachata Con Categoría, Regresó Mi Amor Bonito, El Antojito, El Príncipe, Vine A Decirte Adiós and Extraño Mi Pueblo. The last of those brought him his first award as bachata singer of the year, in 1999.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nada de Nada","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2001 the Dominican radio and television networks named him bachata artist of the year. The following year Nada de Nada took him outside the country: it worked across Latin America and among Spanish-speaking audiences in the United States and Europe, and it remains the record most people name first. He also turned up on the compilation Reggae Bachata 2003, where the song was reworked as a reggaetón remix with Zurdo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Seven statuettes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He won bachata singer of the year in 1999, 2002, 2003 and 2005 under the Casandra awards, and again in 2015, 2017 and 2018 under the Soberano. The seven put him ahead of everyone else who has held the category: ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a77079ce-351a-4eb5-baef-de02dc1b62ce","displayText":"Zacarías Ferreira","occurrenceId":"c14790df-b63a-424b-a14c-242fd6636569"}},{"text":" has six, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos","occurrenceId":"af4616e1-8453-4575-9317-ad0ac2875460"}},{"text":" five, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"8ca871c3-413e-4879-bb79-8195b00826df"}},{"text":" three, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aec32df5-cc5a-43c2-ac33-02bc8caa1cf5","displayText":"Joe Veras","occurrenceId":"ece05207-cad4-4b2a-ab2a-1ff7d1759659"}},{"text":" two, and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"97aba7a6-2428-4540-8ddd-79ea8c487e36","displayText":"Teodoro Reyes","occurrenceId":"0e268ebe-d272-4d64-aebe-e59f280ff379"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6302aca6-2203-456f-ad96-6bd2f26ee9b3","displayText":"Luis Miguel del Amargue","occurrenceId":"dcb6a3ce-36e2-485d-ab91-536d4fe13166"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e566c763-02c1-4f96-8a82-edbba9fc0bb2","displayText":"Elvis Martínez","occurrenceId":"9584fc6f-12c3-4f98-9f34-3f3dac3d6721"}},{"text":" one each.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has also taken bachata of the year, the award for the song rather than the singer, three times: in 2005 for Quién eres tú, in 2007 for Princesa, written by Rafael Martín Céspedes, and again in 2026.","type":"text"}]},{"type":"paragraph","content":[{"text":"Noche de Pasión","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Noche de Pasión, released in August 2014, spent twenty-two weeks on Monitor Latino’s Dominican Top Latin Songs chart and reached number three. Cómo Sanar followed in 2015 and Veneno in 2018, both of them near the top of the Dominican lists.","type":"text"}]},{"type":"paragraph","content":[{"text":"Across the genre","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He sang Payasos on Utopía, the 2019 album on which Romeo Santos recorded with the bachata singers he had grown up hearing; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas","occurrenceId":"f5044448-879e-4ffa-9d36-c481ce7c77c7"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aec32df5-cc5a-43c2-ac33-02bc8caa1cf5","displayText":"Joe Veras","occurrenceId":"be7fa6f2-8bfc-458d-9e71-06b2e89b08cd"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra","occurrenceId":"4f1c79cc-60c0-49b8-bd40-1832184348aa"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"39633fbc-b45c-469b-8126-d575c4427231"}},{"text":" were on it as well. Decidí, from 2020, was written for him by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"998fcf05-a3bd-48b5-a95e-4e7cd6cb96b4","displayText":"Daniel Monción","occurrenceId":"84df794a-c655-49b8-b503-027acacf0b50"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"A year later he recorded Por última vez with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera","occurrenceId":"a933ac9e-ddcc-4804-84f4-6b5779bd21ac"}},{"text":", a merengue singer working in bachata, which the Dominican press treated as the clearest recent case of that crossing. Earlier, he had contributed to Contra el Tiempo, the first album by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"eda18621-ddc1-4416-b856-7505d34480d3"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Quién te dio el derecho","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Quién te dio el derecho, written by Ángela Milagros Santos, won bachata of the year at the Premios Soberano in March 2026, in a category where ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6","displayText":"El Chaval de la Bachata","occurrenceId":"ca494fef-8115-4a05-a4e2-b7e722185d4b"}},{"text":" and other singers of the following generation were also honoured that night.","type":"text"}]},{"type":"paragraph","content":[{"text":"He has recorded more than twenty productions. Soy Tuyo, Noche de Pasión, Devuélveme Mi Libertad and Aventurero belong to the later part of that run, followed by the four volumes of Mi Historia Musical and, in 2025, Descarada.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'frank-reyes'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Francisco López Reyes, que graba como Frank Reyes, es un cantante y compositor dominicano de bachata, natural de Tenares. Anunciado como El Príncipe de la Bachata, ha ganado siete veces el premio dominicano al bachatero del año, más que ningún otro intérprete en la historia de la categoría.","type":"text"}]},{"type":"paragraph","content":[{"text":"De Tenares a la capital","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1969 en Tenares, provincia Hermanas Mirabal, y empezó a cantar de niño en un grupo que armó con sus hermanos. A los doce se fue a Santo Domingo y tomó el trabajo que apareciera mientras buscaba la manera de entrar en la música.","type":"text"}]},{"type":"paragraph","content":[{"text":"Tú Serás Mi Reina","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su primer disco, Tú Serás Mi Reina, salió en 1991 y lo puso en la prensa dominicana. El resto de la década publicó casi un disco por año: Si El Amor Condena, Estoy Condenado, Bachata Con Categoría, Regresó Mi Amor Bonito, El Antojito, El Príncipe, Vine A Decirte Adiós y Extraño Mi Pueblo. Con el penúltimo llegó su primer premio como bachatero del año, en 1999.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nada de Nada","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2001 las cadenas de radio y televisión dominicanas lo nombraron artista bachatero del año. Al año siguiente Nada de Nada lo sacó del país: funcionó en varios países de América Latina y entre el público hispanohablante de Estados Unidos y Europa, y sigue siendo el tema que la gente nombra primero. Apareció además en el recopilatorio Reggae Bachata 2003, donde el tema se rehízo como remezcla de reguetón con Zurdo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Siete estatuillas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Ganó el premio al bachatero del año en 1999, 2002, 2003 y 2005 bajo los Casandra, y otra vez en 2015, 2017 y 2018 bajo los Soberano. Las siete lo ponen por delante de todos los que han tenido la categoría: ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a77079ce-351a-4eb5-baef-de02dc1b62ce","displayText":"Zacarías Ferreira","occurrenceId":"f770055f-6d60-40bb-a3f5-27fd12286f9a"}},{"text":" tiene seis, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos","occurrenceId":"5c1de9ae-d52c-4b12-a906-2881fbc63afe"}},{"text":" cinco, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"a5cdeb44-2fde-486a-ac0c-c7176ea9d0ae"}},{"text":" tres, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aec32df5-cc5a-43c2-ac33-02bc8caa1cf5","displayText":"Joe Veras","occurrenceId":"f5347035-cc3d-4f52-ad98-4c80653f0ce0"}},{"text":" dos, y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"97aba7a6-2428-4540-8ddd-79ea8c487e36","displayText":"Teodoro Reyes","occurrenceId":"c0f35411-dec9-4ba3-9594-48593d6fdea2"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6302aca6-2203-456f-ad96-6bd2f26ee9b3","displayText":"Luis Miguel del Amargue","occurrenceId":"46bdae40-a065-4de0-8f2f-9f431ad5acfb"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e566c763-02c1-4f96-8a82-edbba9fc0bb2","displayText":"Elvis Martínez","occurrenceId":"a693cae2-1c9b-4303-83e2-7c77f6e78d4b"}},{"text":" una cada uno.","type":"text"}]},{"type":"paragraph","content":[{"text":"También se ha llevado tres veces la bachata del año, que premia la canción y no al cantante: en 2005 por Quién eres tú, en 2007 por Princesa, escrita por Rafael Martín Céspedes, y de nuevo en 2026.","type":"text"}]},{"type":"paragraph","content":[{"text":"Noche de Pasión","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Noche de Pasión, publicada en agosto de 2014, se mantuvo veintidós semanas en la lista Top Latin Songs de Monitor Latino en la República Dominicana y llegó al tercer puesto. Cómo Sanar salió en 2015 y Veneno en 2018, las dos en los primeros lugares de las listas del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Dentro del género","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Cantó Payasos en Utopía, el disco de 2019 en el que Romeo Santos grabó con los bachateros que había crecido oyendo; también estaban ahí ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas","occurrenceId":"b64ad4cd-026c-4036-922d-5866ae5cc438"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aec32df5-cc5a-43c2-ac33-02bc8caa1cf5","displayText":"Joe Veras","occurrenceId":"7ecfbf71-c0b4-45e2-88d0-a4d173697d58"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra","occurrenceId":"e2c5492c-780a-449a-aeea-065315b13aa5"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"c5b76ab5-8117-44ff-be85-f5119d30e322"}},{"text":". Decidí, de 2020, se la escribió ","type":"text"},{"type":"artistReference","attrs":{"artistId":"998fcf05-a3bd-48b5-a95e-4e7cd6cb96b4","displayText":"Daniel Monción","occurrenceId":"12490125-eed4-4d44-b991-8f3634b2ae1d"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Un año después grabó Por última vez con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera","occurrenceId":"74849cd0-324b-49a4-a24d-e2d3abb8629a"}},{"text":", un merenguero metido en la bachata, cruce que la prensa dominicana tomó como el ejemplo más reciente de ese movimiento. Antes había trabajado en Contra el Tiempo, el primer disco de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"bee4d986-2da0-4f70-8d22-3992f83426b3"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Quién te dio el derecho","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Quién te dio el derecho, compuesta por Ángela Milagros Santos, ganó la bachata del año en los Premios Soberano de marzo de 2026, en una noche en la que también fueron premiados ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6","displayText":"El Chaval de la Bachata","occurrenceId":"f2e5a764-deee-43c3-a988-d1724a13d6c9"}},{"text":" y otros cantantes de la generación siguiente.","type":"text"}]},{"type":"paragraph","content":[{"text":"Lleva más de veinte producciones grabadas. Soy Tuyo, Noche de Pasión, Devuélveme Mi Libertad y Aventurero pertenecen al tramo más reciente, seguidos por los cuatro volúmenes de Mi Historia Musical y, en 2025, Descarada.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'frank-reyes'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '0e268ebe-d272-4d64-aebe-e59f280ff379', 'artist', '97aba7a6-2428-4540-8ddd-79ea8c487e36');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '39633fbc-b45c-469b-8126-d575c4427231', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '4f1c79cc-60c0-49b8-bd40-1832184348aa', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '84df794a-c655-49b8-b503-027acacf0b50', 'artist', '998fcf05-a3bd-48b5-a95e-4e7cd6cb96b4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '8ca871c3-413e-4879-bb79-8195b00826df', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), '9584fc6f-12c3-4f98-9f34-3f3dac3d6721', 'artist', 'e566c763-02c1-4f96-8a82-edbba9fc0bb2');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'a933ac9e-ddcc-4804-84f4-6b5779bd21ac', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'af4616e1-8453-4575-9317-ad0ac2875460', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'be7fa6f2-8bfc-458d-9e71-06b2e89b08cd', 'artist', 'aec32df5-cc5a-43c2-ac33-02bc8caa1cf5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'c14790df-b63a-424b-a14c-242fd6636569', 'artist', 'a77079ce-351a-4eb5-baef-de02dc1b62ce');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'ca494fef-8115-4a05-a4e2-b7e722185d4b', 'artist', '8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'dcb6a3ce-36e2-485d-ab91-536d4fe13166', 'artist', '6302aca6-2203-456f-ad96-6bd2f26ee9b3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'ece05207-cad4-4b2a-ab2a-1ff7d1759659', 'artist', 'aec32df5-cc5a-43c2-ac33-02bc8caa1cf5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'eda18621-ddc1-4416-b856-7505d34480d3', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'en'), 'f5044448-879e-4ffa-9d36-c481ce7c77c7', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '12490125-eed4-4d44-b991-8f3634b2ae1d', 'artist', '998fcf05-a3bd-48b5-a95e-4e7cd6cb96b4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '46bdae40-a065-4de0-8f2f-9f431ad5acfb', 'artist', '6302aca6-2203-456f-ad96-6bd2f26ee9b3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '5c1de9ae-d52c-4b12-a906-2881fbc63afe', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '74849cd0-324b-49a4-a24d-e2d3abb8629a', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), '7ecfbf71-c0b4-45e2-88d0-a4d173697d58', 'artist', 'aec32df5-cc5a-43c2-ac33-02bc8caa1cf5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'a5cdeb44-2fde-486a-ac0c-c7176ea9d0ae', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'a693cae2-1c9b-4303-83e2-7c77f6e78d4b', 'artist', 'e566c763-02c1-4f96-8a82-edbba9fc0bb2');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'b64ad4cd-026c-4036-922d-5866ae5cc438', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'bee4d986-2da0-4f70-8d22-3992f83426b3', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'c0f35411-dec9-4ba3-9594-48593d6fdea2', 'artist', '97aba7a6-2428-4540-8ddd-79ea8c487e36');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'c5b76ab5-8117-44ff-be85-f5119d30e322', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'e2c5492c-780a-449a-aeea-065315b13aa5', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'f2e5a764-deee-43c3-a988-d1724a13d6c9', 'artist', '8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'f5347035-cc3d-4f52-ad98-4c80653f0ce0', 'artist', 'aec32df5-cc5a-43c2-ac33-02bc8caa1cf5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'frank-reyes') AND locale = 'es'), 'f770055f-6d60-40bb-a3f5-27fd12286f9a', 'artist', 'a77079ce-351a-4eb5-baef-de02dc1b62ce');

COMMIT;
