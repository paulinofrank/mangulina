BEGIN;

-- Ficha de Duluc (José Duluc).
--
-- La biografía de relleno lo describía en términos genéricos, sin nombrar una sola canción
-- ni agrupación. date_of_birth: 6 de septiembre de 1958 (la fila decía 1957; coinciden su
-- propia biografía, Radio Cimarrona y Listín Diario en 1958).

UPDATE artists SET date_of_birth = '1958-09-06', birth_year = 1958 WHERE slug = 'duluc';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Duluc — José Duluc, born 6 September 1958 in Higüey — is a Dominican composer, folkloric percussionist and dancer, and one of the country’s most persistent researchers of its Afro-Dominican rhythms."}]},{"type":"paragraph","content":[{"type":"text","text":"From the Ballet Folklórico to «Transporte Urbano»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began formal music study at eleven in his native Higüey and spent 1980 to 1984 as a dancer with the Ballet Folklórico of the Universidad Autónoma de Santo Domingo. In 1982 he joined Luis “Terror” Días’s «Transporte Urbano» — alongside "},{"type":"artistReference","attrs":{"occurrenceId":"225f78e5-a922-440c-98db-05c942746875","artistId":"8769e02a-52d7-4818-ac19-e5dd46d7075f","displayText":"Juan Francisco Ordóñez"}},{"type":"text","text":" on guitar — on percussion, in the band widely credited with starting Dominican rock by building it out of merengue, mangulina, salve and other native rhythms rather than importing it."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs that outgrew him","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As a composer he has written past his own performances more than through them. «La Ciguapa», recorded by "},{"type":"artistReference","attrs":{"occurrenceId":"659f2123-e031-40a2-a228-745927e1fda5","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":", went gold and platinum; «Carnaval para gozar», first sung with "},{"type":"artistReference","attrs":{"occurrenceId":"a4e09296-e218-45ca-a8db-b4d9bca0e9f9","artistId":"080c0205-8b66-4f16-915e-1d867acf82cc","displayText":"Maridalia Hernández"}},{"type":"text","text":", was the official Dominican Carnival theme from 1997 to 1999 and was recorded again by "},{"type":"artistReference","attrs":{"occurrenceId":"928d0ef7-c9bb-4593-9360-33ecacd6a44a","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":"; «Pega’o de qué» went to «Diómedes y el Grupo Mío», and «El Caminante», which he recorded himself for «Música Raíz, Vol. 1», later turned up on the compilation «Música negra in the Americas»."}]},{"type":"paragraph","content":[{"type":"text","text":"His own groups","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He founded and led «Palemba», «Ga’Caribe» and «Domini-Can» — with which he released the albums «Pánico» and «A quién le creo» — and, more recently, «Los Guerreros del Fuego», whose electric-palo hit «El Animal» became a fixture of Santo Domingo’s nightclubs. Along the way he has catalogued more than fifty rhythms drawn from groups such as «El Combo de Higüey» and his own Domini-Can, the research side of a career spent as much in the field as on stage."}]},{"type":"paragraph","content":[{"type":"text","text":"On the road","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His music has traveled to the Festival Mundial de la Juventud in Moscow (1985), the Festival de Varadero in Havana (1987), Fenétre au Sud in Cergy, France (1996), the Festival Caribeño de Veracruz (1997), the Festival Washoi in Japan (2000) and the SOB club in New York (2005)."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Well past four decades in music, Duluc still leads «Los Guerreros del Fuego» and keeps working, by his own description, from the belief that the country’s roots survive in the everyday — the same conviction that has run through every group, every song and every rhythm he has chased since he first picked up an instrument in Higüey."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'duluc'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'duluc' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '225f78e5-a922-440c-98db-05c942746875', 'artist', '8769e02a-52d7-4818-ac19-e5dd46d7075f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'duluc' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '659f2123-e031-40a2-a228-745927e1fda5', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'duluc' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a4e09296-e218-45ca-a8db-b4d9bca0e9f9', 'artist', '080c0205-8b66-4f16-915e-1d867acf82cc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'duluc' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '928d0ef7-c9bb-4593-9360-33ecacd6a44a', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'duluc' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Duluc — José Duluc, born 6 September 1958 in Higüey — is a Dominican composer, folkloric percussionist and dancer, and one of the country’s most persistent researchers of its Afro-Dominican rhythms.

**From the Ballet Folklórico to «Transporte Urbano»**

He began formal music study at eleven in his native Higüey and spent 1980 to 1984 as a dancer with the Ballet Folklórico of the Universidad Autónoma de Santo Domingo. In 1982 he joined Luis “Terror” Días’s «Transporte Urbano» — alongside Juan Francisco Ordóñez on guitar — on percussion, in the band widely credited with starting Dominican rock by building it out of merengue, mangulina, salve and other native rhythms rather than importing it.

**Songs that outgrew him**

As a composer he has written past his own performances more than through them. «La Ciguapa», recorded by Chichi Peralta, went gold and platinum; «Carnaval para gozar», first sung with Maridalia Hernández, was the official Dominican Carnival theme from 1997 to 1999 and was recorded again by Sergio Vargas; «Pega’o de qué» went to «Diómedes y el Grupo Mío», and «El Caminante», which he recorded himself for «Música Raíz, Vol. 1», later turned up on the compilation «Música negra in the Americas».

**His own groups**

He founded and led «Palemba», «Ga’Caribe» and «Domini-Can» — with which he released the albums «Pánico» and «A quién le creo» — and, more recently, «Los Guerreros del Fuego», whose electric-palo hit «El Animal» became a fixture of Santo Domingo’s nightclubs. Along the way he has catalogued more than fifty rhythms drawn from groups such as «El Combo de Higüey» and his own Domini-Can, the research side of a career spent as much in the field as on stage.

**On the road**

His music has traveled to the Festival Mundial de la Juventud in Moscow (1985), the Festival de Varadero in Havana (1987), Fenétre au Sud in Cergy, France (1996), the Festival Caribeño de Veracruz (1997), the Festival Washoi in Japan (2000) and the SOB club in New York (2005).

**Legacy**

Well past four decades in music, Duluc still leads «Los Guerreros del Fuego» and keeps working, by his own description, from the belief that the country’s roots survive in the everyday — the same conviction that has run through every group, every song and every rhythm he has chased since he first picked up an instrument in Higüey.' WHERE slug = 'duluc';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Duluc —José Duluc, nacido el 6 de septiembre de 1958 en Higüey— es compositor, percusionista folclórico y bailarín dominicano, y uno de los investigadores más constantes del país en torno a sus ritmos afrodominicanos."}]},{"type":"paragraph","content":[{"type":"text","text":"Del Ballet Folklórico a «Transporte Urbano»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó sus estudios formales de música a los once años en su Higüey natal y pasó de 1980 a 1984 como bailarín del Ballet Folklórico de la Universidad Autónoma de Santo Domingo. En 1982 entró en «Transporte Urbano», de Luis «Terror» Días —junto a "},{"type":"artistReference","attrs":{"occurrenceId":"2d53c674-3d51-4b35-b99b-2a44962fbc24","artistId":"8769e02a-52d7-4818-ac19-e5dd46d7075f","displayText":"Juan Francisco Ordóñez"}},{"type":"text","text":" en la guitarra— como percusionista, en la banda a la que se le atribuye el inicio del rock dominicano por construirlo con merengue, mangulina, salve y otros ritmos propios en lugar de importarlo."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones que lo superaron","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Como compositor ha escrito más allá de sus propias interpretaciones que a través de ellas. «La Ciguapa», grabada por "},{"type":"artistReference","attrs":{"occurrenceId":"426a30e9-cd1e-4efc-8d17-0c6cccd5bfe0","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":", llegó a disco de oro y platino; «Carnaval para gozar», cantada primero junto a "},{"type":"artistReference","attrs":{"occurrenceId":"2b13d6c8-1f99-4fb4-aeec-c1dec2027de6","artistId":"080c0205-8b66-4f16-915e-1d867acf82cc","displayText":"Maridalia Hernández"}},{"type":"text","text":", fue el tema oficial del Carnaval Dominicano de 1997 a 1999 y la volvió a grabar "},{"type":"artistReference","attrs":{"occurrenceId":"61375fae-7154-4f02-88e5-004dc5cc12d5","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":"; «Pega’o de qué» pasó a manos de «Diómedes y el Grupo Mío», y «El Caminante», que grabó él mismo para «Música Raíz, Vol. 1», apareció después en la compilación «Música negra in the Americas»."}]},{"type":"paragraph","content":[{"type":"text","text":"Sus propias agrupaciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fundó y dirigió «Palemba», «Ga’Caribe» y «Domini-Can» —con la que sacó los discos «Pánico» y «A quién le creo»— y, más recientemente, «Los Guerreros del Fuego», cuyo éxito de palo eléctrico «El Animal» se volvió fijo en las discotecas de Santo Domingo. En el camino ha catalogado más de cincuenta ritmos tomados de grupos como «El Combo de Higüey» y su propio Domini-Can, el lado de investigación de una carrera repartida tanto en el campo como en el escenario."}]},{"type":"paragraph","content":[{"type":"text","text":"De gira","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su música ha viajado al Festival Mundial de la Juventud en Moscú (1985), al Festival de Varadero en La Habana (1987), a Fenétre au Sud en Cergy, Francia (1996), al Festival Caribeño de Veracruz (1997), al Festival Washoi en Japón (2000) y al club SOB de Nueva York (2005)."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Bien pasadas las cuatro décadas en la música, Duluc sigue al frente de «Los Guerreros del Fuego» y sigue trabajando, según él mismo, desde la convicción de que las raíces del país sobreviven en lo cotidiano —la misma que ha recorrido cada grupo, cada canción y cada ritmo que ha perseguido desde que tomó un instrumento por primera vez en Higüey."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'duluc'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'duluc' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2d53c674-3d51-4b35-b99b-2a44962fbc24', 'artist', '8769e02a-52d7-4818-ac19-e5dd46d7075f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'duluc' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '426a30e9-cd1e-4efc-8d17-0c6cccd5bfe0', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'duluc' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2b13d6c8-1f99-4fb4-aeec-c1dec2027de6', 'artist', '080c0205-8b66-4f16-915e-1d867acf82cc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'duluc' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '61375fae-7154-4f02-88e5-004dc5cc12d5', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'duluc' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Duluc —José Duluc, nacido el 6 de septiembre de 1958 en Higüey— es compositor, percusionista folclórico y bailarín dominicano, y uno de los investigadores más constantes del país en torno a sus ritmos afrodominicanos.

**Del Ballet Folklórico a «Transporte Urbano»**

Empezó sus estudios formales de música a los once años en su Higüey natal y pasó de 1980 a 1984 como bailarín del Ballet Folklórico de la Universidad Autónoma de Santo Domingo. En 1982 entró en «Transporte Urbano», de Luis «Terror» Días —junto a Juan Francisco Ordóñez en la guitarra— como percusionista, en la banda a la que se le atribuye el inicio del rock dominicano por construirlo con merengue, mangulina, salve y otros ritmos propios en lugar de importarlo.

**Canciones que lo superaron**

Como compositor ha escrito más allá de sus propias interpretaciones que a través de ellas. «La Ciguapa», grabada por Chichi Peralta, llegó a disco de oro y platino; «Carnaval para gozar», cantada primero junto a Maridalia Hernández, fue el tema oficial del Carnaval Dominicano de 1997 a 1999 y la volvió a grabar Sergio Vargas; «Pega’o de qué» pasó a manos de «Diómedes y el Grupo Mío», y «El Caminante», que grabó él mismo para «Música Raíz, Vol. 1», apareció después en la compilación «Música negra in the Americas».

**Sus propias agrupaciones**

Fundó y dirigió «Palemba», «Ga’Caribe» y «Domini-Can» —con la que sacó los discos «Pánico» y «A quién le creo»— y, más recientemente, «Los Guerreros del Fuego», cuyo éxito de palo eléctrico «El Animal» se volvió fijo en las discotecas de Santo Domingo. En el camino ha catalogado más de cincuenta ritmos tomados de grupos como «El Combo de Higüey» y su propio Domini-Can, el lado de investigación de una carrera repartida tanto en el campo como en el escenario.

**De gira**

Su música ha viajado al Festival Mundial de la Juventud en Moscú (1985), al Festival de Varadero en La Habana (1987), a Fenétre au Sud en Cergy, Francia (1996), al Festival Caribeño de Veracruz (1997), al Festival Washoi en Japón (2000) y al club SOB de Nueva York (2005).

**Legado**

Bien pasadas las cuatro décadas en la música, Duluc sigue al frente de «Los Guerreros del Fuego» y sigue trabajando, según él mismo, desde la convicción de que las raíces del país sobreviven en lo cotidiano —la misma que ha recorrido cada grupo, cada canción y cada ritmo que ha perseguido desde que tomó un instrumento por primera vez en Higüey.' WHERE slug = 'duluc';

COMMIT;
