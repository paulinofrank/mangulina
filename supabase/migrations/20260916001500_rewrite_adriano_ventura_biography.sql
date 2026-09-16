BEGIN;

-- Ficha de Adriano Ventura.
--
-- La biografía de relleno era completamente genérica, sin nombrar canción ni hecho real: en
-- realidad es uno de los pioneros documentados de la bachata dominicana y productor de la
-- primera grabación de su hermana Aridia Ventura.
-- birth_place ampliado de "Santiago de los Caballeros" a "Jacagua, Santiago de los
-- Caballeros" (mismo formato de la ficha de Aridia Ventura). primary_genre corregido de
-- merengue a bachata. genres vaciado (folklore sin respaldo en ninguna fuente).

UPDATE artists SET birth_place = 'Jacagua, Santiago de los Caballeros',
       primary_genre = 'bachata', genres = '{}'::text[]
       WHERE slug = 'adriano-ventura';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Adriano Ventura —born in the Santiago suburb of Jacagua, one of nine musical siblings that included his sister "},{"type":"artistReference","attrs":{"occurrenceId":"de2b0adf-bee3-47de-8b3b-541a5fce3c3e","artistId":"01db8904-c39e-428d-bbea-da4049a79ee6","displayText":"Aridia Ventura"}},{"type":"text","text":"— is a Dominican bachata singer and composer remembered as one of the genre’s earliest pioneers, and as the first bachata artist Santiago produced."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Novia Ajena»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1968 he wrote and recorded «La Novia Ajena», a bachata composed in the style and rhythm of the Mexican vals, which brought him considerable success in a genre then still taking shape alongside foundational figures like "},{"type":"artistReference","attrs":{"occurrenceId":"44fcacbc-2244-4ebb-9dad-1f674d06802c","artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"136bdaea-dd17-4614-b61b-a1ef476e7ea1","artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Launching his sister’s career","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1975 he produced Aridia Ventura’s first single, helping launch a career that would make her one of bachata’s leading female voices — even though he and others had reservations when she went on to sign a five-year contract with "},{"type":"artistReference","attrs":{"occurrenceId":"7cc96040-8137-47f9-a38a-74fdb025c3ed","artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena"}},{"type":"text","text":" of Radio Guarachita."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Still remembered today as the first bachatero Santiago ever produced, Adriano Ventura now lives in Manhattan, New York."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'adriano-ventura'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'adriano-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'de2b0adf-bee3-47de-8b3b-541a5fce3c3e', 'artist', '01db8904-c39e-428d-bbea-da4049a79ee6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'adriano-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '44fcacbc-2244-4ebb-9dad-1f674d06802c', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'adriano-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '136bdaea-dd17-4614-b61b-a1ef476e7ea1', 'artist', '5ceceef0-765d-4e01-8017-85422a263357' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'adriano-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '7cc96040-8137-47f9-a38a-74fdb025c3ed', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'adriano-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Adriano Ventura —born in the Santiago suburb of Jacagua, one of nine musical siblings that included his sister Aridia Ventura— is a Dominican bachata singer and composer remembered as one of the genre’s earliest pioneers, and as the first bachata artist Santiago produced.

**«La Novia Ajena»**

In 1968 he wrote and recorded «La Novia Ajena», a bachata composed in the style and rhythm of the Mexican vals, which brought him considerable success in a genre then still taking shape alongside foundational figures like José Manuel Calderón and Luis Segura.

**Launching his sister’s career**

In 1975 he produced Aridia Ventura’s first single, helping launch a career that would make her one of bachata’s leading female voices — even though he and others had reservations when she went on to sign a five-year contract with Radhamés Aracena of Radio Guarachita.

**Legacy**

Still remembered today as the first bachatero Santiago ever produced, Adriano Ventura now lives in Manhattan, New York.' WHERE slug = 'adriano-ventura';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Adriano Ventura —nacido en el suburbio de Jacagua, Santiago, uno de nueve hermanos músicos entre los que se encontraba su hermana "},{"type":"artistReference","attrs":{"occurrenceId":"57b5ed97-7e06-4f53-a325-444d8e177761","artistId":"01db8904-c39e-428d-bbea-da4049a79ee6","displayText":"Aridia Ventura"}},{"type":"text","text":"— es cantante y compositor dominicano de bachata, recordado como uno de los pioneros más tempranos del género y como el primer bachatero que tuvo Santiago."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Novia Ajena»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1968 escribió y grabó «La Novia Ajena», una bachata compuesta al estilo y ritmo del vals mexicano, que le dio un éxito considerable en un género que todavía se formaba junto a figuras fundacionales como "},{"type":"artistReference","attrs":{"occurrenceId":"1a0d78aa-6752-4f87-9832-fb6252fe3121","artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"07adfe6b-21e4-4aa4-8859-44b3e0750364","artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"El impulso a la carrera de su hermana","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1975 produjo el primer sencillo de Aridia Ventura, ayudando a lanzar una carrera que la convertiría en una de las voces femeninas líderes de la bachata — aunque él y otros tuvieron reservas cuando ella firmó después un contrato de cinco años con "},{"type":"artistReference","attrs":{"occurrenceId":"b6a9c077-783a-4851-877a-db56f926b764","artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena"}},{"type":"text","text":" de Radio Guarachita."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Recordado todavía hoy como el primer bachatero que tuvo Santiago, Adriano Ventura reside actualmente en Manhattan, Nueva York."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'adriano-ventura'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'adriano-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '57b5ed97-7e06-4f53-a325-444d8e177761', 'artist', '01db8904-c39e-428d-bbea-da4049a79ee6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'adriano-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '1a0d78aa-6752-4f87-9832-fb6252fe3121', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'adriano-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '07adfe6b-21e4-4aa4-8859-44b3e0750364', 'artist', '5ceceef0-765d-4e01-8017-85422a263357' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'adriano-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'b6a9c077-783a-4851-877a-db56f926b764', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'adriano-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Adriano Ventura —nacido en el suburbio de Jacagua, Santiago, uno de nueve hermanos músicos entre los que se encontraba su hermana Aridia Ventura— es cantante y compositor dominicano de bachata, recordado como uno de los pioneros más tempranos del género y como el primer bachatero que tuvo Santiago.

**«La Novia Ajena»**

En 1968 escribió y grabó «La Novia Ajena», una bachata compuesta al estilo y ritmo del vals mexicano, que le dio un éxito considerable en un género que todavía se formaba junto a figuras fundacionales como José Manuel Calderón y Luis Segura.

**El impulso a la carrera de su hermana**

En 1975 produjo el primer sencillo de Aridia Ventura, ayudando a lanzar una carrera que la convertiría en una de las voces femeninas líderes de la bachata — aunque él y otros tuvieron reservas cuando ella firmó después un contrato de cinco años con Radhamés Aracena de Radio Guarachita.

**Legado**

Recordado todavía hoy como el primer bachatero que tuvo Santiago, Adriano Ventura reside actualmente en Manhattan, Nueva York.' WHERE slug = 'adriano-ventura';

COMMIT;
