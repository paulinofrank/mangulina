BEGIN;

-- Ficha de Sujeto Oro 24.
--
-- La biografía de relleno lo llamaba genéricamente artista de "merengue" sin nombrar banda,
-- canción, colaborador ni barrio. primary_genre corregido de 'urbano' a 'merengue-mambo',
-- la misma categoría de Omega y Amarfis y La Banda de Atakke en este catálogo, respaldada
-- por la prensa dominicana que lo llama consistentemente "merenguero de calle/urbano".
-- No se incluyen sus procesos legales personales: son ajenos a la trayectoria musical y la
-- acusación de 2025 no prosperó (declarado no culpable en agosto de 2026).

UPDATE artists SET primary_genre = 'merengue-mambo' WHERE slug = 'sujeto-oro-24';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Sujeto Oro 24, born Johan Manuel Nova in Santo Domingo, is a Dominican merengue de calle and dembow-crossover singer known for his aggressive, streetwise delivery and his identification with his home barrio of Los Mina."}]},{"type":"paragraph","content":[{"type":"text","text":"Merengue de calle","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Coming up alongside genre pioneers such as "},{"type":"artistReference","attrs":{"occurrenceId":"be60ce42-e27d-462f-9b37-ad940d3bd88d","artistId":"6159dc70-bd8f-439d-bf17-5d690262e5cb","displayText":"Omega"}},{"type":"text","text":", he built a catalogue of dancefloor hits, among them «Weje Weje», «Bobo» and «Amor», and paid tribute to his own barrio directly on «Los Mina Lo Mato» (2022). He has kept a foothold in tribute and live-band shows as well, fronting homages to salsa’s Tito Rojas and to "},{"type":"artistReference","attrs":{"occurrenceId":"3a706fe6-0297-4c51-a100-61b64853310b","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Posse cuts and collaborations","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He has been a regular presence on the genre’s crowded remix cuts, appearing alongside "},{"type":"artistReference","attrs":{"occurrenceId":"360c2e9e-34f3-47aa-baf8-5a106c9e9dcc","artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"d77bbf00-aebc-4f82-a9eb-9cf5fa59b899","artistId":"fa9cc802-28ca-4695-b585-f75aa90a2b6c","displayText":"Mozart La Para"}},{"type":"text","text":" on the remixes of «A Beber» and «Pa Que Me Dan De Eso», and recording «No Me Importa» with "},{"type":"artistReference","attrs":{"occurrenceId":"a0742268-f6ad-488c-a4c8-399f755d404b","artistId":"7f216f19-be38-4369-adb6-0f51922cb75c","displayText":"Ala Jaza"}},{"type":"text","text":", part of a scene that also counts "},{"type":"artistReference","attrs":{"occurrenceId":"d9ec46a3-ee2a-450d-a20f-f3d67a89fe47","artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa"}},{"type":"text","text":" among its biggest names."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"More than two decades into a career built on merengue de calle’s crossover into dembow, Sujeto Oro 24 remains one of the genre’s recognizable, if combative, voices, as comfortable trading verses on a posse cut as fronting a tribute to the salsa greats he grew up on."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'sujeto-oro-24'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'be60ce42-e27d-462f-9b37-ad940d3bd88d', 'artist', '6159dc70-bd8f-439d-bf17-5d690262e5cb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3a706fe6-0297-4c51-a100-61b64853310b', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '360c2e9e-34f3-47aa-baf8-5a106c9e9dcc', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd77bbf00-aebc-4f82-a9eb-9cf5fa59b899', 'artist', 'fa9cc802-28ca-4695-b585-f75aa90a2b6c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a0742268-f6ad-488c-a4c8-399f755d404b', 'artist', '7f216f19-be38-4369-adb6-0f51922cb75c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd9ec46a3-ee2a-450d-a20f-f3d67a89fe47', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Sujeto Oro 24, born Johan Manuel Nova in Santo Domingo, is a Dominican merengue de calle and dembow-crossover singer known for his aggressive, streetwise delivery and his identification with his home barrio of Los Mina.

**Merengue de calle**

Coming up alongside genre pioneers such as Omega, he built a catalogue of dancefloor hits, among them «Weje Weje», «Bobo» and «Amor», and paid tribute to his own barrio directly on «Los Mina Lo Mato» (2022). He has kept a foothold in tribute and live-band shows as well, fronting homages to salsa’s Tito Rojas and to Ramón Orlando & Orquesta Internacional.

**Posse cuts and collaborations**

He has been a regular presence on the genre’s crowded remix cuts, appearing alongside Don Miguelo and Mozart La Para on the remixes of «A Beber» and «Pa Que Me Dan De Eso», and recording «No Me Importa» with Ala Jaza, part of a scene that also counts El Alfa among its biggest names.

**Legacy**

More than two decades into a career built on merengue de calle’s crossover into dembow, Sujeto Oro 24 remains one of the genre’s recognizable, if combative, voices, as comfortable trading verses on a posse cut as fronting a tribute to the salsa greats he grew up on.' WHERE slug = 'sujeto-oro-24';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Sujeto Oro 24, nacido Johan Manuel Nova en Santo Domingo, es cantante dominicano de merengue de calle y cruce con el dembow, conocido por su estilo agresivo y callejero y por su identificación con su barrio, Los Mina."}]},{"type":"paragraph","content":[{"type":"text","text":"Merengue de calle","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Formado junto a pioneros del género como "},{"type":"artistReference","attrs":{"occurrenceId":"4ef21e92-ba0b-4431-a886-c515a2f0c46a","artistId":"6159dc70-bd8f-439d-bf17-5d690262e5cb","displayText":"Omega"}},{"type":"text","text":", construyó un catálogo de bailables entre los que están «Weje Weje», «Bobo» y «Amor», y le rindió homenaje directo a su propio barrio en «Los Mina Lo Mato» (2022). También ha mantenido presencia en shows de homenaje con banda en vivo, encabezando tributos al salsero Tito Rojas y a "},{"type":"artistReference","attrs":{"occurrenceId":"d02108d1-28d2-44f8-bfc4-c00b2e1b3093","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Remixes y colaboraciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ha sido presencia constante en los concurridos remixes del género, apareciendo junto a "},{"type":"artistReference","attrs":{"occurrenceId":"ac73b0c0-cb50-4ffe-98d9-c777dabec785","artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"18404788-9ea0-4aef-898d-7a20ded068fa","artistId":"fa9cc802-28ca-4695-b585-f75aa90a2b6c","displayText":"Mozart La Para"}},{"type":"text","text":" en los remixes de «A Beber» y «Pa Que Me Dan De Eso», y grabando «No Me Importa» con "},{"type":"artistReference","attrs":{"occurrenceId":"fa330f2d-6d80-4576-8fad-08075e4c0586","artistId":"7f216f19-be38-4369-adb6-0f51922cb75c","displayText":"Ala Jaza"}},{"type":"text","text":", dentro de una escena que también cuenta a "},{"type":"artistReference","attrs":{"occurrenceId":"feb7d13e-1bbb-4d02-8180-008c9a314e2a","artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa"}},{"type":"text","text":" entre sus nombres más grandes."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Con más de dos décadas de carrera construida sobre el cruce del merengue de calle con el dembow, Sujeto Oro 24 sigue siendo una de las voces reconocibles, aunque combativas, del género, tan cómodo intercambiando versos en un remix como al frente de un homenaje a los grandes de la salsa con los que creció."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'sujeto-oro-24'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4ef21e92-ba0b-4431-a886-c515a2f0c46a', 'artist', '6159dc70-bd8f-439d-bf17-5d690262e5cb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd02108d1-28d2-44f8-bfc4-c00b2e1b3093', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ac73b0c0-cb50-4ffe-98d9-c777dabec785', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '18404788-9ea0-4aef-898d-7a20ded068fa', 'artist', 'fa9cc802-28ca-4695-b585-f75aa90a2b6c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'fa330f2d-6d80-4576-8fad-08075e4c0586', 'artist', '7f216f19-be38-4369-adb6-0f51922cb75c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'feb7d13e-1bbb-4d02-8180-008c9a314e2a', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'sujeto-oro-24' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Sujeto Oro 24, nacido Johan Manuel Nova en Santo Domingo, es cantante dominicano de merengue de calle y cruce con el dembow, conocido por su estilo agresivo y callejero y por su identificación con su barrio, Los Mina.

**Merengue de calle**

Formado junto a pioneros del género como Omega, construyó un catálogo de bailables entre los que están «Weje Weje», «Bobo» y «Amor», y le rindió homenaje directo a su propio barrio en «Los Mina Lo Mato» (2022). También ha mantenido presencia en shows de homenaje con banda en vivo, encabezando tributos al salsero Tito Rojas y a Ramón Orlando & Orquesta Internacional.

**Remixes y colaboraciones**

Ha sido presencia constante en los concurridos remixes del género, apareciendo junto a Don Miguelo y Mozart La Para en los remixes de «A Beber» y «Pa Que Me Dan De Eso», y grabando «No Me Importa» con Ala Jaza, dentro de una escena que también cuenta a El Alfa entre sus nombres más grandes.

**Legado**

Con más de dos décadas de carrera construida sobre el cruce del merengue de calle con el dembow, Sujeto Oro 24 sigue siendo una de las voces reconocibles, aunque combativas, del género, tan cómodo intercambiando versos en un remix como al frente de un homenaje a los grandes de la salsa con los que creció.' WHERE slug = 'sujeto-oro-24';

COMMIT;
