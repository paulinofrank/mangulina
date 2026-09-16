BEGIN;

-- Ficha de Mélida Rodríguez.
--
-- La biografía de relleno la reducía a una artista "sin gran visibilidad comercial" sin
-- mencionar que fue la primera mujer en grabar bachata en RD (fuente: iASO Records).
-- death_year corregido de 1982 a 1975 (iASO Records + mb_metadata.life-span.end + verificación
-- cruzada con la ficha de Aridia Ventura); date_of_death limpiado por no tener fuente de día
-- exacto. Ver conflicto anotado en CONFLICTOS_DE_DATO.md.

UPDATE artists SET death_year = 1975, date_of_death = NULL WHERE slug = 'melida-rodriguez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Mélida Rodríguez was a Dominican bachata singer and songwriter, born in Hato Mayor in 1943, and the first woman to record the genre, following the guitar-bolero style of the Puerto Rican singer Blanca Iris Villafañe."}]},{"type":"paragraph","content":[{"type":"text","text":"«Yo soy mala, y seguiré siendo mala»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She began recording in the early years of Dominican bachata, alongside its first male pioneers, backed by the same musicians who played on records by "},{"type":"artistReference","attrs":{"occurrenceId":"ef662684-51e2-4edc-80b9-ca114cdbad3f","artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón"}},{"type":"text","text":" and Fabio Sanabia. She wrote most of her own material, and her signature song, «La Sufrida», is considered the best-known early bachata sung entirely from a woman’s point of view: its chorus, an unrepentant declaration of independence, was a striking statement of feminine freedom for its time."}]},{"type":"paragraph","content":[{"type":"text","text":"Twenty or thirty songs","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her active recording career was brief, producing an estimated twenty to thirty songs, virtually all boleros. About two-thirds were her own compositions, and while some followed the classic bachata format of two guitars, maracas, bass and bongo, others were arranged with saxophone, trumpet or timbales."}]},{"type":"paragraph","content":[{"type":"text","text":"An early disappearance","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She kept performing occasionally after her recording years ended around 1966 or 1967, but her move from Santo Domingo to San Pedro de Macorís removed her from the public eye. She died of a heart attack in 1975, the same year that "},{"type":"artistReference","attrs":{"occurrenceId":"f4b891d2-4db4-4134-b38d-6271e5b05ead","artistId":"01db8904-c39e-428d-bbea-da4049a79ee6","displayText":"Aridia Ventura"}},{"type":"text","text":" — who would become her clear successor as bachata’s leading female voice — began recording."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Mélida Rodríguez is remembered as the woman who opened the door bachata’s early female singers walked through, and «La Sufrida» remains a reference point for the genre’s first generation of songs written from a woman’s perspective."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'melida-rodriguez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'melida-rodriguez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'ef662684-51e2-4edc-80b9-ca114cdbad3f', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'melida-rodriguez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'f4b891d2-4db4-4134-b38d-6271e5b05ead', 'artist', '01db8904-c39e-428d-bbea-da4049a79ee6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'melida-rodriguez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Mélida Rodríguez was a Dominican bachata singer and songwriter, born in Hato Mayor in 1943, and the first woman to record the genre, following the guitar-bolero style of the Puerto Rican singer Blanca Iris Villafañe.

**«Yo soy mala, y seguiré siendo mala»**

She began recording in the early years of Dominican bachata, alongside its first male pioneers, backed by the same musicians who played on records by José Manuel Calderón and Fabio Sanabia. She wrote most of her own material, and her signature song, «La Sufrida», is considered the best-known early bachata sung entirely from a woman’s point of view: its chorus, an unrepentant declaration of independence, was a striking statement of feminine freedom for its time.

**Twenty or thirty songs**

Her active recording career was brief, producing an estimated twenty to thirty songs, virtually all boleros. About two-thirds were her own compositions, and while some followed the classic bachata format of two guitars, maracas, bass and bongo, others were arranged with saxophone, trumpet or timbales.

**An early disappearance**

She kept performing occasionally after her recording years ended around 1966 or 1967, but her move from Santo Domingo to San Pedro de Macorís removed her from the public eye. She died of a heart attack in 1975, the same year that Aridia Ventura — who would become her clear successor as bachata’s leading female voice — began recording.

**Legacy**

