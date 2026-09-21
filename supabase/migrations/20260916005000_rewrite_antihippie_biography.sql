BEGIN;

-- Ficha de AntiHippie: banda de groove metal y hardcore formada en 2013 (el relleno decía artista solista de rock alternativo).
-- Se quita el género "urbano" (sin respaldo) y se fija el año de formación.

UPDATE artists SET genres = '{}'::text[], birth_year = 2013 WHERE slug = 'antihippie';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"AntiHippie is a groove-metal and hardcore band from Santo Domingo, formed in 2013, that describes its style as “narco-metal”."}]},{"type":"paragraph","content":[{"type":"text","text":"The band","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The lineup is Jehison Tavarez on vocals, Radi Pina on guitar, Freddy Muñoz on bass and Mario Luis Ventura on drums. It began as two childhood friends, Jehison and Radi, and grew into a four-piece. Jehison says the “narco-metal” idea started as a satanic take on the theme before he dropped the satanic side, and the band jokes that all its members are hippies despite the name."}]},{"type":"paragraph","content":[{"type":"text","text":"Records","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Its first release was the EP «666» (2013). In late 2016 the band said it had only that EP and expected to release a full album the following year; «Narcoestado» came out in November 2017. A 2016–2017 yearbook of Dominican alternative music lists among its tracks «Perico», «Pederasta», «Narcoestado» and «Complot», and describes the sound as a groove metal with a local flavor, built on syncopated rhythms and harsh vocals. A 2022 survey of Dominican metal read the band’s songs as blunt commentary on drug use and racism. Its YouTube channel also carries «Mantequeros» and a lyric video for «Eugenesia»."}]},{"type":"paragraph","content":[{"type":"text","text":"On stage","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In the two years around the album the band opened for Soulfly, Brujería and A.N.I.M.A.L. at their concerts, and it played the Destrucción Masiva festival in December 2016, on a bill with "},{"type":"artistReference","attrs":{"occurrenceId":"08c7d3ac-7a0c-4c95-8ca4-d9b9a960718d","artistId":"8400a1c5-0f35-4121-ba11-a887a7312443","displayText":"Santuario"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"c9afc186-abb8-42ec-84c0-6e6d30e2def9","artistId":"8fd3269b-6945-4f8d-98d0-51b360f4197c","displayText":"La Armada"}},{"type":"text","text":" among others. Its guitarist described «El Tripletazo», a tradition of a three-band concert on the first Friday after each Destrucción Masiva at the rehearsal space of Santuario, the room from which several local projects, AntiHippie among them, have grown."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The yearbook counted AntiHippie among the most important groups in the Dominican metal scene, and in 2022 the metal site MetalSucks included it in a list of fifteen bands from the Dominican Republic."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'antihippie'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'antihippie' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '08c7d3ac-7a0c-4c95-8ca4-d9b9a960718d', 'artist', '8400a1c5-0f35-4121-ba11-a887a7312443' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'antihippie' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c9afc186-abb8-42ec-84c0-6e6d30e2def9', 'artist', '8fd3269b-6945-4f8d-98d0-51b360f4197c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'antihippie' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'AntiHippie is a groove-metal and hardcore band from Santo Domingo, formed in 2013, that describes its style as “narco-metal”.

**The band**

The lineup is Jehison Tavarez on vocals, Radi Pina on guitar, Freddy Muñoz on bass and Mario Luis Ventura on drums. It began as two childhood friends, Jehison and Radi, and grew into a four-piece. Jehison says the “narco-metal” idea started as a satanic take on the theme before he dropped the satanic side, and the band jokes that all its members are hippies despite the name.

**Records**

Its first release was the EP «666» (2013). In late 2016 the band said it had only that EP and expected to release a full album the following year; «Narcoestado» came out in November 2017. A 2016–2017 yearbook of Dominican alternative music lists among its tracks «Perico», «Pederasta», «Narcoestado» and «Complot», and describes the sound as a groove metal with a local flavor, built on syncopated rhythms and harsh vocals. A 2022 survey of Dominican metal read the band’s songs as blunt commentary on drug use and racism. Its YouTube channel also carries «Mantequeros» and a lyric video for «Eugenesia».

**On stage**

In the two years around the album the band opened for Soulfly, Brujería and A.N.I.M.A.L. at their concerts, and it played the Destrucción Masiva festival in December 2016, on a bill with Santuario and La Armada among others. Its guitarist described «El Tripletazo», a tradition of a three-band concert on the first Friday after each Destrucción Masiva at the rehearsal space of Santuario, the room from which several local projects, AntiHippie among them, have grown.

**Legacy**

The yearbook counted AntiHippie among the most important groups in the Dominican metal scene, and in 2022 the metal site MetalSucks included it in a list of fifteen bands from the Dominican Republic.' WHERE slug = 'antihippie';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"AntiHippie es una banda de groove metal y hardcore de Santo Domingo, formada en 2013, que define su estilo como “narco-metal”."}]},{"type":"paragraph","content":[{"type":"text","text":"La banda","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En la banda, Jehison Tavarez canta, Radi Pina toca la guitarra, Freddy Muñoz el bajo y Mario Luis Ventura la batería. Empezó con dos amigos de la infancia, Jehison y Radi, y creció hasta ser un cuarteto. Jehison cuenta que la idea del “narco-metal” nació con un enfoque satánico que luego abandonó, y la banda bromea con que todos sus integrantes son hippies pese al nombre."}]},{"type":"paragraph","content":[{"type":"text","text":"Grabaciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su primer trabajo fue el EP «666» (2013). A finales de 2016 la banda dijo que solo tenía ese EP y que esperaba sacar un disco completo al año siguiente; «Narcoestado» salió en noviembre de 2017. Un anuario de 2016–2017 sobre la música alternativa dominicana cita entre sus temas «Perico», «Pederasta», «Narcoestado» y «Complot», y describe el sonido como un groove metal de sabor local, apoyado en ritmos sincopados y voces ásperas. Un repaso de 2022 sobre el metal dominicano leyó sus canciones como un comentario directo sobre el consumo de drogas y el racismo. Su canal de YouTube incluye además «Mantequeros» y un video de letra de «Eugenesia»."}]},{"type":"paragraph","content":[{"type":"text","text":"En escena","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En los dos años en torno al disco la banda abrió conciertos de Soulfly, Brujería y A.N.I.M.A.L., y tocó en el festival Destrucción Masiva de diciembre de 2016, en un cartel que incluía a "},{"type":"artistReference","attrs":{"occurrenceId":"31de9005-dcdb-4fea-8253-03fc6851dbd6","artistId":"8400a1c5-0f35-4121-ba11-a887a7312443","displayText":"Santuario"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"250b4970-a0ff-4327-b2f9-d92e907a411c","artistId":"8fd3269b-6945-4f8d-98d0-51b360f4197c","displayText":"La Armada"}},{"type":"text","text":", entre otros. Su guitarrista habló de «El Tripletazo», una tradición de concierto con tres grupos el primer viernes después de cada Destrucción Masiva en la sala de ensayo de Santuario, el espacio del que han salido varios proyectos locales, entre ellos AntiHippie."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El anuario situó a AntiHippie entre los grupos más importantes de la escena metalera dominicana, y en 2022 el sitio de metal MetalSucks la incluyó en una lista de quince bandas de República Dominicana."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'antihippie'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'antihippie' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '31de9005-dcdb-4fea-8253-03fc6851dbd6', 'artist', '8400a1c5-0f35-4121-ba11-a887a7312443' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'antihippie' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '250b4970-a0ff-4327-b2f9-d92e907a411c', 'artist', '8fd3269b-6945-4f8d-98d0-51b360f4197c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'antihippie' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'AntiHippie es una banda de groove metal y hardcore de Santo Domingo, formada en 2013, que define su estilo como “narco-metal”.

**La banda**

En la banda, Jehison Tavarez canta, Radi Pina toca la guitarra, Freddy Muñoz el bajo y Mario Luis Ventura la batería. Empezó con dos amigos de la infancia, Jehison y Radi, y creció hasta ser un cuarteto. Jehison cuenta que la idea del “narco-metal” nació con un enfoque satánico que luego abandonó, y la banda bromea con que todos sus integrantes son hippies pese al nombre.

**Grabaciones**

Su primer trabajo fue el EP «666» (2013). A finales de 2016 la banda dijo que solo tenía ese EP y que esperaba sacar un disco completo al año siguiente; «Narcoestado» salió en noviembre de 2017. Un anuario de 2016–2017 sobre la música alternativa dominicana cita entre sus temas «Perico», «Pederasta», «Narcoestado» y «Complot», y describe el sonido como un groove metal de sabor local, apoyado en ritmos sincopados y voces ásperas. Un repaso de 2022 sobre el metal dominicano leyó sus canciones como un comentario directo sobre el consumo de drogas y el racismo. Su canal de YouTube incluye además «Mantequeros» y un video de letra de «Eugenesia».

**En escena**

En los dos años en torno al disco la banda abrió conciertos de Soulfly, Brujería y A.N.I.M.A.L., y tocó en el festival Destrucción Masiva de diciembre de 2016, en un cartel que incluía a Santuario y La Armada, entre otros. Su guitarrista habló de «El Tripletazo», una tradición de concierto con tres grupos el primer viernes después de cada Destrucción Masiva en la sala de ensayo de Santuario, el espacio del que han salido varios proyectos locales, entre ellos AntiHippie.

**Legado**

El anuario situó a AntiHippie entre los grupos más importantes de la escena metalera dominicana, y en 2022 el sitio de metal MetalSucks la incluyó en una lista de quince bandas de República Dominicana.' WHERE slug = 'antihippie';

COMMIT;
