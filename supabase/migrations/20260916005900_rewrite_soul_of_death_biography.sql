BEGIN;

-- Soul of Death: reescritura de la biografía en registro profesional y estado draft hasta que el editor suba una imagen.

UPDATE artists SET status = 'draft' WHERE slug = 'soul-of-death';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Soul of Death is a melodic death metal band from Santo Domingo, formed in August 2004 by the guitarist Melvin Holguín, who plays as Focalor."}]},{"type":"paragraph","content":[{"type":"text","text":"Two periods","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The band was active from 2004 to 2015 and again since 2020. On its return it said it had been through some turmoil and was rising again with the same strength and brotherhood as before."}]},{"type":"paragraph","content":[{"type":"text","text":"Records","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Its first release was the EP «Apocalipsis», dated 2006 by the international metal database Encyclopaedia Metallum and June 2007 on the band’s Bandcamp page. The single «Spiritual Disease», released on 9 February 2020, marked the comeback, and the full album of the same name followed in 2023 on «Nefast Films Records». The database lists occultism as the band’s early subject and ancestral war, apocalyptic prophecies and mythology as its later ones."}]},{"type":"paragraph","content":[{"type":"text","text":"Reception","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Reviewing «Spiritual Disease» for Metal Forces Magazine, Neil Arnold gave it 7 out of 10. He described it as a well-produced, melodic and savage debut album, at moments a tamer version of Deicide, though better suited to the death metal scene of a decade earlier, and said that some tracks blur into one another."}]},{"type":"paragraph","content":[{"type":"text","text":"Related bands","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Rubén Mahfoud, a member of Soul of Death, also plays in «Múcaro», and Focalor created the one-man project «Sífilis de Nazareth» in 2015. Another former member, Vasago Imn, later played in "},{"type":"artistReference","attrs":{"occurrenceId":"7caa51bc-6795-4904-8dc8-4ccf4948653e","artistId":"3a235020-7be9-4884-b964-9efbd6a3e82f","displayText":"Apofis Imn"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2022 the metal site MetalSucks included Soul of Death in a list of fifteen bands from the Dominican Republic, and in 2023 the site The Dark Melody placed «Spiritual Disease» seventieth among the hundred best Latin American albums of the year."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'soul-of-death'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'soul-of-death' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '7caa51bc-6795-4904-8dc8-4ccf4948653e', 'artist', '3a235020-7be9-4884-b964-9efbd6a3e82f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'soul-of-death' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Soul of Death is a melodic death metal band from Santo Domingo, formed in August 2004 by the guitarist Melvin Holguín, who plays as Focalor.

**Two periods**

The band was active from 2004 to 2015 and again since 2020. On its return it said it had been through some turmoil and was rising again with the same strength and brotherhood as before.

**Records**

Its first release was the EP «Apocalipsis», dated 2006 by the international metal database Encyclopaedia Metallum and June 2007 on the band’s Bandcamp page. The single «Spiritual Disease», released on 9 February 2020, marked the comeback, and the full album of the same name followed in 2023 on «Nefast Films Records». The database lists occultism as the band’s early subject and ancestral war, apocalyptic prophecies and mythology as its later ones.

**Reception**

Reviewing «Spiritual Disease» for Metal Forces Magazine, Neil Arnold gave it 7 out of 10. He described it as a well-produced, melodic and savage debut album, at moments a tamer version of Deicide, though better suited to the death metal scene of a decade earlier, and said that some tracks blur into one another.

**Related bands**

Rubén Mahfoud, a member of Soul of Death, also plays in «Múcaro», and Focalor created the one-man project «Sífilis de Nazareth» in 2015. Another former member, Vasago Imn, later played in Apofis Imn.

**Legacy**