Mélida Rodríguez is remembered as the woman who opened the door bachata’s early female singers walked through, and «La Sufrida» remains a reference point for the genre’s first generation of songs written from a woman’s perspective.' WHERE slug = 'melida-rodriguez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Mélida Rodríguez fue cantante y compositora dominicana de bachata, nacida en Hato Mayor en 1943, y la primera mujer en grabar el género, siguiendo el estilo de bolero con guitarras de la cantante puertorriqueña Blanca Iris Villafañe."}]},{"type":"paragraph","content":[{"type":"text","text":"«Yo soy mala, y seguiré siendo mala»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó a grabar en los primeros años de la bachata dominicana, junto a sus primeros pioneros masculinos, acompañada por los mismos músicos que tocaban en los discos de "},{"type":"artistReference","attrs":{"occurrenceId":"127d7db4-d7b0-4da3-9922-66a288c4f7ca","artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón"}},{"type":"text","text":" y Fabio Sanabia. Escribió la mayor parte de su propio repertorio, y su canción emblema, «La Sufrida», es considerada la bachata temprana más conocida cantada enteramente desde el punto de vista de una mujer: su coro, una declaración de independencia sin arrepentimiento, fue una afirmación llamativa de libertad femenina para su época."}]},{"type":"paragraph","content":[{"type":"text","text":"Veinte o treinta canciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su carrera activa como grabadora fue breve, con un estimado de veinte a treinta canciones, casi todas boleros. Cerca de dos tercios eran composiciones propias, y mientras algunas seguían el formato clásico de la bachata —dos guitarras, maracas, bajo y bongó—, otras se arreglaron con saxofón, trompeta o timbales."}]},{"type":"paragraph","content":[{"type":"text","text":"Una desaparición temprana","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Siguió presentándose de vez en cuando después de que sus años de grabación terminaran hacia 1966 o 1967, pero su mudanza de Santo Domingo a San Pedro de Macorís la alejó de la vida pública. Murió de un infarto en 1975, el mismo año en que "},{"type":"artistReference","attrs":{"occurrenceId":"15f9cab5-d8ca-47fd-b17a-cdafda10e042","artistId":"01db8904-c39e-428d-bbea-da4049a79ee6","displayText":"Aridia Ventura"}},{"type":"text","text":" —quien terminaría siendo su clara sucesora como voz femenina líder de la bachata— empezó a grabar."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A Mélida Rodríguez se la recuerda como la mujer que abrió la puerta que cruzarían las primeras cantantes de bachata, y «La Sufrida» sigue siendo un punto de referencia de la primera generación de canciones del género escritas desde la perspectiva de una mujer."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'melida-rodriguez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'melida-rodriguez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '127d7db4-d7b0-4da3-9922-66a288c4f7ca', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'melida-rodriguez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '15f9cab5-d8ca-47fd-b17a-cdafda10e042', 'artist', '01db8904-c39e-428d-bbea-da4049a79ee6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'melida-rodriguez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Mélida Rodríguez fue cantante y compositora dominicana de bachata, nacida en Hato Mayor en 1943, y la primera mujer en grabar el género, siguiendo el estilo de bolero con guitarras de la cantante puertorriqueña Blanca Iris Villafañe.

**«Yo soy mala, y seguiré siendo mala»**

Empezó a grabar en los primeros años de la bachata dominicana, junto a sus primeros pioneros masculinos, acompañada por los mismos músicos que tocaban en los discos de José Manuel Calderón y Fabio Sanabia. Escribió la mayor parte de su propio repertorio, y su canción emblema, «La Sufrida», es considerada la bachata temprana más conocida cantada enteramente desde el punto de vista de una mujer: su coro, una declaración de independencia sin arrepentimiento, fue una afirmación llamativa de libertad femenina para su época.

**Veinte o treinta canciones**

Su carrera activa como grabadora fue breve, con un estimado de veinte a treinta canciones, casi todas boleros. Cerca de dos tercios eran composiciones propias, y mientras algunas seguían el formato clásico de la bachata —dos guitarras, maracas, bajo y bongó—, otras se arreglaron con saxofón, trompeta o timbales.

**Una desaparición temprana**

Siguió presentándose de vez en cuando después de que sus años de grabación terminaran hacia 1966 o 1967, pero su mudanza de Santo Domingo a San Pedro de Macorís la alejó de la vida pública. Murió de un infarto en 1975, el mismo año en que Aridia Ventura —quien terminaría siendo su clara sucesora como voz femenina líder de la bachata— empezó a grabar.

**Legado**

A Mélida Rodríguez se la recuerda como la mujer que abrió la puerta que cruzarían las primeras cantantes de bachata, y «La Sufrida» sigue siendo un punto de referencia de la primera generación de canciones del género escritas desde la perspectiva de una mujer.' WHERE slug = 'melida-rodriguez';

COMMIT;
