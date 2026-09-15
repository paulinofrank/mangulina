BEGIN;

-- Ficha de Juan Hidalgo.
--
-- La biografía de relleno lo describía como músico genérico de merengue/bachata/tropical,
-- sin mencionar J&N Records ni su papel como presidente y cofundador del sello. occupations:
-- executive (sustituye lista vacía; primary_role ya es producer). Un premio registrado: Ralph S. Peer
-- Publishers Award 2025, del Latin Songwriters Hall of Fame. Vico C, Lisa M, Fransheska y
-- Falo son puertorriqueños y no entran en las listas de ausencias.

UPDATE artists SET occupations = '["executive"]'::jsonb WHERE slug = 'juan-hidalgo';

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Ralph S. Peer Publishers Award' FROM awards a WHERE a.name = 'Latin Songwriters Hall of Fame'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Ralph S. Peer Publishers Award');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2025, 'A J&N Publishing (con Nelson Estévez), entregado por la presidenta Marti Cuevas', true, 'Billboard (27 ago 2025); Yahoo/Yahoo Entertainment (17 oct 2025); LaMezcla.com (28 ago 2025); Nevarez PR (9 oct 2025)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'juan-hidalgo' AND a.name = 'Latin Songwriters Hall of Fame' AND cat.name = 'Ralph S. Peer Publishers Award'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2025);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Hidalgo, from San Francisco de Macorís, is a Dominican record executive and music publisher, president and co-founder, with Nelson Estévez, of J&N Records — the most successful independent Latin record company to come out of the Dominican Republic."}]},{"type":"paragraph","content":[{"type":"text","text":"From a record shop in Queens","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He and Estévez started small, selling LPs and cassettes out of a shop in Queens, New York, before turning to production. Their first two records sold to almost no one but themselves; signing "},{"type":"artistReference","attrs":{"occurrenceId":"4012b829-6c39-4e4c-a55c-ad0fa877160a","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":" gave the label its first real hit and put it on a footing to sign "},{"type":"artistReference","attrs":{"occurrenceId":"25b96663-547d-412e-859a-0d3d616c7cca","artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band"}},{"type":"text","text":" and the merengue orchestra La Artillería."}]},{"type":"paragraph","content":[{"type":"text","text":"«Cachamba», and a shark","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Under Hidalgo’s direction the label built a catalogue that would eventually run past 35,000 recordings. "},{"type":"artistReference","attrs":{"occurrenceId":"583e3332-6384-4ecb-bdfa-f782ff5e0376","artistId":"c73737c2-0106-4a87-8dbe-5f1650d34342","displayText":"Kinito Méndez"}},{"type":"text","text":"’s «Cachamba» sold more than a million copies, and "},{"type":"artistReference","attrs":{"occurrenceId":"5e7d2136-3545-431a-aec8-3fbc6e05f880","artistId":"f838ab51-002f-4737-ab38-17f65beec9ab","displayText":"Proyecto Uno"}},{"type":"text","text":"’s «El Tiburón» carried the label into the merenhouse and urban crossover of the 1990s, the same decade J&N became one of the first Dominican-run labels to sign Puerto Rican urban pioneers such as Vico C, Lisa M and Fransheska."}]},{"type":"paragraph","content":[{"type":"text","text":"The roster","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"J&N went on to record "},{"type":"artistReference","attrs":{"occurrenceId":"c6f1f43e-7f33-4585-af00-cd5c6f036c0d","artistId":"a77079ce-351a-4eb5-baef-de02dc1b62ce","displayText":"Zacarías Ferreira"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"11e7f5c2-eb0a-42ce-a414-5c931790c024","artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra"}},{"type":"text","text":" and dozens of other bachata and merengue names, including "},{"type":"artistReference","attrs":{"occurrenceId":"a0d9beee-00b6-48cb-a439-6e9ce6549496","artistId":"6fb949c4-2d6f-437f-8e7f-5f9efec847da","displayText":"Rikarena"}},{"type":"text","text":". Under Hidalgo’s presidency the company also expanded into radio (the Rumba stations in the Dominican Republic, Yunque 92.9 FM in Puerto Rico), its own EMCA recording studios, and film, producing Mexican and Puerto Rican features through a partnership with Televisa. During the 2020 pandemic it produced the tribute album «Billos Legendarios», honoring the Venezuelan-based Dominican bandleader Billo Frómeta with singers including Carlos Vives, Óscar de León and "},{"type":"artistReference","attrs":{"occurrenceId":"73e53f20-c974-4bbc-b29f-c309b864d052","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Ralph S. Peer Award","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In October 2025 the Latin Songwriters Hall of Fame gave Hidalgo and Estévez, as J&N Publishing, its Ralph S. Peer Publishers Award, presented by the organization’s president, Marti Cuevas — recognition of a catalogue that by then ran past 20,000 published works."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"“We started with a $13,000 investment,” Hidalgo has said of the company he still runs — by his own account the only major independent Latin label left free of the industry’s larger conglomerates after more than four decades."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-hidalgo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-hidalgo' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4012b829-6c39-4e4c-a55c-ad0fa877160a', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '25b96663-547d-412e-859a-0d3d616c7cca', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '583e3332-6384-4ecb-bdfa-f782ff5e0376', 'artist', 'c73737c2-0106-4a87-8dbe-5f1650d34342' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5e7d2136-3545-431a-aec8-3fbc6e05f880', 'artist', 'f838ab51-002f-4737-ab38-17f65beec9ab' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c6f1f43e-7f33-4585-af00-cd5c6f036c0d', 'artist', 'a77079ce-351a-4eb5-baef-de02dc1b62ce' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '11e7f5c2-eb0a-42ce-a414-5c931790c024', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a0d9beee-00b6-48cb-a439-6e9ce6549496', 'artist', '6fb949c4-2d6f-437f-8e7f-5f9efec847da' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '73e53f20-c974-4bbc-b29f-c309b864d052', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Juan Hidalgo, from San Francisco de Macorís, is a Dominican record executive and music publisher, president and co-founder, with Nelson Estévez, of J&N Records — the most successful independent Latin record company to come out of the Dominican Republic.

