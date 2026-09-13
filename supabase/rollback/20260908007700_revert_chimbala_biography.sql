BEGIN;

-- Reverts 20260908007700_rewrite_chimbala_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

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

That same year the national commission for public entertainment and broadcasting banned it in the Dominican Republic, along with other records, judging the lyrics and the video obscene. The song went back onto the radio after its words were changed — which is the part worth keeping: it was not withdrawn, it was corrected and returned.

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

Ese mismo año la Comisión Nacional de Espectáculos Públicos y Radiofonía la prohibió en la República Dominicana, junto a otros temas, por considerar obscenos la letra y el video. La canción volvió a la radio después de que se le corrigiera la letra, que es la parte que conviene retener: no se retiró, se corrigió y volvió.

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
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Leury José Tejeda Brito, who records as Chimbala, is a Dominican dembow singer. Billboard has named him among the principal performers of the genre in Latin America, and he is one of the few Dominican artists to have taken a dembow record to the top of an American radio chart.","type":"text"}]},{"type":"paragraph","content":[{"text":"The first records","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He has been recording since 2008. In 2012 came Tu Ere un Loco and Cuenta Conmigo, the second made with Pablo Piddy and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d25ea8c2-1e9f-4f77-832a-48886d50c47b","displayText":"Toxic Crow","occurrenceId":"42075177-3af9-4eae-b900-03b371dcc172"}},{"text":". Two years later he cut Tu No Corre a Na in answer to a record on which ","type":"text"},{"type":"artistReference","attrs":{"artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa","occurrenceId":"83d3484f-69dc-49b1-b513-402a25a6393a"}},{"text":" had come after him, which was how disputes in the genre were settled at the time.","type":"text"}]},{"type":"paragraph","content":[{"text":"He came back in late 2016 with Tamo Burlao, made with El Fother, and spent the following year touring Europe, Argentina and the United States.","type":"text"}]},{"type":"paragraph","content":[{"text":"Maniquí","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Maniquí, released in May 2018, is the record that moved him. It travelled through Latin America, Miami and parts of Europe, particularly Spain and Italy, carried by a video of dancers built around the song.","type":"text"}]},{"type":"paragraph","content":[{"text":"That same year the national commission for public entertainment and broadcasting banned it in the Dominican Republic, along with other records, judging the lyrics and the video obscene. The song went back onto the radio after its words were changed — which is the part worth keeping: it was not withdrawn, it was corrected and returned.","type":"text"}]},{"type":"paragraph","content":[{"text":"Colombiana","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In January 2019 he released Colombiana, produced by B-One and issued through La Para Records, the label belonging to ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fa9cc802-28ca-4695-b585-f75aa90a2b6c","displayText":"Mozart la Para","occurrenceId":"05060df1-01ae-41ac-86c9-a789d776518e"}},{"text":". He also recorded Se Me Nota with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6159dc70-bd8f-439d-bf17-5d690262e5cb","displayText":"Omega","occurrenceId":"43d5750b-79c8-43e5-844e-ec2d1f4ffea6"}},{"text":", which earned an American certification.","type":"text"}]},{"type":"paragraph","content":[{"text":"Loco","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Loco, in 2021, was made with the Puerto Ricans Justin Quiles and Zion & Lennox and went to number one on Billboard’s Latin Airplay chart. It was certified triple platinum in the United States and gold in Spain and Italy, and it topped Los 40 in Spain.","type":"text"}]},{"type":"paragraph","content":[{"text":"The following year he sang Wow BB with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"af726afa-c7a0-47da-99bb-a4c7669a8785","displayText":"Natti Natasha","occurrenceId":"973f15d0-509b-4df5-83ff-db1143fac397"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa","occurrenceId":"3407b4f2-f3d8-4ea2-85d0-017b35ca28f0"}},{"text":", premiering it live at Premio Lo Nuestro; it was certified platinum in March. Feliz went to number one on the Dominican Monitor Latino chart, and Déjate Ver repeated that in 2023.","type":"text"}]},{"type":"paragraph","content":[{"text":"The scene","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He belongs to the generation that made dembow exportable, and works inside it rather than beside it: he shared the urban segment of the Premios Soberano with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"1131c05b-34b9-4978-bb59-a030fea31d20"}},{"text":" and has recorded with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47","occurrenceId":"cce962c6-ca55-422b-9d14-4f6bd68d4a39"}},{"text":". He has also worked with Wisin, Farruko and Pitbull.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'chimbala'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Leury José Tejeda Brito, que graba como Chimbala, es un cantante dominicano de dembow. Billboard lo ha señalado entre los principales intérpretes del género en América Latina, y es de los pocos artistas dominicanos que han llevado un disco de dembow al primer lugar de una lista de radio estadounidense.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los primeros discos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Graba desde 2008. En 2012 salieron Tu Ere un Loco y Cuenta Conmigo, esta última hecha con Pablo Piddy y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"d25ea8c2-1e9f-4f77-832a-48886d50c47b","displayText":"Toxic Crow","occurrenceId":"78e36ebc-0908-4899-b354-d362d65b74e0"}},{"text":". Dos años después grabó Tu No Corre a Na en respuesta a un tema en el que ","type":"text"},{"type":"artistReference","attrs":{"artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa","occurrenceId":"5f831be5-754e-4356-9f31-edf23096f5b8"}},{"text":" le había tirado, que era como se resolvían las disputas del género en ese momento.","type":"text"}]},{"type":"paragraph","content":[{"text":"Volvió a finales de 2016 con Tamo Burlao, hecha con El Fother, y pasó el año siguiente de gira por Europa, Argentina y Estados Unidos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Maniquí","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Maniquí, publicada en mayo de 2018, es el disco que lo mueve. Viajó por América Latina, Miami y partes de Europa, en particular España e Italia, empujada por un video de bailarinas armado alrededor de la canción.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ese mismo año la Comisión Nacional de Espectáculos Públicos y Radiofonía la prohibió en la República Dominicana, junto a otros temas, por considerar obscenos la letra y el video. La canción volvió a la radio después de que se le corrigiera la letra, que es la parte que conviene retener: no se retiró, se corrigió y volvió.","type":"text"}]},{"type":"paragraph","content":[{"text":"Colombiana","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En enero de 2019 publicó Colombiana, producida por B-One y editada por La Para Records, el sello de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fa9cc802-28ca-4695-b585-f75aa90a2b6c","displayText":"Mozart la Para","occurrenceId":"7c9a8374-c190-4242-b8d2-01957943bd99"}},{"text":". Grabó además Se Me Nota con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6159dc70-bd8f-439d-bf17-5d690262e5cb","displayText":"Omega","occurrenceId":"e5db31e1-7d56-4446-a788-0bc782d561e9"}},{"text":", que obtuvo una certificación estadounidense.","type":"text"}]},{"type":"paragraph","content":[{"text":"Loco","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Loco, de 2021, la hizo con los puertorriqueños Justin Quiles y Zion & Lennox y llegó al número uno de la lista Latin Airplay de Billboard. Se certificó triple platino en Estados Unidos y oro en España e Italia, y encabezó Los 40 en España.","type":"text"}]},{"type":"paragraph","content":[{"text":"Al año siguiente cantó Wow BB con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"af726afa-c7a0-47da-99bb-a4c7669a8785","displayText":"Natti Natasha","occurrenceId":"a9cc426f-e212-4302-a173-e52165028d91"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa","occurrenceId":"c9a9c808-107b-44ff-ad6f-fefa67307724"}},{"text":", estrenándola en vivo en Premio Lo Nuestro; en marzo se certificó platino. Feliz llegó al número uno de Monitor Latino en la República Dominicana, y Déjate Ver repitió el puesto en 2023.","type":"text"}]},{"type":"paragraph","content":[{"text":"La escena","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Pertenece a la generación que hizo exportable el dembow, y trabaja dentro de ella y no al lado: compartió el segmento urbano de los Premios Soberano con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"1d13f165-5c5a-4f8d-92a4-a511c26d80ba"}},{"text":" y ha grabado con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47","occurrenceId":"2ac557a1-d397-4007-9059-2451c3e1fbb8"}},{"text":". Ha trabajado además con Wisin, Farruko y Pitbull.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'chimbala'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), '05060df1-01ae-41ac-86c9-a789d776518e', 'artist', 'fa9cc802-28ca-4695-b585-f75aa90a2b6c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), '1131c05b-34b9-4978-bb59-a030fea31d20', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), '3407b4f2-f3d8-4ea2-85d0-017b35ca28f0', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), '42075177-3af9-4eae-b900-03b371dcc172', 'artist', 'd25ea8c2-1e9f-4f77-832a-48886d50c47b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), '43d5750b-79c8-43e5-844e-ec2d1f4ffea6', 'artist', '6159dc70-bd8f-439d-bf17-5d690262e5cb');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), '83d3484f-69dc-49b1-b513-402a25a6393a', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), '973f15d0-509b-4df5-83ff-db1143fac397', 'artist', 'af726afa-c7a0-47da-99bb-a4c7669a8785');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'en'), 'cce962c6-ca55-422b-9d14-4f6bd68d4a39', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), '1d13f165-5c5a-4f8d-92a4-a511c26d80ba', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), '2ac557a1-d397-4007-9059-2451c3e1fbb8', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), '5f831be5-754e-4356-9f31-edf23096f5b8', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), '78e36ebc-0908-4899-b354-d362d65b74e0', 'artist', 'd25ea8c2-1e9f-4f77-832a-48886d50c47b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), '7c9a8374-c190-4242-b8d2-01957943bd99', 'artist', 'fa9cc802-28ca-4695-b585-f75aa90a2b6c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), 'a9cc426f-e212-4302-a173-e52165028d91', 'artist', 'af726afa-c7a0-47da-99bb-a4c7669a8785');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), 'c9a9c808-107b-44ff-ad6f-fefa67307724', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chimbala') AND locale = 'es'), 'e5db31e1-7d56-4446-a788-0bc782d561e9', 'artist', '6159dc70-bd8f-439d-bf17-5d690262e5cb');

COMMIT;
