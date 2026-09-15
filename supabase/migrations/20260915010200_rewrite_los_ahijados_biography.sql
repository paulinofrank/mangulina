BEGIN;

-- Ficha de Los Ahijados.
--
-- La biografía de relleno no daba un solo hecho: fecha de formación, catálogo, ni la ruptura
-- de 1975 cuando Cuco fundó Los Virtuosos. formation_year: 1958 (merengala 2013, Guateque y
-- Guaguancó). primary_genre: folklore-son-dominicano (sustituye salsa; coincide con el valor
-- ya usado en la ficha de Cuco Valoy). Año de «Vuelven... Los Ahijados» en conflicto
-- (1967/1969): no se fija en la prosa.

UPDATE artists SET formation_year = 1958, primary_genre = 'folklore-son-dominicano' WHERE slug = 'los-ahijados';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Los Ahijados — The Godchildren — is the Dominican duo of brothers "},{"type":"artistReference","attrs":{"occurrenceId":"2897e38e-e90f-49df-9d59-b84f6f623b03","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"6232bfd1-e372-4afb-b71d-c11b10f1942a","artistId":"6eccc3e7-82bf-435f-8ae1-ea7e8a721560","displayText":"Martín Valoy"}},{"type":"text","text":", formed in 1958, whose son montuno records of the 1960s and 1970s made them one of the country’s best-known acts outside merengue."}]},{"type":"paragraph","content":[{"type":"text","text":"Serenades to son montuno","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The brothers began singing serenades and the hits of the day. In the mid-1960s "},{"type":"artistReference","attrs":{"occurrenceId":"f57516cb-c991-495e-81da-6f9c9839cdd8","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" turned the repertoire toward Cuban-style sones montunos, in deliberate answer to Cuba’s «Los Compadres», and the duo took the name Los Ahijados. "},{"type":"artistReference","attrs":{"occurrenceId":"999d5a8b-5954-4031-bc90-c894eef087b0","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" sang lead and played second guitar; "},{"type":"artistReference","attrs":{"occurrenceId":"246a6909-5998-48bc-9b12-5cf3f615cb0b","artistId":"6eccc3e7-82bf-435f-8ae1-ea7e8a721560","displayText":"Martín Valoy"}},{"type":"text","text":", credited as the duo’s soloist, played guitar and tres and took the harmony lines. Their repertoire included «Qué será de mí», written by "},{"type":"artistReference","attrs":{"occurrenceId":"85ce41aa-9b54-47c7-b6ec-9b1a765866fe","artistId":"4b85d1eb-ebaa-42b5-9901-5e2805af9138","displayText":"Bienvenido Fabián"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"On «Kubaney»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Recording mostly for the Kubaney label, they built a catalogue through the sixties and seventies: «El enterrador» (1965), «Vuelven... Los Ahijados», «Virgen de la Cueva» (1973), «Ay, mi cien pesos!» and «Sigue afincando» (1974), «La resaca» (1975), «De nuevo Los Ahijados» (1976) and «Baílalo y gózalo...!! Vol. 4» (1978). Songs such as «Timoteo», «El lunar», «El hombre misterioso», «El paso de la jaiba», «Vaivén» and «Corazón de acero», the last written by "},{"type":"artistReference","attrs":{"occurrenceId":"1e4869c1-4585-4d34-9777-2f62aa8638ce","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":", kept returning in later compilations."}]},{"type":"paragraph","content":[{"type":"text","text":"The «Los Virtuosos» years","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1975 "},{"type":"artistReference","attrs":{"occurrenceId":"31a7e674-014c-4664-90d0-6ed8afa50a08","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" set the duo aside to found «Los Virtuosos», later «La Tribu», the orchestra where his son "},{"type":"artistReference","attrs":{"occurrenceId":"0a6fb53d-a09f-42d9-8763-0ea14f7eed9c","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":" came up as arranger and "},{"type":"artistReference","attrs":{"occurrenceId":"3abdb6cd-b9a2-43a2-850f-8263367e7d2e","artistId":"6eccc3e7-82bf-435f-8ae1-ea7e8a721560","displayText":"Martín Valoy"}},{"type":"text","text":" played bass. Martín used the pause to release his only solo album, «Hagan coro señores, llegó el Ahijado» (1981), before the brothers returned as Los Ahijados: «Vuelven Los Ahijados» (1983), the compilations «Los mejores discos» (1985) and «20 éxitos de Los Ahijados» (1988), and, in 1994 and 1995, «Nostalgia Caribeña», «Cachao vs. Los Ahijados» and «Tus ojos indios/Mariposa nocturna»."}]},{"type":"paragraph","content":[{"type":"text","text":"«De nuevo al son»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The brothers came together once more for «De nuevo al son» (1997), a studio album on which both "},{"type":"artistReference","attrs":{"occurrenceId":"821c6110-34f2-490e-bab6-2aa2d4c86656","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"a52f5d34-d0aa-4fe8-a25d-4c27ed1dee74","artistId":"6eccc3e7-82bf-435f-8ae1-ea7e8a721560","displayText":"Martín Valoy"}},{"type":"text","text":" are credited as lead vocalists."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los Ahijados carried the Cuban son montuno into Dominican popular music at a time when merengue dominated the radio, and their records stayed in circulation through four decades of Dominican family listening, from the original Kubaney pressings to the reissue compilations of the 1980s and 1990s."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'los-ahijados'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'los-ahijados' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2897e38e-e90f-49df-9d59-b84f6f623b03', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6232bfd1-e372-4afb-b71d-c11b10f1942a', 'artist', '6eccc3e7-82bf-435f-8ae1-ea7e8a721560' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f57516cb-c991-495e-81da-6f9c9839cdd8', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '999d5a8b-5954-4031-bc90-c894eef087b0', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '246a6909-5998-48bc-9b12-5cf3f615cb0b', 'artist', '6eccc3e7-82bf-435f-8ae1-ea7e8a721560' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '85ce41aa-9b54-47c7-b6ec-9b1a765866fe', 'artist', '4b85d1eb-ebaa-42b5-9901-5e2805af9138' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1e4869c1-4585-4d34-9777-2f62aa8638ce', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '31a7e674-014c-4664-90d0-6ed8afa50a08', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0a6fb53d-a09f-42d9-8763-0ea14f7eed9c', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3abdb6cd-b9a2-43a2-850f-8263367e7d2e', 'artist', '6eccc3e7-82bf-435f-8ae1-ea7e8a721560' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '821c6110-34f2-490e-bab6-2aa2d4c86656', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a52f5d34-d0aa-4fe8-a25d-4c27ed1dee74', 'artist', '6eccc3e7-82bf-435f-8ae1-ea7e8a721560' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Los Ahijados — The Godchildren — is the Dominican duo of brothers Cuco Valoy and Martín Valoy, formed in 1958, whose son montuno records of the 1960s and 1970s made them one of the country’s best-known acts outside merengue.

**Serenades to son montuno**

The brothers began singing serenades and the hits of the day. In the mid-1960s Cuco Valoy turned the repertoire toward Cuban-style sones montunos, in deliberate answer to Cuba’s «Los Compadres», and the duo took the name Los Ahijados. Cuco Valoy sang lead and played second guitar; Martín Valoy, credited as the duo’s soloist, played guitar and tres and took the harmony lines. Their repertoire included «Qué será de mí», written by Bienvenido Fabián.

**On «Kubaney»**

Recording mostly for the Kubaney label, they built a catalogue through the sixties and seventies: «El enterrador» (1965), «Vuelven... Los Ahijados», «Virgen de la Cueva» (1973), «Ay, mi cien pesos!» and «Sigue afincando» (1974), «La resaca» (1975), «De nuevo Los Ahijados» (1976) and «Baílalo y gózalo...!! Vol. 4» (1978). Songs such as «Timoteo», «El lunar», «El hombre misterioso», «El paso de la jaiba», «Vaivén» and «Corazón de acero», the last written by Cuco Valoy, kept returning in later compilations.

**The «Los Virtuosos» years**

In 1975 Cuco Valoy set the duo aside to found «Los Virtuosos», later «La Tribu», the orchestra where his son Ramón Orlando & Orquesta Internacional came up as arranger and Martín Valoy played bass. Martín used the pause to release his only solo album, «Hagan coro señores, llegó el Ahijado» (1981), before the brothers returned as Los Ahijados: «Vuelven Los Ahijados» (1983), the compilations «Los mejores discos» (1985) and «20 éxitos de Los Ahijados» (1988), and, in 1994 and 1995, «Nostalgia Caribeña», «Cachao vs. Los Ahijados» and «Tus ojos indios/Mariposa nocturna».

**«De nuevo al son»**

The brothers came together once more for «De nuevo al son» (1997), a studio album on which both Cuco Valoy and Martín Valoy are credited as lead vocalists.

**Legacy**

Los Ahijados carried the Cuban son montuno into Dominican popular music at a time when merengue dominated the radio, and their records stayed in circulation through four decades of Dominican family listening, from the original Kubaney pressings to the reissue compilations of the 1980s and 1990s.' WHERE slug = 'los-ahijados';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Los Ahijados es el dúo dominicano de los hermanos "},{"type":"artistReference","attrs":{"occurrenceId":"7ecd36b1-805b-4efd-87e2-a44815f85aa7","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"51564989-ad1e-4a35-8f45-ca08fd0d94db","artistId":"6eccc3e7-82bf-435f-8ae1-ea7e8a721560","displayText":"Martín Valoy"}},{"type":"text","text":", formado en 1958, cuyos discos de son montuno de los sesenta y setenta los convirtieron en uno de los actos más conocidos del país fuera del merengue."}]},{"type":"paragraph","content":[{"type":"text","text":"De la serenata al son montuno","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los hermanos empezaron cantando serenatas y los éxitos del momento. A mediados de los sesenta "},{"type":"artistReference","attrs":{"occurrenceId":"3d156b2a-bba0-48ce-9841-f6e082a324c9","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" orientó el repertorio hacia los sones montunos de corte cubano, en respuesta deliberada a «Los Compadres» de Cuba, y el dúo adoptó el nombre de Los Ahijados. "},{"type":"artistReference","attrs":{"occurrenceId":"bf3dac73-b6aa-4537-868b-60164e1cc2fc","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" llevaba la voz principal y la segunda guitarra; "},{"type":"artistReference","attrs":{"occurrenceId":"2a04b178-9f51-4e68-a89e-2f8441c2378c","artistId":"6eccc3e7-82bf-435f-8ae1-ea7e8a721560","displayText":"Martín Valoy"}},{"type":"text","text":", acreditado como solista del dúo, tocaba guitarra y tres y hacía las segundas voces. Su repertorio incluyó «Qué será de mí», escrita por "},{"type":"artistReference","attrs":{"occurrenceId":"0eab3c7c-7179-46b7-ab30-03aa9d22ed2c","artistId":"4b85d1eb-ebaa-42b5-9901-5e2805af9138","displayText":"Bienvenido Fabián"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"En «Kubaney»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Grabando sobre todo para el sello Kubaney, armaron un catálogo a lo largo de los sesenta y setenta: «El enterrador» (1965), «Vuelven... Los Ahijados», «Virgen de la Cueva» (1973), «Ay, mi cien pesos!» y «Sigue afincando» (1974), «La resaca» (1975), «De nuevo Los Ahijados» (1976) y «Baílalo y gózalo...!! Vol. 4» (1978). Temas como «Timoteo», «El lunar», «El hombre misterioso», «El paso de la jaiba», «Vaivén» y «Corazón de acero», esta última escrita por "},{"type":"artistReference","attrs":{"occurrenceId":"14a3cb8f-6094-42bf-949b-6d8f10eb4f27","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":", siguieron volviendo en recopilaciones posteriores."}]},{"type":"paragraph","content":[{"type":"text","text":"Los años de «Los Virtuosos»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1975 "},{"type":"artistReference","attrs":{"occurrenceId":"f934747f-ef26-47fa-bd89-d93b4f0a1f68","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" dejó el dúo en pausa para fundar «Los Virtuosos», después «La Tribu», la orquesta donde su hijo "},{"type":"artistReference","attrs":{"occurrenceId":"5b176294-e033-4e9c-8d49-a1eabaefa852","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":" se formó como arreglista y donde "},{"type":"artistReference","attrs":{"occurrenceId":"9b97cff9-acde-43aa-92fd-6de02baf24ae","artistId":"6eccc3e7-82bf-435f-8ae1-ea7e8a721560","displayText":"Martín Valoy"}},{"type":"text","text":" tocó el bajo. Martín aprovechó la pausa para publicar su único álbum como solista, «Hagan coro señores, llegó el Ahijado» (1981), antes de que los hermanos volvieran como Los Ahijados: «Vuelven Los Ahijados» (1983), las recopilaciones «Los mejores discos» (1985) y «20 éxitos de Los Ahijados» (1988), y, en 1994 y 1995, «Nostalgia Caribeña», «Cachao vs. Los Ahijados» y «Tus ojos indios/Mariposa nocturna»."}]},{"type":"paragraph","content":[{"type":"text","text":"«De nuevo al son»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los hermanos se juntaron una vez más para «De nuevo al son» (1997), un álbum de estudio en el que tanto "},{"type":"artistReference","attrs":{"occurrenceId":"4da3721c-d21d-4ff8-8a93-074378349481","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" como "},{"type":"artistReference","attrs":{"occurrenceId":"6f2391ec-a7d3-4cc1-8982-32e3202398b1","artistId":"6eccc3e7-82bf-435f-8ae1-ea7e8a721560","displayText":"Martín Valoy"}},{"type":"text","text":" figuran acreditados como voces principales."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los Ahijados llevaron el son montuno cubano a la música popular dominicana en un momento en que el merengue dominaba la radio, y sus discos se mantuvieron en circulación durante cuatro décadas de escucha familiar dominicana, desde las prensas originales de Kubaney hasta las recopilaciones de reedición de los ochenta y los noventa."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'los-ahijados'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'los-ahijados' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7ecd36b1-805b-4efd-87e2-a44815f85aa7', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '51564989-ad1e-4a35-8f45-ca08fd0d94db', 'artist', '6eccc3e7-82bf-435f-8ae1-ea7e8a721560' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3d156b2a-bba0-48ce-9841-f6e082a324c9', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'bf3dac73-b6aa-4537-868b-60164e1cc2fc', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2a04b178-9f51-4e68-a89e-2f8441c2378c', 'artist', '6eccc3e7-82bf-435f-8ae1-ea7e8a721560' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0eab3c7c-7179-46b7-ab30-03aa9d22ed2c', 'artist', '4b85d1eb-ebaa-42b5-9901-5e2805af9138' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '14a3cb8f-6094-42bf-949b-6d8f10eb4f27', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f934747f-ef26-47fa-bd89-d93b4f0a1f68', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5b176294-e033-4e9c-8d49-a1eabaefa852', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9b97cff9-acde-43aa-92fd-6de02baf24ae', 'artist', '6eccc3e7-82bf-435f-8ae1-ea7e8a721560' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4da3721c-d21d-4ff8-8a93-074378349481', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6f2391ec-a7d3-4cc1-8982-32e3202398b1', 'artist', '6eccc3e7-82bf-435f-8ae1-ea7e8a721560' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-ahijados' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Los Ahijados es el dúo dominicano de los hermanos Cuco Valoy y Martín Valoy, formado en 1958, cuyos discos de son montuno de los sesenta y setenta los convirtieron en uno de los actos más conocidos del país fuera del merengue.

**De la serenata al son montuno**

Los hermanos empezaron cantando serenatas y los éxitos del momento. A mediados de los sesenta Cuco Valoy orientó el repertorio hacia los sones montunos de corte cubano, en respuesta deliberada a «Los Compadres» de Cuba, y el dúo adoptó el nombre de Los Ahijados. Cuco Valoy llevaba la voz principal y la segunda guitarra; Martín Valoy, acreditado como solista del dúo, tocaba guitarra y tres y hacía las segundas voces. Su repertorio incluyó «Qué será de mí», escrita por Bienvenido Fabián.

**En «Kubaney»**

Grabando sobre todo para el sello Kubaney, armaron un catálogo a lo largo de los sesenta y setenta: «El enterrador» (1965), «Vuelven... Los Ahijados», «Virgen de la Cueva» (1973), «Ay, mi cien pesos!» y «Sigue afincando» (1974), «La resaca» (1975), «De nuevo Los Ahijados» (1976) y «Baílalo y gózalo...!! Vol. 4» (1978). Temas como «Timoteo», «El lunar», «El hombre misterioso», «El paso de la jaiba», «Vaivén» y «Corazón de acero», esta última escrita por Cuco Valoy, siguieron volviendo en recopilaciones posteriores.

**Los años de «Los Virtuosos»**

En 1975 Cuco Valoy dejó el dúo en pausa para fundar «Los Virtuosos», después «La Tribu», la orquesta donde su hijo Ramón Orlando & Orquesta Internacional se formó como arreglista y donde Martín Valoy tocó el bajo. Martín aprovechó la pausa para publicar su único álbum como solista, «Hagan coro señores, llegó el Ahijado» (1981), antes de que los hermanos volvieran como Los Ahijados: «Vuelven Los Ahijados» (1983), las recopilaciones «Los mejores discos» (1985) y «20 éxitos de Los Ahijados» (1988), y, en 1994 y 1995, «Nostalgia Caribeña», «Cachao vs. Los Ahijados» y «Tus ojos indios/Mariposa nocturna».

**«De nuevo al son»**

Los hermanos se juntaron una vez más para «De nuevo al son» (1997), un álbum de estudio en el que tanto Cuco Valoy como Martín Valoy figuran acreditados como voces principales.

**Legado**

Los Ahijados llevaron el son montuno cubano a la música popular dominicana en un momento en que el merengue dominaba la radio, y sus discos se mantuvieron en circulación durante cuatro décadas de escucha familiar dominicana, desde las prensas originales de Kubaney hasta las recopilaciones de reedición de los ochenta y los noventa.' WHERE slug = 'los-ahijados';

COMMIT;
