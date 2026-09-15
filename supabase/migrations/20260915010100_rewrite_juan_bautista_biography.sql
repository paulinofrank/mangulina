BEGIN;

-- Ficha de Juan Bautista.
--
-- Lugar de nacimiento: la fila decía Salcedo / Hermanas Mirabal (Cibao); todas las fuentes
-- coinciden en Batey 8, Tamayo, provincia Bahoruco (Sur). Corregido.
-- occupations: songwriter (sustituye musician, composer). El Solterito del Sur y Cristóbal
-- Acosta anotados en ARTISTAS_FALTANTES.md / MUSICOS_PENDIENTES.md; no tienen ficha.

UPDATE artists SET first_name = 'Juan', middle_name = 'Bautista', last_name = 'Ramírez',
       second_last_name = 'Romero', birth_place = 'Batey 8, Tamayo', province = 'Bahoruco',
       occupations = '["songwriter"]'::jsonb
 WHERE slug = 'juan-bautista';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Bautista — Juan Bautista Ramírez Romero, born on 24 June 1955 in Batey 8, in the municipality of Tamayo, Bahoruco province — was a Dominican bachata singer and songwriter known as El Destroza Corazones, one of the most popular bachateros of the late 1980s and the 1990s."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los Cibernéticos»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In the late 1970s he joined «Los Dominicanos del Ritmo», the group soon known as «Los Cibernéticos», where he shared the stage with figures of cabaret-era bachata such as "},{"type":"artistReference","attrs":{"occurrenceId":"1ec8fbca-2770-4154-a5bd-20eb18d5698a","artistId":"e6aee4de-d994-481c-9d46-83b91a393c44","displayText":"Tony Santos"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"29e7865f-6019-4cc8-bdce-13f77cb93ee2","artistId":"8faf8748-31f9-4dbc-bfe1-d5b7fd70244e","displayText":"Marino Pérez"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Solo years","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"At the end of the 1980s and into the 1990s he stepped out as a soloist and built the catalogue that made his name: «Asesina sin matar», «Estoy aquí, pero no soy yo», «Hijo sin padre», «La casita de mi madre», «Rochy», «La puerta romperé», «La tristeza», «Traición de amigos» and «La ruta desaparecida». In the same decade "},{"type":"artistReference","attrs":{"occurrenceId":"84a89275-10c5-4351-b38d-0a2dfd51c80a","artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena"}},{"type":"text","text":" repeatedly re-recorded his hits at «Radio Guarachita» with a singer billed as El Solterito del Sur, to the point that the copies became better known than the originals. "},{"type":"artistReference","attrs":{"occurrenceId":"4ea25ce5-d906-472e-880c-906d9220bdc4","artistId":"8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6","displayText":"El Chaval de la Bachata"}},{"type":"text","text":" later recorded one of his songs as a tribute."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His signature line, by the account of the broadcaster Amado Vargas, who had introduced him on stage for years, was «Dios mío, esto sí es grande.» His later years were marked by heavy drinking and poverty, and Vargas was the one who confirmed his death, on 21 December 2013, to the Dominican press. He remains one of the voices most closely tied to the amargue style of bachata’s cabaret period."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-bautista'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-bautista' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1ec8fbca-2770-4154-a5bd-20eb18d5698a', 'artist', 'e6aee4de-d994-481c-9d46-83b91a393c44' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-bautista' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '29e7865f-6019-4cc8-bdce-13f77cb93ee2', 'artist', '8faf8748-31f9-4dbc-bfe1-d5b7fd70244e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-bautista' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '84a89275-10c5-4351-b38d-0a2dfd51c80a', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-bautista' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4ea25ce5-d906-472e-880c-906d9220bdc4', 'artist', '8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-bautista' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Juan Bautista — Juan Bautista Ramírez Romero, born on 24 June 1955 in Batey 8, in the municipality of Tamayo, Bahoruco province — was a Dominican bachata singer and songwriter known as El Destroza Corazones, one of the most popular bachateros of the late 1980s and the 1990s.

**«Los Cibernéticos»**

In the late 1970s he joined «Los Dominicanos del Ritmo», the group soon known as «Los Cibernéticos», where he shared the stage with figures of cabaret-era bachata such as Tony Santos and Marino Pérez.

**Solo years**

At the end of the 1980s and into the 1990s he stepped out as a soloist and built the catalogue that made his name: «Asesina sin matar», «Estoy aquí, pero no soy yo», «Hijo sin padre», «La casita de mi madre», «Rochy», «La puerta romperé», «La tristeza», «Traición de amigos» and «La ruta desaparecida». In the same decade Radhamés Aracena repeatedly re-recorded his hits at «Radio Guarachita» with a singer billed as El Solterito del Sur, to the point that the copies became better known than the originals. El Chaval de la Bachata later recorded one of his songs as a tribute.

**Legacy**

His signature line, by the account of the broadcaster Amado Vargas, who had introduced him on stage for years, was «Dios mío, esto sí es grande.» His later years were marked by heavy drinking and poverty, and Vargas was the one who confirmed his death, on 21 December 2013, to the Dominican press. He remains one of the voices most closely tied to the amargue style of bachata’s cabaret period.' WHERE slug = 'juan-bautista';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Bautista —Juan Bautista Ramírez Romero, nacido el 24 de junio de 1955 en Batey 8, municipio de Tamayo, provincia Bahoruco— fue un cantante y compositor dominicano de bachata conocido como El Destroza Corazones, uno de los bachateros más populares de finales de los ochenta y los noventa."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los Cibernéticos»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A finales de los setenta entró en «Los Dominicanos del Ritmo», el grupo que pronto se conoció como «Los Cibernéticos», donde compartió escenario con figuras de la bachata de cabaret como "},{"type":"artistReference","attrs":{"occurrenceId":"2449fb69-d9a6-4ab1-a91b-dd723475b333","artistId":"e6aee4de-d994-481c-9d46-83b91a393c44","displayText":"Tony Santos"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"09b0bba6-1313-47b4-8f24-f66b51167e8f","artistId":"8faf8748-31f9-4dbc-bfe1-d5b7fd70244e","displayText":"Marino Pérez"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Los años de solista","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A finales de los ochenta y en los noventa dio el paso al frente como solista y armó el repertorio que le dio nombre: «Asesina sin matar», «Estoy aquí, pero no soy yo», «Hijo sin padre», «La casita de mi madre», «Rochy», «La puerta romperé», «La tristeza», «Traición de amigos» y «La ruta desaparecida». En esa misma década "},{"type":"artistReference","attrs":{"occurrenceId":"5831b964-07fc-49a5-a18e-213ae373900e","artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena"}},{"type":"text","text":" regrabó repetidamente sus éxitos en «Radio Guarachita» con un cantante acreditado como El Solterito del Sur, al punto de que las copias llegaron a conocerse más que los originales. "},{"type":"artistReference","attrs":{"occurrenceId":"fcbcf7f3-fb7e-4cac-9379-dc89be3a311e","artistId":"8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6","displayText":"El Chaval de la Bachata"}},{"type":"text","text":" grabó después una de sus canciones como homenaje."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su frase distintiva, según el locutor Amado Vargas, que fue su presentador durante años, era «Dios mío, esto sí es grande.» Sus últimos años estuvieron marcados por el alcohol y la pobreza, y fue el propio Vargas quien confirmó a la prensa dominicana su muerte, el 21 de diciembre de 2013. Sigue siendo una de las voces más asociadas al amargue de la bachata de cabaret."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-bautista'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-bautista' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2449fb69-d9a6-4ab1-a91b-dd723475b333', 'artist', 'e6aee4de-d994-481c-9d46-83b91a393c44' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-bautista' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '09b0bba6-1313-47b4-8f24-f66b51167e8f', 'artist', '8faf8748-31f9-4dbc-bfe1-d5b7fd70244e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-bautista' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5831b964-07fc-49a5-a18e-213ae373900e', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-bautista' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'fcbcf7f3-fb7e-4cac-9379-dc89be3a311e', 'artist', '8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-bautista' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Juan Bautista —Juan Bautista Ramírez Romero, nacido el 24 de junio de 1955 en Batey 8, municipio de Tamayo, provincia Bahoruco— fue un cantante y compositor dominicano de bachata conocido como El Destroza Corazones, uno de los bachateros más populares de finales de los ochenta y los noventa.

**«Los Cibernéticos»**

A finales de los setenta entró en «Los Dominicanos del Ritmo», el grupo que pronto se conoció como «Los Cibernéticos», donde compartió escenario con figuras de la bachata de cabaret como Tony Santos y Marino Pérez.

**Los años de solista**

A finales de los ochenta y en los noventa dio el paso al frente como solista y armó el repertorio que le dio nombre: «Asesina sin matar», «Estoy aquí, pero no soy yo», «Hijo sin padre», «La casita de mi madre», «Rochy», «La puerta romperé», «La tristeza», «Traición de amigos» y «La ruta desaparecida». En esa misma década Radhamés Aracena regrabó repetidamente sus éxitos en «Radio Guarachita» con un cantante acreditado como El Solterito del Sur, al punto de que las copias llegaron a conocerse más que los originales. El Chaval de la Bachata grabó después una de sus canciones como homenaje.

**Legado**

Su frase distintiva, según el locutor Amado Vargas, que fue su presentador durante años, era «Dios mío, esto sí es grande.» Sus últimos años estuvieron marcados por el alcohol y la pobreza, y fue el propio Vargas quien confirmó a la prensa dominicana su muerte, el 21 de diciembre de 2013. Sigue siendo una de las voces más asociadas al amargue de la bachata de cabaret.' WHERE slug = 'juan-bautista';

COMMIT;
