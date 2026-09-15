BEGIN;

-- Ficha de Luny (Francisco Saldaña).
--
-- La biografía de relleno especulaba sobre su "sensibilidad dominicana" sin un solo hecho.
-- Fecha de nacimiento: la fila decía 18 de junio; corregida a 23 (Wikipedia, AllMusic,
-- Last.fm, NNDB, Musica.com). La trayectoria compartida con Tunes ya está contada en la ficha
-- de Luny Tunes; aquí solo lo distintivo de Luny: la adolescencia en San Juan.

UPDATE artists SET date_of_birth = date_of_birth + interval '5 days' WHERE slug = 'luny';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Luny — Francisco Saldaña, born in the Dominican Republic on 23 June 1979 — is a record producer, one half of "},{"type":"artistReference","attrs":{"occurrenceId":"39ab4c5d-08ef-4b6e-80c5-5fba9ae78813","artistId":"ef56311a-ac4b-451e-a7a7-97e5f240cd47","displayText":"Luny Tunes"}},{"type":"text","text":", the duo that, with "},{"type":"artistReference","attrs":{"occurrenceId":"5091aa25-1589-49c7-b49e-83e1372d08c1","artistId":"f78661d2-7e96-48b7-baf3-fd99a94d10e6","displayText":"Tunes"}},{"type":"text","text":", gave reggaeton its studio-album template in the early 2000s."}]},{"type":"paragraph","content":[{"type":"text","text":"San Juan","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Before Massachusetts, where his family later settled and where he met "},{"type":"artistReference","attrs":{"occurrenceId":"1c62bca5-87de-4601-bbb5-78d1931510b7","artistId":"f78661d2-7e96-48b7-baf3-fd99a94d10e6","displayText":"Tunes"}},{"type":"text","text":", Saldaña spent part of his adolescence in a barrio of San Juan, Puerto Rico, immersed in the city’s underground scene — the same underground that produced reggaeton itself. A scholarly study of the genre singles him out for that immersion, distinct from "},{"type":"artistReference","attrs":{"occurrenceId":"f1fece33-736a-4326-9c78-ecbbd7b942e0","artistId":"f78661d2-7e96-48b7-baf3-fd99a94d10e6","displayText":"Tunes"}},{"type":"text","text":"’s own path into the partnership."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The work Saldaña built with "},{"type":"artistReference","attrs":{"occurrenceId":"cde51daa-0d5c-482c-aab4-6a01750b6d90","artistId":"f78661d2-7e96-48b7-baf3-fd99a94d10e6","displayText":"Tunes"}},{"type":"text","text":" — from «Mas Flow» in 2003 to «Gasolina» and the double run of «Mas Flow 2» — is a shared one, told in full under "},{"type":"artistReference","attrs":{"occurrenceId":"97b3343c-b75f-4729-9ed7-cf63eb01af43","artistId":"ef56311a-ac4b-451e-a7a7-97e5f240cd47","displayText":"Luny Tunes"}},{"type":"text","text":". What belongs to him alone is the route that brought him to it: Dominican Republic to San Juan to Massachusetts, arriving at reggaeton’s production side by way of its street side."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luny'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'luny' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '39ab4c5d-08ef-4b6e-80c5-5fba9ae78813', 'artist', 'ef56311a-ac4b-451e-a7a7-97e5f240cd47' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5091aa25-1589-49c7-b49e-83e1372d08c1', 'artist', 'f78661d2-7e96-48b7-baf3-fd99a94d10e6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1c62bca5-87de-4601-bbb5-78d1931510b7', 'artist', 'f78661d2-7e96-48b7-baf3-fd99a94d10e6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f1fece33-736a-4326-9c78-ecbbd7b942e0', 'artist', 'f78661d2-7e96-48b7-baf3-fd99a94d10e6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cde51daa-0d5c-482c-aab4-6a01750b6d90', 'artist', 'f78661d2-7e96-48b7-baf3-fd99a94d10e6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '97b3343c-b75f-4729-9ed7-cf63eb01af43', 'artist', 'ef56311a-ac4b-451e-a7a7-97e5f240cd47' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Luny — Francisco Saldaña, born in the Dominican Republic on 23 June 1979 — is a record producer, one half of Luny Tunes, the duo that, with Tunes, gave reggaeton its studio-album template in the early 2000s.

**San Juan**

Before Massachusetts, where his family later settled and where he met Tunes, Saldaña spent part of his adolescence in a barrio of San Juan, Puerto Rico, immersed in the city’s underground scene — the same underground that produced reggaeton itself. A scholarly study of the genre singles him out for that immersion, distinct from Tunes’s own path into the partnership.

**Legacy**

The work Saldaña built with Tunes — from «Mas Flow» in 2003 to «Gasolina» and the double run of «Mas Flow 2» — is a shared one, told in full under Luny Tunes. What belongs to him alone is the route that brought him to it: Dominican Republic to San Juan to Massachusetts, arriving at reggaeton’s production side by way of its street side.' WHERE slug = 'luny';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Luny —Francisco Saldaña, nacido en República Dominicana el 23 de junio de 1979— es un productor discográfico, la mitad de "},{"type":"artistReference","attrs":{"occurrenceId":"3bfdfd19-6bc5-4260-a233-46216b60b66b","artistId":"ef56311a-ac4b-451e-a7a7-97e5f240cd47","displayText":"Luny Tunes"}},{"type":"text","text":", el dúo que, con "},{"type":"artistReference","attrs":{"occurrenceId":"1fb93965-0b9b-425c-85d0-82b810de9294","artistId":"f78661d2-7e96-48b7-baf3-fd99a94d10e6","displayText":"Tunes"}},{"type":"text","text":", le dio al reguetón su modelo de álbum de estudio a comienzos de los 2000."}]},{"type":"paragraph","content":[{"type":"text","text":"San Juan","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Antes de Massachusetts, donde su familia se asentó después y donde conoció a "},{"type":"artistReference","attrs":{"occurrenceId":"5fe91384-5692-464c-8d43-48709b10e9be","artistId":"f78661d2-7e96-48b7-baf3-fd99a94d10e6","displayText":"Tunes"}},{"type":"text","text":", Saldaña pasó parte de su adolescencia en un barrio de San Juan, Puerto Rico, inmerso en el underground de la ciudad —el mismo underground de donde salió el propio reguetón—. Un estudio académico del género lo señala por esa inmersión, distinta del camino que llevó a "},{"type":"artistReference","attrs":{"occurrenceId":"a1fcbf46-77ea-478e-9163-1aacba9a7f23","artistId":"f78661d2-7e96-48b7-baf3-fd99a94d10e6","displayText":"Tunes"}},{"type":"text","text":" hasta la sociedad."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El trabajo que Saldaña construyó con "},{"type":"artistReference","attrs":{"occurrenceId":"c9382078-1f6f-48e1-a56a-6f893fa2ea72","artistId":"f78661d2-7e96-48b7-baf3-fd99a94d10e6","displayText":"Tunes"}},{"type":"text","text":" —de «Mas Flow» en 2003 a «Gasolina» y la doble tanda de «Mas Flow 2»— es compartido, y está contado en su totalidad en "},{"type":"artistReference","attrs":{"occurrenceId":"9176809a-6a50-40a6-ab7e-92a4aef70ab6","artistId":"ef56311a-ac4b-451e-a7a7-97e5f240cd47","displayText":"Luny Tunes"}},{"type":"text","text":". Lo que le pertenece solo a él es el camino que lo llevó hasta ahí: de República Dominicana a San Juan y a Massachusetts, llegando al lado de la producción del reguetón por la vía de su lado de calle."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luny'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'luny' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3bfdfd19-6bc5-4260-a233-46216b60b66b', 'artist', 'ef56311a-ac4b-451e-a7a7-97e5f240cd47' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1fb93965-0b9b-425c-85d0-82b810de9294', 'artist', 'f78661d2-7e96-48b7-baf3-fd99a94d10e6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5fe91384-5692-464c-8d43-48709b10e9be', 'artist', 'f78661d2-7e96-48b7-baf3-fd99a94d10e6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a1fcbf46-77ea-478e-9163-1aacba9a7f23', 'artist', 'f78661d2-7e96-48b7-baf3-fd99a94d10e6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c9382078-1f6f-48e1-a56a-6f893fa2ea72', 'artist', 'f78661d2-7e96-48b7-baf3-fd99a94d10e6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9176809a-6a50-40a6-ab7e-92a4aef70ab6', 'artist', 'ef56311a-ac4b-451e-a7a7-97e5f240cd47' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Luny —Francisco Saldaña, nacido en República Dominicana el 23 de junio de 1979— es un productor discográfico, la mitad de Luny Tunes, el dúo que, con Tunes, le dio al reguetón su modelo de álbum de estudio a comienzos de los 2000.

**San Juan**

Antes de Massachusetts, donde su familia se asentó después y donde conoció a Tunes, Saldaña pasó parte de su adolescencia en un barrio de San Juan, Puerto Rico, inmerso en el underground de la ciudad —el mismo underground de donde salió el propio reguetón—. Un estudio académico del género lo señala por esa inmersión, distinta del camino que llevó a Tunes hasta la sociedad.

**Legado**

El trabajo que Saldaña construyó con Tunes —de «Mas Flow» en 2003 a «Gasolina» y la doble tanda de «Mas Flow 2»— es compartido, y está contado en su totalidad en Luny Tunes. Lo que le pertenece solo a él es el camino que lo llevó hasta ahí: de República Dominicana a San Juan y a Massachusetts, llegando al lado de la producción del reguetón por la vía de su lado de calle.' WHERE slug = 'luny';

COMMIT;
