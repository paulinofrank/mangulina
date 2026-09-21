BEGIN;

-- Jezzy (Jessy Leonardo Lorenzo Rodríguez), 'el Chef de los Versos': dembowero de Villas Agrícolas, no un rapero de hip hop como decía el relleno. Fuentes: Listín Diario (Yadimir Crespo, 22 mar. 2026, entrevista: nombre, Villas Agrícolas, apodo, dembow, «Qué sensación», Soberano, Arcángel, Latin Rhythm Airplay), Diario Libre (13 mar. 2026: debut en Latin Rhythm Airplay en el 22, luego el 18), conectate.com.do (nominados y ganadores de los Premios Soberano 2026; Colaboración del Año: ganó Shadow Blow con Don Miguelo), Univision, People en Español, Hola y Hoy Digital (Premios Juventud 2026, 3 sep. 2026: Mejor Canción Urbano Trap para «Que sensación (Remix)», Jezzy y Arcángel). Campos: nombre civil repartido en first/middle/last/second (Jessy Leonardo Lorenzo Rodríguez), aliases Jezzy el Chef y El Chef de los Versos, primary_genre urbano, genres urban-dembow (era urbano), artist_tags sin emerging. Premios: Soberano 2026 (Colaboración del Año, nominado, no ganó) y Premios Juventud 2026 (Mejor Canción Urbano Trap, ganó; categoría creada). Se descartan cifras de oyentes y suscriptores (regla 6). Nacimiento 21 mar. 2001: fila y MusicBrainz; Listín Diario da 24 años en marzo de 2026, coherente.

