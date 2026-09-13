BEGIN;

-- Rewrite the catalogue entry for Jeff.
--
-- Jeff (Jeffrey Henríquez Rijo). SEXTA de las dieciocho, y la más rara del
-- lote: no es una ficha pobre, es una ficha INFLADA. Y la única hasta ahora
-- donde el texto publicado discute con una versión anterior de sí mismo.
--
-- LA FRASE QUE NO PUEDE ESTAR EN UNA PÁGINA PÚBLICA. El texto decía:
-- "prioritizing emotional melodies and rhythmic beats over the traditional
-- classical structures MISTAKENLY ATTRIBUTED TO HIM PREVIOUSLY". Eso es una
-- nota de edición, no una biografía. Y lo peor: LA FILA TODAVÍA GUARDABA EL
-- ERROR QUE EL TEXTO DESMIENTE -- genres tenía 'instrumental-classical' y
-- artist_tags tenía 'instrumental'. Se corrigió el texto y se dejó el dato.
--
-- SE QUITAN CUATRO COSAS QUE NO PUEDEN IR:
--
--   LOS PADRES. "Jeffrey is the son of Luis Alberto Henríquez and Eusebia Rijo
--   López". Vida privada, y de personas que no son públicas.
--
--   EL PERCENTIL DE MUSO.AI. "placed in the Top 25% of global songwriters based
--   on his active collaborations and growing digital footprint". Es una métrica
--   de plataforma, del mismo género que las cifras de seguidores que aquí no se
--   escriben, y encima no se puede comprobar.
--
--   LA PROMOCIÓN DE SUS REDES. "He shares a steady stream of musical updates,
--   behind-the-scenes content, and snippet previews directly with his audience
--   via his official Facebook Page". Eso es copy, no biografía. Igual que la
--   mención al "verified musical profile" de Musixmatch, que es un perfil
--   autogestionado y no acredita nada.
--
--   QUE ES ACTOR DE DOBLAJE. "professional voice actor based in Higüey". LO
--   BUSQUÉ Y NO APARECE POR NINGÚN LADO. Su propia página de artista en
--   Facebook se describe "Cantante | Compositor", sin una palabra de locución.
--   Un oficio inventado en una ficha pública es exactamente lo que hace que la
--   gente deje de creerle al catálogo.
--
-- TAMPOCO SE ESCRIBEN LAS "11 COMMERCIAL TRACKS". El canal tiene 53 videos
-- entre canciones, shorts y un mix ajeno; los sencillos distribuidos con
-- metadata propia son menos. En vez de una cifra que no cuadra, se nombran los
-- títulos, que sí se pueden comprobar uno por uno.
--
-- LO QUE SÍ QUEDÓ VERIFICADO, Y ES BUENO:
--
--   "NO VALIÓ LA PENA" tiene ficha de derechos completa. La línea "Provided to
--   YouTube by" del canal Topic dice: ONErpm / No Valió la Pena · Jeff ·
--   Jeffrey Henríquez Rijo · Disny music / ℗ DISNY RD MUSIC / Released on:
--   2025-05-10 / Producer: Disny. El tercer campo de esa línea es el
--   COMPOSITOR: él mismo. O sea que 'composer' en occupations está ganado por
--   crédito registrado y no por suposición.
--
--   LOS TÍTULOS Y SU ORDEN, del propio canal: Llora y Llora, Perfecta, Mientes,
--   Ya No Te Quiero, Acuérdate (con Lara51), Mi Adicción (prod. Miguel Gómez
--   RD), Pa' Olvidarme de Ella (prod. Malevolo), Eto' Se Acabó (con Negro
--   Caly), Se Fue, Amor de Verano, No Valió la Pena y Le Fallé al Amor, esta
--   última de hace pocos días.
--
-- LAS FECHAS SE ESCRIBEN CON CUIDADO. Solo "No Valió la Pena" tiene fecha
-- exacta y por eso es la única que se fecha al día. De "Le Fallé al Amor" se
-- dice 2026 porque el canal la marca de hace pocos días. Del resto NO SE
-- INVENTA AÑO: YouTube dice "hace 4 años" y eso no es una fecha.
--
-- CUATRO DEFECTOS DE LA FILA:
--
--   genres pierde 'instrumental-classical', que es el error que el propio texto
--   publicado declaraba erróneo. Quedan bachata y urban-reggaeton.
--
--   artist_tags pierde 'instrumental', por lo mismo.
--
--   occupations pierde 'musician', que no dice nada, y queda 'composer', que
--   está acreditado en la metadata de ONErpm.
--
--   sort_name estaba en NULL. Pasa a 'Henríquez Rijo, Jeffrey'.
--
-- SE DEJA 'bachata' EN genres Y SE REPORTA. No encontré una sola bachata suya:
-- todo lo que oí y vi es reguetón romántico. Pero el género es decisión del
-- editor y esto no es un error autodeclarado como el otro, así que no lo toco.
--
-- SE DEJA instruments = ['guitar'] Y SE REPORTA. No encontré nada que lo
-- sostenga ni nada que lo desmienta. Ante la duda no se borra investigación
-- ajena, pero queda anotado.
--
-- EL FACEBOOK GUARDADO ES CORRECTO AUNQUE PAREZCA TRUNCADO. 'Jeffhrmusi'
-- resuelve, y es su PERFIL personal: 5.9K seguidores y publicación de hace
-- siete horas. Existe además una PÁGINA de artista en 'Jeffhrmusic', con menos
-- seguidores. Por la regla de página contra perfil -- se queda la de más
-- actividad, seguidores y recencia -- gana el perfil, que es lo que ya estaba.
-- Queda reportada la existencia de la página por si el editor prefiere la
-- cuenta de artista aunque sea más chica.
--
-- LOS TRES HANDLES ESTÁN VIVOS, comprobados hoy: youtube @jeffhrmusic (el canal
-- muestra @Jeffhrmusic con J mayúscula, diferencia de caja que no rompe nada),
-- instagram jeffhrmusic, facebook Jeffhrmusi.
--
-- SIN ENLACES, Y ES LO HONESTO. Comprobé con verificar-faltantes.cjs a sus
-- cinco colaboradores y NINGUNO está en el catálogo. Una ficha de artista
-- emergente sin enlaces no es una ficha mal hecha; es el mapa real de dónde
-- está parado.
--
-- FICHA CORTA A PROPÓSITO. Quitando lo inventado, lo promocional y lo privado,
-- lo que queda es un cantautor de veintiséis años con una docena de canciones y
-- un sencillo que funcionó. Escribir cinco mil caracteres sobre eso obligaría a
-- rellenar, que es justo el vicio que estoy corrigiendo.
--
-- FUENTES: el canal de YouTube @jeffhrmusic para los títulos y el orden. La
-- línea de créditos de ONErpm en el canal Topic para la fecha, el sello, el
-- productor y la autoría de "No Valió la Pena". Su página de artista en
-- Facebook para cómo se describe él. La fila para fecha y lugar de nacimiento,
-- que codifican investigación anterior.
--
-- NOMBRES NUEVOS PARA LA LISTA, comprobados: Lara51, Negro Caly, Disny,
-- Malevolo y Miguel Gómez RD. Ninguno está.
--
-- Applied directly over DATABASE_URL as part of an editorial pass. No Vercel
-- function ran and nothing was revalidated; the profile reaches the public site
-- on its own within the 31-day ISR fallback for artist profiles, or sooner if a
-- targeted revalidation is run for the slug.
--
-- This file reproduces the change from the pre-pass state. Both it and its
-- rollback were generated from state captured live either side of the write,
-- not reconstructed afterwards.

