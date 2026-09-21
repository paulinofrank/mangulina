BEGIN;

-- Manolé y la Banda del Truco: orquesta de merengue fundada por el pianista, compositor y arreglista Manuel Pérez, Manolé; la ficha solo tenía una frase vacía. Fuentes: un perfil de su carrera publicado en Facebook (1 ene. 2020: nacimiento un 31 de diciembre en Duvergé, trayectoria como director musical, fundación de la orquesta, éxitos, hoy solo salsa, sello Go-Latino Records), Apple Music (formada en 1997, música tropical), MusicBrainz (inicio 1997, 'Dominican merengue band'), YouTube (Las mujeres son mi locura, 2018 en JN Music Group; Seguiré cantando, 2012), una publicación sobre una presentación en 'La Súper Tarde' de Color Visión Canal 9 en 1998. Fuente única para la biografía: no se nombra el medio. Se omite la cifra de 500,000 copias de «Como una reina» (afirmación sin fuente independiente) y no se afirma el año de nacimiento de Manolé. Campos: birth_year 1997 (formación), occupations bandleader. Enlazados: Carlos Manuel El Zafiro, Cheché Abreu, Raulín Rosendo, Benny Sadel y José Peña Suazo y La Banda Gorda (el perfil habla de 'la Banda Gorda').

