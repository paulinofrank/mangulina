BEGIN;

-- MÓRIA (Mória Estrella): mujer (el relleno usaba they), productora y compositora, alias Móry.

UPDATE artists SET gender = 'female', occupations = '["producer","songwriter"]'::jsonb, aliases = ARRAY['Móry']::text[] WHERE slug = 'moria';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"MÓRIA —Mória Estrella— is a Dominican singer, songwriter and producer who moved with her family to Toronto at the age of eleven. She calls her mix of bachata, dembow, trap and rock “darkchata”, and is also written Móry."}]},{"type":"paragraph","content":[{"type":"text","text":"«Sereno de la Noche»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her debut EP, «Sereno de la Noche», came out in November 2023. Its fourteen minutes were described by the Dominican site Discolai as an urban record with an alternative lean that keeps tropical and dark influences, with bachata at its center; the references to it run through the song subtitles and an interlude in which she explains the idea herself. Besides producing, she brought in several co-producers, among them Okeiflou, Diego Raposo, @producer, Inka and V1FRO. The Los Angeles Times, which put the EP in its list of the best Latin music of 2023, called her sound Caribbean gothic and noted flickers of trap, drill and UK garage."}]},{"type":"paragraph","content":[{"type":"text","text":"Recognition","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Discolai included the EP in its ten favorite local albums of 2023, and Rolling Stone placed it thirty-second in its list of the fifty best Spanish-language albums of the year, published on 14 December 2023."}]},{"type":"paragraph","content":[{"type":"text","text":"Since then","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"On her YouTube channel she has posted the singles «Atlas Celestial», which she labels “Rockbow”, «Bonu$ Rack», «Angelito», a bachata-club version of a song made popular by Aventura, «Rota Nunca Queda» with «Las Cayenas Negras», «Ambas», «ILY», which she labels “Demrock”, and «Rockstar MVP», along with the concept audios of «MADRE...amen»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The Los Angeles Times, Rolling Stone and Discolai each placed «Sereno de la Noche» in their 2023 year-end selections."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'moria'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'moria' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'MÓRIA —Mória Estrella— is a Dominican singer, songwriter and producer who moved with her family to Toronto at the age of eleven. She calls her mix of bachata, dembow, trap and rock “darkchata”, and is also written Móry.

**«Sereno de la Noche»**

Her debut EP, «Sereno de la Noche», came out in November 2023. Its fourteen minutes were described by the Dominican site Discolai as an urban record with an alternative lean that keeps tropical and dark influences, with bachata at its center; the references to it run through the song subtitles and an interlude in which she explains the idea herself. Besides producing, she brought in several co-producers, among them Okeiflou, Diego Raposo, @producer, Inka and V1FRO. The Los Angeles Times, which put the EP in its list of the best Latin music of 2023, called her sound Caribbean gothic and noted flickers of trap, drill and UK garage.

**Recognition**

Discolai included the EP in its ten favorite local albums of 2023, and Rolling Stone placed it thirty-second in its list of the fifty best Spanish-language albums of the year, published on 14 December 2023.

**Since then**

On her YouTube channel she has posted the singles «Atlas Celestial», which she labels “Rockbow”, «Bonu$ Rack», «Angelito», a bachata-club version of a song made popular by Aventura, «Rota Nunca Queda» with «Las Cayenas Negras», «Ambas», «ILY», which she labels “Demrock”, and «Rockstar MVP», along with the concept audios of «MADRE...amen».

**Legacy**

The Los Angeles Times, Rolling Stone and Discolai each placed «Sereno de la Noche» in their 2023 year-end selections.' WHERE slug = 'moria';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"MÓRIA —Mória Estrella— es una cantante, compositora y productora dominicana que se mudó con su familia a Toronto a los once años. Llama “darkchata” a su mezcla de bachata, dembow, trap y rock, y también se escribe Móry."}]},{"type":"paragraph","content":[{"type":"text","text":"«Sereno de la Noche»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su EP debut, «Sereno de la Noche», salió en noviembre de 2023. Sus catorce minutos fueron descritos por el sitio dominicano Discolai como un disco urbano con inclinación alternativa que conserva influencias tropicales y oscuras, con la bachata como eje; las referencias a ella corren por los subtítulos de las canciones y por un interludio en el que la propia artista explica la idea. Además de producir, sumó a varios coproductores, entre ellos Okeiflou, Diego Raposo, @producer, Inka y V1FRO. El diario Los Angeles Times, que colocó el EP en su lista de lo mejor de la música latina de 2023, llamó a su sonido gótico caribeño y notó destellos de trap, drill y UK garage."}]},{"type":"paragraph","content":[{"type":"text","text":"Reconocimientos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Discolai incluyó el EP entre sus diez álbumes locales favoritos de 2023, y Rolling Stone lo colocó en el puesto treinta y dos de su lista de los cincuenta mejores álbumes en español del año, publicada el 14 de diciembre de 2023."}]},{"type":"paragraph","content":[{"type":"text","text":"Después","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En su canal de YouTube ha publicado los sencillos «Atlas Celestial», que etiqueta como “Rockbow”, «Bonu$ Rack», «Angelito», versión bachata club de un tema popularizado por Aventura, «Rota Nunca Queda» con «Las Cayenas Negras», «Ambas», «ILY», que etiqueta como “Demrock”, y «Rockstar MVP», junto con los audios conceptuales de «MADRE...amen»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El Los Angeles Times, Rolling Stone y Discolai colocaron cada uno «Sereno de la Noche» en sus selecciones de fin de año de 2023."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'moria'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'moria' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'MÓRIA —Mória Estrella— es una cantante, compositora y productora dominicana que se mudó con su familia a Toronto a los once años. Llama “darkchata” a su mezcla de bachata, dembow, trap y rock, y también se escribe Móry.

**«Sereno de la Noche»**

Su EP debut, «Sereno de la Noche», salió en noviembre de 2023. Sus catorce minutos fueron descritos por el sitio dominicano Discolai como un disco urbano con inclinación alternativa que conserva influencias tropicales y oscuras, con la bachata como eje; las referencias a ella corren por los subtítulos de las canciones y por un interludio en el que la propia artista explica la idea. Además de producir, sumó a varios coproductores, entre ellos Okeiflou, Diego Raposo, @producer, Inka y V1FRO. El diario Los Angeles Times, que colocó el EP en su lista de lo mejor de la música latina de 2023, llamó a su sonido gótico caribeño y notó destellos de trap, drill y UK garage.

**Reconocimientos**

Discolai incluyó el EP entre sus diez álbumes locales favoritos de 2023, y Rolling Stone lo colocó en el puesto treinta y dos de su lista de los cincuenta mejores álbumes en español del año, publicada el 14 de diciembre de 2023.

**Después**

En su canal de YouTube ha publicado los sencillos «Atlas Celestial», que etiqueta como “Rockbow”, «Bonu$ Rack», «Angelito», versión bachata club de un tema popularizado por Aventura, «Rota Nunca Queda» con «Las Cayenas Negras», «Ambas», «ILY», que etiqueta como “Demrock”, y «Rockstar MVP», junto con los audios conceptuales de «MADRE...amen».

**Legado**

El Los Angeles Times, Rolling Stone y Discolai colocaron cada uno «Sereno de la Noche» en sus selecciones de fin de año de 2023.' WHERE slug = 'moria';

COMMIT;
