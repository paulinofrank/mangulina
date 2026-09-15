BEGIN;

-- Ficha de Damirón.
--
-- La biografía de relleno llamaba "Chapín" a su pareja artística; el nombre real y
-- documentado es José Ernesto Chapuseaux, «Negrito Chapuseaux» (ya publicado). Nombre
-- completo: first_name Francisco Alberto, last_name Simó, second_last_name Damirón (el
-- apellido con el que actuaba era el materno). instruments: piano. occupations: se añade
-- pianist (ya tenía composer, arranger, bandleader). Alias nuevo: Frank Damirón. Billo
-- Frómeta no tiene ficha (ya anotado desde la ficha de Johnny Pacheco); Silvia De Grasse es
-- panameña y no entra en ARTISTAS_FALTANTES.md.

UPDATE artists SET first_name = 'Francisco Alberto', last_name = 'Simó', second_last_name = 'Damirón',
       occupations = '["pianist","composer","arranger","bandleader"]'::jsonb, instruments = ARRAY['piano']::text[], aliases = ARRAY['El Rey del Piano Merengue', 'Los Alegres Tres', 'Frank Damirón']::text[]
 WHERE slug = 'damiron';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Damirón — born Francisco Alberto Simó Damirón on 21 November 1908 in San Francisco de Macorís, died 3 April 1992 in Santo Domingo — was a Dominican pianist, composer and arranger, and half of Damirón y Chapuseaux, the duo credited with helping carry Dominican merengue across Latin America and the Caribbean."}]},{"type":"paragraph","content":[{"type":"text","text":"A mother’s surname","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His parents were Teodoro Simó Knipping and Mercedes Damirón — the name he performed under all his life was his mother’s. He trained under Sixto Brea in theory and solfège and Rafael Pimentel in harmony and composition, and set himself early to spreading his country’s traditional music beyond its borders."}]},{"type":"paragraph","content":[{"type":"text","text":"Damirón y Chapuseaux","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He partnered early with the singer José Ernesto Chapuseaux, known as "},{"type":"artistReference","attrs":{"occurrenceId":"cd402da1-c737-49d3-b870-88a49f5b5356","artistId":"d5f32223-92d0-43c4-b039-0a8a4eb48ada","displayText":"Negrito Chapuseaux"}},{"type":"text","text":", his first vocalist. With güiro, two-headed tambora, bass, voice and piano they formed a típico ensemble and quickly found an audience."}]},{"type":"paragraph","content":[{"type":"text","text":"Billo’s Happy Boys, Panama, Puerto Rico","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1937 Damirón and Chapuseaux helped found the orchestra Billo’s Happy Boys, forerunner of what became Billo’s Caracas Boys, backing the young Dominican bandleader Billo Frómeta as he built his career in Venezuela. From there the pair moved on to Panama, where they met the singer Silvia De Grasse and formed the trio Los Alegres Tres, adding Panamanian tambora rhythm to their Dominican repertoire and appearing on Panamanian television. De Grasse and Chapuseaux later married and settled in Puerto Rico; Damirón and his family followed."}]},{"type":"paragraph","content":[{"type":"text","text":"The piano-merengue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As a soloist, backed by típico ensembles or full orchestras, Damirón built a repertoire that ranged across the Caribbean songbook — \"Piano merengue\", \"El ají caribe\", \"La escalerita\", \"Que siga la fiesta\", \"Tucurucutú\", \"Papá Montero\" and \"Mecanógrafa\" among dozens of others — and set outside standards to merengue rhythm, including \"Last Tango\", \"Popcorn\", \"Hava Nagila\" and \"Love Story\". He toured Colombia, Puerto Rico, Panama, Cuba, Mexico, Venezuela, Costa Rica and the United States, sharing stages with Harry Belafonte, Agustín Lara, Frank Sinatra, Libertad Lamarque and Nat \"King\" Cole, and recorded more than sixty LPs for labels including RCA, Ansonia, Seeco, Montilla and MGM."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He married the Argentine Adelina Leiva, with whom he had a son, Frankie Simó Leiva, and lived for years in Puerto Rico before returning to the Dominican Republic, where he died in 1992 at eighty-three, closing a career of nearly five decades that carried the piano-driven, acoustic merengue of his youth in San Francisco de Macorís to stages across the hemisphere."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'damiron'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'damiron' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cd402da1-c737-49d3-b870-88a49f5b5356', 'artist', 'd5f32223-92d0-43c4-b039-0a8a4eb48ada' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'damiron' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Damirón — born Francisco Alberto Simó Damirón on 21 November 1908 in San Francisco de Macorís, died 3 April 1992 in Santo Domingo — was a Dominican pianist, composer and arranger, and half of Damirón y Chapuseaux, the duo credited with helping carry Dominican merengue across Latin America and the Caribbean.

