BEGIN;

-- Ficha de Maffio.
--
-- La biografía de relleno no daba un solo crédito real. occupations y genres se dejan como
-- están (ya reflejan el trabajo cruzado urbano/tropical/pop); primary_role producer ya es
-- correcto. Premios: 3 Latin Grammy como productor (Ilusión 2012, Sinfónico 2014,
-- Visualízate 2016) y Billboard Latin Music Award 2024 (Latin Pop Song of the Year, con
-- Nacho, «No es normal»). Fuego (colaborador) no tiene ficha: ver ARTISTAS_FALTANTES.md.

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Best Tropical Fusion Album' FROM awards a WHERE a.name = 'Latin Grammy'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Best Tropical Fusion Album');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2012, 'Ilusión (Fonseca)', true, 'Wikipedia (es/en, álbum «Ilusión» y ficha de Fonseca); Diario Las Américas (17 ago 2014); LOS40; Rumberos.net'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'maffio' AND a.name = 'Latin Grammy' AND cat.name = 'Best Tropical Fusion Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2012);

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Best Traditional Pop Vocal Album' FROM awards a WHERE a.name = 'Latin Grammy'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Best Traditional Pop Vocal Album');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2014, 'Fonseca Sinfónico (Fonseca)', true, 'latingrammy.com (archivo oficial); Telemundo, Caracol TV, Univision, People en Español y Queens Latino (20-21 nov 2014)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'maffio' AND a.name = 'Latin Grammy' AND cat.name = 'Best Traditional Pop Vocal Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2014);

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2016, 'Visualízate (Gente de Zona)', true, 'Wikipedia (es/en); LOS40; RIAA/AllMusic (créditos de «Visualízate»)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'maffio' AND a.name = 'Latin Grammy' AND cat.name = 'Best Tropical Fusion Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2016);

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Latin Pop Song of the Year' FROM awards a WHERE a.name = 'Billboard Latin Music Awards'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Latin Pop Song of the Year');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2024, 'No es Normal', true, 'FAME Magazine; Telemundo (Facebook, oct 2024); Billboard (cobertura del evento)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'maffio' AND a.name = 'Billboard Latin Music Awards' AND cat.name = 'Latin Pop Song of the Year'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2024);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Maffio — Carlos Ariel Peralta Mendoza, born in Santo Domingo on 24 January 1986 — is a Dominican producer, songwriter and singer whose credits run through urban, tropical and pop music, three of them Latin Grammy Awards."}]},{"type":"paragraph","content":[{"type":"text","text":"Self-taught at six","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He taught himself piano at six, started writing songs at nine and producing at twelve, in a house where his influences ran from Bob Marley, Donna Summer and the Bee Gees to Camilo Sesto, Michael Jackson and Chuck Mangione. The name Maffio came from his father, who gave it to him as a boy for his fondness for mafia documentaries. At twenty he had his first international hit, producing «Mi alma se muere» for "},{"type":"artistReference","attrs":{"occurrenceId":"1300dba9-0f0e-405d-a8f9-ea12d0889ec7","artistId":"6159dc70-bd8f-439d-bf17-5d690262e5cb","displayText":"Omega"}},{"type":"text","text":" and Fuego (2008)."}]},{"type":"paragraph","content":[{"type":"text","text":"Behind other artists’ hits","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Working from his studio, «ReHab», in Miami, he built a run of production and writing credits through the 2010s: «Súper Estrella» ("},{"type":"artistReference","attrs":{"occurrenceId":"4ea6e760-0e66-4b41-9477-2cbf9a1a387c","artistId":"6159dc70-bd8f-439d-bf17-5d690262e5cb","displayText":"Omega"}},{"type":"text","text":" and Fuego, 2009), «Eres mi sueño» (Fonseca, 2011), «Ropa Puesta» (Gente de Zona, 2012), «Tú me quemas» (Chino y Nacho, 2015, later used in «Ride Along 2»), «Chillax» (Farruko, 2015), «Bajito» and «Baby» (Jencarlos Canela, 2015–16) and «Without You» (Nicky Jam, 2017). In 2019 he produced much of Akon’s album «El Negreeto», with guests including Anitta, Ozuna, Anuel AA, Farruko and Becky G. In 2015 the mayor of Miami, Tomás Regalado, gave him the keys to the city."}]},{"type":"paragraph","content":[{"type":"text","text":"As an artist","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His own singles began with «Si yo fuera él», with Joey Montana (2012), and «No te dejaré de amar» (2012), which reached number one on Billboard’s Tropical Songs chart; «No tengo dinero» (2013) and «Quiero otro amor» (2014) followed. In 2013 he produced and appeared on "},{"type":"artistReference","attrs":{"occurrenceId":"62395cd2-5b32-4900-ad9a-e74fba83b69c","artistId":"8dcfc4e1-9af4-4378-9e19-52573af429a7","displayText":"Henry Santos"}},{"type":"text","text":"’s «La vida», also a Tropical Airplay number one. He worked independently until 2019, when he signed with Sony Music Entertainment and released «Cristina», with Nacho, J Quiles and Shelow Shaq, and he later produced "},{"type":"artistReference","attrs":{"occurrenceId":"edc665b5-f163-446a-b78c-7dbec1034640","artistId":"af726afa-c7a0-47da-99bb-a4c7669a8785","displayText":"Natti Natasha"}},{"type":"text","text":"’s «No voy a llorar» (2019) and "},{"type":"artistReference","attrs":{"occurrenceId":"ff1f195b-84a6-472e-b571-3bde485baa38","artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo"}},{"type":"text","text":"’s «Carne» (2020). His albums as a solo artist are «TumbaGobierno» (2020) and «Eso es mental» (2022), and in 2020 he appeared on «PAM» alongside "},{"type":"artistReference","attrs":{"occurrenceId":"14cd3fd9-f1b4-4cb9-90b5-652023e4fcc6","artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa"}},{"type":"text","text":" and two American acts."}]},{"type":"paragraph","content":[{"type":"text","text":"Alkatraks","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In January 2021 Maffio founded the label «Alkatraks Music Group», signing "},{"type":"artistReference","attrs":{"occurrenceId":"e24d07bd-e3ce-42d8-b4dc-cbf2ccb9e892","artistId":"fba77e56-c658-46d5-a071-0fc87b2095fb","displayText":"Calacote"}},{"type":"text","text":" as its first artist and producing his debut single, «Azafata»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Maffio has won three Latin Grammy Awards as a producer — Best Tropical Fusion Album for Fonseca’s «Ilusión» (2012) and for Gente de Zona’s «Visualízate» (2016), and Best Traditional Pop Vocal Album for «Fonseca Sinfónico» (2014) — and, as an artist, the 2024 Billboard Latin Music Award for Latin Pop Song of the Year, with Nacho, for «No es normal». His work behind other artists’ records has carried more certifications, among them an 11-times-Diamond and multiple Platinum and Gold awards, than most of the acts he has recorded under his own name."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'maffio'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'maffio' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1300dba9-0f0e-405d-a8f9-ea12d0889ec7', 'artist', '6159dc70-bd8f-439d-bf17-5d690262e5cb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4ea6e760-0e66-4b41-9477-2cbf9a1a387c', 'artist', '6159dc70-bd8f-439d-bf17-5d690262e5cb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '62395cd2-5b32-4900-ad9a-e74fba83b69c', 'artist', '8dcfc4e1-9af4-4378-9e19-52573af429a7' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'edc665b5-f163-446a-b78c-7dbec1034640', 'artist', 'af726afa-c7a0-47da-99bb-a4c7669a8785' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ff1f195b-84a6-472e-b571-3bde485baa38', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '14cd3fd9-f1b4-4cb9-90b5-652023e4fcc6', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e24d07bd-e3ce-42d8-b4dc-cbf2ccb9e892', 'artist', 'fba77e56-c658-46d5-a071-0fc87b2095fb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Maffio — Carlos Ariel Peralta Mendoza, born in Santo Domingo on 24 January 1986 — is a Dominican producer, songwriter and singer whose credits run through urban, tropical and pop music, three of them Latin Grammy Awards.

