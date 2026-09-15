BEGIN;

-- Ficha de José Peña Suazo y La Banda Gorda.
--
-- La biografía de relleno lo confundía con El Ciego de Nagua (acordeón, típico).
-- La fila mezcla persona y grupo: nombre del grupo, alias "La Banda Gorda", tipo
-- solo_artist con la fecha de nacimiento de José. No se parte aquí; queda en el lote.
-- instruments: trumpet (El Día 2022, Diario Libre 2024). Wikipedia lo llama
-- saxofonista: no seguido.
-- Categoría nueva Premios Soberano / Merengue del Año (la época Casandra ya la tenía).
-- Premio: Merengue del Año 2015, «Yo sé que Dios me tiene a mí lo mío».
-- No registrados: tres Casandra de 2009 (solo una página de Facebook).

UPDATE artists SET instruments = ARRAY['trumpet']::text[] WHERE slug = 'jose-pena-suazo-y-la-banda-gorda';

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Merengue del Año' FROM awards a WHERE a.name = 'Premios Soberano'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Merengue del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2015, 'Yo sé que Dios me tiene a mí lo mío', true, 'El Nuevo Diario y Ensegundos (12 may 2015); El Día (29 ago 2022)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'jose-pena-suazo-y-la-banda-gorda' AND a.name = 'Premios Soberano' AND cat.name = 'Merengue del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2015);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"José Peña Suazo — José Virgilio Peña Suazo, born in Cotuí in 1967 — is a Dominican trumpeter, arranger, songwriter and bandleader, and the founder, in 1994, of «La Banda Gorda», one of the most durable merengue orchestras of the past three decades. After years writing and arranging hits for other bands, including "},{"type":"artistReference","attrs":{"occurrenceId":"e4fd20c4-528c-4da7-b0eb-92d44c72ab54","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":", he stepped out front as a singer and built a catalogue of his own: «Pa’ los que sufren», «Tú muere’ aquí», «Subido en el palo», «Mi mujer me gobierna»."}]},{"type":"paragraph","content":[{"type":"text","text":"Cotuí and the trumpet","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He came to music in his late teens, taught by Juan Eutimo Jerez, and took up the trumpet after his older brother, Arturo Suazo, formed a group of his own. He was studying accounting at the time — had he not become a musician, he says, he would have made a poor accountant. In 1987 he moved to Santo Domingo and joined the band of the city’s fire brigade."}]},{"type":"paragraph","content":[{"type":"text","text":"Sideman and arranger","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He became first trumpet in the orchestra of "},{"type":"artistReference","attrs":{"occurrenceId":"f29cc6e2-bc02-4b1a-a8ad-eb223d1d1cc1","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":", where he was allowed to compose and arrange, and then played with «La Artillería», one of the orchestras that trained a generation of merengue musicians. In 1991 he joined "},{"type":"artistReference","attrs":{"occurrenceId":"b168675f-99bf-4975-a053-a89cce622591","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":" on trumpet and wrote or arranged some of its best-known numbers, among them «A usted lo botan», «La compota» and «Penas de amores», and in 1993 he moved to "},{"type":"artistReference","attrs":{"occurrenceId":"c74a0543-6a0c-4f8c-be46-ce4ec827bf77","artistId":"86172ade-a3b0-47e3-803b-f913afe8072c","displayText":"Rokabanda"}},{"type":"text","text":", led by "},{"type":"artistReference","attrs":{"occurrenceId":"2bf96e66-fba8-43a4-830d-eb52660cc268","artistId":"c73737c2-0106-4a87-8dbe-5f1650d34342","displayText":"Kinito Méndez"}},{"type":"text","text":" and Bobby Rafael. His songs were recorded by "},{"type":"artistReference","attrs":{"occurrenceId":"97f8be6e-608f-4fcc-93e0-ae72a011c408","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"742c8277-240a-4171-b183-71c7389b6239","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"c8c3b61d-f4fc-4cd0-ac87-d72bc0305342","artistId":"e8ba0f32-1d96-494d-9861-b1dc3937331e","displayText":"José Alberto \"El Canario\""}},{"type":"text","text":". When he wrote for others he sang the guide vocal in the studio himself, and he reasoned that if a singer like "},{"type":"artistReference","attrs":{"occurrenceId":"7bb47656-7361-4c2f-aa2a-5a96f9d31365","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":" could learn a song from his reference, his voice could not be that bad."}]},{"type":"paragraph","content":[{"type":"text","text":"«Libre al fin»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The push to sing came when "},{"type":"artistReference","attrs":{"occurrenceId":"0aadf708-adf8-4605-b8fd-2010a5ef8c09","artistId":"86172ade-a3b0-47e3-803b-f913afe8072c","displayText":"Rokabanda"}},{"type":"text","text":" let him go one December. The start was hard, and musicians left because the band could not yet support them. Then, at a small piano, he wrote in a single sitting the songs of «Libre al fin», released on 19 April 1994 with «Pa’ los que sufren»; the whole album caught on, and there, he says, he found his own sound, free of the influence of the Coco Band and the Rokabanda."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Banda Gorda»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Albums followed almost yearly — «Durísimo» (1995), «Tú muere aquí» (1996), «Calienta esto» (1998), «Aquí, pero allá» (1999), «Esta noche» (2000), «Melao» (2002), «Puro mambo» (2004) — up to a nineteenth production, and he counts more than five hundred songs to his name. His merengue borrows from mambo and from the sayings of the street; «Subido en el palo», written for the envious, has been used in political campaigns by several parties. «Yo sé que Dios me tiene a mí lo mío», written during his mother’s last illness, was named Merengue del Año at the 2015 «Premios Soberano». In 2021 the band received its first gold record from the «RIAA», and «Mi mujer me gobierna» has since run to millions of plays in social-media challenges."}]},{"type":"paragraph","content":[{"type":"text","text":"Thirty years","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In September 2022 he and "},{"type":"artistReference","attrs":{"occurrenceId":"ab391ca4-091e-4e1e-b983-a2c23cc847b0","artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario"}},{"type":"text","text":" were billed together in concert for the first time, and for February 2024 he announced «30 años, mi historia musical», a concert marking three decades since «Libre al fin»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Peña Suazo is one of the musicians who went from the brass section to the front of the stage, and his arrangements for other orchestras sit alongside his own hits in the merengue of the 1990s. He remains optimistic about the genre’s future — society, he says, produces the people it needs, and he points to "},{"type":"artistReference","attrs":{"occurrenceId":"f1c22ed6-01b9-4d63-8672-6e9980d053b8","artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz"}},{"type":"text","text":" as proof."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jose-pena-suazo-y-la-banda-gorda'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e4fd20c4-528c-4da7-b0eb-92d44c72ab54', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f29cc6e2-bc02-4b1a-a8ad-eb223d1d1cc1', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b168675f-99bf-4975-a053-a89cce622591', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c74a0543-6a0c-4f8c-be46-ce4ec827bf77', 'artist', '86172ade-a3b0-47e3-803b-f913afe8072c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2bf96e66-fba8-43a4-830d-eb52660cc268', 'artist', 'c73737c2-0106-4a87-8dbe-5f1650d34342' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '97f8be6e-608f-4fcc-93e0-ae72a011c408', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '742c8277-240a-4171-b183-71c7389b6239', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c8c3b61d-f4fc-4cd0-ac87-d72bc0305342', 'artist', 'e8ba0f32-1d96-494d-9861-b1dc3937331e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7bb47656-7361-4c2f-aa2a-5a96f9d31365', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0aadf708-adf8-4605-b8fd-2010a5ef8c09', 'artist', '86172ade-a3b0-47e3-803b-f913afe8072c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ab391ca4-091e-4e1e-b983-a2c23cc847b0', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f1c22ed6-01b9-4d63-8672-6e9980d053b8', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'José Peña Suazo — José Virgilio Peña Suazo, born in Cotuí in 1967 — is a Dominican trumpeter, arranger, songwriter and bandleader, and the founder, in 1994, of «La Banda Gorda», one of the most durable merengue orchestras of the past three decades. After years writing and arranging hits for other bands, including Pochy y su Cocoband, he stepped out front as a singer and built a catalogue of his own: «Pa’ los que sufren», «Tú muere’ aquí», «Subido en el palo», «Mi mujer me gobierna».

