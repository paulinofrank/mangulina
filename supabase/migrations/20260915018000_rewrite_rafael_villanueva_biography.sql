BEGIN;

-- Ficha de Rafael Villanueva.
--
-- La biografía de relleno lo describía en términos genéricos de merengue y tradiciones
-- tropicales, sin mencionar que fue director titular de la Orquesta Sinfónica Nacional.
-- date_of_death corregida de 1995-12-02 a 1995-12-22 (tres fuentes independientes).
-- primary_genre corregido de merengue a instrumental-classical (era director de orquesta
-- clásica, no músico de merengue). occupations ampliado con composer. middle_name y
-- second_last_name añadidos a partir del nombre completo documentado.

UPDATE artists SET middle_name = 'Tomás Eduardo', second_last_name = 'Martínez',
       date_of_death = '1995-12-22', primary_genre = 'instrumental-classical',
       occupations = '["conductor","composer"]'::jsonb
       WHERE slug = 'rafael-villanueva';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Rafael Villanueva —born Rafael Tomás Eduardo Villanueva Martínez in Santo Domingo on 13 October 1947, died there on 22 December 1995— was a Dominican conductor and composer, and titular director of the National Symphony Orchestra in the final year of his life."}]},{"type":"paragraph","content":[{"type":"text","text":"Toronto and Vienna","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He studied political and economic science at the University of Toronto from 1972, attending classes at the Royal Conservatory of Music, and moved to Vienna the following year, where he spent four years studying orchestral conducting under Karl Randolf and music theory and composition under Rüdiger Seitz at the Vienna Conservatory, graduating in 1977."}]},{"type":"paragraph","content":[{"type":"text","text":"An invitation from Manuel Simó","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He debuted as a conductor in 1978 with the National Symphony Orchestra, invited by "},{"type":"artistReference","attrs":{"occurrenceId":"67047557-63ca-4480-a02c-5365023990bf","artistId":"743c18ed-8dde-4c20-9ae1-4f5a70185b18","displayText":"Manuel Simó"}},{"type":"text","text":", its titular director at the time. He spent the following decade as the orchestra’s associate conductor, alongside "},{"type":"artistReference","attrs":{"occurrenceId":"c760a242-2b6c-4457-96c4-6737a665248a","artistId":"ebd75bb5-0571-4199-9474-22d173b3d072","displayText":"Carlos Piantini"}},{"type":"text","text":", and in 1994 was named its titular director by presidential decree."}]},{"type":"paragraph","content":[{"type":"text","text":"Maracaibo and the Palacio de Bellas Artes","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His international debut came in 1987, conducting the Orquesta Sinfónica de Maracaibo in Venezuela, and the following year he was invited to lead the Orquesta Sinfónica Nacional de México in two concerts at the Palacio de Bellas Artes."}]},{"type":"paragraph","content":[{"type":"text","text":"Radio, lectures, and an honor","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"From 1987 he directed the classical music programming of Clásica Radio, gave frequent lecture series on musical and literary subjects, and wrote on cultural affairs for the national press. In 1991 the Dominican government granted him the Orden Heráldica de Cristóbal Colón in the rank of Caballero."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Villanueva died in Santo Domingo on 22 December 1995, less than two years after being named titular director of the National Symphony Orchestra, a post in which he was succeeded by the violinist Julio de Windt. Accounts of the orchestra’s history describe every program he conducted in that short tenure as meticulously rehearsed, and his death as cutting short what colleagues expected would have been an exceptional directorship."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'rafael-villanueva'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'rafael-villanueva' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '67047557-63ca-4480-a02c-5365023990bf', 'artist', '743c18ed-8dde-4c20-9ae1-4f5a70185b18' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'rafael-villanueva' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c760a242-2b6c-4457-96c4-6737a665248a', 'artist', 'ebd75bb5-0571-4199-9474-22d173b3d072' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'rafael-villanueva' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Rafael Villanueva —born Rafael Tomás Eduardo Villanueva Martínez in Santo Domingo on 13 October 1947, died there on 22 December 1995— was a Dominican conductor and composer, and titular director of the National Symphony Orchestra in the final year of his life.

**Toronto and Vienna**

He studied political and economic science at the University of Toronto from 1972, attending classes at the Royal Conservatory of Music, and moved to Vienna the following year, where he spent four years studying orchestral conducting under Karl Randolf and music theory and composition under Rüdiger Seitz at the Vienna Conservatory, graduating in 1977.

**An invitation from Manuel Simó**

He debuted as a conductor in 1978 with the National Symphony Orchestra, invited by Manuel Simó, its titular director at the time. He spent the following decade as the orchestra’s associate conductor, alongside Carlos Piantini, and in 1994 was named its titular director by presidential decree.

**Maracaibo and the Palacio de Bellas Artes**

His international debut came in 1987, conducting the Orquesta Sinfónica de Maracaibo in Venezuela, and the following year he was invited to lead the Orquesta Sinfónica Nacional de México in two concerts at the Palacio de Bellas Artes.

**Radio, lectures, and an honor**

From 1987 he directed the classical music programming of Clásica Radio, gave frequent lecture series on musical and literary subjects, and wrote on cultural affairs for the national press. In 1991 the Dominican government granted him the Orden Heráldica de Cristóbal Colón in the rank of Caballero.

**Legacy**

