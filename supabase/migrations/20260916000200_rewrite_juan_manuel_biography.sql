BEGIN;

-- Ficha de Juan Manuel (Juan Manuel Puente).
--
-- La biografía de relleno era completamente genérica, sin nombrar canción, agrupación ni
-- hecho alguno de su carrera.
-- birth_place/province corregidos de Santo Domingo/Distrito Nacional a El Seibo/El Seibo.
-- last_name añadido (Puente). El alias "Los Toros Band" se elimina por falta de fuente que
-- lo conecte con esa agrupación (ver CONFLICTOS_DE_DATO.md). occupations y genres ampliados.

UPDATE artists SET birth_place = 'El Seibo', province = 'El Seibo',
       last_name = 'Puente', aliases = '{}'::text[],
       occupations = '["producer","arranger","songwriter"]'::jsonb, genres = ARRAY['bachata']::text[]
       WHERE slug = 'juan-manuel';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Manuel —full name Juan Manuel Puente, born in El Seibo, in eastern Dominican Republic— is a Dominican merengue and bachata singer, producer, arranger and songwriter, best known as the voice behind the New York orchestra La Línea’s hit merengue version of «Si me dejas no vale»."}]},{"type":"paragraph","content":[{"type":"text","text":"From found objects to «Sensación Juvenil»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As a child he made music out of whatever he could find around the house or in the street, from soda cans to empty deodorant bottles. At sixteen his persistence earned him a place in the group «Sensación Juvenil», and he later joined «Orquesta La Unión» before moving to Santo Domingo, where he quickly became lead singer of «Orquesta Caramba» and traveled to New York to record his first production with them."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Línea» and «Si me dejas no vale»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Taken with the city and the opportunities it offered his career, he stayed in New York for five years, joining the orchestra «La Línea», which introduced him internationally through merengue versions of well-known songs. Its version of «Si me dejas no vale» quickly climbed radio charts and reached television audiences across Latin America through the music channel HTV."}]},{"type":"paragraph","content":[{"type":"text","text":"Madrid and «El Impactante»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Following a relationship, Juan Manuel relocated to Madrid, where he built a solo career, known there as «El Impactante», and toured much of Europe both on his own and alongside major tropical-music stars. On his first tour of Peru in 2013 he wrote, arranged and recorded a song in a single day with the Peruvian singer and actress Alejandra Pascucci, former vocalist of the group Alma Bella: «El Idiota», which drew wide coverage in the Peruvian press and television."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Juan Manuel went on to release further albums, including «Corazón de Bachata» and, later, «Juan Manuel y los Clásicos del Merengue», and has remained active on Dominican television, appearing on Telemicro’s «Extremo a Extremo» as a performer still identified, decades into his career, by the orchestra that made him internationally known."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-manuel'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-manuel' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Juan Manuel —full name Juan Manuel Puente, born in El Seibo, in eastern Dominican Republic— is a Dominican merengue and bachata singer, producer, arranger and songwriter, best known as the voice behind the New York orchestra La Línea’s hit merengue version of «Si me dejas no vale».

**From found objects to «Sensación Juvenil»**

As a child he made music out of whatever he could find around the house or in the street, from soda cans to empty deodorant bottles. At sixteen his persistence earned him a place in the group «Sensación Juvenil», and he later joined «Orquesta La Unión» before moving to Santo Domingo, where he quickly became lead singer of «Orquesta Caramba» and traveled to New York to record his first production with them.

**«La Línea» and «Si me dejas no vale»**

Taken with the city and the opportunities it offered his career, he stayed in New York for five years, joining the orchestra «La Línea», which introduced him internationally through merengue versions of well-known songs. Its version of «Si me dejas no vale» quickly climbed radio charts and reached television audiences across Latin America through the music channel HTV.

**Madrid and «El Impactante»**

Following a relationship, Juan Manuel relocated to Madrid, where he built a solo career, known there as «El Impactante», and toured much of Europe both on his own and alongside major tropical-music stars. On his first tour of Peru in 2013 he wrote, arranged and recorded a song in a single day with the Peruvian singer and actress Alejandra Pascucci, former vocalist of the group Alma Bella: «El Idiota», which drew wide coverage in the Peruvian press and television.

**Legacy**

Juan Manuel went on to release further albums, including «Corazón de Bachata» and, later, «Juan Manuel y los Clásicos del Merengue», and has remained active on Dominican television, appearing on Telemicro’s «Extremo a Extremo» as a performer still identified, decades into his career, by the orchestra that made him internationally known.' WHERE slug = 'juan-manuel';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Manuel —nombre completo Juan Manuel Puente, nacido en El Seibo, en el este de la República Dominicana— es cantante, productor, arreglista y compositor dominicano de merengue y bachata, conocido sobre todo como la voz detrás de la exitosa versión en merengue de «Si me dejas no vale» de la orquesta neoyorquina La Línea."}]},{"type":"paragraph","content":[{"type":"text","text":"De los objetos encontrados a «Sensación Juvenil»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De niño hacía música con lo que encontraba en casa o en la calle, desde latas de refresco hasta envases vacíos de desodorante. A los dieciséis años su constancia lo llevó a integrar la agrupación «Sensación Juvenil», y más tarde se unió a «Orquesta La Unión», antes de trasladarse a Santo Domingo, donde rápidamente se convirtió en voz principal de «Orquesta Caramba» y viajó a Nueva York para grabar su primera producción con ellos."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Línea» y «Si me dejas no vale»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Prendado de la ciudad y de las oportunidades que ofrecía a su carrera, se quedó en Nueva York durante cinco años, integrándose a la orquesta «La Línea», que lo dio a conocer internacionalmente con versiones en merengue de canciones conocidas. Su versión de «Si me dejas no vale» subió rápido en las listas radiales y llegó a audiencias televisivas de toda Latinoamérica a través del canal musical HTV."}]},{"type":"paragraph","content":[{"type":"text","text":"Madrid y «El Impactante»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Tras una relación sentimental, Juan Manuel se mudó a Madrid, donde construyó una carrera como solista, conocido allí como «El Impactante», y giró por buena parte de Europa tanto solo como junto a grandes estrellas de la música tropical. En su primera gira por Perú, en 2013, escribió, arregló y grabó en un solo día una canción junto a la cantante y actriz peruana Alejandra Pascucci, exvocalista del grupo Alma Bella: «El Idiota», que tuvo amplia cobertura en la prensa y televisión peruanas."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Juan Manuel siguió publicando discos, entre ellos «Corazón de Bachata» y, más adelante, «Juan Manuel y los Clásicos del Merengue», y se ha mantenido activo en la televisión dominicana, presentándose en «Extremo a Extremo» de Telemicro como un artista que, décadas después, sigue siendo identificado con la orquesta que lo dio a conocer internacionalmente."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-manuel'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-manuel' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Juan Manuel —nombre completo Juan Manuel Puente, nacido en El Seibo, en el este de la República Dominicana— es cantante, productor, arreglista y compositor dominicano de merengue y bachata, conocido sobre todo como la voz detrás de la exitosa versión en merengue de «Si me dejas no vale» de la orquesta neoyorquina La Línea.

**De los objetos encontrados a «Sensación Juvenil»**

De niño hacía música con lo que encontraba en casa o en la calle, desde latas de refresco hasta envases vacíos de desodorante. A los dieciséis años su constancia lo llevó a integrar la agrupación «Sensación Juvenil», y más tarde se unió a «Orquesta La Unión», antes de trasladarse a Santo Domingo, donde rápidamente se convirtió en voz principal de «Orquesta Caramba» y viajó a Nueva York para grabar su primera producción con ellos.

**«La Línea» y «Si me dejas no vale»**

Prendado de la ciudad y de las oportunidades que ofrecía a su carrera, se quedó en Nueva York durante cinco años, integrándose a la orquesta «La Línea», que lo dio a conocer internacionalmente con versiones en merengue de canciones conocidas. Su versión de «Si me dejas no vale» subió rápido en las listas radiales y llegó a audiencias televisivas de toda Latinoamérica a través del canal musical HTV.

**Madrid y «El Impactante»**

Tras una relación sentimental, Juan Manuel se mudó a Madrid, donde construyó una carrera como solista, conocido allí como «El Impactante», y giró por buena parte de Europa tanto solo como junto a grandes estrellas de la música tropical. En su primera gira por Perú, en 2013, escribió, arregló y grabó en un solo día una canción junto a la cantante y actriz peruana Alejandra Pascucci, exvocalista del grupo Alma Bella: «El Idiota», que tuvo amplia cobertura en la prensa y televisión peruanas.

**Legado**

Juan Manuel siguió publicando discos, entre ellos «Corazón de Bachata» y, más adelante, «Juan Manuel y los Clásicos del Merengue», y se ha mantenido activo en la televisión dominicana, presentándose en «Extremo a Extremo» de Telemicro como un artista que, décadas después, sigue siendo identificado con la orquesta que lo dio a conocer internacionalmente.' WHERE slug = 'juan-manuel';

COMMIT;
