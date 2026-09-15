BEGIN;

-- Ficha de El Jeffrey.
--
-- La biografía de relleno inventaba un nombre de nacimiento ("Jeffrey Gómez"); la fila
-- guardaba otro sin fuente clara ("José García"). El nombre real, documentado por Wikipedia,
-- EcuRed y Last.fm, es José Gabriel Severino. Un premio registrado: Casandra 2005, Orquesta
-- del Año (prensa de la época la llama "Mejor Orquesta"). Nelson Gil, Joan Minaya, Jaqueline
-- «La Rubia», Tony López, Alfredo Sisa «Makumba» y Evelio Herrera no tienen ficha: ver
-- ARTISTAS_FALTANTES.md y MUSICOS_PENDIENTES.md.

UPDATE artists SET first_name = 'José Gabriel', last_name = 'Severino' WHERE slug = 'el-jeffrey';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2005, 'Prensa de la época la llama "Mejor Orquesta"', true, 'Wikipedia (es); Diario Libre (12 ago 2005, 1 dic 2005, 16 mar 2005, todas contemporáneas)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'el-jeffrey' AND a.name = 'Premios Casandra' AND cat.name = 'Orquesta del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2005);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"El Jeffrey — José Gabriel Severino, born 1 April 1974 in Santiago de los Caballeros — is a Dominican merengue singer, songwriter and producer, one of the genre’s most durable solo names since the late 1980s."}]},{"type":"paragraph","content":[{"type":"text","text":"La Artillería","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"At about fourteen he joined La Artillería, the merengue orchestra, sharing the stage with Nelson Gil, Joan Minaya and Jaqueline «La Rubia» and singing songs — «Los celos», «Soy yo», «Otra noche» — that stayed in his repertoire for the rest of his career."}]},{"type":"paragraph","content":[{"type":"text","text":"Going solo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He left the group to build an independent career; some discographies date its start to 1994’s «Por qué te siento aquí». His first widely distributed album, «Jeffrey para el mundo» (EMI, 1998), carried «Un mal necesario» and «Mujer infiel» among others."}]},{"type":"paragraph","content":[{"type":"text","text":"«Mi tierra», and a Casandra","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His commercial breakthrough came in the early 2000s with «Mi tierra» — «Pobre diablo», «La noche», «Cuéntale a él», «Palabritas» among its tracks — whose 2004 promotion won him the 2005 Premios Casandra for best orchestra; «Palabritas» went on to reach No. 33 on Billboard’s Tropical Airplay chart in 2006. The follow-up, «Mi vida» (2005), paired him with "},{"type":"artistReference","attrs":{"occurrenceId":"74aa1c9e-c121-448a-aaf3-b5795df141ab","artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura"}},{"type":"text","text":" on «La mujer que nos gusta» and "},{"type":"artistReference","attrs":{"occurrenceId":"5b3a96fb-64c5-4a4f-ab76-b0cb07000264","artistId":"864288d0-a26a-4568-914a-d20c3b88ddcb","displayText":"Papi Sánchez"}},{"type":"text","text":" on «Tu secreto», and he also cut a ballad version of «Por amor» with its composer, "},{"type":"artistReference","attrs":{"occurrenceId":"b0deed98-6e95-4350-9e26-ddf84debf684","artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano"}},{"type":"text","text":", and the singer "},{"type":"artistReference","attrs":{"occurrenceId":"f71a2352-3994-4298-9567-a9fd4b292748","artistId":"19124a2a-a49c-435e-989e-049b5dc3726c","displayText":"Niní Cáffaro"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Staying current","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Voy a ser grande» (2007), written by Tony López and arranged by Alfredo Sisa «Makumba», and «Yo soy merengue» (2011), released under Sánchez Family Entertainment, kept him on the radio through the following decade, during which he pushed merengue toward electronic and urban production while keeping the güira and tambora at its core; in 2021 he released a merengue version of Ozuna’s «Qué pena» as a preview of the project «Mi regreso»."}]},{"type":"paragraph","content":[{"type":"text","text":"Screen and stage","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He acted in the 2007 comedy «Sanky Panky» as Miguelito and appeared musically in the 2017 documentary «Hay un país en el mundo», alongside "},{"type":"artistReference","attrs":{"occurrenceId":"87bfcefc-350a-44ab-a43d-dcbbea8773cd","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"a847a64e-bf76-4a97-ab79-cca070309b31","artistId":"15c08a48-b94b-41c8-99d8-53144397c787","displayText":"Krisspy"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"caec16fe-de81-4a54-b7f8-a7f735bfa6f8","artistId":"8c784f57-4ee4-41b5-b140-c45d0da1c5f6","displayText":"Joseíto Mateo"}},{"type":"text","text":". In July 2024 he marked twenty-five years as an independent artist with the show «Mi tierra» at Hard Rock Live Santo Domingo, joined by "},{"type":"artistReference","attrs":{"occurrenceId":"17cfdc2e-dd1e-4680-99e2-31331c06e6b4","artistId":"02b306b3-acc0-4800-b314-05683205d1c5","displayText":"Jossie Esteban y La Patrulla 15"}},{"type":"text","text":", Krisspy and Fernando Villalona — a concert later nominated for Concierto del Año at the 2025 Premios Soberano."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"After "},{"type":"artistReference","attrs":{"occurrenceId":"663e79be-b5c4-4875-938d-4385c880d3e7","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":"’s death in April 2025, El Jeffrey released the tribute «Rubby vive en mí», having sung Pérez’s songs at his funeral rites; in January 2026 he issued a live retrospective, «Lo mejor de mí», closing in on four decades since a fourteen-year-old from Santiago first stepped on stage with La Artillería."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'el-jeffrey'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'el-jeffrey' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '74aa1c9e-c121-448a-aaf3-b5795df141ab', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5b3a96fb-64c5-4a4f-ab76-b0cb07000264', 'artist', '864288d0-a26a-4568-914a-d20c3b88ddcb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b0deed98-6e95-4350-9e26-ddf84debf684', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f71a2352-3994-4298-9567-a9fd4b292748', 'artist', '19124a2a-a49c-435e-989e-049b5dc3726c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '87bfcefc-350a-44ab-a43d-dcbbea8773cd', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a847a64e-bf76-4a97-ab79-cca070309b31', 'artist', '15c08a48-b94b-41c8-99d8-53144397c787' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'caec16fe-de81-4a54-b7f8-a7f735bfa6f8', 'artist', '8c784f57-4ee4-41b5-b140-c45d0da1c5f6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '17cfdc2e-dd1e-4680-99e2-31331c06e6b4', 'artist', '02b306b3-acc0-4800-b314-05683205d1c5' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '663e79be-b5c4-4875-938d-4385c880d3e7', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'El Jeffrey — José Gabriel Severino, born 1 April 1974 in Santiago de los Caballeros — is a Dominican merengue singer, songwriter and producer, one of the genre’s most durable solo names since the late 1980s.

**La Artillería**

At about fourteen he joined La Artillería, the merengue orchestra, sharing the stage with Nelson Gil, Joan Minaya and Jaqueline «La Rubia» and singing songs — «Los celos», «Soy yo», «Otra noche» — that stayed in his repertoire for the rest of his career.

**Going solo**

He left the group to build an independent career; some discographies date its start to 1994’s «Por qué te siento aquí». His first widely distributed album, «Jeffrey para el mundo» (EMI, 1998), carried «Un mal necesario» and «Mujer infiel» among others.

**«Mi tierra», and a Casandra**

His commercial breakthrough came in the early 2000s with «Mi tierra» — «Pobre diablo», «La noche», «Cuéntale a él», «Palabritas» among its tracks — whose 2004 promotion won him the 2005 Premios Casandra for best orchestra; «Palabritas» went on to reach No. 33 on Billboard’s Tropical Airplay chart in 2006. The follow-up, «Mi vida» (2005), paired him with Johnny Ventura on «La mujer que nos gusta» and Papi Sánchez on «Tu secreto», and he also cut a ballad version of «Por amor» with its composer, Rafael Solano, and the singer Niní Cáffaro.

**Staying current**

«Voy a ser grande» (2007), written by Tony López and arranged by Alfredo Sisa «Makumba», and «Yo soy merengue» (2011), released under Sánchez Family Entertainment, kept him on the radio through the following decade, during which he pushed merengue toward electronic and urban production while keeping the güira and tambora at its core; in 2021 he released a merengue version of Ozuna’s «Qué pena» as a preview of the project «Mi regreso».

**Screen and stage**

He acted in the 2007 comedy «Sanky Panky» as Miguelito and appeared musically in the 2017 documentary «Hay un país en el mundo», alongside Fernando Villalona, Krisspy and Joseíto Mateo. In July 2024 he marked twenty-five years as an independent artist with the show «Mi tierra» at Hard Rock Live Santo Domingo, joined by Jossie Esteban y La Patrulla 15, Krisspy and Fernando Villalona — a concert later nominated for Concierto del Año at the 2025 Premios Soberano.

**Legacy**

After Rubby Pérez’s death in April 2025, El Jeffrey released the tribute «Rubby vive en mí», having sung Pérez’s songs at his funeral rites; in January 2026 he issued a live retrospective, «Lo mejor de mí», closing in on four decades since a fourteen-year-old from Santiago first stepped on stage with La Artillería.' WHERE slug = 'el-jeffrey';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"El Jeffrey —José Gabriel Severino, nacido el 1 de abril de 1974 en Santiago de los Caballeros— es cantante, compositor y productor dominicano de merengue, uno de los nombres solistas más duraderos del género desde finales de los años ochenta."}]},{"type":"paragraph","content":[{"type":"text","text":"La Artillería","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Hacia los catorce años entró en La Artillería, orquesta de merengue, compartiendo escenario con Nelson Gil, Joan Minaya y Jaqueline «La Rubia» y cantando temas —«Los celos», «Soy yo», «Otra noche»— que se quedaron en su repertorio el resto de su carrera."}]},{"type":"paragraph","content":[{"type":"text","text":"En solitario","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Dejó el grupo para hacer carrera independiente; algunas discografías sitúan su arranque en solitario en 1994, con «Por qué te siento aquí». Su primer álbum de amplia distribución, «Jeffrey para el mundo» (EMI, 1998), llevó «Un mal necesario» y «Mujer infiel», entre otros."}]},{"type":"paragraph","content":[{"type":"text","text":"«Mi tierra», y un Casandra","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su despegue comercial llegó a inicios de los dos mil con «Mi tierra» —«Pobre diablo», «La noche», «Cuéntale a él», «Palabritas», entre sus temas—, cuya promoción de 2004 le ganó el Premio Casandra de 2005 a mejor orquesta; «Palabritas» llegó después al puesto 33 de la lista Tropical Airplay de Billboard, en 2006. La siguiente producción, «Mi vida» (2005), lo juntó con "},{"type":"artistReference","attrs":{"occurrenceId":"c4054b6b-b91a-41fb-92fa-c9845294a830","artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura"}},{"type":"text","text":" en «La mujer que nos gusta» y con "},{"type":"artistReference","attrs":{"occurrenceId":"82bdeac4-5f7f-4c49-8e64-ca3e8a35dd3c","artistId":"864288d0-a26a-4568-914a-d20c3b88ddcb","displayText":"Papi Sánchez"}},{"type":"text","text":" en «Tu secreto», y grabó además una versión en balada de «Por amor» con su compositor, "},{"type":"artistReference","attrs":{"occurrenceId":"134b14dc-eeca-49fa-950a-03457c7ee8b4","artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano"}},{"type":"text","text":", y el cantante "},{"type":"artistReference","attrs":{"occurrenceId":"bbb769c2-9893-40d8-9e17-9fdb6ad472f0","artistId":"19124a2a-a49c-435e-989e-049b5dc3726c","displayText":"Niní Cáffaro"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Manteniéndose vigente","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Voy a ser grande» (2007), escrito por Tony López y arreglado por Alfredo Sisa «Makumba», y «Yo soy merengue» (2011), publicado bajo Sánchez Family Entertainment, lo mantuvieron en la radio durante la década siguiente, en la que empujó el merengue hacia una producción electrónica y urbana sin soltar la güira y la tambora; en 2021 sacó una versión en merengue de «Qué pena», de Ozuna, como adelanto del proyecto «Mi regreso»."}]},{"type":"paragraph","content":[{"type":"text","text":"Pantalla y escenario","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Actuó en la comedia «Sanky Panky» (2007) como Miguelito y participó musicalmente en el documental «Hay un país en el mundo» (2017), junto a "},{"type":"artistReference","attrs":{"occurrenceId":"be4cdc2b-0d1e-4602-9b46-29be37c23a74","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"5bba5988-f397-4316-beb3-203150d1b208","artistId":"15c08a48-b94b-41c8-99d8-53144397c787","displayText":"Krisspy"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"64baf2a0-c6f4-4b06-b65c-e48910ed9e1c","artistId":"8c784f57-4ee4-41b5-b140-c45d0da1c5f6","displayText":"Joseíto Mateo"}},{"type":"text","text":". En julio de 2024 celebró sus veinticinco años como artista independiente con el espectáculo «Mi tierra», en el Hard Rock Live de Santo Domingo, acompañado por "},{"type":"artistReference","attrs":{"occurrenceId":"db1c8c2d-1c45-46ec-bb34-2c2d77aea82a","artistId":"02b306b3-acc0-4800-b314-05683205d1c5","displayText":"Jossie Esteban y La Patrulla 15"}},{"type":"text","text":", Krisspy y Fernando Villalona —concierto nominado después a Concierto del Año en los Premios Soberano de 2025."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Tras la muerte de "},{"type":"artistReference","attrs":{"occurrenceId":"4fbeb004-e3e6-459e-a1e6-cfd511f7b8db","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":" en abril de 2025, El Jeffrey publicó el tributo «Rubby vive en mí», después de haber cantado temas de Pérez en sus honras fúnebres; en enero de 2026 sacó un retrospectivo en vivo, «Lo mejor de mí», cerca ya de cuatro décadas desde que un muchacho de catorce años de Santiago subió por primera vez a un escenario con La Artillería."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'el-jeffrey'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'el-jeffrey' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c4054b6b-b91a-41fb-92fa-c9845294a830', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '82bdeac4-5f7f-4c49-8e64-ca3e8a35dd3c', 'artist', '864288d0-a26a-4568-914a-d20c3b88ddcb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '134b14dc-eeca-49fa-950a-03457c7ee8b4', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'bbb769c2-9893-40d8-9e17-9fdb6ad472f0', 'artist', '19124a2a-a49c-435e-989e-049b5dc3726c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'be4cdc2b-0d1e-4602-9b46-29be37c23a74', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5bba5988-f397-4316-beb3-203150d1b208', 'artist', '15c08a48-b94b-41c8-99d8-53144397c787' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '64baf2a0-c6f4-4b06-b65c-e48910ed9e1c', 'artist', '8c784f57-4ee4-41b5-b140-c45d0da1c5f6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'db1c8c2d-1c45-46ec-bb34-2c2d77aea82a', 'artist', '02b306b3-acc0-4800-b314-05683205d1c5' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4fbeb004-e3e6-459e-a1e6-cfd511f7b8db', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'el-jeffrey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'El Jeffrey —José Gabriel Severino, nacido el 1 de abril de 1974 en Santiago de los Caballeros— es cantante, compositor y productor dominicano de merengue, uno de los nombres solistas más duraderos del género desde finales de los años ochenta.

**La Artillería**

Hacia los catorce años entró en La Artillería, orquesta de merengue, compartiendo escenario con Nelson Gil, Joan Minaya y Jaqueline «La Rubia» y cantando temas —«Los celos», «Soy yo», «Otra noche»— que se quedaron en su repertorio el resto de su carrera.

**En solitario**

Dejó el grupo para hacer carrera independiente; algunas discografías sitúan su arranque en solitario en 1994, con «Por qué te siento aquí». Su primer álbum de amplia distribución, «Jeffrey para el mundo» (EMI, 1998), llevó «Un mal necesario» y «Mujer infiel», entre otros.

**«Mi tierra», y un Casandra**

Su despegue comercial llegó a inicios de los dos mil con «Mi tierra» —«Pobre diablo», «La noche», «Cuéntale a él», «Palabritas», entre sus temas—, cuya promoción de 2004 le ganó el Premio Casandra de 2005 a mejor orquesta; «Palabritas» llegó después al puesto 33 de la lista Tropical Airplay de Billboard, en 2006. La siguiente producción, «Mi vida» (2005), lo juntó con Johnny Ventura en «La mujer que nos gusta» y con Papi Sánchez en «Tu secreto», y grabó además una versión en balada de «Por amor» con su compositor, Rafael Solano, y el cantante Niní Cáffaro.

**Manteniéndose vigente**

«Voy a ser grande» (2007), escrito por Tony López y arreglado por Alfredo Sisa «Makumba», y «Yo soy merengue» (2011), publicado bajo Sánchez Family Entertainment, lo mantuvieron en la radio durante la década siguiente, en la que empujó el merengue hacia una producción electrónica y urbana sin soltar la güira y la tambora; en 2021 sacó una versión en merengue de «Qué pena», de Ozuna, como adelanto del proyecto «Mi regreso».

**Pantalla y escenario**

Actuó en la comedia «Sanky Panky» (2007) como Miguelito y participó musicalmente en el documental «Hay un país en el mundo» (2017), junto a Fernando Villalona, Krisspy y Joseíto Mateo. En julio de 2024 celebró sus veinticinco años como artista independiente con el espectáculo «Mi tierra», en el Hard Rock Live de Santo Domingo, acompañado por Jossie Esteban y La Patrulla 15, Krisspy y Fernando Villalona —concierto nominado después a Concierto del Año en los Premios Soberano de 2025.

**Legado**

Tras la muerte de Rubby Pérez en abril de 2025, El Jeffrey publicó el tributo «Rubby vive en mí», después de haber cantado temas de Pérez en sus honras fúnebres; en enero de 2026 sacó un retrospectivo en vivo, «Lo mejor de mí», cerca ya de cuatro décadas desde que un muchacho de catorce años de Santiago subió por primera vez a un escenario con La Artillería.' WHERE slug = 'el-jeffrey';

COMMIT;