UPDATE artists SET
       name = 'Jeff',
       sort_name = 'Henríquez Rijo, Jeffrey',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urbano',
       date_of_birth = '1999-10-28',
       birth_year = 1999,
       date_of_death = NULL,
       birth_place = 'Higüey',
       province = 'La Altagracia',
       first_name = 'Jeffrey',
       middle_name = NULL,
       last_name = 'Henríquez',
       second_last_name = 'Rijo',
       stage_name = 'Jeffrey Henríquez Rijo',
       aliases = ARRAY[]::text[],
       occupations = '["composer"]'::jsonb,
       instruments = ARRAY['guitar']::text[],
       genres = ARRAY['bachata', 'urban-reggaeton']::text[],
       artist_tags = ARRAY['secular', 'emerging']::text[],
       website = NULL,
       youtube = '@jeffhrmusic',
       facebook = 'Jeffhrmusi',
       instagram = 'jeffhrmusic',
       disambiguation = 'Independent singer and songwriter from Higüey working in romantic reggaetón',
       bio_en = 'Jeffrey Henríquez Rijo, who records as Jeff, is a Dominican singer and songwriter working in romantic reggaetón. He was born in Higüey in 1999 and releases his music independently.

**Higüey**

He comes from Higüey, in the province of La Altagracia, and began putting songs out on his own channel at the start of the decade: Llora y Llora, Perfecta, Mientes and Ya No Te Quiero. The register was set early and has not moved much since. The songs are slow, sung rather than rapped, and almost all of them are about a relationship that has already ended.

**No Valió la Pena**

No Valió la Pena, released on 10 May 2025 through ONErpm under the DISNY RD MUSIC imprint, is the record that reached furthest. Disny produced it, and the rights metadata credits the words and music to Henríquez Rijo himself, which is the clearest evidence that the songwriting is his own rather than bought in.

**The other records**

He recorded Acuérdate with Lara51 and Eto’ Se Acabó with Negro Caly, and worked with the producers Miguel Gómez RD on Mi Adicción and Malevolo on Pa’ Olvidarme de Ella. Se Fue and Amor de Verano followed, and Le Fallé al Amor arrived in 2026.

