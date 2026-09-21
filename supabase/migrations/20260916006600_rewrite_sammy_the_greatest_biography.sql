BEGIN;

-- Sammy The Greatest (Samuel Dilone Castillo, antes DJ Sammy): productor y DJ de música urbana. Fuentes: Listín Diario (Lourdes Aponte, 17 ago. 2022, 'Cinco productores...'; 15 abr. 2026, participantes de Planeta Alofoke), TV Plata y otros medios sobre su participación. Sin cambios de campo.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Sammy The Greatest —Samuel Dilone Castillo, formerly known as DJ Sammy, born on 11 March 1991— is a Dominican music producer and DJ who works in urban music."}]},{"type":"paragraph","content":[{"type":"text","text":"Producer for Secreto and El Mayor Clásico","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A 2022 profile in Listín Diario called him the driving force behind songs by several popular performers, above all "},{"type":"artistReference","attrs":{"occurrenceId":"7857e6d4-ed16-4ca1-a8a9-374228d808f4","artistId":"f57eb2e7-9ca7-463d-baee-8b3ea1800e6b","displayText":"Secreto “El Famoso Biberón”"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"ef01bb9c-adb1-422d-989e-580e4b204ee2","artistId":"518354a4-7cb9-4c39-a2b8-9fa4d18f50db","displayText":"El Mayor Clásico"}},{"type":"text","text":". The paper described his partnership with Secreto as a powerful pairing in Dominican urban music, and named «Secreto ponte el chaleco», «La para de tu coro», «El cuerpo del deseo» and «No la maltrates» among the songs they made together."}]},{"type":"paragraph","content":[{"type":"text","text":"Recognition among producers","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In August 2022 Listín Diario included him among five producers who put their stamp on Dominican urban music, together with Nipo 809, Chael Produciendo, "},{"type":"artistReference","attrs":{"occurrenceId":"d4f283fc-719d-4584-9e8f-0eff9df7c5b0","artistId":"66512533-3c96-45f0-b248-d0d5e0e586d7","displayText":"Nico Clínico"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"e2f57a67-f659-44db-b434-8bf5a89c853a","artistId":"5cbc8f2b-cb68-4ebd-8006-6837be54bbe4","displayText":"Leo RD"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Planeta Alofoke»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In April 2026 he was announced as the first participant of «Planeta Alofoke», the reality show produced by Santiago Matías, and Listín Diario listed him among its participants on 15 April."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His work is documented mainly through the credits on the songs he produced and through the press coverage of his partnerships in Dominican urban music."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'sammy-the-greatest'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'sammy-the-greatest' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '7857e6d4-ed16-4ca1-a8a9-374228d808f4', 'artist', 'f57eb2e7-9ca7-463d-baee-8b3ea1800e6b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sammy-the-greatest' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'ef01bb9c-adb1-422d-989e-580e4b204ee2', 'artist', '518354a4-7cb9-4c39-a2b8-9fa4d18f50db' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sammy-the-greatest' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd4f283fc-719d-4584-9e8f-0eff9df7c5b0', 'artist', '66512533-3c96-45f0-b248-d0d5e0e586d7' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sammy-the-greatest' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'e2f57a67-f659-44db-b434-8bf5a89c853a', 'artist', '5cbc8f2b-cb68-4ebd-8006-6837be54bbe4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sammy-the-greatest' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Sammy The Greatest —Samuel Dilone Castillo, formerly known as DJ Sammy, born on 11 March 1991— is a Dominican music producer and DJ who works in urban music.

**Producer for Secreto and El Mayor Clásico**

A 2022 profile in Listín Diario called him the driving force behind songs by several popular performers, above all Secreto “El Famoso Biberón” and El Mayor Clásico. The paper described his partnership with Secreto as a powerful pairing in Dominican urban music, and named «Secreto ponte el chaleco», «La para de tu coro», «El cuerpo del deseo» and «No la maltrates» among the songs they made together.

**Recognition among producers**

In August 2022 Listín Diario included him among five producers who put their stamp on Dominican urban music, together with Nipo 809, Chael Produciendo, Nico Clínico and Leo RD.

**«Planeta Alofoke»**

In April 2026 he was announced as the first participant of «Planeta Alofoke», the reality show produced by Santiago Matías, and Listín Diario listed him among its participants on 15 April.

**Legacy**

