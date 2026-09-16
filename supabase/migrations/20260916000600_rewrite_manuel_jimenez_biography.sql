BEGIN;

-- Ficha de Manuel Jiménez.
--
-- La biografía de relleno era completamente genérica y el primary_genre (merengue) no
-- correspondía a un cantautor de canción de autor/balada.
-- middle_name/second_last_name añadidos (de Jesús/Ortega). birth_place/province añadidos
-- (Sabana Grande, Cotuí/Sánchez Ramírez). primary_genre corregido a balada. occupations
-- ampliado con composer. Premios Casandra registrados: Cantante del Año (1990, 1994) y
-- Autor del Año (1992, 1994).

UPDATE artists SET middle_name = 'de Jesús', second_last_name = 'Ortega',
       birth_place = 'Sabana Grande, Cotuí', province = 'Sánchez Ramírez',
       primary_genre = 'balada', occupations = '["composer"]'::jsonb
       WHERE slug = 'manuel-jimenez';

INSERT INTO award_categories (award_id, name)
  SELECT 'ead83dcf-9e2c-4f69-a557-dad604716a5e', 'Cantante del Año'
  WHERE NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e' AND name = 'Cantante del Año');
INSERT INTO award_categories (award_id, name)
  SELECT 'ead83dcf-9e2c-4f69-a557-dad604716a5e', 'Autor del Año'
  WHERE NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e' AND name = 'Autor del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT a.id, 'ead83dcf-9e2c-4f69-a557-dad604716a5e', ac.id, 1990, NULL, true, 'Wikipedia (es); Diccionario Cultural Dominicano (FUNGLODE); El Nuevo Diario (2020); Listín Diario (2020)'
  FROM artists a, award_categories ac
  WHERE a.slug = 'manuel-jimenez' AND ac.award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e' AND ac.name = 'Cantante del Año';
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT a.id, 'ead83dcf-9e2c-4f69-a557-dad604716a5e', ac.id, 1992, NULL, true, 'Wikipedia (es); Diccionario Cultural Dominicano (FUNGLODE); El Nuevo Diario (2020); Listín Diario (2020)'
  FROM artists a, award_categories ac
  WHERE a.slug = 'manuel-jimenez' AND ac.award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e' AND ac.name = 'Autor del Año';
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT a.id, 'ead83dcf-9e2c-4f69-a557-dad604716a5e', ac.id, 1994, NULL, true, 'Wikipedia (es); Diccionario Cultural Dominicano (FUNGLODE); El Nuevo Diario (2020); Listín Diario (2020)'
  FROM artists a, award_categories ac
  WHERE a.slug = 'manuel-jimenez' AND ac.award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e' AND ac.name = 'Cantante del Año';
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT a.id, 'ead83dcf-9e2c-4f69-a557-dad604716a5e', ac.id, 1994, NULL, true, 'Wikipedia (es); Diccionario Cultural Dominicano (FUNGLODE); El Nuevo Diario (2020); Listín Diario (2020)'
  FROM artists a, award_categories ac
  WHERE a.slug = 'manuel-jimenez' AND ac.award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e' AND ac.name = 'Autor del Año';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manuel Jiménez —full name Manuel de Jesús Jiménez Ortega, born in the Sabana Grande section of Cotuí, Sánchez Ramírez, on 15 October 1952— is a Dominican singer-songwriter and, since 2020, a politician, best known for the ballad «Derroche»."}]},{"type":"paragraph","content":[{"type":"text","text":"«LUCUAM» and two educations","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He showed an early inclination for music, performing at school before moving to Santo Domingo. There he studied literature at the Universidad Autónoma de Santo Domingo and, at the same time, guitar and flute at the Academia Dominicana, joining and later directing the experimental music group «LUCUAM», where he developed as a composer of both romantic and socially conscious songs. He went on to earn a law degree at the Universidad Abierta Para Adultos."}]},{"type":"paragraph","content":[{"type":"text","text":"«Derroche»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Derroche», released in 1993, became his best-known song and, by his own account, the one that has given him the greatest satisfaction as a composer. It has been recorded by more than twenty international artists, was the theme song of the Argentine film «Caballos Desbocados», and was the first Dominican song translated into Cantonese, besides being rendered in Portuguese, French, Danish and English. Asked once by Mariasela Álvarez which song by another songwriter he wished he had written, "},{"type":"artistReference","attrs":{"occurrenceId":"e33c67d5-cfbc-440e-97ac-402c3a4ef6e1","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":" answered: «Derroche»."}]},{"type":"paragraph","content":[{"type":"text","text":"A song for every voice","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His catalogue has traveled widely through other performers’ voices: «Quién no Sabe de Amor» through "},{"type":"artistReference","attrs":{"occurrenceId":"88f1ddb8-bafe-4813-bec3-9829479f4f0f","artistId":"080c0205-8b66-4f16-915e-1d867acf82cc","displayText":"Maridalia Hernández"}},{"type":"text","text":", «Amor Casual» through "},{"type":"artistReference","attrs":{"occurrenceId":"ceb1378a-922e-4277-8361-901d6507c892","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":", «Con Agua y Sal» through both "},{"type":"artistReference","attrs":{"occurrenceId":"edda4302-8475-46ed-9097-0eb3471f9eb3","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":" and, decades later, "},{"type":"artistReference","attrs":{"occurrenceId":"72524aec-9261-4296-b4e3-66f0080f343c","artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera"}},{"type":"text","text":", «Dile Más» through "},{"type":"artistReference","attrs":{"occurrenceId":"6e2cdf2b-747e-4093-9b6c-4c85e39fad6b","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":", and «En Cuarentena» through "},{"type":"artistReference","attrs":{"occurrenceId":"d0317b9f-49e2-47cf-8fec-183328c8ec72","artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario"}},{"type":"text","text":". Abroad, the Colombian rapper Lisa M turned his «Súbeme el Radio» into the best-selling Latin rap single of 1993, winning an ASCAP Award in the United States. He represented the Dominican Republic four times at the OTI Song Festival, and two of his songs, «Guerembé» and «Santo Domingo Carnaval», were chosen as official Santo Domingo Carnival themes."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Jiménez entered politics at seventeen through the Movimiento Popular Dominicano, later serving on the Partido de la Liberación Dominicana’s central committee until his 2015 resignation and joining the Partido Revolucionario Moderno in 2019. He was a deputy in the National Congress and, in 2020, was elected mayor of Santo Domingo Este, a post he held until 2024, acknowledging along the way that his political career had cost him part of his musical following without ever making him abandon it."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manuel-jimenez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manuel-jimenez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'e33c67d5-cfbc-440e-97ac-402c3a4ef6e1', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '88f1ddb8-bafe-4813-bec3-9829479f4f0f', 'artist', '080c0205-8b66-4f16-915e-1d867acf82cc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'ceb1378a-922e-4277-8361-901d6507c892', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'edda4302-8475-46ed-9097-0eb3471f9eb3', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '72524aec-9261-4296-b4e3-66f0080f343c', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '6e2cdf2b-747e-4093-9b6c-4c85e39fad6b', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd0317b9f-49e2-47cf-8fec-183328c8ec72', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Manuel Jiménez —full name Manuel de Jesús Jiménez Ortega, born in the Sabana Grande section of Cotuí, Sánchez Ramírez, on 15 October 1952— is a Dominican singer-songwriter and, since 2020, a politician, best known for the ballad «Derroche».

