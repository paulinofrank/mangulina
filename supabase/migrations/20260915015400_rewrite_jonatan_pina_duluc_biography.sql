BEGIN;

-- Ficha de Jonatan Piña Duluc.
--
-- La biografía de relleno describía en términos genéricos la escena musical de Santiago sin
-- nombrar a El Trio, Proyecto Piña Duluc, ningún álbum ni el Premio Nacional de Música.
-- Se registra el premio de 2015 (Música de Cámara, "Sonata para Violonchelo y Piano"), el
-- único de sus seis premios documentado con año, categoría y obra en dos fuentes
-- independientes; los otros cinco se mencionan en prosa sin desglose.

INSERT INTO award_categories (award_id, name)
SELECT id, 'Música de Cámara' FROM awards WHERE name = 'Premio Nacional de Música'
  AND NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = awards.id AND name = 'Música de Cámara');
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT a.id, aw.id, ac.id, 2015, 'Sonata para Violonchelo y Piano', true,
  'El Leño Pinto Digital (31 jul. 2017) y Facebook del Conservatorio Nacional de Música, ambos citando el Premio Nacional de Música 2015, categoría Música de Cámara'
FROM artists a, awards aw, award_categories ac
WHERE a.slug = 'jonatan-pina-duluc' AND aw.name = 'Premio Nacional de Música' AND ac.award_id = aw.id AND ac.name = 'Música de Cámara';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jonatan Piña Duluc is a Dominican saxophonist, composer and arranger from Santiago de los Caballeros who has built one of the country’s most distinctive catalogues at the meeting point of jazz, Dominican folk rhythm and progressive rock."}]},{"type":"paragraph","content":[{"type":"text","text":"Training","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He studied saxophone at Santiago’s Instituto de Cultura y Arte and contemporary classical composition at the Conservatorio Nacional de Música, later working privately on jazz arranging with the American teacher Corey Allen. For a decade he was the house saxophonist of «Lunes de Jazz», the long-running weekly jazz night in Santiago, and played alongside "},{"type":"artistReference","attrs":{"occurrenceId":"504ac3f8-7e5d-4581-ab67-392cc4d793f5","artistId":"8e29188a-215b-4c6c-b34a-45b381765e46","displayText":"Xiomara Fortuna"}},{"type":"text","text":" and other Dominican and visiting musicians."}]},{"type":"paragraph","content":[{"type":"text","text":"«El Trio» and «Proyecto Piña Duluc»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He first led the rock-fusion trio «El Trio», then in 2010 formed «Proyecto Piña Duluc» to bring original material blending jazz with Dominican folk rhythms — merengue, pambiche and their variants — to «Lunes de Jazz» itself, building a repertoire of more than twenty-five pieces played at the Centro León, the Dominican Republic Jazz Festival and other stages before its live debut album."}]},{"type":"paragraph","content":[{"type":"text","text":"A solo catalogue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2017 he went solo with «Drip/Culebra», an avant-garde, Afro-Dominican chamber-jazz record praised in the UK’s Songwriting Magazine, and followed it with «Substancia» (2018), «Secuencia III, Confirmación» (2020) and «Soundtrack Vol. I: Secuencia» (2021), continuing to compose, record and mix his own music."}]},{"type":"paragraph","content":[{"type":"text","text":"Awards","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He has won the Premio Nacional de Música, the country’s top composition prize, six times, including in 2015 for his «Sonata para Violonchelo y Piano» in the chamber music category."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Working from Santiago rather than the capital and building an idiom that fuses jazz with Dominican folk rhythm and progressive rock in equal measure, Jonatan Piña Duluc has become one of the most decorated composers of his generation without leaving the jazz circuit that shaped him."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jonatan-pina-duluc'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jonatan-pina-duluc' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '504ac3f8-7e5d-4581-ab67-392cc4d793f5', 'artist', '8e29188a-215b-4c6c-b34a-45b381765e46' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jonatan-pina-duluc' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Jonatan Piña Duluc is a Dominican saxophonist, composer and arranger from Santiago de los Caballeros who has built one of the country’s most distinctive catalogues at the meeting point of jazz, Dominican folk rhythm and progressive rock.

**Training**

He studied saxophone at Santiago’s Instituto de Cultura y Arte and contemporary classical composition at the Conservatorio Nacional de Música, later working privately on jazz arranging with the American teacher Corey Allen. For a decade he was the house saxophonist of «Lunes de Jazz», the long-running weekly jazz night in Santiago, and played alongside Xiomara Fortuna and other Dominican and visiting musicians.

**«El Trio» and «Proyecto Piña Duluc»**

He first led the rock-fusion trio «El Trio», then in 2010 formed «Proyecto Piña Duluc» to bring original material blending jazz with Dominican folk rhythms — merengue, pambiche and their variants — to «Lunes de Jazz» itself, building a repertoire of more than twenty-five pieces played at the Centro León, the Dominican Republic Jazz Festival and other stages before its live debut album.

**A solo catalogue**

In 2017 he went solo with «Drip/Culebra», an avant-garde, Afro-Dominican chamber-jazz record praised in the UK’s Songwriting Magazine, and followed it with «Substancia» (2018), «Secuencia III, Confirmación» (2020) and «Soundtrack Vol. I: Secuencia» (2021), continuing to compose, record and mix his own music.

**Awards**

He has won the Premio Nacional de Música, the country’s top composition prize, six times, including in 2015 for his «Sonata para Violonchelo y Piano» in the chamber music category.