**Cotuí and the trumpet**

He came to music in his late teens, taught by Juan Eutimo Jerez, and took up the trumpet after his older brother, Arturo Suazo, formed a group of his own. He was studying accounting at the time — had he not become a musician, he says, he would have made a poor accountant. In 1987 he moved to Santo Domingo and joined the band of the city’s fire brigade.

**Sideman and arranger**

He became first trumpet in the orchestra of Cuco Valoy, where he was allowed to compose and arrange, and then played with «La Artillería», one of the orchestras that trained a generation of merengue musicians. In 1991 he joined Pochy y su Cocoband on trumpet and wrote or arranged some of its best-known numbers, among them «A usted lo botan», «La compota» and «Penas de amores», and in 1993 he moved to Rokabanda, led by Kinito Méndez and Bobby Rafael. His songs were recorded by Fernando Villalona, Sergio Vargas and José Alberto "El Canario". When he wrote for others he sang the guide vocal in the studio himself, and he reasoned that if a singer like Sergio Vargas could learn a song from his reference, his voice could not be that bad.

**«Libre al fin»**

The push to sing came when Rokabanda let him go one December. The start was hard, and musicians left because the band could not yet support them. Then, at a small piano, he wrote in a single sitting the songs of «Libre al fin», released on 19 April 1994 with «Pa’ los que sufren»; the whole album caught on, and there, he says, he found his own sound, free of the influence of the Coco Band and the Rokabanda.