His work is documented mainly through the credits on the songs he produced and through the press coverage of his partnerships in Dominican urban music.' WHERE slug = 'sammy-the-greatest';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Sammy The Greatest —Samuel Dilone Castillo, antes conocido como DJ Sammy, nacido el 11 de marzo de 1991— es un productor musical y DJ dominicano que trabaja en la música urbana."}]},{"type":"paragraph","content":[{"type":"text","text":"Productor de Secreto y El Mayor Clásico","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Un perfil de Listín Diario de 2022 lo llamó el impulsor detrás de temas de varios intérpretes populares, sobre todo de "},{"type":"artistReference","attrs":{"occurrenceId":"39923e68-7f6a-450d-ba05-9ca4a076476e","artistId":"f57eb2e7-9ca7-463d-baee-8b3ea1800e6b","displayText":"Secreto “El Famoso Biberón”"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"d63bc476-a9f0-4e7d-9762-2d5d41faf3b3","artistId":"518354a4-7cb9-4c39-a2b8-9fa4d18f50db","displayText":"El Mayor Clásico"}},{"type":"text","text":". El diario describió su unión con Secreto como un binomio poderoso de la música urbana dominicana y citó «Secreto ponte el chaleco», «La para de tu coro», «El cuerpo del deseo» y «No la maltrates» entre los temas que hicieron juntos."}]},{"type":"paragraph","content":[{"type":"text","text":"Reconocimiento entre productores","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En agosto de 2022 Listín Diario lo incluyó entre cinco productores que ponen su sello a la música urbana dominicana, junto a Nipo 809, Chael Produciendo, "},{"type":"artistReference","attrs":{"occurrenceId":"9578598a-1449-4f21-9a51-3fcd4644d971","artistId":"66512533-3c96-45f0-b248-d0d5e0e586d7","displayText":"Nico Clínico"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"1f6ea622-a4bf-44d7-aad0-8962f350ba9e","artistId":"5cbc8f2b-cb68-4ebd-8006-6837be54bbe4","displayText":"Leo RD"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Planeta Alofoke»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En abril de 2026 fue anunciado como el primer participante de «Planeta Alofoke», el reality producido por Santiago Matías, y Listín Diario lo incluyó entre sus participantes el 15 de abril."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su trabajo está documentado sobre todo en los créditos de las canciones que produjo y en la cobertura de prensa de sus alianzas en la música urbana dominicana."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'sammy-the-greatest'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'sammy-the-greatest' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '39923e68-7f6a-450d-ba05-9ca4a076476e', 'artist', 'f57eb2e7-9ca7-463d-baee-8b3ea1800e6b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sammy-the-greatest' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd63bc476-a9f0-4e7d-9762-2d5d41faf3b3', 'artist', '518354a4-7cb9-4c39-a2b8-9fa4d18f50db' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sammy-the-greatest' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '9578598a-1449-4f21-9a51-3fcd4644d971', 'artist', '66512533-3c96-45f0-b248-d0d5e0e586d7' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sammy-the-greatest' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '1f6ea622-a4bf-44d7-aad0-8962f350ba9e', 'artist', '5cbc8f2b-cb68-4ebd-8006-6837be54bbe4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sammy-the-greatest' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Sammy The Greatest —Samuel Dilone Castillo, antes conocido como DJ Sammy, nacido el 11 de marzo de 1991— es un productor musical y DJ dominicano que trabaja en la música urbana.

**Productor de Secreto y El Mayor Clásico**

Un perfil de Listín Diario de 2022 lo llamó el impulsor detrás de temas de varios intérpretes populares, sobre todo de Secreto “El Famoso Biberón” y El Mayor Clásico. El diario describió su unión con Secreto como un binomio poderoso de la música urbana dominicana y citó «Secreto ponte el chaleco», «La para de tu coro», «El cuerpo del deseo» y «No la maltrates» entre los temas que hicieron juntos.

**Reconocimiento entre productores**

En agosto de 2022 Listín Diario lo incluyó entre cinco productores que ponen su sello a la música urbana dominicana, junto a Nipo 809, Chael Produciendo, Nico Clínico y Leo RD.

**«Planeta Alofoke»**

En abril de 2026 fue anunciado como el primer participante de «Planeta Alofoke», el reality producido por Santiago Matías, y Listín Diario lo incluyó entre sus participantes el 15 de abril.

**Legado**

Su trabajo está documentado sobre todo en los créditos de las canciones que produjo y en la cobertura de prensa de sus alianzas en la música urbana dominicana.' WHERE slug = 'sammy-the-greatest';

COMMIT;
