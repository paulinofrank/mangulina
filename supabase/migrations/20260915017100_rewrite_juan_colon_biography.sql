BEGIN;

-- Ficha de Juan Colón.
--
-- La biografía de relleno hablaba en términos genéricos de "regional musical identity" sin
-- nombrar una sola grabación, colaborador o reconocimiento.
-- primary_genre corregido de 'merengue' a 'jazz' (coincide con el tag genres=['jazz'] que
-- ya tenía la fila). occupations ampliado con "writer" y "arranger".

UPDATE artists SET primary_genre = 'jazz', occupations = '["writer","arranger"]'::jsonb, genres = ARRAY[]::text[] WHERE slug = 'juan-colon';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan José de la Esperanza Colón Rodríguez, born in Mao, Valverde province, on 18 December 1948, is a Dominican saxophonist, arranger, composer and writer regarded as one of the country’s foremost jazz musicians."}]},{"type":"paragraph","content":[{"type":"text","text":"«Con el alma de Tavito»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1998 he and the pianist and arranger "},{"type":"artistReference","attrs":{"occurrenceId":"bd5709eb-dbab-41a9-bd72-b5f30db90a3a","artistId":"4d3a653c-688e-47c1-8cec-b8cf85a4abac","displayText":"Manuel Tejada"}},{"type":"text","text":" released «Con el alma de Tavito» on Aljibe Discos, a tribute to the Dominican saxophonist Tavito Vásquez built around tracks like «Los Saxofones», «Caña Brava» and «La Maricutana». In 2013 El Caribe and Acroarte named it No. 52 on their list of the 100 essential albums of Dominican music."}]},{"type":"paragraph","content":[{"type":"text","text":"Standards and side work","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Alongside his own recordings — informal home sessions of jazz standards like «Green Dolphin Street» and «The Shadow of Your Smile» — Colón has worked across the wider Dominican popular scene, including as a saxophonist backing Johnny Ventura on «Piel Canela»."}]},{"type":"paragraph","content":[{"type":"text","text":"Honors and a return home","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The 2015 Dominican Republic Jazz Festival, at the Centro León in Santiago, opened with a tribute to Colón as one of the greatest saxophonists the Dominican Republic has produced; that same October he was named director of Bellas Artes de Santiago."}]},{"type":"paragraph","content":[{"type":"text","text":"A voice for the music","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Beyond performing, Colón has become a frequent commentator in the Dominican press, writing and speaking about what he sees as a crisis in the country’s musical identity and mourning the decline of merengue’s traditional defenders."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"From a saxophonist paying tribute to the teacher of his own generation to a cultural administrator in his home region, Juan Colón has spent decades arguing, on stage and in print, for the seriousness of Dominican music as an art form."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-colon'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-colon' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'bd5709eb-dbab-41a9-bd72-b5f30db90a3a', 'artist', '4d3a653c-688e-47c1-8cec-b8cf85a4abac' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-colon' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Juan José de la Esperanza Colón Rodríguez, born in Mao, Valverde province, on 18 December 1948, is a Dominican saxophonist, arranger, composer and writer regarded as one of the country’s foremost jazz musicians.

**«Con el alma de Tavito»**

In 1998 he and the pianist and arranger Manuel Tejada released «Con el alma de Tavito» on Aljibe Discos, a tribute to the Dominican saxophonist Tavito Vásquez built around tracks like «Los Saxofones», «Caña Brava» and «La Maricutana». In 2013 El Caribe and Acroarte named it No. 52 on their list of the 100 essential albums of Dominican music.

**Standards and side work**

Alongside his own recordings — informal home sessions of jazz standards like «Green Dolphin Street» and «The Shadow of Your Smile» — Colón has worked across the wider Dominican popular scene, including as a saxophonist backing Johnny Ventura on «Piel Canela».

**Honors and a return home**

The 2015 Dominican Republic Jazz Festival, at the Centro León in Santiago, opened with a tribute to Colón as one of the greatest saxophonists the Dominican Republic has produced; that same October he was named director of Bellas Artes de Santiago.

**A voice for the music**

Beyond performing, Colón has become a frequent commentator in the Dominican press, writing and speaking about what he sees as a crisis in the country’s musical identity and mourning the decline of merengue’s traditional defenders.

**Legacy**

