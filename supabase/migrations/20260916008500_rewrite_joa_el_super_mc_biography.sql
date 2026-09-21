BEGIN;

-- Joa el Super MC (Carlos Jhordany Medrano): rapero y productor de San Carlos, Santo Domingo, de la Charles Family; la fila decía José Manuel Almonte sin respaldo. Fuentes: Last.fm (biografía de comunidad, versión de abr. 2010: nacimiento, San Carlos, C1-03, Charles Family 2003, «Redada Remix» 2004, «7 golpes» 2006, solista 2007, «Juniol»), biografía de Spotify e IMDb (nombre Carlos Jhordany Joa Medrano, alias Joa el Abuelo, 15 dic. 1983), sus cuentas en X e Instagram (pionero, 20 años de carrera), discografía de MusicBrainz (2013-2017) y Spotify (2024-2026), YouTube. Conflicto: la fila daba José Manuel Almonte; tres fuentes dan Carlos Jhordany Medrano con la misma fecha de nacimiento: se corrige, la fecha (15 dic. 1983) coincide. Última fuente de peso es un wiki editable de 2010 y no hay prensa independiente abierta: el texto la atribuye. La rivalidad con Lápiz Conciente que el wiki cuenta no se incluye. Ejercicios Vocales: álbum en 2016 en plataformas (MusicBrainz) y mixtape en 2012 (blog). Campos: nombre civil, alias Joa el Abuelo, primary_role rapper, occupations producer, lyricist, composer.

