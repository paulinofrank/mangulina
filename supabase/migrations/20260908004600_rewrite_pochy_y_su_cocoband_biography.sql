BEGIN;

-- Rewrite the catalogue entry for Pochy y su Cocoband.
--
-- Pochy y su Cocoband. SEXTA de las 211, con 16 enlaces entrantes. Y la ficha
-- más vacía que he visto: 135 CARACTERES.
--
-- Decía, entera: "Pochy y su Cocoband is a Dominican music group. The group is
-- documented for its contribution to Dominican music and its related scenes."
-- Eso no es una biografía corta, es una PLANTILLA. La segunda oración se puede
-- pegar debajo de cualquier nombre del catálogo sin cambiar una palabra.
--
-- ---------------------------------------------------------------------------
-- LA CONFLACIÓN PERSONA/GRUPO, PROBADA CON FUENTE Y NO TOCADA
--
-- La fila es type = 'group' y guarda: first_name 'Manuel', middle_name
-- 'Alfonso', last_name 'Vázquez', second_last_name 'Familia', birth_place
-- 'Higüey' y date_of_birth 1966-09-17.
--
-- Comprobado: POCHY FAMILIA NACIÓ EL 17 DE SEPTIEMBRE DE 1966. O sea que esa
-- fecha es la del HOMBRE, no la de la orquesta. Y en una fila de tipo 'group'
-- el campo significa AÑO DE FORMACIÓN, así que la página pública está diciendo
-- que la Cocoband se formó en 1966, cuando la banda se fundó en 1988.
--
-- NO LO CORRIJO, Y ES DELIBERADO. El editor dejó dicho que la separación de
-- orquestas y cantantes se hará en una auditoría aparte. Y hay una razón
-- técnica para no tocarlo antes: la fecha de nacimiento de Pochy SOLO EXISTE
-- AQUÍ. Si la sobrescribo con 1988 para arreglar lo que se ve, destruyo el dato
-- que la separación va a necesitar para armar la ficha de la persona. Queda
-- reportado como el caso más urgente del inventario.
-- ---------------------------------------------------------------------------
--
-- AÑO DE FUNDACIÓN: HAY CONFLICTO Y SE RESUELVE POR PESO DE FUENTE. El sitio
-- oficial de la banda pone "DESDE 1982" y "40+ años". Listín Diario, en octubre
-- de 2022, dice "esta agrupación FUNDADA EN 1988" y cubre la celebración de sus
-- 35 años; Diario Libre cubrió ese mismo 35 aniversario en diciembre de 2022.
-- Dos periódicos contra el eslogan de la propia banda. Se escribe 1988.
--
-- EL DATO QUE MÁS ME SORPRENDIÓ, Y QUE CORRIGE LO QUE SUGIERE SU PROPIO SITIO:
-- "LA NEGRA POLA" NO ES UNA CANCIÓN DE LA COCOBAND. Pochy la escribió en 1979
-- PARA CHECHÉ ABREU, casi una década antes de fundar la banda. Fue su primer
-- éxito como compositor, siendo un muchacho. El sitio oficial la presenta como
-- si fuera del grupo -- "Desde La Negra Pola hasta sus más recientes éxitos" --
-- y Listín Diario aclara el crédito.
--
-- LO QUE FALTABA, QUE ES ABSOLUTAMENTE TODO:
--
--   CASI SETENTA ÉXITOS ININTERRUMPIDOS ENTRE 1988 Y 1995, y más de cien en
--   diecisiete producciones. De las siete primeras producciones pegaron TODAS
--   las canciones, de la primera a la última.
--
--   ANTES DE LA BANDA, Pochy fue arreglista y compositor de Los Hermanos
--   Rosario, La Gran Manzana y Richie Ricardo, y trabajó en los estudios de
--   Mateo San Martín y su disquera Kubaney.
--
--   EL HOMENAJE DE 2022: DIECISÉIS cantantes de merengue grabaron juntos "35
--   Años con Coco". Listín Diario dice que es LA PRIMERA VEZ en la historia
--   musical dominicana que dieciséis artistas del género se juntan para
--   homenajear a un merenguero. Los dieciséis están en este catálogo salvo dos.
--
--   SUS FANÁTICOS SE LLAMAN "COCOTUSES".
--
-- EL SITIO WEB OFICIAL NO ESTABA GUARDADO. lacocoband.com existe, funciona, y
-- tiene calendario de gira de 2026. Entra.
--
-- LOS TRES HANDLES SON CORRECTOS Y LO COMPROBÉ EN LA MEJOR FUENTE POSIBLE: el
-- propio sitio oficial enlaza exactamente a los tres que la fila ya guardaba --
-- youtube @pochyfamiliaysucocoband3832, instagram pochyfamilia y facebook
-- pochy.familia. El sufijo "3832" del canal parece autogenerado, pero después
-- de lo de Toño Rosario esta mañana no doy nada por muerto sin comprobarlo: el
-- canal existe y es el que su propia web señala.
--
-- DIECINUEVE ENLACES, que es el máximo de toda la corrida, y todos por crédito
-- documentado: cheche-abreu ("La Negra Pola", 1979), los-hermanos-rosario y
-- richie-ricardo (orquestas que Pochy arregló), los-kenton (le pidieron liberar
-- "El Negro del Swing", que la Cocoband tenía engavetado -- está contado en la
-- ficha de ellos, así que cierra por los dos lados), y los quince intérpretes
-- del homenaje de 2022 que están publicados.
--
-- NO ESTÁN Y VAN A LA LISTA: LA GRAN MANZANA, orquesta que Pochy arregló, y
-- CHUCKY ACOSTA, uno de los dieciséis del homenaje.
--
-- NO SE ESCRIBEN los oyentes mensuales de Spotify, que consulté para el
-- catálogo de canciones.
--
-- FUENTES: Listín Diario, 21 de octubre de 2022, que es la buena y la que
-- resuelve fundación, créditos y trayectoria. El sitio oficial lacocoband.com
-- para la actividad actual y los handles. Spotify para confirmar los títulos
-- más oídos. Una publicación de República Merengue para la fecha de nacimiento
-- de Pochy. NO HAY artículo de Wikipedia, ni en español ni en inglés: cuarta
-- ficha de la corrida en esa situación.
--
-- Applied directly over DATABASE_URL as part of an editorial pass. No Vercel
-- function ran and nothing was revalidated; the profile reaches the public site
-- on its own within the 31-day ISR fallback for artist profiles, or sooner if a
-- targeted revalidation is run for the slug.
--
-- This file reproduces the change from the pre-pass state. Both it and its
-- rollback were generated from state captured live either side of the write,
-- not reconstructed afterwards.