**Legacy**

Working from Santiago rather than the capital and building an idiom that fuses jazz with Dominican folk rhythm and progressive rock in equal measure, Jonatan Piña Duluc has become one of the most decorated composers of his generation without leaving the jazz circuit that shaped him.' WHERE slug = 'jonatan-pina-duluc';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jonatan Piña Duluc es saxofonista, compositor y arreglista dominicano de Santiago de los Caballeros que ha construido uno de los catálogos más singulares del país en el cruce entre el jazz, el ritmo folclórico dominicano y el rock progresivo."}]},{"type":"paragraph","content":[{"type":"text","text":"Formación","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Estudió saxofón en el Instituto de Cultura y Arte de Santiago y composición clásica contemporánea en el Conservatorio Nacional de Música, y trabajó después de forma privada el arreglo de jazz con el profesor estadounidense Corey Allen. Durante una década fue el saxofonista de planta de «Lunes de Jazz», la tradición semanal de jazz en Santiago, y tocó junto a "},{"type":"artistReference","attrs":{"occurrenceId":"5107ae70-83a7-49d2-b03f-0802e956ea8c","artistId":"8e29188a-215b-4c6c-b34a-45b381765e46","displayText":"Xiomara Fortuna"}},{"type":"text","text":" y otros músicos dominicanos e invitados."}]},{"type":"paragraph","content":[{"type":"text","text":"«El Trio» y «Proyecto Piña Duluc»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Primero lideró el trío de rock-fusión «El Trio»; luego, en 2010, formó «Proyecto Piña Duluc» para llevar a los propios «Lunes de Jazz» material original que fusiona el jazz con ritmos folclóricos dominicanos —merengue, pambiche y sus variantes—, acumulando un repertorio de más de veinticinco piezas presentadas en el Centro León, el Dominican Republic Jazz Festival y otros escenarios antes de su álbum debut en vivo."}]},{"type":"paragraph","content":[{"type":"text","text":"Un catálogo propio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2017 debutó como solista con «Drip/Culebra», un disco de jazz de cámara afrodominicano y vanguardista elogiado por la revista británica Songwriting Magazine, al que siguieron «Substancia» (2018), «Secuencia III, Confirmación» (2020) y «Soundtrack Vol. I: Secuencia» (2021), en los que sigue componiendo, grabando y mezclando su propia música."}]},{"type":"paragraph","content":[{"type":"text","text":"Premios","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ha ganado el Premio Nacional de Música, el máximo galardón de composición del país, en seis ocasiones, entre ellas en 2015 por su «Sonata para Violonchelo y Piano» en la categoría de música de cámara."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Trabajando desde Santiago y no desde la capital, y construyendo un lenguaje que funde a partes iguales el jazz, el ritmo folclórico dominicano y el rock progresivo, Jonatan Piña Duluc se ha convertido en uno de los compositores más premiados de su generación sin salir del circuito de jazz que lo formó."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jonatan-pina-duluc'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jonatan-pina-duluc' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5107ae70-83a7-49d2-b03f-0802e956ea8c', 'artist', '8e29188a-215b-4c6c-b34a-45b381765e46' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jonatan-pina-duluc' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Jonatan Piña Duluc es saxofonista, compositor y arreglista dominicano de Santiago de los Caballeros que ha construido uno de los catálogos más singulares del país en el cruce entre el jazz, el ritmo folclórico dominicano y el rock progresivo.

**Formación**

Estudió saxofón en el Instituto de Cultura y Arte de Santiago y composición clásica contemporánea en el Conservatorio Nacional de Música, y trabajó después de forma privada el arreglo de jazz con el profesor estadounidense Corey Allen. Durante una década fue el saxofonista de planta de «Lunes de Jazz», la tradición semanal de jazz en Santiago, y tocó junto a Xiomara Fortuna y otros músicos dominicanos e invitados.

**«El Trio» y «Proyecto Piña Duluc»**

Primero lideró el trío de rock-fusión «El Trio»; luego, en 2010, formó «Proyecto Piña Duluc» para llevar a los propios «Lunes de Jazz» material original que fusiona el jazz con ritmos folclóricos dominicanos —merengue, pambiche y sus variantes—, acumulando un repertorio de más de veinticinco piezas presentadas en el Centro León, el Dominican Republic Jazz Festival y otros escenarios antes de su álbum debut en vivo.

**Un catálogo propio**

En 2017 debutó como solista con «Drip/Culebra», un disco de jazz de cámara afrodominicano y vanguardista elogiado por la revista británica Songwriting Magazine, al que siguieron «Substancia» (2018), «Secuencia III, Confirmación» (2020) y «Soundtrack Vol. I: Secuencia» (2021), en los que sigue componiendo, grabando y mezclando su propia música.

**Premios**

Ha ganado el Premio Nacional de Música, el máximo galardón de composición del país, en seis ocasiones, entre ellas en 2015 por su «Sonata para Violonchelo y Piano» en la categoría de música de cámara.

**Legado**

Trabajando desde Santiago y no desde la capital, y construyendo un lenguaje que funde a partes iguales el jazz, el ritmo folclórico dominicano y el rock progresivo, Jonatan Piña Duluc se ha convertido en uno de los compositores más premiados de su generación sin salir del circuito de jazz que lo formó.' WHERE slug = 'jonatan-pina-duluc';

COMMIT;
