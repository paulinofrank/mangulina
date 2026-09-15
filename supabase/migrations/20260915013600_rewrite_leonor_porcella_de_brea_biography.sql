BEGIN;

-- Ficha de Leonor Porcella de Brea.
--
-- La biografía de relleno la presentaba como cantante ("her voice... made her a natural
-- interpreter"), contradiciendo los propios campos de la fila (primary_role lyricist,
-- occupations composer) y todas las fuentes externas: es compositora y letrista, nunca
-- intérprete. second_last_name: de Brea (nombre completo, ya usado en el campo name).

UPDATE artists SET second_last_name = 'de Brea' WHERE slug = 'leonor-porcella-de-brea';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Leonor Porcella de Brea — born 10 April 1940 in Santo Domingo — is a Dominican poet and composer, one of the most prolific songwriters in the country’s romantic songbook, known for writing hits other singers made famous rather than performing them herself."}]},{"type":"paragraph","content":[{"type":"text","text":"Sonia Silvestre’s turning point","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1971 she picked a teenage "},{"type":"artistReference","attrs":{"occurrenceId":"dcb407b5-8d8f-48a8-93e0-2f4c58cde92a","artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre"}},{"type":"text","text":" to sing her song «¿Dónde podré gritarte que te quiero?» at the fourth Festival de la Canción Dominicana. The performance placed second, launched Silvestre’s recording career, and became one of the most covered songs in the Dominican catalogue."}]},{"type":"paragraph","content":[{"type":"text","text":"Beyond the country","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her songs traveled further than most Dominican compositions of her generation: the Mexican singer José José recorded several of her titles, among them «Vive», which gave its name to his 1974 album."}]},{"type":"paragraph","content":[{"type":"text","text":"A career in festivals","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Ven y abrázame» reached the eighth Festival de la Canción Dominicana in February 1982, and songs such as «No hay distancia», «Cada vez otra vez» and «Ay amigo mío» remain part of the standard Dominican songbook, cited alongside the country’s other classic songwriters."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In March 2012 the Ministry of Culture honored her at the «Salón Nacional Eduardo Brito», and press coverage as recently as 2024 still holds her up as a benchmark for measuring new Dominican songwriters — a reputation built entirely on words and melodies handed to other people’s voices."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'leonor-porcella-de-brea'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'leonor-porcella-de-brea' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dcb407b5-8d8f-48a8-93e0-2f4c58cde92a', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leonor-porcella-de-brea' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Leonor Porcella de Brea — born 10 April 1940 in Santo Domingo — is a Dominican poet and composer, one of the most prolific songwriters in the country’s romantic songbook, known for writing hits other singers made famous rather than performing them herself.

**Sonia Silvestre’s turning point**

In 1971 she picked a teenage Sonia Silvestre to sing her song «¿Dónde podré gritarte que te quiero?» at the fourth Festival de la Canción Dominicana. The performance placed second, launched Silvestre’s recording career, and became one of the most covered songs in the Dominican catalogue.

**Beyond the country**

Her songs traveled further than most Dominican compositions of her generation: the Mexican singer José José recorded several of her titles, among them «Vive», which gave its name to his 1974 album.

**A career in festivals**

«Ven y abrázame» reached the eighth Festival de la Canción Dominicana in February 1982, and songs such as «No hay distancia», «Cada vez otra vez» and «Ay amigo mío» remain part of the standard Dominican songbook, cited alongside the country’s other classic songwriters.

**Legacy**

In March 2012 the Ministry of Culture honored her at the «Salón Nacional Eduardo Brito», and press coverage as recently as 2024 still holds her up as a benchmark for measuring new Dominican songwriters — a reputation built entirely on words and melodies handed to other people’s voices.' WHERE slug = 'leonor-porcella-de-brea';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Leonor Porcella de Brea —nacida el 10 de abril de 1940 en Santo Domingo— es poeta y compositora dominicana, una de las más prolíficas del cancionero romántico del país, conocida por escribir los éxitos que otros cantantes hicieron famosos y no por interpretarlos ella misma."}]},{"type":"paragraph","content":[{"type":"text","text":"El giro de Sonia Silvestre","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1971 escogió a una adolescente "},{"type":"artistReference","attrs":{"occurrenceId":"bf0271af-0d45-4d10-a44d-69ddcaf1318a","artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre"}},{"type":"text","text":" para cantar su tema «¿Dónde podré gritarte que te quiero?» en el cuarto Festival de la Canción Dominicana. La interpretación quedó en segundo lugar, lanzó la carrera discográfica de Silvestre y se convirtió en una de las canciones más versionadas del cancionero dominicano."}]},{"type":"paragraph","content":[{"type":"text","text":"Más allá del país","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Sus canciones viajaron más lejos que la mayoría de las composiciones dominicanas de su generación: el cantante mexicano José José grabó varios de sus temas, entre ellos «Vive», que le dio nombre a su álbum de 1974."}]},{"type":"paragraph","content":[{"type":"text","text":"Una carrera de festivales","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Ven y abrázame» llegó al octavo Festival de la Canción Dominicana, en febrero de 1982, y temas como «No hay distancia», «Cada vez otra vez» y «Ay amigo mío» siguen formando parte del cancionero dominicano de referencia, citados junto a los demás compositores clásicos del país."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En marzo de 2012 el Ministerio de Cultura la homenajeó en el «Salón Nacional Eduardo Brito», y la prensa, todavía en 2024, sigue usándola como vara de medir para las nuevas compositoras dominicanas —una reputación construida por completo sobre palabras y melodías entregadas a voces ajenas."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'leonor-porcella-de-brea'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'leonor-porcella-de-brea' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'bf0271af-0d45-4d10-a44d-69ddcaf1318a', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'leonor-porcella-de-brea' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Leonor Porcella de Brea —nacida el 10 de abril de 1940 en Santo Domingo— es poeta y compositora dominicana, una de las más prolíficas del cancionero romántico del país, conocida por escribir los éxitos que otros cantantes hicieron famosos y no por interpretarlos ella misma.

**El giro de Sonia Silvestre**

En 1971 escogió a una adolescente Sonia Silvestre para cantar su tema «¿Dónde podré gritarte que te quiero?» en el cuarto Festival de la Canción Dominicana. La interpretación quedó en segundo lugar, lanzó la carrera discográfica de Silvestre y se convirtió en una de las canciones más versionadas del cancionero dominicano.

**Más allá del país**

Sus canciones viajaron más lejos que la mayoría de las composiciones dominicanas de su generación: el cantante mexicano José José grabó varios de sus temas, entre ellos «Vive», que le dio nombre a su álbum de 1974.

**Una carrera de festivales**

«Ven y abrázame» llegó al octavo Festival de la Canción Dominicana, en febrero de 1982, y temas como «No hay distancia», «Cada vez otra vez» y «Ay amigo mío» siguen formando parte del cancionero dominicano de referencia, citados junto a los demás compositores clásicos del país.

**Legado**

En marzo de 2012 el Ministerio de Cultura la homenajeó en el «Salón Nacional Eduardo Brito», y la prensa, todavía en 2024, sigue usándola como vara de medir para las nuevas compositoras dominicanas —una reputación construida por completo sobre palabras y melodías entregadas a voces ajenas.' WHERE slug = 'leonor-porcella-de-brea';

COMMIT;
