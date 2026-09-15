BEGIN;

-- Ficha de Expresión Joven.
--
-- La biografía de relleno describía "nueva canción y trova" en términos genéricos, sin un
-- solo hecho verificable ni mención de un integrante. formation_year / birth_year 1972,
-- death_year 1975, ended = true (fila de agrupación). Manuel de Jesús, Puro Eduardo López y
-- Rafael Castro no tienen ficha: ver ARTISTAS_FALTANTES.md.

UPDATE artists SET formation_year = 1972, birth_year = 1972, death_year = 1975, ended = true WHERE slug = 'expresion-joven';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Expresión Joven was a Dominican nueva canción group, formed in Santo Domingo in 1972 under the sponsorship of the sociologist Cholo Brenes and gone by 1975, its short life spent almost entirely inside the political repression it sang against."}]},{"type":"paragraph","content":[{"type":"text","text":"A singer, a poet, and a sponsor","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Its founders included "},{"type":"artistReference","attrs":{"occurrenceId":"ae72c933-c477-46b3-9d23-5ee01d81c8a4","artistId":"2e996dea-252b-48ed-9ace-2675b031c381","displayText":"Ramón Leonardo"}},{"type":"text","text":", already an established popular singer, along with the singers Manuel de Jesús and Puro Eduardo López and the poet Chico González, whose lyrics "},{"type":"artistReference","attrs":{"occurrenceId":"e438ffd8-4e64-4a24-acb3-256a4aeabe78","artistId":"2e996dea-252b-48ed-9ace-2675b031c381","displayText":"Ramón Leonardo"}},{"type":"text","text":" set to music. Rafael Castro later replaced Leonardo in the lineup. Cholo Brenes, a sociologist rather than a musician, backed and organized the project from outside the group as it took shape."}]},{"type":"paragraph","content":[{"type":"text","text":"A year and a half on the road","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Once formed, the group spent about eighteen months touring the country under the sponsorship of neighborhood and student club associations, working through the harsh political climate of Joaquín Balaguer’s so-called doce años. It also played outside the Dominican Republic, in Canada and Puerto Rico and especially New York, where it found a ready audience in the Dominican diaspora."}]},{"type":"paragraph","content":[{"type":"text","text":"«Abre las rejas, señor gobierno»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"By mid-1973 Expresión Joven had taken up the cause of the country’s political prisoners, recording «Abre las rejas, señor gobierno» in solidarity. Its members were arrested more than once by Balaguer-era police over the following two years."}]},{"type":"paragraph","content":[{"type":"text","text":"«Siete Días con el Pueblo»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1974 Cholo Brenes and Expresión Joven took over the artistic direction of «Siete Días con el Pueblo», a festival held from 25 November to 1 December that drew major figures of the Ibero-American protest song movement. The group’s performance there of "},{"type":"artistReference","attrs":{"occurrenceId":"237950ce-a53d-4928-b419-8cacc42d79ca","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":"’s «Obrero, acepta mi mano» — already the festival’s official theme — turned it into the anthem of an event that ended in a mass public repudiation of the government of the day."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Expresión Joven left two records behind: «Dominican Republic: La Hora Está Llegando! (The Time Is Coming)», released in the United States on Paredon Records, the label built around protest song from Latin America and beyond, and «Obrero, acepta mi mano» on Karen Records, both from 1974. The group broke up the following year, after barely three years together, but it gave Dominican nueva canción its first organized, internationally distributed voice, and set "},{"type":"artistReference","attrs":{"occurrenceId":"a0e49c22-7bf2-40c7-8cad-46c08f45c74a","artistId":"2e996dea-252b-48ed-9ace-2675b031c381","displayText":"Ramón Leonardo"}},{"type":"text","text":" on the path that would later earn him the title of father of protest song in the Dominican Republic."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'expresion-joven'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'expresion-joven' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ae72c933-c477-46b3-9d23-5ee01d81c8a4', 'artist', '2e996dea-252b-48ed-9ace-2675b031c381' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'expresion-joven' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e438ffd8-4e64-4a24-acb3-256a4aeabe78', 'artist', '2e996dea-252b-48ed-9ace-2675b031c381' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'expresion-joven' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '237950ce-a53d-4928-b419-8cacc42d79ca', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'expresion-joven' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a0e49c22-7bf2-40c7-8cad-46c08f45c74a', 'artist', '2e996dea-252b-48ed-9ace-2675b031c381' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'expresion-joven' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Expresión Joven was a Dominican nueva canción group, formed in Santo Domingo in 1972 under the sponsorship of the sociologist Cholo Brenes and gone by 1975, its short life spent almost entirely inside the political repression it sang against.

**A singer, a poet, and a sponsor**

Its founders included Ramón Leonardo, already an established popular singer, along with the singers Manuel de Jesús and Puro Eduardo López and the poet Chico González, whose lyrics Ramón Leonardo set to music. Rafael Castro later replaced Leonardo in the lineup. Cholo Brenes, a sociologist rather than a musician, backed and organized the project from outside the group as it took shape.

**A year and a half on the road**

Once formed, the group spent about eighteen months touring the country under the sponsorship of neighborhood and student club associations, working through the harsh political climate of Joaquín Balaguer’s so-called doce años. It also played outside the Dominican Republic, in Canada and Puerto Rico and especially New York, where it found a ready audience in the Dominican diaspora.

**«Abre las rejas, señor gobierno»**

By mid-1973 Expresión Joven had taken up the cause of the country’s political prisoners, recording «Abre las rejas, señor gobierno» in solidarity. Its members were arrested more than once by Balaguer-era police over the following two years.

**«Siete Días con el Pueblo»**

In 1974 Cholo Brenes and Expresión Joven took over the artistic direction of «Siete Días con el Pueblo», a festival held from 25 November to 1 December that drew major figures of the Ibero-American protest song movement. The group’s performance there of Luis "Terror" Días’s «Obrero, acepta mi mano» — already the festival’s official theme — turned it into the anthem of an event that ended in a mass public repudiation of the government of the day.

**Legacy**

Expresión Joven left two records behind: «Dominican Republic: La Hora Está Llegando! (The Time Is Coming)», released in the United States on Paredon Records, the label built around protest song from Latin America and beyond, and «Obrero, acepta mi mano» on Karen Records, both from 1974. The group broke up the following year, after barely three years together, but it gave Dominican nueva canción its first organized, internationally distributed voice, and set Ramón Leonardo on the path that would later earn him the title of father of protest song in the Dominican Republic.' WHERE slug = 'expresion-joven';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Expresión Joven fue un grupo dominicano de nueva canción, formado en Santo Domingo en 1972 bajo el auspicio del sociólogo Cholo Brenes y desaparecido hacia 1975, con una vida corta transcurrida casi por completo dentro de la represión política contra la que cantaba."}]},{"type":"paragraph","content":[{"type":"text","text":"Un cantante, un poeta y un padrino","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Entre sus fundadores estuvo "},{"type":"artistReference","attrs":{"occurrenceId":"2d998333-0039-4d6a-a51e-8d5e06dbf4f1","artistId":"2e996dea-252b-48ed-9ace-2675b031c381","displayText":"Ramón Leonardo"}},{"type":"text","text":", ya entonces un cantante popular con trayectoria firme, junto a los cantantes Manuel de Jesús y Puro Eduardo López y el poeta Chico González, a cuyas letras "},{"type":"artistReference","attrs":{"occurrenceId":"5e2ebc7d-fd0c-4252-bedc-7151b0308632","artistId":"2e996dea-252b-48ed-9ace-2675b031c381","displayText":"Ramón Leonardo"}},{"type":"text","text":" les puso música. Rafael Castro sustituyó después a Leonardo en la alineación. Cholo Brenes, sociólogo y no músico, respaldó y organizó el proyecto desde fuera del grupo mientras este tomaba forma."}]},{"type":"paragraph","content":[{"type":"text","text":"Un año y medio de gira","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ya formado, el grupo pasó cerca de dieciocho meses de gira por el país bajo el auspicio de asociaciones de clubes barriales y estudiantiles, trabajando en el clima político duro de los llamados doce años de Joaquín Balaguer. También tocó fuera de República Dominicana, en Canadá y Puerto Rico y sobre todo en Nueva York, donde encontró un público dispuesto en la diáspora dominicana."}]},{"type":"paragraph","content":[{"type":"text","text":"«Abre las rejas, señor gobierno»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Hacia mediados de 1973 Expresión Joven había abrazado la causa de los presos políticos del país, grabando «Abre las rejas, señor gobierno» en solidaridad. A lo largo de los dos años siguientes sus integrantes fueron detenidos más de una vez por la policía del régimen balaguerista."}]},{"type":"paragraph","content":[{"type":"text","text":"«Siete Días con el Pueblo»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1974 Cholo Brenes y Expresión Joven asumieron la dirección artística de «Siete Días con el Pueblo», festival celebrado del 25 de noviembre al 1 de diciembre que reunió a figuras mayores de la canción protesta iberoamericana. La interpretación que el grupo hizo allí de «Obrero, acepta mi mano», de "},{"type":"artistReference","attrs":{"occurrenceId":"c0fd011a-bf0a-496b-80d4-8d34336856bd","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":" —ya tema oficial del festival— la convirtió en el himno de un evento que terminó en un repudio popular masivo contra el gobierno de turno."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Expresión Joven dejó dos discos: «Dominican Republic: La Hora Está Llegando! (The Time Is Coming)», publicado en Estados Unidos por Paredon Records, el sello dedicado a la canción protesta de América Latina y de otras partes del mundo, y «Obrero, acepta mi mano», en Karen Records, ambos de 1974. El grupo se disolvió al año siguiente, después de apenas tres años juntos, pero le dio a la nueva canción dominicana su primera voz organizada y con distribución internacional, y puso a "},{"type":"artistReference","attrs":{"occurrenceId":"18bbb153-6030-4f55-b6a6-1a54e35928cb","artistId":"2e996dea-252b-48ed-9ace-2675b031c381","displayText":"Ramón Leonardo"}},{"type":"text","text":" en el camino que después le ganaría el título de padre de la canción protesta en República Dominicana."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'expresion-joven'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'expresion-joven' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2d998333-0039-4d6a-a51e-8d5e06dbf4f1', 'artist', '2e996dea-252b-48ed-9ace-2675b031c381' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'expresion-joven' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5e2ebc7d-fd0c-4252-bedc-7151b0308632', 'artist', '2e996dea-252b-48ed-9ace-2675b031c381' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'expresion-joven' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c0fd011a-bf0a-496b-80d4-8d34336856bd', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'expresion-joven' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '18bbb153-6030-4f55-b6a6-1a54e35928cb', 'artist', '2e996dea-252b-48ed-9ace-2675b031c381' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'expresion-joven' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Expresión Joven fue un grupo dominicano de nueva canción, formado en Santo Domingo en 1972 bajo el auspicio del sociólogo Cholo Brenes y desaparecido hacia 1975, con una vida corta transcurrida casi por completo dentro de la represión política contra la que cantaba.

**Un cantante, un poeta y un padrino**

Entre sus fundadores estuvo Ramón Leonardo, ya entonces un cantante popular con trayectoria firme, junto a los cantantes Manuel de Jesús y Puro Eduardo López y el poeta Chico González, a cuyas letras Ramón Leonardo les puso música. Rafael Castro sustituyó después a Leonardo en la alineación. Cholo Brenes, sociólogo y no músico, respaldó y organizó el proyecto desde fuera del grupo mientras este tomaba forma.

**Un año y medio de gira**

Ya formado, el grupo pasó cerca de dieciocho meses de gira por el país bajo el auspicio de asociaciones de clubes barriales y estudiantiles, trabajando en el clima político duro de los llamados doce años de Joaquín Balaguer. También tocó fuera de República Dominicana, en Canadá y Puerto Rico y sobre todo en Nueva York, donde encontró un público dispuesto en la diáspora dominicana.

**«Abre las rejas, señor gobierno»**

Hacia mediados de 1973 Expresión Joven había abrazado la causa de los presos políticos del país, grabando «Abre las rejas, señor gobierno» en solidaridad. A lo largo de los dos años siguientes sus integrantes fueron detenidos más de una vez por la policía del régimen balaguerista.

**«Siete Días con el Pueblo»**

En 1974 Cholo Brenes y Expresión Joven asumieron la dirección artística de «Siete Días con el Pueblo», festival celebrado del 25 de noviembre al 1 de diciembre que reunió a figuras mayores de la canción protesta iberoamericana. La interpretación que el grupo hizo allí de «Obrero, acepta mi mano», de Luis "Terror" Días —ya tema oficial del festival— la convirtió en el himno de un evento que terminó en un repudio popular masivo contra el gobierno de turno.

**Legado**

Expresión Joven dejó dos discos: «Dominican Republic: La Hora Está Llegando! (The Time Is Coming)», publicado en Estados Unidos por Paredon Records, el sello dedicado a la canción protesta de América Latina y de otras partes del mundo, y «Obrero, acepta mi mano», en Karen Records, ambos de 1974. El grupo se disolvió al año siguiente, después de apenas tres años juntos, pero le dio a la nueva canción dominicana su primera voz organizada y con distribución internacional, y puso a Ramón Leonardo en el camino que después le ganaría el título de padre de la canción protesta en República Dominicana.' WHERE slug = 'expresion-joven';

COMMIT;
