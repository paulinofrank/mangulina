BEGIN;

-- Ficha de Amenazzy.
--
-- La biografía de relleno inventaba un nombre de nacimiento (Josué Manuel Peña) que ni
-- siquiera coincidía con la fila (José Daniel Betances). Se ignora el infobox vandalizado de
-- Wikipedia (es), que le atribuye otra identidad; se usa solo la prosa del artículo,
-- consistente con el resto de fuentes. Premio: Premios Juventud 2019, Nueva Generación
-- Urbana.

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Nueva Generación Urbana' FROM awards a WHERE a.name = 'Premios Juventud'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Nueva Generación Urbana');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2019, NULL, true, 'El Nuevo Diario (19 jul 2019); Wikipedia (es/en)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'amenazzy' AND a.name = 'Premios Juventud' AND cat.name = 'Nueva Generación Urbana'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2019);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Amenazzy — José Daniel Betances Espinal, born in Santiago de los Caballeros on 4 August 1995 — is a Dominican singer and songwriter working across reggaeton, trap and R&B, one of the first urbano artists of his generation to build his name on melody rather than aggression."}]},{"type":"paragraph","content":[{"type":"text","text":"El Nene","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"At eleven he quit the baseball team he had travelled to Mexico with, telling People en Español years later that he simply did not like being out in the sun. That same year he started freestyling in tiraderas on the streets of Santiago, the smallest of the group in age and size — which is where El Nene came from. As his lyrics sharpened he was calling himself Amenazza, «the threat», until his mentor Alex Gárgolas suggested the softer Amenazzy, better suited to reaching urbano’s women listeners."}]},{"type":"paragraph","content":[{"type":"text","text":"From «La Chanty» to «Baby»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He first appeared on a 2013 single by the production duo Los Mellos on the Track, and «Después del party», also with Los Mellos, went viral and opened the industry’s doors to him. His own breakthrough came with «La Chanty» (2015), the title track of his self-titled album the following year; the song was remixed with Arcángel in 2016. Gárgolas, who also produced his collaboration with Don Omar, «Desierto», brought him into a run of features with Bryant Myers, Lary Over, Arcángel, Farruko and "},{"type":"artistReference","attrs":{"occurrenceId":"8f061752-7cab-4736-9b48-722163789fad","artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa"}},{"type":"text","text":", among them «Sin maquillaje» with "},{"type":"artistReference","attrs":{"occurrenceId":"d0ca7629-d86c-473f-bad6-96ffe44165a5","artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo"}},{"type":"text","text":" and, later, «Como Ali» with "},{"type":"artistReference","attrs":{"occurrenceId":"9b647c28-524d-455a-a46e-75949a8edeaa","artistId":"b8699416-10d2-4c84-a43a-2a035387126f","displayText":"Eklectico"}},{"type":"text","text":". His 2020 single «Baby», with Nicky Jam and Farruko, has passed 300 million views on YouTube."}]},{"type":"paragraph","content":[{"type":"text","text":"From La Plaza to Madison Square Garden","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In April 2018 he opened for Bad Bunny at Madison Square Garden, a year after the two had recorded «Lean» together, and that November he headlined the 9,000-seat Arena del Cibao in his native Santiago — a homecoming he called, in the days before it, a source of pride for the city and everyone who had worked with him — before performing at the 72,000-seat Estadio Olímpico Félix Sánchez alongside Daddy Yankee a few days later. «Solo», with Lary Over, and «Baby» went on to RIAA Platinum certifications, and in 2019 he won Nueva Generación Urbana at the Premios Juventud."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Amenazzy has said he has no five-year plan and wants whatever happens next to surprise even him. Signed to Rimas Entertainment, he released his debut studio album, «Santo Niño», in 2021 and «Triple Equis» in 2023, carrying the loverboy strand of Dominican urbano that he helped define from the tiraderas of Santiago onto some of Latin music’s largest stages."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'amenazzy'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'amenazzy' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '8f061752-7cab-4736-9b48-722163789fad', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'amenazzy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd0ca7629-d86c-473f-bad6-96ffe44165a5', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'amenazzy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9b647c28-524d-455a-a46e-75949a8edeaa', 'artist', 'b8699416-10d2-4c84-a43a-2a035387126f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'amenazzy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Amenazzy — José Daniel Betances Espinal, born in Santiago de los Caballeros on 4 August 1995 — is a Dominican singer and songwriter working across reggaeton, trap and R&B, one of the first urbano artists of his generation to build his name on melody rather than aggression.