UPDATE artists SET
       name = 'Pochy y su Cocoband',
       sort_name = 'Pochy y su Cocoband',
       type = 'group',
       status = 'published',
       gender = NULL,
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue-orquesta',
       date_of_birth = '1966-09-17',
       birth_year = 1966,
       date_of_death = NULL,
       birth_place = 'Higüey',
       province = 'Distrito Nacional',
       first_name = 'Manuel',
       middle_name = 'Alfonso',
       last_name = 'Vázquez',
       second_last_name = 'Familia',
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = 'https://lacocoband.com',
       youtube = '@pochyfamiliaysucocoband3832',
       facebook = 'pochy.familia',
       instagram = 'pochyfamilia',
       disambiguation = 'Merengue orchestra founded by Pochy Familia; the longest unbroken run of hits in the genre',
       bio_en = 'Pochy y su Cocoband is a Dominican merengue orchestra founded and led by Pochy Familia, who writes and arranges everything it records. Between the end of the eighties and the middle of the nineties it put out an unbroken run of hits that no other Dominican merengue band has matched, and it is still filling rooms four decades on.

**Before the band**

Pochy Familia was writing before he was leading. His first hit, La Negra Pola, was written in 1979 for Cheche Abreu — nearly a decade before the Cocoband existed — and it won him a gold record while he was still very young.

He spent the years that followed as an arranger and composer for other people’s orchestras, among them Los Hermanos Rosario and Richie Ricardo, and worked in the studios of Mateo San Martín and his label Kubaney. That is where the band came from: not from a stage, but from the arranging desk.

**The founding**

He put the Cocoband together in 1988 with other musicians and singers, and what followed is the statistic the genre still quotes. From 1988 to 1995 the group placed close to seventy hits without a break, and across seventeen productions it has more than a hundred. Every single track on the first seven records charted, from the opening cut to the last one.

