BEGIN;

-- Ficha de Enrique de Marchena.
--
-- La biografía de relleno admitía su propia debilidad ("detailed biographical records...
-- are limited") sin nombrar una sola obra, maestro o premio. Se registran sus dos premios
-- documentados del Premio Nacional de Música José Reyes (1979 y 1982). occupations
-- ampliado con "writer". Nota: la fila indica que fundó la Sociedad Pro-Arte en 1937;
-- Ninón Lapeiretta de Brouwer (otra ficha de este catálogo) la fundó según otras fuentes en
-- 1953 — conflicto documentado en CONFLICTOS_DE_DATO.md, no conciliado aquí.

INSERT INTO award_categories (award_id, name)
SELECT id, 'Canción' FROM awards WHERE name = 'Premio Nacional de Música'
  AND NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = awards.id AND name = 'Canción');
INSERT INTO award_categories (award_id, name)
SELECT id, 'Composición' FROM awards WHERE name = 'Premio Nacional de Música'
  AND NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = awards.id AND name = 'Composición');
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT a.id, aw.id, ac.id, 1979, NULL, true,
  'Diccionario Cultural Dominicano (FUNGLODE) y varias publicaciones de Historia Dominicana en Gráficas: 12 de sus 27 canciones de amor recibieron el máximo galardón del jurado en 1979'
FROM artists a, awards aw, award_categories ac
WHERE a.slug = 'enrique-de-marchena' AND aw.name = 'Premio Nacional de Música' AND ac.award_id = aw.id AND ac.name = 'Canción';
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT a.id, aw.id, ac.id, 1982, 'Hebraicum', true,
  'Diccionario Cultural Dominicano (FUNGLODE) y Arístides Incháustegui, "Por Amor al Arte" (vía Scribd)'
FROM artists a, awards aw, award_categories ac
WHERE a.slug = 'enrique-de-marchena' AND aw.name = 'Premio Nacional de Música' AND ac.award_id = aw.id AND ac.name = 'Composición';

