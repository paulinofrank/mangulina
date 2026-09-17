BEGIN;

-- Ficha de Grupo Rush.
--
-- El relleno no nombraba un solo integrante, canción ni año. formation_year=2009 (AllMusic).
-- Miriam Cruz y Teodoro Reyes, ambos con ficha publicada, enlazados.

UPDATE artists SET formation_year = 2009, occupations = '["musician","songwriter"]'::jsonb
       WHERE slug = 'grupo-rush';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Grupo Rush is a Dominican bachata group built around Damian Llauger and Cristian «Khriz» Sarmiento, who made their formal recording debut in 2009 — alongside fellow members Migz and Lenny — with the crossover single «Jasmine», released in both Spanish and English."}]},{"type":"paragraph","content":[{"type":"text","text":"«Jasmine» and «We on Fire»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Jasmine» became a top-ten hit on the Billboard Latin Tropical Airplay chart and led the group’s debut album, «We on Fire» (2009), which also produced the follow-up single «Mamita». «Jasmine» was later included on the compilation «Bachata #1’s, Vol. 3» (2010) alongside recordings by Aventura, Héctor Acosta and Ivy Queen. Before recording as Grupo Rush, Damian and Khriz had already performed together for several years, including a bachata duet with the merengue singer "},{"type":"artistReference","attrs":{"occurrenceId":"ea3a7c5c-35bc-4435-ac51-5d54dfb44479","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Stages and recognition","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The group performed at major festivals including the Festival del Merengue in the Dominican Republic, a festival in Colombia, the Dominican Independence Festival in Puerto Rico and the Calle Ocho Festival in Miami, and was reported at the time to have been nominated for Best New Artist or Group at the 2010 Premio Lo Nuestro."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Grupo Rush has continued performing and releasing music as a duo of Damian and Khriz into 2025 and 2026, including the single «Mi Orgullo, Parte 2» (2025) and «Cantinero», featuring "},{"type":"artistReference","attrs":{"occurrenceId":"05ba1be8-4926-48fd-9da8-c1f0a240aa76","artistId":"97aba7a6-2428-4540-8ddd-79ea8c487e36","displayText":"Teodoro Reyes"}},{"type":"text","text":", with regular appearances on Dominican television programs such as «De Extremo a Extremo»."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'grupo-rush'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'grupo-rush' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'ea3a7c5c-35bc-4435-ac51-5d54dfb44479', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'grupo-rush' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '05ba1be8-4926-48fd-9da8-c1f0a240aa76', 'artist', '97aba7a6-2428-4540-8ddd-79ea8c487e36' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'grupo-rush' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Grupo Rush is a Dominican bachata group built around Damian Llauger and Cristian «Khriz» Sarmiento, who made their formal recording debut in 2009 — alongside fellow members Migz and Lenny — with the crossover single «Jasmine», released in both Spanish and English.

**«Jasmine» and «We on Fire»**

«Jasmine» became a top-ten hit on the Billboard Latin Tropical Airplay chart and led the group’s debut album, «We on Fire» (2009), which also produced the follow-up single «Mamita». «Jasmine» was later included on the compilation «Bachata #1’s, Vol. 3» (2010) alongside recordings by Aventura, Héctor Acosta and Ivy Queen. Before recording as Grupo Rush, Damian and Khriz had already performed together for several years, including a bachata duet with the merengue singer Miriam Cruz.

**Stages and recognition**

The group performed at major festivals including the Festival del Merengue in the Dominican Republic, a festival in Colombia, the Dominican Independence Festival in Puerto Rico and the Calle Ocho Festival in Miami, and was reported at the time to have been nominated for Best New Artist or Group at the 2010 Premio Lo Nuestro.

**Legacy**