**From a record shop in Queens**

He and Estévez started small, selling LPs and cassettes out of a shop in Queens, New York, before turning to production. Their first two records sold to almost no one but themselves; signing Ramón Orlando & Orquesta Internacional gave the label its first real hit and put it on a footing to sign Los Toros Band and the merengue orchestra La Artillería.

**«Cachamba», and a shark**

Under Hidalgo’s direction the label built a catalogue that would eventually run past 35,000 recordings. Kinito Méndez’s «Cachamba» sold more than a million copies, and Proyecto Uno’s «El Tiburón» carried the label into the merenhouse and urban crossover of the 1990s, the same decade J&N became one of the first Dominican-run labels to sign Puerto Rican urban pioneers such as Vico C, Lisa M and Fransheska.

**The roster**

J&N went on to record Zacarías Ferreira, Monchy & Alexandra and dozens of other bachata and merengue names, including Rikarena. Under Hidalgo’s presidency the company also expanded into radio (the Rumba stations in the Dominican Republic, Yunque 92.9 FM in Puerto Rico), its own EMCA recording studios, and film, producing Mexican and Puerto Rican features through a partnership with Televisa. During the 2020 pandemic it produced the tribute album «Billos Legendarios», honoring the Venezuelan-based Dominican bandleader Billo Frómeta with singers including Carlos Vives, Óscar de León and Wilfrido Vargas.

**Ralph S. Peer Award**

In October 2025 the Latin Songwriters Hall of Fame gave Hidalgo and Estévez, as J&N Publishing, its Ralph S. Peer Publishers Award, presented by the organization’s president, Marti Cuevas — recognition of a catalogue that by then ran past 20,000 published works.

**Legacy**

