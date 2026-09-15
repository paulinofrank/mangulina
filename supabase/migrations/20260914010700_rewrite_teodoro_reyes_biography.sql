BEGIN;

-- Ficha de Teodoro Reyes.
--
-- birth_place Mao / province Valverde -> Nagua / María Trinidad Sánchez: él mismo
-- (País Político 2024), El Día 2017, ESENDOM 2019, EcuRed y Bachata Republic.
-- aliases El Cieguito Sabio; occupations songwriter (autor de «La hamaquita»,
-- «El masaje» y «El niño mimado» para Fernando Villalona: El Día, ESENDOM).
--
-- Premio: Casandra Bachatero del Año 1994, primer ganador del renglón (El Día
-- 2017, ESENDOM 2019, Bachata Republic). La lista de ganadores de Bachata Republic
-- lo pone en 1995, que parece el año de la gala; convención: año adjudicado.
-- CONFLICTO: antony-santos tiene un Bachatero del Año 1993; no se tocó.

UPDATE artists SET birth_place = 'Nagua', province = 'María Trinidad Sánchez', aliases = ARRAY['El Cieguito Sabio']::text[],
       occupations = '["songwriter"]'::jsonb WHERE slug = 'teodoro-reyes';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 1994, NULL, true, 'El Día (17 may 2017) y ESENDOM (23 oct 2019): primer bachatero ganador del renglón; Bachata Republic lo lista en 1995 (año de gala)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'teodoro-reyes' AND a.name = 'Premios Casandra' AND cat.name = 'Bachatero del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 1994);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Teodoro Reyes — born blind in Nagua on 27 March 1954 and known as El Cieguito Sabio — is a Dominican bachata singer and songwriter. He wrote «La hamaquita» and other early-1980s hits for "},{"type":"artistReference","attrs":{"occurrenceId":"26e27470-b788-4ba7-8cb4-294877d2cb87","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":", spent years singing on the beach at Boca Chica, and in 1994 became the first winner of the Bachatero del Año category at the «Premios Casandra», with the album that carried «Los pobres también aman» and «Vuelve con tu papá»."}]},{"type":"paragraph","content":[{"type":"text","text":"Nagua and the school for the blind","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As a child in Nagua he played at neighbourhood parties on whatever he could find, making a tambora from an oil can and a güira from a tin. The music around him was merengue típico — "},{"type":"artistReference","attrs":{"occurrenceId":"0dae881c-82ff-4e07-a10d-ceabbbb97054","artistId":"9b15dfca-0f60-49b3-a139-100a5a329741","displayText":"Tatico Henríquez"}},{"type":"text","text":" came from the same region — and típico remained his favourite. At twelve, against his family’s wishes, he left home to enrol at the «Escuela Nacional de Ciegos» in Santo Domingo, where he learned to read and write and stayed eight years, finishing secondary school. His classmates teased him that he had a bachatero’s voice."}]},{"type":"paragraph","content":[{"type":"text","text":"He played tambora in the group of Félix Quintana, tried the accordion and found it too heavy, and at the end of the 1970s took up the guitar, which he still uses to compose."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs for Fernando Villalona","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His first success came as a writer. "},{"type":"artistReference","attrs":{"occurrenceId":"efa0fcd3-af47-4fdd-b43a-58dd74dc2c5d","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":" recorded his «La hamaquita», «El masaje» and «El niño mimado»; Reyes has said that he was paid 600 pesos for the first two, and that the royalties only came later, once his name was known."}]},{"type":"paragraph","content":[{"type":"text","text":"Boca Chica","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His own first hit, «Lindas palabritas», came in the mid-1980s, but for years afterwards he made his living singing for visitors on the beach at Boca Chica. When the owner of a venue there told him the public was tired of hearing him and brought in "},{"type":"artistReference","attrs":{"occurrenceId":"eab9d500-b324-4056-a622-94dffc1a5a8c","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":" instead, Reyes tried to get onto the same bill and failed; a week later he waited at the door of a club in Santo Domingo to meet "},{"type":"artistReference","attrs":{"occurrenceId":"75ed167a-8146-4f83-ae84-7a3db8065090","artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez"}},{"type":"text","text":", who walked past him. He has described those two rejections as what drove him to record an album of his own."}]},{"type":"paragraph","content":[{"type":"text","text":"Sentimiento","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"That album, twelve songs of love, heartbreak and humour, set his bachata to livelier, faster arrangements than the genre usually had, and nearly every track was played. «Los pobres también aman», «Vuelve con tu papá», «Muriendo de amor» and «Amor bonito» made him one of the leading bachateros of the decade, and «ACROARTE» named him Bachatero del Año for 1994 — the first time the «Premios Casandra» gave that award, after years in which the ceremony had left bachateros out. Alongside "},{"type":"artistReference","attrs":{"occurrenceId":"78aaa5b1-d785-4f9b-a861-6bf7d2637bbd","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"2fffd288-13c4-4d6d-8682-058645742825","artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"5297d6be-a402-4972-a912-e3f452f624e2","artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"b1fdbd41-3d68-4871-8e76-95e0f5523c27","artistId":"31915623-3206-4052-b13a-2170226671b9","displayText":"Leonardo Paniagua"}},{"type":"text","text":", he was part of the generation that carried the music of amargue into the mainstream."}]},{"type":"paragraph","content":[{"type":"text","text":"Abroad and in duet","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His songs have taken him to the United States, Venezuela, Panama, Spain, Italy, Switzerland and Austria; in 2017 he returned from a European tour of more than thirty dates. In 2019 "},{"type":"artistReference","attrs":{"occurrenceId":"4ab1ce29-595b-4b4e-86c7-d82ee8428054","artistId":"8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3","displayText":"Romeo Santos"}},{"type":"text","text":" invited him to sing «Ileso» on «Utopía», an album of duets with bachateros of the previous generation. In 2024 he announced «La chica de baile», twelve songs each named after a woman."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Teodoro Reyes combined the confessional bachata of the 1990s with a humour and a tearful, playful voice of his own, and he is one of the few bachateros of his generation whose songs are still sung by listeners much younger than they are. His catalogue as a writer spans both merengue, through the hits he gave "},{"type":"artistReference","attrs":{"occurrenceId":"1f04a86f-b5d2-4d84-9ae1-40918e68463d","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":", and bachata, through his own."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'teodoro-reyes'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'teodoro-reyes' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '26e27470-b788-4ba7-8cb4-294877d2cb87', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0dae881c-82ff-4e07-a10d-ceabbbb97054', 'artist', '9b15dfca-0f60-49b3-a139-100a5a329741' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'efa0fcd3-af47-4fdd-b43a-58dd74dc2c5d', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'eab9d500-b324-4056-a622-94dffc1a5a8c', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '75ed167a-8146-4f83-ae84-7a3db8065090', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '78aaa5b1-d785-4f9b-a861-6bf7d2637bbd', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2fffd288-13c4-4d6d-8682-058645742825', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5297d6be-a402-4972-a912-e3f452f624e2', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b1fdbd41-3d68-4871-8e76-95e0f5523c27', 'artist', '31915623-3206-4052-b13a-2170226671b9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4ab1ce29-595b-4b4e-86c7-d82ee8428054', 'artist', '8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1f04a86f-b5d2-4d84-9ae1-40918e68463d', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Teodoro Reyes — born blind in Nagua on 27 March 1954 and known as El Cieguito Sabio — is a Dominican bachata singer and songwriter. He wrote «La hamaquita» and other early-1980s hits for Fernando Villalona, spent years singing on the beach at Boca Chica, and in 1994 became the first winner of the Bachatero del Año category at the «Premios Casandra», with the album that carried «Los pobres también aman» and «Vuelve con tu papá».

**Nagua and the school for the blind**

As a child in Nagua he played at neighbourhood parties on whatever he could find, making a tambora from an oil can and a güira from a tin. The music around him was merengue típico — Tatico Henríquez came from the same region — and típico remained his favourite. At twelve, against his family’s wishes, he left home to enrol at the «Escuela Nacional de Ciegos» in Santo Domingo, where he learned to read and write and stayed eight years, finishing secondary school. His classmates teased him that he had a bachatero’s voice.

He played tambora in the group of Félix Quintana, tried the accordion and found it too heavy, and at the end of the 1970s took up the guitar, which he still uses to compose.

**Songs for Fernando Villalona**

His first success came as a writer. Fernando Villalona recorded his «La hamaquita», «El masaje» and «El niño mimado»; Reyes has said that he was paid 600 pesos for the first two, and that the royalties only came later, once his name was known.

**Boca Chica**

His own first hit, «Lindas palabritas», came in the mid-1980s, but for years afterwards he made his living singing for visitors on the beach at Boca Chica. When the owner of a venue there told him the public was tired of hearing him and brought in Antony Santos instead, Reyes tried to get onto the same bill and failed; a week later he waited at the door of a club in Santo Domingo to meet Raulín Rodríguez, who walked past him. He has described those two rejections as what drove him to record an album of his own.

**Sentimiento**

That album, twelve songs of love, heartbreak and humour, set his bachata to livelier, faster arrangements than the genre usually had, and nearly every track was played. «Los pobres también aman», «Vuelve con tu papá», «Muriendo de amor» and «Amor bonito» made him one of the leading bachateros of the decade, and «ACROARTE» named him Bachatero del Año for 1994 — the first time the «Premios Casandra» gave that award, after years in which the ceremony had left bachateros out. Alongside Antony Santos, Raulín Rodríguez, Luis Vargas and Leonardo Paniagua, he was part of the generation that carried the music of amargue into the mainstream.

**Abroad and in duet**

His songs have taken him to the United States, Venezuela, Panama, Spain, Italy, Switzerland and Austria; in 2017 he returned from a European tour of more than thirty dates. In 2019 Romeo Santos invited him to sing «Ileso» on «Utopía», an album of duets with bachateros of the previous generation. In 2024 he announced «La chica de baile», twelve songs each named after a woman.

**Legacy**

Teodoro Reyes combined the confessional bachata of the 1990s with a humour and a tearful, playful voice of his own, and he is one of the few bachateros of his generation whose songs are still sung by listeners much younger than they are. His catalogue as a writer spans both merengue, through the hits he gave Fernando Villalona, and bachata, through his own.' WHERE slug = 'teodoro-reyes';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Teodoro Reyes —nacido ciego en Nagua el 27 de marzo de 1954 y conocido como El Cieguito Sabio— es cantante y compositor dominicano de bachata. Escribió «La hamaquita» y otros éxitos de principios de los ochenta para "},{"type":"artistReference","attrs":{"occurrenceId":"2e5b078f-e0eb-4271-8f8b-fde78d251369","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":", pasó años cantando en la playa de Boca Chica y en 1994 fue el primer ganador del renglón Bachatero del Año de los «Premios Casandra», con el disco de «Los pobres también aman» y «Vuelve con tu papá»."}]},{"type":"paragraph","content":[{"type":"text","text":"Nagua y la Escuela de Ciegos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De niño, en Nagua, animaba las fiestas del barrio con lo que tuviera a mano: se hizo una tambora con un galón de aceite y una güira con una lata. La música que lo rodeaba era el merengue típico —"},{"type":"artistReference","attrs":{"occurrenceId":"419f938c-320f-4cb5-be4a-b845157517e4","artistId":"9b15dfca-0f60-49b3-a139-100a5a329741","displayText":"Tatico Henríquez"}},{"type":"text","text":" salió de esa misma región—, y el típico siguió siendo su preferido. A los doce años, contra la voluntad de su familia, se fue de la casa para entrar en la «Escuela Nacional de Ciegos», en Santo Domingo, donde aprendió a leer y a escribir, pasó ocho años y se hizo bachiller. Sus compañeros se burlaban diciéndole que tenía voz de bachatero."}]},{"type":"paragraph","content":[{"type":"text","text":"Tocó tambora en el grupo de Félix Quintana, probó el acordeón y lo encontró muy pesado, y a finales de los setenta se quedó con la guitarra, con la que todavía compone."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones para Fernando Villalona","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su primer éxito llegó como autor. "},{"type":"artistReference","attrs":{"occurrenceId":"d6f73c68-69a6-45c1-b0e9-4db127771c76","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":" le grabó «La hamaquita», «El masaje» y «El niño mimado»; Reyes ha contado que por las dos primeras le pagaron 600 pesos, y que los derechos de autor le llegaron después, cuando ya se conocía su nombre."}]},{"type":"paragraph","content":[{"type":"text","text":"Boca Chica","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su primer éxito como cantante, «Lindas palabritas», llegó a mediados de los ochenta, pero durante años se ganó la vida cantándoles a los visitantes en la playa de Boca Chica. Cuando el dueño de un local de allí le dijo que la gente estaba cansada de oírlo y trajo en su lugar a "},{"type":"artistReference","attrs":{"occurrenceId":"2f18da3f-7523-4004-9037-3703de1787d1","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":", Reyes intentó compartir cartel y no lo consiguió; una semana después esperó en la puerta de una discoteca de Santo Domingo para conocer a "},{"type":"artistReference","attrs":{"occurrenceId":"7e5581d6-d2fc-48fb-a7c8-fc55e01e8771","artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez"}},{"type":"text","text":", que pasó de largo. Él cuenta que esos dos desaires fueron los que lo empujaron a grabar su propio disco."}]},{"type":"paragraph","content":[{"type":"text","text":"Sentimiento","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ese disco, doce canciones de amor, despecho y humor, vistió su bachata con arreglos más movidos y bailables de lo que se estilaba, y sonaron casi todos los temas. «Los pobres también aman», «Vuelve con tu papá», «Muriendo de amor» y «Amor bonito» lo pusieron entre los bachateros principales de la década, y «ACROARTE» lo nombró Bachatero del Año correspondiente a 1994: la primera vez que los «Premios Casandra» entregaban ese galardón, después de años en que la gala había dejado fuera a los bachateros. Junto a "},{"type":"artistReference","attrs":{"occurrenceId":"f0283ad0-e5b1-4547-9a3e-4ab659ffee11","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"296c89f9-0f4a-49f9-b8e3-14636f89ac90","artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"e7ad380f-6872-41a9-90c7-42a65abb0315","artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"e2604e0d-cf6c-4283-8e97-687b0ef7d300","artistId":"31915623-3206-4052-b13a-2170226671b9","displayText":"Leonardo Paniagua"}},{"type":"text","text":", formó parte de la generación que sacó la música de amargue a la corriente principal."}]},{"type":"paragraph","content":[{"type":"text","text":"Fuera del país y a dúo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Sus canciones lo han llevado a Estados Unidos, Venezuela, Panamá, España, Italia, Suiza y Austria; en 2017 volvió de una gira europea de más de treinta presentaciones. En 2019 "},{"type":"artistReference","attrs":{"occurrenceId":"87d42b64-3335-4a19-977a-3780e2a9ceda","artistId":"8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3","displayText":"Romeo Santos"}},{"type":"text","text":" lo invitó a cantar «Ileso» en «Utopía», un disco de dúos con bachateros de la generación anterior. En 2024 anunció «La chica de baile», doce canciones con nombre de mujer."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Teodoro Reyes unió la bachata confesional de los noventa con un humor y una voz llorosa y juguetona muy suyos, y es de los pocos bachateros de su generación a quienes siguen cantando oyentes mucho más jóvenes. Su obra como autor abarca el merengue, por los éxitos que le dio a "},{"type":"artistReference","attrs":{"occurrenceId":"ad42d138-10d0-4756-9d62-d33088567c6a","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":", y la bachata, por los suyos."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'teodoro-reyes'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'teodoro-reyes' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2e5b078f-e0eb-4271-8f8b-fde78d251369', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '419f938c-320f-4cb5-be4a-b845157517e4', 'artist', '9b15dfca-0f60-49b3-a139-100a5a329741' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd6f73c68-69a6-45c1-b0e9-4db127771c76', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2f18da3f-7523-4004-9037-3703de1787d1', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7e5581d6-d2fc-48fb-a7c8-fc55e01e8771', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f0283ad0-e5b1-4547-9a3e-4ab659ffee11', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '296c89f9-0f4a-49f9-b8e3-14636f89ac90', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e7ad380f-6872-41a9-90c7-42a65abb0315', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e2604e0d-cf6c-4283-8e97-687b0ef7d300', 'artist', '31915623-3206-4052-b13a-2170226671b9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '87d42b64-3335-4a19-977a-3780e2a9ceda', 'artist', '8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ad42d138-10d0-4756-9d62-d33088567c6a', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'teodoro-reyes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Teodoro Reyes —nacido ciego en Nagua el 27 de marzo de 1954 y conocido como El Cieguito Sabio— es cantante y compositor dominicano de bachata. Escribió «La hamaquita» y otros éxitos de principios de los ochenta para Fernando Villalona, pasó años cantando en la playa de Boca Chica y en 1994 fue el primer ganador del renglón Bachatero del Año de los «Premios Casandra», con el disco de «Los pobres también aman» y «Vuelve con tu papá».

**Nagua y la Escuela de Ciegos**

De niño, en Nagua, animaba las fiestas del barrio con lo que tuviera a mano: se hizo una tambora con un galón de aceite y una güira con una lata. La música que lo rodeaba era el merengue típico —Tatico Henríquez salió de esa misma región—, y el típico siguió siendo su preferido. A los doce años, contra la voluntad de su familia, se fue de la casa para entrar en la «Escuela Nacional de Ciegos», en Santo Domingo, donde aprendió a leer y a escribir, pasó ocho años y se hizo bachiller. Sus compañeros se burlaban diciéndole que tenía voz de bachatero.

Tocó tambora en el grupo de Félix Quintana, probó el acordeón y lo encontró muy pesado, y a finales de los setenta se quedó con la guitarra, con la que todavía compone.

**Canciones para Fernando Villalona**

Su primer éxito llegó como autor. Fernando Villalona le grabó «La hamaquita», «El masaje» y «El niño mimado»; Reyes ha contado que por las dos primeras le pagaron 600 pesos, y que los derechos de autor le llegaron después, cuando ya se conocía su nombre.

**Boca Chica**

Su primer éxito como cantante, «Lindas palabritas», llegó a mediados de los ochenta, pero durante años se ganó la vida cantándoles a los visitantes en la playa de Boca Chica. Cuando el dueño de un local de allí le dijo que la gente estaba cansada de oírlo y trajo en su lugar a Antony Santos, Reyes intentó compartir cartel y no lo consiguió; una semana después esperó en la puerta de una discoteca de Santo Domingo para conocer a Raulín Rodríguez, que pasó de largo. Él cuenta que esos dos desaires fueron los que lo empujaron a grabar su propio disco.

**Sentimiento**

Ese disco, doce canciones de amor, despecho y humor, vistió su bachata con arreglos más movidos y bailables de lo que se estilaba, y sonaron casi todos los temas. «Los pobres también aman», «Vuelve con tu papá», «Muriendo de amor» y «Amor bonito» lo pusieron entre los bachateros principales de la década, y «ACROARTE» lo nombró Bachatero del Año correspondiente a 1994: la primera vez que los «Premios Casandra» entregaban ese galardón, después de años en que la gala había dejado fuera a los bachateros. Junto a Antony Santos, Raulín Rodríguez, Luis Vargas y Leonardo Paniagua, formó parte de la generación que sacó la música de amargue a la corriente principal.

**Fuera del país y a dúo**

Sus canciones lo han llevado a Estados Unidos, Venezuela, Panamá, España, Italia, Suiza y Austria; en 2017 volvió de una gira europea de más de treinta presentaciones. En 2019 Romeo Santos lo invitó a cantar «Ileso» en «Utopía», un disco de dúos con bachateros de la generación anterior. En 2024 anunció «La chica de baile», doce canciones con nombre de mujer.

**Legado**

Teodoro Reyes unió la bachata confesional de los noventa con un humor y una voz llorosa y juguetona muy suyos, y es de los pocos bachateros de su generación a quienes siguen cantando oyentes mucho más jóvenes. Su obra como autor abarca el merengue, por los éxitos que le dio a Fernando Villalona, y la bachata, por los suyos.' WHERE slug = 'teodoro-reyes';

COMMIT;