**«La Banda Gorda»**

Albums followed almost yearly — «Durísimo» (1995), «Tú muere aquí» (1996), «Calienta esto» (1998), «Aquí, pero allá» (1999), «Esta noche» (2000), «Melao» (2002), «Puro mambo» (2004) — up to a nineteenth production, and he counts more than five hundred songs to his name. His merengue borrows from mambo and from the sayings of the street; «Subido en el palo», written for the envious, has been used in political campaigns by several parties. «Yo sé que Dios me tiene a mí lo mío», written during his mother’s last illness, was named Merengue del Año at the 2015 «Premios Soberano». In 2021 the band received its first gold record from the «RIAA», and «Mi mujer me gobierna» has since run to millions of plays in social-media challenges.

**Thirty years**

In September 2022 he and Los Hermanos Rosario were billed together in concert for the first time, and for February 2024 he announced «30 años, mi historia musical», a concert marking three decades since «Libre al fin».

**Legacy**

Peña Suazo is one of the musicians who went from the brass section to the front of the stage, and his arrangements for other orchestras sit alongside his own hits in the merengue of the 1990s. He remains optimistic about the genre’s future — society, he says, produces the people it needs, and he points to Manny Cruz as proof.' WHERE slug = 'jose-pena-suazo-y-la-banda-gorda';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"José Peña Suazo —José Virgilio Peña Suazo, nacido en Cotuí en 1967— es trompetista, arreglista, compositor y director de orquesta dominicano, y fundador, en 1994, de «La Banda Gorda», una de las orquestas de merengue más duraderas de las últimas tres décadas. Tras años escribiendo y arreglando éxitos para otras agrupaciones, entre ellas "},{"type":"artistReference","attrs":{"occurrenceId":"1ccf852d-58d8-4e8c-ad0d-cde8ae523df8","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":", dio el paso al frente como cantante y levantó un repertorio propio: «Pa’ los que sufren», «Tú muere’ aquí», «Subido en el palo», «Mi mujer me gobierna»."}]},{"type":"paragraph","content":[{"type":"text","text":"Cotuí y la trompeta","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Llegó a la música al final de la adolescencia, con el maestro Juan Eutimo Jerez, y tomó la trompeta después de que su hermano mayor, Arturo Suazo, formara su propio grupo. Por entonces estudiaba contabilidad; si no hubiera sido músico, dice, habría sido un mal contador. En 1987 se mudó a Santo Domingo y entró en la Banda de Música del Cuerpo de Bomberos."}]},{"type":"paragraph","content":[{"type":"text","text":"Músico y arreglista","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Llegó a primera trompeta de la orquesta de "},{"type":"artistReference","attrs":{"occurrenceId":"dfc1420f-1fb9-481c-99e0-a8c4ba13b140","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":", donde le dejaron componer y arreglar, y luego tocó con «La Artillería», una de las orquestas que sirvieron de escuela a una generación del merengue. En 1991 entró como trompetista en "},{"type":"artistReference","attrs":{"occurrenceId":"0f85b5f6-4402-439d-b4b5-c5f96027af74","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":" y escribió o arregló varios de sus temas más conocidos, como «A usted lo botan», «La compota» y «Penas de amores», y en 1993 pasó a "},{"type":"artistReference","attrs":{"occurrenceId":"230cece1-5e6a-4b1a-918c-1663543adc77","artistId":"86172ade-a3b0-47e3-803b-f913afe8072c","displayText":"Rokabanda"}},{"type":"text","text":", de "},{"type":"artistReference","attrs":{"occurrenceId":"7d4ce99d-dc19-4380-9d5b-da745570c6c9","artistId":"c73737c2-0106-4a87-8dbe-5f1650d34342","displayText":"Kinito Méndez"}},{"type":"text","text":" y Bobby Rafael. Sus canciones las grabaron "},{"type":"artistReference","attrs":{"occurrenceId":"6e69baa3-987e-403b-bb35-c5baf105fef9","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"e8d9a072-4549-4f3e-9f40-3db33709f3d5","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"629ab5c0-98c8-4f14-957f-358a8c3d5bab","artistId":"e8ba0f32-1d96-494d-9861-b1dc3937331e","displayText":"José Alberto \"El Canario\""}},{"type":"text","text":". Cuando escribía para otros, él mismo cantaba la voz guía en el estudio, y pensaba que si un cantante como "},{"type":"artistReference","attrs":{"occurrenceId":"119fa937-7e62-48a9-a453-144e347a4519","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":" aprendía una canción con su referencia, él no podía cantar tan mal."}]},{"type":"paragraph","content":[{"type":"text","text":"«Libre al fin»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El empujón para cantar llegó cuando "},{"type":"artistReference","attrs":{"occurrenceId":"561e8d9e-afac-4b93-88e0-e4dd8cf5a89d","artistId":"86172ade-a3b0-47e3-803b-f913afe8072c","displayText":"Rokabanda"}},{"type":"text","text":" prescindió de él en un diciembre. Los comienzos fueron duros, y se le fueron músicos porque la banda todavía no les daba para vivir. Después, en un piano pequeño, escribió de un tirón las canciones de «Libre al fin», lanzado el 19 de abril de 1994 con «Pa’ los que sufren»; el disco pegó completo, y ahí, dice, encontró su sonido, libre ya de la influencia de la Coco Band y la Rokabanda."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Banda Gorda»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los discos siguieron casi uno por año —«Durísimo» (1995), «Tú muere aquí» (1996), «Calienta esto» (1998), «Aquí, pero allá» (1999), «Esta noche» (2000), «Melao» (2002), «Puro mambo» (2004)— hasta una producción número diecinueve, y suma más de quinientas composiciones. Su merengue toma del mambo y de los dichos de la calle; «Subido en el palo», escrita para los envidiosos, la han usado en campaña varios partidos. «Yo sé que Dios me tiene a mí lo mío», escrita durante la enfermedad final de su madre, fue Merengue del Año en los «Premios Soberano» de 2015. En 2021 la banda recibió su primer disco de oro de la «RIAA», y «Mi mujer me gobierna» ha sumado desde entonces millones de reproducciones en los retos de las redes sociales."}]},{"type":"paragraph","content":[{"type":"text","text":"Treinta años","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En septiembre de 2022 él y "},{"type":"artistReference","attrs":{"occurrenceId":"43e15244-1857-4585-a44a-9e1fd5a7e46e","artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario"}},{"type":"text","text":" coincidieron por primera vez en un mismo cartel, y para febrero de 2024 anunció «30 años, mi historia musical», un concierto por las tres décadas de «Libre al fin»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Peña Suazo es de los músicos que pasaron de la sección de metales al frente del escenario, y sus arreglos para otras orquestas acompañan a sus propios éxitos en el merengue de los noventa. Sigue optimista sobre el futuro del género: la sociedad, dice, va pariendo los hombres que necesita, y pone como ejemplo a "},{"type":"artistReference","attrs":{"occurrenceId":"79702813-e266-431c-b42b-9134eb1f274b","artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz"}},{"type":"text","text":"."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jose-pena-suazo-y-la-banda-gorda'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1ccf852d-58d8-4e8c-ad0d-cde8ae523df8', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dfc1420f-1fb9-481c-99e0-a8c4ba13b140', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0f85b5f6-4402-439d-b4b5-c5f96027af74', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '230cece1-5e6a-4b1a-918c-1663543adc77', 'artist', '86172ade-a3b0-47e3-803b-f913afe8072c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7d4ce99d-dc19-4380-9d5b-da745570c6c9', 'artist', 'c73737c2-0106-4a87-8dbe-5f1650d34342' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6e69baa3-987e-403b-bb35-c5baf105fef9', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e8d9a072-4549-4f3e-9f40-3db33709f3d5', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '629ab5c0-98c8-4f14-957f-358a8c3d5bab', 'artist', 'e8ba0f32-1d96-494d-9861-b1dc3937331e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '119fa937-7e62-48a9-a453-144e347a4519', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '561e8d9e-afac-4b93-88e0-e4dd8cf5a89d', 'artist', '86172ade-a3b0-47e3-803b-f913afe8072c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '43e15244-1857-4585-a44a-9e1fd5a7e46e', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '79702813-e266-431c-b42b-9134eb1f274b', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-pena-suazo-y-la-banda-gorda' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'José Peña Suazo —José Virgilio Peña Suazo, nacido en Cotuí en 1967— es trompetista, arreglista, compositor y director de orquesta dominicano, y fundador, en 1994, de «La Banda Gorda», una de las orquestas de merengue más duraderas de las últimas tres décadas. Tras años escribiendo y arreglando éxitos para otras agrupaciones, entre ellas Pochy y su Cocoband, dio el paso al frente como cantante y levantó un repertorio propio: «Pa’ los que sufren», «Tú muere’ aquí», «Subido en el palo», «Mi mujer me gobierna».

