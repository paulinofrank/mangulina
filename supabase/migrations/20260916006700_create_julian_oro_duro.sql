BEGIN;

-- Ficha NUEVA en estado draft: Julián Oro Duro (Gilberto Julián Sarante Perdomo). Nominación Casandra 2005 (Compositor del Año).

INSERT INTO artists (name, sort_name, type, first_name, middle_name, last_name, second_last_name, stage_name, birth_place, youtube, aliases,
                                 occupations, instruments, genres, gender, ended, slug, primary_role, artist_tags, status, primary_genre, has_image, id)
  VALUES ('Julián Oro Duro', 'Oro Duro, Julián', 'solo_artist', 'Gilberto', 'Julián', 'Sarante', 'Perdomo', 'Julián Oro Duro', 'Santo Domingo', '@julianoroduro',
          ARRAY['Julian Oro Duro']::text[], '["composer","arranger","bandleader"]'::jsonb, '{}'::text[], ARRAY['merengue-calle','merengue-mambo','salsa','bachata']::text[], 'male', false, 'julian-oro-duro',
          'singer', ARRAY['secular']::text[], 'draft', 'merengue', false, '008f71f8-e39c-4668-9d56-ea9106f6ae13');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT a.id, 'ead83dcf-9e2c-4f69-a557-dad604716a5e', '7e32c2ae-1b52-4624-b03e-0d4934cc6fee', 2005, 'Palabritas', false, 'El Día (21 sep 2026) y Diario Libre (21 sep 2026): nominado a Compositor del Año en 2005 por «Palabritas» y «Ni el odio ni la mentira», interpretadas por El Jeffrey' FROM artists a WHERE a.slug = 'julian-oro-duro';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Julián Oro Duro —Gilberto Julián Sarante Perdomo— is a Dominican merengue singer, songwriter and arranger from Santo Domingo, known for the street merengue of the early 2000s and for leading the orchestra Oro Duro. He is the older brother of the salsa singer Yiyo Sarante."}]},{"type":"paragraph","content":[{"type":"text","text":"The orchestra and the family","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In the 1980s and 1990s he fronted the orchestra Oro Duro. His younger brother Yiyo Sarante sang in its chorus before going independent with a project of his own. Dominican media later reported a period of estrangement between the brothers and their public reconciliation."}]},{"type":"paragraph","content":[{"type":"text","text":"Solo career and «La Cabaña»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began a solo career in 2000 and became one of the exponents of merengue de calle, a current that was widely welcomed by young Dominicans. His album «La Cabaña», released on 20 December 2004 by «J&N Records», has thirteen songs, among them «La Cabaña», «La Cita», «Por Eso Está Conmigo», «Historia Entre Tus Dedos», «Y Te Vi», «La Querida» and «El Licor». Later albums include «El Más Duro» and «Pa’ lo Mambero». The press noted that his style opened the way for "},{"type":"artistReference","attrs":{"occurrenceId":"18c83a8c-2517-445c-9930-c924187e9adb","artistId":"d2c0eb06-4b6e-45d1-b795-3778cdf82488","displayText":"Juliana O''Neal"}},{"type":"text","text":", who emerged with a similar proposal before settling on romantic merengue."}]},{"type":"paragraph","content":[{"type":"text","text":"Songwriter","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2005 he was nominated for a Casandra Award as Composer of the Year for «Palabritas» and «Ni el odio ni la mentira», both recorded by "},{"type":"artistReference","attrs":{"occurrenceId":"3b3d2fcb-e4b8-466a-adea-b1945ec5e81e","artistId":"9da4edbe-7d7e-4bf1-8c23-ee01bb5ee65b","displayText":"El Jeffrey"}},{"type":"text","text":"; the second is on the 2004 album «Mi Tierra»."}]},{"type":"paragraph","content":[{"type":"text","text":"Since 2010","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"From 2010 he widened his repertoire to romantic merengue, salsa, bachata and merengue mambo. The album «Jaque Mate», with twelve songs, includes «Sé que llorarás» and «No hace falta papá»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Dominican newspapers describe him as a frequent presence at parties and stages during the years of merengue de calle, and El Día credits his 2004 album «La Cabaña» with making him known to a mass audience."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'julian-oro-duro';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '18c83a8c-2517-445c-9930-c924187e9adb', 'artist', 'd2c0eb06-4b6e-45d1-b795-3778cdf82488' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'julian-oro-duro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '3b3d2fcb-e4b8-466a-adea-b1945ec5e81e', 'artist', '9da4edbe-7d7e-4bf1-8c23-ee01bb5ee65b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'julian-oro-duro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Julián Oro Duro —Gilberto Julián Sarante Perdomo— is a Dominican merengue singer, songwriter and arranger from Santo Domingo, known for the street merengue of the early 2000s and for leading the orchestra Oro Duro. He is the older brother of the salsa singer Yiyo Sarante.

