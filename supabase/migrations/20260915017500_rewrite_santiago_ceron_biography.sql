BEGIN;

-- Ficha de Santiago Cerón.
--
-- La biografía de relleno hablaba en términos genéricos de su formación en el Cibao sin
-- nombrar una sola canción, colaborador u orquesta.
-- birth_place/province corregidos de Santiago de los Caballeros/Santiago a Santo
-- Domingo/Distrito Nacional -aparente confusión entre su nombre de pila y la ciudad
-- homónima-. primary_genre corregido de merengue a salsa (toda fuente lo llama "sonero");
-- genres ampliado con merengue. occupations ampliado con songwriter; instruments con
-- voice y guiro.

UPDATE artists SET birth_place = 'Santo Domingo', province = 'Distrito Nacional',
       primary_genre = 'salsa', genres = ARRAY['merengue']::text[], occupations = '["songwriter"]'::jsonb,
       instruments = ARRAY['voice','guiro']::text[] WHERE slug = 'santiago-ceron';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Santiago Cerón, born in Santo Domingo on 25 July 1940 and died in New York on 10 May 2011, was a Dominican sonero and songwriter, one of the first Dominican singers to build a lasting career inside New York’s Latin music scene."}]},{"type":"paragraph","content":[{"type":"text","text":"From La Voz Dominicana to Arsenio Rodríguez","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began as an amateur singer on the state station La Voz Dominicana and trained as a lyric tenor at the Escuela de Bellas Artes before emigrating to New York at twenty-two. There he met the legendary Arsenio Rodríguez, who introduced him to Cuban vocal style; the two recorded three albums together between 1964 and 1966."}]},{"type":"paragraph","content":[{"type":"text","text":"Merengue and salsa in New York","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cerón sang merengue in "},{"type":"artistReference","attrs":{"occurrenceId":"6cec09b7-a877-4e71-8e88-8c986fcbd879","artistId":"dab6636c-21fd-4e34-a0a2-e59e9e147bbd","displayText":"Luis Kalaff"}},{"type":"text","text":"’s orchestra, Los Alegres Dominicanos, and worked with Pete Rodríguez and Tony Pabón’s La Protesta before becoming vocalist and güiro player for "},{"type":"artistReference","attrs":{"occurrenceId":"defba0ef-33ca-4d62-983f-d4de42ee1055","artistId":"e005898c-4fcc-45da-b857-c6775e92fa52","displayText":"Johnny Pacheco"}},{"type":"text","text":"’s orchestra, where he recorded the classic «Se Me Perdió la Cartera» alongside Larry Harlow, Adalberto Santiago and Héctor Lavoe."}]},{"type":"paragraph","content":[{"type":"text","text":"A solo catalogue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He launched his own band and a solo recording career in 1980 with «Tumbando Puertas», followed the same year by «Navegando en Sabor» and «Canta si Vas a Cantar». Over three decades he recorded some thirty-two albums, with «Cruel Tormento», «Lindo Yambú», «Baja y Tapa» and «Espíritu Burlón» among his best-known songs."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cerón died of heart problems in New York in 2011. In 2018, a stretch of Sickles Street in Washington Heights, where he had lived for years, was co-named in his honor — the first street in New York City named for a Dominican singer."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'santiago-ceron'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'santiago-ceron' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6cec09b7-a877-4e71-8e88-8c986fcbd879', 'artist', 'dab6636c-21fd-4e34-a0a2-e59e9e147bbd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'santiago-ceron' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'defba0ef-33ca-4d62-983f-d4de42ee1055', 'artist', 'e005898c-4fcc-45da-b857-c6775e92fa52' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'santiago-ceron' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Santiago Cerón, born in Santo Domingo on 25 July 1940 and died in New York on 10 May 2011, was a Dominican sonero and songwriter, one of the first Dominican singers to build a lasting career inside New York’s Latin music scene.

**From La Voz Dominicana to Arsenio Rodríguez**

He began as an amateur singer on the state station La Voz Dominicana and trained as a lyric tenor at the Escuela de Bellas Artes before emigrating to New York at twenty-two. There he met the legendary Arsenio Rodríguez, who introduced him to Cuban vocal style; the two recorded three albums together between 1964 and 1966.

**Merengue and salsa in New York**

Cerón sang merengue in Luis Kalaff’s orchestra, Los Alegres Dominicanos, and worked with Pete Rodríguez and Tony Pabón’s La Protesta before becoming vocalist and güiro player for Johnny Pacheco’s orchestra, where he recorded the classic «Se Me Perdió la Cartera» alongside Larry Harlow, Adalberto Santiago and Héctor Lavoe.

**A solo catalogue**

He launched his own band and a solo recording career in 1980 with «Tumbando Puertas», followed the same year by «Navegando en Sabor» and «Canta si Vas a Cantar». Over three decades he recorded some thirty-two albums, with «Cruel Tormento», «Lindo Yambú», «Baja y Tapa» and «Espíritu Burlón» among his best-known songs.

**Legacy**

