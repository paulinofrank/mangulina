BEGIN;

-- Ficha NUEVA en estado draft: Yiyo Sarante (Eduardo Sarante), hermano de Julián Oro Duro. Tres Premios Soberano (Salsero del Año 2014, 2025, 2026) y parentesco de hermanos.

INSERT INTO artists (name, sort_name, type, first_name, middle_name, last_name, second_last_name, stage_name, birth_year, birth_place, province, youtube, instagram, aliases,
                                 occupations, instruments, genres, gender, ended, slug, primary_role, artist_tags, status, primary_genre, has_image, id)
  VALUES ('Yiyo Sarante', 'Sarante, Yiyo', 'solo_artist', 'Eduardo', 'Alberto', 'Sarante', 'Perdomo', 'Yiyo Sarante', 1979, 'Baní', 'Peravia', '@YiyoSarantee', 'yiyosarante',
          ARRAY['La Voz de la Salsa']::text[], '[]'::jsonb, ARRAY['conga']::text[], '{}'::text[], 'male', false, 'yiyo-sarante', 'singer', ARRAY['secular']::text[], 'draft', 'salsa', false, '0d54316a-0114-4754-ae89-72a87ed7069c');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT x.id, 'dec5d9e2-427b-414a-975f-41580488a7fd', '679164a7-3aa6-4d89-ab4e-832e585848e6', 2014, NULL, true, 'Canal oficial de los Premios Soberano (19 mar. 2014: «Yiyo Sarante ganador como salsero del año»); tutropical y Sabrosita 590' FROM artists x WHERE x.slug = 'yiyo-sarante';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT x.id, 'dec5d9e2-427b-414a-975f-41580488a7fd', '679164a7-3aa6-4d89-ab4e-832e585848e6', 2025, NULL, true, 'Premios Soberano 2025 (lista de nominados y ganadores de Conectate); publicación del propio artista del 26 mar. 2025' FROM artists x WHERE x.slug = 'yiyo-sarante';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT x.id, 'dec5d9e2-427b-414a-975f-41580488a7fd', '679164a7-3aa6-4d89-ab4e-832e585848e6', 2026, NULL, true, 'Premios Soberano 2026, 41.ª entrega (18 mar. 2026; Conectate, lista de ganadores, y Arte y Medio)' FROM artists x WHERE x.slug = 'yiyo-sarante';

INSERT INTO artist_family_relationships (artist_id, related_artist_id, relationship_type, relationship_status)
  SELECT LEAST(a.id, b.id), GREATEST(a.id, b.id), 'sibling', NULL FROM artists a, artists b WHERE a.slug = 'yiyo-sarante' AND b.slug = 'julian-oro-duro';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Yiyo Sarante —Eduardo Sarante, born in 1979 in Baní— is a Dominican salsa singer known as “La Voz de la Salsa”, the voice of salsa. He is the younger brother of the merengue singer Julián Oro Duro."}]},{"type":"paragraph","content":[{"type":"text","text":"From the congas to the microphone","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He grew up in a musical family, the seventh of nine children, five of whom became musicians. He began as a percussionist and by the age of seven was playing the conga in local orchestras. In 1999 he made his debut as a singer in the tourist area of Bávaro, and in 2003 he joined the orchestra Oro Duro, led by his brother Julián."}]},{"type":"paragraph","content":[{"type":"text","text":"Solo career","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2010, encouraged by his brother and producer José Sarante, he started a solo career and began recording salsa versions of popular songs, among them «Pirata», «Maldita primavera» and «Tierra mala». In 2011 «Tierra mala» reached second place on the annual list of the fifty most played salsa songs in the Dominican Republic, and in 2012 «Maldita primavera» began to be heard on radio in Florida and along the East Coast of the United States. His album «La Voz de la Salsa», with twelve songs, came out in 2013, and he later released «El Álbum». Among his best-known songs are «Me vas a extrañar», «Corazón de acero» and «Mi todo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Recognition","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He won the Premio Soberano for Salsa Performer of the Year in 2014, the year he also played the Festival Presidente, and again in 2025 and 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"Recent work","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"On 31 August 2026 he released a new official video of «Corazón de acero» on his YouTube channel."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A 2025 profile on a Mexican salsa radio site described him as one of the leading figures of contemporary salsa."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'yiyo-sarante';
UPDATE artists SET bio_en = 'Yiyo Sarante —Eduardo Sarante, born in 1979 in Baní— is a Dominican salsa singer known as “La Voz de la Salsa”, the voice of salsa. He is the younger brother of the merengue singer Julián Oro Duro.

**From the congas to the microphone**

He grew up in a musical family, the seventh of nine children, five of whom became musicians. He began as a percussionist and by the age of seven was playing the conga in local orchestras. In 1999 he made his debut as a singer in the tourist area of Bávaro, and in 2003 he joined the orchestra Oro Duro, led by his brother Julián.

