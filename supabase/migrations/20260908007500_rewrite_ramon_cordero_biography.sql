BEGIN;

-- Rewrite the catalogue entry for Ramón Cordero.
--
-- Ramón Cordero. DECIMOSÉPTIMA de las 211. 892 caracteres en UN SOLO PÁRRAFO
-- que no dice absolutamente nada.
--
-- Texto completo de lo que había: "Ramón Cordero was a Dominican musician with
-- roots in Moca... whose work has contributed to the popular music tradition of
-- the Dominican Republic's northern interior. Moca's cultural life has produced
-- a number of significant Dominican artists... His career as a musician
-- reflected the commitment to the craft of popular performance that sustains
-- Dominican music across the country's diverse communities, from the capital to
-- the smallest provincial towns."
--
-- NO DICE QUÉ CANTABA. Es una plantilla con un nombre y una provincia dentro.
--
-- ---------------------------------------------------------------------------
-- TRES DATOS DE LA FILA QUE LAS FUENTES CONTRADICEN, Y NO TOCO NINGUNO
--
-- 1. primary_genre = 'merengue'. Es un BACHATERO, y de los fundadores. Todas
--    las fuentes lo llaman así y los cinco enlaces entrantes que tiene son de
--    gente de bachata.
--
--    PERO EL VALOR NO ES ABSURDO Y CONVIENE SABERLO: grabó discos de merengue
--    de verdad -- "Merengues" (1977), "Merengues al Estilo" (1989) y dos
--    volúmenes recopilatorios de merengues. Alguien pudo fichar el género por
--    ahí. Aun así, como género PRINCIPAL está mal.
--
--    LA REGLA DICE QUE EL GÉNERO LO DECIDE EL EDITOR. No lo cambio. Queda
--    reportado, que es lo único que me toca.
--
-- 2. birth_place = 'Moca', province = 'Espaillat'. TRES fuentes dicen SAN
--    FRANCISCO DE MACORÍS -- iASO Records, Bachata Republic y Artístico RD -- y
--    NINGUNA dice Moca. iASO añade que se crió en el campo de San Felipe, cerca
--    de San Francisco de Macorís, junto a Edilio Paredes.
--
-- 3. La FECHA. La fila da 26 de abril de 1940; las tres fuentes dan 26 de abril
--    de 1939. Coinciden en el día y el mes. Bachata Republic se contradice sola:
--    dice 1939 y también que murió "a los 76 años", que sale de 1940.
--
-- LOS DOS ÚLTIMOS LOS DEJO IGUAL Y EL TEXTO NO DA NI EL AÑO NI EL PUEBLO DE
-- NACIMIENTO. Hoy me contuve dos veces con conflictos de este tipo -- el Cotuí
-- de Joe Veras y el San Francisco de Macorís de Edilio Paredes -- y las dos
-- veces la fila tenía razón. La prosa dice que se crió en el campo cerca de San
-- Francisco de Macorís, que es lo que la fuente afirma sobre su crianza y no
-- sobre su nacimiento, y por tanto es cierto se resuelva como se resuelva.
-- ---------------------------------------------------------------------------
--
-- EL NOMBRE LEGAL Y EL APODO NO ESTABAN. Se llamaba JOSÉ RAMÓN CORDERO y le
-- decían "EL ESCUDO", o "El Escudo del Amargue". La fila no tenía ni campos de
-- nombre ni alias.
--
-- LO QUE FALTABA, QUE ES TODO:
--
--   SE CRIÓ CON EDILIO PAREDES. Amigos de infancia y después compadres,
--   cantaban y tocaban juntos en el campo. Cuando Paredes se fue a la capital,
--   Cordero lo siguió. Escribí la ficha de Paredes hace un rato y las dos se
--   completan.
--
--   "YO LA RECUERDO" (1966), a dúo con Paredes, en el sello de CUCO VALOY.
--
--   MÉXICO PASADO POR UNA GUITARRA DOMINICANA, que es su aportación propia:
--   ANTONIO AGUILAR y PEDRO INFANTE lo marcaron, grabó muchas canciones suyas
--   como bachatas y a veces CONSERVÓ EL COMPÁS DE 2/4 o 3/4 DE LA RANCHERA
--   añadiéndole el acompañamiento percusivo de guitarra de la bachata. También
--   grabó música jíbara puertorriqueña y baladas.
--
--   LOS TEMAS DE LOS SETENTA CON PAREDES en la primera guitarra: "Vuela
--   paloma", "Entre copa y copa", "Las nieves de enero".
--
--   "AMOR DEL BUENO" (1974), su himno, y la carta de presentación de Paredes
--   como guitarrista.
--
--   SU REPERTORIO ES DE LOS MÁS DIFÍCILES DE TOCAR DEL GÉNERO, por los arreglos
--   de Paredes, y por eso pasaron por su grupo los mejores guitarristas del
--   país: AUGUSTO SANTOS, FRANK MÉNDEZ, VIRGILIO DE LA CRUZ y MÁRTIRES DE LEÓN.
--   Con Augusto Santos formó el dúo LOS INIMITABLES.
--
--   FUE DIRECTOR VOCAL de los estudios ENCA y ENFI en Santo Domingo, y MONCHY &
--   ALEXANDRA son el ejemplo que da la fuente de ese trabajo suyo. Es el dato
--   más inesperado de la ficha.
--
--   THE BACHATA LEGENDS, la banda que armó con EL CHIVO SIN LEY, EDILIO PAREDES
--   y JOAN SORIANO para internacionalizar la bachata acústica clásica. Disco en
--   2011 y giras por Estados Unidos y Europa.
--
-- LA MUERTE ENTRA Y LA CAUSA NO. Murió el 19 de enero de 2017. Las fuentes dan
-- el diagnóstico; no se escribe.
--
-- CONTRADICCIÓN ENTRE DOS PÁGINAS DEL MISMO AUTOR, que anoto y esquivo: la
-- biografía de Edilio Paredes en iASO dice que CASA ALEGRE era la tienda de
-- música de Cuco Valoy; la de Ramón Cordero en el mismo sitio dice que Casa
-- Alegre era el sello de Bienvenido Ortiz y que la tienda de Valoy se llamaba
-- CMV Records. No sé cuál es la buena, así que la prosa dice que grabó para el
-- sello de Cuco Valoy sin ponerle nombre a la tienda.
--
-- SEIS ENLACES, todos por crédito documentado.
--
-- FUENTES: iASO Records, biografía por David Wayne, que es la que tiene los
-- detalles técnicos. Bachata Republic (19 de noviembre de 2021), para el nombre
-- legal, el apodo y la discografía. Diario Libre y El Nuevo Diario del 19 y 20
-- de enero de 2017 para la muerte. NO HAY ARTÍCULO DE WIKIPEDIA en ningún
-- idioma.
--
-- AUSENCIAS NUEVAS: AUGUSTO SANTOS, FRANK MÉNDEZ, VIRGILIO DE LA CRUZ,
-- BIENVENIDO ORTIZ y EL CHIVO SIN LEY, más los grupos LOS INIMITABLES y THE
-- BACHATA LEGENDS. Los cinco primeros a MUSICOS_PENDIENTES.
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
       name = 'Ramón Cordero',
       sort_name = 'Cordero, Ramón',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1940-04-26',
       birth_year = 1940,
       date_of_death = '2017-01-19',
       birth_place = 'Moca',
       province = 'Espaillat',
       first_name = 'José',
       middle_name = 'Ramón',
       last_name = 'Cordero',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY['El Escudo', 'El Escudo del Amargue']::text[],
       occupations = '["composer","guitarist"]'::jsonb,
       instruments = ARRAY['voice', 'guitar']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = 'RamonCorderoBachata',
       instagram = 'ramon_cordero_05',
       disambiguation = 'Founding bachata singer known as El Escudo; his recordings define the acoustic style',
       bio_en = 'José Ramón Cordero, known throughout his career as El Escudo, was one of the founding voices of bachata. His high, plaintive delivery is among the most recognisable the genre has, and his records are among the hardest in it to play, because the arrangements behind them were written by Edilio Paredes. He died on 19 January 2017.