**«LUCUAM» and two educations**

He showed an early inclination for music, performing at school before moving to Santo Domingo. There he studied literature at the Universidad Autónoma de Santo Domingo and, at the same time, guitar and flute at the Academia Dominicana, joining and later directing the experimental music group «LUCUAM», where he developed as a composer of both romantic and socially conscious songs. He went on to earn a law degree at the Universidad Abierta Para Adultos.

**«Derroche»**

«Derroche», released in 1993, became his best-known song and, by his own account, the one that has given him the greatest satisfaction as a composer. It has been recorded by more than twenty international artists, was the theme song of the Argentine film «Caballos Desbocados», and was the first Dominican song translated into Cantonese, besides being rendered in Portuguese, French, Danish and English. Asked once by Mariasela Álvarez which song by another songwriter he wished he had written, Juan Luis Guerra 4.40 answered: «Derroche».

**A song for every voice**

His catalogue has traveled widely through other performers’ voices: «Quién no Sabe de Amor» through Maridalia Hernández, «Amor Casual» through Wilfrido Vargas, «Con Agua y Sal» through both Miriam Cruz and, decades later, Eddy Herrera, «Dile Más» through Sergio Vargas, and «En Cuarentena» through Los Hermanos Rosario. Abroad, the Colombian rapper Lisa M turned his «Súbeme el Radio» into the best-selling Latin rap single of 1993, winning an ASCAP Award in the United States. He represented the Dominican Republic four times at the OTI Song Festival, and two of his songs, «Guerembé» and «Santo Domingo Carnaval», were chosen as official Santo Domingo Carnival themes.

