BEGIN;

-- Ficha de Messiah. Sin cambios de campos: nombre legal, fecha y lugar de
-- nacimiento coinciden con Wikipedia (es, en), Deezer y BuenaMusica. AllMusic da
-- 1990 en la biografía y 1991 en la ficha lateral.
--
-- Fuera por fuente única: tres conciertos en el Madison Square Garden y una gira
-- de 16 fechas agotadas (El Especialito), el consejo de 50 Cent (Revolt), la
-- entrevista en HOT 97, el parentesco con Fernando Valerio (Wikipedia es).
-- «Las vocales» número uno en Billboard (El Especialito): no se usa.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Messiah — Benito Emmanuel García, born in Santiago de los Caballeros on 8 June 1990 and raised in Harlem, New York — is a Dominican rapper, singer and songwriter, and one of the pioneers of Latin trap. He was among the first to join reggaeton and trap and to rap as easily in Spanish as in English, laying down a model for the boom the genre went through in the mid-2010s."}]},{"type":"paragraph","content":[{"type":"text","text":"Harlem","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His family took him to New York when he was two. He grew up between the hip-hop of the streets of Upper Manhattan and the romantic Latin music his parents played at home, and he wrote his first song at eleven. As a teenager he made his name in freestyle battles."}]},{"type":"paragraph","content":[{"type":"text","text":"Tali & Messiah","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His first project was a reggaeton duo with "},{"type":"artistReference","attrs":{"occurrenceId":"af0db811-16cc-47cb-b173-b613fd70db28","artistId":"47d07f5d-de56-4ad2-abc3-3e33221805dd","displayText":"Tali Goya"}},{"type":"text","text":", started when both were young teenagers. «Tali & Messiah» released an EP on the label «La Reina Records», and «Mi dimensión» went into rotation on «Mun2», «MTV Tr3s» and «Music Choice». In 2010 the two went their separate ways."}]},{"type":"paragraph","content":[{"type":"text","text":"The remix king","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"On his own, Messiah first spread his music by handing it out in clubs and hair salons, and then by the internet, where his Spanish-language versions of songs by Drake, Future and later Cardi B earned him the nickname of king of the Latin remixes. His «Tu protagonista» grew into a remix with Nicky Jam, J Balvin and Zion & Lennox, and over the following years he recorded with Farruko, Bad Bunny, Daddy Yankee and Ozuna, as well as with Dominican artists such as "},{"type":"artistReference","attrs":{"occurrenceId":"3f9494b2-d285-47cd-90d7-4d5aefa9dc54","artistId":"cadebd75-4af4-4519-9599-6ec606694a36","displayText":"Shelow Shaq"}},{"type":"text","text":", on «Soy de la calle», and "},{"type":"artistReference","attrs":{"occurrenceId":"f6e74ce6-67cf-4cd7-82b6-99523cd5d539","artistId":"b22dbf04-c87b-4842-baac-0616b7613208","displayText":"Jhoni The Voice"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Albums and campaigns","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His first album, «Made in Europe», made with DJ 40, came out digitally in July 2016, and that year he was the voice of national advertising campaigns for Gatorade and Sean John. He became the first Latin rapper from New York to fill the club Stage 48. When Billboard gathered the genre’s leading names in 2017 to tell the history of Latin trap, Messiah was among them, with Ozuna, Bad Bunny, De La Ghetto and Farruko. His second album, «B.E.N.I.T.O.», followed in 2018, the same year he joined the remix of Andy Mineo’s «You Can’t Stop Me». By 2025 his catalogue ran to more than eighty singles."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Messiah is one of the New York Dominicans credited with helping launch Latin trap, and his bilingual, bicultural approach — trap from the city, sung for listeners who share neither its streets nor its language — anticipated the path that the genre’s biggest stars would later follow."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'messiah'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'messiah' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'af0db811-16cc-47cb-b173-b613fd70db28', 'artist', '47d07f5d-de56-4ad2-abc3-3e33221805dd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'messiah' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3f9494b2-d285-47cd-90d7-4d5aefa9dc54', 'artist', 'cadebd75-4af4-4519-9599-6ec606694a36' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'messiah' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f6e74ce6-67cf-4cd7-82b6-99523cd5d539', 'artist', 'b22dbf04-c87b-4842-baac-0616b7613208' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'messiah' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Messiah — Benito Emmanuel García, born in Santiago de los Caballeros on 8 June 1990 and raised in Harlem, New York — is a Dominican rapper, singer and songwriter, and one of the pioneers of Latin trap. He was among the first to join reggaeton and trap and to rap as easily in Spanish as in English, laying down a model for the boom the genre went through in the mid-2010s.

**Harlem**

His family took him to New York when he was two. He grew up between the hip-hop of the streets of Upper Manhattan and the romantic Latin music his parents played at home, and he wrote his first song at eleven. As a teenager he made his name in freestyle battles.

**Tali & Messiah**

His first project was a reggaeton duo with Tali Goya, started when both were young teenagers. «Tali & Messiah» released an EP on the label «La Reina Records», and «Mi dimensión» went into rotation on «Mun2», «MTV Tr3s» and «Music Choice». In 2010 the two went their separate ways.

**The remix king**

On his own, Messiah first spread his music by handing it out in clubs and hair salons, and then by the internet, where his Spanish-language versions of songs by Drake, Future and later Cardi B earned him the nickname of king of the Latin remixes. His «Tu protagonista» grew into a remix with Nicky Jam, J Balvin and Zion & Lennox, and over the following years he recorded with Farruko, Bad Bunny, Daddy Yankee and Ozuna, as well as with Dominican artists such as Shelow Shaq, on «Soy de la calle», and Jhoni The Voice.

**Albums and campaigns**

His first album, «Made in Europe», made with DJ 40, came out digitally in July 2016, and that year he was the voice of national advertising campaigns for Gatorade and Sean John. He became the first Latin rapper from New York to fill the club Stage 48. When Billboard gathered the genre’s leading names in 2017 to tell the history of Latin trap, Messiah was among them, with Ozuna, Bad Bunny, De La Ghetto and Farruko. His second album, «B.E.N.I.T.O.», followed in 2018, the same year he joined the remix of Andy Mineo’s «You Can’t Stop Me». By 2025 his catalogue ran to more than eighty singles.

**Legacy**

Messiah is one of the New York Dominicans credited with helping launch Latin trap, and his bilingual, bicultural approach — trap from the city, sung for listeners who share neither its streets nor its language — anticipated the path that the genre’s biggest stars would later follow.' WHERE slug = 'messiah';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Messiah —Benito Emmanuel García, nacido en Santiago de los Caballeros el 8 de junio de 1990 y criado en Harlem, Nueva York— es rapero, cantante y compositor dominicano, y uno de los pioneros del trap latino. Estuvo entre los primeros en unir el reguetón con el trap y en rapear con la misma soltura en español que en inglés, un modelo para el auge que vivió el género a mediados de la década de 2010."}]},{"type":"paragraph","content":[{"type":"text","text":"Harlem","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su familia lo llevó a Nueva York cuando tenía dos años. Creció entre el hip-hop de las calles del Alto Manhattan y la música romántica latina que sus padres ponían en casa, y escribió su primera canción a los once años. De adolescente se hizo un nombre en las batallas de improvisación."}]},{"type":"paragraph","content":[{"type":"text","text":"Tali & Messiah","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su primer proyecto fue un dúo de reguetón con "},{"type":"artistReference","attrs":{"occurrenceId":"2c620f47-f550-4db7-8a16-a8a958e24ee8","artistId":"47d07f5d-de56-4ad2-abc3-3e33221805dd","displayText":"Tali Goya"}},{"type":"text","text":", formado cuando ambos eran casi niños. «Tali & Messiah» publicó un EP con el sello «La Reina Records», y «Mi dimensión» entró en rotación en «Mun2», «MTV Tr3s» y «Music Choice». En 2010 cada uno tomó su camino."}]},{"type":"paragraph","content":[{"type":"text","text":"El rey de las remezclas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Por su cuenta, Messiah empezó repartiendo su música en discotecas y salones de belleza, y después en internet, donde sus versiones en español de canciones de Drake, Future y más tarde Cardi B le ganaron el apodo de rey de las remezclas latinas. Su «Tu protagonista» terminó en una remezcla con Nicky Jam, J Balvin y Zion & Lennox, y en los años siguientes grabó con Farruko, Bad Bunny, Daddy Yankee y Ozuna, además de con artistas dominicanos como "},{"type":"artistReference","attrs":{"occurrenceId":"d7ec8ff4-ec19-4277-9252-6f8a41ea7b57","artistId":"cadebd75-4af4-4519-9599-6ec606694a36","displayText":"Shelow Shaq"}},{"type":"text","text":", en «Soy de la calle», y "},{"type":"artistReference","attrs":{"occurrenceId":"dbcf4fb9-c202-48cd-b4b9-570ffdc22f12","artistId":"b22dbf04-c87b-4842-baac-0616b7613208","displayText":"Jhoni The Voice"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Discos y campañas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su primer álbum, «Made in Europe», hecho con DJ 40, salió en formato digital en julio de 2016, y ese año fue la voz de campañas publicitarias nacionales de Gatorade y Sean John. Se convirtió en el primer rapero latino de Nueva York en llenar el club Stage 48. Cuando Billboard reunió en 2017 a los nombres principales del género para contar la historia del trap latino, Messiah estaba entre ellos, con Ozuna, Bad Bunny, De La Ghetto y Farruko. Su segundo álbum, «B.E.N.I.T.O.», llegó en 2018, el mismo año en que participó en la remezcla de «You Can’t Stop Me», de Andy Mineo. Para 2025 su catálogo pasaba de ochenta sencillos."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Messiah es uno de los dominicanos de Nueva York a los que se atribuye haber ayudado a lanzar el trap latino, y su propuesta bilingüe y bicultural —trap de la ciudad cantado para oyentes que no comparten ni sus calles ni su idioma— anticipó el camino que después seguirían las mayores estrellas del género."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'messiah'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'messiah' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2c620f47-f550-4db7-8a16-a8a958e24ee8', 'artist', '47d07f5d-de56-4ad2-abc3-3e33221805dd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'messiah' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd7ec8ff4-ec19-4277-9252-6f8a41ea7b57', 'artist', 'cadebd75-4af4-4519-9599-6ec606694a36' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'messiah' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dbcf4fb9-c202-48cd-b4b9-570ffdc22f12', 'artist', 'b22dbf04-c87b-4842-baac-0616b7613208' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'messiah' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Messiah —Benito Emmanuel García, nacido en Santiago de los Caballeros el 8 de junio de 1990 y criado en Harlem, Nueva York— es rapero, cantante y compositor dominicano, y uno de los pioneros del trap latino. Estuvo entre los primeros en unir el reguetón con el trap y en rapear con la misma soltura en español que en inglés, un modelo para el auge que vivió el género a mediados de la década de 2010.

**Harlem**

Su familia lo llevó a Nueva York cuando tenía dos años. Creció entre el hip-hop de las calles del Alto Manhattan y la música romántica latina que sus padres ponían en casa, y escribió su primera canción a los once años. De adolescente se hizo un nombre en las batallas de improvisación.

**Tali & Messiah**

Su primer proyecto fue un dúo de reguetón con Tali Goya, formado cuando ambos eran casi niños. «Tali & Messiah» publicó un EP con el sello «La Reina Records», y «Mi dimensión» entró en rotación en «Mun2», «MTV Tr3s» y «Music Choice». En 2010 cada uno tomó su camino.

**El rey de las remezclas**

Por su cuenta, Messiah empezó repartiendo su música en discotecas y salones de belleza, y después en internet, donde sus versiones en español de canciones de Drake, Future y más tarde Cardi B le ganaron el apodo de rey de las remezclas latinas. Su «Tu protagonista» terminó en una remezcla con Nicky Jam, J Balvin y Zion & Lennox, y en los años siguientes grabó con Farruko, Bad Bunny, Daddy Yankee y Ozuna, además de con artistas dominicanos como Shelow Shaq, en «Soy de la calle», y Jhoni The Voice.

**Discos y campañas**

Su primer álbum, «Made in Europe», hecho con DJ 40, salió en formato digital en julio de 2016, y ese año fue la voz de campañas publicitarias nacionales de Gatorade y Sean John. Se convirtió en el primer rapero latino de Nueva York en llenar el club Stage 48. Cuando Billboard reunió en 2017 a los nombres principales del género para contar la historia del trap latino, Messiah estaba entre ellos, con Ozuna, Bad Bunny, De La Ghetto y Farruko. Su segundo álbum, «B.E.N.I.T.O.», llegó en 2018, el mismo año en que participó en la remezcla de «You Can’t Stop Me», de Andy Mineo. Para 2025 su catálogo pasaba de ochenta sencillos.

**Legado**

Messiah es uno de los dominicanos de Nueva York a los que se atribuye haber ayudado a lanzar el trap latino, y su propuesta bilingüe y bicultural —trap de la ciudad cantado para oyentes que no comparten ni sus calles ni su idioma— anticipó el camino que después seguirían las mayores estrellas del género.' WHERE slug = 'messiah';

COMMIT;