“We started with a $13,000 investment,” Hidalgo has said of the company he still runs — by his own account the only major independent Latin label left free of the industry’s larger conglomerates after more than four decades.' WHERE slug = 'juan-hidalgo';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Hidalgo, de San Francisco de Macorís, es empresario discográfico y editor musical dominicano, presidente y cofundador, junto a Nelson Estévez, de J&N Records —la disquera independiente latina más exitosa salida de República Dominicana."}]},{"type":"paragraph","content":[{"type":"text","text":"Desde una tienda de discos en Queens","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Él y Estévez empezaron en pequeño, vendiendo LP y casetes en una tienda de Queens, Nueva York, antes de pasar a la producción. Sus dos primeras grabaciones casi no se las compró nadie más que ellos mismos; fichar a "},{"type":"artistReference","attrs":{"occurrenceId":"a74d27ab-b435-4506-a3bd-71edbe9900d8","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":" le dio al sello su primer éxito real y lo puso en condiciones de firmar a "},{"type":"artistReference","attrs":{"occurrenceId":"4b3f4d47-9174-4e6b-a842-b85456fa8c79","artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band"}},{"type":"text","text":" y a la orquesta de merengue La Artillería."}]},{"type":"paragraph","content":[{"type":"text","text":"«Cachamba», y un tiburón","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Bajo la dirección de Hidalgo el sello armó un catálogo que terminaría pasando los 35 000 fonogramas. «Cachamba», de "},{"type":"artistReference","attrs":{"occurrenceId":"fa5c2a95-d0c5-4e20-a816-d46fc6b8487a","artistId":"c73737c2-0106-4a87-8dbe-5f1650d34342","displayText":"Kinito Méndez"}},{"type":"text","text":", vendió más de un millón de copias, y «El Tiburón», de "},{"type":"artistReference","attrs":{"occurrenceId":"7312afb3-866d-45eb-9298-557a61118b92","artistId":"f838ab51-002f-4737-ab38-17f65beec9ab","displayText":"Proyecto Uno"}},{"type":"text","text":", llevó al sello al merenhouse y al cruce urbano de los años noventa, la misma década en que J&N se convirtió en uno de los primeros sellos dirigidos por dominicanos en fichar a pioneros urbanos puertorriqueños como Vico C, Lisa M y Fransheska."}]},{"type":"paragraph","content":[{"type":"text","text":"El catálogo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"J&N pasó a grabar a "},{"type":"artistReference","attrs":{"occurrenceId":"fa1adda3-8c47-44fa-ac52-c950490c764f","artistId":"a77079ce-351a-4eb5-baef-de02dc1b62ce","displayText":"Zacarías Ferreira"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"6cb843ce-1df7-44b7-8b3c-4e6cd5e56026","artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra"}},{"type":"text","text":" y decenas de otros nombres de bachata y merengue, entre ellos "},{"type":"artistReference","attrs":{"occurrenceId":"6504822c-3867-4539-b318-1b828645c8fb","artistId":"6fb949c4-2d6f-437f-8e7f-5f9efec847da","displayText":"Rikarena"}},{"type":"text","text":". Bajo la presidencia de Hidalgo la compañía se expandió además a la radio (las emisoras Rumba en República Dominicana, Yunque 92.9 FM en Puerto Rico), sus propios estudios de grabación EMCA y el cine, produciendo películas mexicanas y puertorriqueñas en sociedad con Televisa. Durante la pandemia de 2020 produjo el álbum tributo «Billos Legendarios», en honor al director de orquesta dominicano radicado en Venezuela Billo Frómeta, con cantantes como Carlos Vives, Óscar de León y "},{"type":"artistReference","attrs":{"occurrenceId":"a3dce82c-6a84-4602-b23b-3cc23234b3f7","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Premio Ralph S. Peer","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En octubre de 2025 el Latin Songwriters Hall of Fame le entregó a Hidalgo y Estévez, como J&N Publishing, su Ralph S. Peer Publishers Award, presentado por la presidenta de la organización, Marti Cuevas —reconocimiento a un catálogo que para entonces pasaba las 20 000 obras editoriales publicadas."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"“Empezamos con una inversión de 13 mil dólares”, ha dicho Hidalgo sobre la compañía que todavía dirige —según él mismo, la única gran disquera independiente latina que sigue libre de los grandes conglomerados de la industria después de más de cuatro décadas."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-hidalgo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-hidalgo' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a74d27ab-b435-4506-a3bd-71edbe9900d8', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4b3f4d47-9174-4e6b-a842-b85456fa8c79', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'fa5c2a95-d0c5-4e20-a816-d46fc6b8487a', 'artist', 'c73737c2-0106-4a87-8dbe-5f1650d34342' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7312afb3-866d-45eb-9298-557a61118b92', 'artist', 'f838ab51-002f-4737-ab38-17f65beec9ab' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'fa1adda3-8c47-44fa-ac52-c950490c764f', 'artist', 'a77079ce-351a-4eb5-baef-de02dc1b62ce' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6cb843ce-1df7-44b7-8b3c-4e6cd5e56026', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6504822c-3867-4539-b318-1b828645c8fb', 'artist', '6fb949c4-2d6f-437f-8e7f-5f9efec847da' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a3dce82c-6a84-4602-b23b-3cc23234b3f7', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-hidalgo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Juan Hidalgo, de San Francisco de Macorís, es empresario discográfico y editor musical dominicano, presidente y cofundador, junto a Nelson Estévez, de J&N Records —la disquera independiente latina más exitosa salida de República Dominicana.

