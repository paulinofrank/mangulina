BEGIN;

-- Ficha de Daniel Santacruz.
--
-- Campos: last_name Cruz, second_last_name Sánchez. Forbes Centroamérica: su nombre
-- de pila es Daniel Cruz Sánchez y el artístico une los dos apellidos; el alias
-- "Daniel Cruz" de la fila coincide.
-- Parentesco nuevo: sibling con Manny Cruz (Wikipedia en, Forbes, Diario Libre).
--
-- Premios: el Latin Grammy de 2020 se registra en la categoría que da el archivo
-- oficial (Mejor Álbum Tropical Contemporáneo); Forbes y Wikipedia la llaman
-- Mejor Álbum de Merengue y/o Bachata. Siete nominaciones del mismo archivo.
-- Categoría nueva Premios Soberano / Compositor del Año: existe con ese nombre en
-- la época Casandra y sigue entregándose en la época Soberano.

UPDATE artists SET last_name = 'Cruz', second_last_name = 'Sánchez' WHERE slug = 'daniel-santacruz';

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Compositor del Año' FROM awards a WHERE a.name = 'Premios Soberano'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Compositor del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2009, 'Radio Rompecorazones', false, 'latingrammy.com, archivo del artista; Wikipedia (en) e Impacto Latino (dos nominaciones por el disco)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'daniel-santacruz' AND a.name = 'Latin Grammy' AND cat.name = 'Best Contemporary Tropical Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2009 AND coalesce(w.work,'') = coalesce('Radio Rompecorazones',''));
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2009, '¿A dónde va el amor?', false, 'latingrammy.com, archivo del artista; Wikipedia (en)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'daniel-santacruz' AND a.name = 'Latin Grammy' AND cat.name = 'Best Tropical Song'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2009 AND coalesce(w.work,'') = coalesce('¿A dónde va el amor?',''));
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2011, 'Bachata Stereo', false, 'latingrammy.com, archivo del artista; Wikipedia (en) e Impacto Latino'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'daniel-santacruz' AND a.name = 'Latin Grammy' AND cat.name = 'Best Contemporary Tropical Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2011 AND coalesce(w.work,'') = coalesce('Bachata Stereo',''));
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2016, 'Toda la vida', false, 'latingrammy.com, archivo del artista; Wikipedia (en)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'daniel-santacruz' AND a.name = 'Latin Grammy' AND cat.name = 'Best Contemporary Tropical Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2016 AND coalesce(w.work,'') = coalesce('Toda la vida',''));
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2016, 'La carretera', false, 'latingrammy.com, archivo del artista; Wikipedia (en); coescrita con Prince Royce'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'daniel-santacruz' AND a.name = 'Latin Grammy' AND cat.name = 'Best Tropical Song'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2016 AND coalesce(w.work,'') = coalesce('La carretera',''));
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2017, 'Deja vu', false, 'latingrammy.com, archivo del artista; autoría con Manny Cruz según Forbes Centroamérica'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'daniel-santacruz' AND a.name = 'Latin Grammy' AND cat.name = 'Best Tropical Song'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2017 AND coalesce(w.work,'') = coalesce('Deja vu',''));
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2018, 'Momentos de cine', false, 'latingrammy.com, archivo del artista; Wikipedia (en)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'daniel-santacruz' AND a.name = 'Latin Grammy' AND cat.name = 'Best Contemporary Tropical Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2018 AND coalesce(w.work,'') = coalesce('Momentos de cine',''));
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2020, 'Larimar', true, 'latingrammy.com, archivo del artista (21.a entrega); Forbes Centroamérica 28 dic 2020 y Wikipedia (en) confirman el premio pero lo nombran Mejor Álbum de Merengue y/o Bachata'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'daniel-santacruz' AND a.name = 'Latin Grammy' AND cat.name = 'Best Contemporary Tropical Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2020 AND coalesce(w.work,'') = coalesce('Larimar',''));
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2017, NULL, true, 'Inter News Service 21 mar 2018 ("por segundo año consecutivo"); listas de Wikipedia (es), EcuRed y Pronto'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'daniel-santacruz' AND a.name = 'Premios Soberano' AND cat.name = 'Compositor del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2017 AND coalesce(w.work,'') = coalesce(NULL,''));
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2018, NULL, true, 'Diario Libre 27 abr 2018 e Inter News Service 21 mar 2018'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'daniel-santacruz' AND a.name = 'Premios Soberano' AND cat.name = 'Compositor del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2018 AND coalesce(w.work,'') = coalesce(NULL,''));