In 2022 the metal site MetalSucks included Soul of Death in a list of fifteen bands from the Dominican Republic, and in 2023 the site The Dark Melody placed «Spiritual Disease» seventieth among the hundred best Latin American albums of the year.' WHERE slug = 'soul-of-death';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Soul of Death es una banda de death metal melódico de Santo Domingo, formada en agosto de 2004 por el guitarrista Melvin Holguín, que toca como Focalor."}]},{"type":"paragraph","content":[{"type":"text","text":"Dos etapas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La banda estuvo activa de 2004 a 2015 y de nuevo desde 2020. A su regreso dijo que había pasado por cierta turbulencia y que se levantaba otra vez con la misma fuerza y la misma hermandad de antes."}]},{"type":"paragraph","content":[{"type":"text","text":"Grabaciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su primer trabajo fue el EP «Apocalipsis», fechado en 2006 por la base de datos internacional Encyclopaedia Metallum y en junio de 2007 en la página de Bandcamp de la banda. El sencillo «Spiritual Disease», publicado el 9 de febrero de 2020, marcó el regreso, y el álbum completo del mismo nombre llegó en 2023 con «Nefast Films Records». La base de datos anota el ocultismo como tema de sus comienzos y la guerra ancestral, las profecías apocalípticas y la mitología como los posteriores."}]},{"type":"paragraph","content":[{"type":"text","text":"Recepción","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Al reseñar «Spiritual Disease» para Metal Forces Magazine, Neil Arnold le dio 7 sobre 10. Lo describió como un álbum debut bien producido, melódico y feroz, por momentos una versión más suave de Deicide, aunque más propio de la escena del death metal de una década antes, y señaló que algunas pistas se confunden entre sí."}]},{"type":"paragraph","content":[{"type":"text","text":"Bandas relacionadas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Rubén Mahfoud, integrante de Soul of Death, toca también en «Múcaro», y Focalor creó en 2015 el proyecto de un solo hombre «Sífilis de Nazareth». Otro exintegrante, Vasago Imn, tocó después en "},{"type":"artistReference","attrs":{"occurrenceId":"019098b8-bb97-422d-ae1b-ccff2db1797e","artistId":"3a235020-7be9-4884-b964-9efbd6a3e82f","displayText":"Apofis Imn"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2022 el sitio de metal MetalSucks incluyó a Soul of Death en una lista de quince bandas de República Dominicana, y en 2023 el sitio The Dark Melody colocó «Spiritual Disease» en el puesto setenta de los cien mejores discos latinoamericanos del año."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'soul-of-death'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'soul-of-death' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '019098b8-bb97-422d-ae1b-ccff2db1797e', 'artist', '3a235020-7be9-4884-b964-9efbd6a3e82f' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'soul-of-death' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Soul of Death es una banda de death metal melódico de Santo Domingo, formada en agosto de 2004 por el guitarrista Melvin Holguín, que toca como Focalor.

**Dos etapas**

La banda estuvo activa de 2004 a 2015 y de nuevo desde 2020. A su regreso dijo que había pasado por cierta turbulencia y que se levantaba otra vez con la misma fuerza y la misma hermandad de antes.

**Grabaciones**

Su primer trabajo fue el EP «Apocalipsis», fechado en 2006 por la base de datos internacional Encyclopaedia Metallum y en junio de 2007 en la página de Bandcamp de la banda. El sencillo «Spiritual Disease», publicado el 9 de febrero de 2020, marcó el regreso, y el álbum completo del mismo nombre llegó en 2023 con «Nefast Films Records». La base de datos anota el ocultismo como tema de sus comienzos y la guerra ancestral, las profecías apocalípticas y la mitología como los posteriores.

**Recepción**

Al reseñar «Spiritual Disease» para Metal Forces Magazine, Neil Arnold le dio 7 sobre 10. Lo describió como un álbum debut bien producido, melódico y feroz, por momentos una versión más suave de Deicide, aunque más propio de la escena del death metal de una década antes, y señaló que algunas pistas se confunden entre sí.

**Bandas relacionadas**

Rubén Mahfoud, integrante de Soul of Death, toca también en «Múcaro», y Focalor creó en 2015 el proyecto de un solo hombre «Sífilis de Nazareth». Otro exintegrante, Vasago Imn, tocó después en Apofis Imn.

**Legado**

En 2022 el sitio de metal MetalSucks incluyó a Soul of Death en una lista de quince bandas de República Dominicana, y en 2023 el sitio The Dark Melody colocó «Spiritual Disease» en el puesto setenta de los cien mejores discos latinoamericanos del año.' WHERE slug = 'soul-of-death';

COMMIT;
