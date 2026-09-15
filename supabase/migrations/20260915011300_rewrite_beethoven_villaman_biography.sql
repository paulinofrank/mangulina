BEGIN;

-- Ficha de Beethoven Villaman.
--
-- La biografía de relleno no daba un solo hecho verificable de su carrera: ni Los Crudos, ni
-- Lo Correcto, ni la muerte de Hitler Faraón, ni el reencuentro de 2025 con Ovni Exp en
-- «Acción Rápida». Sin fecha de nacimiento ni nombre real encontrados en ninguna fuente.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Beethoven Villaman is a Dominican MC from Santo Domingo, one of the durable names of the country’s underground rap since the late 1990s, best known for his long partnership with "},{"type":"artistReference","attrs":{"occurrenceId":"c6309132-a316-4206-b5da-b08a06f37fd1","artistId":"08ca978e-07cd-437a-8460-3eb0fbb51dcc","displayText":"Ovni Exp"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los Crudos»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He started out in 1998 in the group «Los Crudos» with his friend and colleague Hitler Faraón, later moving through «Campamento» and «Lo Correcto» — the crew that also held "},{"type":"artistReference","attrs":{"occurrenceId":"34f67259-9ae5-4ddf-bf4d-fb68f2f0c510","artistId":"08ca978e-07cd-437a-8460-3eb0fbb51dcc","displayText":"Ovni Exp"}},{"type":"text","text":", Básico, Sin Fin, Faqundo González and Crooklyn, among others. He appears alongside that lineup on Faqundo González’s «El palo ta’ dao» (2009). When independent labels such as Charles Family and Complot Records began pulling the audience away from groups like Lo Correcto around 2003 and 2004, it was reportedly DJ Scuff who pushed Villaman to answer them publicly."}]},{"type":"paragraph","content":[{"type":"text","text":"Going solo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"After Hitler Faraón’s death, Villaman stepped out as a solo artist and became a fixture of Dominican underground rap, releasing tracks such as «Harto y cansao» on the Blues Urbano platform. Hitler Faraón’s son, Disian — billed as «El Príncipe de los Crudos» — has since recorded with Villaman in his own right, among them «La de Toni»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Acción Rápida»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2025 Villaman and "},{"type":"artistReference","attrs":{"occurrenceId":"394b2bd0-3330-43f7-979f-5400cd6528b1","artistId":"08ca978e-07cd-437a-8460-3eb0fbb51dcc","displayText":"Ovni Exp"}},{"type":"text","text":" recorded together for the first time in fifteen years, on the album «Acción Rápida», a record built, by the two rappers’ own account, as a direct response to the state of rap and of Dominican society. «A nivel», one of its singles, added "},{"type":"artistReference","attrs":{"occurrenceId":"3679b20a-4daa-4cea-a8e8-1f73766f0696","artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente"}},{"type":"text","text":" to the pairing."}]},{"type":"paragraph","content":[{"type":"text","text":"«Grasa pesá»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A February 2026 bonus track, «Grasa pesá», extended the album’s reach by bringing in Lafontaine and Jotazei, two younger rappers from the Latin Guayza collective, in what the two veterans framed as a bridge between the movement’s legacy and its next generation."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Villaman’s catalogue runs in a straight line from a 1998 crew in Santo Domingo to a 2026 single shared with rappers a generation younger, by way of Lo Correcto, a solo run built after losing his closest collaborator, and a reunion with "},{"type":"artistReference","attrs":{"occurrenceId":"c263d984-8977-4064-845d-47608e3edaaa","artistId":"08ca978e-07cd-437a-8460-3eb0fbb51dcc","displayText":"Ovni Exp"}},{"type":"text","text":" that both men have called a return to first principles."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'beethoven-villaman'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'beethoven-villaman' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c6309132-a316-4206-b5da-b08a06f37fd1', 'artist', '08ca978e-07cd-437a-8460-3eb0fbb51dcc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'beethoven-villaman' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '34f67259-9ae5-4ddf-bf4d-fb68f2f0c510', 'artist', '08ca978e-07cd-437a-8460-3eb0fbb51dcc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'beethoven-villaman' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '394b2bd0-3330-43f7-979f-5400cd6528b1', 'artist', '08ca978e-07cd-437a-8460-3eb0fbb51dcc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'beethoven-villaman' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3679b20a-4daa-4cea-a8e8-1f73766f0696', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'beethoven-villaman' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c263d984-8977-4064-845d-47608e3edaaa', 'artist', '08ca978e-07cd-437a-8460-3eb0fbb51dcc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'beethoven-villaman' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Beethoven Villaman is a Dominican MC from Santo Domingo, one of the durable names of the country’s underground rap since the late 1990s, best known for his long partnership with Ovni Exp.

**«Los Crudos»**

He started out in 1998 in the group «Los Crudos» with his friend and colleague Hitler Faraón, later moving through «Campamento» and «Lo Correcto» — the crew that also held Ovni Exp, Básico, Sin Fin, Faqundo González and Crooklyn, among others. He appears alongside that lineup on Faqundo González’s «El palo ta’ dao» (2009). When independent labels such as Charles Family and Complot Records began pulling the audience away from groups like Lo Correcto around 2003 and 2004, it was reportedly DJ Scuff who pushed Villaman to answer them publicly.

**Going solo**

After Hitler Faraón’s death, Villaman stepped out as a solo artist and became a fixture of Dominican underground rap, releasing tracks such as «Harto y cansao» on the Blues Urbano platform. Hitler Faraón’s son, Disian — billed as «El Príncipe de los Crudos» — has since recorded with Villaman in his own right, among them «La de Toni».

**«Acción Rápida»**

In 2025 Villaman and Ovni Exp recorded together for the first time in fifteen years, on the album «Acción Rápida», a record built, by the two rappers’ own account, as a direct response to the state of rap and of Dominican society. «A nivel», one of its singles, added Lápiz Conciente to the pairing.

**«Grasa pesá»**

A February 2026 bonus track, «Grasa pesá», extended the album’s reach by bringing in Lafontaine and Jotazei, two younger rappers from the Latin Guayza collective, in what the two veterans framed as a bridge between the movement’s legacy and its next generation.

**Legacy**

Villaman’s catalogue runs in a straight line from a 1998 crew in Santo Domingo to a 2026 single shared with rappers a generation younger, by way of Lo Correcto, a solo run built after losing his closest collaborator, and a reunion with Ovni Exp that both men have called a return to first principles.' WHERE slug = 'beethoven-villaman';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Beethoven Villaman es un MC dominicano de Santo Domingo, una de las presencias duraderas del rap underground del país desde finales de los noventa, conocido sobre todo por su larga sociedad con "},{"type":"artistReference","attrs":{"occurrenceId":"0c77f640-43a5-4be2-afb5-dceaa2ae9aa8","artistId":"08ca978e-07cd-437a-8460-3eb0fbb51dcc","displayText":"Ovni Exp"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los Crudos»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó en 1998 en el grupo «Los Crudos» junto a su amigo y colega Hitler Faraón, y pasó después por «Campamento» y «Lo Correcto» —el colectivo que tuvo también a "},{"type":"artistReference","attrs":{"occurrenceId":"1f1ac091-95ef-44b8-ace3-c83ab9e22e95","artistId":"08ca978e-07cd-437a-8460-3eb0fbb51dcc","displayText":"Ovni Exp"}},{"type":"text","text":", Básico, Sin Fin, Faqundo González y Crooklyn, entre otros. Aparece junto a esa nómina en «El palo ta’ dao», de Faqundo González (2009). Cuando sellos independientes como Charles Family y Complot Records empezaron a llevarse al público de grupos como Lo Correcto, hacia 2003 y 2004, se cuenta que fue DJ Scuff quien empujó a Villaman a responderles en público."}]},{"type":"paragraph","content":[{"type":"text","text":"En solitario","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Tras la muerte de Hitler Faraón, Villaman salió como solista y se convirtió en una presencia fija del rap underground dominicano, con temas como «Harto y cansao» en la plataforma Blues Urbano. El hijo de Hitler Faraón, Disian —presentado como «El Príncipe de los Crudos»— ha grabado desde entonces con Villaman por cuenta propia, entre otros temas «La de Toni»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Acción Rápida»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2025 Villaman y "},{"type":"artistReference","attrs":{"occurrenceId":"a8ae9290-4747-4c68-a470-bc6e533c6247","artistId":"08ca978e-07cd-437a-8460-3eb0fbb51dcc","displayText":"Ovni Exp"}},{"type":"text","text":" grabaron juntos por primera vez en quince años, en el álbum «Acción Rápida», un disco que los propios raperos describen como una respuesta directa al estado del rap y de la sociedad dominicana. «A nivel», uno de sus sencillos, sumó a "},{"type":"artistReference","attrs":{"occurrenceId":"91103e49-a94d-45c2-aabf-5b4fda8372f2","artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente"}},{"type":"text","text":" a la dupla."}]},{"type":"paragraph","content":[{"type":"text","text":"«Grasa pesá»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Un bonustrack de febrero de 2026, «Grasa pesá», amplió el alcance del álbum sumando a Lafontaine y Jotazei, dos raperos más jóvenes del colectivo Latin Guayza, en lo que los dos veteranos plantearon como un puente entre el legado del movimiento y su siguiente generación."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El catálogo de Villaman va en línea recta de un grupo de 1998 en Santo Domingo a un sencillo de 2026 compartido con raperos una generación más jóvenes, pasando por Lo Correcto, una carrera en solitario armada tras perder a su colaborador más cercano, y un reencuentro con "},{"type":"artistReference","attrs":{"occurrenceId":"53ca2b13-fe83-42e6-8b5a-b0dc89a8b222","artistId":"08ca978e-07cd-437a-8460-3eb0fbb51dcc","displayText":"Ovni Exp"}},{"type":"text","text":" que los dos han descrito como una vuelta a los principios."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'beethoven-villaman'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'beethoven-villaman' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0c77f640-43a5-4be2-afb5-dceaa2ae9aa8', 'artist', '08ca978e-07cd-437a-8460-3eb0fbb51dcc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'beethoven-villaman' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1f1ac091-95ef-44b8-ace3-c83ab9e22e95', 'artist', '08ca978e-07cd-437a-8460-3eb0fbb51dcc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'beethoven-villaman' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a8ae9290-4747-4c68-a470-bc6e533c6247', 'artist', '08ca978e-07cd-437a-8460-3eb0fbb51dcc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'beethoven-villaman' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '91103e49-a94d-45c2-aabf-5b4fda8372f2', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'beethoven-villaman' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '53ca2b13-fe83-42e6-8b5a-b0dc89a8b222', 'artist', '08ca978e-07cd-437a-8460-3eb0fbb51dcc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'beethoven-villaman' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Beethoven Villaman es un MC dominicano de Santo Domingo, una de las presencias duraderas del rap underground del país desde finales de los noventa, conocido sobre todo por su larga sociedad con Ovni Exp.

**«Los Crudos»**

Empezó en 1998 en el grupo «Los Crudos» junto a su amigo y colega Hitler Faraón, y pasó después por «Campamento» y «Lo Correcto» —el colectivo que tuvo también a Ovni Exp, Básico, Sin Fin, Faqundo González y Crooklyn, entre otros. Aparece junto a esa nómina en «El palo ta’ dao», de Faqundo González (2009). Cuando sellos independientes como Charles Family y Complot Records empezaron a llevarse al público de grupos como Lo Correcto, hacia 2003 y 2004, se cuenta que fue DJ Scuff quien empujó a Villaman a responderles en público.

**En solitario**

Tras la muerte de Hitler Faraón, Villaman salió como solista y se convirtió en una presencia fija del rap underground dominicano, con temas como «Harto y cansao» en la plataforma Blues Urbano. El hijo de Hitler Faraón, Disian —presentado como «El Príncipe de los Crudos»— ha grabado desde entonces con Villaman por cuenta propia, entre otros temas «La de Toni».

**«Acción Rápida»**

En 2025 Villaman y Ovni Exp grabaron juntos por primera vez en quince años, en el álbum «Acción Rápida», un disco que los propios raperos describen como una respuesta directa al estado del rap y de la sociedad dominicana. «A nivel», uno de sus sencillos, sumó a Lápiz Conciente a la dupla.

**«Grasa pesá»**

Un bonustrack de febrero de 2026, «Grasa pesá», amplió el alcance del álbum sumando a Lafontaine y Jotazei, dos raperos más jóvenes del colectivo Latin Guayza, en lo que los dos veteranos plantearon como un puente entre el legado del movimiento y su siguiente generación.

**Legado**

El catálogo de Villaman va en línea recta de un grupo de 1998 en Santo Domingo a un sencillo de 2026 compartido con raperos una generación más jóvenes, pasando por Lo Correcto, una carrera en solitario armada tras perder a su colaborador más cercano, y un reencuentro con Ovni Exp que los dos han descrito como una vuelta a los principios.' WHERE slug = 'beethoven-villaman';

COMMIT;
