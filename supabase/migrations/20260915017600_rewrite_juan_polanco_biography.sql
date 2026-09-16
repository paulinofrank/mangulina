BEGIN;

-- Ficha de Juan Polanco.
--
-- La biografía de relleno lo describía como acordeonista de merengue típico del Cibao, algo
-- que ninguna fuente respalda: toda la documentación encontrada lo sitúa como vocalista de
-- orquesta (Conjunto Casino, Porfi Jiménez), autor de un merengue de protesta contra
-- Trujillo grabado en el exilio. No se tocan birth_place/province por falta de fuente.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Polanco was a Dominican singer who carried merengue into Cuba’s big-band tradition and, from exile, lent his voice to one of Dominican music’s boldest acts of protest against the Trujillo dictatorship."}]},{"type":"paragraph","content":[{"type":"text","text":"A Dominican voice in Havana","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Polanco joined Cuba’s storied Conjunto Casino as a vocalist alongside his compatriot "},{"type":"artistReference","attrs":{"occurrenceId":"fa5bd6c4-5359-48ed-8e33-5fb739da515e","artistId":"1410b448-6357-4895-a32a-58708697e10d","displayText":"Alberto Beltrán"}},{"type":"text","text":", recording merengues reshaped by the ensemble’s Cuban big-band sound — among them «San Antonio», a Ñico Lora composition captured live on 23 September 1955."}]},{"type":"paragraph","content":[{"type":"text","text":"«Que me tumben a Chapita»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"By the end of the 1950s he had settled in Venezuela, where in 1961 he recorded «Que me tumben a Chapita» with the orchestra of Porfi Jiménez — a merengue openly hostile to Trujillo, whose nickname gave the song its title. The record could not circulate inside the Dominican Republic while the dictatorship stood, and it remains one of the clearest examples of Dominican protest music made from exile in the months surrounding Trujillo’s assassination on 30 May 1961."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Better remembered today for a single act of open defiance than for a catalogue of hits, Juan Polanco used a Cuban-inflected Dominican merengue to say, from abroad, what could not be said at home."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-polanco'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-polanco' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'fa5bd6c4-5359-48ed-8e33-5fb739da515e', 'artist', '1410b448-6357-4895-a32a-58708697e10d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-polanco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Juan Polanco was a Dominican singer who carried merengue into Cuba’s big-band tradition and, from exile, lent his voice to one of Dominican music’s boldest acts of protest against the Trujillo dictatorship.

**A Dominican voice in Havana**

Polanco joined Cuba’s storied Conjunto Casino as a vocalist alongside his compatriot Alberto Beltrán, recording merengues reshaped by the ensemble’s Cuban big-band sound — among them «San Antonio», a Ñico Lora composition captured live on 23 September 1955.

**«Que me tumben a Chapita»**

By the end of the 1950s he had settled in Venezuela, where in 1961 he recorded «Que me tumben a Chapita» with the orchestra of Porfi Jiménez — a merengue openly hostile to Trujillo, whose nickname gave the song its title. The record could not circulate inside the Dominican Republic while the dictatorship stood, and it remains one of the clearest examples of Dominican protest music made from exile in the months surrounding Trujillo’s assassination on 30 May 1961.

**Legacy**

Better remembered today for a single act of open defiance than for a catalogue of hits, Juan Polanco used a Cuban-inflected Dominican merengue to say, from abroad, what could not be said at home.' WHERE slug = 'juan-polanco';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Polanco fue cantante dominicano que llevó el merengue a la tradición de las grandes orquestas cubanas y que, desde el exilio, prestó su voz a uno de los actos de protesta más audaces de la música dominicana contra la dictadura de Trujillo."}]},{"type":"paragraph","content":[{"type":"text","text":"Una voz dominicana en La Habana","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Polanco se integró como vocalista al legendario Conjunto Casino de Cuba junto a su compatriota "},{"type":"artistReference","attrs":{"occurrenceId":"dffee423-034c-463d-aa13-da211084ddb9","artistId":"1410b448-6357-4895-a32a-58708697e10d","displayText":"Alberto Beltrán"}},{"type":"text","text":", grabando merengues reformulados con el sonido de gran orquesta cubana —entre ellos «San Antonio», composición de Ñico Lora capturada en vivo el 23 de septiembre de 1955."}]},{"type":"paragraph","content":[{"type":"text","text":"«Que me tumben a Chapita»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Hacia finales de los años cincuenta se había establecido en Venezuela, donde en 1961 grabó «Que me tumben a Chapita» con la orquesta de Porfi Jiménez, un merengue abiertamente hostil a Trujillo, cuyo apodo le dio título al tema. El disco no pudo circular dentro de la República Dominicana mientras duró la dictadura, y sigue siendo uno de los ejemplos más claros de música de protesta dominicana hecha desde el exilio en los meses en torno al ajusticiamiento de Trujillo, el 30 de mayo de 1961."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Recordado hoy más por un solo acto de desafío abierto que por un catálogo de éxitos, Juan Polanco usó un merengue dominicano con acento cubano para decir, desde el exterior, lo que no podía decirse en el país."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-polanco'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-polanco' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dffee423-034c-463d-aa13-da211084ddb9', 'artist', '1410b448-6357-4895-a32a-58708697e10d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-polanco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Juan Polanco fue cantante dominicano que llevó el merengue a la tradición de las grandes orquestas cubanas y que, desde el exilio, prestó su voz a uno de los actos de protesta más audaces de la música dominicana contra la dictadura de Trujillo.

**Una voz dominicana en La Habana**

Polanco se integró como vocalista al legendario Conjunto Casino de Cuba junto a su compatriota Alberto Beltrán, grabando merengues reformulados con el sonido de gran orquesta cubana —entre ellos «San Antonio», composición de Ñico Lora capturada en vivo el 23 de septiembre de 1955.

**«Que me tumben a Chapita»**

Hacia finales de los años cincuenta se había establecido en Venezuela, donde en 1961 grabó «Que me tumben a Chapita» con la orquesta de Porfi Jiménez, un merengue abiertamente hostil a Trujillo, cuyo apodo le dio título al tema. El disco no pudo circular dentro de la República Dominicana mientras duró la dictadura, y sigue siendo uno de los ejemplos más claros de música de protesta dominicana hecha desde el exilio en los meses en torno al ajusticiamiento de Trujillo, el 30 de mayo de 1961.

**Legado**

Recordado hoy más por un solo acto de desafío abierto que por un catálogo de éxitos, Juan Polanco usó un merengue dominicano con acento cubano para decir, desde el exterior, lo que no podía decirse en el país.' WHERE slug = 'juan-polanco';

COMMIT;
