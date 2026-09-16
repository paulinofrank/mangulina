BEGIN;

-- Ficha de Mickey Taveras.
--
-- La biografía de relleno era genérica, sin nombrar canción, agrupación ni hecho real de su
-- carrera. Los campos estructurados de la fila ya eran correctos; solo se reescribió la
-- biografía.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Mickey Taveras —full name Miguel Vinicio Almánzar Taveras, born in Santo Domingo on 29 September 1970, to Raúl Almánzar and Modesta Taveras, a family of Ecuadorian descent— is a Dominican singer of salsa romántica, merengue and bachata, launched to international fame in the orchestra of "},{"type":"artistReference","attrs":{"occurrenceId":"a559d15a-d6cb-4f2f-8d69-9a235c6db823","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":" before a long solo career built on romantic ballads."}]},{"type":"paragraph","content":[{"type":"text","text":"From «Los Pícaros de Moca» to Wilfrido Vargas’s orchestra","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He trained at the Escuela de Bellas Artes y Cultos, learning guitar, piano, harmony and solfège, skills that later let him write his own arrangements and songs. At twelve he formed the rock group «Los Pícaros de Moca», two years later the group «Variedades Musicales», and afterward joined an ensemble playing jazz and English-language ballads. "},{"type":"artistReference","attrs":{"occurrenceId":"0d4d5b5e-fe68-4eac-aa6b-72a578639110","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":" then launched him to international fame within his own orchestra, where Taveras worked as both singer and music producer, before leaving after five years to pursue his own projects and to compose for other artists."}]},{"type":"paragraph","content":[{"type":"text","text":"«Lucharé» and Viña del Mar","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His debut solo album, «Lucharé» (September 1995), included the hits «Quiéreme», «A Pesar del Tiempo», «Y Qué Me Pasa» and the title track, selling more than 500,000 copies in Colombia and earning him the award for best performer at Chile’s Viña del Mar Festival in 1996."}]},{"type":"paragraph","content":[{"type":"text","text":"Further albums","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Más Romántico» (1999), led by «Mi Historia Entre Tus Dedos», brought him a Premios Lo Nuestro nomination; a bachata album, «Sigo Siendo Romántico: Grandes Éxitos de la Bachata» (2003), sold more modestly but earned a Latin Grammy nomination. «Te Esperaré» (2006) and «Pasado y Presente» (2013) followed, the latter revisiting his 1996–2002 salsa hits in pop, rock and ballad arrangements and including a cover of «Me Enloqueces», a hit for the Colombian singer Charlie Zaá. A 2016 single, «Hoy Ya Me Voy», featured a guest appearance by José Aguirre."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Now based in Miami, Taveras has named among his own influences singers as varied as Ismael Rivera, "},{"type":"artistReference","attrs":{"occurrenceId":"f5287a85-edae-4c7e-9a12-ae5e91643cac","artistId":"8fc78100-e51e-48a8-91e9-3007f4c67ec0","displayText":"Félix del Rosario"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"2494347e-5643-4ecc-a4b0-84767cdf1a8c","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"bb2dfc08-ec87-4d24-8b4f-c881b1528b51","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":", a range that mirrors the breadth of his own catalogue across salsa, merengue and bachata."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'mickey-taveras'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'mickey-taveras' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'a559d15a-d6cb-4f2f-8d69-9a235c6db823', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'mickey-taveras' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '0d4d5b5e-fe68-4eac-aa6b-72a578639110', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'mickey-taveras' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'f5287a85-edae-4c7e-9a12-ae5e91643cac', 'artist', '8fc78100-e51e-48a8-91e9-3007f4c67ec0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'mickey-taveras' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '2494347e-5643-4ecc-a4b0-84767cdf1a8c', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'mickey-taveras' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'bb2dfc08-ec87-4d24-8b4f-c881b1528b51', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'mickey-taveras' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Mickey Taveras —full name Miguel Vinicio Almánzar Taveras, born in Santo Domingo on 29 September 1970, to Raúl Almánzar and Modesta Taveras, a family of Ecuadorian descent— is a Dominican singer of salsa romántica, merengue and bachata, launched to international fame in the orchestra of Wilfrido Vargas before a long solo career built on romantic ballads.

**From «Los Pícaros de Moca» to Wilfrido Vargas’s orchestra**

He trained at the Escuela de Bellas Artes y Cultos, learning guitar, piano, harmony and solfège, skills that later let him write his own arrangements and songs. At twelve he formed the rock group «Los Pícaros de Moca», two years later the group «Variedades Musicales», and afterward joined an ensemble playing jazz and English-language ballads. Wilfrido Vargas then launched him to international fame within his own orchestra, where Taveras worked as both singer and music producer, before leaving after five years to pursue his own projects and to compose for other artists.

**«Lucharé» and Viña del Mar**

His debut solo album, «Lucharé» (September 1995), included the hits «Quiéreme», «A Pesar del Tiempo», «Y Qué Me Pasa» and the title track, selling more than 500,000 copies in Colombia and earning him the award for best performer at Chile’s Viña del Mar Festival in 1996.

**Further albums**

«Más Romántico» (1999), led by «Mi Historia Entre Tus Dedos», brought him a Premios Lo Nuestro nomination; a bachata album, «Sigo Siendo Romántico: Grandes Éxitos de la Bachata» (2003), sold more modestly but earned a Latin Grammy nomination. «Te Esperaré» (2006) and «Pasado y Presente» (2013) followed, the latter revisiting his 1996–2002 salsa hits in pop, rock and ballad arrangements and including a cover of «Me Enloqueces», a hit for the Colombian singer Charlie Zaá. A 2016 single, «Hoy Ya Me Voy», featured a guest appearance by José Aguirre.

**Legacy**

Now based in Miami, Taveras has named among his own influences singers as varied as Ismael Rivera, Félix del Rosario, Cuco Valoy and Ramón Orlando & Orquesta Internacional, a range that mirrors the breadth of his own catalogue across salsa, merengue and bachata.' WHERE slug = 'mickey-taveras';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Mickey Taveras —nombre completo Miguel Vinicio Almánzar Taveras, nacido en Santo Domingo el 29 de septiembre de 1970, hijo de Raúl Almánzar y Modesta Taveras, familia de ascendencia ecuatoriana— es cantante dominicano de salsa romántica, merengue y bachata, lanzado a la fama internacional en la orquesta de "},{"type":"artistReference","attrs":{"occurrenceId":"61432c5a-90bc-493f-9f7b-0df618b0ec11","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":" antes de una larga carrera como solista construida sobre la balada romántica."}]},{"type":"paragraph","content":[{"type":"text","text":"De «Los Pícaros de Moca» a la orquesta de Wilfrido Vargas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Se formó en la Escuela de Bellas Artes y Cultos, aprendiendo guitarra, piano, armonía y solfeo, conocimientos que después le permitieron hacer sus propios arreglos y composiciones. A los doce años formó el grupo de rock «Los Pícaros de Moca», dos años después la agrupación «Variedades Musicales», y más tarde se integró a un conjunto que tocaba jazz y baladas en inglés. "},{"type":"artistReference","attrs":{"occurrenceId":"162db9e7-c035-4f67-b296-803bc1262f2c","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":" lo lanzó después a la fama internacional dentro de su propia orquesta, donde Taveras se desempeñó como cantante y productor musical, antes de salir a los cinco años para dedicarse a sus propios proyectos y a componer para otros artistas."}]},{"type":"paragraph","content":[{"type":"text","text":"«Lucharé» y Viña del Mar","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su álbum debut como solista, «Lucharé» (septiembre de 1995), incluyó los éxitos «Quiéreme», «A Pesar del Tiempo», «Y Qué Me Pasa» y el tema título, vendiendo más de 500 000 copias en Colombia y ganándole el premio al mejor intérprete en el Festival de Viña del Mar de Chile en 1996."}]},{"type":"paragraph","content":[{"type":"text","text":"Más álbumes","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Más Romántico» (1999), encabezado por «Mi Historia Entre Tus Dedos», le trajo una nominación a los Premios Lo Nuestro; un álbum de bachata, «Sigo Siendo Romántico: Grandes Éxitos de la Bachata» (2003), vendió más modestamente pero le ganó una nominación al Grammy Latino. Siguieron «Te Esperaré» (2006) y «Pasado y Presente» (2013), este último revisitando sus éxitos de salsa de 1996-2002 en arreglos de pop, rock y balada, e incluyendo una versión de «Me Enloqueces», éxito del cantante colombiano Charlie Zaá. Un sencillo de 2016, «Hoy Ya Me Voy», contó con la participación especial de José Aguirre."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Radicado hoy en Miami, Taveras ha nombrado entre sus propias influencias a cantantes tan variados como Ismael Rivera, "},{"type":"artistReference","attrs":{"occurrenceId":"284e0280-4189-4ead-8069-b3d964c9c93a","artistId":"8fc78100-e51e-48a8-91e9-3007f4c67ec0","displayText":"Félix del Rosario"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"0c60bf6f-a3cd-4697-ac61-901141c82f68","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"25eb4743-d06e-4894-b890-af94debce1c3","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":", un rango que refleja la amplitud de su propio catálogo entre salsa, merengue y bachata."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'mickey-taveras'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'mickey-taveras' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '61432c5a-90bc-493f-9f7b-0df618b0ec11', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'mickey-taveras' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '162db9e7-c035-4f67-b296-803bc1262f2c', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'mickey-taveras' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '284e0280-4189-4ead-8069-b3d964c9c93a', 'artist', '8fc78100-e51e-48a8-91e9-3007f4c67ec0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'mickey-taveras' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '0c60bf6f-a3cd-4697-ac61-901141c82f68', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'mickey-taveras' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '25eb4743-d06e-4894-b890-af94debce1c3', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'mickey-taveras' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Mickey Taveras —nombre completo Miguel Vinicio Almánzar Taveras, nacido en Santo Domingo el 29 de septiembre de 1970, hijo de Raúl Almánzar y Modesta Taveras, familia de ascendencia ecuatoriana— es cantante dominicano de salsa romántica, merengue y bachata, lanzado a la fama internacional en la orquesta de Wilfrido Vargas antes de una larga carrera como solista construida sobre la balada romántica.

**De «Los Pícaros de Moca» a la orquesta de Wilfrido Vargas**

Se formó en la Escuela de Bellas Artes y Cultos, aprendiendo guitarra, piano, armonía y solfeo, conocimientos que después le permitieron hacer sus propios arreglos y composiciones. A los doce años formó el grupo de rock «Los Pícaros de Moca», dos años después la agrupación «Variedades Musicales», y más tarde se integró a un conjunto que tocaba jazz y baladas en inglés. Wilfrido Vargas lo lanzó después a la fama internacional dentro de su propia orquesta, donde Taveras se desempeñó como cantante y productor musical, antes de salir a los cinco años para dedicarse a sus propios proyectos y a componer para otros artistas.

**«Lucharé» y Viña del Mar**

Su álbum debut como solista, «Lucharé» (septiembre de 1995), incluyó los éxitos «Quiéreme», «A Pesar del Tiempo», «Y Qué Me Pasa» y el tema título, vendiendo más de 500 000 copias en Colombia y ganándole el premio al mejor intérprete en el Festival de Viña del Mar de Chile en 1996.

**Más álbumes**

«Más Romántico» (1999), encabezado por «Mi Historia Entre Tus Dedos», le trajo una nominación a los Premios Lo Nuestro; un álbum de bachata, «Sigo Siendo Romántico: Grandes Éxitos de la Bachata» (2003), vendió más modestamente pero le ganó una nominación al Grammy Latino. Siguieron «Te Esperaré» (2006) y «Pasado y Presente» (2013), este último revisitando sus éxitos de salsa de 1996-2002 en arreglos de pop, rock y balada, e incluyendo una versión de «Me Enloqueces», éxito del cantante colombiano Charlie Zaá. Un sencillo de 2016, «Hoy Ya Me Voy», contó con la participación especial de José Aguirre.

**Legado**

Radicado hoy en Miami, Taveras ha nombrado entre sus propias influencias a cantantes tan variados como Ismael Rivera, Félix del Rosario, Cuco Valoy y Ramón Orlando & Orquesta Internacional, un rango que refleja la amplitud de su propio catálogo entre salsa, merengue y bachata.' WHERE slug = 'mickey-taveras';

COMMIT;