**The orchestra and the family**

In the 1980s and 1990s he fronted the orchestra Oro Duro. His younger brother Yiyo Sarante sang in its chorus before going independent with a project of his own. Dominican media later reported a period of estrangement between the brothers and their public reconciliation.

**Solo career and «La Cabaña»**

He began a solo career in 2000 and became one of the exponents of merengue de calle, a current that was widely welcomed by young Dominicans. His album «La Cabaña», released on 20 December 2004 by «J&N Records», has thirteen songs, among them «La Cabaña», «La Cita», «Por Eso Está Conmigo», «Historia Entre Tus Dedos», «Y Te Vi», «La Querida» and «El Licor». Later albums include «El Más Duro» and «Pa’ lo Mambero». The press noted that his style opened the way for Juliana O''Neal, who emerged with a similar proposal before settling on romantic merengue.

**Songwriter**

In 2005 he was nominated for a Casandra Award as Composer of the Year for «Palabritas» and «Ni el odio ni la mentira», both recorded by El Jeffrey; the second is on the 2004 album «Mi Tierra».

**Since 2010**

From 2010 he widened his repertoire to romantic merengue, salsa, bachata and merengue mambo. The album «Jaque Mate», with twelve songs, includes «Sé que llorarás» and «No hace falta papá».

**Legacy**