Cerón died of heart problems in New York in 2011. In 2018, a stretch of Sickles Street in Washington Heights, where he had lived for years, was co-named in his honor — the first street in New York City named for a Dominican singer.' WHERE slug = 'santiago-ceron';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Santiago Cerón, nacido en Santo Domingo el 25 de julio de 1940 y fallecido en Nueva York el 10 de mayo de 2011, fue sonero y compositor dominicano, uno de los primeros cantantes dominicanos en construir una carrera duradera dentro de la escena de música latina de Nueva York."}]},{"type":"paragraph","content":[{"type":"text","text":"De La Voz Dominicana a Arsenio Rodríguez","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Comenzó como cantante aficionado en la emisora estatal La Voz Dominicana y se formó como tenor lírico en la Escuela de Bellas Artes, antes de emigrar a Nueva York a los veintidós años. Allí conoció al legendario Arsenio Rodríguez, quien lo inició en la interpretación vocal cubana; juntos grabaron tres producciones entre 1964 y 1966."}]},{"type":"paragraph","content":[{"type":"text","text":"Merengue y salsa en Nueva York","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cerón cantó merengue en la orquesta de "},{"type":"artistReference","attrs":{"occurrenceId":"4846d2bd-1fa9-4105-97b7-c182e9246fa7","artistId":"dab6636c-21fd-4e34-a0a2-e59e9e147bbd","displayText":"Luis Kalaff"}},{"type":"text","text":", Los Alegres Dominicanos, y trabajó con Pete Rodríguez y con La Protesta de Tony Pabón, antes de convertirse en cantante y tocador de güiro de la orquesta de "},{"type":"artistReference","attrs":{"occurrenceId":"b3669efd-9959-49d6-a471-35b291ad3711","artistId":"e005898c-4fcc-45da-b857-c6775e92fa52","displayText":"Johnny Pacheco"}},{"type":"text","text":", con la que grabó el clásico «Se Me Perdió la Cartera» junto a Larry Harlow, Adalberto Santiago y Héctor Lavoe."}]},{"type":"paragraph","content":[{"type":"text","text":"Un catálogo propio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1980 formó su propia orquesta e inició su carrera como solista con «Tumbando Puertas», seguida ese mismo año de «Navegando en Sabor» y «Canta si Vas a Cantar». A lo largo de tres décadas grabó unas treinta y dos producciones, entre las que «Cruel Tormento», «Lindo Yambú», «Baja y Tapa» y «Espíritu Burlón» están entre sus temas más conocidos."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cerón murió de problemas cardíacos en Nueva York en 2011. En 2018, un tramo de la calle Sickles en Washington Heights, donde había vivido durante años, fue renombrado en su honor: la primera calle de la ciudad de Nueva York con el nombre de un cantante dominicano."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'santiago-ceron'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'santiago-ceron' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4846d2bd-1fa9-4105-97b7-c182e9246fa7', 'artist', 'dab6636c-21fd-4e34-a0a2-e59e9e147bbd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'santiago-ceron' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b3669efd-9959-49d6-a471-35b291ad3711', 'artist', 'e005898c-4fcc-45da-b857-c6775e92fa52' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'santiago-ceron' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Santiago Cerón, nacido en Santo Domingo el 25 de julio de 1940 y fallecido en Nueva York el 10 de mayo de 2011, fue sonero y compositor dominicano, uno de los primeros cantantes dominicanos en construir una carrera duradera dentro de la escena de música latina de Nueva York.

**De La Voz Dominicana a Arsenio Rodríguez**

Comenzó como cantante aficionado en la emisora estatal La Voz Dominicana y se formó como tenor lírico en la Escuela de Bellas Artes, antes de emigrar a Nueva York a los veintidós años. Allí conoció al legendario Arsenio Rodríguez, quien lo inició en la interpretación vocal cubana; juntos grabaron tres producciones entre 1964 y 1966.

**Merengue y salsa en Nueva York**

Cerón cantó merengue en la orquesta de Luis Kalaff, Los Alegres Dominicanos, y trabajó con Pete Rodríguez y con La Protesta de Tony Pabón, antes de convertirse en cantante y tocador de güiro de la orquesta de Johnny Pacheco, con la que grabó el clásico «Se Me Perdió la Cartera» junto a Larry Harlow, Adalberto Santiago y Héctor Lavoe.

**Un catálogo propio**

En 1980 formó su propia orquesta e inició su carrera como solista con «Tumbando Puertas», seguida ese mismo año de «Navegando en Sabor» y «Canta si Vas a Cantar». A lo largo de tres décadas grabó unas treinta y dos producciones, entre las que «Cruel Tormento», «Lindo Yambú», «Baja y Tapa» y «Espíritu Burlón» están entre sus temas más conocidos.

**Legado**

Cerón murió de problemas cardíacos en Nueva York en 2011. En 2018, un tramo de la calle Sickles en Washington Heights, donde había vivido durante años, fue renombrado en su honor: la primera calle de la ciudad de Nueva York con el nombre de un cantante dominicano.' WHERE slug = 'santiago-ceron';

COMMIT;