UPDATE artists SET birth_year = 1997, occupations = '["bandleader"]'::jsonb WHERE slug = 'manole-y-la-banda-del-truco';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manolé y la Banda del Truco is a Dominican merengue orchestra founded in 1997 by the pianist, composer and arranger Manuel Pérez, known as Manolé, who was born in Duvergé."}]},{"type":"paragraph","content":[{"type":"text","text":"Manolé","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"According to a career profile published in 2020, Manolé was musical director of the orchestra of "},{"type":"artistReference","attrs":{"occurrenceId":"e950748b-8b49-46b5-a153-b37550ef1575","artistId":"703e412f-92ba-4ad8-a84c-54adc831c5e6","displayText":"Carlos Manuel El Zafiro"}},{"type":"text","text":" and later worked with other prominent groups, such as those of "},{"type":"artistReference","attrs":{"occurrenceId":"e577803e-447f-4bec-b8ec-c700bc905382","artistId":"73691e65-206a-4c71-9b5f-8689f15b2584","displayText":"Cheché Abreu"}},{"type":"text","text":", Grupo Tambó, "},{"type":"artistReference","attrs":{"occurrenceId":"79b6428c-d5c0-4035-8e0f-136091b98a34","artistId":"faf3e4cb-808e-419c-87ff-5126eed85e73","displayText":"Raulín Rosendo"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"a6b76882-8b62-480a-a166-5a7ad2ff9dab","artistId":"15775d55-9e10-46bc-8516-ee7468724ec0","displayText":"Benny Sadel"}},{"type":"text","text":" and Juanchy Vásquez “El Galeno”, until he became co-producer and musical director of "},{"type":"artistReference","attrs":{"occurrenceId":"9c478bb1-473e-4a6c-8e01-10091f2c3503","artistId":"b41d4bd2-9303-4834-885e-e7dee35a0287","displayText":"José Peña Suazo y La Banda Gorda"}},{"type":"text","text":". He then founded his own orchestra, which he named La Banda del Truco."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"With the orchestra he had popular hits with «Las mujeres son mi locura», «Te bateo a ti», «Sufriendo callao», «Seguiré cantando» and «Tiene truco», and a salsa and tropical song, «Como una reina», that the profile describes as an international success. In 1998 the band appeared on the program «La Súper Tarde» of Color Visión Canal 9. Its album «Las mujeres son mi locura» was also released on CD."}]},{"type":"paragraph","content":[{"type":"text","text":"Salsa","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The same profile says that Manolé now devotes himself only to salsa, with songs such as «Todavía creo en el amor», «Separados» and «Cuéntale», and that he belongs to the independent label Go-Latino Records, whose recent singles include «Por un poco de tu amor» and «A mi madre»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The orchestra is documented through its 1990s recordings and the career profile of its leader."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manole-y-la-banda-del-truco'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manole-y-la-banda-del-truco' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'e950748b-8b49-46b5-a153-b37550ef1575', 'artist', '703e412f-92ba-4ad8-a84c-54adc831c5e6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manole-y-la-banda-del-truco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'e577803e-447f-4bec-b8ec-c700bc905382', 'artist', '73691e65-206a-4c71-9b5f-8689f15b2584' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manole-y-la-banda-del-truco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '79b6428c-d5c0-4035-8e0f-136091b98a34', 'artist', 'faf3e4cb-808e-419c-87ff-5126eed85e73' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manole-y-la-banda-del-truco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'a6b76882-8b62-480a-a166-5a7ad2ff9dab', 'artist', '15775d55-9e10-46bc-8516-ee7468724ec0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manole-y-la-banda-del-truco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '9c478bb1-473e-4a6c-8e01-10091f2c3503', 'artist', 'b41d4bd2-9303-4834-885e-e7dee35a0287' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manole-y-la-banda-del-truco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Manolé y la Banda del Truco is a Dominican merengue orchestra founded in 1997 by the pianist, composer and arranger Manuel Pérez, known as Manolé, who was born in Duvergé.

**Manolé**

According to a career profile published in 2020, Manolé was musical director of the orchestra of Carlos Manuel El Zafiro and later worked with other prominent groups, such as those of Cheché Abreu, Grupo Tambó, Raulín Rosendo, Benny Sadel and Juanchy Vásquez “El Galeno”, until he became co-producer and musical director of José Peña Suazo y La Banda Gorda. He then founded his own orchestra, which he named La Banda del Truco.

**Songs**

With the orchestra he had popular hits with «Las mujeres son mi locura», «Te bateo a ti», «Sufriendo callao», «Seguiré cantando» and «Tiene truco», and a salsa and tropical song, «Como una reina», that the profile describes as an international success. In 1998 the band appeared on the program «La Súper Tarde» of Color Visión Canal 9. Its album «Las mujeres son mi locura» was also released on CD.

**Salsa**

The same profile says that Manolé now devotes himself only to salsa, with songs such as «Todavía creo en el amor», «Separados» and «Cuéntale», and that he belongs to the independent label Go-Latino Records, whose recent singles include «Por un poco de tu amor» and «A mi madre».

**Legacy**

The orchestra is documented through its 1990s recordings and the career profile of its leader.' WHERE slug = 'manole-y-la-banda-del-truco';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manolé y la Banda del Truco es una orquesta dominicana de merengue fundada en 1997 por el pianista, compositor y arreglista Manuel Pérez, conocido como Manolé, nacido en Duvergé."}]},{"type":"paragraph","content":[{"type":"text","text":"Manolé","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Según un perfil de su trayectoria publicado en 2020, Manolé fue director musical de la orquesta de "},{"type":"artistReference","attrs":{"occurrenceId":"86f37488-7d20-4f62-aa8c-35b1486cb16f","artistId":"703e412f-92ba-4ad8-a84c-54adc831c5e6","displayText":"Carlos Manuel El Zafiro"}},{"type":"text","text":" y después trabajó con otras agrupaciones destacadas, como las de "},{"type":"artistReference","attrs":{"occurrenceId":"efc72708-41a1-4e83-b74f-1a114d664557","artistId":"73691e65-206a-4c71-9b5f-8689f15b2584","displayText":"Cheché Abreu"}},{"type":"text","text":", Grupo Tambó, "},{"type":"artistReference","attrs":{"occurrenceId":"9824981b-3e10-4030-a700-c49b986f4d49","artistId":"faf3e4cb-808e-419c-87ff-5126eed85e73","displayText":"Raulín Rosendo"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"8f150dd5-1b95-434a-94ab-b42f0c718f34","artistId":"15775d55-9e10-46bc-8516-ee7468724ec0","displayText":"Benny Sadel"}},{"type":"text","text":" y Juanchy Vásquez “El Galeno”, hasta llegar a ser coproductor y director musical de "},{"type":"artistReference","attrs":{"occurrenceId":"fc6727a4-80b1-40c3-88d8-b05676add632","artistId":"b41d4bd2-9303-4834-885e-e7dee35a0287","displayText":"José Peña Suazo y La Banda Gorda"}},{"type":"text","text":". Luego fundó su propia orquesta, a la que llamó La Banda del Truco."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Con la orquesta tuvo éxitos populares con «Las mujeres son mi locura», «Te bateo a ti», «Sufriendo callao», «Seguiré cantando» y «Tiene truco», y una canción de salsa y tropical, «Como una reina», que el perfil describe como un éxito internacional. En 1998 la banda apareció en el programa «La Súper Tarde» de Color Visión Canal 9. Su álbum «Las mujeres son mi locura» salió también en CD."}]},{"type":"paragraph","content":[{"type":"text","text":"Salsa","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El mismo perfil dice que Manolé se dedica hoy solo a la salsa, con temas como «Todavía creo en el amor», «Separados» y «Cuéntale», y que pertenece al sello independiente Go-Latino Records, cuyos sencillos recientes incluyen «Por un poco de tu amor» y «A mi madre»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La orquesta está documentada a través de sus grabaciones de los años noventa y del perfil de trayectoria de su líder."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manole-y-la-banda-del-truco'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manole-y-la-banda-del-truco' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '86f37488-7d20-4f62-aa8c-35b1486cb16f', 'artist', '703e412f-92ba-4ad8-a84c-54adc831c5e6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manole-y-la-banda-del-truco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'efc72708-41a1-4e83-b74f-1a114d664557', 'artist', '73691e65-206a-4c71-9b5f-8689f15b2584' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manole-y-la-banda-del-truco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '9824981b-3e10-4030-a700-c49b986f4d49', 'artist', 'faf3e4cb-808e-419c-87ff-5126eed85e73' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manole-y-la-banda-del-truco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '8f150dd5-1b95-434a-94ab-b42f0c718f34', 'artist', '15775d55-9e10-46bc-8516-ee7468724ec0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manole-y-la-banda-del-truco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'fc6727a4-80b1-40c3-88d8-b05676add632', 'artist', 'b41d4bd2-9303-4834-885e-e7dee35a0287' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manole-y-la-banda-del-truco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Manolé y la Banda del Truco es una orquesta dominicana de merengue fundada en 1997 por el pianista, compositor y arreglista Manuel Pérez, conocido como Manolé, nacido en Duvergé.

**Manolé**

Según un perfil de su trayectoria publicado en 2020, Manolé fue director musical de la orquesta de Carlos Manuel El Zafiro y después trabajó con otras agrupaciones destacadas, como las de Cheché Abreu, Grupo Tambó, Raulín Rosendo, Benny Sadel y Juanchy Vásquez “El Galeno”, hasta llegar a ser coproductor y director musical de José Peña Suazo y La Banda Gorda. Luego fundó su propia orquesta, a la que llamó La Banda del Truco.

**Canciones**

Con la orquesta tuvo éxitos populares con «Las mujeres son mi locura», «Te bateo a ti», «Sufriendo callao», «Seguiré cantando» y «Tiene truco», y una canción de salsa y tropical, «Como una reina», que el perfil describe como un éxito internacional. En 1998 la banda apareció en el programa «La Súper Tarde» de Color Visión Canal 9. Su álbum «Las mujeres son mi locura» salió también en CD.

**Salsa**

El mismo perfil dice que Manolé se dedica hoy solo a la salsa, con temas como «Todavía creo en el amor», «Separados» y «Cuéntale», y que pertenece al sello independiente Go-Latino Records, cuyos sencillos recientes incluyen «Por un poco de tu amor» y «A mi madre».

**Legado**

La orquesta está documentada a través de sus grabaciones de los años noventa y del perfil de trayectoria de su líder.' WHERE slug = 'manole-y-la-banda-del-truco';

COMMIT;