**The campo and the capital**

He grew up in the countryside near San Francisco de Macorís, and the friend he grew up singing and playing with was Paredes, who lived nearby and later became his compadre. The two of them worked through their own songs and other people’s at country parties. When Paredes left for Santo Domingo, Cordero followed him there.

His first real success came in 1966 with Yo la recuerdo, which the two of them sang as a duo and recorded for the label belonging to Cuco Valoy. He released a run of records with the Casa Alegre label around the same period.

**Mexico through a Dominican guitar**

What he brought to bachata came partly from somewhere else. Antonio Aguilar and Pedro Infante shaped his singing, and he recorded a great many Mexican songs as bachatas. Sometimes he went further and kept the ranchera in its original two-four or three-four time instead of the four-four the genre normally used, laying bachata’s percussive guitar over it. He drew on Puerto Rican jíbaro music as well, and on baladas such as Condenado a la distancia.

The songs he cut in the seventies with Paredes on lead guitar — Vuela paloma, Entre copa y copa, Las nieves de enero — stayed at the centre of his repertoire for the rest of his life. Amor del bueno, from 1974, became his anthem, and it is also the record by which Paredes is known as a guitarist.

**The hardest repertoire in the genre**

Because Paredes wrote such demanding arrangements, only the best players could accompany him, and a succession of the country’s finest guitarists passed through his group: Augusto Santos, Frank Méndez, Virgilio de la Cruz and Mártires de León. With Augusto Santos he also formed a singing duo, Los Inimitables, which produced Con golpes de pecho and Negra ¿por qué me dejaste?; Santos played the lead guitar on the 1967 single La causa de mi muerte.