**Self-taught at six**

He taught himself piano at six, started writing songs at nine and producing at twelve, in a house where his influences ran from Bob Marley, Donna Summer and the Bee Gees to Camilo Sesto, Michael Jackson and Chuck Mangione. The name Maffio came from his father, who gave it to him as a boy for his fondness for mafia documentaries. At twenty he had his first international hit, producing «Mi alma se muere» for Omega and Fuego (2008).

**Behind other artists’ hits**

Working from his studio, «ReHab», in Miami, he built a run of production and writing credits through the 2010s: «Súper Estrella» (Omega and Fuego, 2009), «Eres mi sueño» (Fonseca, 2011), «Ropa Puesta» (Gente de Zona, 2012), «Tú me quemas» (Chino y Nacho, 2015, later used in «Ride Along 2»), «Chillax» (Farruko, 2015), «Bajito» and «Baby» (Jencarlos Canela, 2015–16) and «Without You» (Nicky Jam, 2017). In 2019 he produced much of Akon’s album «El Negreeto», with guests including Anitta, Ozuna, Anuel AA, Farruko and Becky G. In 2015 the mayor of Miami, Tomás Regalado, gave him the keys to the city.

**As an artist**

His own singles began with «Si yo fuera él», with Joey Montana (2012), and «No te dejaré de amar» (2012), which reached number one on Billboard’s Tropical Songs chart; «No tengo dinero» (2013) and «Quiero otro amor» (2014) followed. In 2013 he produced and appeared on Henry Santos’s «La vida», also a Tropical Airplay number one. He worked independently until 2019, when he signed with Sony Music Entertainment and released «Cristina», with Nacho, J Quiles and Shelow Shaq, and he later produced Natti Natasha’s «No voy a llorar» (2019) and Don Miguelo’s «Carne» (2020). His albums as a solo artist are «TumbaGobierno» (2020) and «Eso es mental» (2022), and in 2020 he appeared on «PAM» alongside El Alfa and two American acts.

