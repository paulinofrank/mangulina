BEGIN;

-- Ficha de Henry Hierro.
--
-- Campos: middle_name Rafael, second_last_name Fernández (ESENDOM, Diario Libre,
-- Listín Diario). occupations añade producer (Diario Libre, ESENDOM).
--
-- aliases: se quitan "La Gran Manzana" y "Henry Hierro y la Gran Manzana". Son el
-- nombre de una orquesta que tiene fila propia (victor-roque-y-la-gran-manzana,
-- que ya lleva el alias "La Gran Manzana"); como alias de una persona hacían que
-- la búsqueda del grupo devolviera a Hierro. Mismo patrón que los siete casos
-- corregidos antes.
--
-- Relación nueva: founder_of Víctor Roque y La Gran Manzana, 1982-1986 (ESENDOM y
-- la ficha del grupo dan 1982; Listín Diario, la salida en 1986).
--
-- Fuera: la causa médica de su muerte, matrimonio e hijos.

UPDATE artists SET middle_name = 'Rafael', second_last_name = 'Fernández', aliases = ARRAY[]::text[],
       occupations = '["musician","arranger","bandleader","composer","producer"]'::jsonb WHERE slug = 'henry-hierro';

INSERT INTO artist_relationships (source_artist_id, target_artist_id, relationship_type, start_year, end_year, notes)
SELECT s.id, g.id, 'founder_of', 1982, 1986, 'Co-founded the orchestra with Víctor Roque in New York; musical director, pianist and arranger until he left in 1986'
  FROM artists s, artists g
 WHERE s.slug = 'henry-hierro' AND g.slug = 'victor-roque-y-la-gran-manzana'
   AND NOT EXISTS (SELECT 1 FROM artist_relationships r WHERE r.source_artist_id = s.id AND r.target_artist_id = g.id AND r.relationship_type = 'founder_of');

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Henry Hierro — Henry Rafael Hierro Fernández, born in San Francisco de Macorís on 26 September 1955, died there on 3 November 2025 — was a Dominican bassist, pianist, singer, arranger and producer. In New York in 1982 he and the singer Víctor Roque founded the orchestra now known as "},{"type":"artistReference","attrs":{"occurrenceId":"c62a83d7-f0f5-4925-b4f2-b3d55a6375db","artistId":"908c3016-2aab-424e-9913-664e5f9a04ac","displayText":"Víctor Roque y La Gran Manzana"}},{"type":"text","text":", whose «El poder de New York» made it one of the defining merengue bands of the 1980s, and he went on to arrange and produce for some of the genre’s biggest names."}]},{"type":"paragraph","content":[{"type":"text","text":"From rock to merengue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Music came from his grandfather, a Cuban who played percussion, accordion, tambora, guitar and flute, built instruments and sat the boy in front of a tambora for the first time. As a teenager, though, Hierro wanted to play rock. When one of the big bands in his home town, «Los Bravos de Juan Félix», needed a bass player, he took the job, found merengue easy to keep time to and brought his first pay home; his grandmother told him to stay where the money was. He has said he started playing merengue for the pay and grew to love it. His formal training was patchy, and he taught himself largely from music books."}]},{"type":"paragraph","content":[{"type":"text","text":"Bass player","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He played bass and wrote arrangements for the earliest line-ups of "},{"type":"artistReference","attrs":{"occurrenceId":"07515459-f907-4f22-917f-74587f6288ae","artistId":"02b306b3-acc0-4800-b314-05683205d1c5","displayText":"Jossie Esteban y La Patrulla 15"}},{"type":"text","text":". In December 1978 he moved to the orchestra of "},{"type":"artistReference","attrs":{"occurrenceId":"d504c758-d8aa-431d-9b05-758fe91ba1d5","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":" as bassist, and it was Vargas, he told Listín Diario in 2008, who first had him sing."}]},{"type":"paragraph","content":[{"type":"text","text":"La Gran Manzana","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1979 he went to live in the United States. The band he put together there began with five or six musicians, Dominicans and players of other nationalities, and a singer from San Francisco de Macorís; Víctor Roque joined on conga. It was going to be called «Los Amigos», but they settled on a name for New York itself, and in 1982 he and Roque launched it as "},{"type":"artistReference","attrs":{"occurrenceId":"25a569db-a3e2-4db5-9cd5-56822852eae0","artistId":"908c3016-2aab-424e-9913-664e5f9a04ac","displayText":"Víctor Roque y La Gran Manzana"}},{"type":"text","text":". A first album in 1983 made little impression. «El poder de New York», in 1985, broke through in American cities and at home, and the band’s run of hits — «Tus besos», «Rosa blanca», «Mentirosa», «Mole mole», «¿Cuándo llegará?», «No me sigas más», «Vamos a beber» — made it the sound of Dominican New York. Hierro was its musical director, pianist and arranger, and sang lead on songs such as «Tus besos»."}]},{"type":"paragraph","content":[{"type":"text","text":"Under his own name","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1986, unhappy with how the band was being managed, he left to lead his own group. In 1987 he recorded «A millón», «La banda» and «El diente de oro» for «Karen Records»; «A millón» is still one of the songs most often played at his concerts and at parties, and «Déjame decirte» showed him as a soloist and songwriter."}]},{"type":"paragraph","content":[{"type":"text","text":"Arranger and producer","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His longest-lasting work was done in the studio. Hierro arranged and produced for "},{"type":"artistReference","attrs":{"occurrenceId":"cedcfe9f-fa8d-444e-87fe-420c40901ea8","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"08d2a843-00e2-40ae-b7ca-5b3d993f7bbf","artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"b07c1c71-de43-41b7-89a3-f95df1cb1f21","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"2fa1a207-dab2-46d9-b126-05a93a016ad6","artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario"}},{"type":"text","text":", Jackeline Estévez, "},{"type":"artistReference","attrs":{"occurrenceId":"aba46437-3e4f-4829-af9a-7580d2e67413","artistId":"870cd31a-ded5-42de-88ab-a190cb2a1624","displayText":"Raffy Matias"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"b379a0a8-1890-4727-9589-3e9ee49242db","artistId":"15775d55-9e10-46bc-8516-ee7468724ec0","displayText":"Benny Sadel"}},{"type":"text","text":", among others; "},{"type":"artistReference","attrs":{"occurrenceId":"2e05a5f0-bec5-4c36-9720-9840d8edb408","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":" also spent two months singing in his orchestra."}]},{"type":"paragraph","content":[{"type":"text","text":"Last years","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Back in the Dominican Republic, he settled in San Francisco de Macorís. In 2022 "},{"type":"artistReference","attrs":{"occurrenceId":"dd196d85-469c-4f31-b80e-3edb7ab3e801","artistId":"908c3016-2aab-424e-9913-664e5f9a04ac","displayText":"Víctor Roque y La Gran Manzana"}},{"type":"text","text":" marked forty years with a tour that opened in New York, and he and Roque were honoured together in San Juan. He released two albums from 2022 onwards and, in October 2024, the single «El negro quiere bailar», and had announced an album called «Bacharengue» that joined merengue and bachata. He died in San Francisco de Macorís on 3 November 2025, at the age of seventy."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Henry Hierro helped give merengue a New York address. The band he co-founded turned the music of Dominican clubs in the city into a national success at home, and the arrangements he later wrote for other orchestras carried the same brass-driven, hook-heavy signature into the records of the 1980s and 1990s."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'henry-hierro'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'henry-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c62a83d7-f0f5-4925-b4f2-b3d55a6375db', 'artist', '908c3016-2aab-424e-9913-664e5f9a04ac' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '07515459-f907-4f22-917f-74587f6288ae', 'artist', '02b306b3-acc0-4800-b314-05683205d1c5' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd504c758-d8aa-431d-9b05-758fe91ba1d5', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '25a569db-a3e2-4db5-9cd5-56822852eae0', 'artist', '908c3016-2aab-424e-9913-664e5f9a04ac' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cedcfe9f-fa8d-444e-87fe-420c40901ea8', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '08d2a843-00e2-40ae-b7ca-5b3d993f7bbf', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b07c1c71-de43-41b7-89a3-f95df1cb1f21', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2fa1a207-dab2-46d9-b126-05a93a016ad6', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'aba46437-3e4f-4829-af9a-7580d2e67413', 'artist', '870cd31a-ded5-42de-88ab-a190cb2a1624' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b379a0a8-1890-4727-9589-3e9ee49242db', 'artist', '15775d55-9e10-46bc-8516-ee7468724ec0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2e05a5f0-bec5-4c36-9720-9840d8edb408', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dd196d85-469c-4f31-b80e-3edb7ab3e801', 'artist', '908c3016-2aab-424e-9913-664e5f9a04ac' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Henry Hierro — Henry Rafael Hierro Fernández, born in San Francisco de Macorís on 26 September 1955, died there on 3 November 2025 — was a Dominican bassist, pianist, singer, arranger and producer. In New York in 1982 he and the singer Víctor Roque founded the orchestra now known as Víctor Roque y La Gran Manzana, whose «El poder de New York» made it one of the defining merengue bands of the 1980s, and he went on to arrange and produce for some of the genre’s biggest names.

**From rock to merengue**

Music came from his grandfather, a Cuban who played percussion, accordion, tambora, guitar and flute, built instruments and sat the boy in front of a tambora for the first time. As a teenager, though, Hierro wanted to play rock. When one of the big bands in his home town, «Los Bravos de Juan Félix», needed a bass player, he took the job, found merengue easy to keep time to and brought his first pay home; his grandmother told him to stay where the money was. He has said he started playing merengue for the pay and grew to love it. His formal training was patchy, and he taught himself largely from music books.

**Bass player**

He played bass and wrote arrangements for the earliest line-ups of Jossie Esteban y La Patrulla 15. In December 1978 he moved to the orchestra of Wilfrido Vargas as bassist, and it was Vargas, he told Listín Diario in 2008, who first had him sing.

**La Gran Manzana**

In 1979 he went to live in the United States. The band he put together there began with five or six musicians, Dominicans and players of other nationalities, and a singer from San Francisco de Macorís; Víctor Roque joined on conga. It was going to be called «Los Amigos», but they settled on a name for New York itself, and in 1982 he and Roque launched it as Víctor Roque y La Gran Manzana. A first album in 1983 made little impression. «El poder de New York», in 1985, broke through in American cities and at home, and the band’s run of hits — «Tus besos», «Rosa blanca», «Mentirosa», «Mole mole», «¿Cuándo llegará?», «No me sigas más», «Vamos a beber» — made it the sound of Dominican New York. Hierro was its musical director, pianist and arranger, and sang lead on songs such as «Tus besos».

**Under his own name**

In 1986, unhappy with how the band was being managed, he left to lead his own group. In 1987 he recorded «A millón», «La banda» and «El diente de oro» for «Karen Records»; «A millón» is still one of the songs most often played at his concerts and at parties, and «Déjame decirte» showed him as a soloist and songwriter.

**Arranger and producer**

His longest-lasting work was done in the studio. Hierro arranged and produced for Rubby Pérez, Los Toros Band, Héctor Acosta “El Torito”, Los Hermanos Rosario, Jackeline Estévez, Raffy Matias and Benny Sadel, among others; Héctor Acosta “El Torito” also spent two months singing in his orchestra.

**Last years**

Back in the Dominican Republic, he settled in San Francisco de Macorís. In 2022 Víctor Roque y La Gran Manzana marked forty years with a tour that opened in New York, and he and Roque were honoured together in San Juan. He released two albums from 2022 onwards and, in October 2024, the single «El negro quiere bailar», and had announced an album called «Bacharengue» that joined merengue and bachata. He died in San Francisco de Macorís on 3 November 2025, at the age of seventy.

**Legacy**

Henry Hierro helped give merengue a New York address. The band he co-founded turned the music of Dominican clubs in the city into a national success at home, and the arrangements he later wrote for other orchestras carried the same brass-driven, hook-heavy signature into the records of the 1980s and 1990s.' WHERE slug = 'henry-hierro';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Henry Hierro —Henry Rafael Hierro Fernández, nacido en San Francisco de Macorís el 26 de septiembre de 1955 y fallecido allí el 3 de noviembre de 2025— fue bajista, pianista, cantante, arreglista y productor dominicano. En Nueva York fundó en 1982, junto al cantante Víctor Roque, la orquesta que hoy se conoce como "},{"type":"artistReference","attrs":{"occurrenceId":"4565f394-1537-4016-8309-611e6f48a6a3","artistId":"908c3016-2aab-424e-9913-664e5f9a04ac","displayText":"Víctor Roque y La Gran Manzana"}},{"type":"text","text":", cuyo «El poder de New York» la convirtió en una de las bandas de merengue que definieron los años ochenta, y después arregló y produjo para algunos de los nombres mayores del género."}]},{"type":"paragraph","content":[{"type":"text","text":"Del rock al merengue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La música le venía del abuelo, un cubano que tocaba percusión, acordeón, tambora, guitarra y flauta, fabricaba instrumentos y fue quien lo sentó por primera vez frente a una tambora. De adolescente, sin embargo, lo que quería era tocar rock. Cuando a una de las big bands de su pueblo, «Los Bravos de Juan Félix», le faltó un bajista, aceptó el puesto, encontró que el merengue era fácil de marcar y llevó a casa su primera paga; la abuela le aconsejó quedarse donde había dinero. Él mismo contaba que empezó por la paga y que el merengue le fue gustando poco a poco. Su formación académica fue irregular, y aprendió en buena medida por su cuenta, con libros de música."}]},{"type":"paragraph","content":[{"type":"text","text":"El bajista","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Tocó el bajo e hizo arreglos en las primeras nóminas de "},{"type":"artistReference","attrs":{"occurrenceId":"c10d4686-d1b8-40bd-a92f-0822ad6539b6","artistId":"02b306b3-acc0-4800-b314-05683205d1c5","displayText":"Jossie Esteban y La Patrulla 15"}},{"type":"text","text":". En diciembre de 1978 pasó como bajista a la orquesta de "},{"type":"artistReference","attrs":{"occurrenceId":"4d1c9a5a-078a-4209-ba70-ee2aedd27170","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":", y fue Vargas, según le contó a Listín Diario en 2008, quien lo puso a cantar por primera vez."}]},{"type":"paragraph","content":[{"type":"text","text":"La Gran Manzana","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1979 se fue a vivir a Estados Unidos. El grupo que armó allí empezó con cinco o seis músicos, dominicanos y de otras nacionalidades, y un cantante de San Francisco de Macorís; Víctor Roque entró en la conga. Iba a llamarse «Los Amigos», pero terminaron poniéndole un nombre de la propia Nueva York, y en 1982 él y Roque lo lanzaron como "},{"type":"artistReference","attrs":{"occurrenceId":"f5d00ff6-e113-41ab-990c-3c58a7c61dee","artistId":"908c3016-2aab-424e-9913-664e5f9a04ac","displayText":"Víctor Roque y La Gran Manzana"}},{"type":"text","text":". Un primer disco en 1983 pasó sin mucho eco. «El poder de New York», en 1985, sonó con fuerza en las ciudades norteamericanas y en el país, y la serie de éxitos —«Tus besos», «Rosa blanca», «Mentirosa», «Mole mole», «¿Cuándo llegará?», «No me sigas más», «Vamos a beber»— hizo de la banda el sonido de la Nueva York dominicana. Hierro era su director musical, pianista y arreglista, y cantaba temas como «Tus besos»."}]},{"type":"paragraph","content":[{"type":"text","text":"Con su nombre","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1986, inconforme con la administración de la banda, salió a dirigir su propio grupo. En 1987 grabó para «Karen Records» «A millón», «La banda» y «El diente de oro»; «A millón» sigue siendo de las más tocadas en eventos y conciertos, y «Déjame decirte» lo mostró como solista y compositor."}]},{"type":"paragraph","content":[{"type":"text","text":"Arreglista y productor","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su trabajo más duradero se hizo en el estudio. Hierro arregló y produjo para "},{"type":"artistReference","attrs":{"occurrenceId":"2207437c-4536-437b-b991-8cf92ac086e2","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"b636952f-a273-48f0-845c-e91d4bed3146","artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"2a13c084-0356-4005-a13e-4dc76beec9bc","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"2f03810a-93d9-415c-929c-c2e00a6ac32b","artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario"}},{"type":"text","text":", Jackeline Estévez, "},{"type":"artistReference","attrs":{"occurrenceId":"17ef6265-4276-4c4f-bb52-d36e2a630856","artistId":"870cd31a-ded5-42de-88ab-a190cb2a1624","displayText":"Raffy Matias"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"5b1f0cbb-a0a8-4113-98ec-660c2ff11195","artistId":"15775d55-9e10-46bc-8516-ee7468724ec0","displayText":"Benny Sadel"}},{"type":"text","text":", entre otros; "},{"type":"artistReference","attrs":{"occurrenceId":"a0b101ef-c775-4e62-be53-6c43c87fee70","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":" pasó además dos meses cantando en su orquesta."}]},{"type":"paragraph","content":[{"type":"text","text":"Los últimos años","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De vuelta en la República Dominicana, se estableció en San Francisco de Macorís. En 2022 "},{"type":"artistReference","attrs":{"occurrenceId":"5112ce64-b7e0-4f42-a24d-5132cde6adc8","artistId":"908c3016-2aab-424e-9913-664e5f9a04ac","displayText":"Víctor Roque y La Gran Manzana"}},{"type":"text","text":" celebró sus cuarenta años con una gira que arrancó en Nueva York, y a él y a Roque los homenajearon juntos en San Juan. Desde 2022 publicó dos álbumes y, en octubre de 2024, el sencillo «El negro quiere bailar», y había anunciado un disco, «Bacharengue», que unía merengue y bachata. Murió en San Francisco de Macorís el 3 de noviembre de 2025, a los setenta años."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Henry Hierro ayudó a darle al merengue una dirección en Nueva York. La banda que cofundó convirtió la música de los clubes dominicanos de esa ciudad en un éxito nacional en el país, y los arreglos que luego escribió para otras orquestas llevaron esa misma firma de metales y coros pegajosos a los discos de los ochenta y los noventa."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'henry-hierro'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'henry-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4565f394-1537-4016-8309-611e6f48a6a3', 'artist', '908c3016-2aab-424e-9913-664e5f9a04ac' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c10d4686-d1b8-40bd-a92f-0822ad6539b6', 'artist', '02b306b3-acc0-4800-b314-05683205d1c5' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4d1c9a5a-078a-4209-ba70-ee2aedd27170', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f5d00ff6-e113-41ab-990c-3c58a7c61dee', 'artist', '908c3016-2aab-424e-9913-664e5f9a04ac' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2207437c-4536-437b-b991-8cf92ac086e2', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b636952f-a273-48f0-845c-e91d4bed3146', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2a13c084-0356-4005-a13e-4dc76beec9bc', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2f03810a-93d9-415c-929c-c2e00a6ac32b', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '17ef6265-4276-4c4f-bb52-d36e2a630856', 'artist', '870cd31a-ded5-42de-88ab-a190cb2a1624' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5b1f0cbb-a0a8-4113-98ec-660c2ff11195', 'artist', '15775d55-9e10-46bc-8516-ee7468724ec0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a0b101ef-c775-4e62-be53-6c43c87fee70', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5112ce64-b7e0-4f42-a24d-5132cde6adc8', 'artist', '908c3016-2aab-424e-9913-664e5f9a04ac' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-hierro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Henry Hierro —Henry Rafael Hierro Fernández, nacido en San Francisco de Macorís el 26 de septiembre de 1955 y fallecido allí el 3 de noviembre de 2025— fue bajista, pianista, cantante, arreglista y productor dominicano. En Nueva York fundó en 1982, junto al cantante Víctor Roque, la orquesta que hoy se conoce como Víctor Roque y La Gran Manzana, cuyo «El poder de New York» la convirtió en una de las bandas de merengue que definieron los años ochenta, y después arregló y produjo para algunos de los nombres mayores del género.

**Del rock al merengue**

La música le venía del abuelo, un cubano que tocaba percusión, acordeón, tambora, guitarra y flauta, fabricaba instrumentos y fue quien lo sentó por primera vez frente a una tambora. De adolescente, sin embargo, lo que quería era tocar rock. Cuando a una de las big bands de su pueblo, «Los Bravos de Juan Félix», le faltó un bajista, aceptó el puesto, encontró que el merengue era fácil de marcar y llevó a casa su primera paga; la abuela le aconsejó quedarse donde había dinero. Él mismo contaba que empezó por la paga y que el merengue le fue gustando poco a poco. Su formación académica fue irregular, y aprendió en buena medida por su cuenta, con libros de música.

**El bajista**

Tocó el bajo e hizo arreglos en las primeras nóminas de Jossie Esteban y La Patrulla 15. En diciembre de 1978 pasó como bajista a la orquesta de Wilfrido Vargas, y fue Vargas, según le contó a Listín Diario en 2008, quien lo puso a cantar por primera vez.

**La Gran Manzana**

En 1979 se fue a vivir a Estados Unidos. El grupo que armó allí empezó con cinco o seis músicos, dominicanos y de otras nacionalidades, y un cantante de San Francisco de Macorís; Víctor Roque entró en la conga. Iba a llamarse «Los Amigos», pero terminaron poniéndole un nombre de la propia Nueva York, y en 1982 él y Roque lo lanzaron como Víctor Roque y La Gran Manzana. Un primer disco en 1983 pasó sin mucho eco. «El poder de New York», en 1985, sonó con fuerza en las ciudades norteamericanas y en el país, y la serie de éxitos —«Tus besos», «Rosa blanca», «Mentirosa», «Mole mole», «¿Cuándo llegará?», «No me sigas más», «Vamos a beber»— hizo de la banda el sonido de la Nueva York dominicana. Hierro era su director musical, pianista y arreglista, y cantaba temas como «Tus besos».

**Con su nombre**

En 1986, inconforme con la administración de la banda, salió a dirigir su propio grupo. En 1987 grabó para «Karen Records» «A millón», «La banda» y «El diente de oro»; «A millón» sigue siendo de las más tocadas en eventos y conciertos, y «Déjame decirte» lo mostró como solista y compositor.

**Arreglista y productor**

Su trabajo más duradero se hizo en el estudio. Hierro arregló y produjo para Rubby Pérez, Los Toros Band, Héctor Acosta “El Torito”, Los Hermanos Rosario, Jackeline Estévez, Raffy Matias y Benny Sadel, entre otros; Héctor Acosta “El Torito” pasó además dos meses cantando en su orquesta.

**Los últimos años**

De vuelta en la República Dominicana, se estableció en San Francisco de Macorís. En 2022 Víctor Roque y La Gran Manzana celebró sus cuarenta años con una gira que arrancó en Nueva York, y a él y a Roque los homenajearon juntos en San Juan. Desde 2022 publicó dos álbumes y, en octubre de 2024, el sencillo «El negro quiere bailar», y había anunciado un disco, «Bacharengue», que unía merengue y bachata. Murió en San Francisco de Macorís el 3 de noviembre de 2025, a los setenta años.

**Legado**

Henry Hierro ayudó a darle al merengue una dirección en Nueva York. La banda que cofundó convirtió la música de los clubes dominicanos de esa ciudad en un éxito nacional en el país, y los arreglos que luego escribió para otras orquestas llevaron esa misma firma de metales y coros pegajosos a los discos de los ochenta y los noventa.' WHERE slug = 'henry-hierro';

COMMIT;
