BEGIN;

-- Ficha de Bienvenido Brens.
--
-- La biografía de relleno hablaba en términos genéricos sin nombrar una sola canción,
-- intérprete o premio.
-- date_of_birth corregido de 1925-01-22 a 1925-07-30 (Wikipedia y numerosas fuentes
-- independientes coinciden en julio, no enero).

UPDATE artists SET date_of_birth = '1925-07-30' WHERE slug = 'bienvenido-brens';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Bienvenido Brens Florimón, born in Pimentel, Duarte province, on 30 July 1925 and died in Santo Domingo on 18 January 2007, was a Dominican songwriter whose boleros made him one of the leading creative voices of Antillean popular music."}]},{"type":"paragraph","content":[{"type":"text","text":"From medicine to music","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Named for his father, the composer Bienvenido Brens Galán, he studied music young under Rafael Pimentel. Family finances cut short his plans to study medicine in the capital; back home, he took up alto saxophone, learned guitar by mail-order correspondence course, and began composing."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los Alegres Dominicanos»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1944 his fellow townsman "},{"type":"artistReference","attrs":{"occurrenceId":"33e05500-ca00-464e-a6a1-aaf324f94511","artistId":"dab6636c-21fd-4e34-a0a2-e59e9e147bbd","displayText":"Luis Kalaff"}},{"type":"text","text":" invited him to join his trio, Los Alegres Dominicanos, through which he also performed Dominican folk material broadcast by the state station La Voz Dominicana."}]},{"type":"paragraph","content":[{"type":"text","text":"A songwriter for the Antilles","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"From the late 1940s his songs were recorded across Latin America: «Ninfa del Alma», inspired by his wife Celeste Bobadilla; «Bendito Amor», first recorded by "},{"type":"artistReference","attrs":{"occurrenceId":"2f0f9a4b-f9f6-4cac-8032-2e18977a7d83","artistId":"1410b448-6357-4895-a32a-58708697e10d","displayText":"Alberto Beltrán"}},{"type":"text","text":" and later covered by Las Hermanas Lago, the Argentine Leo Marini and the Mexican trio Los Tres Diamantes; and Bobby Capó’s «No, No Vuelvo» and Panchito Riset’s «Tú No Recuerdas». In 1951 the Mexican bolerista Fernando Fernández recorded and performed on film his «Peregrina Sin Amor», which went on to be recorded in fourteen different versions and became his best-known song, alongside «La Cárcel de Sing-Sing», later made famous by José Feliciano."}]},{"type":"paragraph","content":[{"type":"text","text":"Honors and later years","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1973 President Joaquín Balaguer named him a Knight of the Order of Merit of Duarte, Sánchez y Mella; the following year the Universidad Autónoma de Santo Domingo honored his contribution to Dominican music, and the town of Samaná declared him an adopted son. His catalogue continued to circulate through recordings by "},{"type":"artistReference","attrs":{"occurrenceId":"add30961-a51b-4ff5-9d44-97cbfb5d3b9c","artistId":"19124a2a-a49c-435e-989e-049b5dc3726c","displayText":"Niní Cáffaro"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"32ccdcf4-551e-41a7-919c-cad1921d6936","artistId":"8da26ee1-8079-4232-b9a2-66eccee08cb3","displayText":"Elenita Santos"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"733299f4-9805-41fa-a880-794ba9af8688","artistId":"f625be23-cfa4-43fe-8bb5-0879b2fa492f","displayText":"Vinicio Franco"}},{"type":"text","text":" and Johnny Ventura, among many others. In his last years he was slowed by Parkinson’s and Alzheimer’s, and he died of septicemia four days after its diagnosis."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A songwriter whose biggest hit was recorded fourteen separate times by singers across two continents, Bienvenido Brens turned a small Cibao town into the starting point for some of the mid-century Caribbean’s most durable boleros."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bienvenido-brens'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'bienvenido-brens' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '33e05500-ca00-464e-a6a1-aaf324f94511', 'artist', 'dab6636c-21fd-4e34-a0a2-e59e9e147bbd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-brens' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2f0f9a4b-f9f6-4cac-8032-2e18977a7d83', 'artist', '1410b448-6357-4895-a32a-58708697e10d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-brens' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'add30961-a51b-4ff5-9d44-97cbfb5d3b9c', 'artist', '19124a2a-a49c-435e-989e-049b5dc3726c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-brens' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '32ccdcf4-551e-41a7-919c-cad1921d6936', 'artist', '8da26ee1-8079-4232-b9a2-66eccee08cb3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-brens' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '733299f4-9805-41fa-a880-794ba9af8688', 'artist', 'f625be23-cfa4-43fe-8bb5-0879b2fa492f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-brens' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Bienvenido Brens Florimón, born in Pimentel, Duarte province, on 30 July 1925 and died in Santo Domingo on 18 January 2007, was a Dominican songwriter whose boleros made him one of the leading creative voices of Antillean popular music.

**From medicine to music**

Named for his father, the composer Bienvenido Brens Galán, he studied music young under Rafael Pimentel. Family finances cut short his plans to study medicine in the capital; back home, he took up alto saxophone, learned guitar by mail-order correspondence course, and began composing.

**«Los Alegres Dominicanos»**

In 1944 his fellow townsman Luis Kalaff invited him to join his trio, Los Alegres Dominicanos, through which he also performed Dominican folk material broadcast by the state station La Voz Dominicana.

**A songwriter for the Antilles**

From the late 1940s his songs were recorded across Latin America: «Ninfa del Alma», inspired by his wife Celeste Bobadilla; «Bendito Amor», first recorded by Alberto Beltrán and later covered by Las Hermanas Lago, the Argentine Leo Marini and the Mexican trio Los Tres Diamantes; and Bobby Capó’s «No, No Vuelvo» and Panchito Riset’s «Tú No Recuerdas». In 1951 the Mexican bolerista Fernando Fernández recorded and performed on film his «Peregrina Sin Amor», which went on to be recorded in fourteen different versions and became his best-known song, alongside «La Cárcel de Sing-Sing», later made famous by José Feliciano.

**Honors and later years**

In 1973 President Joaquín Balaguer named him a Knight of the Order of Merit of Duarte, Sánchez y Mella; the following year the Universidad Autónoma de Santo Domingo honored his contribution to Dominican music, and the town of Samaná declared him an adopted son. His catalogue continued to circulate through recordings by Niní Cáffaro, Elenita Santos, Vinicio Franco and Johnny Ventura, among many others. In his last years he was slowed by Parkinson’s and Alzheimer’s, and he died of septicemia four days after its diagnosis.

**Legacy**

A songwriter whose biggest hit was recorded fourteen separate times by singers across two continents, Bienvenido Brens turned a small Cibao town into the starting point for some of the mid-century Caribbean’s most durable boleros.' WHERE slug = 'bienvenido-brens';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Bienvenido Brens Florimón, nacido en Pimentel, provincia Duarte, el 30 de julio de 1925 y fallecido en Santo Domingo el 18 de enero de 2007, fue compositor dominicano cuyos boleros lo convirtieron en una de las voces creativas más importantes de la música popular antillana."}]},{"type":"paragraph","content":[{"type":"text","text":"Del sueño de la medicina a la música","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Bautizado con el nombre de su padre, el compositor Bienvenido Brens Galán, estudió música desde joven con Rafael Pimentel. Las dificultades económicas de su familia truncaron sus planes de estudiar medicina en la capital; de vuelta en su pueblo, tomó el saxofón alto, aprendió guitarra por curso de correspondencia y empezó a componer."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los Alegres Dominicanos»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1944 su coterráneo "},{"type":"artistReference","attrs":{"occurrenceId":"e4c2d712-27d2-4b63-a484-436afce0238c","artistId":"dab6636c-21fd-4e34-a0a2-e59e9e147bbd","displayText":"Luis Kalaff"}},{"type":"text","text":" lo invitó a integrar su trío, Los Alegres Dominicanos, con el que también interpretó expresiones folclóricas dominicanas difundidas por la emisora estatal La Voz Dominicana."}]},{"type":"paragraph","content":[{"type":"text","text":"Un compositor para las Antillas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Desde finales de los años cuarenta sus canciones se grabaron por toda América Latina: «Ninfa del Alma», inspirada en su esposa Celeste Bobadilla; «Bendito Amor», grabada primero por "},{"type":"artistReference","attrs":{"occurrenceId":"750a9b88-d7c6-4a86-9c2d-068417a21407","artistId":"1410b448-6357-4895-a32a-58708697e10d","displayText":"Alberto Beltrán"}},{"type":"text","text":" y después versionada por Las Hermanas Lago, el argentino Leo Marini y el trío mexicano Los Tres Diamantes; y «No, No Vuelvo» de Bobby Capó y «Tú No Recuerdas» de Panchito Riset. En 1951 el bolerista mexicano Fernando Fernández grabó e interpretó en el cine su «Peregrina Sin Amor», que llegó a grabarse en catorce versiones distintas y se convirtió en su tema más conocido, junto a «La Cárcel de Sing-Sing», inmortalizada después por José Feliciano."}]},{"type":"paragraph","content":[{"type":"text","text":"Reconocimientos y últimos años","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1973 el presidente Joaquín Balaguer lo nombró Caballero de la Orden al Mérito de Duarte, Sánchez y Mella; al año siguiente la Universidad Autónoma de Santo Domingo reconoció su aporte a la música dominicana, y el municipio de Samaná lo declaró hijo adoptivo. Su catálogo siguió circulando en grabaciones de "},{"type":"artistReference","attrs":{"occurrenceId":"7da5cbbb-0bff-4fa2-ae1c-d481ad1d89de","artistId":"19124a2a-a49c-435e-989e-049b5dc3726c","displayText":"Niní Cáffaro"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"d41a3d41-5a6e-4ec6-b2fa-399a999023c2","artistId":"8da26ee1-8079-4232-b9a2-66eccee08cb3","displayText":"Elenita Santos"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"d0d9e3c6-1d4e-427c-85e1-3a22f5670486","artistId":"f625be23-cfa4-43fe-8bb5-0879b2fa492f","displayText":"Vinicio Franco"}},{"type":"text","text":" y Johnny Ventura, entre muchos otros. En sus últimos años se vio afectado por el Parkinson y el Alzheimer, y murió de septicemia cuatro días después de ser diagnosticado."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Compositor cuyo mayor éxito se grabó catorce veces distintas por cantantes de dos continentes, Bienvenido Brens convirtió a un pequeño pueblo del Cibao en el punto de partida de algunos de los boleros más duraderos del Caribe de mediados de siglo."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bienvenido-brens'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'bienvenido-brens' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e4c2d712-27d2-4b63-a484-436afce0238c', 'artist', 'dab6636c-21fd-4e34-a0a2-e59e9e147bbd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-brens' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '750a9b88-d7c6-4a86-9c2d-068417a21407', 'artist', '1410b448-6357-4895-a32a-58708697e10d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-brens' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7da5cbbb-0bff-4fa2-ae1c-d481ad1d89de', 'artist', '19124a2a-a49c-435e-989e-049b5dc3726c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-brens' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd41a3d41-5a6e-4ec6-b2fa-399a999023c2', 'artist', '8da26ee1-8079-4232-b9a2-66eccee08cb3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-brens' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd0d9e3c6-1d4e-427c-85e1-3a22f5670486', 'artist', 'f625be23-cfa4-43fe-8bb5-0879b2fa492f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'bienvenido-brens' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Bienvenido Brens Florimón, nacido en Pimentel, provincia Duarte, el 30 de julio de 1925 y fallecido en Santo Domingo el 18 de enero de 2007, fue compositor dominicano cuyos boleros lo convirtieron en una de las voces creativas más importantes de la música popular antillana.

**Del sueño de la medicina a la música**

Bautizado con el nombre de su padre, el compositor Bienvenido Brens Galán, estudió música desde joven con Rafael Pimentel. Las dificultades económicas de su familia truncaron sus planes de estudiar medicina en la capital; de vuelta en su pueblo, tomó el saxofón alto, aprendió guitarra por curso de correspondencia y empezó a componer.

**«Los Alegres Dominicanos»**

En 1944 su coterráneo Luis Kalaff lo invitó a integrar su trío, Los Alegres Dominicanos, con el que también interpretó expresiones folclóricas dominicanas difundidas por la emisora estatal La Voz Dominicana.

**Un compositor para las Antillas**

Desde finales de los años cuarenta sus canciones se grabaron por toda América Latina: «Ninfa del Alma», inspirada en su esposa Celeste Bobadilla; «Bendito Amor», grabada primero por Alberto Beltrán y después versionada por Las Hermanas Lago, el argentino Leo Marini y el trío mexicano Los Tres Diamantes; y «No, No Vuelvo» de Bobby Capó y «Tú No Recuerdas» de Panchito Riset. En 1951 el bolerista mexicano Fernando Fernández grabó e interpretó en el cine su «Peregrina Sin Amor», que llegó a grabarse en catorce versiones distintas y se convirtió en su tema más conocido, junto a «La Cárcel de Sing-Sing», inmortalizada después por José Feliciano.

**Reconocimientos y últimos años**

En 1973 el presidente Joaquín Balaguer lo nombró Caballero de la Orden al Mérito de Duarte, Sánchez y Mella; al año siguiente la Universidad Autónoma de Santo Domingo reconoció su aporte a la música dominicana, y el municipio de Samaná lo declaró hijo adoptivo. Su catálogo siguió circulando en grabaciones de Niní Cáffaro, Elenita Santos, Vinicio Franco y Johnny Ventura, entre muchos otros. En sus últimos años se vio afectado por el Parkinson y el Alzheimer, y murió de septicemia cuatro días después de ser diagnosticado.

**Legado**

Compositor cuyo mayor éxito se grabó catorce veces distintas por cantantes de dos continentes, Bienvenido Brens convirtió a un pequeño pueblo del Cibao en el punto de partida de algunos de los boleros más duraderos del Caribe de mediados de siglo.' WHERE slug = 'bienvenido-brens';

COMMIT;
