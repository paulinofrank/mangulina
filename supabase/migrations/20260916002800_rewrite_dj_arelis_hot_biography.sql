BEGIN;

-- Ficha de DJ Arelis Hot.
--
-- El relleno no nombraba una sola canción ni el hecho mas distintivo de su carrera: en el video
-- de "Rap de calle" (2017) aparece acreditada en IMDb como directora, guionista, camarografa,
-- editora, doble de riesgo y protagonista a la vez. Sin cambios de campo.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"DJ Arelis Hot —born Arelis Hernández Gómez on 20 June 1975 in San Francisco de Macorís— is a Dominican DJ, singer, songwriter and video producer who has released music independently under her own name since 2008."}]},{"type":"paragraph","content":[{"type":"text","text":"«Rap de calle» and total creative control","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her breakout release, the 2017 music video «Rap de calle», is credited on IMDb with her serving simultaneously as director, writer, cinematographer, editor and stunts performer, in addition to being its lead performer — a degree of hands-on creative control unusual even among independent Dominican artists."}]},{"type":"paragraph","content":[{"type":"text","text":"A catalog built independently","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She has released a steady string of singles and EPs largely through her own label, «El Nitro 56 Music Group», including «Mi HD» and «la pampara» (2019), «Solo Frío» (2020) and «Influencer de redes» (2023), moving across reggaetón romántico, R&B, hip hop and merengue."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Building her career primarily through YouTube and social media rather than radio or television, DJ Arelis Hot has continued releasing music into the 2020s as one of the more self-sufficient independent artists in Dominican urban music, doing much of her own production, direction and camera work rather than relying on a wider creative team."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dj-arelis-hot'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'dj-arelis-hot' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'DJ Arelis Hot —born Arelis Hernández Gómez on 20 June 1975 in San Francisco de Macorís— is a Dominican DJ, singer, songwriter and video producer who has released music independently under her own name since 2008.

**«Rap de calle» and total creative control**

Her breakout release, the 2017 music video «Rap de calle», is credited on IMDb with her serving simultaneously as director, writer, cinematographer, editor and stunts performer, in addition to being its lead performer — a degree of hands-on creative control unusual even among independent Dominican artists.

**A catalog built independently**

She has released a steady string of singles and EPs largely through her own label, «El Nitro 56 Music Group», including «Mi HD» and «la pampara» (2019), «Solo Frío» (2020) and «Influencer de redes» (2023), moving across reggaetón romántico, R&B, hip hop and merengue.

**Legacy**

Building her career primarily through YouTube and social media rather than radio or television, DJ Arelis Hot has continued releasing music into the 2020s as one of the more self-sufficient independent artists in Dominican urban music, doing much of her own production, direction and camera work rather than relying on a wider creative team.' WHERE slug = 'dj-arelis-hot';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"DJ Arelis Hot —nacida Arelis Hernández Gómez el 20 de junio de 1975 en San Francisco de Macorís— es DJ, cantante, compositora y realizadora audiovisual dominicana que publica música de forma independiente bajo su propio nombre desde 2008."}]},{"type":"paragraph","content":[{"type":"text","text":"«Rap de calle» y el control creativo total","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su lanzamiento más destacado, el video musical «Rap de calle» (2017), aparece acreditado en IMDb con ella misma como directora, guionista, camarógrafa, editora y doble de riesgo, además de protagonista — un grado de control creativo directo poco habitual incluso entre artistas independientes dominicanos."}]},{"type":"paragraph","content":[{"type":"text","text":"Una discografía construida de forma independiente","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ha publicado una serie constante de sencillos y EPs, en buena parte a través de su propio sello, «El Nitro 56 Music Group», entre ellos «Mi HD» y «la pampara» (2019), «Solo Frío» (2020) e «Influencer de redes» (2023), moviéndose entre el reguetón romántico, el R&B, el hip hop y el merengue."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Construyendo su carrera principalmente a través de YouTube y las redes sociales, más que de la radio o la televisión, DJ Arelis Hot ha seguido publicando música hacia la década de 2020 como una de las artistas independientes más autosuficientes de la música urbana dominicana, haciendo ella misma buena parte de la producción, dirección y trabajo de cámara en vez de depender de un equipo creativo más amplio."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dj-arelis-hot'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'dj-arelis-hot' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'DJ Arelis Hot —nacida Arelis Hernández Gómez el 20 de junio de 1975 en San Francisco de Macorís— es DJ, cantante, compositora y realizadora audiovisual dominicana que publica música de forma independiente bajo su propio nombre desde 2008.

**«Rap de calle» y el control creativo total**

Su lanzamiento más destacado, el video musical «Rap de calle» (2017), aparece acreditado en IMDb con ella misma como directora, guionista, camarógrafa, editora y doble de riesgo, además de protagonista — un grado de control creativo directo poco habitual incluso entre artistas independientes dominicanos.

**Una discografía construida de forma independiente**

Ha publicado una serie constante de sencillos y EPs, en buena parte a través de su propio sello, «El Nitro 56 Music Group», entre ellos «Mi HD» y «la pampara» (2019), «Solo Frío» (2020) e «Influencer de redes» (2023), moviéndose entre el reguetón romántico, el R&B, el hip hop y el merengue.

**Legado**

Construyendo su carrera principalmente a través de YouTube y las redes sociales, más que de la radio o la televisión, DJ Arelis Hot ha seguido publicando música hacia la década de 2020 como una de las artistas independientes más autosuficientes de la música urbana dominicana, haciendo ella misma buena parte de la producción, dirección y trabajo de cámara en vez de depender de un equipo creativo más amplio.' WHERE slug = 'dj-arelis-hot';

COMMIT;