**Desde una tienda de discos en Queens**

Él y Estévez empezaron en pequeño, vendiendo LP y casetes en una tienda de Queens, Nueva York, antes de pasar a la producción. Sus dos primeras grabaciones casi no se las compró nadie más que ellos mismos; fichar a Ramón Orlando & Orquesta Internacional le dio al sello su primer éxito real y lo puso en condiciones de firmar a Los Toros Band y a la orquesta de merengue La Artillería.

**«Cachamba», y un tiburón**

Bajo la dirección de Hidalgo el sello armó un catálogo que terminaría pasando los 35 000 fonogramas. «Cachamba», de Kinito Méndez, vendió más de un millón de copias, y «El Tiburón», de Proyecto Uno, llevó al sello al merenhouse y al cruce urbano de los años noventa, la misma década en que J&N se convirtió en uno de los primeros sellos dirigidos por dominicanos en fichar a pioneros urbanos puertorriqueños como Vico C, Lisa M y Fransheska.

**El catálogo**

J&N pasó a grabar a Zacarías Ferreira, Monchy & Alexandra y decenas de otros nombres de bachata y merengue, entre ellos Rikarena. Bajo la presidencia de Hidalgo la compañía se expandió además a la radio (las emisoras Rumba en República Dominicana, Yunque 92.9 FM en Puerto Rico), sus propios estudios de grabación EMCA y el cine, produciendo películas mexicanas y puertorriqueñas en sociedad con Televisa. Durante la pandemia de 2020 produjo el álbum tributo «Billos Legendarios», en honor al director de orquesta dominicano radicado en Venezuela Billo Frómeta, con cantantes como Carlos Vives, Óscar de León y Wilfrido Vargas.

**Premio Ralph S. Peer**

En octubre de 2025 el Latin Songwriters Hall of Fame le entregó a Hidalgo y Estévez, como J&N Publishing, su Ralph S. Peer Publishers Award, presentado por la presidenta de la organización, Marti Cuevas —reconocimiento a un catálogo que para entonces pasaba las 20 000 obras editoriales publicadas.

**Legado**

“Empezamos con una inversión de 13 mil dólares”, ha dicho Hidalgo sobre la compañía que todavía dirige —según él mismo, la única gran disquera independiente latina que sigue libre de los grandes conglomerados de la industria después de más de cuatro décadas.' WHERE slug = 'juan-hidalgo';

COMMIT;