**Pero con coco**

The sound is güira, tambora and a horn line pushed hard, with lyrics that are funny before they are anything else. Salsa con Coco, La Faldita, La Flaca, El Ombliguito, A Usted Lo Botan, Bala Bala, Los Hombres Feos, Ya Se Me Olvidó Tu Nombre, El Hombre Llegó Parao, De Reversa, La Pinea, Ay Pero Qué Calor, El Cacú, Esperando el 31, El Batecito and La Peliona are the ones the country knows.

The band also kept material back. Los Kenton asked them to release El Negro del Swing, which the Cocoband had shelved, and had a hit with it.

Their audience has a name of its own. Cocoband followers call themselves the Cocotuses.

**35 Años con Coco**

In October 2022 sixteen merengue singers recorded a single song together in tribute to the band, running through sixteen of its hits — all of them written by Pochy Familia. Listín Diario reported it as the first time in Dominican musical history that that many recognised artists of the genre had joined voices to honour one merenguero.

Those who sang on it were Wilfrido Vargas, Jossie Esteban y La Patrulla 15, Milly Quezada, Fernando Villalona, Ramón Orlando & Orquesta Internacional, Miriam Cruz, Toño Rosario, Héctor Acosta “El Torito”, Eddy Herrera, Rafa Rosario, José Peña Suazo y La Banda Gorda, Kinito Méndez, Sergio Vargas, Rubby Pérez and Jandy Ventura, along with Chucky Acosta. The anniversary concert followed that December at the Teatro La Fiesta of the Hotel Jaragua.

**Four decades**

The band has not stopped. Las Mujeres Siempre Ganan came in 2021, Pa’ los Coquitos in 2026, and its 2026 calendar runs through the Hotel Jaragua, the Gran Arena del Cibao, the Gran Teatro Nacional, the amphitheatre at Altos de Chavón and the Hard Rock in Santo Domingo.',
       bio_es = 'Pochy y su Cocoband es una orquesta de merengue dominicana fundada y dirigida por Pochy Familia, que escribe y arregla todo lo que graba. Entre finales de los ochenta y mediados de los noventa sacó una racha ininterrumpida de éxitos que ninguna otra banda de merengue dominicana ha igualado, y sigue llenando salas cuatro décadas después.

**Antes de la banda**

Pochy Familia escribía antes de dirigir. Su primer éxito, La Negra Pola, lo escribió en 1979 para Cheche Abreu —casi una década antes de que existiera la Cocoband— y le valió un disco de oro siendo muy joven.

Los años siguientes los pasó como arreglista y compositor de orquestas ajenas, entre ellas Los Hermanos Rosario y Richie Ricardo, y trabajó en los estudios de Mateo San Martín y su disquera Kubaney. De ahí salió la banda: no de una tarima, sino de la mesa de arreglos.

**La fundación**

Armó la Cocoband en 1988 junto a otros músicos y cantantes, y lo que vino después es la estadística que el género todavía cita. De 1988 a 1995 el grupo colocó cerca de setenta éxitos sin interrupción, y en diecisiete producciones lleva más de cien. De los siete primeros discos pegaron todas las canciones, de la primera a la última.

**Pero con coco**

El sonido es güira, tambora y una línea de metales empujada fuerte, con letras que son graciosas antes que ninguna otra cosa. Salsa con Coco, La Faldita, La Flaca, El Ombliguito, A Usted Lo Botan, Bala Bala, Los Hombres Feos, Ya Se Me Olvidó Tu Nombre, El Hombre Llegó Parao, De Reversa, La Pinea, Ay Pero Qué Calor, El Cacú, Esperando el 31, El Batecito y La Peliona son las que el país se sabe.

La banda guardaba material además. Los Kenton les pidió que liberaran El Negro del Swing, que la Cocoband tenía engavetado, y pegaron con ella.

Su público tiene nombre propio. Los seguidores de la Cocoband se llaman a sí mismos los Cocotuses.

**35 Años con Coco**

En octubre de 2022 dieciséis cantantes de merengue grabaron juntos una sola canción en homenaje a la banda, recorriendo dieciséis de sus éxitos, todos de la autoría de Pochy Familia. Listín Diario lo reportó como la primera vez en la historia musical dominicana que tantos artistas reconocidos del género unen sus voces para homenajear a un merenguero.

