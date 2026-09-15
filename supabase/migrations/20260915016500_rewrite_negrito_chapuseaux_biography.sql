BEGIN;

-- Ficha de Negrito Chapuseaux.
--
-- La biografía de relleno no mencionaba a Damirón, al dúo, ni ningún hecho concreto de su
-- carrera. second_last_name añadido (Guerra); occupations ampliado con "dancer" (bailarín,
-- per dos fuentes independientes que lo describen como "cantante, compositor y bailarín").

UPDATE artists SET second_last_name = 'Guerra', occupations = '["dancer"]'::jsonb WHERE slug = 'negrito-chapuseaux';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"José Ernesto Chapuseaux Guerra, known as Negrito Chapuseaux, was a Dominican singer, dancer and composer born in Santo Domingo on 17 October 1911 and, as one half of Damirón y Chapuseaux, credited alongside "},{"type":"artistReference","attrs":{"occurrenceId":"5edc93c2-3c14-4f68-add8-d26d51ecf851","artistId":"fa592bc6-78af-41e8-a1ff-f6fe59fae250","displayText":"Damirón"}},{"type":"text","text":" with carrying Dominican merengue across Latin America and the Caribbean."}]},{"type":"paragraph","content":[{"type":"text","text":"From the Santo Domingo Jazz Band to exile","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began performing alongside pianist Francisco Damirón, Freddy Coronado and a young Billo Frómeta in the dance orchestra Santo Domingo Jazz Band. In December 1937, Chapuseaux and Damirón left the country into political exile from the Trujillo dictatorship, settling in Venezuela, where together with Frómeta they helped found the Billo’s Happy Boys, forerunner of the later Billo’s Caracas Boys."}]},{"type":"paragraph","content":[{"type":"text","text":"Panama, Los Alegres Tres, and a new life","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The duo went on to Panama, where Chapuseaux met the singer and actress Silvia De Grasse; the three formed the trio Los Alegres Tres, folding Panamanian tambora rhythms into their Dominican repertoire. Chapuseaux and De Grasse later married and settled in Puerto Rico, with Damirón and his own family following."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Chapuseaux died in Santo Domingo on 19 November 1986, at 75. As the vocalist and dancer in one of Dominican music’s most consequential export acts, he helped make merengue a Caribbean-wide currency decades before it became a global one."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'negrito-chapuseaux'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'negrito-chapuseaux' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5edc93c2-3c14-4f68-add8-d26d51ecf851', 'artist', 'fa592bc6-78af-41e8-a1ff-f6fe59fae250' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'negrito-chapuseaux' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'José Ernesto Chapuseaux Guerra, known as Negrito Chapuseaux, was a Dominican singer, dancer and composer born in Santo Domingo on 17 October 1911 and, as one half of Damirón y Chapuseaux, credited alongside Damirón with carrying Dominican merengue across Latin America and the Caribbean.

**From the Santo Domingo Jazz Band to exile**

He began performing alongside pianist Francisco Damirón, Freddy Coronado and a young Billo Frómeta in the dance orchestra Santo Domingo Jazz Band. In December 1937, Chapuseaux and Damirón left the country into political exile from the Trujillo dictatorship, settling in Venezuela, where together with Frómeta they helped found the Billo’s Happy Boys, forerunner of the later Billo’s Caracas Boys.

**Panama, Los Alegres Tres, and a new life**

The duo went on to Panama, where Chapuseaux met the singer and actress Silvia De Grasse; the three formed the trio Los Alegres Tres, folding Panamanian tambora rhythms into their Dominican repertoire. Chapuseaux and De Grasse later married and settled in Puerto Rico, with Damirón and his own family following.

**Legacy**

Chapuseaux died in Santo Domingo on 19 November 1986, at 75. As the vocalist and dancer in one of Dominican music’s most consequential export acts, he helped make merengue a Caribbean-wide currency decades before it became a global one.' WHERE slug = 'negrito-chapuseaux';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"José Ernesto Chapuseaux Guerra, conocido como Negrito Chapuseaux, fue cantante, bailarín y compositor dominicano nacido en Santo Domingo el 17 de octubre de 1911 y, como una mitad de Damirón y Chapuseaux, se le atribuye junto a "},{"type":"artistReference","attrs":{"occurrenceId":"2d870754-b86a-457f-aa62-2e963ff67fc8","artistId":"fa592bc6-78af-41e8-a1ff-f6fe59fae250","displayText":"Damirón"}},{"type":"text","text":" haber llevado el merengue dominicano por toda América Latina y el Caribe."}]},{"type":"paragraph","content":[{"type":"text","text":"De la Santo Domingo Jazz Band al exilio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Comenzó a actuar junto al pianista Francisco Damirón, Freddy Coronado y un joven Billo Frómeta en la orquesta de baile Santo Domingo Jazz Band. En diciembre de 1937, Chapuseaux y Damirón salieron del país al exilio político huyendo de la dictadura de Trujillo, radicándose en Venezuela, donde junto a Frómeta ayudaron a fundar Billo’s Happy Boys, precursora de la posterior Billo’s Caracas Boys."}]},{"type":"paragraph","content":[{"type":"text","text":"Panamá, Los Alegres Tres y una nueva vida","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El dúo siguió a Panamá, donde Chapuseaux conoció a la cantante y actriz Silvia De Grasse; los tres formaron el trío Los Alegres Tres, sumando ritmos de tambora panameña a su repertorio dominicano. Chapuseaux y De Grasse se casaron después y se establecieron en Puerto Rico, adonde los siguieron Damirón y su propia familia."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Chapuseaux murió en Santo Domingo el 19 de noviembre de 1986, a los setenta y cinco años. Como voz y bailarín de uno de los actos de exportación más importantes de la música dominicana, ayudó a hacer del merengue una moneda corriente en todo el Caribe décadas antes de que se convirtiera en una global."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'negrito-chapuseaux'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'negrito-chapuseaux' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2d870754-b86a-457f-aa62-2e963ff67fc8', 'artist', 'fa592bc6-78af-41e8-a1ff-f6fe59fae250' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'negrito-chapuseaux' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'José Ernesto Chapuseaux Guerra, conocido como Negrito Chapuseaux, fue cantante, bailarín y compositor dominicano nacido en Santo Domingo el 17 de octubre de 1911 y, como una mitad de Damirón y Chapuseaux, se le atribuye junto a Damirón haber llevado el merengue dominicano por toda América Latina y el Caribe.

**De la Santo Domingo Jazz Band al exilio**

Comenzó a actuar junto al pianista Francisco Damirón, Freddy Coronado y un joven Billo Frómeta en la orquesta de baile Santo Domingo Jazz Band. En diciembre de 1937, Chapuseaux y Damirón salieron del país al exilio político huyendo de la dictadura de Trujillo, radicándose en Venezuela, donde junto a Frómeta ayudaron a fundar Billo’s Happy Boys, precursora de la posterior Billo’s Caracas Boys.

**Panamá, Los Alegres Tres y una nueva vida**

El dúo siguió a Panamá, donde Chapuseaux conoció a la cantante y actriz Silvia De Grasse; los tres formaron el trío Los Alegres Tres, sumando ritmos de tambora panameña a su repertorio dominicano. Chapuseaux y De Grasse se casaron después y se establecieron en Puerto Rico, adonde los siguieron Damirón y su propia familia.

**Legado**

Chapuseaux murió en Santo Domingo el 19 de noviembre de 1986, a los setenta y cinco años. Como voz y bailarín de uno de los actos de exportación más importantes de la música dominicana, ayudó a hacer del merengue una moneda corriente en todo el Caribe décadas antes de que se convirtiera en una global.' WHERE slug = 'negrito-chapuseaux';

COMMIT;