**Cotuí y la trompeta**

Llegó a la música al final de la adolescencia, con el maestro Juan Eutimo Jerez, y tomó la trompeta después de que su hermano mayor, Arturo Suazo, formara su propio grupo. Por entonces estudiaba contabilidad; si no hubiera sido músico, dice, habría sido un mal contador. En 1987 se mudó a Santo Domingo y entró en la Banda de Música del Cuerpo de Bomberos.

**Músico y arreglista**

Llegó a primera trompeta de la orquesta de Cuco Valoy, donde le dejaron componer y arreglar, y luego tocó con «La Artillería», una de las orquestas que sirvieron de escuela a una generación del merengue. En 1991 entró como trompetista en Pochy y su Cocoband y escribió o arregló varios de sus temas más conocidos, como «A usted lo botan», «La compota» y «Penas de amores», y en 1993 pasó a Rokabanda, de Kinito Méndez y Bobby Rafael. Sus canciones las grabaron Fernando Villalona, Sergio Vargas y José Alberto "El Canario". Cuando escribía para otros, él mismo cantaba la voz guía en el estudio, y pensaba que si un cantante como Sergio Vargas aprendía una canción con su referencia, él no podía cantar tan mal.

**«Libre al fin»**

El empujón para cantar llegó cuando Rokabanda prescindió de él en un diciembre. Los comienzos fueron duros, y se le fueron músicos porque la banda todavía no les daba para vivir. Después, en un piano pequeño, escribió de un tirón las canciones de «Libre al fin», lanzado el 19 de abril de 1994 con «Pa’ los que sufren»; el disco pegó completo, y ahí, dice, encontró su sonido, libre ya de la influencia de la Coco Band y la Rokabanda.

