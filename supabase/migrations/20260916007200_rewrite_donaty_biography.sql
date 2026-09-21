BEGIN;

-- Donaty (Ángel Feliz Díaz): la fila decía Yeifry Sánchez; El Caribe (6 ago. 2023) y BuenaMusica dan Ángel Feliz Díaz, criado en Cristo Rey, que empezó en 2015 con covers y a los 17 conoció a Tivi Gunz. Nominación Premio Lo Nuestro 2025 a Mejor Canción Dembow con Rochy RD por Déjenme Rulay (listas de nominados de Billboard y LOS40; ganó Lomiiel con Hay Lupita según Diario Libre y LA Times). birth_year sale de la fila, sin respaldo (posible mezcla de identidades): se vacía.

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT x.id, 'f289c627-bc9e-48c5-8da3-d8fe3e9b0f60', (SELECT id FROM award_categories WHERE award_id = 'f289c627-bc9e-48c5-8da3-d8fe3e9b0f60' AND name = 'Mejor Canción Dembow'), 2025, 'Déjenme Rulay', false, 'Billboard y LOS40 (lista de nominados, 22 ene 2025); ganó «Hay Lupita» de Lomiiel (Diario Libre y Los Angeles Times, 20-21 feb 2025)'
  FROM artists x WHERE x.slug = 'donaty';

