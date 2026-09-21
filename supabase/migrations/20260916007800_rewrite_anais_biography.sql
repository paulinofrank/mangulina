BEGIN;

-- Anaís (Anaís Martínez Vega): ganadora de la segunda temporada de Objetivo Fama (2005), no una cantante genérica de 'pop latino y tropical'. Fuentes: Wikipedia en español (nombre completo, infancia, singles, listas, película, Love & Hip Hop), BuenaMusica, base oficial de los Latin Grammy (nominación 2006 a Mejor Álbum Vocal Pop Femenino, ganó Shakira), Hoy Digital y Diario Libre (28 y 31 mar. 2007, Premio Casandra a Artista Destacada en el Extranjero), Primera Hora (26 may. 2016, segunda edición y dos discos), Metro Puerto Rico (18 may. 2025, dos discos y nominación), EcuRed (gira 16 sep. 2006). Campos: second_last_name Vega, tag diaspora. Premios: Latin Grammy 2006 (perdido) y Casandra 2007 (ganado). Omitidos: situación de salud y personal de 2025-2026 y vida privada (Wikipedia), por la regla de causa médica.

INSERT INTO award_categories (award_id, name) SELECT '1d8267d6-ad99-4ca6-8425-1315545ad86e', 'Best Female Pop Vocal Album' WHERE NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Female Pop Vocal Album');

