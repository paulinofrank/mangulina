BEGIN;

-- Ficha de Jandy Ventura.
--
-- La biografía de relleno lo describía en términos genéricos, sin nombrar su banda, su
-- álbum ni un solo colaborador. Nombre completo: first_name Juan de Dios, last_name Ventura
-- (ya correcto), second_last_name Flores.

UPDATE artists SET first_name = 'Juan de Dios', second_last_name = 'Flores' WHERE slug = 'jandy-ventura';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jandy Ventura — Juan de Dios Ventura Flores, born 30 September 1974 in Santo Domingo — is a Dominican merengue singer and bandleader, son of "},{"type":"artistReference","attrs":{"occurrenceId":"4e4a6507-0dd8-451d-81b8-b8212a0589ae","artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura"}},{"type":"text","text":", who built his own group, «Jandy Ventura y Los Potros», as a deliberate nod to his father’s nickname, El Caballo."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los Potros»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The name traces back to the broadcaster Colombia Alcántara, who had nicknamed the elder Ventura «El Potro» years before «El Caballo» stuck; Jandy took the colt for his own band, releasing material such as «Ley seca» on the compilation «Los mejores del merengue 2011»."}]},{"type":"paragraph","content":[{"type":"text","text":"«El Legado del Caballo»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"After his father’s death, Jandy completed a project Johnny Ventura had wanted to record across more than sixty-five years of career: «El Legado del Caballo, Vol. 1» (2022), fourteen of his father’s biggest hits reinterpreted with a cast of guest singers. "},{"type":"artistReference","attrs":{"occurrenceId":"3675cd71-bf01-472e-a75d-fc46ecd4847a","artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada"}},{"type":"text","text":" sang «La agarradera», "},{"type":"artistReference","attrs":{"occurrenceId":"1876ce4a-9e59-482a-ab5b-bb17d0ee4288","artistId":"e8ba0f32-1d96-494d-9861-b1dc3937331e","displayText":"José Alberto \"El Canario\""}},{"type":"text","text":" took «Matilde Lina», "},{"type":"artistReference","attrs":{"occurrenceId":"349f44e5-1da2-45c4-9cc7-0b376916d247","artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz"}},{"type":"text","text":" sang «Merenguero hasta la tambora», "},{"type":"artistReference","attrs":{"occurrenceId":"04185bae-b4ad-4f44-949c-01cfe960f50c","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":" carried «El carbonero», "},{"type":"artistReference","attrs":{"occurrenceId":"61929ff3-8eee-48c0-aacc-8171e88bee57","artistId":"6c3e0d74-23b7-4d80-969f-9d5319ee5127","displayText":"Alex Bueno"}},{"type":"text","text":" recorded «Las indias de Baní», "},{"type":"artistReference","attrs":{"occurrenceId":"c4586ce7-1ada-4d28-a08b-b69e7cfb1f95","artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera"}},{"type":"text","text":" sang «Consígueme eso», and "},{"type":"artistReference","attrs":{"occurrenceId":"dacddebd-ca16-427e-b180-5fa5816f37f7","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":" closed the album with «Titita»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The record kept his father’s songbook and the Ventura name in front of a new audience, completing, in Jandy’s own words, something Johnny Ventura had wanted to leave behind and never got the chance to finish himself."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jandy-ventura'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jandy-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4e4a6507-0dd8-451d-81b8-b8212a0589ae', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3675cd71-bf01-472e-a75d-fc46ecd4847a', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1876ce4a-9e59-482a-ab5b-bb17d0ee4288', 'artist', 'e8ba0f32-1d96-494d-9861-b1dc3937331e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '349f44e5-1da2-45c4-9cc7-0b376916d247', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '04185bae-b4ad-4f44-949c-01cfe960f50c', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '61929ff3-8eee-48c0-aacc-8171e88bee57', 'artist', '6c3e0d74-23b7-4d80-969f-9d5319ee5127' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c4586ce7-1ada-4d28-a08b-b69e7cfb1f95', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dacddebd-ca16-427e-b180-5fa5816f37f7', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Jandy Ventura — Juan de Dios Ventura Flores, born 30 September 1974 in Santo Domingo — is a Dominican merengue singer and bandleader, son of Johnny Ventura, who built his own group, «Jandy Ventura y Los Potros», as a deliberate nod to his father’s nickname, El Caballo.

**«Los Potros»**

The name traces back to the broadcaster Colombia Alcántara, who had nicknamed the elder Ventura «El Potro» years before «El Caballo» stuck; Jandy took the colt for his own band, releasing material such as «Ley seca» on the compilation «Los mejores del merengue 2011».

**«El Legado del Caballo»**

After his father’s death, Jandy completed a project Johnny Ventura had wanted to record across more than sixty-five years of career: «El Legado del Caballo, Vol. 1» (2022), fourteen of his father’s biggest hits reinterpreted with a cast of guest singers. Milly Quezada sang «La agarradera», José Alberto "El Canario" took «Matilde Lina», Manny Cruz sang «Merenguero hasta la tambora», Sergio Vargas carried «El carbonero», Alex Bueno recorded «Las indias de Baní», Eddy Herrera sang «Consígueme eso», and Rubby Pérez closed the album with «Titita».

**Legacy**

The record kept his father’s songbook and the Ventura name in front of a new audience, completing, in Jandy’s own words, something Johnny Ventura had wanted to leave behind and never got the chance to finish himself.' WHERE slug = 'jandy-ventura';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jandy Ventura —Juan de Dios Ventura Flores, nacido el 30 de septiembre de 1974 en Santo Domingo— es cantante y director de orquesta dominicano de merengue, hijo de "},{"type":"artistReference","attrs":{"occurrenceId":"2f19f12d-b755-4f50-afeb-043a1b94fa73","artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura"}},{"type":"text","text":", que armó su propio grupo, «Jandy Ventura y Los Potros», como un guiño deliberado al apodo de su padre, El Caballo."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los Potros»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El nombre viene de la locutora Colombia Alcántara, quien había apodado al Ventura mayor «El Potro» años antes de que se le quedara «El Caballo»; Jandy tomó el potro para su propia banda, sacando material como «Ley seca» en el recopilatorio «Los mejores del merengue 2011»."}]},{"type":"paragraph","content":[{"type":"text","text":"«El Legado del Caballo»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Tras la muerte de su padre, Jandy completó un proyecto que Johnny Ventura había querido grabar a lo largo de más de sesenta y cinco años de carrera: «El Legado del Caballo, Vol. 1» (2022), catorce de los mayores éxitos de su padre reinterpretados con un elenco de cantantes invitados. "},{"type":"artistReference","attrs":{"occurrenceId":"a98bbeed-f820-4b17-a3e9-57d0b55cb2c9","artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada"}},{"type":"text","text":" cantó «La agarradera», "},{"type":"artistReference","attrs":{"occurrenceId":"c6d8bf18-c082-43be-b6a1-93ea237c3977","artistId":"e8ba0f32-1d96-494d-9861-b1dc3937331e","displayText":"José Alberto \"El Canario\""}},{"type":"text","text":" tomó «Matilde Lina», "},{"type":"artistReference","attrs":{"occurrenceId":"cc0f34dc-85d9-4f5d-a1d2-31be0d94e7fe","artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz"}},{"type":"text","text":" cantó «Merenguero hasta la tambora», "},{"type":"artistReference","attrs":{"occurrenceId":"71054a59-d452-41c1-b509-2517d702c604","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":" llevó «El carbonero», "},{"type":"artistReference","attrs":{"occurrenceId":"213f22d6-7412-45f1-81a1-e5ed8c586ac3","artistId":"6c3e0d74-23b7-4d80-969f-9d5319ee5127","displayText":"Alex Bueno"}},{"type":"text","text":" grabó «Las indias de Baní», "},{"type":"artistReference","attrs":{"occurrenceId":"6caa378c-0f65-42c0-a4ac-e18e96acc0ea","artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera"}},{"type":"text","text":" cantó «Consígueme eso», y "},{"type":"artistReference","attrs":{"occurrenceId":"fa1f61ac-c103-4c9f-968a-908cf249d214","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":" cerró el álbum con «Titita»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El disco mantuvo el cancionero de su padre y el apellido Ventura frente a un público nuevo, completando, en palabras del propio Jandy, algo que Johnny Ventura había querido dejar y nunca alcanzó a terminar él mismo."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jandy-ventura'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jandy-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2f19f12d-b755-4f50-afeb-043a1b94fa73', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a98bbeed-f820-4b17-a3e9-57d0b55cb2c9', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c6d8bf18-c082-43be-b6a1-93ea237c3977', 'artist', 'e8ba0f32-1d96-494d-9861-b1dc3937331e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cc0f34dc-85d9-4f5d-a1d2-31be0d94e7fe', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '71054a59-d452-41c1-b509-2517d702c604', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '213f22d6-7412-45f1-81a1-e5ed8c586ac3', 'artist', '6c3e0d74-23b7-4d80-969f-9d5319ee5127' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6caa378c-0f65-42c0-a4ac-e18e96acc0ea', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'fa1f61ac-c103-4c9f-968a-908cf249d214', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Jandy Ventura —Juan de Dios Ventura Flores, nacido el 30 de septiembre de 1974 en Santo Domingo— es cantante y director de orquesta dominicano de merengue, hijo de Johnny Ventura, que armó su propio grupo, «Jandy Ventura y Los Potros», como un guiño deliberado al apodo de su padre, El Caballo.

**«Los Potros»**

El nombre viene de la locutora Colombia Alcántara, quien había apodado al Ventura mayor «El Potro» años antes de que se le quedara «El Caballo»; Jandy tomó el potro para su propia banda, sacando material como «Ley seca» en el recopilatorio «Los mejores del merengue 2011».

**«El Legado del Caballo»**

Tras la muerte de su padre, Jandy completó un proyecto que Johnny Ventura había querido grabar a lo largo de más de sesenta y cinco años de carrera: «El Legado del Caballo, Vol. 1» (2022), catorce de los mayores éxitos de su padre reinterpretados con un elenco de cantantes invitados. Milly Quezada cantó «La agarradera», José Alberto "El Canario" tomó «Matilde Lina», Manny Cruz cantó «Merenguero hasta la tambora», Sergio Vargas llevó «El carbonero», Alex Bueno grabó «Las indias de Baní», Eddy Herrera cantó «Consígueme eso», y Rubby Pérez cerró el álbum con «Titita».

**Legado**

El disco mantuvo el cancionero de su padre y el apellido Ventura frente a un público nuevo, completando, en palabras del propio Jandy, algo que Johnny Ventura había querido dejar y nunca alcanzó a terminar él mismo.' WHERE slug = 'jandy-ventura';

COMMIT;