**After the electric guitar**

Bachata changed when Blas Durán brought the electric guitar into it in 1987. A younger generation went on to an international reach their predecessors had never had, while players who stayed with acoustic instruments, Cordero among them, went on performing largely for audiences at home.

What brought his work back into view in the nineties was other musicians. Mártires de León, by then a master of the modern electric style, recorded the lead guitar on Manantial de amor, which sold strongly.

**Vocal director**

His ear and his sense of pitch got him work behind the glass as well, as a vocal director for the ENCA and ENFI studios in Santo Domingo. Monchy & Alexandra are the example usually given of what that work produced.

**The Bachata Legends**

In his last years he set out to revive classic acoustic bachata and take it abroad. With El Chivo Sin Ley, Edilio Paredes and Joan Soriano he formed the band The Bachata Legends, which released an album in 2011 and toured the United States and Europe.',
       bio_es = 'José Ramón Cordero, conocido durante toda su carrera como El Escudo, fue una de las voces fundadoras de la bachata. Su manera de cantar, aguda y quejumbrosa, es de las más reconocibles del género, y sus discos están entre los más difíciles de tocar, porque los arreglos que los sostienen los escribió Edilio Paredes. Murió el 19 de enero de 2017.

**El campo y la capital**

Se crió en el campo cerca de San Francisco de Macorís, y el amigo con el que cantaba y tocaba de niño era Paredes, que vivía cerca y con el tiempo fue su compadre. Los dos se hacían las canciones propias y las ajenas en las fiestas de la zona. Cuando Paredes se fue a Santo Domingo, Cordero lo siguió.

Su primer éxito de verdad llegó en 1966 con Yo la recuerdo, que cantaron a dúo y grabaron para el sello de Cuco Valoy. Por esos mismos años publicó una tanda de discos con el sello Casa Alegre.

**México pasado por una guitarra dominicana**

Lo que aportó a la bachata venía en parte de fuera. Antonio Aguilar y Pedro Infante le marcaron la manera de cantar, y grabó muchísimas canciones mexicanas convertidas en bachatas. A veces iba más lejos y mantenía la ranchera en su compás original de dos por cuatro o tres por cuatro, en lugar del cuatro por cuatro habitual del género, poniéndole encima la guitarra percusiva de la bachata. Tiró también de la música jíbara puertorriqueña y de baladas como Condenado a la distancia.

Los temas que grabó en los setenta con Paredes en la primera guitarra —Vuela paloma, Entre copa y copa, Las nieves de enero— se quedaron en el centro de su repertorio el resto de su vida. Amor del bueno, de 1974, se convirtió en su himno, y es además el disco por el que se conoce a Paredes como guitarrista.

**El repertorio más difícil del género**

Como Paredes escribía arreglos tan exigentes, solo los mejores podían acompañarlo, y por su grupo pasaron algunos de los guitarristas más finos del país: Augusto Santos, Frank Méndez, Virgilio de la Cruz y Mártires de León. Con Augusto Santos formó además un dúo de voces, Los Inimitables, del que salieron Con golpes de pecho y Negra ¿por qué me dejaste?; Santos grabó la primera guitarra del sencillo La causa de mi muerte, de 1967.

**Después de la guitarra eléctrica**

