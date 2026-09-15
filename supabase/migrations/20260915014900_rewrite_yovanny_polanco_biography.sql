BEGIN;

-- Ficha de Yovanny Polanco.
--
-- La biografía de relleno lo describía en términos genéricos, sin nombrar una sola banda,
-- disco o colaborador. Rafaelito Burdier, Aureliano Guzmán, Fidel Lora y Dagoberto Rodríguez
-- no tienen ficha: ver ARTISTAS_FALTANTES.md y MUSICOS_PENDIENTES.md.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Yovanny Polanco — born Geovanny Polanco on 2 November 1974 in Nagua — is a Dominican merengue típico accordionist, singer and composer known as «El Mambólogo»."}]},{"type":"paragraph","content":[{"type":"text","text":"An accordion at fifteen","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Son of the accordionist Julio Polanco and María Constanza de la Rosa, he moved with his family to Santo Domingo at three and to the rural community of Arroyo al Medio Arriba, Caño Teloso, at eight, before his father bought him his first accordion at fifteen. Sent to Santiago de los Caballeros at seventeen to specialize in the instrument, he started out busking around the city’s Monumento a la Restauración for tips, naming "},{"type":"artistReference","attrs":{"occurrenceId":"c934c87f-f148-4da6-887b-2481ade7fab4","artistId":"9b15dfca-0f60-49b3-a139-100a5a329741","displayText":"Tatico Henríquez"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"e7dd6779-d186-425d-8589-730013dd68b9","artistId":"ac087719-147c-47fa-9bb0-801f7a039ca7","displayText":"El Cieguito de Nagua"}},{"type":"text","text":", Rafelito Román, Lupe Valerio and Siano Arias, alongside his own father, as his main influences."}]},{"type":"paragraph","content":[{"type":"text","text":"First bands","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The store owners Fidel Lora and Dagoberto Rodríguez helped him put together his first group, «La Candela Típica», which lasted six months; a second, «Geovanny Polanco y Rafaelito Burdier», ran for two years and produced the songs that appeared on his 1999 album «Para mis amigos», among them «La historia de un gran amor» — a breakup song that has stayed in his live set ever since — «El general» and «Dile que vuelva». At twenty-four, the businessman Aureliano Guzmán backed him in forming «Geovanny Polanco y su Mambo Swing»."}]},{"type":"paragraph","content":[{"type":"text","text":"The battles of the típico","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Signed to «J&N Records», he released «¿De qué tú priva?» (2002) and followed it with a run of live albums recorded as head-to-head “battles” against other típico bandleaders — «La batalla del típico», rounds 1 through 3, and «El Prodigio vs. Geovanny Polanco, round 4» (2003), against "},{"type":"artistReference","attrs":{"occurrenceId":"06083511-8b7d-4e99-b071-07acb980e4ac","artistId":"f07fcc6b-a888-4e97-ac50-6ce6ea37a714","displayText":"El Prodigio"}},{"type":"text","text":". «Linda morenita» (2004) paired him with "},{"type":"artistReference","attrs":{"occurrenceId":"772ce240-1455-476a-9519-8b8a622c7d72","artistId":"6c3e0d74-23b7-4d80-969f-9d5319ee5127","displayText":"Alex Bueno"}},{"type":"text","text":" on «Ven mi amor», and «Lindo amanecer» followed in 2005."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He was nominated for the Premios Casandra as Conjunto Típico in both 2011 and 2012, and has continued touring internationally and recording under a stage name — Yovanny — that keeps the spelling by which he was known growing up, rather than the Geovanny on his birth certificate."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'yovanny-polanco'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'yovanny-polanco' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c934c87f-f148-4da6-887b-2481ade7fab4', 'artist', '9b15dfca-0f60-49b3-a139-100a5a329741' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'yovanny-polanco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e7dd6779-d186-425d-8589-730013dd68b9', 'artist', 'ac087719-147c-47fa-9bb0-801f7a039ca7' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'yovanny-polanco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '06083511-8b7d-4e99-b071-07acb980e4ac', 'artist', 'f07fcc6b-a888-4e97-ac50-6ce6ea37a714' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'yovanny-polanco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '772ce240-1455-476a-9519-8b8a622c7d72', 'artist', '6c3e0d74-23b7-4d80-969f-9d5319ee5127' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'yovanny-polanco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Yovanny Polanco — born Geovanny Polanco on 2 November 1974 in Nagua — is a Dominican merengue típico accordionist, singer and composer known as «El Mambólogo».