**A mother’s surname**

His parents were Teodoro Simó Knipping and Mercedes Damirón — the name he performed under all his life was his mother’s. He trained under Sixto Brea in theory and solfège and Rafael Pimentel in harmony and composition, and set himself early to spreading his country’s traditional music beyond its borders.

**Damirón y Chapuseaux**

He partnered early with the singer José Ernesto Chapuseaux, known as Negrito Chapuseaux, his first vocalist. With güiro, two-headed tambora, bass, voice and piano they formed a típico ensemble and quickly found an audience.

**Billo’s Happy Boys, Panama, Puerto Rico**

In 1937 Damirón and Chapuseaux helped found the orchestra Billo’s Happy Boys, forerunner of what became Billo’s Caracas Boys, backing the young Dominican bandleader Billo Frómeta as he built his career in Venezuela. From there the pair moved on to Panama, where they met the singer Silvia De Grasse and formed the trio Los Alegres Tres, adding Panamanian tambora rhythm to their Dominican repertoire and appearing on Panamanian television. De Grasse and Chapuseaux later married and settled in Puerto Rico; Damirón and his family followed.

**The piano-merengue**

As a soloist, backed by típico ensembles or full orchestras, Damirón built a repertoire that ranged across the Caribbean songbook — "Piano merengue", "El ají caribe", "La escalerita", "Que siga la fiesta", "Tucurucutú", "Papá Montero" and "Mecanógrafa" among dozens of others — and set outside standards to merengue rhythm, including "Last Tango", "Popcorn", "Hava Nagila" and "Love Story". He toured Colombia, Puerto Rico, Panama, Cuba, Mexico, Venezuela, Costa Rica and the United States, sharing stages with Harry Belafonte, Agustín Lara, Frank Sinatra, Libertad Lamarque and Nat "King" Cole, and recorded more than sixty LPs for labels including RCA, Ansonia, Seeco, Montilla and MGM.

**Legacy**

He married the Argentine Adelina Leiva, with whom he had a son, Frankie Simó Leiva, and lived for years in Puerto Rico before returning to the Dominican Republic, where he died in 1992 at eighty-three, closing a career of nearly five decades that carried the piano-driven, acoustic merengue of his youth in San Francisco de Macorís to stages across the hemisphere.' WHERE slug = 'damiron';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Damirón —nacido Francisco Alberto Simó Damirón el 21 de noviembre de 1908 en San Francisco de Macorís, fallecido el 3 de abril de 1992 en Santo Domingo— fue un pianista, compositor y arreglista dominicano, y una mitad de Damirón y Chapuseaux, el dúo al que se le atribuye haber llevado el merengue dominicano por toda América Latina y el Caribe."}]},{"type":"paragraph","content":[{"type":"text","text":"El apellido de la madre","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Sus padres fueron Teodoro Simó Knipping y Mercedes Damirón: el nombre bajo el que actuó toda su vida era el de su madre. Se formó con Sixto Brea en teoría y solfeo y con Rafael Pimentel en armonía y composición, y se propuso desde joven difundir la música tradicional de su país más allá de sus fronteras."}]},{"type":"paragraph","content":[{"type":"text","text":"Damirón y Chapuseaux","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Se asoció desde temprano con el cantante José Ernesto Chapuseaux, conocido como "},{"type":"artistReference","attrs":{"occurrenceId":"6cf1cf23-15bc-47b9-b482-29dc46e268d2","artistId":"d5f32223-92d0-43c4-b039-0a8a4eb48ada","displayText":"Negrito Chapuseaux"}},{"type":"text","text":", su primer vocalista. Con güiro, tambora de dos cueros, bajo, voz y piano formaron un conjunto típico y encontraron público rápido."}]},{"type":"paragraph","content":[{"type":"text","text":"Billo’s Happy Boys, Panamá, Puerto Rico","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1937 Damirón y Chapuseaux ayudaron a fundar la orquesta Billo’s Happy Boys, precursora de lo que sería Billo’s Caracas Boys, respaldando al joven director dominicano Billo Frómeta mientras este hacía carrera en Venezuela. De ahí la pareja siguió a Panamá, donde conocieron a la cantante Silvia De Grasse y formaron el trío Los Alegres Tres, sumando el ritmo de tambora panameño a su repertorio dominicano y presentándose en la televisión de ese país. De Grasse y Chapuseaux se casaron después y se establecieron en Puerto Rico; Damirón y su familia los siguieron."}]},{"type":"paragraph","content":[{"type":"text","text":"El piano-merengue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Como solista, con acompañamiento típico o de orquesta completa, Damirón armó un repertorio que recorría el cancionero caribeño —«Piano merengue», «El ají caribe», «La escalerita», «Que siga la fiesta», «Tucurucutú», «Papá Montero» y «Mecanógrafa», entre decenas más— y puso a ritmo de merengue estándares ajenos, entre ellos «Last Tango», «Popcorn», «Hava Nagila» y «Love Story». Recorrió Colombia, Puerto Rico, Panamá, Cuba, México, Venezuela, Costa Rica y Estados Unidos, compartiendo escenario con Harry Belafonte, Agustín Lara, Frank Sinatra, Libertad Lamarque y Nat «King» Cole, y grabó más de sesenta LP para sellos como RCA, Ansonia, Seeco, Montilla y MGM."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Se casó con la argentina Adelina Leiva, con quien tuvo un hijo, Frankie Simó Leiva, y vivió años en Puerto Rico antes de volver a República Dominicana, donde murió en 1992 a los ochenta y tres años, al cierre de una carrera de casi cinco décadas que llevó el merengue acústico y pianístico de su juventud en San Francisco de Macorís a escenarios de todo el hemisferio."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'damiron'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'damiron' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6cf1cf23-15bc-47b9-b482-29dc46e268d2', 'artist', 'd5f32223-92d0-43c4-b039-0a8a4eb48ada' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'damiron' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Damirón —nacido Francisco Alberto Simó Damirón el 21 de noviembre de 1908 en San Francisco de Macorís, fallecido el 3 de abril de 1992 en Santo Domingo— fue un pianista, compositor y arreglista dominicano, y una mitad de Damirón y Chapuseaux, el dúo al que se le atribuye haber llevado el merengue dominicano por toda América Latina y el Caribe.