From a saxophonist paying tribute to the teacher of his own generation to a cultural administrator in his home region, Juan Colón has spent decades arguing, on stage and in print, for the seriousness of Dominican music as an art form.' WHERE slug = 'juan-colon';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan José de la Esperanza Colón Rodríguez, nacido en Mao, provincia Valverde, el 18 de diciembre de 1948, es saxofonista, arreglista, compositor y escritor dominicano considerado uno de los músicos de jazz más importantes del país."}]},{"type":"paragraph","content":[{"type":"text","text":"«Con el alma de Tavito»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1998 él y el pianista y arreglista "},{"type":"artistReference","attrs":{"occurrenceId":"c42c8ea0-775a-4b82-b51f-06dc59b4cee5","artistId":"4d3a653c-688e-47c1-8cec-b8cf85a4abac","displayText":"Manuel Tejada"}},{"type":"text","text":" publicaron «Con el alma de Tavito» con el sello Aljibe Discos, un homenaje al saxofonista dominicano Tavito Vásquez construido alrededor de temas como «Los Saxofones», «Caña Brava» y «La Maricutana». En 2013 El Caribe y Acroarte lo situaron en el puesto 52 de su lista de los 100 álbumes esenciales de la música dominicana."}]},{"type":"paragraph","content":[{"type":"text","text":"Estándares y colaboraciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Además de sus propias grabaciones —sesiones informales de estándares de jazz como «Green Dolphin Street» y «The Shadow of Your Smile», grabadas en casa—, Colón ha trabajado en la escena popular dominicana más amplia, entre otras cosas como saxofonista acompañando a Johnny Ventura en «Piel Canela»."}]},{"type":"paragraph","content":[{"type":"text","text":"Reconocimiento y un regreso a casa","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El Dominican Republic Jazz Festival de 2015, en el Centro León de Santiago, abrió con un homenaje a Colón como uno de los mejores saxofonistas que ha dado la República Dominicana; ese mismo octubre fue nombrado director de Bellas Artes de Santiago."}]},{"type":"paragraph","content":[{"type":"text","text":"Una voz por la música","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Más allá de tocar, Colón se ha convertido en comentarista frecuente de la prensa dominicana, escribiendo y hablando sobre lo que considera una crisis de identidad musical en el país y lamentando el declive de los defensores tradicionales del merengue."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De saxofonista que le rindió homenaje al maestro de su propia generación a gestor cultural en su región natal, Juan Colón ha pasado décadas defendiendo, en tarima y en la prensa, la seriedad de la música dominicana como forma de arte."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-colon'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-colon' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c42c8ea0-775a-4b82-b51f-06dc59b4cee5', 'artist', '4d3a653c-688e-47c1-8cec-b8cf85a4abac' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-colon' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Juan José de la Esperanza Colón Rodríguez, nacido en Mao, provincia Valverde, el 18 de diciembre de 1948, es saxofonista, arreglista, compositor y escritor dominicano considerado uno de los músicos de jazz más importantes del país.

**«Con el alma de Tavito»**

En 1998 él y el pianista y arreglista Manuel Tejada publicaron «Con el alma de Tavito» con el sello Aljibe Discos, un homenaje al saxofonista dominicano Tavito Vásquez construido alrededor de temas como «Los Saxofones», «Caña Brava» y «La Maricutana». En 2013 El Caribe y Acroarte lo situaron en el puesto 52 de su lista de los 100 álbumes esenciales de la música dominicana.

**Estándares y colaboraciones**

Además de sus propias grabaciones —sesiones informales de estándares de jazz como «Green Dolphin Street» y «The Shadow of Your Smile», grabadas en casa—, Colón ha trabajado en la escena popular dominicana más amplia, entre otras cosas como saxofonista acompañando a Johnny Ventura en «Piel Canela».

**Reconocimiento y un regreso a casa**

El Dominican Republic Jazz Festival de 2015, en el Centro León de Santiago, abrió con un homenaje a Colón como uno de los mejores saxofonistas que ha dado la República Dominicana; ese mismo octubre fue nombrado director de Bellas Artes de Santiago.

**Una voz por la música**

Más allá de tocar, Colón se ha convertido en comentarista frecuente de la prensa dominicana, escribiendo y hablando sobre lo que considera una crisis de identidad musical en el país y lamentando el declive de los defensores tradicionales del merengue.

**Legado**

De saxofonista que le rindió homenaje al maestro de su propia generación a gestor cultural en su región natal, Juan Colón ha pasado décadas defendiendo, en tarima y en la prensa, la seriedad de la música dominicana como forma de arte.' WHERE slug = 'juan-colon';

COMMIT;