**An accordion at fifteen**

Son of the accordionist Julio Polanco and María Constanza de la Rosa, he moved with his family to Santo Domingo at three and to the rural community of Arroyo al Medio Arriba, Caño Teloso, at eight, before his father bought him his first accordion at fifteen. Sent to Santiago de los Caballeros at seventeen to specialize in the instrument, he started out busking around the city’s Monumento a la Restauración for tips, naming Tatico Henríquez, El Cieguito de Nagua, Rafelito Román, Lupe Valerio and Siano Arias, alongside his own father, as his main influences.

**First bands**

The store owners Fidel Lora and Dagoberto Rodríguez helped him put together his first group, «La Candela Típica», which lasted six months; a second, «Geovanny Polanco y Rafaelito Burdier», ran for two years and produced the songs that appeared on his 1999 album «Para mis amigos», among them «La historia de un gran amor» — a breakup song that has stayed in his live set ever since — «El general» and «Dile que vuelva». At twenty-four, the businessman Aureliano Guzmán backed him in forming «Geovanny Polanco y su Mambo Swing».

**The battles of the típico**

Signed to «J&N Records», he released «¿De qué tú priva?» (2002) and followed it with a run of live albums recorded as head-to-head “battles” against other típico bandleaders — «La batalla del típico», rounds 1 through 3, and «El Prodigio vs. Geovanny Polanco, round 4» (2003), against El Prodigio. «Linda morenita» (2004) paired him with Alex Bueno on «Ven mi amor», and «Lindo amanecer» followed in 2005.

**Legacy**

He was nominated for the Premios Casandra as Conjunto Típico in both 2011 and 2012, and has continued touring internationally and recording under a stage name — Yovanny — that keeps the spelling by which he was known growing up, rather than the Geovanny on his birth certificate.' WHERE slug = 'yovanny-polanco';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Yovanny Polanco —nacido Geovanny Polanco el 2 de noviembre de 1974 en Nagua— es acordeonista, cantante y compositor dominicano de merengue típico, conocido como «El Mambólogo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Un acordeón a los quince","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Hijo del acordeonista Julio Polanco y de María Constanza de la Rosa, se mudó con su familia a Santo Domingo a los tres años y a la comunidad rural de Arroyo al Medio Arriba, Caño Teloso, a los ocho, antes de que su padre le comprara su primer acordeón a los quince. Enviado a Santiago de los Caballeros a los diecisiete para especializarse en el instrumento, empezó tocando en los alrededores del Monumento a la Restauración por pequeñas pagas, y nombra a "},{"type":"artistReference","attrs":{"occurrenceId":"84fe2a40-5c96-4934-93ab-beb1b04189c1","artistId":"9b15dfca-0f60-49b3-a139-100a5a329741","displayText":"Tatico Henríquez"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"c892324d-8a25-4211-b0fb-bfeb61ecfddd","artistId":"ac087719-147c-47fa-9bb0-801f7a039ca7","displayText":"El Cieguito de Nagua"}},{"type":"text","text":", Rafelito Román, Lupe Valerio y Siano Arias, junto a su propio padre, como sus principales influencias."}]},{"type":"paragraph","content":[{"type":"text","text":"Primeras bandas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los comerciantes Fidel Lora y Dagoberto Rodríguez lo ayudaron a armar su primer grupo, «La Candela Típica», que duró seis meses; un segundo, «Geovanny Polanco y Rafaelito Burdier», duró dos años y produjo las canciones que aparecieron en su álbum de 1999, «Para mis amigos», entre ellas «La historia de un gran amor» —tema de despecho que se ha quedado en su repertorio en vivo desde entonces—, «El general» y «Dile que vuelva». A los veinticuatro años, el empresario Aureliano Guzmán respaldó la formación de «Geovanny Polanco y su Mambo Swing»."}]},{"type":"paragraph","content":[{"type":"text","text":"Las batallas del típico","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Firmado con «J&N Records», sacó «¿De qué tú priva?» (2002) y siguió con una serie de discos en vivo grabados como «batallas» frente a frente contra otros directores de típico —«La batalla del típico», rounds 1 al 3, y «El Prodigio vs. Geovanny Polanco, round 4» (2003), contra "},{"type":"artistReference","attrs":{"occurrenceId":"96bdaf27-8646-4a5d-9bdf-82647b05b6cc","artistId":"f07fcc6b-a888-4e97-ac50-6ce6ea37a714","displayText":"El Prodigio"}},{"type":"text","text":". «Linda morenita» (2004) lo juntó con "},{"type":"artistReference","attrs":{"occurrenceId":"dac6cc46-6107-4254-8cf2-30ffacb09603","artistId":"6c3e0d74-23b7-4d80-969f-9d5319ee5127","displayText":"Alex Bueno"}},{"type":"text","text":" en «Ven mi amor», y «Lindo amanecer» siguió en 2005."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fue nominado al Premio Casandra como Conjunto Típico tanto en 2011 como en 2012, y ha seguido de gira internacional y grabando bajo un nombre artístico —Yovanny— que conserva la grafía por la que se le conocía de niño, en vez del Geovanny de su acta de nacimiento."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'yovanny-polanco'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'yovanny-polanco' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '84fe2a40-5c96-4934-93ab-beb1b04189c1', 'artist', '9b15dfca-0f60-49b3-a139-100a5a329741' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'yovanny-polanco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c892324d-8a25-4211-b0fb-bfeb61ecfddd', 'artist', 'ac087719-147c-47fa-9bb0-801f7a039ca7' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'yovanny-polanco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '96bdaf27-8646-4a5d-9bdf-82647b05b6cc', 'artist', 'f07fcc6b-a888-4e97-ac50-6ce6ea37a714' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'yovanny-polanco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dac6cc46-6107-4254-8cf2-30ffacb09603', 'artist', '6c3e0d74-23b7-4d80-969f-9d5319ee5127' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'yovanny-polanco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Yovanny Polanco —nacido Geovanny Polanco el 2 de noviembre de 1974 en Nagua— es acordeonista, cantante y compositor dominicano de merengue típico, conocido como «El Mambólogo».

