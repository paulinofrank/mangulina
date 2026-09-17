BEGIN;

-- Ficha de AKINOhayLEY.
--
-- El relleno usaba pronombres "they/their" pese a gender='male' correcto, y no nombraba
-- canción, colaboración ni influencia real. primary_role corregido de "singer" a "rapper".
-- occupations ampliado con "producer". genres ampliado con "urban-dembow".

UPDATE artists SET primary_role = 'rapper', occupations = '["songwriter","producer"]'::jsonb,
       genres = ARRAY['urban-rap-hip-hop','urban-dembow']::text[]
       WHERE slug = 'akinohayley';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"AKINOhayLEY —born Josué Daniel Aquino Leyba on 3 December 1988 in Los Mina, Santo Domingo Este— is a Dominican rapper, songwriter and producer known for an experimental, genre-blending approach that moves between rap and dembow."}]},{"type":"paragraph","content":[{"type":"text","text":"Influences and early songs","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He has named the Dominican rap group «Lo Correcto» and Lápiz Conciente — known in the local scene as «El Papá del Rap» — as key influences, and built a catalog that includes «Rueda», with Sincero; «No le sale», with DNZO; «Toxina», with Cedeño Brown; «Piñata»; and «Lamento»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Toy Claro»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In March 2024 he released the single «Toy Claro», a two-minute, twenty-eight-second track he described as a personal outlet, built around the idea of overcoming challenges, leaving negativity behind and living with gratitude. “En la música no me limito, soy muy experimental, me gusta jugar con la música” (“In music I don’t limit myself, I’m very experimental, I like to play with music”), he said of his approach; the song passed 20,000 YouTube views within weeks of release."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"AKINOhayLEY has remained part of Santo Domingo’s underground rap circuit into 2026, appearing in freestyle collaborations such as «Algo de Ritmo», recorded with Keiro Sobrenatural, and in sessions documented by local rap-history accounts, while pursuing what Dominican press in 2024 described as an ambition to build a legacy that reaches beyond the local scene."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'akinohayley'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'akinohayley' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'AKINOhayLEY —born Josué Daniel Aquino Leyba on 3 December 1988 in Los Mina, Santo Domingo Este— is a Dominican rapper, songwriter and producer known for an experimental, genre-blending approach that moves between rap and dembow.

**Influences and early songs**

He has named the Dominican rap group «Lo Correcto» and Lápiz Conciente — known in the local scene as «El Papá del Rap» — as key influences, and built a catalog that includes «Rueda», with Sincero; «No le sale», with DNZO; «Toxina», with Cedeño Brown; «Piñata»; and «Lamento».

**«Toy Claro»**

In March 2024 he released the single «Toy Claro», a two-minute, twenty-eight-second track he described as a personal outlet, built around the idea of overcoming challenges, leaving negativity behind and living with gratitude. “En la música no me limito, soy muy experimental, me gusta jugar con la música” (“In music I don’t limit myself, I’m very experimental, I like to play with music”), he said of his approach; the song passed 20,000 YouTube views within weeks of release.

**Legacy**

AKINOhayLEY has remained part of Santo Domingo’s underground rap circuit into 2026, appearing in freestyle collaborations such as «Algo de Ritmo», recorded with Keiro Sobrenatural, and in sessions documented by local rap-history accounts, while pursuing what Dominican press in 2024 described as an ambition to build a legacy that reaches beyond the local scene.' WHERE slug = 'akinohayley';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"AKINOhayLEY —nacido Josué Daniel Aquino Leyba el 3 de diciembre de 1988 en Los Mina, Santo Domingo Este— es rapero, compositor y productor dominicano conocido por un enfoque experimental que mezcla géneros y se mueve entre el rap y el dembow."}]},{"type":"paragraph","content":[{"type":"text","text":"Influencias y primeras canciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ha señalado como influencias clave a la agrupación dominicana de rap «Lo Correcto» y a Lápiz Conciente —conocido en la escena local como «El Papá del Rap»—, y construyó un catálogo que incluye «Rueda», junto a Sincero; «No le sale», junto a DNZO; «Toxina», junto a Cedeño Brown; «Piñata»; y «Lamento»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Toy Claro»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En marzo de 2024 publicó el sencillo «Toy Claro», un tema de dos minutos con veintiocho segundos que describió como un desahogo personal, construido sobre la idea de superar desafíos, dejar atrás la negatividad y vivir agradecido. “En la música no me limito, soy muy experimental, me gusta jugar con la música”, dijo sobre su enfoque; la canción superó las 20 mil visitas en YouTube semanas después de su lanzamiento."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"AKINOhayLEY ha seguido siendo parte del circuito de rap underground de Santo Domingo hasta 2026, apareciendo en colaboraciones de freestyle como «Algo de Ritmo», grabada junto a Keiro Sobrenatural, y en sesiones documentadas por cuentas dedicadas a la historia del rap local, mientras persigue lo que la prensa dominicana describió en 2024 como la ambición de construir un legado que trascienda la escena local."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'akinohayley'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'akinohayley' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'AKINOhayLEY —nacido Josué Daniel Aquino Leyba el 3 de diciembre de 1988 en Los Mina, Santo Domingo Este— es rapero, compositor y productor dominicano conocido por un enfoque experimental que mezcla géneros y se mueve entre el rap y el dembow.

**Influencias y primeras canciones**

Ha señalado como influencias clave a la agrupación dominicana de rap «Lo Correcto» y a Lápiz Conciente —conocido en la escena local como «El Papá del Rap»—, y construyó un catálogo que incluye «Rueda», junto a Sincero; «No le sale», junto a DNZO; «Toxina», junto a Cedeño Brown; «Piñata»; y «Lamento».

**«Toy Claro»**

En marzo de 2024 publicó el sencillo «Toy Claro», un tema de dos minutos con veintiocho segundos que describió como un desahogo personal, construido sobre la idea de superar desafíos, dejar atrás la negatividad y vivir agradecido. “En la música no me limito, soy muy experimental, me gusta jugar con la música”, dijo sobre su enfoque; la canción superó las 20 mil visitas en YouTube semanas después de su lanzamiento.

**Legado**

AKINOhayLEY ha seguido siendo parte del circuito de rap underground de Santo Domingo hasta 2026, apareciendo en colaboraciones de freestyle como «Algo de Ritmo», grabada junto a Keiro Sobrenatural, y en sesiones documentadas por cuentas dedicadas a la historia del rap local, mientras persigue lo que la prensa dominicana describió en 2024 como la ambición de construir un legado que trascienda la escena local.' WHERE slug = 'akinohayley';

COMMIT;