**Alkatraks**

In January 2021 Maffio founded the label «Alkatraks Music Group», signing Calacote as its first artist and producing his debut single, «Azafata».

**Legacy**

Maffio has won three Latin Grammy Awards as a producer — Best Tropical Fusion Album for Fonseca’s «Ilusión» (2012) and for Gente de Zona’s «Visualízate» (2016), and Best Traditional Pop Vocal Album for «Fonseca Sinfónico» (2014) — and, as an artist, the 2024 Billboard Latin Music Award for Latin Pop Song of the Year, with Nacho, for «No es normal». His work behind other artists’ records has carried more certifications, among them an 11-times-Diamond and multiple Platinum and Gold awards, than most of the acts he has recorded under his own name.' WHERE slug = 'maffio';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Maffio —Carlos Ariel Peralta Mendoza, nacido en Santo Domingo el 24 de enero de 1986— es un productor, compositor y cantante dominicano cuyos créditos recorren la música urbana, tropical y pop, tres de ellos con Latin Grammy."}]},{"type":"paragraph","content":[{"type":"text","text":"Autodidacta a los seis años","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Aprendió piano de forma autodidacta a los seis años, empezó a componer a los nueve y a producir a los doce, en una casa donde sus influencias iban de Bob Marley, Donna Summer y los Bee Gees a Camilo Sesto, Michael Jackson y Chuck Mangione. El nombre Maffio se lo puso su padre, de niño, por su afición a los documentales sobre la mafia. A los veinte años tuvo su primer éxito internacional, produciendo «Mi alma se muere» para "},{"type":"artistReference","attrs":{"occurrenceId":"a20e458b-9873-46dd-a84f-987ea52169da","artistId":"6159dc70-bd8f-439d-bf17-5d690262e5cb","displayText":"Omega"}},{"type":"text","text":" y Fuego (2008)."}]},{"type":"paragraph","content":[{"type":"text","text":"Detrás de los éxitos de otros","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Trabajando desde su estudio, «ReHab», en Miami, armó a lo largo de la década de 2010 una cadena de créditos de producción y composición: «Súper Estrella» ("},{"type":"artistReference","attrs":{"occurrenceId":"f4b327d0-5262-4222-ad12-33c1b86ca695","artistId":"6159dc70-bd8f-439d-bf17-5d690262e5cb","displayText":"Omega"}},{"type":"text","text":" y Fuego, 2009), «Eres mi sueño» (Fonseca, 2011), «Ropa Puesta» (Gente de Zona, 2012), «Tú me quemas» (Chino y Nacho, 2015, usada después en «Ride Along 2»), «Chillax» (Farruko, 2015), «Bajito» y «Baby» (Jencarlos Canela, 2015-16) y «Without You» (Nicky Jam, 2017). En 2019 produjo buena parte del álbum de Akon «El Negreeto», con invitados como Anitta, Ozuna, Anuel AA, Farruko y Becky G. En 2015 el alcalde de Miami, Tomás Regalado, le entregó las llaves de la ciudad."}]},{"type":"paragraph","content":[{"type":"text","text":"Como artista","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Sus sencillos propios empezaron con «Si yo fuera él», junto a Joey Montana (2012), y «No te dejaré de amar» (2012), que llegó al número uno de la lista Tropical Songs de Billboard; siguieron «No tengo dinero» (2013) y «Quiero otro amor» (2014). En 2013 produjo y participó en «La vida», de "},{"type":"artistReference","attrs":{"occurrenceId":"cb0bbd41-c184-40bc-9bbf-9982803af99c","artistId":"8dcfc4e1-9af4-4378-9e19-52573af429a7","displayText":"Henry Santos"}},{"type":"text","text":", también número uno en Tropical Airplay. Trabajó de manera independiente hasta 2019, cuando firmó con Sony Music Entertainment y lanzó «Cristina», con Nacho, J Quiles y Shelow Shaq, y después produjo «No voy a llorar» (2019), de "},{"type":"artistReference","attrs":{"occurrenceId":"25a458ee-6106-4365-97a3-2e04030721be","artistId":"af726afa-c7a0-47da-99bb-a4c7669a8785","displayText":"Natti Natasha"}},{"type":"text","text":", y «Carne» (2020), de "},{"type":"artistReference","attrs":{"occurrenceId":"3cf434d1-9900-4957-b519-750719fc7c21","artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo"}},{"type":"text","text":". Sus álbumes como solista son «TumbaGobierno» (2020) y «Eso es mental» (2022), y en 2020 apareció en «PAM» junto a "},{"type":"artistReference","attrs":{"occurrenceId":"d79cf808-674d-4c46-b788-42fcc3557b5e","artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa"}},{"type":"text","text":" y dos artistas estadounidenses."}]},{"type":"paragraph","content":[{"type":"text","text":"Alkatraks","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En enero de 2021 Maffio fundó el sello «Alkatraks Music Group», con "},{"type":"artistReference","attrs":{"occurrenceId":"ad9c484a-eb76-41a9-a1e1-12ae4eeb8546","artistId":"fba77e56-c658-46d5-a071-0fc87b2095fb","displayText":"Calacote"}},{"type":"text","text":" como primer artista firmado, y produjo su sencillo debut, «Azafata»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Maffio ha ganado tres Latin Grammy como productor —Mejor Álbum de Fusión Tropical por «Ilusión», de Fonseca (2012), y por «Visualízate», de Gente de Zona (2016), y Mejor Álbum Vocal Pop Tradicional por «Fonseca Sinfónico» (2014)— y, como artista, el Billboard Latin Music Award de 2024 a Canción Pop Latina del Año, junto a Nacho, por «No es normal». Su trabajo detrás de discos ajenos ha sumado más certificaciones —entre ellas un disco once veces Diamante y varios Platino y Oro— que la mayoría de los que ha grabado a su propio nombre."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'maffio'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'maffio' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a20e458b-9873-46dd-a84f-987ea52169da', 'artist', '6159dc70-bd8f-439d-bf17-5d690262e5cb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f4b327d0-5262-4222-ad12-33c1b86ca695', 'artist', '6159dc70-bd8f-439d-bf17-5d690262e5cb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cb0bbd41-c184-40bc-9bbf-9982803af99c', 'artist', '8dcfc4e1-9af4-4378-9e19-52573af429a7' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '25a458ee-6106-4365-97a3-2e04030721be', 'artist', 'af726afa-c7a0-47da-99bb-a4c7669a8785' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3cf434d1-9900-4957-b519-750719fc7c21', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd79cf808-674d-4c46-b788-42fcc3557b5e', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ad9c484a-eb76-41a9-a1e1-12ae4eeb8546', 'artist', 'fba77e56-c658-46d5-a071-0fc87b2095fb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'maffio' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Maffio —Carlos Ariel Peralta Mendoza, nacido en Santo Domingo el 24 de enero de 1986— es un productor, compositor y cantante dominicano cuyos créditos recorren la música urbana, tropical y pop, tres de ellos con Latin Grammy.

