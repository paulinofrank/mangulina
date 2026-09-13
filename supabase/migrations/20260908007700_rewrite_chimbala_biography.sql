BEGIN;

-- Rewrite the catalogue entry for Chimbala.
--
-- Chimbala. DÉCIMA de las 211, con 14 enlaces entrantes. La ficha vieja tenía
-- 1.370 caracteres de COMENTARIO SOBRE EL GÉNERO y casi nada sobre él.
--
-- Tres párrafos explicando qué es el dembow, de dónde viene y por qué importa
-- -- "a homegrown response to reggaeton and dancehall", "did not need to be
-- subordinate to the reggaeton establishment centered in Puerto Rico and
-- Colombia" -- sin UNA canción, UN año, UN colaborador ni UN premio. Es una
-- ficha del dembow con el nombre de Chimbala encima.
--
-- CONFLICTO DE FECHA QUE NO RESUELVO. La fila guarda 18 DE MAYO DE 1991 y
-- Wikipedia dice 18 DE MAYO DE 1989. Mismo día y mes, dos años de diferencia.
-- NO TOCO LA FILA y el texto NO DA EL AÑO, que es lo único honesto cuando las
-- dos fuentes discrepan justo en eso. Queda para el editor.
--
-- EL NOMBRE LEGAL ESTABA INCOMPLETO Y EL ALIAS LO DELATABA: la fila guarda
-- first_name 'Leury', middle_name 'José', last_name 'Tejeda' y second_last_name
-- en NULL, mientras que aliases guardaba "Leury José Tejeda BRITO" completo. O
-- sea que el dato existía, mal colocado. Se mueve Brito a su campo y el alias
-- sale. DUODÉCIMO caso del patrón.
--
-- LO QUE FALTABA, QUE ES SU CARRERA ENTERA:
--
--   2012, sus primeros temas: "Tu Ere un Loco" y "Cuenta Conmigo", esta con
--   Pablo Piddy y Toxic Crow.
--
--   2014, "TU NO CORRE A NA", que grabó EN RESPUESTA a una canción en la que El
--   Alfa lo atacaba. Es una tiradera, y tiene su gracia porque ocho años
--   después los dos graban juntos "Wow BB". Ese arco no estaba.
--
--   2016, "TAMO BURLAO" con El Fother, que es con lo que vuelve.
--
--   2018, "MANIQUÍ", el sencillo que lo lanza.
--
--   2021, "LOCO", con Justin Quiles y Zion & Lennox: NÚMERO UNO en Latin
--   Airplay de Billboard, triple platino de la RIAA, oro en España e Italia, y
--   número uno en Los 40 de España.
--
--   2022, "WOW BB" con Natti Natasha y El Alfa, ESTRENADA EN VIVO EN PREMIO LO
--   NUESTRO, y platino de la RIAA.
--
--   Que BILLBOARD lo ha señalado como uno de los principales intérpretes de
--   dembow de América Latina, que es exactamente el dato que la ficha vieja
--   intentaba decir con adjetivos.
--
-- LA PROHIBICIÓN DE "MANIQUÍ" ENTRA, Y ES DE LOS DATOS MÁS IMPORTANTES DE LA
-- FICHA. En 2018 la Comisión Nacional de Espectáculos Públicos y Radiofonía la
-- prohibió en la República Dominicana junto a otros temas, por considerarlos no
-- aptos y de alto contenido obsceno en letras y videos. Volvió a la radio
-- después de que se le corrigiera la letra.
--
-- Es censura estatal sobre la obra, el mismo criterio por el que entraron
-- "Desacato Escolar" de Tokischa, la cárcel de Ramón Leonardo y los viajes
-- prohibidos de Víctor Víctor a Cuba. Y aquí hay un matiz que vale la pena
-- conservar: la canción no se retiró, se corrigió y volvió.
--
-- NO SE ESCRIBEN LAS REPRODUCCIONES. La fuente da 7 millones para "Tamo Burlao"
-- y 18 millones para "Maniquí". Cifras de plataforma. SÍ ENTRAN las posiciones
-- de lista y las certificaciones.
--
-- SIETE ENLACES, TODOS POR CRÉDITO: toxic-crow ("Cuenta Conmigo"), el-alfa (la
-- tiradera de 2014 y la colaboración de 2022), mozart-la-para (cuyo sello La
-- Para Records publicó "Colombiana"), natti-natasha ("Wow BB"), omega ("Se Me
-- Nota"), y don-miguelo y bulin-47, del segmento urbano de Premios Soberano de
-- 2018 y de la escena que comparte.
--
-- occupations SE QUEDA VACÍO Y SE REPORTA. No encontré crédito de composición ni
-- de producción a su nombre, y prefiero el campo vacío a meter 'songwriter'
-- porque suele ser cierto en el género. instruments sí se llena con voz.
--
-- FUENTES: Wikipedia en español, bien referenciada, con citas a Billboard,
-- Diario Libre, El Día, Hoy Digital, Warner Music y TelevisaUnivisión.
--
-- NOMBRES NUEVOS PARA LA LISTA: PABLO PIDDY (ya estaba anotado) y EL FOTHER (ya
-- estaba). LIRO SHAQ vuelve a salir, tercera ficha que lo nombra.
--
-- ---------------------------------------------------------------------------
-- CORRECCION DE REGISTRO, 8 de septiembre de 2026
--
-- Esta ficha tenia la muletilla que el editor me corrigio hace tiempo:
-- SENALAR CUAL DE LOS DATOS QUE ACABO DE DAR ES EL IMPORTANTE, en vez de
-- escribirlo y seguir. Una biografia expone; no se comenta a si misma.
--
-- La cazo un barrido propio, no un gate: BANNED tenia 'worth holding still',
-- 'conviene dejar' y 'conviene decir', y estas variantes pasaron por el hueco
-- entre ellas. mk.cjs lleva ya un patron que persigue la forma y no las
-- palabras, asi que no puede repetirse.
--
-- La frase sale y el dato se queda: no hacia falta anunciarlo.
-- ---------------------------------------------------------------------------
--
-- Applied directly over DATABASE_URL as part of an editorial pass. No Vercel
-- function ran and nothing was revalidated; the profile reaches the public site
-- on its own within the 31-day ISR fallback for artist profiles, or sooner if a
-- targeted revalidation is run for the slug.
--
-- This file reproduces the change from the pre-pass state. Both it and its
-- rollback were generated from state captured live either side of the write,
-- not reconstructed afterwards.

UPDATE artists SET
       name = 'Chimbala',
       sort_name = 'Tejeda Brito, Leury José',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urbano',
       date_of_birth = '1991-05-18',
       birth_year = 1991,
       date_of_death = NULL,
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = 'Leury',
       middle_name = 'José',
       last_name = 'Tejeda',
       second_last_name = 'Brito',
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY['urban-reggaeton', 'urban-dembow']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@ChimbalaHD',
       facebook = 'ChimbalaOfficial',
       instagram = 'chimbalaofficial',
       disambiguation = 'Dembow singer; took Loco to number one on Latin Airplay and had Maniquí banned at home',
       bio_en = 'Leury José Tejeda Brito, who records as Chimbala, is a Dominican dembow singer. Billboard has named him among the principal performers of the genre in Latin America, and he is one of the few Dominican artists to have taken a dembow record to the top of an American radio chart.

**The first records**

He has been recording since 2008. In 2012 came Tu Ere un Loco and Cuenta Conmigo, the second made with Pablo Piddy and Toxic Crow. Two years later he cut Tu No Corre a Na in answer to a record on which El Alfa had come after him, which was how disputes in the genre were settled at the time.

He came back in late 2016 with Tamo Burlao, made with El Fother, and spent the following year touring Europe, Argentina and the United States.

**Maniquí**

Maniquí, released in May 2018, is the record that moved him. It travelled through Latin America, Miami and parts of Europe, particularly Spain and Italy, carried by a video of dancers built around the song.

That same year the national commission for public entertainment and broadcasting banned it in the Dominican Republic, along with other records, judging the lyrics and the video obscene. The song went back onto the radio after its words were changed: it was not withdrawn, it was corrected and returned.

**Colombiana**

In January 2019 he released Colombiana, produced by B-One and issued through La Para Records, the label belonging to Mozart la Para. He also recorded Se Me Nota with Omega, which earned an American certification.

**Loco**

Loco, in 2021, was made with the Puerto Ricans Justin Quiles and Zion & Lennox and went to number one on Billboard’s Latin Airplay chart. It was certified triple platinum in the United States and gold in Spain and Italy, and it topped Los 40 in Spain.

The following year he sang Wow BB with Natti Natasha and El Alfa, premiering it live at Premio Lo Nuestro; it was certified platinum in March. Feliz went to number one on the Dominican Monitor Latino chart, and Déjate Ver repeated that in 2023.

**The scene**

He belongs to the generation that made dembow exportable, and works inside it rather than beside it: he shared the urban segment of the Premios Soberano with Don Miguelo and has recorded with Bulin 47. He has also worked with Wisin, Farruko and Pitbull.',
       bio_es = 'Leury José Tejeda Brito, que graba como Chimbala, es un cantante dominicano de dembow. Billboard lo ha señalado entre los principales intérpretes del género en América Latina, y es de los pocos artistas dominicanos que han llevado un disco de dembow al primer lugar de una lista de radio estadounidense.

**Los primeros discos**

Graba desde 2008. En 2012 salieron Tu Ere un Loco y Cuenta Conmigo, esta última hecha con Pablo Piddy y Toxic Crow. Dos años después grabó Tu No Corre a Na en respuesta a un tema en el que El Alfa le había tirado, que era como se resolvían las disputas del género en ese momento.

Volvió a finales de 2016 con Tamo Burlao, hecha con El Fother, y pasó el año siguiente de gira por Europa, Argentina y Estados Unidos.

**Maniquí**

Maniquí, publicada en mayo de 2018, es el disco que lo mueve. Viajó por América Latina, Miami y partes de Europa, en particular España e Italia, empujada por un video de bailarinas armado alrededor de la canción.

Ese mismo año la Comisión Nacional de Espectáculos Públicos y Radiofonía la prohibió en la República Dominicana, junto a otros temas, por considerar obscenos la letra y el video. La canción volvió a la radio después de que se le corrigiera la letra: no se retiró, se corrigió y volvió.

**Colombiana**

En enero de 2019 publicó Colombiana, producida por B-One y editada por La Para Records, el sello de Mozart la Para. Grabó además Se Me Nota con Omega, que obtuvo una certificación estadounidense.

**Loco**

Loco, de 2021, la hizo con los puertorriqueños Justin Quiles y Zion & Lennox y llegó al número uno de la lista Latin Airplay de Billboard. Se certificó triple platino en Estados Unidos y oro en España e Italia, y encabezó Los 40 en España.

Al año siguiente cantó Wow BB con Natti Natasha y El Alfa, estrenándola en vivo en Premio Lo Nuestro; en marzo se certificó platino. Feliz llegó al número uno de Monitor Latino en la República Dominicana, y Déjate Ver repitió el puesto en 2023.

**La escena**

Pertenece a la generación que hizo exportable el dembow, y trabaja dentro de ella y no al lado: compartió el segmento urbano de los Premios Soberano con Don Miguelo y ha grabado con Bulin 47. Ha trabajado además con Wisin, Farruko y Pitbull.',
       updated_at = now()
 WHERE slug = 'chimbala';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Leury José Tejeda Brito, who records as Chimbala, is a Dominican dembow singer. Billboard has named him among the principal performers of the genre in Latin America, and he is one of the few Dominican artists to have taken a dembow record to the top of an American radio chart.","type":"text"}]},{"type":"paragraph","content":[{"text":"The first records","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He has been recording since 2008. In 2012 came Tu Ere un Loco and Cuenta Conmigo, the second made with Pablo Piddy and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d25ea8c2-1e9f-4f77-832a-48886d50c47b","displayText":"Toxic Crow","occurrenceId":"bf9e8820-c447-45d7-be0c-4d8dbfced167"}},{"text":". Two years later he cut Tu No Corre a Na in answer to a record on which ","type":"text"},{"type":"artistReference","attrs":{"artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa","occurrenceId":"61a55c9d-66c5-4751-a9a6-c06a24aae40d"}},{"text":" had come after him, which was how disputes in the genre were settled at the time.","type":"text"}]},{"type":"paragraph","content":[{"text":"He came back in late 2016 with Tamo Burlao, made with El Fother, and spent the following year touring Europe, Argentina and the United States.","type":"text"}]},{"type":"paragraph","content":[{"text":"Maniquí","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Maniquí, released in May 2018, is the record that moved him. It travelled through Latin America, Miami and parts of Europe, particularly Spain and Italy, carried by a video of dancers built around the song.","type":"text"}]},{"type":"paragraph","content":[{"text":"That same year the national commission for public entertainment and broadcasting banned it in the Dominican Republic, along with other records, judging the lyrics and the video obscene. The song went back onto the radio after its words were changed: it was not withdrawn, it was corrected and returned.","type":"text"}]},{"type":"paragraph","content":[{"text":"Colombiana","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In January 2019 he released Colombiana, produced by B-One and issued through La Para Records, the label belonging to ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fa9cc802-28ca-4695-b585-f75aa90a2b6c","displayText":"Mozart la Para","occurrenceId":"f21e53ec-bea2-4659-b4f7-1d02433572f0"}},{"text":". He also recorded Se Me Nota with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6159dc70-bd8f-439d-bf17-5d690262e5cb","displayText":"Omega","occurrenceId":"8180b25d-8036-4236-b1e7-842901b048d9"}},{"text":", which earned an American certification.","type":"text"}]},{"type":"paragraph","content":[{"text":"Loco","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Loco, in 2021, was made with the Puerto Ricans Justin Quiles and Zion & Lennox and went to number one on Billboard’s Latin Airplay chart. It was certified triple platinum in the United States and gold in Spain and Italy, and it topped Los 40 in Spain.","type":"text"}]},{"type":"paragraph","content":[{"text":"The following year he sang Wow BB with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"af726afa-c7a0-47da-99bb-a4c7669a8785","displayText":"Natti Natasha","occurrenceId":"4db33fe7-b861-4d9a-a6a0-322b8f333120"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa","occurrenceId":"84abc237-9626-4550-96f8-103ea654f518"}},{"text":", premiering it live at Premio Lo Nuestro; it was certified platinum in March. Feliz went to number one on the Dominican Monitor Latino chart, and Déjate Ver repeated that in 2023.","type":"text"}]},{"type":"paragraph","content":[{"text":"The scene","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He belongs to the generation that made dembow exportable, and works inside it rather than beside it: he shared the urban segment of the Premios Soberano with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"81767ee9-8a4c-4e8b-856d-be03695d1b4c"}},{"text":" and has recorded with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47","occurrenceId":"7c018170-3f11-47e5-be9c-edcc24f33ae2"}},{"text":". He has also worked with Wisin, Farruko and Pitbull.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'chimbala'), 3)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Leury José Tejeda Brito, que graba como Chimbala, es un cantante dominicano de dembow. Billboard lo ha señalado entre los principales intérpretes del género en América Latina, y es de los pocos artistas dominicanos que han llevado un disco de dembow al primer lugar de una lista de radio estadounidense.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los primeros discos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Graba desde 2008. En 2012 salieron Tu Ere un Loco y Cuenta Conmigo, esta última hecha con Pablo Piddy y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d25ea8c2-1e9f-4f77-832a-48886d50c47b","displayText":"Toxic Crow","occurrenceId":"344090f7-dbcb-4f4d-8a06-593d2300e758"}},{"text":". Dos años después grabó Tu No Corre a Na en respuesta a un tema en el que ","type":"text"},{"type":"artistReference","attrs":{"artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa","occurrenceId":"871441dc-f4e7-4b97-862d-70b7921c5ef9"}},{"text":" le había tirado, que era como se resolvían las disputas del género en ese momento.","type":"text"}]},{"type":"paragraph","content":[{"text":"Volvió a finales de 2016 con Tamo Burlao, hecha con El Fother, y pasó el año siguiente de gira por Europa, Argentina y Estados Unidos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Maniquí","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Maniquí, publicada en mayo de 2018, es el disco que lo mueve. Viajó por América Latina, Miami y partes de Europa, en particular España e Italia, empujada por un video de bailarinas armado alrededor de la canción.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ese mismo año la Comisión Nacional de Espectáculos Públicos y Radiofonía la prohibió en la República Dominicana, junto a otros temas, por considerar obscenos la letra y el video. La canción volvió a la radio después de que se le corrigiera la letra: no se retiró, se corrigió y volvió.","type":"text"}]},{"type":"paragraph","content":[{"text":"Colombiana","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En enero de 2019 publicó Colombiana, producida por B-One y editada por La Para Records, el sello de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fa9cc802-28ca-4695-b585-f75aa90a2b6c","displayText":"Mozart la Para","occurrenceId":"e098f786-e649-49bc-9c88-262f888378b3"}},{"text":". Grabó además Se Me Nota con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6159dc70-bd8f-439d-bf17-5d690262e5cb","displayText":"Omega","occurrenceId":"4f1c6d2f-3fad-4be8-b912-6eceac9f6d2f"}},{"text":", que obtuvo una certificación estadounidense.","type":"text"}]},{"type":"paragraph","content":[{"text":"Loco","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Loco, de 2021, la hizo con los puertorriqueños Justin Quiles y Zion & Lennox y llegó al número uno de la lista Latin Airplay de Billboard. Se certificó triple platino en Estados Unidos y oro en España e Italia, y encabezó Los 40 en España.","type":"text"}]},{"type":"paragraph","content":[{"text":"Al año siguiente cantó Wow BB con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"af726afa-c7a0-47da-99bb-a4c7669a8785","displayText":"Natti Natasha","occurrenceId":"cc07c7c4-7ddb-4602-b815-bc6f764db671"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa","occurrenceId":"96ba4b40-5f80-4ba0-b041-e1d9b0315f79"}},{"text":", estrenándola en vivo en Premio Lo Nuestro; en marzo se certificó platino. Feliz llegó al número uno de Monitor Latino en la República Dominicana, y Déjate Ver repitió el puesto en 2023.","type":"text"}]},{"type":"paragraph","content":[{"text":"La escena","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Pertenece a la generación que hizo exportable el dembow, y trabaja dentro de ella y no al lado: compartió el segmento urbano de los Premios Soberano con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"7288ee0d-bbde-41ef-a5ab-823892b8b863"}},{"text":" y ha grabado con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47","occurrenceId":"61c49759-3b47-40a2-b8d0-a38f36652cbd"}},{"text":". Ha trabajado además con Wisin, Farruko y Pitbull.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'chimbala'), 2)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), '4db33fe7-b861-4d9a-a6a0-322b8f333120', 'artist', 'af726afa-c7a0-47da-99bb-a4c7669a8785');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), '61a55c9d-66c5-4751-a9a6-c06a24aae40d', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), '7c018170-3f11-47e5-be9c-edcc24f33ae2', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), '81767ee9-8a4c-4e8b-856d-be03695d1b4c', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), '8180b25d-8036-4236-b1e7-842901b048d9', 'artist', '6159dc70-bd8f-439d-bf17-5d690262e5cb');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), '84abc237-9626-4550-96f8-103ea654f518', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), 'bf9e8820-c447-45d7-be0c-4d8dbfced167', 'artist', 'd25ea8c2-1e9f-4f77-832a-48886d50c47b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), 'f21e53ec-bea2-4659-b4f7-1d02433572f0', 'artist', 'fa9cc802-28ca-4695-b585-f75aa90a2b6c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), '344090f7-dbcb-4f4d-8a06-593d2300e758', 'artist', 'd25ea8c2-1e9f-4f77-832a-48886d50c47b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), '4f1c6d2f-3fad-4be8-b912-6eceac9f6d2f', 'artist', '6159dc70-bd8f-439d-bf17-5d690262e5cb');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), '61c49759-3b47-40a2-b8d0-a38f36652cbd', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), '7288ee0d-bbde-41ef-a5ab-823892b8b863', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), '871441dc-f4e7-4b97-862d-70b7921c5ef9', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), '96ba4b40-5f80-4ba0-b041-e1d9b0315f79', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), 'cc07c7c4-7ddb-4602-b815-bc6f764db671', 'artist', 'af726afa-c7a0-47da-99bb-a4c7669a8785');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), 'e098f786-e649-49bc-9c88-262f888378b3', 'artist', 'fa9cc802-28ca-4695-b585-f75aa90a2b6c');

COMMIT;