**«La Banda Gorda»**

Los discos siguieron casi uno por año —«Durísimo» (1995), «Tú muere aquí» (1996), «Calienta esto» (1998), «Aquí, pero allá» (1999), «Esta noche» (2000), «Melao» (2002), «Puro mambo» (2004)— hasta una producción número diecinueve, y suma más de quinientas composiciones. Su merengue toma del mambo y de los dichos de la calle; «Subido en el palo», escrita para los envidiosos, la han usado en campaña varios partidos. «Yo sé que Dios me tiene a mí lo mío», escrita durante la enfermedad final de su madre, fue Merengue del Año en los «Premios Soberano» de 2015. En 2021 la banda recibió su primer disco de oro de la «RIAA», y «Mi mujer me gobierna» ha sumado desde entonces millones de reproducciones en los retos de las redes sociales.

**Treinta años**

En septiembre de 2022 él y Los Hermanos Rosario coincidieron por primera vez en un mismo cartel, y para febrero de 2024 anunció «30 años, mi historia musical», un concierto por las tres décadas de «Libre al fin».

**Legado**

Peña Suazo es de los músicos que pasaron de la sección de metales al frente del escenario, y sus arreglos para otras orquestas acompañan a sus propios éxitos en el merengue de los noventa. Sigue optimista sobre el futuro del género: la sociedad, dice, va pariendo los hombres que necesita, y pone como ejemplo a Manny Cruz.' WHERE slug = 'jose-pena-suazo-y-la-banda-gorda';

COMMIT;
