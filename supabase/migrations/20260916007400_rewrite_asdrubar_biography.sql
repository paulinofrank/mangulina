BEGIN;

-- Asdrúbar (Asdrúbar Stefan Báez Domínguez): salsero romántico de Villa Consuelo, no un 'músico de salsa y tropical' genérico. Fuentes: Diario Libre (24 ago. 2020, sencillo «Fue un ayer», 17 años de carrera, sello Yeray Music), El Nuevo Diario (entrevista, 30 ene. 2025), página de Facebook Guateque y Guaguancó (efemérides, 26 jul. 2025: fecha y lugar de nacimiento, nombre completo), su canal oficial de YouTube (títulos). Nacimiento 26 jul. 1979 sale de una sola página, sin segunda fuente: se atribuye en el texto. Conflicto: 17 años de carrera en 2020 (Diario Libre) frente a 'más de 15' en 2025 (Facebook): no se da año de inicio.

UPDATE artists SET first_name = 'Asdrúbar', middle_name = 'Stefan', last_name = 'Báez', second_last_name = 'Domínguez', date_of_birth = '1979-07-26'::date, province = 'Distrito Nacional' WHERE slug = 'asdrubar';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Asdrúbar —Asdrúbar Stefan Báez Domínguez— is a Dominican singer of romantic salsa from the Villa Consuelo neighborhood of Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"From Villa Consuelo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A salsa-history page on Facebook records that he was born on 26 July 1979 in Villa Consuelo and describes him as a recognized romantic salsa singer with more than fifteen years on stage. A fan channel says he chose salsa because it was the genre most heard in his neighborhood."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2020 the newspaper Diario Libre listed «Contigo», «Suelta mi mano» and «Viento de otoño» among his hits and gave him seventeen years in music. His official YouTube channel also carries «Crónica de un viejo amor». His label at the time was Yeray Music."}]},{"type":"paragraph","content":[{"type":"text","text":"«Fue un ayer»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In August 2020 he released «Fue un ayer», a salsa adaptation of a song by The Beatles that had been popularized in the country by "},{"type":"text","text":"Camboy Estévez"},{"type":"text","text":". The video was produced by Directive Films and by the singer himself. He said he hoped the single would return him to the radio stations and that he had eleven more songs ready. During the pandemic he was seen delivering help to DJs left without work."}]},{"type":"paragraph","content":[{"type":"text","text":"On stage","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He has sung in the Dominican community of New York and at events in Texas, and appeared among the salsa artists announced for a tribute to "},{"type":"artistReference","attrs":{"occurrenceId":"36eebf09-d8b0-45cf-a0e3-e066e9b71e5f","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":". In a January 2025 interview with El Nuevo Diario he said he does not record songs for the sake of it and that quality and feeling guide his interpretations."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His work belongs to the Dominican line of romantic salsa and is documented mainly through his own channels and a handful of press notes."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'asdrubar'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'asdrubar' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '36eebf09-d8b0-45cf-a0e3-e066e9b71e5f', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'asdrubar' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Asdrúbar —Asdrúbar Stefan Báez Domínguez— is a Dominican singer of romantic salsa from the Villa Consuelo neighborhood of Santo Domingo.

**From Villa Consuelo**

A salsa-history page on Facebook records that he was born on 26 July 1979 in Villa Consuelo and describes him as a recognized romantic salsa singer with more than fifteen years on stage. A fan channel says he chose salsa because it was the genre most heard in his neighborhood.

**Songs**

In 2020 the newspaper Diario Libre listed «Contigo», «Suelta mi mano» and «Viento de otoño» among his hits and gave him seventeen years in music. His official YouTube channel also carries «Crónica de un viejo amor». His label at the time was Yeray Music.

**«Fue un ayer»**

In August 2020 he released «Fue un ayer», a salsa adaptation of a song by The Beatles that had been popularized in the country by Camboy Estévez. The video was produced by Directive Films and by the singer himself. He said he hoped the single would return him to the radio stations and that he had eleven more songs ready. During the pandemic he was seen delivering help to DJs left without work.

**On stage**