Grupo Rush has continued performing and releasing music as a duo of Damian and Khriz into 2025 and 2026, including the single «Mi Orgullo, Parte 2» (2025) and «Cantinero», featuring Teodoro Reyes, with regular appearances on Dominican television programs such as «De Extremo a Extremo».' WHERE slug = 'grupo-rush';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Grupo Rush es una agrupación dominicana de bachata construida alrededor de Damian Llauger y Cristian «Khriz» Sarmiento, que hicieron su debut discográfico formal en 2009 —junto a los también integrantes Migz y Lenny— con el sencillo cruzado «Jasmine», publicado en español e inglés."}]},{"type":"paragraph","content":[{"type":"text","text":"«Jasmine» y «We on Fire»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Jasmine» se convirtió en un éxito top diez del listado Billboard Latin Tropical Airplay y encabezó el álbum debut del grupo, «We on Fire» (2009), que produjo también el sencillo «Mamita». «Jasmine» fue incluida más tarde en la compilación «Bachata #1’s, Vol. 3» (2010), junto a grabaciones de Aventura, Héctor Acosta e Ivy Queen. Antes de grabar como Grupo Rush, Damian y Khriz ya habían actuado juntos durante varios años, incluyendo un dueto de bachata con la cantante de merengue "},{"type":"artistReference","attrs":{"occurrenceId":"a5c701f0-0659-43a3-b038-dfa70a902a90","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Escenarios y reconocimiento","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El grupo se presentó en festivales importantes como el Festival del Merengue en República Dominicana, un festival en Colombia, el Festival de la Independencia Dominicana en Puerto Rico y el Calle Ocho Festival de Miami, y en su momento se reportó su nominación a Mejor Artista o Grupo Revelación en el Premio Lo Nuestro 2010."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Grupo Rush ha seguido presentándose y publicando música como dúo formado por Damian y Khriz hacia 2025 y 2026, con sencillos como «Mi Orgullo, Parte 2» (2025) y «Cantinero», junto a "},{"type":"artistReference","attrs":{"occurrenceId":"d2de9ea9-f8c8-4626-a2ce-57b71814ae25","artistId":"97aba7a6-2428-4540-8ddd-79ea8c487e36","displayText":"Teodoro Reyes"}},{"type":"text","text":", además de apariciones regulares en programas de televisión dominicanos como «De Extremo a Extremo»."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'grupo-rush'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'grupo-rush' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'a5c701f0-0659-43a3-b038-dfa70a902a90', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'grupo-rush' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd2de9ea9-f8c8-4626-a2ce-57b71814ae25', 'artist', '97aba7a6-2428-4540-8ddd-79ea8c487e36' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'grupo-rush' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Grupo Rush es una agrupación dominicana de bachata construida alrededor de Damian Llauger y Cristian «Khriz» Sarmiento, que hicieron su debut discográfico formal en 2009 —junto a los también integrantes Migz y Lenny— con el sencillo cruzado «Jasmine», publicado en español e inglés.

**«Jasmine» y «We on Fire»**

«Jasmine» se convirtió en un éxito top diez del listado Billboard Latin Tropical Airplay y encabezó el álbum debut del grupo, «We on Fire» (2009), que produjo también el sencillo «Mamita». «Jasmine» fue incluida más tarde en la compilación «Bachata #1’s, Vol. 3» (2010), junto a grabaciones de Aventura, Héctor Acosta e Ivy Queen. Antes de grabar como Grupo Rush, Damian y Khriz ya habían actuado juntos durante varios años, incluyendo un dueto de bachata con la cantante de merengue Miriam Cruz.

**Escenarios y reconocimiento**

El grupo se presentó en festivales importantes como el Festival del Merengue en República Dominicana, un festival en Colombia, el Festival de la Independencia Dominicana en Puerto Rico y el Calle Ocho Festival de Miami, y en su momento se reportó su nominación a Mejor Artista o Grupo Revelación en el Premio Lo Nuestro 2010.

**Legado**

Grupo Rush ha seguido presentándose y publicando música como dúo formado por Damian y Khriz hacia 2025 y 2026, con sencillos como «Mi Orgullo, Parte 2» (2025) y «Cantinero», junto a Teodoro Reyes, además de apariciones regulares en programas de televisión dominicanos como «De Extremo a Extremo».' WHERE slug = 'grupo-rush';

COMMIT;
