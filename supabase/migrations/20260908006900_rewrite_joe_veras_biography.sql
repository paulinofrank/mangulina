BEGIN;

-- Rewrite the catalogue entry for Joe Veras.
--
-- Joe Veras. DECIMOCUARTA de las 211, con 12 enlaces entrantes. 1.855
-- caracteres, cuatro párrafos, NI UNA CANCIÓN NI UN DISCO NI UN AÑO.
--
-- El párrafo tercero decía que sus canciones "have been celebrated at family
-- gatherings, on radio stations, and in the diaspora communities of New York,
-- Boston, and beyond, where Dominican music serves as a vital cultural
-- connection to the homeland". Eso no es información sobre Joe Veras; se puede
-- decir igual de cualquier bachatero vivo.
--
-- ---------------------------------------------------------------------------
-- EL NOMBRE LEGAL ESTABA EN LA PROPIA FILA, EN UN CAMPO QUE NADIE MIRÓ
--
-- first_name guardaba 'Joe' y last_name 'Veras', o sea el nombre artístico
-- metido en los campos del nombre legal. Pero mb_metadata, en la misma fila,
-- trae el alias de MusicBrainz: "JOSÉ MARÍA VERAS BATISTA".
--
-- Lo confirman Bachata Republic y la prensa dominicana. Se reparte en sus
-- cuatro campos. Es el mismo tipo de hallazgo que el de Don Miguelo: el dato
-- bueno estaba dentro de la fila.
-- ---------------------------------------------------------------------------
--
-- CONFLICTO DE PUEBLO QUE NO RESUELVO, Y ESTUVE A PUNTO DE "CORREGIR" LA FILA.
--
-- La fila guarda COTUÍ. Bachata Republic dice que nació en el sector la
-- Cooperativa del municipio de CEVICOS, y Hoy Digital (27 mar 2023) y
-- Gobernanzas Digital (2025) repiten Cevicos con la misma fecha.
--
-- PERO SU PROPIO CANAL DE YOUTUBE DICE, EN PRIMERA PERSONA, "un orgulloso
-- COTUISANO". Y el mismo artículo de Bachata Republic que dice Cevicos lo llama
-- dos veces "el bachatero de Cotuí". Cotuí es la capital de la provincia y
-- Cevicos un municipio de la misma provincia, así que la confusión tiene por
-- dónde entrar en las dos direcciones.
--
-- NO TOCO birth_place. El texto nombra la provincia, que nadie discute, y no el
-- pueblo. Queda reportado.
--
-- LO QUE FALTABA, QUE ES UNA HISTORIA DE ORIGEN ENTERA Y MUY BUENA:
--
--   OYÓ BACHATA EN RADIO GUARACHITA de niño: José Manuel Calderón, Luis Segura,
--   Eladio Romero Santos, Inocencio Cruz y Rafael Encarnación. Cuatro de los
--   cinco están en el catálogo, y la emisora es la de Radhamés Aracena, cuya
--   ficha se cruzó con la de Luis Segura hace un rato.
--
--   CONSTRUÍA GUITARRAS DE JUGUETE y tocaba a escondidas la de su hermano
--   Eugenio; a los diez pedía prestadas las de los vecinos para practicar y
--   cantar en los coros de las iglesias de su pueblo.
--
--   TRABAJÓ EN LA CONSTRUCCIÓN en Santo Domingo mientras tocaba de noche.
--   Estuvo en un grupo llamado LOS CONQUISTADORES, que duró poco, y después en
--   la ORQUESTA DE FÉLIX MIRABAL como guitarrista y cantante. Ahí se hizo
--   compositor y arreglista, con el apoyo de Mirabal.
--
--   EL CAMBIO DE NOMBRE, que es el mejor dato de la ficha: empezó en solitario
--   como JOSÉ VERAS. En 1993 el productor JOSÉ LUIS SEGURA, HIJO DE LUIS
--   SEGURA, lo oyó ensayando en su estudio, se convirtió en su mentor, LE
--   COMPRÓ SU PRIMERA GUITARRA y le sugirió llamarse Joe Veras para no
--   confundirse con el merenguero José Veras. Le dejó grabar "Joe Veras con
--   Amor", con la que sonó en el este y en parte de la capital con "DIME QUÉ
--   PASÓ".
--
--   "QUE SE MUERAN DE ENVIDIA", de "Con Más Amor" (1996), fue la que le permitió
--   dejar la construcción.
--
--   "ASÍ ES LA VIDA" (1997) le dio proyección internacional y su PRIMER
--   CASANDRA como bachatero del año.
--
--   VEINTIÚN DISCOS, de "Con Amor" (1993) a "Provócame" (2019).
--
-- TRES PREMIOS, ninguno registrado: Bachatero del Año en 1997 y 2004, y Bachata
-- del Año en 2006 por "LA PARED", compuesta por ENRIQUE FÉLIX. Van en migración
-- aparte.
--
-- DISCREPANCIA MENOR EN MI PROPIA FUENTE: el palmarés de Bachata Republic
-- atribuye el Casandra de 1997 a "Con más amor" y su biografía se lo atribuye a
-- "Así es la vida". Como el premio de una ceremonia suele ser por el trabajo del
-- año anterior, guardo el del palmarés y lo digo en la migración.
--
-- LAS COLABORACIONES, todas documentadas: "Amor Enterrado" en el "Utopía" de
-- Romeo Santos; "Tú No Sabes" en el Añoñado II de LUIS SEGURA, disco que
-- describí ayer entero; "No me Tocó Morir por ti" en el "Friends and Legends"
-- de HENRY SANTOS; el remix de "Que se mueran de envidia" que grabó Farruko en
-- 2022 invitándolo al video; y "Como da Vueltas la Vida" con RAULÍN RODRÍGUEZ.
--
-- occupations SE REESCRIBE Y LO REPORTO. Estaba ["musician","composer",
-- "producer"]. 'musician' es vago y las tres fuentes coinciden en dos oficios
-- precisos que faltaban: GUITARRISTA y ARREGLISTA. 'producer' NO LO SOSTIENE
-- NINGUNA FUENTE que yo haya visto, y sale. Si el editor tiene un crédito de
-- producción, vuelve con una línea.
--
-- LO QUE SE DEJA FUERA: que es el cuarto de trece hijos, los nombres de sus
-- padres, y que su padre se oponía a que fuera artista. Vida privada, aunque la
-- última sea tentadora.
--
-- NO SE ESCRIBEN LAS REPRODUCCIONES, que BuenaMusica da en millones.
--
-- LAS TRES REDES DE LA FILA RESPONDEN y son suyas: el canal se titula "Joe
-- Veras Oficial" y el Instagram "Joe Veras 'El Hombre De Tu Vida'". Nada que
-- corregir.
--
-- OCHO ENLACES: los cuatro bachateros que oía en la Guarachita y que están en
-- el catálogo, Henry Santos y Raulín Rodríguez por crédito, y Frank Reyes y
-- Luis Vargas, que estuvieron con él en "Utopía".
--
-- FUENTES: Bachata Republic, biografía de Joe Veras (Luis Becker Cabrera, 8 de
-- julio de 2021), referenciada a Hoy Digital (21 may 2008, "de obrero de la
-- construcción a ser un ídolo de la bachata"), El Portal (27 abr 2017), El Día
-- (24 abr 2018), El Caribe (6 feb 2019) y Diario Libre (6 dic 2005).
-- BuenaMusica para los sellos —Darlenis Records, Hipólito Records, JVN Music—
-- y para la lista de países. NO HAY ARTÍCULO DE WIKIPEDIA sobre él, ni en
-- español ni en inglés, cosa notable para un artista con tres Casandra.
--
-- AUSENCIAS NUEVAS: INOCENCIO CRUZ (de los cinco que oía en la Guarachita, el
-- único que falta), FÉLIX MIRABAL (director de la orquesta donde se formó),
-- JOSÉ LUIS SEGURA (el productor que lo bautizó) y ENRIQUE FÉLIX (compositor de
-- "La Pared", canción premiada). Los cuatro comprobados con el buscador
-- corregido. Farruko es puertorriqueño y no entra.
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
       name = 'Joe Veras',
       sort_name = 'Veras, Joe',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1964-05-01',
       birth_year = 1964,
       date_of_death = NULL,
       birth_place = 'Cotuí',
       province = 'Sánchez Ramírez',
       first_name = 'José',
       middle_name = 'María',
       last_name = 'Veras',
       second_last_name = 'Batista',
       stage_name = 'Joe Veras',
       aliases = ARRAY['El Hombre de Tu Vida']::text[],
       occupations = '["composer","arranger","guitarist"]'::jsonb,
       instruments = ARRAY['voice', 'guitar']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@JoeVeras',
       facebook = 'JoeVerasMusic',
       instagram = 'joeverasoficial',
       disambiguation = 'Bachata singer, guitarist and arranger billed as El Hombre de Tu Vida',
       bio_en = 'José María Veras Batista, who records as Joe Veras, is a Dominican bachata singer, guitarist, composer and arranger. Billed as El Hombre de Tu Vida, he has won the Dominican award for bachata singer of the year twice and bachata of the year once, and he writes and arranges most of what he records, which is unusual among singers of his generation.

**Toy guitars and church choirs**

He was born on 1 May 1964 in the province of Sánchez Ramírez, in the centre of the country. What he heard as a child was Radio Guarachita, and what the station played was José Manuel Calderón, Luis Segura, Eladio Romero Santos, Inocencio Cruz and Rafael Encarnación.

He built himself toy guitars and played his brother Eugenio’s when nobody was watching. By ten he was borrowing instruments from neighbours to practise on, and singing in the church choirs of his town.

**Construction by day**

His brother, by then in Santo Domingo and playing in a bachata group, sent for him to join as guitarist or bassist and to study agronomy. The city turned out to be harder than that, and for several years he worked in construction and played at night.

He passed through a group called Los Conquistadores, which broke up quickly, and then joined the orchestra of Félix Mirabal as guitarist and as the singer on its bachata numbers. That is where he learned to arrange and to write, with Mirabal encouraging him.

**Dime qué pasó**

He went out on his own under the name José Veras. In 1993 the producer José Luis Segura, son of Luis Segura, heard him rehearsing at his studio, took him on, bought him his first guitar and suggested he bill himself as Joe Veras so as not to be confused with the merengue singer of the same name.

Segura let him cut his first record, Joe Veras con Amor. Dime qué pasó, from that album, got him played across the east of the country and in parts of the capital.

**Que se mueran de envidia**

Con Más Amor followed in 1996, and the song Que se mueran de envidia carried the whole record. It was what allowed him to leave the building sites and live on music. Así es la Vida, the year after, took him outside the country and brought his first Casandra as bachata singer of the year.

From there the albums came steadily: Reencuentro, Acéptame Como Soy, Desde mi Alma, Simplemente, Carta de Verano, Tonto Corazón, La Travesía, Vida, Maestro, Firme, Tranquilo y Tropical, Entrega Total and Provócame among them, along with two collections given over to merengue. Carta de Verano brought a second bachata singer of the year in 2004, and in 2006 La Pared, written by Enrique Félix, took bachata of the year.

**The invitations**

Younger and older singers alike have called him in. He sang Amor Enterrado on Romeo Santos’s Utopía, the album on which Frank Reyes and Luis Vargas also appeared, and Tú No Sabes on the second volume of Luis Segura’s farewell record.

He sang No me Tocó Morir por ti with Henry Santos on Friends and Legends, recorded Como da Vueltas la Vida with Raulín Rodríguez, and in 2022 the Puerto Rican Farruko cut a remix of Que se mueran de envidia and brought him into the video for it.',
       bio_es = 'José María Veras Batista, que graba como Joe Veras, es un cantante, guitarrista, compositor y arreglista dominicano de bachata. Anunciado como El Hombre de Tu Vida, ha ganado dos veces el premio dominicano al bachatero del año y una la bachata del año, y escribe y arregla casi todo lo que graba, cosa poco común entre los cantantes de su generación.

**Guitarras de juguete y coros de iglesia**

Nació el 1 de mayo de 1964 en la provincia Sánchez Ramírez, en el centro del país. Lo que oía de niño era Radio Guarachita, y lo que la emisora ponía era José Manuel Calderón, Luis Segura, Eladio Romero Santos, Inocencio Cruz y Rafael Encarnación.

Se fabricaba guitarras de juguete y tocaba la de su hermano Eugenio cuando no había nadie mirando. A los diez años pedía prestados los instrumentos de los vecinos para practicar, y cantaba en los coros de las iglesias de su pueblo.

**La construcción de día**

Su hermano, ya en Santo Domingo y tocando en un grupo de bachata, mandó a buscarlo para que entrara como guitarrista o bajista y de paso estudiara agronomía. La capital resultó más dura que eso, y durante varios años trabajó en la construcción y tocó de noche.

Pasó por un grupo llamado Los Conquistadores, que se disolvió pronto, y después entró en la orquesta de Félix Mirabal como guitarrista y como voz de los temas de bachata. Ahí aprendió a arreglar y a componer, con Mirabal empujándolo.

**Dime qué pasó**

Salió en solitario con el nombre de José Veras. En 1993 el productor José Luis Segura, hijo de Luis Segura, lo oyó ensayando en su estudio, lo tomó bajo su cargo, le compró su primera guitarra y le sugirió anunciarse como Joe Veras para no confundirse con el merenguero del mismo nombre.

Segura le permitió grabar su primer disco, Joe Veras con Amor. Con Dime qué pasó, de ese álbum, sonó en toda la región este y en parte de la capital.

**Que se mueran de envidia**

Con Más Amor salió en 1996, y la canción Que se mueran de envidia arrastró el disco entero. Fue la que le permitió dejar las obras y vivir de la música. Así es la Vida, al año siguiente, lo sacó del país y le trajo su primer Casandra como bachatero del año.

A partir de ahí los discos fueron seguidos: Reencuentro, Acéptame Como Soy, Desde mi Alma, Simplemente, Carta de Verano, Tonto Corazón, La Travesía, Vida, Maestro, Firme, Tranquilo y Tropical, Entrega Total y Provócame, entre otros, más dos entregas dedicadas al merengue. Carta de Verano le dio el segundo bachatero del año en 2004, y en 2006 La Pared, compuesta por Enrique Félix, se llevó la bachata del año.

**Las invitaciones**

Lo han llamado los más jóvenes y los mayores. Cantó Amor Enterrado en el Utopía de Romeo Santos, disco en el que también estuvieron Frank Reyes y Luis Vargas, y Tú No Sabes en el segundo volumen del disco de despedida de Luis Segura.

Cantó No me Tocó Morir por ti con Henry Santos en Friends and Legends, grabó Como da Vueltas la Vida con Raulín Rodríguez, y en 2022 el puertorriqueño Farruko hizo una remezcla de Que se mueran de envidia y lo metió en el video.',
       updated_at = now()
 WHERE slug = 'joe-veras';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José María Veras Batista, who records as Joe Veras, is a Dominican bachata singer, guitarist, composer and arranger. Billed as El Hombre de Tu Vida, he has won the Dominican award for bachata singer of the year twice and bachata of the year once, and he writes and arranges most of what he records, which is unusual among singers of his generation.","type":"text"}]},{"type":"paragraph","content":[{"text":"Toy guitars and church choirs","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born on 1 May 1964 in the province of Sánchez Ramírez, in the centre of the country. What he heard as a child was Radio Guarachita, and what the station played was ","type":"text"},{"type":"artistReference","attrs":{"artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón","occurrenceId":"cd2a4f5b-9fd3-48cc-841e-4e106de8b90d"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"599fc81b-ee41-4e16-b1f2-21787de712ae"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"634a12eb-24c4-4053-835b-806986a8a735","displayText":"Eladio Romero Santos","occurrenceId":"f8a424c4-89fe-46b0-bd53-264dfd55a21e"}},{"text":", Inocencio Cruz and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3ae30a9a-5369-4084-8162-b2d470263f1e","displayText":"Rafael Encarnación","occurrenceId":"c262341f-a4e7-4bcd-b237-84e484717b4a"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"He built himself toy guitars and played his brother Eugenio’s when nobody was watching. By ten he was borrowing instruments from neighbours to practise on, and singing in the church choirs of his town.","type":"text"}]},{"type":"paragraph","content":[{"text":"Construction by day","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His brother, by then in Santo Domingo and playing in a bachata group, sent for him to join as guitarist or bassist and to study agronomy. The city turned out to be harder than that, and for several years he worked in construction and played at night.","type":"text"}]},{"type":"paragraph","content":[{"text":"He passed through a group called Los Conquistadores, which broke up quickly, and then joined the orchestra of Félix Mirabal as guitarist and as the singer on its bachata numbers. That is where he learned to arrange and to write, with Mirabal encouraging him.","type":"text"}]},{"type":"paragraph","content":[{"text":"Dime qué pasó","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He went out on his own under the name José Veras. In 1993 the producer José Luis Segura, son of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"bf77cdf3-87a2-4207-bc56-6dcb4d11ee61"}},{"text":", heard him rehearsing at his studio, took him on, bought him his first guitar and suggested he bill himself as Joe Veras so as not to be confused with the merengue singer of the same name.","type":"text"}]},{"type":"paragraph","content":[{"text":"Segura let him cut his first record, Joe Veras con Amor. Dime qué pasó, from that album, got him played across the east of the country and in parts of the capital.","type":"text"}]},{"type":"paragraph","content":[{"text":"Que se mueran de envidia","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Con Más Amor followed in 1996, and the song Que se mueran de envidia carried the whole record. It was what allowed him to leave the building sites and live on music. Así es la Vida, the year after, took him outside the country and brought his first Casandra as bachata singer of the year.","type":"text"}]},{"type":"paragraph","content":[{"text":"From there the albums came steadily: Reencuentro, Acéptame Como Soy, Desde mi Alma, Simplemente, Carta de Verano, Tonto Corazón, La Travesía, Vida, Maestro, Firme, Tranquilo y Tropical, Entrega Total and Provócame among them, along with two collections given over to merengue. Carta de Verano brought a second bachata singer of the year in 2004, and in 2006 La Pared, written by Enrique Félix, took bachata of the year.","type":"text"}]},{"type":"paragraph","content":[{"text":"The invitations","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Younger and older singers alike have called him in. He sang Amor Enterrado on Romeo Santos’s Utopía, the album on which ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes","occurrenceId":"3090229a-2603-45e5-9248-6f69f0e3b125"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas","occurrenceId":"2b654ecc-a2fb-471d-9b17-84f4709ad1b3"}},{"text":" also appeared, and Tú No Sabes on the second volume of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"4b975007-abea-412e-8bcb-41dd74cfd32e"}},{"text":"’s farewell record.","type":"text"}]},{"type":"paragraph","content":[{"text":"He sang No me Tocó Morir por ti with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8dcfc4e1-9af4-4378-9e19-52573af429a7","displayText":"Henry Santos","occurrenceId":"44e80fe0-fcb1-4ffb-833d-519e8221c94b"}},{"text":" on Friends and Legends, recorded Como da Vueltas la Vida with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"49f934cd-7152-40ca-ac08-f489de5a1433"}},{"text":", and in 2022 the Puerto Rican Farruko cut a remix of Que se mueran de envidia and brought him into the video for it.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'joe-veras'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José María Veras Batista, que graba como Joe Veras, es un cantante, guitarrista, compositor y arreglista dominicano de bachata. Anunciado como El Hombre de Tu Vida, ha ganado dos veces el premio dominicano al bachatero del año y una la bachata del año, y escribe y arregla casi todo lo que graba, cosa poco común entre los cantantes de su generación.","type":"text"}]},{"type":"paragraph","content":[{"text":"Guitarras de juguete y coros de iglesia","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació el 1 de mayo de 1964 en la provincia Sánchez Ramírez, en el centro del país. Lo que oía de niño era Radio Guarachita, y lo que la emisora ponía era ","type":"text"},{"type":"artistReference","attrs":{"artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón","occurrenceId":"55726d58-f464-41eb-a639-1a3dacd9f367"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"e1cace35-1a13-4f03-a34d-1b36544c8067"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"634a12eb-24c4-4053-835b-806986a8a735","displayText":"Eladio Romero Santos","occurrenceId":"c1c8e7d6-747a-4e64-8863-1649d3e80ac4"}},{"text":", Inocencio Cruz y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3ae30a9a-5369-4084-8162-b2d470263f1e","displayText":"Rafael Encarnación","occurrenceId":"d1804a4d-84e3-479f-ab92-3c11612a7840"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Se fabricaba guitarras de juguete y tocaba la de su hermano Eugenio cuando no había nadie mirando. A los diez años pedía prestados los instrumentos de los vecinos para practicar, y cantaba en los coros de las iglesias de su pueblo.","type":"text"}]},{"type":"paragraph","content":[{"text":"La construcción de día","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su hermano, ya en Santo Domingo y tocando en un grupo de bachata, mandó a buscarlo para que entrara como guitarrista o bajista y de paso estudiara agronomía. La capital resultó más dura que eso, y durante varios años trabajó en la construcción y tocó de noche.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pasó por un grupo llamado Los Conquistadores, que se disolvió pronto, y después entró en la orquesta de Félix Mirabal como guitarrista y como voz de los temas de bachata. Ahí aprendió a arreglar y a componer, con Mirabal empujándolo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Dime qué pasó","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Salió en solitario con el nombre de José Veras. En 1993 el productor José Luis Segura, hijo de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"2f4e2921-9c81-466f-b6c9-6c1808656af3"}},{"text":", lo oyó ensayando en su estudio, lo tomó bajo su cargo, le compró su primera guitarra y le sugirió anunciarse como Joe Veras para no confundirse con el merenguero del mismo nombre.","type":"text"}]},{"type":"paragraph","content":[{"text":"Segura le permitió grabar su primer disco, Joe Veras con Amor. Con Dime qué pasó, de ese álbum, sonó en toda la región este y en parte de la capital.","type":"text"}]},{"type":"paragraph","content":[{"text":"Que se mueran de envidia","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Con Más Amor salió en 1996, y la canción Que se mueran de envidia arrastró el disco entero. Fue la que le permitió dejar las obras y vivir de la música. Así es la Vida, al año siguiente, lo sacó del país y le trajo su primer Casandra como bachatero del año.","type":"text"}]},{"type":"paragraph","content":[{"text":"A partir de ahí los discos fueron seguidos: Reencuentro, Acéptame Como Soy, Desde mi Alma, Simplemente, Carta de Verano, Tonto Corazón, La Travesía, Vida, Maestro, Firme, Tranquilo y Tropical, Entrega Total y Provócame, entre otros, más dos entregas dedicadas al merengue. Carta de Verano le dio el segundo bachatero del año en 2004, y en 2006 La Pared, compuesta por Enrique Félix, se llevó la bachata del año.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las invitaciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Lo han llamado los más jóvenes y los mayores. Cantó Amor Enterrado en el Utopía de Romeo Santos, disco en el que también estuvieron ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes","occurrenceId":"2249be33-1de2-49f2-b94d-c1278913d49e"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas","occurrenceId":"397031a4-4027-447f-82b2-c77eebe8d609"}},{"text":", y Tú No Sabes en el segundo volumen del disco de despedida de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"86a18bef-8762-46fb-b6e5-83a1b5805c9b"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Cantó No me Tocó Morir por ti con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8dcfc4e1-9af4-4378-9e19-52573af429a7","displayText":"Henry Santos","occurrenceId":"408ccbdc-2633-40c9-a220-d5bd33363f48"}},{"text":" en Friends and Legends, grabó Como da Vueltas la Vida con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"8ce57152-4bd4-4300-b7f9-ac4fdf668afb"}},{"text":", y en 2022 el puertorriqueño Farruko hizo una remezcla de Que se mueran de envidia y lo metió en el video.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'joe-veras'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'en'), '2b654ecc-a2fb-471d-9b17-84f4709ad1b3', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'en'), '3090229a-2603-45e5-9248-6f69f0e3b125', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'en'), '44e80fe0-fcb1-4ffb-833d-519e8221c94b', 'artist', '8dcfc4e1-9af4-4378-9e19-52573af429a7');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'en'), '49f934cd-7152-40ca-ac08-f489de5a1433', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'en'), '4b975007-abea-412e-8bcb-41dd74cfd32e', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'en'), '599fc81b-ee41-4e16-b1f2-21787de712ae', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'en'), 'bf77cdf3-87a2-4207-bc56-6dcb4d11ee61', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'en'), 'c262341f-a4e7-4bcd-b237-84e484717b4a', 'artist', '3ae30a9a-5369-4084-8162-b2d470263f1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'en'), 'cd2a4f5b-9fd3-48cc-841e-4e106de8b90d', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'en'), 'f8a424c4-89fe-46b0-bd53-264dfd55a21e', 'artist', '634a12eb-24c4-4053-835b-806986a8a735');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'es'), '2249be33-1de2-49f2-b94d-c1278913d49e', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'es'), '2f4e2921-9c81-466f-b6c9-6c1808656af3', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'es'), '397031a4-4027-447f-82b2-c77eebe8d609', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'es'), '408ccbdc-2633-40c9-a220-d5bd33363f48', 'artist', '8dcfc4e1-9af4-4378-9e19-52573af429a7');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'es'), '55726d58-f464-41eb-a639-1a3dacd9f367', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'es'), '86a18bef-8762-46fb-b6e5-83a1b5805c9b', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'es'), '8ce57152-4bd4-4300-b7f9-ac4fdf668afb', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'es'), 'c1c8e7d6-747a-4e64-8863-1649d3e80ac4', 'artist', '634a12eb-24c4-4053-835b-806986a8a735');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'es'), 'd1804a4d-84e3-479f-ab92-3c11612a7840', 'artist', '3ae30a9a-5369-4084-8162-b2d470263f1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras') AND locale = 'es'), 'e1cace35-1a13-4f03-a34d-1b36544c8067', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

COMMIT;
