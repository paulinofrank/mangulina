BEGIN;

-- Ficha de Adonis Produciendo: biografía basada en su canal y las fechas de lanzamiento. occupations sin producer (ya es su primary_role).

UPDATE artists SET occupations = '["songwriter","dj","beatmaker"]'::jsonb WHERE slug = 'adonis-produciendo';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Adonis Produciendo —Ángel Adonis Feliz, born in Santo Domingo on 2 January 2005— is a Dominican producer and composer who started in 2021, at sixteen, working mainly in dembow. He also goes by El Mágico."}]},{"type":"paragraph","content":[{"type":"text","text":"Sounds","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Beyond dembow, he says he has worked in trap, rap, drill, reggaeton, afrobeat and dancehall. Many of his releases are beats and type beats, among them «Pista de Trap Romántica» and «Dembow Dominicano» (both 2022), «A I O (Dembow Type Beat)» and «LeBron En El Bameso» (2022)."}]},{"type":"paragraph","content":[{"type":"text","text":"Releases and collaborations","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The platforms list his singles from April 2022 onward, with «Rata Con Bigote», «Se Dañó el Domingo» and «Mariela» in 2023, «Maduro Renuncia» in 2024, and a dense run in 2025 and 2026 that includes «Yuju», «Se Le Da», «Ella la Pone», «La Thomson», «No Lo Apague», «Modo GTA» and «Galáctico», released on 4 September 2026. On his YouTube channel he has posted «Decocótate» with Tajalan and Mario Misterio, «Opa King» with Nerlin Doble B, King Opa and MC Maicol, an instrumental for Crazy Design’s «Que Rica», and slowed and sped-up versions of tracks by Huan62 and Lil Naay."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His work is documented mainly on the platforms where it is released and on his own channel."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'adonis-produciendo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'adonis-produciendo' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Adonis Produciendo —Ángel Adonis Feliz, born in Santo Domingo on 2 January 2005— is a Dominican producer and composer who started in 2021, at sixteen, working mainly in dembow. He also goes by El Mágico.

**Sounds**

Beyond dembow, he says he has worked in trap, rap, drill, reggaeton, afrobeat and dancehall. Many of his releases are beats and type beats, among them «Pista de Trap Romántica» and «Dembow Dominicano» (both 2022), «A I O (Dembow Type Beat)» and «LeBron En El Bameso» (2022).

**Releases and collaborations**

The platforms list his singles from April 2022 onward, with «Rata Con Bigote», «Se Dañó el Domingo» and «Mariela» in 2023, «Maduro Renuncia» in 2024, and a dense run in 2025 and 2026 that includes «Yuju», «Se Le Da», «Ella la Pone», «La Thomson», «No Lo Apague», «Modo GTA» and «Galáctico», released on 4 September 2026. On his YouTube channel he has posted «Decocótate» with Tajalan and Mario Misterio, «Opa King» with Nerlin Doble B, King Opa and MC Maicol, an instrumental for Crazy Design’s «Que Rica», and slowed and sped-up versions of tracks by Huan62 and Lil Naay.

**Legacy**

His work is documented mainly on the platforms where it is released and on his own channel.' WHERE slug = 'adonis-produciendo';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Adonis Produciendo —Ángel Adonis Feliz, nacido en Santo Domingo el 2 de enero de 2005— es un productor y compositor dominicano que empezó en 2021, a los dieciséis años, trabajando sobre todo el dembow. También se le conoce como El Mágico."}]},{"type":"paragraph","content":[{"type":"text","text":"Sonidos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Además del dembow, dice haber trabajado el trap, el rap, el drill, el reguetón, el afrobeat y el dancehall. Muchos de sus lanzamientos son beats y type beats, entre ellos «Pista de Trap Romántica» y «Dembow Dominicano» (ambos de 2022), «A I O (Dembow Type Beat)» y «LeBron En El Bameso» (2022)."}]},{"type":"paragraph","content":[{"type":"text","text":"Lanzamientos y colaboraciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Las plataformas listan sus sencillos desde abril de 2022, con «Rata Con Bigote», «Se Dañó el Domingo» y «Mariela» en 2023, «Maduro Renuncia» en 2024 y una racha densa en 2025 y 2026 que incluye «Yuju», «Se Le Da», «Ella la Pone», «La Thomson», «No Lo Apague», «Modo GTA» y «Galáctico», publicado el 4 de septiembre de 2026. En su canal de YouTube ha publicado «Decocótate» con Tajalan y Mario Misterio, «Opa King» con Nerlin Doble B, King Opa y MC Maicol, un instrumental para «Que Rica» de Crazy Design, y versiones ralentizadas y aceleradas de temas de Huan62 y Lil Naay."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su obra está documentada sobre todo en las plataformas donde se publica y en su propio canal."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'adonis-produciendo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'adonis-produciendo' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Adonis Produciendo —Ángel Adonis Feliz, nacido en Santo Domingo el 2 de enero de 2005— es un productor y compositor dominicano que empezó en 2021, a los dieciséis años, trabajando sobre todo el dembow. También se le conoce como El Mágico.

**Sonidos**

Además del dembow, dice haber trabajado el trap, el rap, el drill, el reguetón, el afrobeat y el dancehall. Muchos de sus lanzamientos son beats y type beats, entre ellos «Pista de Trap Romántica» y «Dembow Dominicano» (ambos de 2022), «A I O (Dembow Type Beat)» y «LeBron En El Bameso» (2022).

**Lanzamientos y colaboraciones**

Las plataformas listan sus sencillos desde abril de 2022, con «Rata Con Bigote», «Se Dañó el Domingo» y «Mariela» en 2023, «Maduro Renuncia» en 2024 y una racha densa en 2025 y 2026 que incluye «Yuju», «Se Le Da», «Ella la Pone», «La Thomson», «No Lo Apague», «Modo GTA» y «Galáctico», publicado el 4 de septiembre de 2026. En su canal de YouTube ha publicado «Decocótate» con Tajalan y Mario Misterio, «Opa King» con Nerlin Doble B, King Opa y MC Maicol, un instrumental para «Que Rica» de Crazy Design, y versiones ralentizadas y aceleradas de temas de Huan62 y Lil Naay.

**Legado**

Su obra está documentada sobre todo en las plataformas donde se publica y en su propio canal.' WHERE slug = 'adonis-produciendo';

COMMIT;