He runs his releases through an imprint of his own, JEFFHRMUSIC, without a record company behind him.',
       bio_es = 'Jeffrey Henríquez Rijo, que graba como Jeff, es un cantante y compositor dominicano de reguetón romántico. Nació en Higüey en 1999 y publica su música de manera independiente.

**Higüey**

Es de Higüey, en la provincia de La Altagracia, y empezó a sacar canciones por su propio canal a principios de la década: Llora y Llora, Perfecta, Mientes y Ya No Te Quiero. El registro quedó fijado desde entonces y no se ha movido mucho. Son canciones lentas, cantadas y no rapeadas, y casi todas hablan de una relación que ya se acabó.

**No Valió la Pena**

No Valió la Pena, publicada el 10 de mayo de 2025 por ONErpm bajo el sello DISNY RD MUSIC, es la que más lejos llegó. La produjo Disny, y la metadata de derechos acredita letra y música al propio Henríquez Rijo, que es la prueba más clara de que la escritura es suya y no comprada.

**Los otros discos**

Grabó Acuérdate con Lara51 y Eto’ Se Acabó con Negro Caly, y trabajó con los productores Miguel Gómez RD en Mi Adicción y Malevolo en Pa’ Olvidarme de Ella. Detrás vinieron Se Fue y Amor de Verano, y Le Fallé al Amor salió en 2026.

Maneja sus lanzamientos desde un sello propio, JEFFHRMUSIC, sin una disquera detrás.',
       updated_at = now()
 WHERE slug = 'jeffrey-henriquez-rijo';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jeffrey-henriquez-rijo')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jeffrey-henriquez-rijo')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jeffrey Henríquez Rijo, who records as Jeff, is a Dominican singer and songwriter working in romantic reggaetón. He was born in Higüey in 1999 and releases his music independently.","type":"text"}]},{"type":"paragraph","content":[{"text":"Higüey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He comes from Higüey, in the province of La Altagracia, and began putting songs out on his own channel at the start of the decade: Llora y Llora, Perfecta, Mientes and Ya No Te Quiero. The register was set early and has not moved much since. The songs are slow, sung rather than rapped, and almost all of them are about a relationship that has already ended.","type":"text"}]},{"type":"paragraph","content":[{"text":"No Valió la Pena","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"No Valió la Pena, released on 10 May 2025 through ONErpm under the DISNY RD MUSIC imprint, is the record that reached furthest. Disny produced it, and the rights metadata credits the words and music to Henríquez Rijo himself, which is the clearest evidence that the songwriting is his own rather than bought in.","type":"text"}]},{"type":"paragraph","content":[{"text":"The other records","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He recorded Acuérdate with Lara51 and Eto’ Se Acabó with Negro Caly, and worked with the producers Miguel Gómez RD on Mi Adicción and Malevolo on Pa’ Olvidarme de Ella. Se Fue and Amor de Verano followed, and Le Fallé al Amor arrived in 2026.","type":"text"}]},{"type":"paragraph","content":[{"text":"He runs his releases through an imprint of his own, JEFFHRMUSIC, without a record company behind him.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jeffrey-henriquez-rijo'), 2)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Jeffrey Henríquez Rijo, que graba como Jeff, es un cantante y compositor dominicano de reguetón romántico. Nació en Higüey en 1999 y publica su música de manera independiente.","type":"text"}]},{"type":"paragraph","content":[{"text":"Higüey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Es de Higüey, en la provincia de La Altagracia, y empezó a sacar canciones por su propio canal a principios de la década: Llora y Llora, Perfecta, Mientes y Ya No Te Quiero. El registro quedó fijado desde entonces y no se ha movido mucho. Son canciones lentas, cantadas y no rapeadas, y casi todas hablan de una relación que ya se acabó.","type":"text"}]},{"type":"paragraph","content":[{"text":"No Valió la Pena","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"No Valió la Pena, publicada el 10 de mayo de 2025 por ONErpm bajo el sello DISNY RD MUSIC, es la que más lejos llegó. La produjo Disny, y la metadata de derechos acredita letra y música al propio Henríquez Rijo, que es la prueba más clara de que la escritura es suya y no comprada.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los otros discos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Grabó Acuérdate con Lara51 y Eto’ Se Acabó con Negro Caly, y trabajó con los productores Miguel Gómez RD en Mi Adicción y Malevolo en Pa’ Olvidarme de Ella. Detrás vinieron Se Fue y Amor de Verano, y Le Fallé al Amor salió en 2026.","type":"text"}]},{"type":"paragraph","content":[{"text":"Maneja sus lanzamientos desde un sello propio, JEFFHRMUSIC, sin una disquera detrás.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'jeffrey-henriquez-rijo'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