La bachata cambió cuando Blas Durán le metió la guitarra eléctrica en 1987. La generación siguiente alcanzó una proyección internacional que sus antecesores no habían tenido, mientras que quienes se quedaron en los instrumentos acústicos, Cordero entre ellos, siguieron tocando sobre todo para el público de casa.

Lo que devolvió su obra a la vista en los noventa fueron los propios músicos. Mártires de León, ya maestro del estilo eléctrico moderno, grabó la primera guitarra de Manantial de amor, que funcionó muy bien.

**Director vocal**

El oído y la afinación le dieron trabajo también del otro lado del cristal, como director vocal de los estudios ENCA y ENFI de Santo Domingo. Monchy & Alexandra son el ejemplo que suele darse de lo que salió de ese trabajo.

**The Bachata Legends**

En sus últimos años se propuso recuperar la bachata acústica clásica y sacarla del país. Con El Chivo Sin Ley, Edilio Paredes y Joan Soriano formó la banda The Bachata Legends, que publicó un disco en 2011 y giró por Estados Unidos y Europa.',
       updated_at = now()
 WHERE slug = 'ramon-cordero';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José Ramón Cordero, known throughout his career as El Escudo, was one of the founding voices of bachata. His high, plaintive delivery is among the most recognisable the genre has, and his records are among the hardest in it to play, because the arrangements behind them were written by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cbda65a4-c7da-4762-8cf8-f29b942d2ac3","displayText":"Edilio Paredes","occurrenceId":"14808b73-9c70-483d-8c6e-1701d0e1fa89"}},{"text":". He died on 19 January 2017.","type":"text"}]},{"type":"paragraph","content":[{"text":"The campo and the capital","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He grew up in the countryside near San Francisco de Macorís, and the friend he grew up singing and playing with was Paredes, who lived nearby and later became his compadre. The two of them worked through their own songs and other people’s at country parties. When Paredes left for Santo Domingo, Cordero followed him there.","type":"text"}]},{"type":"paragraph","content":[{"text":"His first real success came in 1966 with Yo la recuerdo, which the two of them sang as a duo and recorded for the label belonging to ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy","occurrenceId":"0117bad6-bd97-4e0a-a826-1273812d382b"}},{"text":". He released a run of records with the Casa Alegre label around the same period.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mexico through a Dominican guitar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"What he brought to bachata came partly from somewhere else. Antonio Aguilar and Pedro Infante shaped his singing, and he recorded a great many Mexican songs as bachatas. Sometimes he went further and kept the ranchera in its original two-four or three-four time instead of the four-four the genre normally used, laying bachata’s percussive guitar over it. He drew on Puerto Rican jíbaro music as well, and on baladas such as Condenado a la distancia.","type":"text"}]},{"type":"paragraph","content":[{"text":"The songs he cut in the seventies with Paredes on lead guitar — Vuela paloma, Entre copa y copa, Las nieves de enero — stayed at the centre of his repertoire for the rest of his life. Amor del bueno, from 1974, became his anthem, and it is also the record by which Paredes is known as a guitarist.","type":"text"}]},{"type":"paragraph","content":[{"text":"The hardest repertoire in the genre","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Because Paredes wrote such demanding arrangements, only the best players could accompany him, and a succession of the country’s finest guitarists passed through his group: Augusto Santos, Frank Méndez, Virgilio de la Cruz and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1db77ddd-1046-4d95-b675-65da60234ef0","displayText":"Mártires de León","occurrenceId":"def369b2-6dde-4d0f-849f-27ebcb076eca"}},{"text":". With Augusto Santos he also formed a singing duo, Los Inimitables, which produced Con golpes de pecho and Negra ¿por qué me dejaste?; Santos played the lead guitar on the 1967 single La causa de mi muerte.","type":"text"}]},{"type":"paragraph","content":[{"text":"After the electric guitar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Bachata changed when ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2b644026-3e99-4229-a729-003f04103f30","displayText":"Blas Durán","occurrenceId":"1618a77c-6242-4c8f-acb8-74d98d3e1c2a"}},{"text":" brought the electric guitar into it in 1987. A younger generation went on to an international reach their predecessors had never had, while players who stayed with acoustic instruments, Cordero among them, went on performing largely for audiences at home.","type":"text"}]},{"type":"paragraph","content":[{"text":"What brought his work back into view in the nineties was other musicians. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1db77ddd-1046-4d95-b675-65da60234ef0","displayText":"Mártires de León","occurrenceId":"69397119-7bdc-4f7b-87f6-faf99fde6962"}},{"text":", by then a master of the modern electric style, recorded the lead guitar on Manantial de amor, which sold strongly.","type":"text"}]},{"type":"paragraph","content":[{"text":"Vocal director","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His ear and his sense of pitch got him work behind the glass as well, as a vocal director for the ENCA and ENFI studios in Santo Domingo. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra","occurrenceId":"762d0eda-5b89-43df-a8e3-2a0bfce29696"}},{"text":" are the example usually given of what that work produced.","type":"text"}]},{"type":"paragraph","content":[{"text":"The Bachata Legends","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In his last years he set out to revive classic acoustic bachata and take it abroad. With El Chivo Sin Ley, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cbda65a4-c7da-4762-8cf8-f29b942d2ac3","displayText":"Edilio Paredes","occurrenceId":"0d842f2a-d881-4697-b3db-bcf63a4c4410"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4d9ac6ac-6802-47f4-8731-5fa567713513","displayText":"Joan Soriano","occurrenceId":"8fe32df6-3139-4357-8c35-8aa23f225a4d"}},{"text":" he formed the band The Bachata Legends, which released an album in 2011 and toured the United States and Europe.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'ramon-cordero'), 3)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José Ramón Cordero, conocido durante toda su carrera como El Escudo, fue una de las voces fundadoras de la bachata. Su manera de cantar, aguda y quejumbrosa, es de las más reconocibles del género, y sus discos están entre los más difíciles de tocar, porque los arreglos que los sostienen los escribió ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cbda65a4-c7da-4762-8cf8-f29b942d2ac3","displayText":"Edilio Paredes","occurrenceId":"b4d31ff2-6a90-4f7d-bfa8-1d1d65e8906e"}},{"text":". Murió el 19 de enero de 2017.","type":"text"}]},{"type":"paragraph","content":[{"text":"El campo y la capital","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se crió en el campo cerca de San Francisco de Macorís, y el amigo con el que cantaba y tocaba de niño era Paredes, que vivía cerca y con el tiempo fue su compadre. Los dos se hacían las canciones propias y las ajenas en las fiestas de la zona. Cuando Paredes se fue a Santo Domingo, Cordero lo siguió.","type":"text"}]},{"type":"paragraph","content":[{"text":"Su primer éxito de verdad llegó en 1966 con Yo la recuerdo, que cantaron a dúo y grabaron para el sello de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy","occurrenceId":"d4478b32-d028-4f30-b627-e1d90bbce720"}},{"text":". Por esos mismos años publicó una tanda de discos con el sello Casa Alegre.","type":"text"}]},{"type":"paragraph","content":[{"text":"México pasado por una guitarra dominicana","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Lo que aportó a la bachata venía en parte de fuera. Antonio Aguilar y Pedro Infante le marcaron la manera de cantar, y grabó muchísimas canciones mexicanas convertidas en bachatas. A veces iba más lejos y mantenía la ranchera en su compás original de dos por cuatro o tres por cuatro, en lugar del cuatro por cuatro habitual del género, poniéndole encima la guitarra percusiva de la bachata. Tiró también de la música jíbara puertorriqueña y de baladas como Condenado a la distancia.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los temas que grabó en los setenta con Paredes en la primera guitarra —Vuela paloma, Entre copa y copa, Las nieves de enero— se quedaron en el centro de su repertorio el resto de su vida. Amor del bueno, de 1974, se convirtió en su himno, y es además el disco por el que se conoce a Paredes como guitarrista.","type":"text"}]},{"type":"paragraph","content":[{"text":"El repertorio más difícil del género","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Como Paredes escribía arreglos tan exigentes, solo los mejores podían acompañarlo, y por su grupo pasaron algunos de los guitarristas más finos del país: Augusto Santos, Frank Méndez, Virgilio de la Cruz y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1db77ddd-1046-4d95-b675-65da60234ef0","displayText":"Mártires de León","occurrenceId":"abe7cef6-f81c-4c8b-b585-65ef2ef0afb5"}},{"text":". Con Augusto Santos formó además un dúo de voces, Los Inimitables, del que salieron Con golpes de pecho y Negra ¿por qué me dejaste?; Santos grabó la primera guitarra del sencillo La causa de mi muerte, de 1967.","type":"text"}]},{"type":"paragraph","content":[{"text":"Después de la guitarra eléctrica","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La bachata cambió cuando ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2b644026-3e99-4229-a729-003f04103f30","displayText":"Blas Durán","occurrenceId":"44b92ba1-aeb1-406d-98d7-3669dfbe2c6f"}},{"text":" le metió la guitarra eléctrica en 1987. La generación siguiente alcanzó una proyección internacional que sus antecesores no habían tenido, mientras que quienes se quedaron en los instrumentos acústicos, Cordero entre ellos, siguieron tocando sobre todo para el público de casa.","type":"text"}]},{"type":"paragraph","content":[{"text":"Lo que devolvió su obra a la vista en los noventa fueron los propios músicos. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1db77ddd-1046-4d95-b675-65da60234ef0","displayText":"Mártires de León","occurrenceId":"1d5ddde2-8d89-4c7a-9875-d924bd99965e"}},{"text":", ya maestro del estilo eléctrico moderno, grabó la primera guitarra de Manantial de amor, que funcionó muy bien.","type":"text"}]},{"type":"paragraph","content":[{"text":"Director vocal","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El oído y la afinación le dieron trabajo también del otro lado del cristal, como director vocal de los estudios ENCA y ENFI de Santo Domingo. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra","occurrenceId":"8c3c6887-bf29-4e5f-b13a-e6b83b0351ea"}},{"text":" son el ejemplo que suele darse de lo que salió de ese trabajo.","type":"text"}]},{"type":"paragraph","content":[{"text":"The Bachata Legends","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En sus últimos años se propuso recuperar la bachata acústica clásica y sacarla del país. Con El Chivo Sin Ley, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"cbda65a4-c7da-4762-8cf8-f29b942d2ac3","displayText":"Edilio Paredes","occurrenceId":"05ccd971-cdfc-46d6-a0c8-a503f2987cc1"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4d9ac6ac-6802-47f4-8731-5fa567713513","displayText":"Joan Soriano","occurrenceId":"24a4d809-a069-4ec2-901d-85349f26d019"}},{"text":" formó la banda The Bachata Legends, que publicó un disco en 2011 y giró por Estados Unidos y Europa.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'ramon-cordero'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'en'), '0117bad6-bd97-4e0a-a826-1273812d382b', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'en'), '0d842f2a-d881-4697-b3db-bcf63a4c4410', 'artist', 'cbda65a4-c7da-4762-8cf8-f29b942d2ac3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'en'), '14808b73-9c70-483d-8c6e-1701d0e1fa89', 'artist', 'cbda65a4-c7da-4762-8cf8-f29b942d2ac3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'en'), '1618a77c-6242-4c8f-acb8-74d98d3e1c2a', 'artist', '2b644026-3e99-4229-a729-003f04103f30');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'en'), '69397119-7bdc-4f7b-87f6-faf99fde6962', 'artist', '1db77ddd-1046-4d95-b675-65da60234ef0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'en'), '762d0eda-5b89-43df-a8e3-2a0bfce29696', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'en'), '8fe32df6-3139-4357-8c35-8aa23f225a4d', 'artist', '4d9ac6ac-6802-47f4-8731-5fa567713513');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'en'), 'def369b2-6dde-4d0f-849f-27ebcb076eca', 'artist', '1db77ddd-1046-4d95-b675-65da60234ef0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'es'), '05ccd971-cdfc-46d6-a0c8-a503f2987cc1', 'artist', 'cbda65a4-c7da-4762-8cf8-f29b942d2ac3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'es'), '1d5ddde2-8d89-4c7a-9875-d924bd99965e', 'artist', '1db77ddd-1046-4d95-b675-65da60234ef0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'es'), '24a4d809-a069-4ec2-901d-85349f26d019', 'artist', '4d9ac6ac-6802-47f4-8731-5fa567713513');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'es'), '44b92ba1-aeb1-406d-98d7-3669dfbe2c6f', 'artist', '2b644026-3e99-4229-a729-003f04103f30');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'es'), '8c3c6887-bf29-4e5f-b13a-e6b83b0351ea', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'es'), 'abe7cef6-f81c-4c8b-b585-65ef2ef0afb5', 'artist', '1db77ddd-1046-4d95-b675-65da60234ef0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'es'), 'b4d31ff2-6a90-4f7d-bfa8-1d1d65e8906e', 'artist', 'cbda65a4-c7da-4762-8cf8-f29b942d2ac3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-cordero') AND locale = 'es'), 'd4478b32-d028-4f30-b627-e1d90bbce720', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d');

COMMIT;
