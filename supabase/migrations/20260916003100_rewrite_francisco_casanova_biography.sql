BEGIN;

-- Ficha de Francisco Casanova.
--
-- El relleno no nombraba un solo papel, teatro ni el hecho de haber sustituido a Pavarotti en
-- 1996, y daba un lugar de nacimiento incorrecto. birth_place/province corregidos de "San
-- Pedro de Macoris" a "El Seibo". last_name corregido a "Chahin"; second_last_name "Casanova"
-- añadido.

UPDATE artists SET last_name = 'Chahín', second_last_name = 'Casanova',
       birth_place = 'El Seibo', province = 'El Seibo'
       WHERE slug = 'francisco-casanova';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Francisco Casanova —born Francisco Chahín Casanova on 3 October 1957 in El Seibo, died in New York on 26 September 2019— was a Dominican lyric tenor who built a twenty-five-year career on the world’s major opera stages, singing a repertoire of fifty-six leading roles."}]},{"type":"paragraph","content":[{"type":"text","text":"A family of singers","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He was the youngest of four children of Alfredo Chahín, a popular singer active in the 1940s with a trained tenor voice, and the pianist Bárbara Casanova, who gave him his first music lessons at age seven and later accompanied him at family gatherings. He made his stage debut at eight, in 1966, singing Rafael Hernández’s «Señorita» at El Seibo’s Teatro Prado, and went on to study under bandleader Enrique Estévez Pacheco before entering the Conservatorio Nacional de Música in the early 1970s, where he trained under the Dominican tenor Rafael Sánchez Cestero."}]},{"type":"paragraph","content":[{"type":"text","text":"New York and the world’s opera houses","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He emigrated to New York in 1978, and over a twenty-five-year career sang leading roles including Oronte in «I Lombardi» and Pinkerton in «Madama Butterfly» at the Metropolitan Opera, Alvaro in «La Forza del Destino» in Avignon, and Gustavo in «Un Ballo in Maschera» in Klagenfurt, Austria, in addition to engagements across Italy, France, Spain, Germany, Poland, the former Yugoslavia, Canada, Puerto Rico and Colombia."}]},{"type":"paragraph","content":[{"type":"text","text":"Substituting for Pavarotti, and Carnegie Hall","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"On 18 May 1996, Casanova stepped in for Luciano Pavarotti at the «Pavarotti and Friends» concert at Avery Fisher Hall in New York, performing arias and duets from «La Bohème», «Un Ballo in Maschera», «Tosca», «Il Trovatore» and «Lucia di Lammermoor». He debuted at Carnegie Hall on 13 April 1999 as Eléazar in Halévy’s «La Juive», under conductor Eve Queler, and that August starred in the title role of Verdi’s «Aída» in his first full opera performance before a Dominican audience."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Casanova performed for more than two decades without canceling a single engagement for illness, retiring from the stage in April 2012 as diabetes advanced; he died in New York on 26 September 2019, remembered in the Dominican press as the country’s most internationally accomplished operatic voice."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'francisco-casanova'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'francisco-casanova' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Francisco Casanova —born Francisco Chahín Casanova on 3 October 1957 in El Seibo, died in New York on 26 September 2019— was a Dominican lyric tenor who built a twenty-five-year career on the world’s major opera stages, singing a repertoire of fifty-six leading roles.

**A family of singers**

He was the youngest of four children of Alfredo Chahín, a popular singer active in the 1940s with a trained tenor voice, and the pianist Bárbara Casanova, who gave him his first music lessons at age seven and later accompanied him at family gatherings. He made his stage debut at eight, in 1966, singing Rafael Hernández’s «Señorita» at El Seibo’s Teatro Prado, and went on to study under bandleader Enrique Estévez Pacheco before entering the Conservatorio Nacional de Música in the early 1970s, where he trained under the Dominican tenor Rafael Sánchez Cestero.

**New York and the world’s opera houses**

He emigrated to New York in 1978, and over a twenty-five-year career sang leading roles including Oronte in «I Lombardi» and Pinkerton in «Madama Butterfly» at the Metropolitan Opera, Alvaro in «La Forza del Destino» in Avignon, and Gustavo in «Un Ballo in Maschera» in Klagenfurt, Austria, in addition to engagements across Italy, France, Spain, Germany, Poland, the former Yugoslavia, Canada, Puerto Rico and Colombia.

**Substituting for Pavarotti, and Carnegie Hall**

On 18 May 1996, Casanova stepped in for Luciano Pavarotti at the «Pavarotti and Friends» concert at Avery Fisher Hall in New York, performing arias and duets from «La Bohème», «Un Ballo in Maschera», «Tosca», «Il Trovatore» and «Lucia di Lammermoor». He debuted at Carnegie Hall on 13 April 1999 as Eléazar in Halévy’s «La Juive», under conductor Eve Queler, and that August starred in the title role of Verdi’s «Aída» in his first full opera performance before a Dominican audience.

**Legacy**