**El Nene**

At eleven he quit the baseball team he had travelled to Mexico with, telling People en Español years later that he simply did not like being out in the sun. That same year he started freestyling in tiraderas on the streets of Santiago, the smallest of the group in age and size — which is where El Nene came from. As his lyrics sharpened he was calling himself Amenazza, «the threat», until his mentor Alex Gárgolas suggested the softer Amenazzy, better suited to reaching urbano’s women listeners.

**From «La Chanty» to «Baby»**

He first appeared on a 2013 single by the production duo Los Mellos on the Track, and «Después del party», also with Los Mellos, went viral and opened the industry’s doors to him. His own breakthrough came with «La Chanty» (2015), the title track of his self-titled album the following year; the song was remixed with Arcángel in 2016. Gárgolas, who also produced his collaboration with Don Omar, «Desierto», brought him into a run of features with Bryant Myers, Lary Over, Arcángel, Farruko and El Alfa, among them «Sin maquillaje» with Don Miguelo and, later, «Como Ali» with Eklectico. His 2020 single «Baby», with Nicky Jam and Farruko, has passed 300 million views on YouTube.

**From La Plaza to Madison Square Garden**

In April 2018 he opened for Bad Bunny at Madison Square Garden, a year after the two had recorded «Lean» together, and that November he headlined the 9,000-seat Arena del Cibao in his native Santiago — a homecoming he called, in the days before it, a source of pride for the city and everyone who had worked with him — before performing at the 72,000-seat Estadio Olímpico Félix Sánchez alongside Daddy Yankee a few days later. «Solo», with Lary Over, and «Baby» went on to RIAA Platinum certifications, and in 2019 he won Nueva Generación Urbana at the Premios Juventud.

**Legacy**

Amenazzy has said he has no five-year plan and wants whatever happens next to surprise even him. Signed to Rimas Entertainment, he released his debut studio album, «Santo Niño», in 2021 and «Triple Equis» in 2023, carrying the loverboy strand of Dominican urbano that he helped define from the tiraderas of Santiago onto some of Latin music’s largest stages.' WHERE slug = 'amenazzy';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Amenazzy —José Daniel Betances Espinal, nacido en Santiago de los Caballeros el 4 de agosto de 1995— es un cantante y compositor dominicano que trabaja entre el reguetón, el trap y el R&B, uno de los primeros artistas urbanos de su generación en construir su nombre sobre la melodía y no sobre la agresividad."}]},{"type":"paragraph","content":[{"type":"text","text":"El Nene","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A los once años dejó el equipo de béisbol con el que había viajado a México, y años después le confesó a People en Español que sencillamente no le gustaba estar al sol. Ese mismo año empezó a improvisar en tiraderas por las calles de Santiago, el más pequeño del grupo en edad y estatura —de ahí salió El Nene—. A medida que afiló sus letras se hacía llamar Amenazza, «la amenaza», hasta que su mentor Alex Gárgolas le sugirió el más suave Amenazzy, mejor pensado para llegar al público femenino del género urbano."}]},{"type":"paragraph","content":[{"type":"text","text":"De «La Chanty» a «Baby»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Apareció por primera vez en un sencillo de 2013 del dúo de producción Los Mellos on the Track, y «Después del party», también con ellos, se volvió viral y le abrió las puertas de la industria. Su despegue propio llegó con «La Chanty» (2015), tema que da título a su álbum homónimo del año siguiente; la canción se remezcló con Arcángel en 2016. Gárgolas, que también produjo su colaboración con Don Omar, «Desierto», lo metió en una racha de participaciones con Bryant Myers, Lary Over, Arcángel, Farruko y "},{"type":"artistReference","attrs":{"occurrenceId":"2b732465-0485-4dbb-8385-5dbf5963473a","artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa"}},{"type":"text","text":", entre ellas «Sin maquillaje» con "},{"type":"artistReference","attrs":{"occurrenceId":"e68a66c3-c2f6-4a63-80fe-7acc54233c8e","artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo"}},{"type":"text","text":" y, después, «Como Ali» con "},{"type":"artistReference","attrs":{"occurrenceId":"bd0f2999-7ceb-478a-8296-31d661ff9570","artistId":"b8699416-10d2-4c84-a43a-2a035387126f","displayText":"Eklectico"}},{"type":"text","text":". Su sencillo de 2020 «Baby», con Nicky Jam y Farruko, ha pasado los 300 millones de reproducciones en YouTube."}]},{"type":"paragraph","content":[{"type":"text","text":"De la plaza al Madison Square Garden","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En abril de 2018 abrió para Bad Bunny en el Madison Square Garden, un año después de haber grabado juntos «Lean», y ese noviembre encabezó cartel en la Arena del Cibao de su Santiago natal, con capacidad para 9.000 personas —un regreso a casa que, en los días previos, describió como un orgullo para la ciudad y para todos los que trabajaban con él—, antes de presentarse en el Estadio Olímpico Félix Sánchez, con capacidad para 72.000, junto a Daddy Yankee pocos días después. «Solo», con Lary Over, y «Baby» llegaron a la certificación Platino de la RIAA, y en 2019 ganó como Nueva Generación Urbana en los Premios Juventud."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Amenazzy ha dicho que no tiene un plan a cinco años y que quiere que lo que venga lo sorprenda incluso a él. Firmado con Rimas Entertainment, publicó su álbum debut de estudio, «Santo Niño», en 2021 y «Triple Equis» en 2023, llevando la vertiente romántica del urbano dominicano que ayudó a definir desde las tiraderas de Santiago hasta algunos de los escenarios más grandes de la música latina."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'amenazzy'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'amenazzy' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2b732465-0485-4dbb-8385-5dbf5963473a', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'amenazzy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e68a66c3-c2f6-4a63-80fe-7acc54233c8e', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'amenazzy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'bd0f2999-7ceb-478a-8296-31d661ff9570', 'artist', 'b8699416-10d2-4c84-a43a-2a035387126f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'amenazzy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Amenazzy —José Daniel Betances Espinal, nacido en Santiago de los Caballeros el 4 de agosto de 1995— es un cantante y compositor dominicano que trabaja entre el reguetón, el trap y el R&B, uno de los primeros artistas urbanos de su generación en construir su nombre sobre la melodía y no sobre la agresividad.