**Solo career**

In 2010, encouraged by his brother and producer José Sarante, he started a solo career and began recording salsa versions of popular songs, among them «Pirata», «Maldita primavera» and «Tierra mala». In 2011 «Tierra mala» reached second place on the annual list of the fifty most played salsa songs in the Dominican Republic, and in 2012 «Maldita primavera» began to be heard on radio in Florida and along the East Coast of the United States. His album «La Voz de la Salsa», with twelve songs, came out in 2013, and he later released «El Álbum». Among his best-known songs are «Me vas a extrañar», «Corazón de acero» and «Mi todo».

**Recognition**

He won the Premio Soberano for Salsa Performer of the Year in 2014, the year he also played the Festival Presidente, and again in 2025 and 2026.

**Recent work**

On 31 August 2026 he released a new official video of «Corazón de acero» on his YouTube channel.

**Legacy**

A 2025 profile on a Mexican salsa radio site described him as one of the leading figures of contemporary salsa.' WHERE slug = 'yiyo-sarante';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Yiyo Sarante —Eduardo Sarante, nacido en 1979 en Baní— es un cantante dominicano de salsa conocido como “La Voz de la Salsa”. Es hermano menor del cantante de merengue Julián Oro Duro."}]},{"type":"paragraph","content":[{"type":"text","text":"De las congas al micrófono","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Creció en una familia de músicos, séptimo de nueve hijos, de los cuales cinco se dedicaron a la música. Empezó como percusionista y a los siete años ya tocaba la conga en orquestas locales. En 1999 debutó como cantante en la zona turística de Bávaro, y en 2003 se integró a la orquesta Oro Duro, dirigida por su hermano Julián."}]},{"type":"paragraph","content":[{"type":"text","text":"Carrera en solitario","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2010, animado por su hermano y productor José Sarante, inició su carrera como solista y empezó a grabar versiones en salsa de canciones populares, entre ellas «Pirata», «Maldita primavera» y «Tierra mala». En 2011 «Tierra mala» alcanzó el segundo lugar de la lista anual de las cincuenta canciones de salsa más tocadas de República Dominicana, y en 2012 «Maldita primavera» empezó a sonar en las emisoras de Florida y de la costa este de Estados Unidos. Su álbum «La Voz de la Salsa», de doce canciones, salió en 2013, y más tarde publicó «El Álbum». Entre sus canciones más conocidas figuran «Me vas a extrañar», «Corazón de acero» y «Mi todo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Reconocimiento","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ganó el Premio Soberano a Salsero del Año en 2014, año en que también actuó en el Festival Presidente, y de nuevo en 2025 y 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"Trabajo reciente","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El 31 de agosto de 2026 publicó en su canal de YouTube un nuevo video oficial de «Corazón de acero»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Un perfil de 2025 en un sitio mexicano de radio de salsa lo describió como una de las figuras más importantes de la salsa contemporánea."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'yiyo-sarante';
UPDATE artists SET bio_es = 'Yiyo Sarante —Eduardo Sarante, nacido en 1979 en Baní— es un cantante dominicano de salsa conocido como “La Voz de la Salsa”. Es hermano menor del cantante de merengue Julián Oro Duro.

**De las congas al micrófono**

Creció en una familia de músicos, séptimo de nueve hijos, de los cuales cinco se dedicaron a la música. Empezó como percusionista y a los siete años ya tocaba la conga en orquestas locales. En 1999 debutó como cantante en la zona turística de Bávaro, y en 2003 se integró a la orquesta Oro Duro, dirigida por su hermano Julián.

**Carrera en solitario**

En 2010, animado por su hermano y productor José Sarante, inició su carrera como solista y empezó a grabar versiones en salsa de canciones populares, entre ellas «Pirata», «Maldita primavera» y «Tierra mala». En 2011 «Tierra mala» alcanzó el segundo lugar de la lista anual de las cincuenta canciones de salsa más tocadas de República Dominicana, y en 2012 «Maldita primavera» empezó a sonar en las emisoras de Florida y de la costa este de Estados Unidos. Su álbum «La Voz de la Salsa», de doce canciones, salió en 2013, y más tarde publicó «El Álbum». Entre sus canciones más conocidas figuran «Me vas a extrañar», «Corazón de acero» y «Mi todo».

**Reconocimiento**

Ganó el Premio Soberano a Salsero del Año en 2014, año en que también actuó en el Festival Presidente, y de nuevo en 2025 y 2026.

**Trabajo reciente**

El 31 de agosto de 2026 publicó en su canal de YouTube un nuevo video oficial de «Corazón de acero».

**Legado**

Un perfil de 2025 en un sitio mexicano de radio de salsa lo describió como una de las figuras más importantes de la salsa contemporánea.' WHERE slug = 'yiyo-sarante';

COMMIT;