INSERT INTO award_categories (award_id, name) SELECT 'ead83dcf-9e2c-4f69-a557-dad604716a5e', 'Artista Destacada en el Extranjero' WHERE NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e' AND name = 'Artista Destacada en el Extranjero');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT x.id, '1d8267d6-ad99-4ca6-8425-1315545ad86e', (SELECT id FROM award_categories WHERE award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e' AND name = 'Best Female Pop Vocal Album'), 2006, 'Así soy yo', false, 'latingrammy.com (archivo de la artista, 7.ª edición); ganó Shakira con «Fijación oral, vol. 1»'
  FROM artists x WHERE x.slug = 'anais';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
  SELECT x.id, 'ead83dcf-9e2c-4f69-a557-dad604716a5e', (SELECT id FROM award_categories WHERE award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e' AND name = 'Artista Destacada en el Extranjero'), 2007, NULL, true, 'Hoy Digital (28 mar. 2007) y Diario Libre (31 mar. 2007); BuenaMusica'
  FROM artists x WHERE x.slug = 'anais';

UPDATE artists SET second_last_name = 'Vega', artist_tags = ARRAY['secular','diaspora']::text[] WHERE slug = 'anais';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Anaís —Anaís Martínez Vega, born on 22 June 1984 in Santo Domingo— is a Dominican-American singer of ballads and Latin pop who won the second season of the television talent show Objetivo Fama."}]},{"type":"paragraph","content":[{"type":"text","text":"From Santo Domingo to the Bronx","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She was born in Santo Domingo and lived there until the age of nine, when she moved with her father to the Bronx, in New York. In 2005 she won the second season of Objetivo Fama, the singing competition broadcast by Univision in Puerto Rico and the United States. At the end of that year she recorded «Arriba, abajo», a song for the 2006 FIFA World Cup, with Pablo Montero, Mariana Seoane and Ana Bárbara."}]},{"type":"paragraph","content":[{"type":"text","text":"«Así soy yo»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her debut album, «Así soy yo», came out on 18 April 2006 on Univision, with the singles «Atrapada», «Lo que son las cosas», «Estoy con él y pienso en ti» and «Estar contigo». «Lo que son las cosas», a song first recorded by Ednita Nazario, reached number one on Billboard’s Hot Latin Songs, and «Estoy con él y pienso en ti» entered its top ten. The album was nominated for the 2006 Latin Grammy for Best Female Pop Vocal Album, which went to Shakira, and she began her «Así soy yo» tour in Puerto Rico on 16 September 2006."}]},{"type":"paragraph","content":[{"type":"text","text":"«Con todo mi corazón»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her second album, «Con todo mi corazón», was released on 3 April 2007 in the United States, with the singles «Tu amor no es garantía», «Sólo mío» and «Como tu mujer», and a deluxe edition followed on 16 October. In March 2007 she received the Premio Casandra as Outstanding Artist Abroad and took part in the ceremony’s musical opening."}]},{"type":"paragraph","content":[{"type":"text","text":"Later work","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She appeared in the Dominican film «La soga» (2009) and in 2017 joined the cast of the eighth season of the reality series «Love & Hip Hop: New York»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2016 the Puerto Rican newspaper Primera Hora, reviewing the contestants of Objetivo Fama, recalled her as the winner of its second edition who went on to record two albums."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'anais'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'anais' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Anaís —Anaís Martínez Vega, born on 22 June 1984 in Santo Domingo— is a Dominican-American singer of ballads and Latin pop who won the second season of the television talent show Objetivo Fama.

**From Santo Domingo to the Bronx**

She was born in Santo Domingo and lived there until the age of nine, when she moved with her father to the Bronx, in New York. In 2005 she won the second season of Objetivo Fama, the singing competition broadcast by Univision in Puerto Rico and the United States. At the end of that year she recorded «Arriba, abajo», a song for the 2006 FIFA World Cup, with Pablo Montero, Mariana Seoane and Ana Bárbara.

**«Así soy yo»**

Her debut album, «Así soy yo», came out on 18 April 2006 on Univision, with the singles «Atrapada», «Lo que son las cosas», «Estoy con él y pienso en ti» and «Estar contigo». «Lo que son las cosas», a song first recorded by Ednita Nazario, reached number one on Billboard’s Hot Latin Songs, and «Estoy con él y pienso en ti» entered its top ten. The album was nominated for the 2006 Latin Grammy for Best Female Pop Vocal Album, which went to Shakira, and she began her «Así soy yo» tour in Puerto Rico on 16 September 2006.

**«Con todo mi corazón»**

Her second album, «Con todo mi corazón», was released on 3 April 2007 in the United States, with the singles «Tu amor no es garantía», «Sólo mío» and «Como tu mujer», and a deluxe edition followed on 16 October. In March 2007 she received the Premio Casandra as Outstanding Artist Abroad and took part in the ceremony’s musical opening.

**Later work**

She appeared in the Dominican film «La soga» (2009) and in 2017 joined the cast of the eighth season of the reality series «Love & Hip Hop: New York».

**Legacy**

In 2016 the Puerto Rican newspaper Primera Hora, reviewing the contestants of Objetivo Fama, recalled her as the winner of its second edition who went on to record two albums.' WHERE slug = 'anais';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Anaís —Anaís Martínez Vega, nacida el 22 de junio de 1984 en Santo Domingo— es una cantante dominico-estadounidense de balada y pop latino que ganó la segunda temporada del concurso televisivo Objetivo Fama."}]},{"type":"paragraph","content":[{"type":"text","text":"De Santo Domingo al Bronx","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Nació en Santo Domingo y vivió allí hasta los nueve años, cuando se mudó con su padre al Bronx, en Nueva York. En 2005 ganó la segunda temporada de Objetivo Fama, el concurso de canto que Univision transmitía en Puerto Rico y Estados Unidos. A finales de ese año grabó «Arriba, abajo», canción para la Copa Mundial de la FIFA 2006, junto a Pablo Montero, Mariana Seoane y Ana Bárbara."}]},{"type":"paragraph","content":[{"type":"text","text":"«Así soy yo»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su álbum debut, «Así soy yo», salió el 18 de abril de 2006 en Univision, con los sencillos «Atrapada», «Lo que son las cosas», «Estoy con él y pienso en ti» y «Estar contigo». «Lo que son las cosas», canción que grabó primero Ednita Nazario, llegó al número uno de Hot Latin Songs de Billboard, y «Estoy con él y pienso en ti» entró en su top diez. El álbum fue nominado al Latin Grammy 2006 a Mejor Álbum Vocal Pop Femenino, que ganó Shakira, y ella empezó su gira «Así soy yo» en Puerto Rico el 16 de septiembre de 2006."}]},{"type":"paragraph","content":[{"type":"text","text":"«Con todo mi corazón»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su segundo álbum, «Con todo mi corazón», salió el 3 de abril de 2007 en Estados Unidos, con los sencillos «Tu amor no es garantía», «Sólo mío» y «Como tu mujer», y una edición de lujo el 16 de octubre. En marzo de 2007 recibió el Premio Casandra como Artista Destacada en el Extranjero y participó en la apertura musical de la ceremonia."}]},{"type":"paragraph","content":[{"type":"text","text":"Trabajos posteriores","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Actuó en la película dominicana «La soga» (2009) y en 2017 se unió al reparto de la octava temporada de la serie de telerrealidad «Love & Hip Hop: New York»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2016 el periódico puertorriqueño Primera Hora, al repasar a los concursantes de Objetivo Fama, la recordó como la ganadora de su segunda edición que llegó a grabar dos discos."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'anais'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'anais' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Anaís —Anaís Martínez Vega, nacida el 22 de junio de 1984 en Santo Domingo— es una cantante dominico-estadounidense de balada y pop latino que ganó la segunda temporada del concurso televisivo Objetivo Fama.

**De Santo Domingo al Bronx**

Nació en Santo Domingo y vivió allí hasta los nueve años, cuando se mudó con su padre al Bronx, en Nueva York. En 2005 ganó la segunda temporada de Objetivo Fama, el concurso de canto que Univision transmitía en Puerto Rico y Estados Unidos. A finales de ese año grabó «Arriba, abajo», canción para la Copa Mundial de la FIFA 2006, junto a Pablo Montero, Mariana Seoane y Ana Bárbara.

**«Así soy yo»**

Su álbum debut, «Así soy yo», salió el 18 de abril de 2006 en Univision, con los sencillos «Atrapada», «Lo que son las cosas», «Estoy con él y pienso en ti» y «Estar contigo». «Lo que son las cosas», canción que grabó primero Ednita Nazario, llegó al número uno de Hot Latin Songs de Billboard, y «Estoy con él y pienso en ti» entró en su top diez. El álbum fue nominado al Latin Grammy 2006 a Mejor Álbum Vocal Pop Femenino, que ganó Shakira, y ella empezó su gira «Así soy yo» en Puerto Rico el 16 de septiembre de 2006.

**«Con todo mi corazón»**

Su segundo álbum, «Con todo mi corazón», salió el 3 de abril de 2007 en Estados Unidos, con los sencillos «Tu amor no es garantía», «Sólo mío» y «Como tu mujer», y una edición de lujo el 16 de octubre. En marzo de 2007 recibió el Premio Casandra como Artista Destacada en el Extranjero y participó en la apertura musical de la ceremonia.

**Trabajos posteriores**

Actuó en la película dominicana «La soga» (2009) y en 2017 se unió al reparto de la octava temporada de la serie de telerrealidad «Love & Hip Hop: New York».

**Legado**

En 2016 el periódico puertorriqueño Primera Hora, al repasar a los concursantes de Objetivo Fama, la recordó como la ganadora de su segunda edición que llegó a grabar dos discos.' WHERE slug = 'anais';

COMMIT;
