BEGIN;

-- Ficha de Alih Jey. Nombre completo Alih Jey de Peña Jiménez (el relleno decía "Alissa Jeylani García"),
-- nacida el 5 de mayo de 1984 (el relleno decía 4 de febrero de 1982), occupations con producer.
-- Premios: nominación al Latin Grammy 2008 (Necia) y BMI Latin 2016 por «Adrenalina».

UPDATE artists SET first_name = 'Alih', middle_name = 'Jey', last_name = 'de Peña', second_last_name = 'Jiménez',
       aliases = ARRAY['Alih Jey de Peña']::text[], date_of_birth = '1984-05-05', birth_year = 1984,
       occupations = '["songwriter","guitarist","producer"]'::jsonb
       WHERE slug = 'alih-jey';

INSERT INTO award_categories (award_id, name)
  SELECT '1d8267d6-ad99-4ca6-8425-1315545ad86e', 'Best Rock Solo Vocal Album'
  WHERE NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Rock Solo Vocal Album');

INSERT INTO award_categories (award_id, name)
  SELECT '39b84fb1-2924-4389-a3d1-51cfb3688934', 'Award-Winning Song'
  WHERE NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = '39b84fb1-2924-4389-a3d1-51cfb3688934' AND name = 'Award-Winning Song');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT a.id, '1d8267d6-ad99-4ca6-8425-1315545ad86e', (SELECT id FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Rock Solo Vocal Album'), 2008, 'Necia', false, 'latingrammy.com (9.ª edición, archivo de la artista y lista de nominados de la categoría); Discolai (8 jun 2019)'
  FROM artists a WHERE a.slug = 'alih-jey';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT a.id, '39b84fb1-2924-4389-a3d1-51cfb3688934', (SELECT id FROM award_categories WHERE award_id = '39b84fb1-2924-4389-a3d1-51cfb3688934' AND name = 'Award-Winning Song'), 2016, 'Adrenalina', true, 'BMI.com (lista de premiados de los BMI Latin Awards, 3 mar 2016); Diario Libre (2 nov 2018)'
  FROM artists a WHERE a.slug = 'alih-jey';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Alih Jey —born Alih Jey de Peña Jiménez in Santo Domingo on 5 May 1984— is a Dominican singer, songwriter and producer based in Los Angeles, whose work moves between rock, pop and folk-tinged Latin music. She is the daughter of the singer "},{"type":"artistReference","attrs":{"occurrenceId":"99714b30-5289-4dfc-853c-1fe3671e0a3d","artistId":"2bdd072a-e0d4-472f-9579-ba9499ac4005","displayText":"Aníbal de Peña"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"A family of singers","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She started singing at three, travelling with her relatives in a family group known as La Familia de Peña, and as a teenager co-hosted the television programme «Topi Topi de Fiesta» alongside her older sister. Her first song, «Deal with It», dates from the age of fourteen. "},{"type":"text","text":"Jorge Taveras recorded two demos of her music, and Cholo Brenes managed her at that point."}]},{"type":"paragraph","content":[{"type":"text","text":"Universal Music and Paulina Rubio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her debut album, «Alih Jey», came out in 2001 with the single «It’s OK». She then paused to study and began writing with the songwriter and producer Jodi Marr, with whom she made «Gotas de Piel» (2004), recorded in Miami with a live band and produced by JMRS Productions, the trio of Marr, Jon Merchant and Ritchie Supa. Both albums appeared on Universal Music. In 2005 she opened the United States shows of Paulina Rubio’s «Pau-Latina» tour, and a concert at the Fortaleza Ozama in Santo Domingo was planned around it. «Gotas de Piel» includes her own version of «Mi Debilidad», the song her father had made popular."}]},{"type":"paragraph","content":[{"type":"text","text":"«Necia» and independent work","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Necia» (2007) earned her a nomination at the ninth Latin Grammy Awards, in 2008, for Best Rock Solo Vocal Album. Press coverage has described her as a three-time nominee, but the Latin Recording Academy’s own database lists this as her only nomination. Her catalogue continues with «Tarte» (2011) and, according to her official website, «Car Trouble» (2014)."}]},{"type":"paragraph","content":[{"type":"text","text":"Songwriting from Los Angeles","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"After settling in Los Angeles she built a second career writing for other artists. She co-wrote «Adrenalina», recorded by Ricky Martin with Wisin and Jennifer Lopez, and received a BMI Latin Award for it in 2016. She also sang «Pleasant Nightmare», the theme of the ABC series «Suburgatory»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Soy De Peña»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2018 and 2019 she turned to her family’s repertoire with «Soy De Peña», a tribute to her father and her grandfather recorded with the American folk group Cuñao. She described its sound as “bolero folk”. The lead single, «Mi Debilidad», known through "},{"type":"artistReference","attrs":{"occurrenceId":"4bacf700-0550-442b-9da8-a4e2be05165e","artistId":"2bdd072a-e0d4-472f-9579-ba9499ac4005","displayText":"Aníbal de Peña"}},{"type":"text","text":" and also recorded by the Venezuelan Felipe Pirela, was released with a video directed by Ernesto Lomelí and Jarina De Marco. On 3 November 2018, after ten years away from Dominican stages, she gave a free concert at Casa de Teatro in Santo Domingo, and the album followed in May 2019."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Asked in 2018 about her achievements, she said she valued the awards mostly because they showed that Dominican artists also make music beyond merengue and bachata, and she named her Latin Grammy nomination in the rock category as an example. She continues to write, produce and perform in Los Angeles."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alih-jey'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'alih-jey' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '99714b30-5289-4dfc-853c-1fe3671e0a3d', 'artist', '2bdd072a-e0d4-472f-9579-ba9499ac4005' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'alih-jey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '4bacf700-0550-442b-9da8-a4e2be05165e', 'artist', '2bdd072a-e0d4-472f-9579-ba9499ac4005' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'alih-jey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Alih Jey —born Alih Jey de Peña Jiménez in Santo Domingo on 5 May 1984— is a Dominican singer, songwriter and producer based in Los Angeles, whose work moves between rock, pop and folk-tinged Latin music. She is the daughter of the singer Aníbal de Peña.

**A family of singers**

She started singing at three, travelling with her relatives in a family group known as La Familia de Peña, and as a teenager co-hosted the television programme «Topi Topi de Fiesta» alongside her older sister. Her first song, «Deal with It», dates from the age of fourteen. Jorge Taveras recorded two demos of her music, and Cholo Brenes managed her at that point.

**Universal Music and Paulina Rubio**

Her debut album, «Alih Jey», came out in 2001 with the single «It’s OK». She then paused to study and began writing with the songwriter and producer Jodi Marr, with whom she made «Gotas de Piel» (2004), recorded in Miami with a live band and produced by JMRS Productions, the trio of Marr, Jon Merchant and Ritchie Supa. Both albums appeared on Universal Music. In 2005 she opened the United States shows of Paulina Rubio’s «Pau-Latina» tour, and a concert at the Fortaleza Ozama in Santo Domingo was planned around it. «Gotas de Piel» includes her own version of «Mi Debilidad», the song her father had made popular.

**«Necia» and independent work**

«Necia» (2007) earned her a nomination at the ninth Latin Grammy Awards, in 2008, for Best Rock Solo Vocal Album. Press coverage has described her as a three-time nominee, but the Latin Recording Academy’s own database lists this as her only nomination. Her catalogue continues with «Tarte» (2011) and, according to her official website, «Car Trouble» (2014).

**Songwriting from Los Angeles**

After settling in Los Angeles she built a second career writing for other artists. She co-wrote «Adrenalina», recorded by Ricky Martin with Wisin and Jennifer Lopez, and received a BMI Latin Award for it in 2016. She also sang «Pleasant Nightmare», the theme of the ABC series «Suburgatory».

**«Soy De Peña»**

In 2018 and 2019 she turned to her family’s repertoire with «Soy De Peña», a tribute to her father and her grandfather recorded with the American folk group Cuñao. She described its sound as “bolero folk”. The lead single, «Mi Debilidad», known through Aníbal de Peña and also recorded by the Venezuelan Felipe Pirela, was released with a video directed by Ernesto Lomelí and Jarina De Marco. On 3 November 2018, after ten years away from Dominican stages, she gave a free concert at Casa de Teatro in Santo Domingo, and the album followed in May 2019.

**Legacy**

Asked in 2018 about her achievements, she said she valued the awards mostly because they showed that Dominican artists also make music beyond merengue and bachata, and she named her Latin Grammy nomination in the rock category as an example. She continues to write, produce and perform in Los Angeles.' WHERE slug = 'alih-jey';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Alih Jey —nacida Alih Jey de Peña Jiménez en Santo Domingo el 5 de mayo de 1984— es cantante, compositora y productora dominicana radicada en Los Ángeles, cuyo trabajo se mueve entre el rock, el pop y una música latina de aire folk. Es hija del cantante "},{"type":"artistReference","attrs":{"occurrenceId":"d94e9250-c90c-408f-b4c1-acb160c848ca","artistId":"2bdd072a-e0d4-472f-9579-ba9499ac4005","displayText":"Aníbal de Peña"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Una familia de cantantes","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó a cantar a los tres años, de viaje con sus familiares en un grupo llamado La Familia de Peña, y en la adolescencia copresentó el programa de televisión «Topi Topi de Fiesta» junto a su hermana mayor. Su primera canción, «Deal with It», es de cuando tenía catorce años. "},{"type":"text","text":"Jorge Taveras registró dos demos de sus canciones, y por entonces la representaba Cholo Brenes."}]},{"type":"paragraph","content":[{"type":"text","text":"Universal Music y Paulina Rubio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su álbum debut, «Alih Jey», salió en 2001 con el sencillo «It’s OK». Después hizo una pausa para estudiar y empezó a componer con la compositora y productora Jodi Marr, con quien hizo «Gotas de Piel» (2004), grabado en Miami con banda en vivo y producido por JMRS Productions, el trío formado por Marr, Jon Merchant y Ritchie Supa. Ambos discos aparecieron con Universal Music. En 2005 abrió los conciertos en Estados Unidos de la gira «Pau-Latina» de Paulina Rubio, y se programó un concierto en la Fortaleza Ozama de Santo Domingo. «Gotas de Piel» incluye su propia versión de «Mi Debilidad», la canción que su padre había popularizado."}]},{"type":"paragraph","content":[{"type":"text","text":"«Necia» y su trabajo independiente","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Necia» (2007) le valió una nominación en la novena entrega de los Latin Grammy, en 2008, a Mejor Álbum de Rock de Solista. La prensa la ha descrito como nominada en tres ocasiones, pero la base de datos de la Academia Latina de la Grabación registra esta como su única nominación. Su catálogo sigue con «Tarte» (2011) y, según su sitio oficial, «Car Trouble» (2014)."}]},{"type":"paragraph","content":[{"type":"text","text":"Compositora desde Los Ángeles","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ya instalada en Los Ángeles, construyó una segunda carrera escribiendo para otros artistas. Coescribió «Adrenalina», grabada por Ricky Martin con Wisin y Jennifer Lopez, y por ella recibió un premio BMI Latin en 2016. También cantó «Pleasant Nightmare», el tema de la serie de ABC «Suburgatory»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Soy De Peña»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2018 y 2019 volvió al repertorio de su familia con «Soy De Peña», un tributo a su padre y a su abuelo grabado con el grupo folk estadounidense Cuñao. Ella definió su sonido como “bolero folk”. El sencillo principal, «Mi Debilidad», conocido por la voz de "},{"type":"artistReference","attrs":{"occurrenceId":"d448f899-35fd-4f90-a4d6-78ae237241d2","artistId":"2bdd072a-e0d4-472f-9579-ba9499ac4005","displayText":"Aníbal de Peña"}},{"type":"text","text":" y grabado también por el venezolano Felipe Pirela, salió acompañado de un video que realizaron Ernesto Lomelí y Jarina De Marco. El 3 de noviembre de 2018, tras diez años sin actuar en escenarios dominicanos, ofreció un concierto gratuito en Casa de Teatro, en Santo Domingo, y el álbum llegó en mayo de 2019."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Preguntada en 2018 por sus logros, dijo que valoraba los premios sobre todo porque mostraban que los artistas dominicanos también hacen música más allá del merengue y la bachata, y citó como ejemplo su nominación al Latin Grammy en la categoría de rock. Sigue escribiendo, produciendo y presentándose en Los Ángeles."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alih-jey'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'alih-jey' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd94e9250-c90c-408f-b4c1-acb160c848ca', 'artist', '2bdd072a-e0d4-472f-9579-ba9499ac4005' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'alih-jey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd448f899-35fd-4f90-a4d6-78ae237241d2', 'artist', '2bdd072a-e0d4-472f-9579-ba9499ac4005' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'alih-jey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Alih Jey —nacida Alih Jey de Peña Jiménez en Santo Domingo el 5 de mayo de 1984— es cantante, compositora y productora dominicana radicada en Los Ángeles, cuyo trabajo se mueve entre el rock, el pop y una música latina de aire folk. Es hija del cantante Aníbal de Peña.

**Una familia de cantantes**

Empezó a cantar a los tres años, de viaje con sus familiares en un grupo llamado La Familia de Peña, y en la adolescencia copresentó el programa de televisión «Topi Topi de Fiesta» junto a su hermana mayor. Su primera canción, «Deal with It», es de cuando tenía catorce años. Jorge Taveras registró dos demos de sus canciones, y por entonces la representaba Cholo Brenes.

**Universal Music y Paulina Rubio**

Su álbum debut, «Alih Jey», salió en 2001 con el sencillo «It’s OK». Después hizo una pausa para estudiar y empezó a componer con la compositora y productora Jodi Marr, con quien hizo «Gotas de Piel» (2004), grabado en Miami con banda en vivo y producido por JMRS Productions, el trío formado por Marr, Jon Merchant y Ritchie Supa. Ambos discos aparecieron con Universal Music. En 2005 abrió los conciertos en Estados Unidos de la gira «Pau-Latina» de Paulina Rubio, y se programó un concierto en la Fortaleza Ozama de Santo Domingo. «Gotas de Piel» incluye su propia versión de «Mi Debilidad», la canción que su padre había popularizado.

**«Necia» y su trabajo independiente**

«Necia» (2007) le valió una nominación en la novena entrega de los Latin Grammy, en 2008, a Mejor Álbum de Rock de Solista. La prensa la ha descrito como nominada en tres ocasiones, pero la base de datos de la Academia Latina de la Grabación registra esta como su única nominación. Su catálogo sigue con «Tarte» (2011) y, según su sitio oficial, «Car Trouble» (2014).

**Compositora desde Los Ángeles**

Ya instalada en Los Ángeles, construyó una segunda carrera escribiendo para otros artistas. Coescribió «Adrenalina», grabada por Ricky Martin con Wisin y Jennifer Lopez, y por ella recibió un premio BMI Latin en 2016. También cantó «Pleasant Nightmare», el tema de la serie de ABC «Suburgatory».

**«Soy De Peña»**

En 2018 y 2019 volvió al repertorio de su familia con «Soy De Peña», un tributo a su padre y a su abuelo grabado con el grupo folk estadounidense Cuñao. Ella definió su sonido como “bolero folk”. El sencillo principal, «Mi Debilidad», conocido por la voz de Aníbal de Peña y grabado también por el venezolano Felipe Pirela, salió acompañado de un video que realizaron Ernesto Lomelí y Jarina De Marco. El 3 de noviembre de 2018, tras diez años sin actuar en escenarios dominicanos, ofreció un concierto gratuito en Casa de Teatro, en Santo Domingo, y el álbum llegó en mayo de 2019.

**Legado**

Preguntada en 2018 por sus logros, dijo que valoraba los premios sobre todo porque mostraban que los artistas dominicanos también hacen música más allá del merengue y la bachata, y citó como ejemplo su nominación al Latin Grammy en la categoría de rock. Sigue escribiendo, produciendo y presentándose en Los Ángeles.' WHERE slug = 'alih-jey';

COMMIT;