INSERT INTO award_categories (award_id, name) SELECT '8304c63b-ff51-40ed-80bb-ea7c4079ca6f', 'Mejor Canción Urbano Trap' WHERE NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = '8304c63b-ff51-40ed-80bb-ea7c4079ca6f' AND name = 'Mejor Canción Urbano Trap');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT x.id, 'dec5d9e2-427b-414a-975f-41580488a7fd', (SELECT id FROM award_categories WHERE award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd' AND name = 'Colaboración del Año'), 2026, 'Qué sensación, con Arcángel (compuesta por Austin Santos y Jessy Lorenzo)', false, 'conectate.com.do (nominados y ganadores, 41.ª entrega, 18 mar. 2026); ganó «Zaza», de Shadow Blow con Don Miguelo'
  FROM artists x WHERE x.slug = 'jezzy';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT x.id, '8304c63b-ff51-40ed-80bb-ea7c4079ca6f', (SELECT id FROM award_categories WHERE award_id = '8304c63b-ff51-40ed-80bb-ea7c4079ca6f' AND name = 'Mejor Canción Urbano Trap'), 2026, 'Que sensación (Remix), con Arcángel', true, 'Univision, People en Español, Hola y Hoy Digital (ganadores, 3 sep. 2026)'
  FROM artists x WHERE x.slug = 'jezzy';

UPDATE artists SET first_name = 'Jessy', middle_name = 'Leonardo', last_name = 'Lorenzo', second_last_name = 'Rodríguez', aliases = ARRAY['Jezzy el Chef','El Chef de los Versos']::text[], primary_genre = 'urbano', genres = ARRAY['urban-dembow']::text[], artist_tags = ARRAY['secular']::text[] WHERE slug = 'jezzy';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jezzy —Jessy Leonardo Lorenzo Rodríguez, born on 21 March 2001 and known as “el Chef de los Versos”— is a Dominican dembow singer and songwriter from the Villas Agrícolas district of Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"The chef of verses","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A friend gave him the nickname because he is always writing, “cooking” the lines of his next songs. In a March 2026 interview with Listín Diario he said he had never dreamed of being a dembow singer but let himself be carried by the rhythm; he describes himself as a general artist, although dembow is the genre that made him popular. He says nearly all his songs speak of what happens in Villas Agrícolas, and he tries to export Dominican slang while keeping the identity of the neighborhood."}]},{"type":"paragraph","content":[{"type":"text","text":"«Qué sensación»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His song «Qué sensación», written with Austin Santos, led the charts in the Dominican Republic for months and was performed by him at the 41st Premios Soberano, on 18 March 2026 at the Teatro Nacional. The song, born as a declaration of love, led to a collaboration with the Puerto Rican singer Arcángel; the remix debuted on Billboard’s Latin Rhythm Airplay chart at number 22 in March 2026 and rose to 18 in its second week."}]},{"type":"paragraph","content":[{"type":"text","text":"Awards","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"At the 2026 Premios Soberano «Qué sensación», with Arcángel, was nominated for Collaboration of the Year, which went to "},{"type":"artistReference","attrs":{"occurrenceId":"7dfe4249-291f-4798-8cb1-7e608676d7d5","artistId":"b3841446-0bdb-48f5-9ace-b492db7d9be2","displayText":"Shadow Blow"}},{"type":"text","text":" with «Zaza». In September 2026 he and Arcángel won Best Urban Trap Song at the Premios Juventud for «Que sensación (Remix)»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He presents his music as the voice of the neighborhood: for him dembow is hope in the middle of turbulence and the joy of the Dominican Republic."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jezzy'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jezzy' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '7dfe4249-291f-4798-8cb1-7e608676d7d5', 'artist', 'b3841446-0bdb-48f5-9ace-b492db7d9be2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jezzy' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Jezzy —Jessy Leonardo Lorenzo Rodríguez, born on 21 March 2001 and known as “el Chef de los Versos”— is a Dominican dembow singer and songwriter from the Villas Agrícolas district of Santo Domingo.

**The chef of verses**

A friend gave him the nickname because he is always writing, “cooking” the lines of his next songs. In a March 2026 interview with Listín Diario he said he had never dreamed of being a dembow singer but let himself be carried by the rhythm; he describes himself as a general artist, although dembow is the genre that made him popular. He says nearly all his songs speak of what happens in Villas Agrícolas, and he tries to export Dominican slang while keeping the identity of the neighborhood.

**«Qué sensación»**

His song «Qué sensación», written with Austin Santos, led the charts in the Dominican Republic for months and was performed by him at the 41st Premios Soberano, on 18 March 2026 at the Teatro Nacional. The song, born as a declaration of love, led to a collaboration with the Puerto Rican singer Arcángel; the remix debuted on Billboard’s Latin Rhythm Airplay chart at number 22 in March 2026 and rose to 18 in its second week.

**Awards**

At the 2026 Premios Soberano «Qué sensación», with Arcángel, was nominated for Collaboration of the Year, which went to Shadow Blow with «Zaza». In September 2026 he and Arcángel won Best Urban Trap Song at the Premios Juventud for «Que sensación (Remix)».

**Legacy**

He presents his music as the voice of the neighborhood: for him dembow is hope in the middle of turbulence and the joy of the Dominican Republic.' WHERE slug = 'jezzy';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jezzy —Jessy Leonardo Lorenzo Rodríguez, nacido el 21 de marzo de 2001 y conocido como “el Chef de los Versos”— es un cantante y compositor dominicano de dembow del sector Villas Agrícolas, en Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"El chef de los versos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Un amigo le puso el apodo porque siempre está componiendo, “cocinando” los versos de sus próximas canciones. En una entrevista de marzo de 2026 con Listín Diario dijo que nunca soñó con ser dembowsero pero se dejó llevar por el ritmo; se define como un artista general, aunque el dembow es el género que le dio popularidad. Dice que casi todas sus canciones hablan de lo que pasa en Villas Agrícolas y que trata de exportar la jerga dominicana sin perder la identidad del barrio."}]},{"type":"paragraph","content":[{"type":"text","text":"«Qué sensación»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su canción «Qué sensación», escrita con Austin Santos, lideró durante meses las listas de República Dominicana y él la interpretó en la 41.ª entrega de los Premios Soberano, el 18 de marzo de 2026 en el Teatro Nacional. La canción, nacida como una declaración de amor, derivó en una colaboración con el cantante puertorriqueño Arcángel; el remix debutó en la lista Latin Rhythm Airplay de Billboard en el puesto 22 en marzo de 2026 y subió al 18 en su segunda semana."}]},{"type":"paragraph","content":[{"type":"text","text":"Premios","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En los Premios Soberano de 2026 «Qué sensación», con Arcángel, fue nominada a Colaboración del Año, que se llevó "},{"type":"artistReference","attrs":{"occurrenceId":"15c28b33-f71f-4971-80c7-286c901ea3de","artistId":"b3841446-0bdb-48f5-9ace-b492db7d9be2","displayText":"Shadow Blow"}},{"type":"text","text":" con «Zaza». En septiembre de 2026 él y Arcángel ganaron Mejor Canción Urbano Trap en los Premios Juventud con «Que sensación (Remix)»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Presenta su música como la voz del barrio: para él el dembow es la esperanza en medio de la turbulencia y la alegría de la República Dominicana."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jezzy'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jezzy' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '15c28b33-f71f-4971-80c7-286c901ea3de', 'artist', 'b3841446-0bdb-48f5-9ace-b492db7d9be2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jezzy' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Jezzy —Jessy Leonardo Lorenzo Rodríguez, nacido el 21 de marzo de 2001 y conocido como “el Chef de los Versos”— es un cantante y compositor dominicano de dembow del sector Villas Agrícolas, en Santo Domingo.

**El chef de los versos**

Un amigo le puso el apodo porque siempre está componiendo, “cocinando” los versos de sus próximas canciones. En una entrevista de marzo de 2026 con Listín Diario dijo que nunca soñó con ser dembowsero pero se dejó llevar por el ritmo; se define como un artista general, aunque el dembow es el género que le dio popularidad. Dice que casi todas sus canciones hablan de lo que pasa en Villas Agrícolas y que trata de exportar la jerga dominicana sin perder la identidad del barrio.

**«Qué sensación»**

Su canción «Qué sensación», escrita con Austin Santos, lideró durante meses las listas de República Dominicana y él la interpretó en la 41.ª entrega de los Premios Soberano, el 18 de marzo de 2026 en el Teatro Nacional. La canción, nacida como una declaración de amor, derivó en una colaboración con el cantante puertorriqueño Arcángel; el remix debutó en la lista Latin Rhythm Airplay de Billboard en el puesto 22 en marzo de 2026 y subió al 18 en su segunda semana.

**Premios**

En los Premios Soberano de 2026 «Qué sensación», con Arcángel, fue nominada a Colaboración del Año, que se llevó Shadow Blow con «Zaza». En septiembre de 2026 él y Arcángel ganaron Mejor Canción Urbano Trap en los Premios Juventud con «Que sensación (Remix)».

**Legado**

Presenta su música como la voz del barrio: para él el dembow es la esperanza en medio de la turbulencia y la alegría de la República Dominicana.' WHERE slug = 'jezzy';

COMMIT;