He has sung in the Dominican community of New York and at events in Texas, and appeared among the salsa artists announced for a tribute to Cuco Valoy. In a January 2025 interview with El Nuevo Diario he said he does not record songs for the sake of it and that quality and feeling guide his interpretations.

**Legacy**

His work belongs to the Dominican line of romantic salsa and is documented mainly through his own channels and a handful of press notes.' WHERE slug = 'asdrubar';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Asdrúbar —Asdrúbar Stefan Báez Domínguez— es un cantante dominicano de salsa romántica del sector Villa Consuelo, en Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"Desde Villa Consuelo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Una página de historia de la salsa en Facebook registra que nació el 26 de julio de 1979 en Villa Consuelo y lo describe como un cantante reconocido de salsa romántica con más de quince años en los escenarios. Un canal de aficionados dice que eligió la salsa por ser el género que más se escuchaba en su barrio."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2020 el periódico Diario Libre citó «Contigo», «Suelta mi mano» y «Viento de otoño» entre sus éxitos y le atribuyó diecisiete años en la música. Su canal oficial de YouTube incluye además «Crónica de un viejo amor». Su sello entonces era Yeray Music."}]},{"type":"paragraph","content":[{"type":"text","text":"«Fue un ayer»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En agosto de 2020 lanzó «Fue un ayer», adaptación en salsa de una canción de The Beatles que había sido popularizada en el país por "},{"type":"text","text":"Camboy Estévez"},{"type":"text","text":". El video fue producido por Directive Films y por el propio cantante. Dijo que esperaba volver con el sencillo a las emisoras y que tenía once temas más preparados. Durante la pandemia se le vio llevando ayudas a DJs que se quedaron sin trabajo."}]},{"type":"paragraph","content":[{"type":"text","text":"En los escenarios","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ha cantado en la comunidad dominicana de Nueva York y en eventos de Texas, y figuró entre los salseros anunciados para un homenaje a "},{"type":"artistReference","attrs":{"occurrenceId":"5724aef7-3f8b-4b33-845a-f5fb2b4e1e3f","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":". En una entrevista de enero de 2025 con El Nuevo Diario dijo que no hace temas por hacerlos y que la calidad y el sentimiento guían sus interpretaciones."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su obra pertenece a la línea dominicana de la salsa romántica y está documentada sobre todo en sus propios canales y en unas pocas notas de prensa."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'asdrubar'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'asdrubar' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '5724aef7-3f8b-4b33-845a-f5fb2b4e1e3f', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'asdrubar' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Asdrúbar —Asdrúbar Stefan Báez Domínguez— es un cantante dominicano de salsa romántica del sector Villa Consuelo, en Santo Domingo.

**Desde Villa Consuelo**

Una página de historia de la salsa en Facebook registra que nació el 26 de julio de 1979 en Villa Consuelo y lo describe como un cantante reconocido de salsa romántica con más de quince años en los escenarios. Un canal de aficionados dice que eligió la salsa por ser el género que más se escuchaba en su barrio.

**Canciones**

En 2020 el periódico Diario Libre citó «Contigo», «Suelta mi mano» y «Viento de otoño» entre sus éxitos y le atribuyó diecisiete años en la música. Su canal oficial de YouTube incluye además «Crónica de un viejo amor». Su sello entonces era Yeray Music.

**«Fue un ayer»**

En agosto de 2020 lanzó «Fue un ayer», adaptación en salsa de una canción de The Beatles que había sido popularizada en el país por Camboy Estévez. El video fue producido por Directive Films y por el propio cantante. Dijo que esperaba volver con el sencillo a las emisoras y que tenía once temas más preparados. Durante la pandemia se le vio llevando ayudas a DJs que se quedaron sin trabajo.

**En los escenarios**

Ha cantado en la comunidad dominicana de Nueva York y en eventos de Texas, y figuró entre los salseros anunciados para un homenaje a Cuco Valoy. En una entrevista de enero de 2025 con El Nuevo Diario dijo que no hace temas por hacerlos y que la calidad y el sentimiento guían sus interpretaciones.

**Legado**

Su obra pertenece a la línea dominicana de la salsa romántica y está documentada sobre todo en sus propios canales y en unas pocas notas de prensa.' WHERE slug = 'asdrubar';

COMMIT;
