BEGIN;

-- Ficha de Isidoro Flores.
--
-- La biografía de relleno lo describía "connected to the Santiago region", contradiciendo
-- tanto la propia fila (birth_place='San Pedro de Macorís') como toda fuente encontrada:
-- Flores fue exponente de un merengue típico oriental, distinto del cibaeño.
-- instruments añadido (accordion).

UPDATE artists SET instruments = ARRAY['accordion']::text[] WHERE slug = 'isidoro-flores';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Isidro Castillo Flores, known as Isidoro Flores, was born in 1912 in the Pajarito section of the Quisqueya sugar mill in San Pedro de Macorís and died in Puerto Rico on 7 January 1973 — a leading accordionist of the eastern Dominican merengue típico tradition, a distinct regional sound from the better-known Cibao style."}]},{"type":"paragraph","content":[{"type":"text","text":"From the cane fields to «La Voz del Yuna»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He learned accordion watching his father run a business that hosted country dances, and formed his first group at the Las Pajas sugar mill in the 1920s, playing for cane cutters. A move to Hato Mayor in search of opportunity led an army recruiter, Pedrito Trujillo, to spot his talent, and that connection opened the door to twenty-three years hosting a traditional música típica program on La Voz del Yuna, today CERTV."}]},{"type":"paragraph","content":[{"type":"text","text":"«Cuarteto Flores»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He led his own group, Cuarteto Flores, with Tavito Peguero, Neftalí Castro and Juan Cabrera, sometimes joined by the singers Thelma and Celeste Cruz, recording five LPs. Of the more than a hundred pieces he composed — mostly merengues, mangulinas and salves — «Carmela Linda», «Fiesta en la Joya» and «El Gallito Pinto» remain among his best known, alongside the salves «Blanca Flor» and «Salve de la Aurora»."}]},{"type":"paragraph","content":[{"type":"text","text":"Radio, stage, and a dispute over authorship","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His ensemble supplied the music for «La Hacienda por la Radio», a daily program aimed at rural listeners, and he appeared himself, playing a Haitian character, in the folk comedy duo Felipa y Macario, for whom his tune «Heroína» served as a theme song for decades. He publicly defended his authorship of «Fiesta en la Joya» after the Puerto Plata composer Félix López claimed the song as his own."}]},{"type":"paragraph","content":[{"type":"text","text":"Exile and an unfinished return","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1968, unable to make a living from his music at home, he emigrated to Puerto Rico, where the following year he formed a new ensemble, Los Alegres Dominicanos. He had everything ready to move back to the Dominican Republic for good when, the night before his planned return, he collapsed while playing accordion at a house party in Puerto Rico and died shortly after at a hospital in Río Piedras."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Two of his nine children carried the music forward — Domingo Flores as an accordionist like his father, and Isidoro «Ply» Flores Jr. as a singer — and Isidoro Flores himself is remembered as one of the most authoritative voices of Dominican folk music, and of a merengue típico sound the Cibao never fully claimed as its own."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'isidoro-flores'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'isidoro-flores' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Isidro Castillo Flores, known as Isidoro Flores, was born in 1912 in the Pajarito section of the Quisqueya sugar mill in San Pedro de Macorís and died in Puerto Rico on 7 January 1973 — a leading accordionist of the eastern Dominican merengue típico tradition, a distinct regional sound from the better-known Cibao style.

**From the cane fields to «La Voz del Yuna»**

He learned accordion watching his father run a business that hosted country dances, and formed his first group at the Las Pajas sugar mill in the 1920s, playing for cane cutters. A move to Hato Mayor in search of opportunity led an army recruiter, Pedrito Trujillo, to spot his talent, and that connection opened the door to twenty-three years hosting a traditional música típica program on La Voz del Yuna, today CERTV.

**«Cuarteto Flores»**

He led his own group, Cuarteto Flores, with Tavito Peguero, Neftalí Castro and Juan Cabrera, sometimes joined by the singers Thelma and Celeste Cruz, recording five LPs. Of the more than a hundred pieces he composed — mostly merengues, mangulinas and salves — «Carmela Linda», «Fiesta en la Joya» and «El Gallito Pinto» remain among his best known, alongside the salves «Blanca Flor» and «Salve de la Aurora».

**Radio, stage, and a dispute over authorship**

His ensemble supplied the music for «La Hacienda por la Radio», a daily program aimed at rural listeners, and he appeared himself, playing a Haitian character, in the folk comedy duo Felipa y Macario, for whom his tune «Heroína» served as a theme song for decades. He publicly defended his authorship of «Fiesta en la Joya» after the Puerto Plata composer Félix López claimed the song as his own.

**Exile and an unfinished return**

In 1968, unable to make a living from his music at home, he emigrated to Puerto Rico, where the following year he formed a new ensemble, Los Alegres Dominicanos. He had everything ready to move back to the Dominican Republic for good when, the night before his planned return, he collapsed while playing accordion at a house party in Puerto Rico and died shortly after at a hospital in Río Piedras.

**Legacy**