Dominican newspapers describe him as a frequent presence at parties and stages during the years of merengue de calle, and El Día credits his 2004 album «La Cabaña» with making him known to a mass audience.' WHERE slug = 'julian-oro-duro';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Julián Oro Duro —Gilberto Julián Sarante Perdomo— es un cantante, compositor y arreglista dominicano de merengue, nacido en Santo Domingo, conocido por el merengue de calle de los primeros años de los 2000 y por dirigir la orquesta Oro Duro. Es hermano mayor del salsero Yiyo Sarante."}]},{"type":"paragraph","content":[{"type":"text","text":"La orquesta y la familia","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En los años ochenta y noventa estuvo al frente de la orquesta Oro Duro. Su hermano menor Yiyo Sarante cantó en el coro de esa orquesta antes de independizarse con un proyecto propio. Medios dominicanos informaron después de un distanciamiento entre los hermanos y de su reconciliación pública."}]},{"type":"paragraph","content":[{"type":"text","text":"Carrera en solitario y «La Cabaña»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Inició su carrera en solitario en 2000 y fue uno de los exponentes del merengue de calle, una corriente que tuvo amplia acogida entre los jóvenes dominicanos. Su álbum «La Cabaña», publicado el 20 de diciembre de 2004 por «J&N Records», tiene trece canciones, entre ellas «La Cabaña», «La Cita», «Por Eso Está Conmigo», «Historia Entre Tus Dedos», «Y Te Vi», «La Querida» y «El Licor». Entre sus discos posteriores están «El Más Duro» y «Pa’ lo Mambero». La prensa señaló que su estilo abrió camino a "},{"type":"artistReference","attrs":{"occurrenceId":"2ddcff4f-e617-4348-8077-51387943fb29","artistId":"d2c0eb06-4b6e-45d1-b795-3778cdf82488","displayText":"Juliana O''Neal"}},{"type":"text","text":", que surgió con una propuesta parecida antes de decantarse por el merengue romántico."}]},{"type":"paragraph","content":[{"type":"text","text":"Compositor","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2005 fue nominado a los Premios Casandra como Compositor del Año por «Palabritas» y «Ni el odio ni la mentira», ambas grabadas por "},{"type":"artistReference","attrs":{"occurrenceId":"235698ce-36b3-45a0-bebf-42aeb3249d03","artistId":"9da4edbe-7d7e-4bf1-8c23-ee01bb5ee65b","displayText":"El Jeffrey"}},{"type":"text","text":"; la segunda está en el álbum «Mi Tierra» de 2004."}]},{"type":"paragraph","content":[{"type":"text","text":"Desde 2010","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A partir de 2010 amplió su repertorio al merengue romántico, la salsa, la bachata y el merengue mambo. El álbum «Jaque Mate», de doce canciones, incluye «Sé que llorarás» y «No hace falta papá»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los periódicos dominicanos lo describen como una presencia frecuente en fiestas y escenarios durante los años del merengue de calle, y El Día atribuye a su álbum «La Cabaña» de 2004 haberlo dado a conocer a un público masivo."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'julian-oro-duro';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '2ddcff4f-e617-4348-8077-51387943fb29', 'artist', 'd2c0eb06-4b6e-45d1-b795-3778cdf82488' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'julian-oro-duro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '235698ce-36b3-45a0-bebf-42aeb3249d03', 'artist', '9da4edbe-7d7e-4bf1-8c23-ee01bb5ee65b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'julian-oro-duro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Julián Oro Duro —Gilberto Julián Sarante Perdomo— es un cantante, compositor y arreglista dominicano de merengue, nacido en Santo Domingo, conocido por el merengue de calle de los primeros años de los 2000 y por dirigir la orquesta Oro Duro. Es hermano mayor del salsero Yiyo Sarante.

**La orquesta y la familia**

En los años ochenta y noventa estuvo al frente de la orquesta Oro Duro. Su hermano menor Yiyo Sarante cantó en el coro de esa orquesta antes de independizarse con un proyecto propio. Medios dominicanos informaron después de un distanciamiento entre los hermanos y de su reconciliación pública.

**Carrera en solitario y «La Cabaña»**

Inició su carrera en solitario en 2000 y fue uno de los exponentes del merengue de calle, una corriente que tuvo amplia acogida entre los jóvenes dominicanos. Su álbum «La Cabaña», publicado el 20 de diciembre de 2004 por «J&N Records», tiene trece canciones, entre ellas «La Cabaña», «La Cita», «Por Eso Está Conmigo», «Historia Entre Tus Dedos», «Y Te Vi», «La Querida» y «El Licor». Entre sus discos posteriores están «El Más Duro» y «Pa’ lo Mambero». La prensa señaló que su estilo abrió camino a Juliana O''Neal, que surgió con una propuesta parecida antes de decantarse por el merengue romántico.

**Compositor**

En 2005 fue nominado a los Premios Casandra como Compositor del Año por «Palabritas» y «Ni el odio ni la mentira», ambas grabadas por El Jeffrey; la segunda está en el álbum «Mi Tierra» de 2004.

**Desde 2010**

A partir de 2010 amplió su repertorio al merengue romántico, la salsa, la bachata y el merengue mambo. El álbum «Jaque Mate», de doce canciones, incluye «Sé que llorarás» y «No hace falta papá».

**Legado**

Los periódicos dominicanos lo describen como una presencia frecuente en fiestas y escenarios durante los años del merengue de calle, y El Día atribuye a su álbum «La Cabaña» de 2004 haberlo dado a conocer a un público masivo.' WHERE slug = 'julian-oro-duro';

COMMIT;
