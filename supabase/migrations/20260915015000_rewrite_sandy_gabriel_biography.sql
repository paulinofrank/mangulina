BEGIN;

-- Ficha de Sandy Gabriel.
--
-- La biografía de relleno decía que nació en Puerto Plata en 1974; nació en Nagua el 10 de
-- mayo de 1972 y se mudó a Puerto Plata a los nueve años (Wikipedia es, con referencias).
-- second_last_name: Difó. Dos premios registrados: Premio Nacional de Música (jazz) 2003 y
-- Soberano 2012 a Mejor Concierto del Año. El Combo Candela (agrupación de su padre) ya
-- estaba anotado desde la ficha de Jerry Vargas El Nazareno. Sócrates Gabriel no tiene
-- ficha: ver MUSICOS_PENDIENTES.md.

UPDATE artists SET second_last_name = 'Difó', birth_place = 'Nagua',
       province = 'María Trinidad Sánchez', date_of_birth = '1972-05-10', birth_year = 1972
 WHERE slug = 'sandy-gabriel';

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Concierto del Año' FROM awards a WHERE a.name = 'Premios Casandra'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Concierto del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2012, NULL, true, 'Ultimo Diario (11 ene 2012, nominaciones); Puerto Plata Digital y costanorteenlared.blogspot.com (15 mar 2012, victoria); LinkedIn (perfil propio) — todas contemporáneas dicen "Casandra", no "Soberano" (que no empezó hasta 2013; ver epocas-acroarte)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'sandy-gabriel' AND a.name = 'Premios Casandra' AND cat.name = 'Concierto del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2012);

INSERT INTO awards (name) SELECT 'Premio Nacional de Música' WHERE NOT EXISTS (SELECT 1 FROM awards WHERE name = 'Premio Nacional de Música');

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Jazz' FROM awards a WHERE a.name = 'Premio Nacional de Música'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Jazz');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2003, NULL, true, 'Wikipedia (es), con referencia'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'sandy-gabriel' AND a.name = 'Premio Nacional de Música' AND cat.name = 'Jazz'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2003);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Sandy Gabriel — Sandy Antonio Gabriel Difó, born 10 May 1972 in Nagua — is a Dominican saxophonist, composer and arranger who built the country’s clearest bridge between jazz and merengue from a base on the north coast."}]},{"type":"paragraph","content":[{"type":"text","text":"The Combo Candela","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He moved to Puerto Plata at nine; his interest in the saxophone came from his father, Sócrates Gabriel, who led the popular 1960s and ’70s group «Combo Candela». Sandy’s own early work was in jazz combos at Puerto Plata’s tourist hotels, where he began fusing jazz language with Dominican merengue."}]},{"type":"paragraph","content":[{"type":"text","text":"From Puerto Plata to the world","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He went on to play the Puerto Plata Jazz Festival and Puerto Rico’s Heineken Jazz Festival, sharing stages there with Néstor Torres, Tito Puente, Sérgio Mendes, Spyro Gyra, Paquito D’Rivera, Chucho Valdés, Dave Grusin, Lee Ritenour, Arturo Sandoval and Gonzalo Rubalcaba, and carried his own «PP Jazz Ensemble» to the Ramajay Jazz Festival in Trinidad and Tobago, Cuba’s Jazz Plaza, the Bahamas Jazz Festival and the Montreal Jazz Festival. In the Dominican Republic he has recorded and performed with "},{"type":"artistReference","attrs":{"occurrenceId":"e340824f-e0c5-4899-b587-3e992ee5a5e5","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"7781df4d-ad33-4fc7-814f-1bd8a4596d96","artistId":"da791d26-8bab-45e4-b7d1-f09314869f09","displayText":"Michel Camilo"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"b04d6438-d671-4dc0-8503-a6625fd6ec08","artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"ffbabc73-85de-4eb6-a2e0-22aa1d710060","artistId":"8769e02a-52d7-4818-ac19-e5dd46d7075f","displayText":"Juan Francisco Ordóñez"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"74d7fcd9-ca63-405d-a8c6-1ddec3f4921b","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":" and the percussionist "},{"type":"artistReference","attrs":{"occurrenceId":"bf161bd9-619e-4da5-a52d-cd419117acb4","artistId":"977db71a-8bf6-4006-a63d-5e604e99336c","displayText":"Guarionex Aquino Hijo"}},{"type":"text","text":", with whom he has repeatedly shared a bill."}]},{"type":"paragraph","content":[{"type":"text","text":"Awards, and the Teatro Nacional","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He won the 2003 Premio Nacional de Música in jazz and the 2012 Premios Casandra for Concierto del Año, and was the first Dominican jazz musician to bring an original show of his own to the Teatro Nacional. He has also taught saxophone, giving masterclasses for three straight years at the University of North Carolina and running clinics at Troy University in Alabama."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Two decades after leaving hotel lounges in Puerto Plata for international stages, Gabriel remains the Dominican north’s clearest jazz voice, still touring under the PP Jazz Ensemble name that carries his adopted city’s initials."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'sandy-gabriel'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'sandy-gabriel' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e340824f-e0c5-4899-b587-3e992ee5a5e5', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sandy-gabriel' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7781df4d-ad33-4fc7-814f-1bd8a4596d96', 'artist', 'da791d26-8bab-45e4-b7d1-f09314869f09' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sandy-gabriel' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b04d6438-d671-4dc0-8503-a6625fd6ec08', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sandy-gabriel' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ffbabc73-85de-4eb6-a2e0-22aa1d710060', 'artist', '8769e02a-52d7-4818-ac19-e5dd46d7075f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sandy-gabriel' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '74d7fcd9-ca63-405d-a8c6-1ddec3f4921b', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sandy-gabriel' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'bf161bd9-619e-4da5-a52d-cd419117acb4', 'artist', '977db71a-8bf6-4006-a63d-5e604e99336c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sandy-gabriel' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Sandy Gabriel — Sandy Antonio Gabriel Difó, born 10 May 1972 in Nagua — is a Dominican saxophonist, composer and arranger who built the country’s clearest bridge between jazz and merengue from a base on the north coast.