UPDATE artists SET occupations = '["writer"]'::jsonb WHERE slug = 'enrique-de-marchena';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Enrique de Marchena y Dujarric, born in Santo Domingo on 13 October 1908 and died there in 1988, was a Dominican composer, pianist, lawyer, writer and diplomat whose music was built on the aesthetics of French Impressionism."}]},{"type":"paragraph","content":[{"type":"text","text":"Training","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He took his first piano lessons at ten from Flérida de Nolasco and studied solfège and theory at the Liceo Musical under José de Jesús Ravelo. As a teenager he played piano at the Cine Colón, accompanying silent films, and composed his first work, the waltz «Ella», at sixteen; he later considered «Vals en sol» his real starting point as a composer. In 1929 he earned a law degree from the Universidad de Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"Building the institutions","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He played horn in the founding lineup of the Orquesta Sinfónica de Santo Domingo in 1932 and, by his own dictionary entry, was one of the principal founders of the Sociedad Pro-Arte in 1937. From 1929 until the end of his life he wrote music criticism for Listín Diario, alongside a parallel career teaching law."}]},{"type":"paragraph","content":[{"type":"text","text":"A catalogue in the Impressionist mode","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His catalogue of more than ninety works — identified stylistically with Debussy — includes the piano pieces «Debussyenne», «Claro de Luna» and «Reverie», the symphonic poem «Arco Iris» (awarded at the 1944 music competition marking the centennial of the Republic), a divertimento for strings and harp, and a concertino for flute and orchestra. Of his twenty-seven love songs, twelve won the top honor of the Premio Nacional de Música José Reyes jury in 1979, and his choral suite «Hebraicum» won the same prize in 1982."}]},{"type":"paragraph","content":[{"type":"text","text":"Diplomat and writer","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He served as Dominican ambassador to Washington from 1947 to 1954 and as delegate to the United Nations, then as ambassador to Bonn and Switzerland from 1966 to 1969. A member of the Academia Dominicana de la Lengua, he also wrote on Dominican folklore, including the 1942 essay «Del areíto de Anacaona al poema folklórico», and was decorated by both Germany and Spain, receiving Spain’s Grand Cross of the Order of Isabella the Catholic and, in 1955, its Grand Cross of the Civil Order of Alfonso X the Wise."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Composer, critic, law professor and career diplomat all at once, Enrique de Marchena spent six decades making the case, in concert halls and in print, that Santo Domingo’s musical life belonged in conversation with Paris and Vienna as much as with its own popular tradition."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'enrique-de-marchena'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'enrique-de-marchena' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Enrique de Marchena y Dujarric, born in Santo Domingo on 13 October 1908 and died there in 1988, was a Dominican composer, pianist, lawyer, writer and diplomat whose music was built on the aesthetics of French Impressionism.

**Training**

He took his first piano lessons at ten from Flérida de Nolasco and studied solfège and theory at the Liceo Musical under José de Jesús Ravelo. As a teenager he played piano at the Cine Colón, accompanying silent films, and composed his first work, the waltz «Ella», at sixteen; he later considered «Vals en sol» his real starting point as a composer. In 1929 he earned a law degree from the Universidad de Santo Domingo.

**Building the institutions**

He played horn in the founding lineup of the Orquesta Sinfónica de Santo Domingo in 1932 and, by his own dictionary entry, was one of the principal founders of the Sociedad Pro-Arte in 1937. From 1929 until the end of his life he wrote music criticism for Listín Diario, alongside a parallel career teaching law.

**A catalogue in the Impressionist mode**

His catalogue of more than ninety works — identified stylistically with Debussy — includes the piano pieces «Debussyenne», «Claro de Luna» and «Reverie», the symphonic poem «Arco Iris» (awarded at the 1944 music competition marking the centennial of the Republic), a divertimento for strings and harp, and a concertino for flute and orchestra. Of his twenty-seven love songs, twelve won the top honor of the Premio Nacional de Música José Reyes jury in 1979, and his choral suite «Hebraicum» won the same prize in 1982.

**Diplomat and writer**

He served as Dominican ambassador to Washington from 1947 to 1954 and as delegate to the United Nations, then as ambassador to Bonn and Switzerland from 1966 to 1969. A member of the Academia Dominicana de la Lengua, he also wrote on Dominican folklore, including the 1942 essay «Del areíto de Anacaona al poema folklórico», and was decorated by both Germany and Spain, receiving Spain’s Grand Cross of the Order of Isabella the Catholic and, in 1955, its Grand Cross of the Civil Order of Alfonso X the Wise.

**Legacy**

Composer, critic, law professor and career diplomat all at once, Enrique de Marchena spent six decades making the case, in concert halls and in print, that Santo Domingo’s musical life belonged in conversation with Paris and Vienna as much as with its own popular tradition.' WHERE slug = 'enrique-de-marchena';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Enrique de Marchena y Dujarric, nacido en Santo Domingo el 13 de octubre de 1908 y fallecido en la misma ciudad en 1988, fue compositor, pianista, abogado, escritor y diplomático dominicano cuya música se construyó sobre la estética del impresionismo francés."}]},{"type":"paragraph","content":[{"type":"text","text":"Formación","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Tomó sus primeras clases de piano a los diez años con Flérida de Nolasco y estudió solfeo y teoría en el Liceo Musical con José de Jesús Ravelo. De adolescente tocó el piano en el Cine Colón, amenizando películas mudas, y compuso su primera obra, el vals «Ella», a los dieciséis años; más tarde consideró «Vals en sol» su verdadero punto de partida como compositor. En 1929 se licenció en Derecho por la Universidad de Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"Construir las instituciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Tocó el corno en la formación fundadora de la Orquesta Sinfónica de Santo Domingo en 1932 y, según su propia entrada de diccionario, fue uno de los principales fundadores de la Sociedad Pro-Arte en 1937. Desde 1929 y hasta el final de su vida ejerció la crítica musical en el Listín Diario, junto a una carrera paralela como profesor de Derecho."}]},{"type":"paragraph","content":[{"type":"text","text":"Un catálogo de cuño impresionista","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su catálogo de más de noventa obras —identificado estilísticamente con Debussy— incluye las piezas para piano «Debussyenne», «Claro de Luna» y «Reverie», el poema sinfónico «Arco Iris» (premiado en el concurso musical de 1944 por el centenario de la República), un divertimento para cuerdas y arpa, y un concertino para flauta y orquesta. De sus veintisiete canciones de amor, doce recibieron el máximo galardón del jurado del Premio Nacional de Música José Reyes en 1979, y su suite coral «Hebraicum» ganó el mismo premio en 1982."}]},{"type":"paragraph","content":[{"type":"text","text":"Diplomático y escritor","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fue embajador dominicano en Washington de 1947 a 1954 y delegado ante las Naciones Unidas, y luego embajador en Bonn y Suiza de 1966 a 1969. Miembro de la Academia Dominicana de la Lengua, escribió además sobre folclore dominicano, entre ellos el ensayo de 1942 «Del areíto de Anacaona al poema folklórico», y fue condecorado tanto por Alemania como por España, recibiendo de esta última la Gran Cruz de la Orden de Isabel la Católica y, en 1955, la Gran Cruz de la Orden Civil de Alfonso X el Sabio."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Compositor, crítico, profesor de Derecho y diplomático de carrera a la vez, Enrique de Marchena pasó seis décadas defendiendo, en salas de concierto y en la prensa, que la vida musical de Santo Domingo merecía dialogar tanto con París y Viena como con su propia tradición popular."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'enrique-de-marchena'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'enrique-de-marchena' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Enrique de Marchena y Dujarric, nacido en Santo Domingo el 13 de octubre de 1908 y fallecido en la misma ciudad en 1988, fue compositor, pianista, abogado, escritor y diplomático dominicano cuya música se construyó sobre la estética del impresionismo francés.

**Formación**

Tomó sus primeras clases de piano a los diez años con Flérida de Nolasco y estudió solfeo y teoría en el Liceo Musical con José de Jesús Ravelo. De adolescente tocó el piano en el Cine Colón, amenizando películas mudas, y compuso su primera obra, el vals «Ella», a los dieciséis años; más tarde consideró «Vals en sol» su verdadero punto de partida como compositor. En 1929 se licenció en Derecho por la Universidad de Santo Domingo.

**Construir las instituciones**

Tocó el corno en la formación fundadora de la Orquesta Sinfónica de Santo Domingo en 1932 y, según su propia entrada de diccionario, fue uno de los principales fundadores de la Sociedad Pro-Arte en 1937. Desde 1929 y hasta el final de su vida ejerció la crítica musical en el Listín Diario, junto a una carrera paralela como profesor de Derecho.

**Un catálogo de cuño impresionista**

Su catálogo de más de noventa obras —identificado estilísticamente con Debussy— incluye las piezas para piano «Debussyenne», «Claro de Luna» y «Reverie», el poema sinfónico «Arco Iris» (premiado en el concurso musical de 1944 por el centenario de la República), un divertimento para cuerdas y arpa, y un concertino para flauta y orquesta. De sus veintisiete canciones de amor, doce recibieron el máximo galardón del jurado del Premio Nacional de Música José Reyes en 1979, y su suite coral «Hebraicum» ganó el mismo premio en 1982.

**Diplomático y escritor**

Fue embajador dominicano en Washington de 1947 a 1954 y delegado ante las Naciones Unidas, y luego embajador en Bonn y Suiza de 1966 a 1969. Miembro de la Academia Dominicana de la Lengua, escribió además sobre folclore dominicano, entre ellos el ensayo de 1942 «Del areíto de Anacaona al poema folklórico», y fue condecorado tanto por Alemania como por España, recibiendo de esta última la Gran Cruz de la Orden de Isabel la Católica y, en 1955, la Gran Cruz de la Orden Civil de Alfonso X el Sabio.

**Legado**

Compositor, crítico, profesor de Derecho y diplomático de carrera a la vez, Enrique de Marchena pasó seis décadas defendiendo, en salas de concierto y en la prensa, que la vida musical de Santo Domingo merecía dialogar tanto con París y Viena como con su propia tradición popular.' WHERE slug = 'enrique-de-marchena';

COMMIT;
