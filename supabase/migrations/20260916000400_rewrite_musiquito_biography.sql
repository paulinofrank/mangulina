BEGIN;

-- Ficha de Musiquito.
--
-- La biografía de relleno inventaba una etimología sentimental para el apodo en vez de
-- reportar su origen real y documentado, y no nombraba canción, agrupación ni hecho alguno.
-- birth_year añadido (1952, derivado de "falleció a los 70 años" el 22 de junio de 2022).
-- birth_place/province añadidos (Moca/Espaillat). occupations ampliado con bandleader.

UPDATE artists SET birth_year = 1952, birth_place = 'Moca', province = 'Espaillat',
       occupations = '["bandleader"]'::jsonb
       WHERE slug = 'musiquito';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Musiquito —born Francisco Arturo Avelino García in Moca, Espaillat, around 1952, died there of a heart attack on 22 June 2022— was a Dominican merengue singer and bandleader remembered above all for «Cómetela Ripiá»."}]},{"type":"paragraph","content":[{"type":"text","text":"A nickname from the town band","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As a boy he never missed a rehearsal of Moca’s one municipal band, following its members through the streets so closely that townspeople took to saying, as they passed, «ahí viene la banda con el musiquito ese» — there goes the band with that little musician. The nickname stuck for life, and the band itself took him in at thirteen."}]},{"type":"paragraph","content":[{"type":"text","text":"From «Los Juveniles de Moca» to «Luis Ovalles y Orquesta»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1967 he joined «Los Juveniles de Moca», led by the saxophonist "},{"type":"artistReference","attrs":{"occurrenceId":"72e94199-db13-408f-b2f0-8545ebc8e042","artistId":"0882a2a4-4706-4687-9c2e-523944ab6011","displayText":"Luis Ovalles"}},{"type":"text","text":", who renamed the group after himself in 1973. Musiquito remained until 1979, shortly before Ovalles left for the capital in search of a wider audience."}]},{"type":"paragraph","content":[{"type":"text","text":"«Víctor Taveras y Musiquito»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1980 he formed «Víctor Taveras y Musiquito» in Santiago de los Caballeros with the musician Víctor Taveras, recording a single LP that included the merengues «La Ropa», «El Disco Rayao’» and «La Gran Fiesta de los Políticos» without much radio success. The partnership ended when Taveras left the country on a scholarship to study at a university in Detroit."}]},{"type":"paragraph","content":[{"type":"text","text":"«Musiquito y Orquesta» and «Cómetela Ripiá»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His career took off in 1981 with his own group, Musiquito y Orquesta, and its breakout hit «Cómetela Ripiá», still remembered by its chorus, «¿Tú la quieres mucho? Cómetela ripiá». Among his other songs, «El Añoñaíto» (1983) went on to be popularized far beyond the Dominican Republic, played at Barranquilla’s Carnival in Colombia the following year, alongside «Ay Mami», «Yo lo Coloco» and «El Tulipán»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"One of his last notable appearances came in 2018, at the fiftieth-anniversary celebration of Conjunto Quisqueya at the Teatro Nacional, where he stood in for the late singer Aneudi Díaz on account of their similar voices. He died four years later, at seventy, in his native Moca."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'musiquito'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'musiquito' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '72e94199-db13-408f-b2f0-8545ebc8e042', 'artist', '0882a2a4-4706-4687-9c2e-523944ab6011' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'musiquito' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Musiquito —born Francisco Arturo Avelino García in Moca, Espaillat, around 1952, died there of a heart attack on 22 June 2022— was a Dominican merengue singer and bandleader remembered above all for «Cómetela Ripiá».

**A nickname from the town band**

As a boy he never missed a rehearsal of Moca’s one municipal band, following its members through the streets so closely that townspeople took to saying, as they passed, «ahí viene la banda con el musiquito ese» — there goes the band with that little musician. The nickname stuck for life, and the band itself took him in at thirteen.

**From «Los Juveniles de Moca» to «Luis Ovalles y Orquesta»**

In 1967 he joined «Los Juveniles de Moca», led by the saxophonist Luis Ovalles, who renamed the group after himself in 1973. Musiquito remained until 1979, shortly before Ovalles left for the capital in search of a wider audience.

**«Víctor Taveras y Musiquito»**

In 1980 he formed «Víctor Taveras y Musiquito» in Santiago de los Caballeros with the musician Víctor Taveras, recording a single LP that included the merengues «La Ropa», «El Disco Rayao’» and «La Gran Fiesta de los Políticos» without much radio success. The partnership ended when Taveras left the country on a scholarship to study at a university in Detroit.

**«Musiquito y Orquesta» and «Cómetela Ripiá»**

His career took off in 1981 with his own group, Musiquito y Orquesta, and its breakout hit «Cómetela Ripiá», still remembered by its chorus, «¿Tú la quieres mucho? Cómetela ripiá». Among his other songs, «El Añoñaíto» (1983) went on to be popularized far beyond the Dominican Republic, played at Barranquilla’s Carnival in Colombia the following year, alongside «Ay Mami», «Yo lo Coloco» and «El Tulipán».

**Legacy**