Casanova performed for more than two decades without canceling a single engagement for illness, retiring from the stage in April 2012 as diabetes advanced; he died in New York on 26 September 2019, remembered in the Dominican press as the country’s most internationally accomplished operatic voice.' WHERE slug = 'francisco-casanova';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Francisco Casanova —nacido Francisco Chahín Casanova el 3 de octubre de 1957 en El Seibo, fallecido en Nueva York el 26 de septiembre de 2019— fue tenor lírico dominicano que construyó una carrera de veinticinco años en los principales escenarios operísticos del mundo, con un repertorio de cincuenta y seis papeles protagónicos."}]},{"type":"paragraph","content":[{"type":"text","text":"Una familia de cantantes","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fue el menor de cuatro hijos de Alfredo Chahín, cantante popular activo en los años cuarenta con una voz de tenor entrenada, y de la pianista Bárbara Casanova, quien le dio sus primeras clases de música a los siete años y más tarde lo acompañaba en las veladas familiares. Debutó en escena a los ocho años, en 1966, cantando «Señorita» de Rafael Hernández en el Teatro Prado de El Seibo, y luego estudió con el director de banda Enrique Estévez Pacheco antes de ingresar al Conservatorio Nacional de Música a inicios de los años setenta, donde se formó bajo el tenor dominicano Rafael Sánchez Cestero."}]},{"type":"paragraph","content":[{"type":"text","text":"Nueva York y los teatros de ópera del mundo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Emigró a Nueva York en 1978, y a lo largo de una carrera de veinticinco años cantó papeles protagónicos como Oronte en «I Lombardi» y Pinkerton en «Madama Butterfly» en el Metropolitan Opera, Alvaro en «La Forza del Destino» en Avignon, y Gustavo en «Un Ballo in Maschera» en Klagenfurt, Austria, además de presentaciones en Italia, Francia, España, Alemania, Polonia, la entonces Yugoslavia, Canadá, Puerto Rico y Colombia."}]},{"type":"paragraph","content":[{"type":"text","text":"Sustituir a Pavarotti, y Carnegie Hall","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El 18 de mayo de 1996, Casanova sustituyó a Luciano Pavarotti en el concierto «Pavarotti and Friends» en el Avery Fisher Hall de Nueva York, interpretando arias y dúos de «La Bohème», «Un Ballo in Maschera», «Tosca», «Il Trovatore» y «Lucia di Lammermoor». Debutó en el Carnegie Hall el 13 de abril de 1999 como Eléazar en «La Juive» de Halévy, bajo la dirección de Eve Queler, y ese agosto protagonizó el papel principal de «Aída», de Verdi, en su primera ópera completa ante el público dominicano."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Casanova se presentó durante más de dos décadas sin cancelar una sola función por enfermedad, y se retiró de los escenarios en abril de 2012 conforme avanzaba su diabetes; murió en Nueva York el 26 de septiembre de 2019, recordado por la prensa dominicana como la voz operística más internacional del país."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'francisco-casanova'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'francisco-casanova' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Francisco Casanova —nacido Francisco Chahín Casanova el 3 de octubre de 1957 en El Seibo, fallecido en Nueva York el 26 de septiembre de 2019— fue tenor lírico dominicano que construyó una carrera de veinticinco años en los principales escenarios operísticos del mundo, con un repertorio de cincuenta y seis papeles protagónicos.

**Una familia de cantantes**

Fue el menor de cuatro hijos de Alfredo Chahín, cantante popular activo en los años cuarenta con una voz de tenor entrenada, y de la pianista Bárbara Casanova, quien le dio sus primeras clases de música a los siete años y más tarde lo acompañaba en las veladas familiares. Debutó en escena a los ocho años, en 1966, cantando «Señorita» de Rafael Hernández en el Teatro Prado de El Seibo, y luego estudió con el director de banda Enrique Estévez Pacheco antes de ingresar al Conservatorio Nacional de Música a inicios de los años setenta, donde se formó bajo el tenor dominicano Rafael Sánchez Cestero.

**Nueva York y los teatros de ópera del mundo**

Emigró a Nueva York en 1978, y a lo largo de una carrera de veinticinco años cantó papeles protagónicos como Oronte en «I Lombardi» y Pinkerton en «Madama Butterfly» en el Metropolitan Opera, Alvaro en «La Forza del Destino» en Avignon, y Gustavo en «Un Ballo in Maschera» en Klagenfurt, Austria, además de presentaciones en Italia, Francia, España, Alemania, Polonia, la entonces Yugoslavia, Canadá, Puerto Rico y Colombia.

**Sustituir a Pavarotti, y Carnegie Hall**

El 18 de mayo de 1996, Casanova sustituyó a Luciano Pavarotti en el concierto «Pavarotti and Friends» en el Avery Fisher Hall de Nueva York, interpretando arias y dúos de «La Bohème», «Un Ballo in Maschera», «Tosca», «Il Trovatore» y «Lucia di Lammermoor». Debutó en el Carnegie Hall el 13 de abril de 1999 como Eléazar en «La Juive» de Halévy, bajo la dirección de Eve Queler, y ese agosto protagonizó el papel principal de «Aída», de Verdi, en su primera ópera completa ante el público dominicano.

**Legado**

Casanova se presentó durante más de dos décadas sin cancelar una sola función por enfermedad, y se retiró de los escenarios en abril de 2012 conforme avanzaba su diabetes; murió en Nueva York el 26 de septiembre de 2019, recordado por la prensa dominicana como la voz operística más internacional del país.' WHERE slug = 'francisco-casanova';

COMMIT;