UPDATE artists SET first_name = 'Carlos', middle_name = 'Jhordany', last_name = 'Medrano', aliases = ARRAY['Joa','Joa el Abuelo']::text[], primary_role = 'rapper', occupations = '["producer","lyricist","composer"]'::jsonb WHERE slug = 'joa-el-super-mc';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Joa el Super MC —Carlos Jhordany Medrano, born on 15 December 1983 in the San Carlos district of Santo Domingo— is a Dominican rapper and producer, also known as Joa el Abuelo, and a member of the first generation of Dominican hip hop."}]},{"type":"paragraph","content":[{"type":"text","text":"Beginnings","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"According to the biography kept on Last.fm, he became fascinated by hip hop as a child through videos and cassettes that a friend brought from the United States. At sixteen he moved to the Zona Oriental, where at the Liceo Experimental of the Universidad Autónoma de Santo Domingo he met the rappers Aalkuadrado and Ka-mc, with whom he formed his first group, C1-03."}]},{"type":"paragraph","content":[{"type":"text","text":"Charles Family","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2003 he joined the Charles Family, together with "},{"type":"artistReference","attrs":{"occurrenceId":"efebcd2f-9840-4f34-9d7e-6bdc63589228","artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente"}},{"type":"text","text":", 3ni Blaze, Enigma and DJ Strike One. The group recorded «Redada Remix» in 2004, which produced the street hit «Calle es calle», sung with Lápiz Conciente and produced by Joa, and in 2006 «7 golpes», from which came «El Super MC», recorded and produced by Joa with DJ Strike One on the turntables, the song that gave him his name. In 2007 he began a solo career with «El Filmao», followed by «Tan Equivocao», and was invited to contribute to the soundtrack of the Dominican film «Juniol», directed by Alfonso Rodríguez."}]},{"type":"paragraph","content":[{"type":"text","text":"Albums","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His discography includes «Greatest Hits» (2013), «Ejercicios Vocales» (a mixtape in 2012 and an album on the platforms in 2016), «Demasiado Mucho Rap» (2017) and «Muy Under» (2024), whose title song has Lápiz Conciente as a guest. In 2025 he released «TOLA», and in 2026 the singles «Rayitos de sol», «Mi reina» and «Mi tiempo», tagged as «Ejercicios Vocales 2», and he took part in a track by Lápiz Conciente and "},{"type":"artistReference","attrs":{"occurrenceId":"1388f9af-39cd-4d5c-8f7a-b1c717db804e","artistId":"66512533-3c96-45f0-b248-d0d5e0e586d7","displayText":"Nico Clínico"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His profile on X describes him as a pioneer of Dominican urban music, and in 2026 he wrote on his social networks that he had completed twenty years of career."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'joa-el-super-mc'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'joa-el-super-mc' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'efebcd2f-9840-4f34-9d7e-6bdc63589228', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'joa-el-super-mc' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '1388f9af-39cd-4d5c-8f7a-b1c717db804e', 'artist', '66512533-3c96-45f0-b248-d0d5e0e586d7' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'joa-el-super-mc' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Joa el Super MC —Carlos Jhordany Medrano, born on 15 December 1983 in the San Carlos district of Santo Domingo— is a Dominican rapper and producer, also known as Joa el Abuelo, and a member of the first generation of Dominican hip hop.

**Beginnings**

According to the biography kept on Last.fm, he became fascinated by hip hop as a child through videos and cassettes that a friend brought from the United States. At sixteen he moved to the Zona Oriental, where at the Liceo Experimental of the Universidad Autónoma de Santo Domingo he met the rappers Aalkuadrado and Ka-mc, with whom he formed his first group, C1-03.

**Charles Family**

In 2003 he joined the Charles Family, together with Lápiz Conciente, 3ni Blaze, Enigma and DJ Strike One. The group recorded «Redada Remix» in 2004, which produced the street hit «Calle es calle», sung with Lápiz Conciente and produced by Joa, and in 2006 «7 golpes», from which came «El Super MC», recorded and produced by Joa with DJ Strike One on the turntables, the song that gave him his name. In 2007 he began a solo career with «El Filmao», followed by «Tan Equivocao», and was invited to contribute to the soundtrack of the Dominican film «Juniol», directed by Alfonso Rodríguez.

**Albums**

His discography includes «Greatest Hits» (2013), «Ejercicios Vocales» (a mixtape in 2012 and an album on the platforms in 2016), «Demasiado Mucho Rap» (2017) and «Muy Under» (2024), whose title song has Lápiz Conciente as a guest. In 2025 he released «TOLA», and in 2026 the singles «Rayitos de sol», «Mi reina» and «Mi tiempo», tagged as «Ejercicios Vocales 2», and he took part in a track by Lápiz Conciente and Nico Clínico.

**Legacy**

His profile on X describes him as a pioneer of Dominican urban music, and in 2026 he wrote on his social networks that he had completed twenty years of career.' WHERE slug = 'joa-el-super-mc';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Joa el Super MC —Carlos Jhordany Medrano, nacido el 15 de diciembre de 1983 en el sector San Carlos de Santo Domingo— es un rapero y productor dominicano, también conocido como Joa el Abuelo, y miembro de la primera generación del hip hop dominicano."}]},{"type":"paragraph","content":[{"type":"text","text":"Inicios","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Según la biografía que recoge Last.fm, se fascinó con el hip hop de niño por unos videos y casetes que un amigo trajo de Estados Unidos. A los dieciséis años se mudó a la Zona Oriental, donde en el Liceo Experimental de la Universidad Autónoma de Santo Domingo conoció a los raperos Aalkuadrado y Ka-mc, con quienes formó su primer grupo, C1-03."}]},{"type":"paragraph","content":[{"type":"text","text":"Charles Family","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2003 entró en la Charles Family, junto a "},{"type":"artistReference","attrs":{"occurrenceId":"c2206814-5a63-42e3-a7d4-2f838f7e10b5","artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente"}},{"type":"text","text":", 3ni Blaze, Enigma y DJ Strike One. El grupo grabó «Redada Remix» en 2004, del que salió el éxito callejero «Calle es calle», cantado con Lápiz Conciente y producido por Joa, y en 2006 «7 golpes», de donde salió «El Super MC», interpretada y producida por Joa con DJ Strike One en los platos, la canción que le dio su nombre. En 2007 inició su carrera como solista con «El Filmao», seguida de «Tan Equivocao», y fue invitado a participar en la banda sonora de la película dominicana «Juniol», dirigida por Alfonso Rodríguez."}]},{"type":"paragraph","content":[{"type":"text","text":"Discos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su discografía incluye «Greatest Hits» (2013), «Ejercicios Vocales» (mixtape en 2012 y álbum en las plataformas en 2016), «Demasiado Mucho Rap» (2017) y «Muy Under» (2024), cuyo tema homónimo tiene como invitado a Lápiz Conciente. En 2025 publicó «TOLA», y en 2026 los sencillos «Rayitos de sol», «Mi reina» y «Mi tiempo», etiquetado como «Ejercicios Vocales 2», y participó en un tema de Lápiz Conciente y "},{"type":"artistReference","attrs":{"occurrenceId":"996d4271-6b37-4568-91b8-6ce2bf818808","artistId":"66512533-3c96-45f0-b248-d0d5e0e586d7","displayText":"Nico Clínico"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su perfil en X lo describe como pionero de la música urbana dominicana, y en 2026 escribió en sus redes que había cumplido veinte años de carrera."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'joa-el-super-mc'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'joa-el-super-mc' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c2206814-5a63-42e3-a7d4-2f838f7e10b5', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'joa-el-super-mc' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '996d4271-6b37-4568-91b8-6ce2bf818808', 'artist', '66512533-3c96-45f0-b248-d0d5e0e586d7' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'joa-el-super-mc' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Joa el Super MC —Carlos Jhordany Medrano, nacido el 15 de diciembre de 1983 en el sector San Carlos de Santo Domingo— es un rapero y productor dominicano, también conocido como Joa el Abuelo, y miembro de la primera generación del hip hop dominicano.

**Inicios**

Según la biografía que recoge Last.fm, se fascinó con el hip hop de niño por unos videos y casetes que un amigo trajo de Estados Unidos. A los dieciséis años se mudó a la Zona Oriental, donde en el Liceo Experimental de la Universidad Autónoma de Santo Domingo conoció a los raperos Aalkuadrado y Ka-mc, con quienes formó su primer grupo, C1-03.

**Charles Family**

En 2003 entró en la Charles Family, junto a Lápiz Conciente, 3ni Blaze, Enigma y DJ Strike One. El grupo grabó «Redada Remix» en 2004, del que salió el éxito callejero «Calle es calle», cantado con Lápiz Conciente y producido por Joa, y en 2006 «7 golpes», de donde salió «El Super MC», interpretada y producida por Joa con DJ Strike One en los platos, la canción que le dio su nombre. En 2007 inició su carrera como solista con «El Filmao», seguida de «Tan Equivocao», y fue invitado a participar en la banda sonora de la película dominicana «Juniol», dirigida por Alfonso Rodríguez.

**Discos**

Su discografía incluye «Greatest Hits» (2013), «Ejercicios Vocales» (mixtape en 2012 y álbum en las plataformas en 2016), «Demasiado Mucho Rap» (2017) y «Muy Under» (2024), cuyo tema homónimo tiene como invitado a Lápiz Conciente. En 2025 publicó «TOLA», y en 2026 los sencillos «Rayitos de sol», «Mi reina» y «Mi tiempo», etiquetado como «Ejercicios Vocales 2», y participó en un tema de Lápiz Conciente y Nico Clínico.

**Legado**

Su perfil en X lo describe como pionero de la música urbana dominicana, y en 2026 escribió en sus redes que había cumplido veinte años de carrera.' WHERE slug = 'joa-el-super-mc';

COMMIT;
