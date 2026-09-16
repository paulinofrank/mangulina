BEGIN;

-- Ficha de Yoyito Cabrera.
--
-- La biografía de relleno lo describía en términos genéricos como "colorful figure" sin
-- nombrar una sola canción, grupo o hecho biográfico concreto.
-- birth_year/birth_place corregidos de 1928/Santo Domingo (MusicBrainz) a 1926/San José de
-- Los Llanos, San Pedro de Macorís -respaldado por más de una decena de fuentes
-- independientes coincidentes en fecha, lugar y detalles biográficos concretos ("El Guardia
-- con el Tolete", el exilio, el Combo Managuá-. Nombre real (George Cabrera) añadido a
-- first_name/last_name, vacíos hasta ahora. occupations ampliado con "comedian".

UPDATE artists SET birth_year = 1926, birth_place = 'San José de Los Llanos', province = 'San Pedro de Macorís',
       date_of_birth = '1926-09-13', first_name = 'George', last_name = 'Cabrera', occupations = '["comedian"]'::jsonb
       WHERE slug = 'yoyito-cabrera';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"George Cabrera, known as Yoyito Cabrera, was a Dominican merengue singer and comedian born in San José de Los Llanos, San Pedro de Macorís province, on 13 September 1926, remembered as the country’s first humorous-merengue singer to turn his songs into open political satire."}]},{"type":"paragraph","content":[{"type":"text","text":"A merengue of protest","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fronting his own group, Combo Managuá, Cabrera built a catalogue of comic songs — «Soy un Peje», «Ritmo Merembe», «Aquí no Hay Dinero», «Murió como un Campeón», «Pegapalo» and «Timoteo» among them — that often doubled as commentary on the government of the day, continuing a tradition of satirical verse that traced back to the nineteenth-century poet Juan Antonio Alix."}]},{"type":"paragraph","content":[{"type":"text","text":"Censorship and exile","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"That satire had consequences under both the Trujillo dictatorship and the Balaguer governments that followed: his merengue «El Guardia con el Tolete» was pulled from the country’s handful of radio stations and forced him into exile."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cabrera died in 1984, largely forgotten and, by most accounts, abandoned; decades later, his daughter Margarita Cabrera has kept his story alive through oral-history interviews, and historians researching Dominican merengue continue to name him alongside contemporaries like Tatico Henríquez and Joseíto Mateo as one of the genre’s overlooked pioneers."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'yoyito-cabrera'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'yoyito-cabrera' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'George Cabrera, known as Yoyito Cabrera, was a Dominican merengue singer and comedian born in San José de Los Llanos, San Pedro de Macorís province, on 13 September 1926, remembered as the country’s first humorous-merengue singer to turn his songs into open political satire.

**A merengue of protest**

Fronting his own group, Combo Managuá, Cabrera built a catalogue of comic songs — «Soy un Peje», «Ritmo Merembe», «Aquí no Hay Dinero», «Murió como un Campeón», «Pegapalo» and «Timoteo» among them — that often doubled as commentary on the government of the day, continuing a tradition of satirical verse that traced back to the nineteenth-century poet Juan Antonio Alix.

**Censorship and exile**

That satire had consequences under both the Trujillo dictatorship and the Balaguer governments that followed: his merengue «El Guardia con el Tolete» was pulled from the country’s handful of radio stations and forced him into exile.

**Legacy**

Cabrera died in 1984, largely forgotten and, by most accounts, abandoned; decades later, his daughter Margarita Cabrera has kept his story alive through oral-history interviews, and historians researching Dominican merengue continue to name him alongside contemporaries like Tatico Henríquez and Joseíto Mateo as one of the genre’s overlooked pioneers.' WHERE slug = 'yoyito-cabrera';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"George Cabrera, conocido como Yoyito Cabrera, fue cantante de merengue y humorista dominicano nacido en San José de Los Llanos, provincia San Pedro de Macorís, el 13 de septiembre de 1926, recordado como el primer merenguero humorístico del país en convertir sus canciones en sátira política abierta."}]},{"type":"paragraph","content":[{"type":"text","text":"Un merengue de protesta","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Al frente de su propia agrupación, el Combo Managuá, Cabrera construyó un catálogo de temas cómicos —«Soy un Peje», «Ritmo Merembe», «Aquí no Hay Dinero», «Murió como un Campeón», «Pegapalo» y «Timoteo», entre otros— que muchas veces funcionaban también como comentario sobre el gobierno de turno, continuando una tradición de verso satírico que se remontaba al poeta decimonónico Juan Antonio Alix."}]},{"type":"paragraph","content":[{"type":"text","text":"Censura y exilio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Esa sátira tuvo consecuencias tanto bajo la dictadura de Trujillo como bajo los gobiernos de Balaguer que le siguieron: su merengue «El Guardia con el Tolete» fue sacado de las pocas emisoras del país y lo llevó al exilio."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cabrera murió en 1984, prácticamente olvidado y, según casi todos los relatos, abandonado; décadas después, su hija Margarita Cabrera ha mantenido viva su historia a través de entrevistas de historia oral, y los investigadores del merengue dominicano lo siguen mencionando junto a contemporáneos como Tatico Henríquez y Joseíto Mateo como uno de los pioneros olvidados del género."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'yoyito-cabrera'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'yoyito-cabrera' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'George Cabrera, conocido como Yoyito Cabrera, fue cantante de merengue y humorista dominicano nacido en San José de Los Llanos, provincia San Pedro de Macorís, el 13 de septiembre de 1926, recordado como el primer merenguero humorístico del país en convertir sus canciones en sátira política abierta.

**Un merengue de protesta**

Al frente de su propia agrupación, el Combo Managuá, Cabrera construyó un catálogo de temas cómicos —«Soy un Peje», «Ritmo Merembe», «Aquí no Hay Dinero», «Murió como un Campeón», «Pegapalo» y «Timoteo», entre otros— que muchas veces funcionaban también como comentario sobre el gobierno de turno, continuando una tradición de verso satírico que se remontaba al poeta decimonónico Juan Antonio Alix.

**Censura y exilio**

Esa sátira tuvo consecuencias tanto bajo la dictadura de Trujillo como bajo los gobiernos de Balaguer que le siguieron: su merengue «El Guardia con el Tolete» fue sacado de las pocas emisoras del país y lo llevó al exilio.

**Legado**

Cabrera murió en 1984, prácticamente olvidado y, según casi todos los relatos, abandonado; décadas después, su hija Margarita Cabrera ha mantenido viva su historia a través de entrevistas de historia oral, y los investigadores del merengue dominicano lo siguen mencionando junto a contemporáneos como Tatico Henríquez y Joseíto Mateo como uno de los pioneros olvidados del género.' WHERE slug = 'yoyito-cabrera';

COMMIT;