**The Combo Candela**

He moved to Puerto Plata at nine; his interest in the saxophone came from his father, Sócrates Gabriel, who led the popular 1960s and ’70s group «Combo Candela». Sandy’s own early work was in jazz combos at Puerto Plata’s tourist hotels, where he began fusing jazz language with Dominican merengue.

**From Puerto Plata to the world**

He went on to play the Puerto Plata Jazz Festival and Puerto Rico’s Heineken Jazz Festival, sharing stages there with Néstor Torres, Tito Puente, Sérgio Mendes, Spyro Gyra, Paquito D’Rivera, Chucho Valdés, Dave Grusin, Lee Ritenour, Arturo Sandoval and Gonzalo Rubalcaba, and carried his own «PP Jazz Ensemble» to the Ramajay Jazz Festival in Trinidad and Tobago, Cuba’s Jazz Plaza, the Bahamas Jazz Festival and the Montreal Jazz Festival. In the Dominican Republic he has recorded and performed with Juan Luis Guerra 4.40, Michel Camilo, Víctor Víctor, Juan Francisco Ordóñez, Chichi Peralta and the percussionist Guarionex Aquino Hijo, with whom he has repeatedly shared a bill.

**Awards, and the Teatro Nacional**

He won the 2003 Premio Nacional de Música in jazz and the 2012 Premios Casandra for Concierto del Año, and was the first Dominican jazz musician to bring an original show of his own to the Teatro Nacional. He has also taught saxophone, giving masterclasses for three straight years at the University of North Carolina and running clinics at Troy University in Alabama.

**Legacy**