**El apellido de la madre**

Sus padres fueron Teodoro Simó Knipping y Mercedes Damirón: el nombre bajo el que actuó toda su vida era el de su madre. Se formó con Sixto Brea en teoría y solfeo y con Rafael Pimentel en armonía y composición, y se propuso desde joven difundir la música tradicional de su país más allá de sus fronteras.

**Damirón y Chapuseaux**

Se asoció desde temprano con el cantante José Ernesto Chapuseaux, conocido como Negrito Chapuseaux, su primer vocalista. Con güiro, tambora de dos cueros, bajo, voz y piano formaron un conjunto típico y encontraron público rápido.

**Billo’s Happy Boys, Panamá, Puerto Rico**

En 1937 Damirón y Chapuseaux ayudaron a fundar la orquesta Billo’s Happy Boys, precursora de lo que sería Billo’s Caracas Boys, respaldando al joven director dominicano Billo Frómeta mientras este hacía carrera en Venezuela. De ahí la pareja siguió a Panamá, donde conocieron a la cantante Silvia De Grasse y formaron el trío Los Alegres Tres, sumando el ritmo de tambora panameño a su repertorio dominicano y presentándose en la televisión de ese país. De Grasse y Chapuseaux se casaron después y se establecieron en Puerto Rico; Damirón y su familia los siguieron.

**El piano-merengue**

Como solista, con acompañamiento típico o de orquesta completa, Damirón armó un repertorio que recorría el cancionero caribeño —«Piano merengue», «El ají caribe», «La escalerita», «Que siga la fiesta», «Tucurucutú», «Papá Montero» y «Mecanógrafa», entre decenas más— y puso a ritmo de merengue estándares ajenos, entre ellos «Last Tango», «Popcorn», «Hava Nagila» y «Love Story». Recorrió Colombia, Puerto Rico, Panamá, Cuba, México, Venezuela, Costa Rica y Estados Unidos, compartiendo escenario con Harry Belafonte, Agustín Lara, Frank Sinatra, Libertad Lamarque y Nat «King» Cole, y grabó más de sesenta LP para sellos como RCA, Ansonia, Seeco, Montilla y MGM.

**Legado**

Se casó con la argentina Adelina Leiva, con quien tuvo un hijo, Frankie Simó Leiva, y vivió años en Puerto Rico antes de volver a República Dominicana, donde murió en 1992 a los ochenta y tres años, al cierre de una carrera de casi cinco décadas que llevó el merengue acústico y pianístico de su juventud en San Francisco de Macorís a escenarios de todo el hemisferio.' WHERE slug = 'damiron';

COMMIT;