UPDATE artists SET first_name = 'Ángel', last_name = 'Feliz', second_last_name = 'Díaz', birth_year = NULL WHERE slug = 'donaty';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Donaty —Ángel Feliz Díaz— is a Dominican urban singer, rapper and songwriter who grew up in the Cristo Rey district of Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"Beginnings","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began in 2015 by posting covers and improvisations on social media, and left home at sixteen to pursue music. At seventeen he met the producer "},{"type":"artistReference","attrs":{"occurrenceId":"43a7fba2-07ef-4396-be44-d41be5d7e726","artistId":"95e181f1-58e5-4537-a5e8-75a9f60c6aca","displayText":"Tivi Gunz"}},{"type":"text","text":", who produced his first songs; his label, according to a music directory, is GunzGangMusic."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs and collaborations","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Newspaper profiles list among his hits «Empaquétate», «Tírate», «Mentolado», «Mi pana», «Rututu», «Mucha nota» and «Dividida», and he is also known for «Eso E» and «To No Morimo». Besides urban tracks he has composed in trap, rap and pop ballad styles. He has worked with "},{"type":"artistReference","attrs":{"occurrenceId":"715f9ca7-fbc1-4884-bfe8-f8bd8c08a9e5","artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa"}},{"type":"text","text":", with the Mexican band Fuerza Regida on «Toretto», and with the dembow artists Onguito Wa and Treintisiete 3730. His later singles include «Lo Que Pueda» (September 2025), and in 2026 he released «Cuánto», «Cadereo» and the dembow «To’ el mundo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Recognition","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2025 he was nominated for a Premio Lo Nuestro for Best Dembow Song, a new category, with «Déjenme Rulay», recorded with "},{"type":"artistReference","attrs":{"occurrenceId":"c5d826c3-8a44-4049-8c2f-2160693558c0","artistId":"71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb","displayText":"Rochy RD"}},{"type":"text","text":"; the award went to Lomiiel for «Hay Lupita»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The newspaper El Caribe described him in 2023 as one of the most influential exponents of the Dominican urban recording movement."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'donaty'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'donaty' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '43a7fba2-07ef-4396-be44-d41be5d7e726', 'artist', '95e181f1-58e5-4537-a5e8-75a9f60c6aca' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'donaty' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '715f9ca7-fbc1-4884-bfe8-f8bd8c08a9e5', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'donaty' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c5d826c3-8a44-4049-8c2f-2160693558c0', 'artist', '71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'donaty' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Donaty —Ángel Feliz Díaz— is a Dominican urban singer, rapper and songwriter who grew up in the Cristo Rey district of Santo Domingo.

**Beginnings**

He began in 2015 by posting covers and improvisations on social media, and left home at sixteen to pursue music. At seventeen he met the producer Tivi Gunz, who produced his first songs; his label, according to a music directory, is GunzGangMusic.

**Songs and collaborations**

Newspaper profiles list among his hits «Empaquétate», «Tírate», «Mentolado», «Mi pana», «Rututu», «Mucha nota» and «Dividida», and he is also known for «Eso E» and «To No Morimo». Besides urban tracks he has composed in trap, rap and pop ballad styles. He has worked with El Alfa, with the Mexican band Fuerza Regida on «Toretto», and with the dembow artists Onguito Wa and Treintisiete 3730. His later singles include «Lo Que Pueda» (September 2025), and in 2026 he released «Cuánto», «Cadereo» and the dembow «To’ el mundo».

**Recognition**

In 2025 he was nominated for a Premio Lo Nuestro for Best Dembow Song, a new category, with «Déjenme Rulay», recorded with Rochy RD; the award went to Lomiiel for «Hay Lupita».

**Legacy**

The newspaper El Caribe described him in 2023 as one of the most influential exponents of the Dominican urban recording movement.' WHERE slug = 'donaty';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Donaty —Ángel Feliz Díaz— es un cantante, rapero y compositor urbano dominicano criado en el sector Cristo Rey de Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"Inicios","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó en 2015 subiendo covers e improvisaciones a las redes sociales y dejó su casa a los dieciséis años para dedicarse a la música. A los diecisiete conoció al productor "},{"type":"artistReference","attrs":{"occurrenceId":"c97d449c-f2e9-49e5-99fd-4979b30eca70","artistId":"95e181f1-58e5-4537-a5e8-75a9f60c6aca","displayText":"Tivi Gunz"}},{"type":"text","text":", que produjo sus primeras canciones; su sello, según un directorio musical, es GunzGangMusic."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones y colaboraciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los perfiles de prensa incluyen entre sus éxitos «Empaquétate», «Tírate», «Mentolado», «Mi pana», «Rututu», «Mucha nota» y «Dividida», y también es conocido por «Eso E» y «To No Morimo». Además de temas urbanos ha compuesto en trap, rap y balada pop. Ha trabajado con "},{"type":"artistReference","attrs":{"occurrenceId":"db0f9496-7090-48c9-b59d-dd2174a1e5c0","artistId":"559f2ed4-8831-483b-bc00-7cb4f340ad92","displayText":"El Alfa"}},{"type":"text","text":", con la banda mexicana Fuerza Regida en «Toretto» y con los dembowseros Onguito Wa y Treintisiete 3730. Entre sus sencillos posteriores figura «Lo Que Pueda» (septiembre de 2025), y en 2026 publicó «Cuánto», «Cadereo» y el dembow «To’ el mundo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Reconocimiento","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2025 fue nominado a un Premio Lo Nuestro a Mejor Canción Dembow, categoría nueva, con «Déjenme Rulay», grabada con "},{"type":"artistReference","attrs":{"occurrenceId":"9853e768-9b0d-4b90-926a-9ed7f1ebe6f9","artistId":"71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb","displayText":"Rochy RD"}},{"type":"text","text":"; el premio fue para Lomiiel por «Hay Lupita»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El periódico El Caribe lo describió en 2023 como uno de los exponentes más influyentes del movimiento discográfico urbano dominicano."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'donaty'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'donaty' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c97d449c-f2e9-49e5-99fd-4979b30eca70', 'artist', '95e181f1-58e5-4537-a5e8-75a9f60c6aca' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'donaty' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'db0f9496-7090-48c9-b59d-dd2174a1e5c0', 'artist', '559f2ed4-8831-483b-bc00-7cb4f340ad92' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'donaty' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '9853e768-9b0d-4b90-926a-9ed7f1ebe6f9', 'artist', '71ebd02b-8ba4-4cd7-b7e4-a990a9c3c3bb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'donaty' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Donaty —Ángel Feliz Díaz— es un cantante, rapero y compositor urbano dominicano criado en el sector Cristo Rey de Santo Domingo.

**Inicios**

Empezó en 2015 subiendo covers e improvisaciones a las redes sociales y dejó su casa a los dieciséis años para dedicarse a la música. A los diecisiete conoció al productor Tivi Gunz, que produjo sus primeras canciones; su sello, según un directorio musical, es GunzGangMusic.

**Canciones y colaboraciones**

Los perfiles de prensa incluyen entre sus éxitos «Empaquétate», «Tírate», «Mentolado», «Mi pana», «Rututu», «Mucha nota» y «Dividida», y también es conocido por «Eso E» y «To No Morimo». Además de temas urbanos ha compuesto en trap, rap y balada pop. Ha trabajado con El Alfa, con la banda mexicana Fuerza Regida en «Toretto» y con los dembowseros Onguito Wa y Treintisiete 3730. Entre sus sencillos posteriores figura «Lo Que Pueda» (septiembre de 2025), y en 2026 publicó «Cuánto», «Cadereo» y el dembow «To’ el mundo».

**Reconocimiento**

En 2025 fue nominado a un Premio Lo Nuestro a Mejor Canción Dembow, categoría nueva, con «Déjenme Rulay», grabada con Rochy RD; el premio fue para Lomiiel por «Hay Lupita».

**Legado**

El periódico El Caribe lo describió en 2023 como uno de los exponentes más influyentes del movimiento discográfico urbano dominicano.' WHERE slug = 'donaty';

COMMIT;