Two decades after leaving hotel lounges in Puerto Plata for international stages, Gabriel remains the Dominican north’s clearest jazz voice, still touring under the PP Jazz Ensemble name that carries his adopted city’s initials.' WHERE slug = 'sandy-gabriel';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Sandy Gabriel —Sandy Antonio Gabriel Difó, nacido el 10 de mayo de 1972 en Nagua— es saxofonista, compositor y arreglista dominicano, quien construyó desde la costa norte el puente más claro del país entre el jazz y el merengue."}]},{"type":"paragraph","content":[{"type":"text","text":"El Combo Candela","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Se mudó a Puerto Plata a los nueve años; su interés por el saxofón le vino de su padre, Sócrates Gabriel, director del popular grupo de los sesenta y setenta «Combo Candela». Sus primeros trabajos fueron en combos de jazz en los hoteles turísticos de Puerto Plata, donde empezó a fusionar el lenguaje del jazz con el merengue dominicano."}]},{"type":"paragraph","content":[{"type":"text","text":"De Puerto Plata al mundo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Pasó a tocar en el Festival de Jazz de Puerto Plata y en el Heineken Jazz Festival de Puerto Rico, compartiendo allí escenario con Néstor Torres, Tito Puente, Sérgio Mendes, Spyro Gyra, Paquito D’Rivera, Chucho Valdés, Dave Grusin, Lee Ritenour, Arturo Sandoval y Gonzalo Rubalcaba, y llevó a su propio «PP Jazz Ensemble» al Ramajay Jazz Festival de Trinidad y Tobago, al Jazz Plaza de Cuba, al Bahamas Jazz Festival y al Festival de Jazz de Montreal. En República Dominicana ha grabado y tocado con "},{"type":"artistReference","attrs":{"occurrenceId":"a5e3272e-3bf6-40e9-807f-fbbc5641882b","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"99784eec-6cca-40aa-bf05-2e79386dbb14","artistId":"da791d26-8bab-45e4-b7d1-f09314869f09","displayText":"Michel Camilo"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"89538ae3-d9c3-4afb-8334-3ec0765e2fad","artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"4e2d3d82-37db-48c1-b987-14ff3c1df4e9","artistId":"8769e02a-52d7-4818-ac19-e5dd46d7075f","displayText":"Juan Francisco Ordóñez"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"6e67649d-73e8-4c4f-955e-c3cb88bda138","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":" y el percusionista "},{"type":"artistReference","attrs":{"occurrenceId":"292456a4-18bd-4db3-b5ea-68a21e47b528","artistId":"977db71a-8bf6-4006-a63d-5e604e99336c","displayText":"Guarionex Aquino Hijo"}},{"type":"text","text":", con quien ha compartido cartel en varias ocasiones."}]},{"type":"paragraph","content":[{"type":"text","text":"Premios, y el Teatro Nacional","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ganó el Premio Nacional de Música en jazz de 2003 y el Premio Casandra 2012 a Concierto del Año, y fue el primer jazzista dominicano en llevar un espectáculo propio y original al Teatro Nacional. También ha dado clases de saxofón, con masterclasses tres años seguidos en la Universidad de Carolina del Norte y clínicas en la Universidad de Troy, en Alabama."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Dos décadas después de dejar los lounges de hotel en Puerto Plata por escenarios internacionales, Gabriel sigue siendo la voz de jazz más clara del norte dominicano, todavía de gira bajo el nombre PP Jazz Ensemble, que lleva las iniciales de la ciudad que lo adoptó."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'sandy-gabriel'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'sandy-gabriel' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a5e3272e-3bf6-40e9-807f-fbbc5641882b', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sandy-gabriel' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '99784eec-6cca-40aa-bf05-2e79386dbb14', 'artist', 'da791d26-8bab-45e4-b7d1-f09314869f09' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sandy-gabriel' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '89538ae3-d9c3-4afb-8334-3ec0765e2fad', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sandy-gabriel' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4e2d3d82-37db-48c1-b987-14ff3c1df4e9', 'artist', '8769e02a-52d7-4818-ac19-e5dd46d7075f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sandy-gabriel' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6e67649d-73e8-4c4f-955e-c3cb88bda138', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sandy-gabriel' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '292456a4-18bd-4db3-b5ea-68a21e47b528', 'artist', '977db71a-8bf6-4006-a63d-5e604e99336c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sandy-gabriel' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Sandy Gabriel —Sandy Antonio Gabriel Difó, nacido el 10 de mayo de 1972 en Nagua— es saxofonista, compositor y arreglista dominicano, quien construyó desde la costa norte el puente más claro del país entre el jazz y el merengue.

**El Combo Candela**

Se mudó a Puerto Plata a los nueve años; su interés por el saxofón le vino de su padre, Sócrates Gabriel, director del popular grupo de los sesenta y setenta «Combo Candela». Sus primeros trabajos fueron en combos de jazz en los hoteles turísticos de Puerto Plata, donde empezó a fusionar el lenguaje del jazz con el merengue dominicano.

**De Puerto Plata al mundo**

Pasó a tocar en el Festival de Jazz de Puerto Plata y en el Heineken Jazz Festival de Puerto Rico, compartiendo allí escenario con Néstor Torres, Tito Puente, Sérgio Mendes, Spyro Gyra, Paquito D’Rivera, Chucho Valdés, Dave Grusin, Lee Ritenour, Arturo Sandoval y Gonzalo Rubalcaba, y llevó a su propio «PP Jazz Ensemble» al Ramajay Jazz Festival de Trinidad y Tobago, al Jazz Plaza de Cuba, al Bahamas Jazz Festival y al Festival de Jazz de Montreal. En República Dominicana ha grabado y tocado con Juan Luis Guerra 4.40, Michel Camilo, Víctor Víctor, Juan Francisco Ordóñez, Chichi Peralta y el percusionista Guarionex Aquino Hijo, con quien ha compartido cartel en varias ocasiones.

**Premios, y el Teatro Nacional**

Ganó el Premio Nacional de Música en jazz de 2003 y el Premio Casandra 2012 a Concierto del Año, y fue el primer jazzista dominicano en llevar un espectáculo propio y original al Teatro Nacional. También ha dado clases de saxofón, con masterclasses tres años seguidos en la Universidad de Carolina del Norte y clínicas en la Universidad de Troy, en Alabama.

**Legado**

Dos décadas después de dejar los lounges de hotel en Puerto Plata por escenarios internacionales, Gabriel sigue siendo la voz de jazz más clara del norte dominicano, todavía de gira bajo el nombre PP Jazz Ensemble, que lleva las iniciales de la ciudad que lo adoptó.' WHERE slug = 'sandy-gabriel';

COMMIT;
