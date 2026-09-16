BEGIN;

-- Ficha de Sandy MC.
--
-- La biografía de relleno usaba pronombres femeninos de principio a fin pese a que la fila
-- ya tenía gender='male' correcto (error de redacción del relleno, no de datos), y no
-- nombraba canción, agrupación ni hecho real: fue la mitad de Sandy & Papo, dúo pionero del
-- merenhouse neoyorquino.
-- middle_name/second_last_name añadidos (Adalberto/Rojas). primary_genre corregido de
-- "urbano" a "merengue-house". genres ampliado con rap.

UPDATE artists SET middle_name = 'Adalberto', second_last_name = 'Rojas',
       primary_genre = 'merengue-house', genres = ARRAY['rap']::text[]
       WHERE slug = 'sandy-mc';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Sandy MC —full name Sandy Adalberto Carriello Rojas, born in Santo Domingo on 14 September 1972, died in New York on 23 December 2020— was a Dominican rapper and singer, half of the pioneering merenhouse duo Sandy & Papo."}]},{"type":"paragraph","content":[{"type":"text","text":"«Boogie Down Rap» and «Sábado de Corporán»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Drawn to rap as a teenager by groups like Run-D.M.C., The Fat Boys and Public Enemy, he was part of Santo Domingo’s local rap scene in the 1980s as a member of «Boogie Down Rap», appearing on television programs including «Sábado de Corporán»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Sandy & Papo»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"After moving to New York in the early 1990s, he reunited with Luis «Papo MC» Deschamps, and the two formed Sandy & Papo following an audition for "},{"type":"artistReference","attrs":{"occurrenceId":"839aa711-3ca9-4fee-8fe1-f5515dc73fcd","artistId":"f838ab51-002f-4737-ab38-17f65beec9ab","displayText":"Proyecto Uno"}},{"type":"text","text":", a pairing arranged by Nelson Zapata and Pavel de Jesús. The duo became part of New York’s merenhouse movement, alongside "},{"type":"artistReference","attrs":{"occurrenceId":"2c7da369-e191-4286-b262-b29cbd7d88f6","artistId":"f838ab51-002f-4737-ab38-17f65beec9ab","displayText":"Proyecto Uno"}},{"type":"text","text":", Fulanito and "},{"type":"artistReference","attrs":{"occurrenceId":"721c4f5e-f5f8-42b6-b94c-6d60dc8b08b7","artistId":"1cd11a22-573a-43b4-8f54-fbd08329a4e2","displayText":"Ilegales"}},{"type":"text","text":", covering the house hit «El Mueve Mueve» — a Spanish-language version of Reel 2 Real’s «I Like to Move It» — and writing «Huelepega», the theme song for the 1999 Venezuelan film of the same name. Their song «Candela» later appeared in the 2006 animated film «Happy Feet»."}]},{"type":"paragraph","content":[{"type":"text","text":"After Papo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The duo ended when Luis Deschamps died in a car accident on 11 July 1999. Sandy continued as a solo artist, releasing the tribute album «Homenaje a Papo» in 2000, followed by «El Duro Soy Yo» (2005), which included «El Hijo de Doña Beba (Tu Mujer)» and «Pa’ Qué Me Tiras», and «Insuperable» (2010), led by the single «Tabaco y Ron». In 2017 he released «La Historia de un Dúo», revisiting the story of Sandy & Papo."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Sandy Carriello died of a heart attack in New York on 23 December 2020 and was buried at the Cementerio Cristo Salvador. In 2023 the producer Winston de Jesús released an album of previously unreleased Sandy MC recordings completed with the help of artificial intelligence tools."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'sandy-mc'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'sandy-mc' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '839aa711-3ca9-4fee-8fe1-f5515dc73fcd', 'artist', 'f838ab51-002f-4737-ab38-17f65beec9ab' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sandy-mc' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '2c7da369-e191-4286-b262-b29cbd7d88f6', 'artist', 'f838ab51-002f-4737-ab38-17f65beec9ab' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sandy-mc' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '721c4f5e-f5f8-42b6-b94c-6d60dc8b08b7', 'artist', '1cd11a22-573a-43b4-8f54-fbd08329a4e2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sandy-mc' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Sandy MC —full name Sandy Adalberto Carriello Rojas, born in Santo Domingo on 14 September 1972, died in New York on 23 December 2020— was a Dominican rapper and singer, half of the pioneering merenhouse duo Sandy & Papo.

**«Boogie Down Rap» and «Sábado de Corporán»**

Drawn to rap as a teenager by groups like Run-D.M.C., The Fat Boys and Public Enemy, he was part of Santo Domingo’s local rap scene in the 1980s as a member of «Boogie Down Rap», appearing on television programs including «Sábado de Corporán».

**«Sandy & Papo»**

After moving to New York in the early 1990s, he reunited with Luis «Papo MC» Deschamps, and the two formed Sandy & Papo following an audition for Proyecto Uno, a pairing arranged by Nelson Zapata and Pavel de Jesús. The duo became part of New York’s merenhouse movement, alongside Proyecto Uno, Fulanito and Ilegales, covering the house hit «El Mueve Mueve» — a Spanish-language version of Reel 2 Real’s «I Like to Move It» — and writing «Huelepega», the theme song for the 1999 Venezuelan film of the same name. Their song «Candela» later appeared in the 2006 animated film «Happy Feet».

**After Papo**

The duo ended when Luis Deschamps died in a car accident on 11 July 1999. Sandy continued as a solo artist, releasing the tribute album «Homenaje a Papo» in 2000, followed by «El Duro Soy Yo» (2005), which included «El Hijo de Doña Beba (Tu Mujer)» and «Pa’ Qué Me Tiras», and «Insuperable» (2010), led by the single «Tabaco y Ron». In 2017 he released «La Historia de un Dúo», revisiting the story of Sandy & Papo.

**Legacy**

Sandy Carriello died of a heart attack in New York on 23 December 2020 and was buried at the Cementerio Cristo Salvador. In 2023 the producer Winston de Jesús released an album of previously unreleased Sandy MC recordings completed with the help of artificial intelligence tools.' WHERE slug = 'sandy-mc';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Sandy MC —nombre completo Sandy Adalberto Carriello Rojas, nacido en Santo Domingo el 14 de septiembre de 1972, fallecido en Nueva York el 23 de diciembre de 2020— fue rapero y cantante dominicano, mitad del dúo pionero del merenhouse Sandy & Papo."}]},{"type":"paragraph","content":[{"type":"text","text":"«Boogie Down Rap» y «Sábado de Corporán»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Atraído por el rap desde adolescente por grupos como Run-D.M.C., The Fat Boys y Public Enemy, formó parte de la escena local de rap de Santo Domingo en los años ochenta como integrante de «Boogie Down Rap», presentándose en programas de televisión como «Sábado de Corporán»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Sandy & Papo»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Tras mudarse a Nueva York a inicios de los noventa, se reencontró con Luis «Papo MC» Deschamps, y ambos formaron Sandy & Papo después de una audición para "},{"type":"artistReference","attrs":{"occurrenceId":"e136e8be-9722-4bc7-ad6c-0c4f5bc63b2d","artistId":"f838ab51-002f-4737-ab38-17f65beec9ab","displayText":"Proyecto Uno"}},{"type":"text","text":", encuentro organizado por Nelson Zapata y Pavel de Jesús. El dúo pasó a formar parte del movimiento merenhouse neoyorquino, junto a "},{"type":"artistReference","attrs":{"occurrenceId":"a9064437-57f2-4e92-8f4e-ac0218a9c964","artistId":"f838ab51-002f-4737-ab38-17f65beec9ab","displayText":"Proyecto Uno"}},{"type":"text","text":", Fulanito e "},{"type":"artistReference","attrs":{"occurrenceId":"d2862579-2ce0-4ea9-8c41-c43bc779deaf","artistId":"1cd11a22-573a-43b4-8f54-fbd08329a4e2","displayText":"Ilegales"}},{"type":"text","text":", versionando el éxito house «El Mueve Mueve» —adaptación en español de «I Like to Move It», de Reel 2 Real— y escribiendo «Huelepega», tema de la película venezolana homónima de 1999. Su canción «Candela» apareció más tarde en la película animada «Happy Feet» (2006)."}]},{"type":"paragraph","content":[{"type":"text","text":"Después de Papo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El dúo terminó cuando Luis Deschamps murió en un accidente automovilístico el 11 de julio de 1999. Sandy continuó como solista, publicando el álbum homenaje «Homenaje a Papo» en 2000, seguido de «El Duro Soy Yo» (2005), que incluyó «El Hijo de Doña Beba (Tu Mujer)» y «Pa’ Qué Me Tiras», e «Insuperable» (2010), encabezado por el sencillo «Tabaco y Ron». En 2017 publicó «La Historia de un Dúo», que revisitaba la historia de Sandy & Papo."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Sandy Carriello murió de un infarto en Nueva York el 23 de diciembre de 2020 y fue sepultado en el Cementerio Cristo Salvador. En 2023 el productor Winston de Jesús publicó un álbum de grabaciones inéditas de Sandy MC completadas con la ayuda de herramientas de inteligencia artificial."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'sandy-mc'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'sandy-mc' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'e136e8be-9722-4bc7-ad6c-0c4f5bc63b2d', 'artist', 'f838ab51-002f-4737-ab38-17f65beec9ab' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sandy-mc' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'a9064437-57f2-4e92-8f4e-ac0218a9c964', 'artist', 'f838ab51-002f-4737-ab38-17f65beec9ab' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sandy-mc' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd2862579-2ce0-4ea9-8c41-c43bc779deaf', 'artist', '1cd11a22-573a-43b4-8f54-fbd08329a4e2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'sandy-mc' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Sandy MC —nombre completo Sandy Adalberto Carriello Rojas, nacido en Santo Domingo el 14 de septiembre de 1972, fallecido en Nueva York el 23 de diciembre de 2020— fue rapero y cantante dominicano, mitad del dúo pionero del merenhouse Sandy & Papo.

**«Boogie Down Rap» y «Sábado de Corporán»**

Atraído por el rap desde adolescente por grupos como Run-D.M.C., The Fat Boys y Public Enemy, formó parte de la escena local de rap de Santo Domingo en los años ochenta como integrante de «Boogie Down Rap», presentándose en programas de televisión como «Sábado de Corporán».

**«Sandy & Papo»**

Tras mudarse a Nueva York a inicios de los noventa, se reencontró con Luis «Papo MC» Deschamps, y ambos formaron Sandy & Papo después de una audición para Proyecto Uno, encuentro organizado por Nelson Zapata y Pavel de Jesús. El dúo pasó a formar parte del movimiento merenhouse neoyorquino, junto a Proyecto Uno, Fulanito e Ilegales, versionando el éxito house «El Mueve Mueve» —adaptación en español de «I Like to Move It», de Reel 2 Real— y escribiendo «Huelepega», tema de la película venezolana homónima de 1999. Su canción «Candela» apareció más tarde en la película animada «Happy Feet» (2006).

**Después de Papo**

El dúo terminó cuando Luis Deschamps murió en un accidente automovilístico el 11 de julio de 1999. Sandy continuó como solista, publicando el álbum homenaje «Homenaje a Papo» en 2000, seguido de «El Duro Soy Yo» (2005), que incluyó «El Hijo de Doña Beba (Tu Mujer)» y «Pa’ Qué Me Tiras», e «Insuperable» (2010), encabezado por el sencillo «Tabaco y Ron». En 2017 publicó «La Historia de un Dúo», que revisitaba la historia de Sandy & Papo.

**Legado**

Sandy Carriello murió de un infarto en Nueva York el 23 de diciembre de 2020 y fue sepultado en el Cementerio Cristo Salvador. En 2023 el productor Winston de Jesús publicó un álbum de grabaciones inéditas de Sandy MC completadas con la ayuda de herramientas de inteligencia artificial.' WHERE slug = 'sandy-mc';

COMMIT;