**Autodidacta a los seis años**

Aprendió piano de forma autodidacta a los seis años, empezó a componer a los nueve y a producir a los doce, en una casa donde sus influencias iban de Bob Marley, Donna Summer y los Bee Gees a Camilo Sesto, Michael Jackson y Chuck Mangione. El nombre Maffio se lo puso su padre, de niño, por su afición a los documentales sobre la mafia. A los veinte años tuvo su primer éxito internacional, produciendo «Mi alma se muere» para Omega y Fuego (2008).

**Detrás de los éxitos de otros**

Trabajando desde su estudio, «ReHab», en Miami, armó a lo largo de la década de 2010 una cadena de créditos de producción y composición: «Súper Estrella» (Omega y Fuego, 2009), «Eres mi sueño» (Fonseca, 2011), «Ropa Puesta» (Gente de Zona, 2012), «Tú me quemas» (Chino y Nacho, 2015, usada después en «Ride Along 2»), «Chillax» (Farruko, 2015), «Bajito» y «Baby» (Jencarlos Canela, 2015-16) y «Without You» (Nicky Jam, 2017). En 2019 produjo buena parte del álbum de Akon «El Negreeto», con invitados como Anitta, Ozuna, Anuel AA, Farruko y Becky G. En 2015 el alcalde de Miami, Tomás Regalado, le entregó las llaves de la ciudad.