One of his last notable appearances came in 2018, at the fiftieth-anniversary celebration of Conjunto Quisqueya at the Teatro Nacional, where he stood in for the late singer Aneudi Díaz on account of their similar voices. He died four years later, at seventy, in his native Moca.' WHERE slug = 'musiquito';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Musiquito —nacido Francisco Arturo Avelino García en Moca, Espaillat, hacia 1952, fallecido en la misma ciudad de un infarto el 22 de junio de 2022— fue cantante y director de orquesta dominicano de merengue, recordado sobre todo por «Cómetela Ripiá»."}]},{"type":"paragraph","content":[{"type":"text","text":"Un apodo salido de la banda del pueblo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De niño no se perdía un ensayo de la única banda municipal de Moca, siguiendo a sus integrantes por las calles con tanta insistencia que la gente del pueblo empezó a decir, a su paso, «ahí viene la banda con el musiquito ese». El apodo le quedó para toda la vida, y la propia banda lo acogió a los trece años."}]},{"type":"paragraph","content":[{"type":"text","text":"De «Los Juveniles de Moca» a «Luis Ovalles y Orquesta»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1967 entró a «Los Juveniles de Moca», dirigida por el saxofonista "},{"type":"artistReference","attrs":{"occurrenceId":"67e39eee-58b2-4a15-a567-048d81b31341","artistId":"0882a2a4-4706-4687-9c2e-523944ab6011","displayText":"Luis Ovalles"}},{"type":"text","text":", quien renombró la agrupación con su propio nombre en 1973. Musiquito se mantuvo allí hasta 1979, poco antes de que Ovalles partiera hacia la capital en busca de un público mayor."}]},{"type":"paragraph","content":[{"type":"text","text":"«Víctor Taveras y Musiquito»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1980 formó «Víctor Taveras y Musiquito» en Santiago de los Caballeros junto al músico Víctor Taveras, con quien grabó un único LP que incluía los merengues «La Ropa», «El Disco Rayao’» y «La Gran Fiesta de los Políticos», sin mucho resultado radial. La sociedad terminó cuando Taveras salió del país con una beca para estudiar en una universidad de Detroit."}]},{"type":"paragraph","content":[{"type":"text","text":"«Musiquito y Orquesta» y «Cómetela Ripiá»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su carrera despegó en 1981 con su propia agrupación, Musiquito y Orquesta, y el éxito que lo consagró, «Cómetela Ripiá», recordado todavía por su coro, «¿Tú la quieres mucho? Cómetela ripiá». Entre sus otras canciones, «El Añoñaíto» (1983) llegó a popularizarse más allá de República Dominicana, sonando en el Carnaval de Barranquilla, en Colombia, al año siguiente, junto a «Ay Mami», «Yo lo Coloco» y «El Tulipán»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Una de sus últimas presentaciones notables fue en 2018, en la celebración del cincuentenario del Conjunto Quisqueya en el Teatro Nacional, donde sustituyó al fenecido cantante Aneudi Díaz por el parecido de sus voces. Murió cuatro años después, a los setenta, en su Moca natal."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'musiquito'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'musiquito' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '67e39eee-58b2-4a15-a567-048d81b31341', 'artist', '0882a2a4-4706-4687-9c2e-523944ab6011' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'musiquito' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Musiquito —nacido Francisco Arturo Avelino García en Moca, Espaillat, hacia 1952, fallecido en la misma ciudad de un infarto el 22 de junio de 2022— fue cantante y director de orquesta dominicano de merengue, recordado sobre todo por «Cómetela Ripiá».

**Un apodo salido de la banda del pueblo**

De niño no se perdía un ensayo de la única banda municipal de Moca, siguiendo a sus integrantes por las calles con tanta insistencia que la gente del pueblo empezó a decir, a su paso, «ahí viene la banda con el musiquito ese». El apodo le quedó para toda la vida, y la propia banda lo acogió a los trece años.

**De «Los Juveniles de Moca» a «Luis Ovalles y Orquesta»**

En 1967 entró a «Los Juveniles de Moca», dirigida por el saxofonista Luis Ovalles, quien renombró la agrupación con su propio nombre en 1973. Musiquito se mantuvo allí hasta 1979, poco antes de que Ovalles partiera hacia la capital en busca de un público mayor.

**«Víctor Taveras y Musiquito»**

En 1980 formó «Víctor Taveras y Musiquito» en Santiago de los Caballeros junto al músico Víctor Taveras, con quien grabó un único LP que incluía los merengues «La Ropa», «El Disco Rayao’» y «La Gran Fiesta de los Políticos», sin mucho resultado radial. La sociedad terminó cuando Taveras salió del país con una beca para estudiar en una universidad de Detroit.

**«Musiquito y Orquesta» y «Cómetela Ripiá»**

Su carrera despegó en 1981 con su propia agrupación, Musiquito y Orquesta, y el éxito que lo consagró, «Cómetela Ripiá», recordado todavía por su coro, «¿Tú la quieres mucho? Cómetela ripiá». Entre sus otras canciones, «El Añoñaíto» (1983) llegó a popularizarse más allá de República Dominicana, sonando en el Carnaval de Barranquilla, en Colombia, al año siguiente, junto a «Ay Mami», «Yo lo Coloco» y «El Tulipán».

**Legado**

Una de sus últimas presentaciones notables fue en 2018, en la celebración del cincuentenario del Conjunto Quisqueya en el Teatro Nacional, donde sustituyó al fenecido cantante Aneudi Díaz por el parecido de sus voces. Murió cuatro años después, a los setenta, en su Moca natal.' WHERE slug = 'musiquito';

COMMIT;
