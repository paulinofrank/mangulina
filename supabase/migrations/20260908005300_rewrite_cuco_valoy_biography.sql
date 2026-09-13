BEGIN;

-- Rewrite the catalogue entry for Cuco Valoy.
--
-- Cuco Valoy. OCTAVA de las 211, con 14 enlaces entrantes. Y la ficha vieja
-- tenía UN ERROR QUE MEZCLA DOS BANDAS Y DOS DÉCADAS.
--
-- DECÍA: "In the 1960s, he and his brother Martín formed LOS VIRTUOSOS, an
-- ensemble that became one of the most celebrated acts on the Dominican popular
-- music circuit."
--
-- Está mal por partida doble:
--
--   Con su hermano MARTÍN VALOY formó un dúo que a mediados de los sesenta pasó
--   a llamarse LOS AHIJADOS, cantando sones montunos en la línea de Los
--   Compadres de Cuba. Cuco era voz principal y guitarra segunda; Martín, la
--   voz solista. Ese dúo va de los cincuenta a finales de los sesenta.
--
--   LOS VIRTUOSOS es OTRA COSA Y DE OTRA DÉCADA: lo formó en los SETENTA, con
--   trece integrantes, y en él metió A SU HIJO RAMÓN ORLANDO. La ficha no
--   mencionaba a su hijo ni una vez.
--
-- Las dos entidades tienen fila propia en el catálogo -- los-ahijados y
-- martin-valoy están publicados -- así que el error además desperdiciaba dos
-- enlaces que estaban ahí para tomarse.
--
-- EL NOMBRE DE LA FILA ESTABA BIEN Y ME SORPRENDIÓ. first_name dice 'Pupo', que
-- parece un apodo. NO LO ES: Wikipedia da como nombre de nacimiento "PUPO VALOY
-- REYNOSO". La fila estaba correcta y no se toca.
--
-- DE DÓNDE SALEN LOS DOS NOMBRES DE ORQUESTA, que es lo mejor de la ficha y no
-- estaba:
--
--   "LOS VIRTUOSOS" sale del título de un LIBRO DE PIANO que Valoy usaba para
--   darle clases a Ramón Orlando.
--
--   "LA TRIBU" sale de una broma. En una gira por Panamá un aficionado le dijo
--   que la orquesta parecía una tribu por el color de piel de sus integrantes.
--   A Valoy le gustó el concepto, empezó a usarlo, y terminó siendo el nombre
--   oficial.
--
-- LO DEMÁS QUE FALTABA: las canciones -- El Brujo, Juliana, Nació Varón, Pasito
-- Colombiano, Los Frutos del Carnaval, No Me Empuje --, que es
-- multiinstrumentista (guitarra, piano, bajo y tambora), que estudió teoría en
-- el Conservatorio Nacional, y TRES PREMIOS MAYORES, incluido EL GRAN SOBERANO
-- DE 2017 y el Premio a la Excelencia Musical del Latin Grammy del mismo año.
--
-- CONFLICTO INTERNO DE LA FUENTE QUE NO RESUELVO: el texto dice que ganó el
-- Congo de Oro "por cuatro veces consecutivas" y la tabla del mismo artículo
-- lista TRES, en 1981, 1983 y 2015, que además no son consecutivas. Escribo
-- "varias veces" y registro las tres que la tabla fecha, que es lo único
-- verificable.
--
-- SEIS ENLACES, todos por crédito o parentesco documentado: los-ahijados y
-- martin-valoy (el dúo), ramon-orlando (su hijo, y el músico que metió en Los
-- Virtuosos), alberto-beltran (el disco de 1984 "Cuco y Ramón Orlando Valoy
-- Presentan a Alberto Beltrán"), y johnny-ventura y johnny-pacheco, con quienes
-- la fuente lo lista compartiendo escenario.
--
-- LOS PARENTESCOS YA ESTABAN TODOS REGISTRADOS y no hay nada que hacer: Cuco
-- 'parent' de Ramón Orlando y de Cristopher Valoy, 'grandparent' de Jura Valoy,
-- y 'sibling' con Martín. Es la primera ficha de la corrida donde la tabla de
-- familia estaba completa antes de que yo llegara.
--
-- aliases estaba VACÍO. Entra "El Brujo", que es a la vez su canción de 1976 y
-- como lo llama la prensa dominicana.
--
-- instruments estaba VACÍO para un hombre que toca cuatro instrumentos.
--
-- LO QUE SE DEJA FUERA: su dirección en San Carlos, que la fuente da con calle
-- y número.
--
-- genres dice 'folklore-son-dominicano' Y SE REPORTA. Su son es CUBANO -- Los
-- Ahijados imitaban a Los Compadres de Cuba -- y su orquesta tocaba merengue,
-- salsa, bachata, cumbia, bolero, guaracha y cha-cha-chá. Es decisión de género.
--
-- FUENTES: Wikipedia en español, bien referenciada en su caso, con citas a
-- Diario Libre, Listín Diario y 7 Días. Existe además una biografía autorizada
-- escrita por José Díaz (2021), que no consulté y queda anotada como la fuente
-- a la que ir si esta ficha se amplía.
--
-- NOMBRE NUEVO PARA LA LISTA: LOS VIRTUOSOS, la orquesta de los setenta, que no
-- tiene ficha propia pese a que Los Ahijados sí la tiene.
-- REVISION EN EL MISMO DIA. nombres-sin-enlazar.cjs pesco que el parrafo de
-- premios nombraba a WILFRIDO VARGAS y a JUAN LUIS GUERRA en texto plano,
-- estando los dos publicados. El detector solo vio a Wilfrido: a Guerra no lo
-- vio porque la fila se llama "Juan Luis Guerra 4.40" y el texto decia "Juan
-- Luis Guerra" a secas. Otra limitacion del detector que conviene tener
-- presente: no encuentra nombres que en el catalogo llevan sufijo de orquesta.
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
       name = 'Cuco Valoy',
       sort_name = 'Valoy Reynoso, Pupo',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1937-01-06',
       birth_year = 1937,
       date_of_death = NULL,
       birth_place = 'Manoguayabo',
       province = 'Santo Domingo',
       first_name = 'Pupo',
       middle_name = NULL,
       last_name = 'Valoy',
       second_last_name = 'Reynoso',
       stage_name = NULL,
       aliases = ARRAY['El Brujo']::text[],
       occupations = '["composer","guitarist","bandleader"]'::jsonb,
       instruments = ARRAY['guitar', 'piano', 'bass', 'tambora', 'voice']::text[],
       genres = ARRAY['folklore-son-dominicano']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@CucoValoyoficial',
       facebook = 'CucoValoyLaTribu',
       instagram = 'cucovaloyoficial',
       disambiguation = 'Singer and bandleader called El Brujo; took Cuban son into Dominican music and led La Tribu',
       bio_en = 'Pupo Valoy Reynoso, known as Cuco Valoy and called El Brujo, is a Dominican singer, composer and bandleader. He has been working since 1955, first singing Cuban son in a duo with his brother and then at the head of an orchestra that could play anything, and he is among the musicians usually credited with modernising Dominican tropical music.

**Manoguayabo**

He was born in 1937 in Manoguayabo, on the edge of Santo Domingo, and studied music theory at the National Conservatory. He plays guitar, piano and bass, and he is a percussionist as well, working the tambora that sits at the centre of merengue. That range is what later let his orchestra move between genres without changing personnel.

**Los Ahijados**

He started out singing serenades and the hits of the day in a duo with his younger brother Martín Valoy. In the middle of the sixties he changed the repertoire to sones montunos and the duo took the name Los Ahijados, in deliberate answer to Cuba’s Los Compadres. Cuco sang lead and played second guitar; Martín took the solo voice. They worked that Afro-Cuban material until the end of the decade.

**Los Virtuosos**

In the seventies he built an orchestra of thirteen players and called it Los Virtuosos, taking the name from the title of a piano book he was using to teach his son Ramón Orlando & Orquesta Internacional. The son joined the band, and what followed came out of the combination: the father’s voice and knowledge of the older forms against the son’s modern arranging.

The group played merengue, bachata, salsa, cumbia, son montuno, bolero, guaracha and cha-cha-chá, and it travelled — Colombia took to it especially. In 1984 father and son produced a record together for Alberto Beltrán.

**La Tribu**

The orchestra got its lasting name on tour in Panama, where a member of the audience joked that the band looked like a tribe because of the colour of its players. Valoy liked the idea, started using it, and before long the orchestra was officially La Tribu.

**El Brujo**

The songs that carried him are El Brujo, Juliana, Nació Varón, Pasito Colombiano, Los Frutos del Carnaval and No Me Empuje, and the discography behind them runs to dozens of records from Páginas Gloriosas de Mi Patria in 1965 onward. He has shared stages with Machito, Celia Cruz, Oscar D’León, Johnny Ventura and Johnny Pacheco.

**The honours**

Colombia has given him the Congo de Oro at the Barranquilla carnival several times, in the salsa category and, decades later, as king of the people. In 2017 Acroarte gave him the Gran Soberano, its highest award, putting him alongside Johnny Ventura, Juan Luis Guerra 4.40, Wilfrido Vargas and Johnny Pacheco; the Latin Recording Academy gave him its Musical Excellence Award the same year.',
       bio_es = 'Pupo Valoy Reynoso, conocido como Cuco Valoy y llamado El Brujo, es un cantante, compositor y director de orquesta dominicano. Trabaja desde 1955, primero cantando son cubano en dúo con su hermano y después al frente de una orquesta capaz de tocar cualquier cosa, y está entre los músicos a los que se acredita la modernización de la música tropical dominicana.

**Manoguayabo**

Nació en 1937 en Manoguayabo, a las afueras de Santo Domingo, y estudió teoría musical en el Conservatorio Nacional. Toca guitarra, piano y bajo, y es además percusionista, con la tambora que está en el centro del merengue. Ese registro es lo que después le permitió a su orquesta moverse entre géneros sin cambiar de músicos.

**Los Ahijados**

Empezó cantando serenatas y los éxitos del momento en dúo con su hermano menor Martín Valoy. A mediados de los sesenta cambió el repertorio a sones montunos y el dúo tomó el nombre de Los Ahijados, en respuesta deliberada a Los Compadres de Cuba. Cuco cantaba la voz principal y hacía la guitarra segunda; Martín llevaba la solista. Trabajaron ese material afrocubano hasta el final de la década.

**Los Virtuosos**

En los setenta armó una orquesta de trece músicos y la llamó Los Virtuosos, tomando el nombre del título de un libro de piano con el que le daba clases a su hijo Ramón Orlando & Orquesta Internacional. El hijo entró a la banda, y lo que vino después salió de esa combinación: la voz y el conocimiento de las formas viejas del padre contra el arreglo moderno del hijo.

El grupo tocaba merengue, bachata, salsa, cumbia, son montuno, bolero, guaracha y cha-cha-chá, y viajó: Colombia lo hizo suyo de manera especial. En 1984 padre e hijo produjeron juntos un disco para Alberto Beltrán.

**La Tribu**

La orquesta consiguió el nombre que le quedó en una gira por Panamá, donde alguien del público bromeó diciendo que la banda parecía una tribu por el color de sus integrantes. A Valoy le gustó la idea, empezó a usarla, y al poco tiempo la orquesta se llamaba oficialmente La Tribu.

**El Brujo**

Las canciones que lo sostienen son El Brujo, Juliana, Nació Varón, Pasito Colombiano, Los Frutos del Carnaval y No Me Empuje, y detrás hay una discografía de decenas de discos desde Páginas Gloriosas de Mi Patria, de 1965. Ha compartido tarima con Machito, Celia Cruz, Oscar D’León, Johnny Ventura y Johnny Pacheco.

**Los reconocimientos**

Colombia le ha dado el Congo de Oro del carnaval de Barranquilla varias veces, en la categoría de salsa y, décadas después, como rey del pueblo. En 2017 Acroarte le entregó el Gran Soberano, su máximo galardón, poniéndolo junto a Johnny Ventura, Juan Luis Guerra 4.40, Wilfrido Vargas y Johnny Pacheco; ese mismo año la Academia Latina de la Grabación le dio su Premio a la Excelencia Musical.',
       updated_at = now()
 WHERE slug = 'cuco-valoy';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Pupo Valoy Reynoso, known as Cuco Valoy and called El Brujo, is a Dominican singer, composer and bandleader. He has been working since 1955, first singing Cuban son in a duo with his brother and then at the head of an orchestra that could play anything, and he is among the musicians usually credited with modernising Dominican tropical music.","type":"text"}]},{"type":"paragraph","content":[{"text":"Manoguayabo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1937 in Manoguayabo, on the edge of Santo Domingo, and studied music theory at the National Conservatory. He plays guitar, piano and bass, and he is a percussionist as well, working the tambora that sits at the centre of merengue. That range is what later let his orchestra move between genres without changing personnel.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Ahijados","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He started out singing serenades and the hits of the day in a duo with his younger brother ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6eccc3e7-82bf-435f-8ae1-ea7e8a721560","displayText":"Martín Valoy","occurrenceId":"fd503f93-3d49-482c-a37f-8663d57a1980"}},{"text":". In the middle of the sixties he changed the repertoire to sones montunos and the duo took the name ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f6f95f0f-e008-47b9-8b4c-10fe5508bfd9","displayText":"Los Ahijados","occurrenceId":"dc70fcb9-e53e-42e7-bb8e-a01a2aed6a38"}},{"text":", in deliberate answer to Cuba’s Los Compadres. Cuco sang lead and played second guitar; Martín took the solo voice. They worked that Afro-Cuban material until the end of the decade.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Virtuosos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In the seventies he built an orchestra of thirteen players and called it Los Virtuosos, taking the name from the title of a piano book he was using to teach his son ","type":"text"},{"type":"artistReference","attrs":{"artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional","occurrenceId":"8ece04d9-dafa-4592-95c8-399cd2577591"}},{"text":". The son joined the band, and what followed came out of the combination: the father’s voice and knowledge of the older forms against the son’s modern arranging.","type":"text"}]},{"type":"paragraph","content":[{"text":"The group played merengue, bachata, salsa, cumbia, son montuno, bolero, guaracha and cha-cha-chá, and it travelled — Colombia took to it especially. In 1984 father and son produced a record together for ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1410b448-6357-4895-a32a-58708697e10d","displayText":"Alberto Beltrán","occurrenceId":"4e4b87ea-4727-4154-a935-c37e388809c6"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"La Tribu","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The orchestra got its lasting name on tour in Panama, where a member of the audience joked that the band looked like a tribe because of the colour of its players. Valoy liked the idea, started using it, and before long the orchestra was officially La Tribu.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Brujo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The songs that carried him are El Brujo, Juliana, Nació Varón, Pasito Colombiano, Los Frutos del Carnaval and No Me Empuje, and the discography behind them runs to dozens of records from Páginas Gloriosas de Mi Patria in 1965 onward. He has shared stages with Machito, Celia Cruz, Oscar D’León, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"8253a74e-d36d-4cae-a1f3-bddfe901dbab"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e005898c-4fcc-45da-b857-c6775e92fa52","displayText":"Johnny Pacheco","occurrenceId":"67229274-b423-4c02-88c5-e2ff41bb3ec6"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"The honours","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Colombia has given him the Congo de Oro at the Barranquilla carnival several times, in the salsa category and, decades later, as king of the people. In 2017 Acroarte gave him the Gran Soberano, its highest award, putting him alongside ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"c7eaccea-42ba-4e33-8ba2-d81956b1967e"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40","occurrenceId":"b4248ec2-222a-4c86-940e-963f8d257453"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"6cde7e15-b2cb-4e8c-964b-bbbfc6382483"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e005898c-4fcc-45da-b857-c6775e92fa52","displayText":"Johnny Pacheco","occurrenceId":"7cd314ad-fd2b-4c5d-b695-322aace8087e"}},{"text":"; the Latin Recording Academy gave him its Musical Excellence Award the same year.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'cuco-valoy'), 3)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Pupo Valoy Reynoso, conocido como Cuco Valoy y llamado El Brujo, es un cantante, compositor y director de orquesta dominicano. Trabaja desde 1955, primero cantando son cubano en dúo con su hermano y después al frente de una orquesta capaz de tocar cualquier cosa, y está entre los músicos a los que se acredita la modernización de la música tropical dominicana.","type":"text"}]},{"type":"paragraph","content":[{"text":"Manoguayabo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1937 en Manoguayabo, a las afueras de Santo Domingo, y estudió teoría musical en el Conservatorio Nacional. Toca guitarra, piano y bajo, y es además percusionista, con la tambora que está en el centro del merengue. Ese registro es lo que después le permitió a su orquesta moverse entre géneros sin cambiar de músicos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Ahijados","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Empezó cantando serenatas y los éxitos del momento en dúo con su hermano menor ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6eccc3e7-82bf-435f-8ae1-ea7e8a721560","displayText":"Martín Valoy","occurrenceId":"751d72bb-ab69-4676-b666-b37b3dd24e1d"}},{"text":". A mediados de los sesenta cambió el repertorio a sones montunos y el dúo tomó el nombre de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f6f95f0f-e008-47b9-8b4c-10fe5508bfd9","displayText":"Los Ahijados","occurrenceId":"08bc4613-6954-4e8c-bf74-d9a62614a3d2"}},{"text":", en respuesta deliberada a Los Compadres de Cuba. Cuco cantaba la voz principal y hacía la guitarra segunda; Martín llevaba la solista. Trabajaron ese material afrocubano hasta el final de la década.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Virtuosos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En los setenta armó una orquesta de trece músicos y la llamó Los Virtuosos, tomando el nombre del título de un libro de piano con el que le daba clases a su hijo ","type":"text"},{"type":"artistReference","attrs":{"artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional","occurrenceId":"c29e8820-236a-4d22-8d01-8923f4673774"}},{"text":". El hijo entró a la banda, y lo que vino después salió de esa combinación: la voz y el conocimiento de las formas viejas del padre contra el arreglo moderno del hijo.","type":"text"}]},{"type":"paragraph","content":[{"text":"El grupo tocaba merengue, bachata, salsa, cumbia, son montuno, bolero, guaracha y cha-cha-chá, y viajó: Colombia lo hizo suyo de manera especial. En 1984 padre e hijo produjeron juntos un disco para ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1410b448-6357-4895-a32a-58708697e10d","displayText":"Alberto Beltrán","occurrenceId":"d4204637-5d65-4754-9bed-3eb4e425e4cf"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"La Tribu","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La orquesta consiguió el nombre que le quedó en una gira por Panamá, donde alguien del público bromeó diciendo que la banda parecía una tribu por el color de sus integrantes. A Valoy le gustó la idea, empezó a usarla, y al poco tiempo la orquesta se llamaba oficialmente La Tribu.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Brujo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Las canciones que lo sostienen son El Brujo, Juliana, Nació Varón, Pasito Colombiano, Los Frutos del Carnaval y No Me Empuje, y detrás hay una discografía de decenas de discos desde Páginas Gloriosas de Mi Patria, de 1965. Ha compartido tarima con Machito, Celia Cruz, Oscar D’León, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"7f6de48a-4f71-4a4e-a29a-d76b933b7e9e"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e005898c-4fcc-45da-b857-c6775e92fa52","displayText":"Johnny Pacheco","occurrenceId":"a28d83e4-1516-405c-8b0b-8a8f9dda91b2"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Los reconocimientos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Colombia le ha dado el Congo de Oro del carnaval de Barranquilla varias veces, en la categoría de salsa y, décadas después, como rey del pueblo. En 2017 Acroarte le entregó el Gran Soberano, su máximo galardón, poniéndolo junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"e18f4252-be9e-4488-bccc-679d41f2107e"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40","occurrenceId":"3c862317-5a6c-4277-a18c-e461c0c1e5cb"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"c6d8658b-1c1c-4ead-8c3d-f22c86ee41a5"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e005898c-4fcc-45da-b857-c6775e92fa52","displayText":"Johnny Pacheco","occurrenceId":"b7f05aad-20ca-45c2-a4b7-a25bf999d1e2"}},{"text":"; ese mismo año la Academia Latina de la Grabación le dio su Premio a la Excelencia Musical.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'cuco-valoy'), 2)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'en'), '4e4b87ea-4727-4154-a935-c37e388809c6', 'artist', '1410b448-6357-4895-a32a-58708697e10d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'en'), '67229274-b423-4c02-88c5-e2ff41bb3ec6', 'artist', 'e005898c-4fcc-45da-b857-c6775e92fa52');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'en'), '6cde7e15-b2cb-4e8c-964b-bbbfc6382483', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'en'), '7cd314ad-fd2b-4c5d-b695-322aace8087e', 'artist', 'e005898c-4fcc-45da-b857-c6775e92fa52');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'en'), '8253a74e-d36d-4cae-a1f3-bddfe901dbab', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'en'), '8ece04d9-dafa-4592-95c8-399cd2577591', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'en'), 'b4248ec2-222a-4c86-940e-963f8d257453', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'en'), 'c7eaccea-42ba-4e33-8ba2-d81956b1967e', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'en'), 'dc70fcb9-e53e-42e7-bb8e-a01a2aed6a38', 'artist', 'f6f95f0f-e008-47b9-8b4c-10fe5508bfd9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'en'), 'fd503f93-3d49-482c-a37f-8663d57a1980', 'artist', '6eccc3e7-82bf-435f-8ae1-ea7e8a721560');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'es'), '08bc4613-6954-4e8c-bf74-d9a62614a3d2', 'artist', 'f6f95f0f-e008-47b9-8b4c-10fe5508bfd9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'es'), '3c862317-5a6c-4277-a18c-e461c0c1e5cb', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'es'), '751d72bb-ab69-4676-b666-b37b3dd24e1d', 'artist', '6eccc3e7-82bf-435f-8ae1-ea7e8a721560');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'es'), '7f6de48a-4f71-4a4e-a29a-d76b933b7e9e', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'es'), 'a28d83e4-1516-405c-8b0b-8a8f9dda91b2', 'artist', 'e005898c-4fcc-45da-b857-c6775e92fa52');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'es'), 'b7f05aad-20ca-45c2-a4b7-a25bf999d1e2', 'artist', 'e005898c-4fcc-45da-b857-c6775e92fa52');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'es'), 'c29e8820-236a-4d22-8d01-8923f4673774', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'es'), 'c6d8658b-1c1c-4ead-8c3d-f22c86ee41a5', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'es'), 'd4204637-5d65-4754-9bed-3eb4e425e4cf', 'artist', '1410b448-6357-4895-a32a-58708697e10d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuco-valoy') AND locale = 'es'), 'e18f4252-be9e-4488-bccc-679d41f2107e', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

COMMIT;