Two of his nine children carried the music forward — Domingo Flores as an accordionist like his father, and Isidoro «Ply» Flores Jr. as a singer — and Isidoro Flores himself is remembered as one of the most authoritative voices of Dominican folk music, and of a merengue típico sound the Cibao never fully claimed as its own.' WHERE slug = 'isidoro-flores';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Isidro Castillo Flores, conocido como Isidoro Flores, nació en 1912 en la sección Pajarito del ingenio Quisqueya, en San Pedro de Macorís, y murió en Puerto Rico el 7 de enero de 1973 — un acordeonista de primer orden del merengue típico oriental, un sonido regional propio y distinto del más conocido estilo cibaeño."}]},{"type":"paragraph","content":[{"type":"text","text":"De los cañaverales a «La Voz del Yuna»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Aprendió acordeón viendo a su padre manejar un negocio donde se hacían fiestas de campo, y formó su primera agrupación en el ingenio Las Pajas en los años veinte, tocando para los cortadores de caña. Una mudanza a Hato Mayor en busca de oportunidades hizo que un reclutador del ejército, Pedrito Trujillo, viera su talento, y esa conexión le abrió la puerta a veintitrés años al frente de un programa de música típica dominicana en La Voz del Yuna, hoy Certv."}]},{"type":"paragraph","content":[{"type":"text","text":"«Cuarteto Flores»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Dirigió su propia agrupación, el Cuarteto Flores, con Tavito Peguero, Neftalí Castro y Juan Cabrera, a veces acompañado por las cantantes Thelma y Celeste Cruz, con la que grabó cinco discos de larga duración. De las más de cien piezas que compuso —en su mayoría merengues, mangulinas y salves—, «Carmela Linda», «Fiesta en la Joya» y «El Gallito Pinto» siguen entre las más conocidas, junto a las salves «Blanca Flor» y «Salve de la Aurora»."}]},{"type":"paragraph","content":[{"type":"text","text":"Radio, tarima y una disputa de autoría","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su conjunto puso la música de «La Hacienda por la Radio», programa diario dirigido a la audiencia rural, y él mismo apareció, interpretando a un personaje haitiano, en el dúo de comedia folclórica Felipa y Macario, para quienes su tema «Heroína» sirvió de sintonía durante décadas. Defendió públicamente la autoría de «Fiesta en la Joya» después de que el compositor puertoplateño Félix López reclamara la canción como propia."}]},{"type":"paragraph","content":[{"type":"text","text":"Exilio y un regreso inconcluso","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1968, sin poder vivir de su música en el país, emigró a Puerto Rico, donde al año siguiente formó una nueva agrupación, Los Alegres Dominicanos. Tenía todo listo para volver definitivamente a la República Dominicana cuando, la noche anterior a su regreso, se desplomó mientras tocaba el acordeón en una fiesta familiar en Puerto Rico y murió poco después en un hospital de Río Piedras."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Dos de sus nueve hijos siguieron con la música —Domingo Flores como acordeonista, igual que su padre, e Isidoro «Ply» Flores Jr. como cantante—, y a Isidoro Flores se le recuerda como una de las voces más autorizadas de la música folclórica dominicana, y de un merengue típico que el Cibao nunca terminó de reclamar como propio."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'isidoro-flores'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'isidoro-flores' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Isidro Castillo Flores, conocido como Isidoro Flores, nació en 1912 en la sección Pajarito del ingenio Quisqueya, en San Pedro de Macorís, y murió en Puerto Rico el 7 de enero de 1973 — un acordeonista de primer orden del merengue típico oriental, un sonido regional propio y distinto del más conocido estilo cibaeño.

**De los cañaverales a «La Voz del Yuna»**

Aprendió acordeón viendo a su padre manejar un negocio donde se hacían fiestas de campo, y formó su primera agrupación en el ingenio Las Pajas en los años veinte, tocando para los cortadores de caña. Una mudanza a Hato Mayor en busca de oportunidades hizo que un reclutador del ejército, Pedrito Trujillo, viera su talento, y esa conexión le abrió la puerta a veintitrés años al frente de un programa de música típica dominicana en La Voz del Yuna, hoy Certv.

**«Cuarteto Flores»**

Dirigió su propia agrupación, el Cuarteto Flores, con Tavito Peguero, Neftalí Castro y Juan Cabrera, a veces acompañado por las cantantes Thelma y Celeste Cruz, con la que grabó cinco discos de larga duración. De las más de cien piezas que compuso —en su mayoría merengues, mangulinas y salves—, «Carmela Linda», «Fiesta en la Joya» y «El Gallito Pinto» siguen entre las más conocidas, junto a las salves «Blanca Flor» y «Salve de la Aurora».

**Radio, tarima y una disputa de autoría**

Su conjunto puso la música de «La Hacienda por la Radio», programa diario dirigido a la audiencia rural, y él mismo apareció, interpretando a un personaje haitiano, en el dúo de comedia folclórica Felipa y Macario, para quienes su tema «Heroína» sirvió de sintonía durante décadas. Defendió públicamente la autoría de «Fiesta en la Joya» después de que el compositor puertoplateño Félix López reclamara la canción como propia.

**Exilio y un regreso inconcluso**

En 1968, sin poder vivir de su música en el país, emigró a Puerto Rico, donde al año siguiente formó una nueva agrupación, Los Alegres Dominicanos. Tenía todo listo para volver definitivamente a la República Dominicana cuando, la noche anterior a su regreso, se desplomó mientras tocaba el acordeón en una fiesta familiar en Puerto Rico y murió poco después en un hospital de Río Piedras.

**Legado**

Dos de sus nueve hijos siguieron con la música —Domingo Flores como acordeonista, igual que su padre, e Isidoro «Ply» Flores Jr. como cantante—, y a Isidoro Flores se le recuerda como una de las voces más autorizadas de la música folclórica dominicana, y de un merengue típico que el Cibao nunca terminó de reclamar como propio.' WHERE slug = 'isidoro-flores';

COMMIT;