**Un acordeón a los quince**

Hijo del acordeonista Julio Polanco y de María Constanza de la Rosa, se mudó con su familia a Santo Domingo a los tres años y a la comunidad rural de Arroyo al Medio Arriba, Caño Teloso, a los ocho, antes de que su padre le comprara su primer acordeón a los quince. Enviado a Santiago de los Caballeros a los diecisiete para especializarse en el instrumento, empezó tocando en los alrededores del Monumento a la Restauración por pequeñas pagas, y nombra a Tatico Henríquez, El Cieguito de Nagua, Rafelito Román, Lupe Valerio y Siano Arias, junto a su propio padre, como sus principales influencias.

**Primeras bandas**

Los comerciantes Fidel Lora y Dagoberto Rodríguez lo ayudaron a armar su primer grupo, «La Candela Típica», que duró seis meses; un segundo, «Geovanny Polanco y Rafaelito Burdier», duró dos años y produjo las canciones que aparecieron en su álbum de 1999, «Para mis amigos», entre ellas «La historia de un gran amor» —tema de despecho que se ha quedado en su repertorio en vivo desde entonces—, «El general» y «Dile que vuelva». A los veinticuatro años, el empresario Aureliano Guzmán respaldó la formación de «Geovanny Polanco y su Mambo Swing».

**Las batallas del típico**

Firmado con «J&N Records», sacó «¿De qué tú priva?» (2002) y siguió con una serie de discos en vivo grabados como «batallas» frente a frente contra otros directores de típico —«La batalla del típico», rounds 1 al 3, y «El Prodigio vs. Geovanny Polanco, round 4» (2003), contra El Prodigio. «Linda morenita» (2004) lo juntó con Alex Bueno en «Ven mi amor», y «Lindo amanecer» siguió en 2005.

**Legado**

Fue nominado al Premio Casandra como Conjunto Típico tanto en 2011 como en 2012, y ha seguido de gira internacional y grabando bajo un nombre artístico —Yovanny— que conserva la grafía por la que se le conocía de niño, en vez del Geovanny de su acta de nacimiento.' WHERE slug = 'yovanny-polanco';

COMMIT;