Villanueva died in Santo Domingo on 22 December 1995, less than two years after being named titular director of the National Symphony Orchestra, a post in which he was succeeded by the violinist Julio de Windt. Accounts of the orchestra’s history describe every program he conducted in that short tenure as meticulously rehearsed, and his death as cutting short what colleagues expected would have been an exceptional directorship.' WHERE slug = 'rafael-villanueva';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Rafael Villanueva —nacido Rafael Tomás Eduardo Villanueva Martínez en Santo Domingo el 13 de octubre de 1947, fallecido en la misma ciudad el 22 de diciembre de 1995— fue director de orquesta y compositor dominicano, y director titular de la Orquesta Sinfónica Nacional en el último año de su vida."}]},{"type":"paragraph","content":[{"type":"text","text":"Toronto y Viena","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Estudió Ciencias Políticas y Económicas en la Universidad de Toronto a partir de 1972, asistiendo también a clases en el Royal Conservatory of Music, y al año siguiente se trasladó a Viena, donde pasó cuatro años estudiando dirección orquestal con Karl Randolf y teoría musical y composición con Rüdiger Seitz en el Conservatorio de Viena, graduándose en 1977."}]},{"type":"paragraph","content":[{"type":"text","text":"Una invitación de Manuel Simó","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Debutó como director en 1978 al frente de la Orquesta Sinfónica Nacional, invitado por "},{"type":"artistReference","attrs":{"occurrenceId":"602dbe7c-8995-4f8c-b8a4-79c15e750480","artistId":"743c18ed-8dde-4c20-9ae1-4f5a70185b18","displayText":"Manuel Simó"}},{"type":"text","text":", su director titular en ese momento. Pasó la década siguiente como director asociado de la orquesta, junto a "},{"type":"artistReference","attrs":{"occurrenceId":"11821e4b-c7c2-45c4-aa1e-92557481fe11","artistId":"ebd75bb5-0571-4199-9474-22d173b3d072","displayText":"Carlos Piantini"}},{"type":"text","text":", y en 1994 fue nombrado su director titular por decreto presidencial."}]},{"type":"paragraph","content":[{"type":"text","text":"Maracaibo y el Palacio de Bellas Artes","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su debut internacional llegó en 1987, al frente de la Orquesta Sinfónica de Maracaibo, en Venezuela, y al año siguiente fue invitado a dirigir la Orquesta Sinfónica Nacional de México en dos conciertos en el Palacio de Bellas Artes."}]},{"type":"paragraph","content":[{"type":"text","text":"Radio, conferencias, y una condecoración","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Desde 1987 dirigió la programación de música clásica de Clásica Radio, dictó con frecuencia ciclos de conferencias sobre temas musicales y literarios, y escribió sobre temas culturales en la prensa nacional. En 1991 el gobierno dominicano le otorgó la Orden Heráldica de Cristóbal Colón en el grado de Caballero."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Villanueva murió en Santo Domingo el 22 de diciembre de 1995, menos de dos años después de ser nombrado director titular de la Orquesta Sinfónica Nacional, cargo en el que lo sucedió el violinista Julio de Windt. Los relatos sobre la historia de la orquesta describen cada programa que dirigió en ese breve período como cuidadosamente ensayado, y su muerte como el corte abrupto de lo que sus colegas esperaban fuera una etapa excepcional al frente de la institución."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'rafael-villanueva'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'rafael-villanueva' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '602dbe7c-8995-4f8c-b8a4-79c15e750480', 'artist', '743c18ed-8dde-4c20-9ae1-4f5a70185b18' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'rafael-villanueva' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '11821e4b-c7c2-45c4-aa1e-92557481fe11', 'artist', 'ebd75bb5-0571-4199-9474-22d173b3d072' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'rafael-villanueva' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Rafael Villanueva —nacido Rafael Tomás Eduardo Villanueva Martínez en Santo Domingo el 13 de octubre de 1947, fallecido en la misma ciudad el 22 de diciembre de 1995— fue director de orquesta y compositor dominicano, y director titular de la Orquesta Sinfónica Nacional en el último año de su vida.

**Toronto y Viena**

Estudió Ciencias Políticas y Económicas en la Universidad de Toronto a partir de 1972, asistiendo también a clases en el Royal Conservatory of Music, y al año siguiente se trasladó a Viena, donde pasó cuatro años estudiando dirección orquestal con Karl Randolf y teoría musical y composición con Rüdiger Seitz en el Conservatorio de Viena, graduándose en 1977.

**Una invitación de Manuel Simó**

Debutó como director en 1978 al frente de la Orquesta Sinfónica Nacional, invitado por Manuel Simó, su director titular en ese momento. Pasó la década siguiente como director asociado de la orquesta, junto a Carlos Piantini, y en 1994 fue nombrado su director titular por decreto presidencial.

**Maracaibo y el Palacio de Bellas Artes**

Su debut internacional llegó en 1987, al frente de la Orquesta Sinfónica de Maracaibo, en Venezuela, y al año siguiente fue invitado a dirigir la Orquesta Sinfónica Nacional de México en dos conciertos en el Palacio de Bellas Artes.

**Radio, conferencias, y una condecoración**

Desde 1987 dirigió la programación de música clásica de Clásica Radio, dictó con frecuencia ciclos de conferencias sobre temas musicales y literarios, y escribió sobre temas culturales en la prensa nacional. En 1991 el gobierno dominicano le otorgó la Orden Heráldica de Cristóbal Colón en el grado de Caballero.

**Legado**

Villanueva murió en Santo Domingo el 22 de diciembre de 1995, menos de dos años después de ser nombrado director titular de la Orquesta Sinfónica Nacional, cargo en el que lo sucedió el violinista Julio de Windt. Los relatos sobre la historia de la orquesta describen cada programa que dirigió en ese breve período como cuidadosamente ensayado, y su muerte como el corte abrupto de lo que sus colegas esperaban fuera una etapa excepcional al frente de la institución.' WHERE slug = 'rafael-villanueva';

COMMIT;
