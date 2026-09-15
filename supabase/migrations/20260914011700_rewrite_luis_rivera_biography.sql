BEGIN;

-- Ficha de Luis Rivera (Luis Armando Rivera González).
--
-- occupations: musician (violín, piano), arranger, bandleader (dirigió la Banda de la
-- Policía Nacional y la Súper Orquesta San José). primary_role composer no cambia.
-- Premio: Premios Casandra / El Soberano 1985. Las órdenes de Duarte, Sánchez y Mella
-- y de Cristóbal Colón (Hoy 2014) no llevan año: no registradas.
-- El relleno anterior hablaba de zarzuela: ninguna fuente lo sostiene.

UPDATE artists SET occupations = '["musician","arranger","bandleader"]'::jsonb WHERE slug = 'luis-armando-rivera-gonzalez';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 1985, NULL, true, 'Artículo Premios Casandra 1985 (Wikipedia es); Hoy (9 mar 2009); Diario Libre (25 ene 2005); El Caribe (17 jun 2021). Primera entrega, 15 abr 1985'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'luis-armando-rivera-gonzalez' AND a.name = 'Premios Casandra' AND cat.name = 'El Soberano'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 1985);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Luis Rivera — Luis Armando Rivera González, born in San Fernando de Monte Cristi on 22 June 1901, died in Santo Domingo on 16 September 1986 — was a Dominican violinist, pianist, composer, arranger and conductor. He wrote the «Rapsodia dominicana n.º 1» and most of the songs remembered in the voice of his wife, "},{"type":"artistReference","attrs":{"occurrenceId":"cee9d2df-ad7a-46f4-b90c-545063ec5468","artistId":"a81458f1-ccaa-451a-8cd5-2afd4d27affb","displayText":"Casandra Damirón"}},{"type":"text","text":", and in 1985 received the first El Soberano, the highest honour of the awards named after her."}]},{"type":"paragraph","content":[{"type":"text","text":"Monte Cristi and Santiago","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His father, José Luis Rivera, taught him piano and violin. As a teenager he played among the violins of the «Centro Lírico Ildefonso Arté» in Santiago and in the small ensembles that accompanied silent films."}]},{"type":"paragraph","content":[{"type":"text","text":"Havana and Mexico","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1930 he appeared with the «Trío México Lindo», then on tour in the country, and soon afterwards left for Cuba, where he sat among the first violins of the Havana Philharmonic under its founder, the Spanish conductor Pedro San Juan. He published his first songbook in 1932, and his gift as an orchestrator led to arrangements of works by Ernesto Lecuona. In Mexico he wrote songs such as «Jugando y llorando» and premiered the musical revue «Pa’ L’Habana me voy»."}]},{"type":"paragraph","content":[{"type":"text","text":"Bands, radio and the «San José»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Back in the Dominican Republic he led the orchestra at the Club Antillas, where "},{"type":"artistReference","attrs":{"occurrenceId":"1a94eb1a-a522-47fc-91a6-fbba7d81c9b8","artistId":"a81458f1-ccaa-451a-8cd5-2afd4d27affb","displayText":"Casandra Damirón"}},{"type":"text","text":" first sang with him. In 1942 he was appointed director of the «Banda de Música de la Policía Nacional» and violin teacher at the Liceo Municipal, and he accompanied singers on the piano on the «Hora Selecta» of the radio station «HIG». In 1945 he became artistic director of «La Voz del Yuna», in Bonao, where he conducted the «Súper Orquesta San José», and he taught solfège and harmony at the Conservatorio Nacional de Música."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs for Casandra","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He married "},{"type":"artistReference","attrs":{"occurrenceId":"38a07721-dff1-4337-a3ae-80fa6fcaa29b","artistId":"a81458f1-ccaa-451a-8cd5-2afd4d27affb","displayText":"Casandra Damirón"}},{"type":"text","text":" in 1948, and for her he wrote boleros and folk pieces alike: «Reina», «Rosas para ti», «Vida», «Llegaste», «Noche tropical», «Eres todo en mi vida» and «Por qué dudas», which she sang with the «Súper Orquesta San José», as well as salves, tumbas and mangulinas. The tenor Arístides Incháustegui and the soprano Ivonne Haza also sang his songs."}]},{"type":"paragraph","content":[{"type":"text","text":"The concert works","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His catalogue runs to more than twenty romantic songs and twenty-five folk songs, dances for piano, the «Poema indio» for orchestra with baritone and narrator, and the «Rapsodia dominicana n.º 1» for piano and orchestra, alongside pieces such as «Sierra de Bahoruco», «Danza en merengue», «Fiesta de palos», «Siñá Anacleta» and «Merengueando»."}]},{"type":"paragraph","content":[{"type":"text","text":"Recognition","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He was made a knight of the Order of Duarte, Sánchez and Mella and of the Order of Christopher Columbus. At the first «Premios Casandra», on 15 April 1985 — two years after his wife’s death — he received El Soberano, the ceremony’s highest award, the first time it was given. In 2014 the «Compañía Lírica Nacional» paid tribute to him with a concert of his songs at the Palacio de Bellas Artes."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Luis Rivera moved between the concert hall, the military band and the dance orchestra, and his work joined the two: a classically trained violinist who put Dominican folk forms into orchestral writing and wrote boleros that remain among the most remembered of his time."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luis-armando-rivera-gonzalez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'luis-armando-rivera-gonzalez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cee9d2df-ad7a-46f4-b90c-545063ec5468', 'artist', 'a81458f1-ccaa-451a-8cd5-2afd4d27affb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luis-armando-rivera-gonzalez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1a94eb1a-a522-47fc-91a6-fbba7d81c9b8', 'artist', 'a81458f1-ccaa-451a-8cd5-2afd4d27affb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luis-armando-rivera-gonzalez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '38a07721-dff1-4337-a3ae-80fa6fcaa29b', 'artist', 'a81458f1-ccaa-451a-8cd5-2afd4d27affb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luis-armando-rivera-gonzalez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Luis Rivera — Luis Armando Rivera González, born in San Fernando de Monte Cristi on 22 June 1901, died in Santo Domingo on 16 September 1986 — was a Dominican violinist, pianist, composer, arranger and conductor. He wrote the «Rapsodia dominicana n.º 1» and most of the songs remembered in the voice of his wife, Casandra Damirón, and in 1985 received the first El Soberano, the highest honour of the awards named after her.

**Monte Cristi and Santiago**

His father, José Luis Rivera, taught him piano and violin. As a teenager he played among the violins of the «Centro Lírico Ildefonso Arté» in Santiago and in the small ensembles that accompanied silent films.

**Havana and Mexico**

In 1930 he appeared with the «Trío México Lindo», then on tour in the country, and soon afterwards left for Cuba, where he sat among the first violins of the Havana Philharmonic under its founder, the Spanish conductor Pedro San Juan. He published his first songbook in 1932, and his gift as an orchestrator led to arrangements of works by Ernesto Lecuona. In Mexico he wrote songs such as «Jugando y llorando» and premiered the musical revue «Pa’ L’Habana me voy».

**Bands, radio and the «San José»**

Back in the Dominican Republic he led the orchestra at the Club Antillas, where Casandra Damirón first sang with him. In 1942 he was appointed director of the «Banda de Música de la Policía Nacional» and violin teacher at the Liceo Municipal, and he accompanied singers on the piano on the «Hora Selecta» of the radio station «HIG». In 1945 he became artistic director of «La Voz del Yuna», in Bonao, where he conducted the «Súper Orquesta San José», and he taught solfège and harmony at the Conservatorio Nacional de Música.

**Songs for Casandra**

He married Casandra Damirón in 1948, and for her he wrote boleros and folk pieces alike: «Reina», «Rosas para ti», «Vida», «Llegaste», «Noche tropical», «Eres todo en mi vida» and «Por qué dudas», which she sang with the «Súper Orquesta San José», as well as salves, tumbas and mangulinas. The tenor Arístides Incháustegui and the soprano Ivonne Haza also sang his songs.

**The concert works**

His catalogue runs to more than twenty romantic songs and twenty-five folk songs, dances for piano, the «Poema indio» for orchestra with baritone and narrator, and the «Rapsodia dominicana n.º 1» for piano and orchestra, alongside pieces such as «Sierra de Bahoruco», «Danza en merengue», «Fiesta de palos», «Siñá Anacleta» and «Merengueando».

**Recognition**

He was made a knight of the Order of Duarte, Sánchez and Mella and of the Order of Christopher Columbus. At the first «Premios Casandra», on 15 April 1985 — two years after his wife’s death — he received El Soberano, the ceremony’s highest award, the first time it was given. In 2014 the «Compañía Lírica Nacional» paid tribute to him with a concert of his songs at the Palacio de Bellas Artes.

**Legacy**

Luis Rivera moved between the concert hall, the military band and the dance orchestra, and his work joined the two: a classically trained violinist who put Dominican folk forms into orchestral writing and wrote boleros that remain among the most remembered of his time.' WHERE slug = 'luis-armando-rivera-gonzalez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Luis Rivera —Luis Armando Rivera González, nacido en San Fernando de Montecristi el 22 de junio de 1901 y fallecido en Santo Domingo el 16 de septiembre de 1986— fue violinista, pianista, compositor, arreglista y director de orquesta dominicano. Escribió la «Rapsodia dominicana n.º 1» y la mayoría de las canciones que se recuerdan en la voz de su esposa, "},{"type":"artistReference","attrs":{"occurrenceId":"a2162bd4-aee4-4966-bba0-309589d57c41","artistId":"a81458f1-ccaa-451a-8cd5-2afd4d27affb","displayText":"Casandra Damirón"}},{"type":"text","text":", y en 1985 recibió el primer El Soberano, el máximo galardón de los premios que llevan el nombre de ella."}]},{"type":"paragraph","content":[{"type":"text","text":"Montecristi y Santiago","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su padre, José Luis Rivera, le enseñó piano y violín. De adolescente tocó entre los violines del «Centro Lírico Ildefonso Arté», en Santiago, y en las agrupaciones que amenizaban las proyecciones del cine mudo."}]},{"type":"paragraph","content":[{"type":"text","text":"La Habana y México","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1930 se presentó con el «Trío México Lindo», que cumplía un contrato en el país, y poco después viajó a Cuba, donde tocó entre los primeros violines de la Filarmónica de La Habana bajo la dirección de su fundador, el maestro español Pedro San Juan. En 1932 publicó su primer álbum de canciones, y su talento de orquestador lo llevó a hacer arreglos de obras de Ernesto Lecuona. En México compuso canciones como «Jugando y llorando» y estrenó la revista musical «Pa’ L’Habana me voy»."}]},{"type":"paragraph","content":[{"type":"text","text":"Bandas, radio y la «San José»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De vuelta al país dirigió la orquesta del Club Antillas, donde "},{"type":"artistReference","attrs":{"occurrenceId":"d25b39c0-7aa0-4944-ba17-475593ba3e5b","artistId":"a81458f1-ccaa-451a-8cd5-2afd4d27affb","displayText":"Casandra Damirón"}},{"type":"text","text":" cantó con él por primera vez. En 1942 fue nombrado director de la «Banda de Música de la Policía Nacional» y profesor de violín del Liceo Municipal, y acompañaba al piano a los cantantes en la «Hora Selecta» de la emisora «HIG». En 1945 asumió la dirección artística de «La Voz del Yuna», en Bonao, donde dirigió la «Súper Orquesta San José», y fue profesor de solfeo y armonía en el Conservatorio Nacional de Música."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones para Casandra","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Se casó con "},{"type":"artistReference","attrs":{"occurrenceId":"0a29fda4-59c3-42fa-8ef3-986e98f309e4","artistId":"a81458f1-ccaa-451a-8cd5-2afd4d27affb","displayText":"Casandra Damirón"}},{"type":"text","text":" en 1948, y para ella escribió tanto boleros como piezas folclóricas: «Reina», «Rosas para ti», «Vida», «Llegaste», «Noche tropical», «Eres todo en mi vida» y «Por qué dudas», que ella cantó con la «Súper Orquesta San José», además de salves, tumbas y mangulinas. El tenor Arístides Incháustegui y la soprano Ivonne Haza también cantaron sus canciones."}]},{"type":"paragraph","content":[{"type":"text","text":"La obra de concierto","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su catálogo reúne más de veinte canciones románticas y veinticinco folclóricas, danzas para piano, el «Poema indio» para orquesta con barítono y narrador y la «Rapsodia dominicana n.º 1» para piano y orquesta, junto a piezas como «Sierra de Bahoruco», «Danza en merengue», «Fiesta de palos», «Siñá Anacleta» y «Merengueando»."}]},{"type":"paragraph","content":[{"type":"text","text":"Reconocimientos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fue condecorado con la Orden de Duarte, Sánchez y Mella y con la Orden de Cristóbal Colón, ambas en grado de caballero. En la primera entrega de los «Premios Casandra», el 15 de abril de 1985 —dos años después de la muerte de su esposa—, recibió El Soberano, el máximo galardón, que se otorgaba por primera vez. En 2014 la «Compañía Lírica Nacional» le rindió homenaje con un concierto de sus canciones en el Palacio de Bellas Artes."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Luis Rivera se movió entre la sala de conciertos, la banda militar y la orquesta de baile, y su obra unió esos mundos: un violinista de formación clásica que llevó las formas folclóricas dominicanas a la escritura orquestal y compuso boleros que siguen entre los más recordados de su época."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luis-armando-rivera-gonzalez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'luis-armando-rivera-gonzalez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a2162bd4-aee4-4966-bba0-309589d57c41', 'artist', 'a81458f1-ccaa-451a-8cd5-2afd4d27affb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luis-armando-rivera-gonzalez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd25b39c0-7aa0-4944-ba17-475593ba3e5b', 'artist', 'a81458f1-ccaa-451a-8cd5-2afd4d27affb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luis-armando-rivera-gonzalez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0a29fda4-59c3-42fa-8ef3-986e98f309e4', 'artist', 'a81458f1-ccaa-451a-8cd5-2afd4d27affb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luis-armando-rivera-gonzalez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Luis Rivera —Luis Armando Rivera González, nacido en San Fernando de Montecristi el 22 de junio de 1901 y fallecido en Santo Domingo el 16 de septiembre de 1986— fue violinista, pianista, compositor, arreglista y director de orquesta dominicano. Escribió la «Rapsodia dominicana n.º 1» y la mayoría de las canciones que se recuerdan en la voz de su esposa, Casandra Damirón, y en 1985 recibió el primer El Soberano, el máximo galardón de los premios que llevan el nombre de ella.

**Montecristi y Santiago**

Su padre, José Luis Rivera, le enseñó piano y violín. De adolescente tocó entre los violines del «Centro Lírico Ildefonso Arté», en Santiago, y en las agrupaciones que amenizaban las proyecciones del cine mudo.

**La Habana y México**

En 1930 se presentó con el «Trío México Lindo», que cumplía un contrato en el país, y poco después viajó a Cuba, donde tocó entre los primeros violines de la Filarmónica de La Habana bajo la dirección de su fundador, el maestro español Pedro San Juan. En 1932 publicó su primer álbum de canciones, y su talento de orquestador lo llevó a hacer arreglos de obras de Ernesto Lecuona. En México compuso canciones como «Jugando y llorando» y estrenó la revista musical «Pa’ L’Habana me voy».

**Bandas, radio y la «San José»**

De vuelta al país dirigió la orquesta del Club Antillas, donde Casandra Damirón cantó con él por primera vez. En 1942 fue nombrado director de la «Banda de Música de la Policía Nacional» y profesor de violín del Liceo Municipal, y acompañaba al piano a los cantantes en la «Hora Selecta» de la emisora «HIG». En 1945 asumió la dirección artística de «La Voz del Yuna», en Bonao, donde dirigió la «Súper Orquesta San José», y fue profesor de solfeo y armonía en el Conservatorio Nacional de Música.

**Canciones para Casandra**

Se casó con Casandra Damirón en 1948, y para ella escribió tanto boleros como piezas folclóricas: «Reina», «Rosas para ti», «Vida», «Llegaste», «Noche tropical», «Eres todo en mi vida» y «Por qué dudas», que ella cantó con la «Súper Orquesta San José», además de salves, tumbas y mangulinas. El tenor Arístides Incháustegui y la soprano Ivonne Haza también cantaron sus canciones.

**La obra de concierto**

Su catálogo reúne más de veinte canciones románticas y veinticinco folclóricas, danzas para piano, el «Poema indio» para orquesta con barítono y narrador y la «Rapsodia dominicana n.º 1» para piano y orquesta, junto a piezas como «Sierra de Bahoruco», «Danza en merengue», «Fiesta de palos», «Siñá Anacleta» y «Merengueando».

**Reconocimientos**

Fue condecorado con la Orden de Duarte, Sánchez y Mella y con la Orden de Cristóbal Colón, ambas en grado de caballero. En la primera entrega de los «Premios Casandra», el 15 de abril de 1985 —dos años después de la muerte de su esposa—, recibió El Soberano, el máximo galardón, que se otorgaba por primera vez. En 2014 la «Compañía Lírica Nacional» le rindió homenaje con un concierto de sus canciones en el Palacio de Bellas Artes.

**Legado**

Luis Rivera se movió entre la sala de conciertos, la banda militar y la orquesta de baile, y su obra unió esos mundos: un violinista de formación clásica que llevó las formas folclóricas dominicanas a la escritura orquestal y compuso boleros que siguen entre los más recordados de su época.' WHERE slug = 'luis-armando-rivera-gonzalez';

COMMIT;