INSERT INTO artist_family_relationships (artist_id, related_artist_id, relationship_type)
SELECT a.id, b.id, 'sibling' FROM artists a, artists b
 WHERE a.slug = 'daniel-santacruz' AND b.slug = 'manny-cruz'
   AND NOT EXISTS (SELECT 1 FROM artist_family_relationships f WHERE f.relationship_type = 'sibling'
     AND ((f.artist_id = a.id AND f.related_artist_id = b.id) OR (f.artist_id = b.id AND f.related_artist_id = a.id)));

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Daniel Santacruz — Daniel Cruz Sánchez, born in New Jersey on 23 November 1976 and raised in the Dominican Republic — is a singer, songwriter and producer of bachata, merengue and kizomba. A former singer with "},{"type":"artistReference","attrs":{"occurrenceId":"a00f93e9-e45a-44c7-80d3-118a32cf875f","artistId":"6fb949c4-2d6f-437f-8e7f-5f9efec847da","displayText":"Rikarena"}},{"type":"text","text":", he has written hits for "},{"type":"artistReference","attrs":{"occurrenceId":"ae7ae9fa-3e3b-4f8e-bb84-b5f212fc836c","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"f2652c66-cc57-4223-b684-620602bd6338","artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"08da6d48-471d-499b-843d-7260dcbb1882","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":", was named Songwriter of the Year at the «Premios Soberano» in 2017 and 2018, and won his first Latin Grammy in 2020, with his seventh album, «Larimar»."}]},{"type":"paragraph","content":[{"type":"text","text":"A family of music","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His father is Cuban and his mother Dominican. The stage name joins his two surnames, a way of honouring his mother, Milagros Sánchez, who writes poetry and used to sing him boleros. His maternal grandmother, a pianist and piano teacher, gave him his first lessons, though he says he paid little attention until his teens. His brother is the singer and songwriter "},{"type":"artistReference","attrs":{"occurrenceId":"6b949570-183d-4b4e-a18c-5d35f3c119d7","artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Merengue bands and a first guitar","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He turned professional in 1996. At twenty he sang with the merengue band «Massá» and two years later moved to "},{"type":"artistReference","attrs":{"occurrenceId":"72815463-fc97-4313-90c8-d0978280f078","artistId":"6fb949c4-2d6f-437f-8e7f-5f9efec847da","displayText":"Rikarena"}},{"type":"text","text":"; on a tour of Colombia with that orchestra, at the end of the nineties, he bought his first guitar, taught himself to play and began writing songs. In the same years he sang backing vocals on other artists’ records and on radio and television jingles, and worked with "},{"type":"artistReference","attrs":{"occurrenceId":"aba0abc2-eb35-44a9-aab3-7e9279a8c159","artistId":"4d3a653c-688e-47c1-8cec-b8cf85a4abac","displayText":"Manuel Tejada"}},{"type":"text","text":". From 2000 to 2002 he sang in the choir of the church where "},{"type":"artistReference","attrs":{"occurrenceId":"e1995983-6719-4532-9c3d-4b21ec5b8db6","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":" is musical director."}]},{"type":"paragraph","content":[{"type":"text","text":"Records under his own name","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His first solo album, «Por un beso» (2003), co-produced with Ambiorix Francisco, earned him a «Premio Lo Nuestro» nomination as best new artist. He then spent several years writing and producing for others. «Radio Rompecorazones» (2008), made with Alejandro Jaén, and its single «¿A dónde va el amor?» brought two Latin Grammy nominations in 2009, and «Bachata Stereo» (2011) a third. «Lo dice la gente» followed in 2014, «Toda la vida» (2016), a tribute to the Mexican singer Emmanuel, and «Momentos de cine» (2018), both nominated as well. «Larimar» (2020), named after the blue stone found only in the Dominican Republic, won Best Contemporary Tropical Album, after eight nominations. He releases his records independently and produces them himself."}]},{"type":"paragraph","content":[{"type":"text","text":"Kizomba","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In the mid-2010s he took up kizomba, the Angolan dance music, and reshaped it with tropical harmonies and Spanish lyrics. «Lento», with a video featuring the dancer Sara López, became the most requested song at his concerts, and in the summer of 2020 more than half a million TikTok videos used it. His music found a large audience in Europe, where he has toured Switzerland, Spain, France and Portugal."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs for other voices","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Much of his reputation rests on his writing. "},{"type":"artistReference","attrs":{"occurrenceId":"786d3a6e-1272-4987-9d4a-a4d8a0c9dd26","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":" has recorded his «Incondicional», «Soy el mismo» and «La carretera», which they wrote together; with "},{"type":"artistReference","attrs":{"occurrenceId":"a7624e8f-f439-433d-b5d7-765466f1ee8e","artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz"}},{"type":"text","text":" he wrote «Deja vu» for "},{"type":"artistReference","attrs":{"occurrenceId":"d6a95ebd-71c6-4c1c-9f97-f61bbe69db4d","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":" and Shakira. "},{"type":"artistReference","attrs":{"occurrenceId":"b0432d55-1f17-4729-b7c5-87ae9bcd7a50","artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra"}},{"type":"text","text":" won a Billboard award with his «Perdidos» and also recorded «No es una novela», and "},{"type":"artistReference","attrs":{"occurrenceId":"c6ad8bf4-4863-4ce9-a852-b65a91948526","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":" had a hit with «Tu veneno». His songs have also been recorded by "},{"type":"artistReference","attrs":{"occurrenceId":"3a935937-0d59-49c4-b0c4-df02e5f5276a","artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"0a20791e-4995-40a5-8730-5279a6e541bb","artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"393dcc62-13c8-486a-8af2-8623186d08c0","artistId":"7b9ee34b-4438-4032-b827-0b748086e223","displayText":"Wason Brazobán"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"1f11ac16-a454-4823-a10a-b9eeb9356ad5","artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"559a7a85-6d94-4f0e-b029-7a4892ff93b1","artistId":"1cd11a22-573a-43b4-8f54-fbd08329a4e2","displayText":"Ilegales"}},{"type":"text","text":". He has received twelve «ASCAP» awards and, in 2018, a Latin Billboard shared with his brother. He has also sung in duet with "},{"type":"artistReference","attrs":{"occurrenceId":"6f85235c-4123-4aa4-8a02-6040722b321e","artistId":"8dcfc4e1-9af4-4378-9e19-52573af429a7","displayText":"Henry Santos"}},{"type":"text","text":", on «Friends & Legends» (2021), and with "},{"type":"artistReference","attrs":{"occurrenceId":"881f81d8-2e27-43f4-9c41-6a63e1dac5bc","artistId":"500a19b6-489a-42f1-9986-f4aa41e07b32","displayText":"Voz a Voz"}},{"type":"text","text":", on «Duele saber»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Daniel Santacruz belongs to the generation of Dominican songwriters whose work travels mostly under other names, and alongside that work he built a recording career of his own that reached audiences far from the Caribbean. His Spanish-language kizomba made him one of the genre’s pioneers in the Latin market."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'daniel-santacruz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a00f93e9-e45a-44c7-80d3-118a32cf875f', 'artist', '6fb949c4-2d6f-437f-8e7f-5f9efec847da' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ae7ae9fa-3e3b-4f8e-bb84-b5f212fc836c', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f2652c66-cc57-4223-b684-620602bd6338', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '08da6d48-471d-499b-843d-7260dcbb1882', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6b949570-183d-4b4e-a18c-5d35f3c119d7', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '72815463-fc97-4313-90c8-d0978280f078', 'artist', '6fb949c4-2d6f-437f-8e7f-5f9efec847da' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'aba0abc2-eb35-44a9-aab3-7e9279a8c159', 'artist', '4d3a653c-688e-47c1-8cec-b8cf85a4abac' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e1995983-6719-4532-9c3d-4b21ec5b8db6', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '786d3a6e-1272-4987-9d4a-a4d8a0c9dd26', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a7624e8f-f439-433d-b5d7-765466f1ee8e', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd6a95ebd-71c6-4c1c-9f97-f61bbe69db4d', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b0432d55-1f17-4729-b7c5-87ae9bcd7a50', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c6ad8bf4-4863-4ce9-a852-b65a91948526', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3a935937-0d59-49c4-b0c4-df02e5f5276a', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0a20791e-4995-40a5-8730-5279a6e541bb', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '393dcc62-13c8-486a-8af2-8623186d08c0', 'artist', '7b9ee34b-4438-4032-b827-0b748086e223' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1f11ac16-a454-4823-a10a-b9eeb9356ad5', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '559a7a85-6d94-4f0e-b029-7a4892ff93b1', 'artist', '1cd11a22-573a-43b4-8f54-fbd08329a4e2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6f85235c-4123-4aa4-8a02-6040722b321e', 'artist', '8dcfc4e1-9af4-4378-9e19-52573af429a7' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '881f81d8-2e27-43f4-9c41-6a63e1dac5bc', 'artist', '500a19b6-489a-42f1-9986-f4aa41e07b32' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Daniel Santacruz — Daniel Cruz Sánchez, born in New Jersey on 23 November 1976 and raised in the Dominican Republic — is a singer, songwriter and producer of bachata, merengue and kizomba. A former singer with Rikarena, he has written hits for Prince Royce, Monchy & Alexandra and Héctor Acosta “El Torito”, was named Songwriter of the Year at the «Premios Soberano» in 2017 and 2018, and won his first Latin Grammy in 2020, with his seventh album, «Larimar».

**A family of music**

His father is Cuban and his mother Dominican. The stage name joins his two surnames, a way of honouring his mother, Milagros Sánchez, who writes poetry and used to sing him boleros. His maternal grandmother, a pianist and piano teacher, gave him his first lessons, though he says he paid little attention until his teens. His brother is the singer and songwriter Manny Cruz.

**Merengue bands and a first guitar**

He turned professional in 1996. At twenty he sang with the merengue band «Massá» and two years later moved to Rikarena; on a tour of Colombia with that orchestra, at the end of the nineties, he bought his first guitar, taught himself to play and began writing songs. In the same years he sang backing vocals on other artists’ records and on radio and television jingles, and worked with Manuel Tejada. From 2000 to 2002 he sang in the choir of the church where Juan Luis Guerra 4.40 is musical director.

**Records under his own name**

His first solo album, «Por un beso» (2003), co-produced with Ambiorix Francisco, earned him a «Premio Lo Nuestro» nomination as best new artist. He then spent several years writing and producing for others. «Radio Rompecorazones» (2008), made with Alejandro Jaén, and its single «¿A dónde va el amor?» brought two Latin Grammy nominations in 2009, and «Bachata Stereo» (2011) a third. «Lo dice la gente» followed in 2014, «Toda la vida» (2016), a tribute to the Mexican singer Emmanuel, and «Momentos de cine» (2018), both nominated as well. «Larimar» (2020), named after the blue stone found only in the Dominican Republic, won Best Contemporary Tropical Album, after eight nominations. He releases his records independently and produces them himself.

**Kizomba**

In the mid-2010s he took up kizomba, the Angolan dance music, and reshaped it with tropical harmonies and Spanish lyrics. «Lento», with a video featuring the dancer Sara López, became the most requested song at his concerts, and in the summer of 2020 more than half a million TikTok videos used it. His music found a large audience in Europe, where he has toured Switzerland, Spain, France and Portugal.

**Songs for other voices**

Much of his reputation rests on his writing. Prince Royce has recorded his «Incondicional», «Soy el mismo» and «La carretera», which they wrote together; with Manny Cruz he wrote «Deja vu» for Prince Royce and Shakira. Monchy & Alexandra won a Billboard award with his «Perdidos» and also recorded «No es una novela», and Héctor Acosta “El Torito” had a hit with «Tu veneno». His songs have also been recorded by Milly Quezada, Frank Reyes, Wason Brazobán, Eddy Herrera and Ilegales. He has received twelve «ASCAP» awards and, in 2018, a Latin Billboard shared with his brother. He has also sung in duet with Henry Santos, on «Friends & Legends» (2021), and with Voz a Voz, on «Duele saber».

**Legacy**

Daniel Santacruz belongs to the generation of Dominican songwriters whose work travels mostly under other names, and alongside that work he built a recording career of his own that reached audiences far from the Caribbean. His Spanish-language kizomba made him one of the genre’s pioneers in the Latin market.' WHERE slug = 'daniel-santacruz';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Daniel Santacruz —Daniel Cruz Sánchez, nacido en Nueva Jersey el 23 de noviembre de 1976 y criado en la República Dominicana— es cantante, compositor y productor de bachata, merengue y kizomba. Excantante de "},{"type":"artistReference","attrs":{"occurrenceId":"6dbf5eee-40c2-456c-a4ac-f20688e8c0bf","artistId":"6fb949c4-2d6f-437f-8e7f-5f9efec847da","displayText":"Rikarena"}},{"type":"text","text":", ha escrito éxitos para "},{"type":"artistReference","attrs":{"occurrenceId":"a9bbd9e8-21ca-4268-8824-44390637d00c","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"1abda53e-1f4c-49ec-8967-3114db62dbbe","artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"aaeb6256-3022-461f-b7da-18f3c674be09","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":", fue Compositor del Año en los «Premios Soberano» de 2017 y 2018 y ganó su primer Latin Grammy en 2020 con su séptimo disco, «Larimar»."}]},{"type":"paragraph","content":[{"type":"text","text":"Una familia de música","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su padre es cubano y su madre, dominicana. El nombre artístico une sus dos apellidos para honrar a su madre, Milagros Sánchez, que escribe poesía y le cantaba boleros de niño. Su abuela materna, pianista y profesora de piano, le dio las primeras lecciones, aunque él admite que no le prestaba mucha atención hasta la adolescencia. Su hermano es el cantante y compositor "},{"type":"artistReference","attrs":{"occurrenceId":"dbabcc52-81c6-40a1-9710-3ff07e3f149b","artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Orquestas de merengue y una primera guitarra","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Se hizo profesional en 1996. A los veinte años cantaba en la banda de merengue «Massá», y dos años después pasó a "},{"type":"artistReference","attrs":{"occurrenceId":"82fea27a-a005-4264-9f07-0f57a267aa8f","artistId":"6fb949c4-2d6f-437f-8e7f-5f9efec847da","displayText":"Rikarena"}},{"type":"text","text":"; en una gira por Colombia con esa orquesta, a finales de los noventa, se compró su primera guitarra, aprendió a tocarla por su cuenta y empezó a escribir canciones. Por esos años hizo coros en grabaciones de otros artistas y en anuncios de radio y televisión, y trabajó con "},{"type":"artistReference","attrs":{"occurrenceId":"9f0b3eed-2ced-4b0a-9449-6afe389e2189","artistId":"4d3a653c-688e-47c1-8cec-b8cf85a4abac","displayText":"Manuel Tejada"}},{"type":"text","text":". De 2000 a 2002 cantó en el coro de la iglesia en la que "},{"type":"artistReference","attrs":{"occurrenceId":"49018614-f39d-4833-bc2f-e67396418d5d","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":" es director musical."}]},{"type":"paragraph","content":[{"type":"text","text":"Discos con su nombre","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su primer disco como solista, «Por un beso» (2003), coproducido con Ambiorix Francisco, le valió una nominación a «Premio Lo Nuestro» como artista revelación. Después pasó varios años escribiendo y produciendo para otros. «Radio Rompecorazones» (2008), hecho con Alejandro Jaén, y su sencillo «¿A dónde va el amor?» le dieron dos nominaciones al Latin Grammy en 2009, y «Bachata Stereo» (2011), una tercera. Siguieron «Lo dice la gente» (2014), «Toda la vida» (2016), homenaje al cantante mexicano Emmanuel, y «Momentos de cine» (2018), ambos también nominados. «Larimar» (2020), con el nombre de la piedra azul que solo se encuentra en la República Dominicana, ganó el premio a Mejor Álbum Tropical Contemporáneo después de ocho nominaciones. Publica sus discos de forma independiente y los produce él mismo."}]},{"type":"paragraph","content":[{"type":"text","text":"La kizomba","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A mediados de la década de 2010 adoptó la kizomba, música bailable de Angola, y la rehízo con armonías tropicales y letras en español. «Lento», con un video en el que baila Sara López, pasó a ser la canción más pedida en sus conciertos, y en el verano de 2020 se usó en más de medio millón de videos de TikTok. Su música encontró un público amplio en Europa, donde ha hecho giras por Suiza, España, Francia y Portugal."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones para otras voces","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Buena parte de su prestigio viene de la composición. "},{"type":"artistReference","attrs":{"occurrenceId":"aee843d4-ce67-4db2-9cb9-c9c0fed3282c","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":" le ha grabado «Incondicional», «Soy el mismo» y «La carretera», escrita entre los dos; con "},{"type":"artistReference","attrs":{"occurrenceId":"3e844192-86f7-438b-841a-66690561bbb0","artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz"}},{"type":"text","text":" compuso «Deja vu» para "},{"type":"artistReference","attrs":{"occurrenceId":"ddd39e8d-ba6f-4209-9ddf-d570d9d85b4a","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":" y Shakira. "},{"type":"artistReference","attrs":{"occurrenceId":"4d42a3a6-e24b-4f10-b9cd-898a56f1ca5a","artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra"}},{"type":"text","text":" ganó un premio Billboard con su «Perdidos» y grabó también «No es una novela», y "},{"type":"artistReference","attrs":{"occurrenceId":"a6638c86-2ff7-49c0-945a-3abd036784e1","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":" pegó «Tu veneno». También le han grabado "},{"type":"artistReference","attrs":{"occurrenceId":"17ec6b08-f0db-46fc-871a-ed3d2055e265","artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"74f0c45c-439d-4e79-afbc-5889320a5c1a","artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"4d673d1f-8dda-4df2-91f5-c7de76c500f0","artistId":"7b9ee34b-4438-4032-b827-0b748086e223","displayText":"Wason Brazobán"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"4dfc336a-f2fa-4fc3-9b77-518bd47dfbbf","artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera"}},{"type":"text","text":" e "},{"type":"artistReference","attrs":{"occurrenceId":"d9178761-8c76-4fd5-a803-b52c863396df","artistId":"1cd11a22-573a-43b4-8f54-fbd08329a4e2","displayText":"Ilegales"}},{"type":"text","text":". Suma doce premios «ASCAP» y, en 2018, un Latin Billboard compartido con su hermano. Ha cantado además a dúo con "},{"type":"artistReference","attrs":{"occurrenceId":"a14829b5-6d48-41a9-a678-d45a2719e726","artistId":"8dcfc4e1-9af4-4378-9e19-52573af429a7","displayText":"Henry Santos"}},{"type":"text","text":", en «Friends & Legends» (2021), y con "},{"type":"artistReference","attrs":{"occurrenceId":"00dd9482-db6e-4afa-be03-9fd91a00aec1","artistId":"500a19b6-489a-42f1-9986-f4aa41e07b32","displayText":"Voz a Voz"}},{"type":"text","text":", en «Duele saber»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Daniel Santacruz pertenece a la generación de compositores dominicanos cuya obra viaja casi siempre con otros nombres, y junto a ese trabajo levantó una carrera discográfica propia que llegó a públicos muy lejos del Caribe. Sus kizombas en español lo convirtieron en uno de los pioneros del género en el mercado latino."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'daniel-santacruz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6dbf5eee-40c2-456c-a4ac-f20688e8c0bf', 'artist', '6fb949c4-2d6f-437f-8e7f-5f9efec847da' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a9bbd9e8-21ca-4268-8824-44390637d00c', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1abda53e-1f4c-49ec-8967-3114db62dbbe', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'aaeb6256-3022-461f-b7da-18f3c674be09', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dbabcc52-81c6-40a1-9710-3ff07e3f149b', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '82fea27a-a005-4264-9f07-0f57a267aa8f', 'artist', '6fb949c4-2d6f-437f-8e7f-5f9efec847da' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9f0b3eed-2ced-4b0a-9449-6afe389e2189', 'artist', '4d3a653c-688e-47c1-8cec-b8cf85a4abac' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '49018614-f39d-4833-bc2f-e67396418d5d', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'aee843d4-ce67-4db2-9cb9-c9c0fed3282c', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3e844192-86f7-438b-841a-66690561bbb0', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ddd39e8d-ba6f-4209-9ddf-d570d9d85b4a', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4d42a3a6-e24b-4f10-b9cd-898a56f1ca5a', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a6638c86-2ff7-49c0-945a-3abd036784e1', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '17ec6b08-f0db-46fc-871a-ed3d2055e265', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '74f0c45c-439d-4e79-afbc-5889320a5c1a', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4d673d1f-8dda-4df2-91f5-c7de76c500f0', 'artist', '7b9ee34b-4438-4032-b827-0b748086e223' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4dfc336a-f2fa-4fc3-9b77-518bd47dfbbf', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd9178761-8c76-4fd5-a803-b52c863396df', 'artist', '1cd11a22-573a-43b4-8f54-fbd08329a4e2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a14829b5-6d48-41a9-a678-d45a2719e726', 'artist', '8dcfc4e1-9af4-4378-9e19-52573af429a7' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '00dd9482-db6e-4afa-be03-9fd91a00aec1', 'artist', '500a19b6-489a-42f1-9986-f4aa41e07b32' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'daniel-santacruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Daniel Santacruz —Daniel Cruz Sánchez, nacido en Nueva Jersey el 23 de noviembre de 1976 y criado en la República Dominicana— es cantante, compositor y productor de bachata, merengue y kizomba. Excantante de Rikarena, ha escrito éxitos para Prince Royce, Monchy & Alexandra y Héctor Acosta “El Torito”, fue Compositor del Año en los «Premios Soberano» de 2017 y 2018 y ganó su primer Latin Grammy en 2020 con su séptimo disco, «Larimar».

**Una familia de música**

Su padre es cubano y su madre, dominicana. El nombre artístico une sus dos apellidos para honrar a su madre, Milagros Sánchez, que escribe poesía y le cantaba boleros de niño. Su abuela materna, pianista y profesora de piano, le dio las primeras lecciones, aunque él admite que no le prestaba mucha atención hasta la adolescencia. Su hermano es el cantante y compositor Manny Cruz.

**Orquestas de merengue y una primera guitarra**

Se hizo profesional en 1996. A los veinte años cantaba en la banda de merengue «Massá», y dos años después pasó a Rikarena; en una gira por Colombia con esa orquesta, a finales de los noventa, se compró su primera guitarra, aprendió a tocarla por su cuenta y empezó a escribir canciones. Por esos años hizo coros en grabaciones de otros artistas y en anuncios de radio y televisión, y trabajó con Manuel Tejada. De 2000 a 2002 cantó en el coro de la iglesia en la que Juan Luis Guerra 4.40 es director musical.

**Discos con su nombre**

Su primer disco como solista, «Por un beso» (2003), coproducido con Ambiorix Francisco, le valió una nominación a «Premio Lo Nuestro» como artista revelación. Después pasó varios años escribiendo y produciendo para otros. «Radio Rompecorazones» (2008), hecho con Alejandro Jaén, y su sencillo «¿A dónde va el amor?» le dieron dos nominaciones al Latin Grammy en 2009, y «Bachata Stereo» (2011), una tercera. Siguieron «Lo dice la gente» (2014), «Toda la vida» (2016), homenaje al cantante mexicano Emmanuel, y «Momentos de cine» (2018), ambos también nominados. «Larimar» (2020), con el nombre de la piedra azul que solo se encuentra en la República Dominicana, ganó el premio a Mejor Álbum Tropical Contemporáneo después de ocho nominaciones. Publica sus discos de forma independiente y los produce él mismo.

**La kizomba**

A mediados de la década de 2010 adoptó la kizomba, música bailable de Angola, y la rehízo con armonías tropicales y letras en español. «Lento», con un video en el que baila Sara López, pasó a ser la canción más pedida en sus conciertos, y en el verano de 2020 se usó en más de medio millón de videos de TikTok. Su música encontró un público amplio en Europa, donde ha hecho giras por Suiza, España, Francia y Portugal.

**Canciones para otras voces**

Buena parte de su prestigio viene de la composición. Prince Royce le ha grabado «Incondicional», «Soy el mismo» y «La carretera», escrita entre los dos; con Manny Cruz compuso «Deja vu» para Prince Royce y Shakira. Monchy & Alexandra ganó un premio Billboard con su «Perdidos» y grabó también «No es una novela», y Héctor Acosta “El Torito” pegó «Tu veneno». También le han grabado Milly Quezada, Frank Reyes, Wason Brazobán, Eddy Herrera e Ilegales. Suma doce premios «ASCAP» y, en 2018, un Latin Billboard compartido con su hermano. Ha cantado además a dúo con Henry Santos, en «Friends & Legends» (2021), y con Voz a Voz, en «Duele saber».

**Legado**

Daniel Santacruz pertenece a la generación de compositores dominicanos cuya obra viaja casi siempre con otros nombres, y junto a ese trabajo levantó una carrera discográfica propia que llegó a públicos muy lejos del Caribe. Sus kizombas en español lo convirtieron en uno de los pioneros del género en el mercado latino.' WHERE slug = 'daniel-santacruz';

COMMIT;
