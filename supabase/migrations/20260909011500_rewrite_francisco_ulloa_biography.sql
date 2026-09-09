BEGIN;

-- Ficha de Francisco Ulloa.
--
-- El relleno que se reemplaza afirmaba que había muerto ("His death was
-- mourned..."). Está vivo: Wikipedia lo marca como biografía de persona
-- viva, MusicBrainz da life-span ended=false, Wikidata no tiene P570,
-- reside en Santiago y en 2025 publicó un disco con Eladio Romero Santos.
--
-- birth_year 1941 se retira por falta de fuente. No aparece en MusicBrainz
-- (life-span begin nulo, con el mbid que la propia fila guarda), ni en
-- Wikidata Q5484003 (P569 ausente), ni en Wikipedia, ni en sus cuentas. El
-- valor coincidía con el mismo texto de relleno que inventó su muerte.
-- El lugar de nacimiento sí se sostiene: su propio canal dice "una aldea
-- cerca de Quita Sueño de Altamira, región de Puerto Plata".
--
-- occupations e instruments se alinean con la convención de los
-- acordeonistas típicos del catálogo (Fefita la Grande, Agapito Pascual,
-- Tatico Henríquez): primary_role singer, accordionist en occupations,
-- accordion en instruments. Se retira "musician", que no dice nada que
-- "accordionist" no diga mejor.

-- 1. Campos
UPDATE artists
   SET birth_year  = NULL,
       occupations = '["accordionist","bandleader","composer","arranger"]'::jsonb,
       instruments = ARRAY['accordion']::text[]
 WHERE slug = 'francisco-ulloa';

-- 2. Documentos editoriales, referencias y espejo markdown legacy
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Francisco Ulloa is a Dominican accordionist, singer and bandleader, and one of the leading interpreters of merengue típico, the accordion-led country form of the Cibao also known as perico ripiao. He was born in Altamira, Puerto Plata, began recording in 1970, and reached his largest audience in 1994 playing on Fogaraté, the album by "},{"type":"artistReference","attrs":{"occurrenceId":"b2b3ebce-1234-4c68-9e6d-d7455b6e4e8b","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":". He lives in Santiago and continues to perform."}]},{"type":"paragraph","content":[{"type":"text","text":"Altamira and the 1970s","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ulloa was born in a village near Quita Sueño, in the Altamira district of Puerto Plata. He turned professional in the 1970s, at roughly the same time as "},{"type":"artistReference","attrs":{"occurrenceId":"f06765c4-494c-4f03-8f83-e44cc69e1310","artistId":"9b15dfca-0f60-49b3-a139-100a5a329741","displayText":"Tatico Henríquez"}},{"type":"text","text":", the accordionist widely regarded as the founder of modern merengue típico. That cohort moved a music which had belonged to rural festivities into recording studios and onto the radio. His first record, El Baby Vol. 1, appeared in 1970."}]},{"type":"paragraph","content":[{"type":"text","text":"The Conjunto San Rafael years","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ulloa recorded steadily from the late 1970s: La Chiflera, Ahora vengo más fuerte and Divina qué linda eres all in 1979, La Tijera in 1980, and in 1981 two records with the Conjunto San Rafael, one of them presented by "},{"type":"artistReference","attrs":{"occurrenceId":"b6c1a270-a68b-4cee-9b5e-a2775f1cb94b","artistId":"634a12eb-24c4-4053-835b-806986a8a735","displayText":"Eladio Romero Santos"}},{"type":"text","text":". He settled his debt to his predecessor with Homenaje al Gran Tatico Henríquez in 1983."}]},{"type":"paragraph","content":[{"type":"text","text":"The run continued through ¡Merengue! (1987), ¿Qué? ¡Aha! La mujer de Antonio (1988), ...Y los mosquitos pullan (1989), En New York and El Chucuchá (both 1990), ¡Ultramerengue! and Voy pa’ llá (1992), Pa’ mi campo (1993), Pegaito (1995), Mejor que nunca (1999), Yo quiero alegría (2000), ¡Qué vaina! (2002) and El Paquetón (2003)."}]},{"type":"paragraph","content":[{"type":"text","text":"Fogaraté","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1994 Juan Luis Guerra released Fogaraté, and on two of its típico tracks he brought Ulloa in as collaborator and as the hand behind the accordion writing. \"La Cosquillita\" was the lead single that June: Guerra wrote and produced it with Ulloa and his band, Spanish-language accounts credit the music to the accordionist, and it reached the Latin Airplay top twenty in Spain, the Dominican Republic, Puerto Rico, Venezuela and the United States, taking a BMI Latin Award in 1996. \"El Farolito\", the album’s eighth track, went to number one in the Dominican Republic. Guerra said he had set out to do for perico ripiao what he had already done for bachata. Fogaraté was nominated for the Grammy for Best Traditional Tropical Latin Album."}]},{"type":"paragraph","content":[{"type":"text","text":"Style","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ulloa plays the diatonic button accordion, and his reputation rests on speed and improvisation — spontaneous variation rather than fixed arrangement. Writers place him in the older, more rustic wing of the tradition, closer to "},{"type":"artistReference","attrs":{"occurrenceId":"6346addc-8e54-4f1a-aed4-7bac61307799","artistId":"9333da06-ad03-44eb-9b81-c21d0ccdd0ea","displayText":"Fefita la Grande"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"a976bd76-2aca-4385-96bb-d9a5e83030b9","artistId":"9127e809-a19c-44b8-a6e6-cee9335941bb","displayText":"Agapito Pascual"}},{"type":"text","text":" than to the jazz-inflected playing of younger accordionists such as "},{"type":"artistReference","attrs":{"occurrenceId":"5d4e2023-ceca-4c88-8927-7d4616a1b96f","artistId":"f07fcc6b-a888-4e97-ac50-6ce6ea37a714","displayText":"El Prodigio"}},{"type":"text","text":". Surveys of the style list him beside Tatico Henríquez, Pedro Reynoso, El Ciego de Nagua, Francisco Peralta and Rafaelito Román."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ulloa is one of the accordionists who carried merengue típico from provincial dance floors to concert halls abroad, and the one whose playing reached the widest audience, through Fogaraté. He continues to perform at home and abroad, and in 2025 released Merengue Típico with Eladio Romero Santos."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'francisco-ulloa'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'francisco-ulloa' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b2b3ebce-1234-4c68-9e6d-d7455b6e4e8b', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'francisco-ulloa' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f06765c4-494c-4f03-8f83-e44cc69e1310', 'artist', '9b15dfca-0f60-49b3-a139-100a5a329741'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'francisco-ulloa' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b6c1a270-a68b-4cee-9b5e-a2775f1cb94b', 'artist', '634a12eb-24c4-4053-835b-806986a8a735'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'francisco-ulloa' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6346addc-8e54-4f1a-aed4-7bac61307799', 'artist', '9333da06-ad03-44eb-9b81-c21d0ccdd0ea'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'francisco-ulloa' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a976bd76-2aca-4385-96bb-d9a5e83030b9', 'artist', '9127e809-a19c-44b8-a6e6-cee9335941bb'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'francisco-ulloa' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5d4e2023-ceca-4c88-8927-7d4616a1b96f', 'artist', 'f07fcc6b-a888-4e97-ac50-6ce6ea37a714'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'francisco-ulloa' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Francisco Ulloa is a Dominican accordionist, singer and bandleader, and one of the leading interpreters of merengue típico, the accordion-led country form of the Cibao also known as perico ripiao. He was born in Altamira, Puerto Plata, began recording in 1970, and reached his largest audience in 1994 playing on Fogaraté, the album by Juan Luis Guerra 4.40. He lives in Santiago and continues to perform.

**Altamira and the 1970s**

Ulloa was born in a village near Quita Sueño, in the Altamira district of Puerto Plata. He turned professional in the 1970s, at roughly the same time as Tatico Henríquez, the accordionist widely regarded as the founder of modern merengue típico. That cohort moved a music which had belonged to rural festivities into recording studios and onto the radio. His first record, El Baby Vol. 1, appeared in 1970.

**The Conjunto San Rafael years**

Ulloa recorded steadily from the late 1970s: La Chiflera, Ahora vengo más fuerte and Divina qué linda eres all in 1979, La Tijera in 1980, and in 1981 two records with the Conjunto San Rafael, one of them presented by Eladio Romero Santos. He settled his debt to his predecessor with Homenaje al Gran Tatico Henríquez in 1983.

The run continued through ¡Merengue! (1987), ¿Qué? ¡Aha! La mujer de Antonio (1988), ...Y los mosquitos pullan (1989), En New York and El Chucuchá (both 1990), ¡Ultramerengue! and Voy pa’ llá (1992), Pa’ mi campo (1993), Pegaito (1995), Mejor que nunca (1999), Yo quiero alegría (2000), ¡Qué vaina! (2002) and El Paquetón (2003).

**Fogaraté**

In 1994 Juan Luis Guerra released Fogaraté, and on two of its típico tracks he brought Ulloa in as collaborator and as the hand behind the accordion writing. "La Cosquillita" was the lead single that June: Guerra wrote and produced it with Ulloa and his band, Spanish-language accounts credit the music to the accordionist, and it reached the Latin Airplay top twenty in Spain, the Dominican Republic, Puerto Rico, Venezuela and the United States, taking a BMI Latin Award in 1996. "El Farolito", the album’s eighth track, went to number one in the Dominican Republic. Guerra said he had set out to do for perico ripiao what he had already done for bachata. Fogaraté was nominated for the Grammy for Best Traditional Tropical Latin Album.

**Style**

Ulloa plays the diatonic button accordion, and his reputation rests on speed and improvisation — spontaneous variation rather than fixed arrangement. Writers place him in the older, more rustic wing of the tradition, closer to Fefita la Grande and Agapito Pascual than to the jazz-inflected playing of younger accordionists such as El Prodigio. Surveys of the style list him beside Tatico Henríquez, Pedro Reynoso, El Ciego de Nagua, Francisco Peralta and Rafaelito Román.

**Legacy**

Ulloa is one of the accordionists who carried merengue típico from provincial dance floors to concert halls abroad, and the one whose playing reached the widest audience, through Fogaraté. He continues to perform at home and abroad, and in 2025 released Merengue Típico with Eladio Romero Santos.' WHERE slug = 'francisco-ulloa';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Francisco Ulloa es acordeonista, cantante y director de conjunto dominicano, y uno de los principales intérpretes del merengue típico, la forma campesina del Cibao llevada por el acordeón que también se conoce como perico ripiao. Nació en Altamira, Puerto Plata, empezó a grabar en 1970 y llegó a su público más amplio en 1994 tocando en Fogaraté, el disco de "},{"type":"artistReference","attrs":{"occurrenceId":"615f30d7-a680-49ba-b117-c893d42970b4","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":". Vive en Santiago y sigue presentándose."}]},{"type":"paragraph","content":[{"type":"text","text":"Altamira y los años setenta","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ulloa nació en una aldea cerca de Quita Sueño, en el municipio de Altamira, Puerto Plata. Se hizo profesional en los años setenta, más o menos al mismo tiempo que "},{"type":"artistReference","attrs":{"occurrenceId":"3e460f4b-c255-4f23-8909-e647118cb59a","artistId":"9b15dfca-0f60-49b3-a139-100a5a329741","displayText":"Tatico Henríquez"}},{"type":"text","text":", el acordeonista al que se tiene por fundador del merengue típico moderno. Esa camada sacó de las fiestas del campo una música que hasta entonces vivía allí y la metió en los estudios y en la radio. Su primer disco, El Baby Vol. 1, es de 1970."}]},{"type":"paragraph","content":[{"type":"text","text":"Los años del Conjunto San Rafael","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ulloa grabó sin pausa desde finales de los setenta: La Chiflera, Ahora vengo más fuerte y Divina qué linda eres, los tres en 1979; La Tijera en 1980; y en 1981 dos discos con el Conjunto San Rafael, uno de ellos presentado por "},{"type":"artistReference","attrs":{"occurrenceId":"7e8642fd-e01b-4b67-bba8-8b571d093be9","artistId":"634a12eb-24c4-4053-835b-806986a8a735","displayText":"Eladio Romero Santos"}},{"type":"text","text":". Saldó la deuda con su antecesor en 1983 con Homenaje al Gran Tatico Henríquez."}]},{"type":"paragraph","content":[{"type":"text","text":"La seguidilla continuó con ¡Merengue! (1987), ¿Qué? ¡Aha! La mujer de Antonio (1988), ...Y los mosquitos pullan (1989), En New York y El Chucuchá (los dos de 1990), ¡Ultramerengue! y Voy pa’ llá (1992), Pa’ mi campo (1993), Pegaito (1995), Mejor que nunca (1999), Yo quiero alegría (2000), ¡Qué vaina! (2002) y El Paquetón (2003)."}]},{"type":"paragraph","content":[{"type":"text","text":"Fogaraté","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1994 Juan Luis Guerra sacó Fogaraté, y en dos de sus temas típicos metió a Ulloa como colaborador y como responsable de la escritura del acordeón. «La Cosquillita» salió de sencillo en junio: Guerra la escribió y produjo con Ulloa y su conjunto, las fuentes en español acreditan la música al acordeonista, y llegó al top veinte de Latin Airplay en España, República Dominicana, Puerto Rico, Venezuela y Estados Unidos, además de un BMI Latin Award en 1996. «El Farolito», octavo tema del disco, llegó al número uno en la República Dominicana. Guerra dijo que se había propuesto hacer con el perico ripiao lo que ya había hecho con la bachata. Fogaraté fue nominado al Grammy al mejor álbum tropical tradicional."}]},{"type":"paragraph","content":[{"type":"text","text":"Estilo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ulloa toca el acordeón diatónico de botones, y su fama descansa en la velocidad y en la improvisación: variación espontánea antes que arreglo fijo. La crítica lo sitúa en el ala vieja y más rústica de la tradición, más cerca de "},{"type":"artistReference","attrs":{"occurrenceId":"3e99affb-3eaa-41bd-b2d4-8c9f0c75377d","artistId":"9333da06-ad03-44eb-9b81-c21d0ccdd0ea","displayText":"Fefita la Grande"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"47933e63-b385-4c7c-909d-a3f137b20482","artistId":"9127e809-a19c-44b8-a6e6-cee9335941bb","displayText":"Agapito Pascual"}},{"type":"text","text":" que del fraseo con armonía de jazz de acordeonistas más jóvenes como "},{"type":"artistReference","attrs":{"occurrenceId":"71fb9bac-4513-476b-991a-c2ec94f17f96","artistId":"f07fcc6b-a888-4e97-ac50-6ce6ea37a714","displayText":"El Prodigio"}},{"type":"text","text":". Los repasos del género lo enumeran junto a Tatico Henríquez, Pedro Reynoso, El Ciego de Nagua, Francisco Peralta y Rafaelito Román."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ulloa es uno de los acordeonistas que sacaron el merengue típico de las pistas de provincia a las salas de concierto del extranjero, y aquel cuyo tocar llegó a más gente, por vía de Fogaraté. Sigue presentándose dentro y fuera del país, y en 2025 publicó Merengue Típico con Eladio Romero Santos."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'francisco-ulloa'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'francisco-ulloa' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '615f30d7-a680-49ba-b117-c893d42970b4', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'francisco-ulloa' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3e460f4b-c255-4f23-8909-e647118cb59a', 'artist', '9b15dfca-0f60-49b3-a139-100a5a329741'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'francisco-ulloa' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7e8642fd-e01b-4b67-bba8-8b571d093be9', 'artist', '634a12eb-24c4-4053-835b-806986a8a735'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'francisco-ulloa' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3e99affb-3eaa-41bd-b2d4-8c9f0c75377d', 'artist', '9333da06-ad03-44eb-9b81-c21d0ccdd0ea'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'francisco-ulloa' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '47933e63-b385-4c7c-909d-a3f137b20482', 'artist', '9127e809-a19c-44b8-a6e6-cee9335941bb'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'francisco-ulloa' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '71fb9bac-4513-476b-991a-c2ec94f17f96', 'artist', 'f07fcc6b-a888-4e97-ac50-6ce6ea37a714'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'francisco-ulloa' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Francisco Ulloa es acordeonista, cantante y director de conjunto dominicano, y uno de los principales intérpretes del merengue típico, la forma campesina del Cibao llevada por el acordeón que también se conoce como perico ripiao. Nació en Altamira, Puerto Plata, empezó a grabar en 1970 y llegó a su público más amplio en 1994 tocando en Fogaraté, el disco de Juan Luis Guerra 4.40. Vive en Santiago y sigue presentándose.

**Altamira y los años setenta**

Ulloa nació en una aldea cerca de Quita Sueño, en el municipio de Altamira, Puerto Plata. Se hizo profesional en los años setenta, más o menos al mismo tiempo que Tatico Henríquez, el acordeonista al que se tiene por fundador del merengue típico moderno. Esa camada sacó de las fiestas del campo una música que hasta entonces vivía allí y la metió en los estudios y en la radio. Su primer disco, El Baby Vol. 1, es de 1970.

**Los años del Conjunto San Rafael**

Ulloa grabó sin pausa desde finales de los setenta: La Chiflera, Ahora vengo más fuerte y Divina qué linda eres, los tres en 1979; La Tijera en 1980; y en 1981 dos discos con el Conjunto San Rafael, uno de ellos presentado por Eladio Romero Santos. Saldó la deuda con su antecesor en 1983 con Homenaje al Gran Tatico Henríquez.

La seguidilla continuó con ¡Merengue! (1987), ¿Qué? ¡Aha! La mujer de Antonio (1988), ...Y los mosquitos pullan (1989), En New York y El Chucuchá (los dos de 1990), ¡Ultramerengue! y Voy pa’ llá (1992), Pa’ mi campo (1993), Pegaito (1995), Mejor que nunca (1999), Yo quiero alegría (2000), ¡Qué vaina! (2002) y El Paquetón (2003).

**Fogaraté**

En 1994 Juan Luis Guerra sacó Fogaraté, y en dos de sus temas típicos metió a Ulloa como colaborador y como responsable de la escritura del acordeón. «La Cosquillita» salió de sencillo en junio: Guerra la escribió y produjo con Ulloa y su conjunto, las fuentes en español acreditan la música al acordeonista, y llegó al top veinte de Latin Airplay en España, República Dominicana, Puerto Rico, Venezuela y Estados Unidos, además de un BMI Latin Award en 1996. «El Farolito», octavo tema del disco, llegó al número uno en la República Dominicana. Guerra dijo que se había propuesto hacer con el perico ripiao lo que ya había hecho con la bachata. Fogaraté fue nominado al Grammy al mejor álbum tropical tradicional.

**Estilo**

Ulloa toca el acordeón diatónico de botones, y su fama descansa en la velocidad y en la improvisación: variación espontánea antes que arreglo fijo. La crítica lo sitúa en el ala vieja y más rústica de la tradición, más cerca de Fefita la Grande y Agapito Pascual que del fraseo con armonía de jazz de acordeonistas más jóvenes como El Prodigio. Los repasos del género lo enumeran junto a Tatico Henríquez, Pedro Reynoso, El Ciego de Nagua, Francisco Peralta y Rafaelito Román.

**Legado**

Ulloa es uno de los acordeonistas que sacaron el merengue típico de las pistas de provincia a las salas de concierto del extranjero, y aquel cuyo tocar llegó a más gente, por vía de Fogaraté. Sigue presentándose dentro y fuera del país, y en 2025 publicó Merengue Típico con Eladio Romero Santos.' WHERE slug = 'francisco-ulloa';

COMMIT;