**Legacy**

Jiménez entered politics at seventeen through the Movimiento Popular Dominicano, later serving on the Partido de la Liberación Dominicana’s central committee until his 2015 resignation and joining the Partido Revolucionario Moderno in 2019. He was a deputy in the National Congress and, in 2020, was elected mayor of Santo Domingo Este, a post he held until 2024, acknowledging along the way that his political career had cost him part of his musical following without ever making him abandon it.' WHERE slug = 'manuel-jimenez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manuel Jiménez —nombre completo Manuel de Jesús Jiménez Ortega, nacido en la sección Sabana Grande de Cotuí, Sánchez Ramírez, el 15 de octubre de 1952— es cantautor dominicano y, desde 2020, político, conocido sobre todo por la balada «Derroche»."}]},{"type":"paragraph","content":[{"type":"text","text":"«LUCUAM» y dos carreras universitarias","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Mostró inclinación por la música desde niño, actuando en su escuela antes de trasladarse a Santo Domingo. Allí estudió Letras en la Universidad Autónoma de Santo Domingo y, al mismo tiempo, guitarra y flauta en la Academia Dominicana, integrándose y luego dirigiendo el grupo de música experimental «LUCUAM», donde se desarrolló como compositor tanto de temática romántica como de contenido social. Más tarde obtuvo una licenciatura en Derecho en la Universidad Abierta Para Adultos."}]},{"type":"paragraph","content":[{"type":"text","text":"«Derroche»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Derroche», lanzada en 1993, se convirtió en su canción más conocida y, según él mismo, la que más satisfacciones le ha dado como compositor. Ha sido grabada por más de veinte artistas internacionales, fue tema de la película argentina «Caballos Desbocados», y fue la primera canción dominicana traducida al cantonés, además de versionarse en portugués, francés, danés e inglés. Cuando Mariasela Álvarez le preguntó una vez a "},{"type":"artistReference","attrs":{"occurrenceId":"f9e4c70e-38b4-4563-a9d6-3dd359bf9baf","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":" qué canción de otro compositor le hubiera gustado escribir a él, su respuesta fue: «Derroche»."}]},{"type":"paragraph","content":[{"type":"text","text":"Una canción para cada voz","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su catálogo ha viajado ampliamente en voces ajenas: «Quién no Sabe de Amor» en la de "},{"type":"artistReference","attrs":{"occurrenceId":"b13cce5f-2782-44a0-ba6b-838a0a1ef4c1","artistId":"080c0205-8b66-4f16-915e-1d867acf82cc","displayText":"Maridalia Hernández"}},{"type":"text","text":", «Amor Casual» en la de "},{"type":"artistReference","attrs":{"occurrenceId":"49db4fd2-9717-4433-84e3-83536e8a1876","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":", «Con Agua y Sal» en las de "},{"type":"artistReference","attrs":{"occurrenceId":"95d35ac6-812a-419b-b3e8-97652a8bb1b0","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":" y, décadas después, "},{"type":"artistReference","attrs":{"occurrenceId":"5586347b-8d5a-4e14-a67b-b82ffa4a9774","artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera"}},{"type":"text","text":", «Dile Más» en la de "},{"type":"artistReference","attrs":{"occurrenceId":"d610dd69-b8cd-4949-855c-ed96069ec3f0","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":", y «En Cuarentena» en la de "},{"type":"artistReference","attrs":{"occurrenceId":"6251819e-814d-4d2c-aac0-03ac79c9132d","artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario"}},{"type":"text","text":". En el extranjero, la rapera colombiana Lisa M convirtió su «Súbeme el Radio» en el sencillo de rap latino más vendido de 1993, ganador de un Premio ASCAP en Estados Unidos. Representó a República Dominicana cuatro veces en el Festival OTI de la Canción, y dos de sus temas, «Guerembé» y «Santo Domingo Carnaval», fueron elegidos canciones oficiales del Carnaval de Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Jiménez incursionó en la política a los diecisiete años a través del Movimiento Popular Dominicano, integró luego el comité central del Partido de la Liberación Dominicana hasta su renuncia en 2015, y se sumó al Partido Revolucionario Moderno en 2019. Fue diputado al Congreso Nacional y, en 2020, fue electo alcalde de Santo Domingo Este, cargo que ocupó hasta 2024, reconociendo en el camino que su carrera política le había costado parte de su público musical sin llegar nunca a apartarlo de ella."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manuel-jimenez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manuel-jimenez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'f9e4c70e-38b4-4563-a9d6-3dd359bf9baf', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'b13cce5f-2782-44a0-ba6b-838a0a1ef4c1', 'artist', '080c0205-8b66-4f16-915e-1d867acf82cc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '49db4fd2-9717-4433-84e3-83536e8a1876', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '95d35ac6-812a-419b-b3e8-97652a8bb1b0', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '5586347b-8d5a-4e14-a67b-b82ffa4a9774', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd610dd69-b8cd-4949-855c-ed96069ec3f0', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '6251819e-814d-4d2c-aac0-03ac79c9132d', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-jimenez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Manuel Jiménez —nombre completo Manuel de Jesús Jiménez Ortega, nacido en la sección Sabana Grande de Cotuí, Sánchez Ramírez, el 15 de octubre de 1952— es cantautor dominicano y, desde 2020, político, conocido sobre todo por la balada «Derroche».

