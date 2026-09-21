BEGIN;

-- Albert Méndez: cantante de salsa de La Vega (el relleno decía bachata y tropical). primary_genre salsa, songwriter, sin tag emerging, alias con tilde.

UPDATE artists SET birth_place = 'La Vega', province = 'La Vega', primary_genre = 'salsa', occupations = '["songwriter"]'::jsonb, artist_tags = ARRAY['secular']::text[], aliases = ARRAY['Albert Méndez']::text[] WHERE slug = 'albert-mendez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Albert Méndez, from La Vega, is a Dominican singer best known for his 1991 salsa album «Déjenme Vivir» and its song «Qué puedo hacer yo»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Déjenme Vivir»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The album came out in 1991 in the United States on «J&N Records», with editions the same year in Venezuela and Colombia. It was produced by José Mangual Jr. and arranged by several hands, among them Isidro Infante, Ralfy Méndez, Lucho Cueto, José Madera, Charlie Mosquea and "},{"type":"artistReference","attrs":{"occurrenceId":"143c7d34-24ea-4cde-ab2a-98a7210104f7","artistId":"95010ba2-3d12-4976-938d-141737fb2daa","displayText":"Víctor Waill"}},{"type":"text","text":"; Albert Méndez sings lead and wrote «Volvamos a Empezar», «Déjenme Vivir» and «Dulce Amor». The other songs on it include «Sexo y Fuego», «Dulce Palomita», «Quisqueya» and «Déjala Tranquila». A second album for the label, «Regresa», followed in the mid-1990s."}]},{"type":"paragraph","content":[{"type":"text","text":"Before salsa","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"According to a biography submitted to Musica.com, he sang first in groups of the Cibao and recorded bachata, and then joined the merengue orchestras of "},{"type":"artistReference","attrs":{"occurrenceId":"85d09790-9c86-4ca6-a387-8cb40fbbd658","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"481d8d66-ebe5-486b-8f2c-e4f1b4a6bd92","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":", where he replaced "},{"type":"artistReference","attrs":{"occurrenceId":"eca360c2-558e-4d0f-bc0e-bdcc8ad88a49","artistId":"fb068903-a085-4a3f-b846-0be0b3e28934","displayText":"Henry García"}},{"type":"text","text":" and had merengues such as «El palo de anón», «Embarazada» and «Paloma mía». The same account says he toured the Caribbean, Latin America, Europe and the United States before settling in New York, where he began recording with Víctor Waill and was signed by J&N Records."}]},{"type":"paragraph","content":[{"type":"text","text":"Later releases","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His catalogue on the streaming platforms has grown since 2023, with the album «Extrañándote» (2025), the EPs «Orquesta La Grande, Vol. 1» and «Vol. 2» (October 2025), a «Homenaje a Cuco Valoy» (November 2025), and the singles «Pensando En Ti» (2023) and «Ramona» (2026). Some of these may be reissues of earlier material."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Qué puedo hacer yo» is the song most associated with him, and «Déjenme Vivir» is preserved in vinyl and CD editions from the United States, Venezuela and Colombia."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'albert-mendez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'albert-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '143c7d34-24ea-4cde-ab2a-98a7210104f7', 'artist', '95010ba2-3d12-4976-938d-141737fb2daa' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'albert-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '85d09790-9c86-4ca6-a387-8cb40fbbd658', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'albert-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '481d8d66-ebe5-486b-8f2c-e4f1b4a6bd92', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'albert-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'eca360c2-558e-4d0f-bc0e-bdcc8ad88a49', 'artist', 'fb068903-a085-4a3f-b846-0be0b3e28934' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'albert-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Albert Méndez, from La Vega, is a Dominican singer best known for his 1991 salsa album «Déjenme Vivir» and its song «Qué puedo hacer yo».

**«Déjenme Vivir»**

The album came out in 1991 in the United States on «J&N Records», with editions the same year in Venezuela and Colombia. It was produced by José Mangual Jr. and arranged by several hands, among them Isidro Infante, Ralfy Méndez, Lucho Cueto, José Madera, Charlie Mosquea and Víctor Waill; Albert Méndez sings lead and wrote «Volvamos a Empezar», «Déjenme Vivir» and «Dulce Amor». The other songs on it include «Sexo y Fuego», «Dulce Palomita», «Quisqueya» and «Déjala Tranquila». A second album for the label, «Regresa», followed in the mid-1990s.

**Before salsa**

According to a biography submitted to Musica.com, he sang first in groups of the Cibao and recorded bachata, and then joined the merengue orchestras of Cuco Valoy and Ramón Orlando & Orquesta Internacional, where he replaced Henry García and had merengues such as «El palo de anón», «Embarazada» and «Paloma mía». The same account says he toured the Caribbean, Latin America, Europe and the United States before settling in New York, where he began recording with Víctor Waill and was signed by J&N Records.

**Later releases**

His catalogue on the streaming platforms has grown since 2023, with the album «Extrañándote» (2025), the EPs «Orquesta La Grande, Vol. 1» and «Vol. 2» (October 2025), a «Homenaje a Cuco Valoy» (November 2025), and the singles «Pensando En Ti» (2023) and «Ramona» (2026). Some of these may be reissues of earlier material.

**Legacy**