**El Nene**

A los once años dejó el equipo de béisbol con el que había viajado a México, y años después le confesó a People en Español que sencillamente no le gustaba estar al sol. Ese mismo año empezó a improvisar en tiraderas por las calles de Santiago, el más pequeño del grupo en edad y estatura —de ahí salió El Nene—. A medida que afiló sus letras se hacía llamar Amenazza, «la amenaza», hasta que su mentor Alex Gárgolas le sugirió el más suave Amenazzy, mejor pensado para llegar al público femenino del género urbano.

**De «La Chanty» a «Baby»**

Apareció por primera vez en un sencillo de 2013 del dúo de producción Los Mellos on the Track, y «Después del party», también con ellos, se volvió viral y le abrió las puertas de la industria. Su despegue propio llegó con «La Chanty» (2015), tema que da título a su álbum homónimo del año siguiente; la canción se remezcló con Arcángel en 2016. Gárgolas, que también produjo su colaboración con Don Omar, «Desierto», lo metió en una racha de participaciones con Bryant Myers, Lary Over, Arcángel, Farruko y El Alfa, entre ellas «Sin maquillaje» con Don Miguelo y, después, «Como Ali» con Eklectico. Su sencillo de 2020 «Baby», con Nicky Jam y Farruko, ha pasado los 300 millones de reproducciones en YouTube.

**De la plaza al Madison Square Garden**

En abril de 2018 abrió para Bad Bunny en el Madison Square Garden, un año después de haber grabado juntos «Lean», y ese noviembre encabezó cartel en la Arena del Cibao de su Santiago natal, con capacidad para 9.000 personas —un regreso a casa que, en los días previos, describió como un orgullo para la ciudad y para todos los que trabajaban con él—, antes de presentarse en el Estadio Olímpico Félix Sánchez, con capacidad para 72.000, junto a Daddy Yankee pocos días después. «Solo», con Lary Over, y «Baby» llegaron a la certificación Platino de la RIAA, y en 2019 ganó como Nueva Generación Urbana en los Premios Juventud.

**Legado**

Amenazzy ha dicho que no tiene un plan a cinco años y que quiere que lo que venga lo sorprenda incluso a él. Firmado con Rimas Entertainment, publicó su álbum debut de estudio, «Santo Niño», en 2021 y «Triple Equis» en 2023, llevando la vertiente romántica del urbano dominicano que ayudó a definir desde las tiraderas de Santiago hasta algunos de los escenarios más grandes de la música latina.' WHERE slug = 'amenazzy';

COMMIT;