**«LUCUAM» y dos carreras universitarias**

Mostró inclinación por la música desde niño, actuando en su escuela antes de trasladarse a Santo Domingo. Allí estudió Letras en la Universidad Autónoma de Santo Domingo y, al mismo tiempo, guitarra y flauta en la Academia Dominicana, integrándose y luego dirigiendo el grupo de música experimental «LUCUAM», donde se desarrolló como compositor tanto de temática romántica como de contenido social. Más tarde obtuvo una licenciatura en Derecho en la Universidad Abierta Para Adultos.

**«Derroche»**

«Derroche», lanzada en 1993, se convirtió en su canción más conocida y, según él mismo, la que más satisfacciones le ha dado como compositor. Ha sido grabada por más de veinte artistas internacionales, fue tema de la película argentina «Caballos Desbocados», y fue la primera canción dominicana traducida al cantonés, además de versionarse en portugués, francés, danés e inglés. Cuando Mariasela Álvarez le preguntó una vez a Juan Luis Guerra 4.40 qué canción de otro compositor le hubiera gustado escribir a él, su respuesta fue: «Derroche».

**Una canción para cada voz**

Su catálogo ha viajado ampliamente en voces ajenas: «Quién no Sabe de Amor» en la de Maridalia Hernández, «Amor Casual» en la de Wilfrido Vargas, «Con Agua y Sal» en las de Miriam Cruz y, décadas después, Eddy Herrera, «Dile Más» en la de Sergio Vargas, y «En Cuarentena» en la de Los Hermanos Rosario. En el extranjero, la rapera colombiana Lisa M convirtió su «Súbeme el Radio» en el sencillo de rap latino más vendido de 1993, ganador de un Premio ASCAP en Estados Unidos. Representó a República Dominicana cuatro veces en el Festival OTI de la Canción, y dos de sus temas, «Guerembé» y «Santo Domingo Carnaval», fueron elegidos canciones oficiales del Carnaval de Santo Domingo.

**Legado**

Jiménez incursionó en la política a los diecisiete años a través del Movimiento Popular Dominicano, integró luego el comité central del Partido de la Liberación Dominicana hasta su renuncia en 2015, y se sumó al Partido Revolucionario Moderno en 2019. Fue diputado al Congreso Nacional y, en 2020, fue electo alcalde de Santo Domingo Este, cargo que ocupó hasta 2024, reconociendo en el camino que su carrera política le había costado parte de su público musical sin llegar nunca a apartarlo de ella.' WHERE slug = 'manuel-jimenez';

COMMIT;