Cantaron en ella Wilfrido Vargas, Jossie Esteban y La Patrulla 15, Milly Quezada, Fernando Villalona, Ramón Orlando & Orquesta Internacional, Miriam Cruz, Toño Rosario, Héctor Acosta “El Torito”, Eddy Herrera, Rafa Rosario, José Peña Suazo y La Banda Gorda, Kinito Méndez, Sergio Vargas, Rubby Pérez y Jandy Ventura, además de Chucky Acosta. El concierto de aniversario vino ese diciembre en el Teatro La Fiesta del Hotel Jaragua.

**Cuatro décadas**

La banda no ha parado. Las Mujeres Siempre Ganan salió en 2021, Pa’ los Coquitos en 2026, y su calendario de 2026 recorre el Hotel Jaragua, la Gran Arena del Cibao, el Gran Teatro Nacional, el anfiteatro de Altos de Chavón y el Hard Rock de Santo Domingo.',
       updated_at = now()
 WHERE slug = 'pochy-y-su-cocoband';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Pochy y su Cocoband is a Dominican merengue orchestra founded and led by Pochy Familia, who writes and arranges everything it records. Between the end of the eighties and the middle of the nineties it put out an unbroken run of hits that no other Dominican merengue band has matched, and it is still filling rooms four decades on.","type":"text"}]},{"type":"paragraph","content":[{"text":"Before the band","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Pochy Familia was writing before he was leading. His first hit, La Negra Pola, was written in 1979 for ","type":"text"},{"type":"artistReference","attrs":{"artistId":"73691e65-206a-4c71-9b5f-8689f15b2584","displayText":"Cheche Abreu","occurrenceId":"10d5bbf2-9760-4a19-84ae-34bdd3664f43"}},{"text":" — nearly a decade before the Cocoband existed — and it won him a gold record while he was still very young.","type":"text"}]},{"type":"paragraph","content":[{"text":"He spent the years that followed as an arranger and composer for other people’s orchestras, among them ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario","occurrenceId":"b482f963-a331-4530-a26f-bda6a6031cf3"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4361e223-5102-4fee-be4a-05bea6281807","displayText":"Richie Ricardo","occurrenceId":"b9adcac5-b284-46a5-900d-513278ec4769"}},{"text":", and worked in the studios of Mateo San Martín and his label Kubaney. That is where the band came from: not from a stage, but from the arranging desk.","type":"text"}]},{"type":"paragraph","content":[{"text":"The founding","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He put the Cocoband together in 1988 with other musicians and singers, and what followed is the statistic the genre still quotes. From 1988 to 1995 the group placed close to seventy hits without a break, and across seventeen productions it has more than a hundred. Every single track on the first seven records charted, from the opening cut to the last one.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pero con coco","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The sound is güira, tambora and a horn line pushed hard, with lyrics that are funny before they are anything else. Salsa con Coco, La Faldita, La Flaca, El Ombliguito, A Usted Lo Botan, Bala Bala, Los Hombres Feos, Ya Se Me Olvidó Tu Nombre, El Hombre Llegó Parao, De Reversa, La Pinea, Ay Pero Qué Calor, El Cacú, Esperando el 31, El Batecito and La Peliona are the ones the country knows.","type":"text"}]},{"type":"paragraph","content":[{"text":"The band also kept material back. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"dc89c826-c298-48c8-aa05-50e77d85264a","displayText":"Los Kenton","occurrenceId":"a4f47170-6f7c-4efe-b2c7-c051cdc0615b"}},{"text":" asked them to release El Negro del Swing, which the Cocoband had shelved, and had a hit with it.","type":"text"}]},{"type":"paragraph","content":[{"text":"Their audience has a name of its own. Cocoband followers call themselves the Cocotuses.","type":"text"}]},{"type":"paragraph","content":[{"text":"35 Años con Coco","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In October 2022 sixteen merengue singers recorded a single song together in tribute to the band, running through sixteen of its hits — all of them written by Pochy Familia. Listín Diario reported it as the first time in Dominican musical history that that many recognised artists of the genre had joined voices to honour one merenguero.","type":"text"}]},{"type":"paragraph","content":[{"text":"Those who sang on it were ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"d3e516e8-a430-4438-8800-3af13dd99d29"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"02b306b3-acc0-4800-b314-05683205d1c5","displayText":"Jossie Esteban y La Patrulla 15","occurrenceId":"1942daec-f9d8-4a6f-8d10-ab971e790536"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada","occurrenceId":"b0982b41-4a37-4dd1-8091-d6e17f70eafa"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"1ca8f31f-5481-43c7-b4a5-745e2eaca498"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional","occurrenceId":"df8fb71a-7482-4cfa-bf65-b9e6834ce125"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz","occurrenceId":"aefc36e9-7aff-4ca7-b74a-600e5a8a3f38"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario","occurrenceId":"8dbd2419-d6a5-47de-99c6-24b374030fba"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”","occurrenceId":"e1a6bfd8-9298-4fa2-820c-c49b6e797294"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera","occurrenceId":"1b5fbc40-1981-4918-b141-9bbcfced3e24"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fb033f0-4f8b-4101-a67d-1d445f316dc4","displayText":"Rafa Rosario","occurrenceId":"d5863979-6f73-4f5c-8d19-afcaa8f63755"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"b41d4bd2-9303-4834-885e-e7dee35a0287","displayText":"José Peña Suazo y La Banda Gorda","occurrenceId":"c21936f6-ec38-407c-93a7-68e4b35e02d5"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c73737c2-0106-4a87-8dbe-5f1650d34342","displayText":"Kinito Méndez","occurrenceId":"e84c5062-2bf9-453c-9cb6-bf95eccb814a"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"71b3ae39-874b-4849-b975-b234bcf7a472"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez","occurrenceId":"c751c11c-59c7-42ab-91f2-7abd82ddf01c"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"acb54568-08b4-4f5b-a6b8-5f50f33dfcbe","displayText":"Jandy Ventura","occurrenceId":"c3be4548-000a-4256-a6df-37c0d66a173c"}},{"text":", along with Chucky Acosta. The anniversary concert followed that December at the Teatro La Fiesta of the Hotel Jaragua.","type":"text"}]},{"type":"paragraph","content":[{"text":"Four decades","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The band has not stopped. Las Mujeres Siempre Ganan came in 2021, Pa’ los Coquitos in 2026, and its 2026 calendar runs through the Hotel Jaragua, the Gran Arena del Cibao, the Gran Teatro Nacional, the amphitheatre at Altos de Chavón and the Hard Rock in Santo Domingo.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband'), 2)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Pochy y su Cocoband es una orquesta de merengue dominicana fundada y dirigida por Pochy Familia, que escribe y arregla todo lo que graba. Entre finales de los ochenta y mediados de los noventa sacó una racha ininterrumpida de éxitos que ninguna otra banda de merengue dominicana ha igualado, y sigue llenando salas cuatro décadas después.","type":"text"}]},{"type":"paragraph","content":[{"text":"Antes de la banda","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Pochy Familia escribía antes de dirigir. Su primer éxito, La Negra Pola, lo escribió en 1979 para ","type":"text"},{"type":"artistReference","attrs":{"artistId":"73691e65-206a-4c71-9b5f-8689f15b2584","displayText":"Cheche Abreu","occurrenceId":"285c3d11-a355-4f76-81db-dd26c7654318"}},{"text":" —casi una década antes de que existiera la Cocoband— y le valió un disco de oro siendo muy joven.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los años siguientes los pasó como arreglista y compositor de orquestas ajenas, entre ellas ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario","occurrenceId":"118b9234-ce22-4635-8bb9-f2b4a99d998d"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4361e223-5102-4fee-be4a-05bea6281807","displayText":"Richie Ricardo","occurrenceId":"8d580451-3e58-47ee-88c5-ddeb2128efb7"}},{"text":", y trabajó en los estudios de Mateo San Martín y su disquera Kubaney. De ahí salió la banda: no de una tarima, sino de la mesa de arreglos.","type":"text"}]},{"type":"paragraph","content":[{"text":"La fundación","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Armó la Cocoband en 1988 junto a otros músicos y cantantes, y lo que vino después es la estadística que el género todavía cita. De 1988 a 1995 el grupo colocó cerca de setenta éxitos sin interrupción, y en diecisiete producciones lleva más de cien. De los siete primeros discos pegaron todas las canciones, de la primera a la última.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pero con coco","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El sonido es güira, tambora y una línea de metales empujada fuerte, con letras que son graciosas antes que ninguna otra cosa. Salsa con Coco, La Faldita, La Flaca, El Ombliguito, A Usted Lo Botan, Bala Bala, Los Hombres Feos, Ya Se Me Olvidó Tu Nombre, El Hombre Llegó Parao, De Reversa, La Pinea, Ay Pero Qué Calor, El Cacú, Esperando el 31, El Batecito y La Peliona son las que el país se sabe.","type":"text"}]},{"type":"paragraph","content":[{"text":"La banda guardaba material además. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"dc89c826-c298-48c8-aa05-50e77d85264a","displayText":"Los Kenton","occurrenceId":"819506a0-2cef-44a9-bf1f-484d19b6bf7c"}},{"text":" les pidió que liberaran El Negro del Swing, que la Cocoband tenía engavetado, y pegaron con ella.","type":"text"}]},{"type":"paragraph","content":[{"text":"Su público tiene nombre propio. Los seguidores de la Cocoband se llaman a sí mismos los Cocotuses.","type":"text"}]},{"type":"paragraph","content":[{"text":"35 Años con Coco","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En octubre de 2022 dieciséis cantantes de merengue grabaron juntos una sola canción en homenaje a la banda, recorriendo dieciséis de sus éxitos, todos de la autoría de Pochy Familia. Listín Diario lo reportó como la primera vez en la historia musical dominicana que tantos artistas reconocidos del género unen sus voces para homenajear a un merenguero.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cantaron en ella ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"a55cf1cc-9fb6-4804-ae5a-e98789fee4f9"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"02b306b3-acc0-4800-b314-05683205d1c5","displayText":"Jossie Esteban y La Patrulla 15","occurrenceId":"77aa52ed-ee5e-4c1a-aef8-2fe9e91150e0"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada","occurrenceId":"7bf28248-aff3-42c7-bd1f-1b23e2b5391b"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"722810aa-0bcd-4f88-b3e9-6b0dbbaec60e"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional","occurrenceId":"531b5dde-8aba-44e2-8ae0-78cf5bad61f0"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz","occurrenceId":"696a4515-8fa2-4f82-bfd5-4f8ad161533a"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario","occurrenceId":"c46fdcb0-e04b-413e-856d-da9f561f37a5"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”","occurrenceId":"dcbff506-26cc-4e29-a9ec-4705b03bf11e"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera","occurrenceId":"b2804223-7d1a-48bd-ae75-efe2ec0ae091"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fb033f0-4f8b-4101-a67d-1d445f316dc4","displayText":"Rafa Rosario","occurrenceId":"08f89993-f24d-4af8-9c15-954e0aa19013"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"b41d4bd2-9303-4834-885e-e7dee35a0287","displayText":"José Peña Suazo y La Banda Gorda","occurrenceId":"24afe8d2-055c-43e2-8a1b-f4932b514228"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c73737c2-0106-4a87-8dbe-5f1650d34342","displayText":"Kinito Méndez","occurrenceId":"da58aa3a-0fee-4f28-afea-96d76779b0de"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"da41d174-5a5e-42dc-af2e-3492ebecc648"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez","occurrenceId":"462a58fd-76fa-4fa2-a814-db5e7b7a81e3"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"acb54568-08b4-4f5b-a6b8-5f50f33dfcbe","displayText":"Jandy Ventura","occurrenceId":"ba82dd4c-fd68-4f92-b158-7106b6d1f451"}},{"text":", además de Chucky Acosta. El concierto de aniversario vino ese diciembre en el Teatro La Fiesta del Hotel Jaragua.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cuatro décadas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La banda no ha parado. Las Mujeres Siempre Ganan salió en 2021, Pa’ los Coquitos en 2026, y su calendario de 2026 recorre el Hotel Jaragua, la Gran Arena del Cibao, el Gran Teatro Nacional, el anfiteatro de Altos de Chavón y el Hard Rock de Santo Domingo.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), '10d5bbf2-9760-4a19-84ae-34bdd3664f43', 'artist', '73691e65-206a-4c71-9b5f-8689f15b2584');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), '1942daec-f9d8-4a6f-8d10-ab971e790536', 'artist', '02b306b3-acc0-4800-b314-05683205d1c5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), '1b5fbc40-1981-4918-b141-9bbcfced3e24', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), '1ca8f31f-5481-43c7-b4a5-745e2eaca498', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), '71b3ae39-874b-4849-b975-b234bcf7a472', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), '8dbd2419-d6a5-47de-99c6-24b374030fba', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), 'a4f47170-6f7c-4efe-b2c7-c051cdc0615b', 'artist', 'dc89c826-c298-48c8-aa05-50e77d85264a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), 'aefc36e9-7aff-4ca7-b74a-600e5a8a3f38', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), 'b0982b41-4a37-4dd1-8091-d6e17f70eafa', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), 'b482f963-a331-4530-a26f-bda6a6031cf3', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), 'b9adcac5-b284-46a5-900d-513278ec4769', 'artist', '4361e223-5102-4fee-be4a-05bea6281807');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), 'c21936f6-ec38-407c-93a7-68e4b35e02d5', 'artist', 'b41d4bd2-9303-4834-885e-e7dee35a0287');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), 'c3be4548-000a-4256-a6df-37c0d66a173c', 'artist', 'acb54568-08b4-4f5b-a6b8-5f50f33dfcbe');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), 'c751c11c-59c7-42ab-91f2-7abd82ddf01c', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), 'd3e516e8-a430-4438-8800-3af13dd99d29', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), 'd5863979-6f73-4f5c-8d19-afcaa8f63755', 'artist', '6fb033f0-4f8b-4101-a67d-1d445f316dc4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), 'df8fb71a-7482-4cfa-bf65-b9e6834ce125', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), 'e1a6bfd8-9298-4fa2-820c-c49b6e797294', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'en'), 'e84c5062-2bf9-453c-9cb6-bf95eccb814a', 'artist', 'c73737c2-0106-4a87-8dbe-5f1650d34342');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), '08f89993-f24d-4af8-9c15-954e0aa19013', 'artist', '6fb033f0-4f8b-4101-a67d-1d445f316dc4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), '118b9234-ce22-4635-8bb9-f2b4a99d998d', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), '24afe8d2-055c-43e2-8a1b-f4932b514228', 'artist', 'b41d4bd2-9303-4834-885e-e7dee35a0287');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), '285c3d11-a355-4f76-81db-dd26c7654318', 'artist', '73691e65-206a-4c71-9b5f-8689f15b2584');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), '462a58fd-76fa-4fa2-a814-db5e7b7a81e3', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), '531b5dde-8aba-44e2-8ae0-78cf5bad61f0', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), '696a4515-8fa2-4f82-bfd5-4f8ad161533a', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), '722810aa-0bcd-4f88-b3e9-6b0dbbaec60e', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), '77aa52ed-ee5e-4c1a-aef8-2fe9e91150e0', 'artist', '02b306b3-acc0-4800-b314-05683205d1c5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), '7bf28248-aff3-42c7-bd1f-1b23e2b5391b', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), '819506a0-2cef-44a9-bf1f-484d19b6bf7c', 'artist', 'dc89c826-c298-48c8-aa05-50e77d85264a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), '8d580451-3e58-47ee-88c5-ddeb2128efb7', 'artist', '4361e223-5102-4fee-be4a-05bea6281807');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), 'a55cf1cc-9fb6-4804-ae5a-e98789fee4f9', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), 'b2804223-7d1a-48bd-ae75-efe2ec0ae091', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), 'ba82dd4c-fd68-4f92-b158-7106b6d1f451', 'artist', 'acb54568-08b4-4f5b-a6b8-5f50f33dfcbe');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), 'c46fdcb0-e04b-413e-856d-da9f561f37a5', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), 'da41d174-5a5e-42dc-af2e-3492ebecc648', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), 'da58aa3a-0fee-4f28-afea-96d76779b0de', 'artist', 'c73737c2-0106-4a87-8dbe-5f1650d34342');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'pochy-y-su-cocoband') AND locale = 'es'), 'dcbff506-26cc-4e29-a9ec-4705b03bf11e', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d');

COMMIT;