«Qué puedo hacer yo» is the song most associated with him, and «Déjenme Vivir» is preserved in vinyl and CD editions from the United States, Venezuela and Colombia.' WHERE slug = 'albert-mendez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Albert Méndez, de La Vega, es un cantante dominicano conocido sobre todo por su álbum de salsa de 1991 «Déjenme Vivir» y su canción «Qué puedo hacer yo»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Déjenme Vivir»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El álbum salió en 1991 en Estados Unidos con «J&N Records», con ediciones ese mismo año en Venezuela y Colombia. Lo produjo José Mangual Jr. y lo arreglaron varias manos, entre ellas Isidro Infante, Ralfy Méndez, Lucho Cueto, José Madera, Charlie Mosquea y "},{"type":"artistReference","attrs":{"occurrenceId":"ccff693e-fea3-4e44-8817-2aa8ee91e20a","artistId":"95010ba2-3d12-4976-938d-141737fb2daa","displayText":"Víctor Waill"}},{"type":"text","text":"; Albert Méndez canta la voz principal y escribió «Volvamos a Empezar», «Déjenme Vivir» y «Dulce Amor». Entre los demás temas están «Sexo y Fuego», «Dulce Palomita», «Quisqueya» y «Déjala Tranquila». Un segundo álbum para el sello, «Regresa», le siguió a mediados de los años noventa."}]},{"type":"paragraph","content":[{"type":"text","text":"Antes de la salsa","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Según una biografía enviada a Musica.com, cantó primero en grupos del Cibao y grabó bachata, y luego entró en las orquestas de merengue de "},{"type":"artistReference","attrs":{"occurrenceId":"ca1726c0-5558-4083-9bb5-c7fa2720d147","artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"601edfb4-2704-415a-8e31-98fef420405b","artistId":"02f23257-1cf6-4a4c-8df1-1f9aa630a2c3","displayText":"Ramón Orlando & Orquesta Internacional"}},{"type":"text","text":", donde sustituyó a "},{"type":"artistReference","attrs":{"occurrenceId":"85db16fc-7099-42e2-8438-fc82e24aef81","artistId":"fb068903-a085-4a3f-b846-0be0b3e28934","displayText":"Henry García"}},{"type":"text","text":" y tuvo merengues como «El palo de anón», «Embarazada» y «Paloma mía». El mismo relato dice que hizo giras por el Caribe, Latinoamérica, Europa y Estados Unidos antes de instalarse en Nueva York, donde empezó a grabar con Víctor Waill y fue fichado por J&N Records."}]},{"type":"paragraph","content":[{"type":"text","text":"Lanzamientos posteriores","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su catálogo en las plataformas de streaming ha crecido desde 2023, con el álbum «Extrañándote» (2025), los EP «Orquesta La Grande, Vol. 1» y «Vol. 2» (octubre de 2025), un «Homenaje a Cuco Valoy» (noviembre de 2025) y los sencillos «Pensando En Ti» (2023) y «Ramona» (2026). Algunos pueden ser reediciones de material anterior."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Qué puedo hacer yo» es la canción que más se le asocia, y «Déjenme Vivir» se conserva en ediciones en vinilo y CD de Estados Unidos, Venezuela y Colombia."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'albert-mendez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'albert-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'ccff693e-fea3-4e44-8817-2aa8ee91e20a', 'artist', '95010ba2-3d12-4976-938d-141737fb2daa' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'albert-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'ca1726c0-5558-4083-9bb5-c7fa2720d147', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'albert-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '601edfb4-2704-415a-8e31-98fef420405b', 'artist', '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'albert-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '85db16fc-7099-42e2-8438-fc82e24aef81', 'artist', 'fb068903-a085-4a3f-b846-0be0b3e28934' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'albert-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Albert Méndez, de La Vega, es un cantante dominicano conocido sobre todo por su álbum de salsa de 1991 «Déjenme Vivir» y su canción «Qué puedo hacer yo».

**«Déjenme Vivir»**

El álbum salió en 1991 en Estados Unidos con «J&N Records», con ediciones ese mismo año en Venezuela y Colombia. Lo produjo José Mangual Jr. y lo arreglaron varias manos, entre ellas Isidro Infante, Ralfy Méndez, Lucho Cueto, José Madera, Charlie Mosquea y Víctor Waill; Albert Méndez canta la voz principal y escribió «Volvamos a Empezar», «Déjenme Vivir» y «Dulce Amor». Entre los demás temas están «Sexo y Fuego», «Dulce Palomita», «Quisqueya» y «Déjala Tranquila». Un segundo álbum para el sello, «Regresa», le siguió a mediados de los años noventa.

**Antes de la salsa**

Según una biografía enviada a Musica.com, cantó primero en grupos del Cibao y grabó bachata, y luego entró en las orquestas de merengue de Cuco Valoy y Ramón Orlando & Orquesta Internacional, donde sustituyó a Henry García y tuvo merengues como «El palo de anón», «Embarazada» y «Paloma mía». El mismo relato dice que hizo giras por el Caribe, Latinoamérica, Europa y Estados Unidos antes de instalarse en Nueva York, donde empezó a grabar con Víctor Waill y fue fichado por J&N Records.

**Lanzamientos posteriores**

Su catálogo en las plataformas de streaming ha crecido desde 2023, con el álbum «Extrañándote» (2025), los EP «Orquesta La Grande, Vol. 1» y «Vol. 2» (octubre de 2025), un «Homenaje a Cuco Valoy» (noviembre de 2025) y los sencillos «Pensando En Ti» (2023) y «Ramona» (2026). Algunos pueden ser reediciones de material anterior.

**Legado**

«Qué puedo hacer yo» es la canción que más se le asocia, y «Déjenme Vivir» se conserva en ediciones en vinilo y CD de Estados Unidos, Venezuela y Colombia.' WHERE slug = 'albert-mendez';

COMMIT;