**Como artista**

Sus sencillos propios empezaron con «Si yo fuera él», junto a Joey Montana (2012), y «No te dejaré de amar» (2012), que llegó al número uno de la lista Tropical Songs de Billboard; siguieron «No tengo dinero» (2013) y «Quiero otro amor» (2014). En 2013 produjo y participó en «La vida», de Henry Santos, también número uno en Tropical Airplay. Trabajó de manera independiente hasta 2019, cuando firmó con Sony Music Entertainment y lanzó «Cristina», con Nacho, J Quiles y Shelow Shaq, y después produjo «No voy a llorar» (2019), de Natti Natasha, y «Carne» (2020), de Don Miguelo. Sus álbumes como solista son «TumbaGobierno» (2020) y «Eso es mental» (2022), y en 2020 apareció en «PAM» junto a El Alfa y dos artistas estadounidenses.

**Alkatraks**

En enero de 2021 Maffio fundó el sello «Alkatraks Music Group», con Calacote como primer artista firmado, y produjo su sencillo debut, «Azafata».

**Legado**

Maffio ha ganado tres Latin Grammy como productor —Mejor Álbum de Fusión Tropical por «Ilusión», de Fonseca (2012), y por «Visualízate», de Gente de Zona (2016), y Mejor Álbum Vocal Pop Tradicional por «Fonseca Sinfónico» (2014)— y, como artista, el Billboard Latin Music Award de 2024 a Canción Pop Latina del Año, junto a Nacho, por «No es normal». Su trabajo detrás de discos ajenos ha sumado más certificaciones —entre ellas un disco once veces Diamante y varios Platino y Oro— que la mayoría de los que ha grabado a su propio nombre.' WHERE slug = 'maffio';

COMMIT;
