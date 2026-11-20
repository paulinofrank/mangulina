DO $hansel$
DECLARE
  v_rows integer;
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM public.artists a
    WHERE a.id='5ac3a5ea-c385-4db3-97cf-be8610ad2e91'::uuid
      AND a.status='published'
      AND a.facebook='hansel.cantantedominicanoJhensen'
      AND a.spotify IS NULL
      AND a.aliases=ARRAY['Hansel Núñez','Hansel Jhensen']::text[]
      AND a.birth_place='Santo Domingo'
      AND a.province='Santo Domingo'
  ) THEN RAISE EXCEPTION 'Hansel artist baseline changed'; END IF;
  IF (SELECT count(*) FROM public.editorial_documents d
      WHERE d.owner_artist_id='5ac3a5ea-c385-4db3-97cf-be8610ad2e91'::uuid
        AND d.locale IN ('en','es') AND d.revision=2 AND d.status='published') <> 2
  THEN RAISE EXCEPTION 'Hansel biography revisions changed'; END IF;
  PERFORM 1 FROM public.upsert_editorial_document('artist_biography','5ac3a5ea-c385-4db3-97cf-be8610ad2e91'::uuid,'en',1,'published','{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Hansel is a Dominican romantic-ballad singer whose work gained attention in the 1980s. Before his solo career, he sang with "},{"type":"artistReference","attrs":{"artistId":"02b306b3-acc0-4800-b314-05683205d1c5","displayText":"Jossie Esteban y La Patrulla 15","occurrenceId":"064028df-fd5f-4b26-b0ae-468eb47dbb02"}},{"type":"text","text":". «Te Perdono», «Niña de Fuego» and «Quien Después de Mi» are among the songs most closely associated with his voice."}]},{"type":"paragraph","content":[{"type":"text","text":"From orchestra to ballads","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His time with "},{"type":"artistReference","attrs":{"artistId":"02b306b3-acc0-4800-b314-05683205d1c5","displayText":"Jossie Esteban y La Patrulla 15","occurrenceId":"634cbd58-bef2-41ef-8546-411d5b0b0945"}},{"type":"text","text":" first connected him with merengue. He later recorded ballads for «Bronco», whose LP from that period includes «Te Perdono» and «Niña de Fuego». A 1986 television performance on «El Show del Mediodía» also documents «Niña de Fuego» in his repertoire."}]},{"type":"paragraph","content":[{"type":"text","text":"On stage","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In July 2011 he joined Sergio Hernández for an evening of ballads and boleros at Santo Domingo''s Maunaloa. He performed «Niña de Fuego», «Para Olvidarme de Ti», «Una Lágrima Mía», «Silencio», «Quien Después de Mi» and «Te Perdono». In 2015 he shared the bill with "},{"type":"artistReference","attrs":{"artistId":"081c1484-bf1c-4b11-ba01-d68446b7b111","displayText":"Anthony Ríos","occurrenceId":"a12929c1-6b41-4baf-8c66-ad0c545df330"}},{"type":"text","text":", Jackelyn Estévez and "},{"type":"artistReference","attrs":{"artistId":"20610d35-0190-4733-90c0-8c7db5cbe7e0","displayText":"Vickiana","occurrenceId":"92fcc7e9-bbaf-491a-8100-de971c065419"}},{"type":"text","text":" at «Baladas de Oro»."}]},{"type":"paragraph","content":[{"type":"text","text":"The repertoire in digital form","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The 2012 compilation «20 Grandes Exitos» appeared under the name Hansel (Cantante Dominicano) on «Ciudad Corazon Baladistas Dominicanos». It includes «Quien Después de Mi», «Niña de Fuego», «Te Perdono» and other songs from his repertoire. His public Facebook profile shows continued activity in 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Hansel''s career links an early period singing merengue with the Dominican romantic ballads of the 1980s. His later appearances and the digital circulation of his songs have kept that repertoire available to new listeners."}]}]}'::jsonb,2);
  PERFORM 1 FROM public.upsert_editorial_document('artist_biography','5ac3a5ea-c385-4db3-97cf-be8610ad2e91'::uuid,'es',1,'published','{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Hansel es un cantante dominicano de balada romántica que alcanzó difusión en la década de 1980. Antes de su carrera como solista cantó con "},{"type":"artistReference","attrs":{"artistId":"02b306b3-acc0-4800-b314-05683205d1c5","displayText":"Jossie Esteban y La Patrulla 15","occurrenceId":"5055219e-64d2-4dce-a958-b48aec5cbb8f"}},{"type":"text","text":". «Te Perdono», «Niña de Fuego» y «Quien Después de Mi» figuran entre las canciones más asociadas con su voz."}]},{"type":"paragraph","content":[{"type":"text","text":"De la orquesta a la balada","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su paso por "},{"type":"artistReference","attrs":{"artistId":"02b306b3-acc0-4800-b314-05683205d1c5","displayText":"Jossie Esteban y La Patrulla 15","occurrenceId":"ede33dab-68d7-4fc1-8cc1-91fafac9796b"}},{"type":"text","text":" lo vinculó primero al merengue. Después grabó baladas para el sello «Bronco»: un LP de la época reúne «Te Perdono» y «Niña de Fuego». Esta última también quedó documentada en una presentación televisiva de 1986 en «El Show del Mediodía»."}]},{"type":"paragraph","content":[{"type":"text","text":"En los escenarios","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En julio de 2011 participó en una noche de baladas y boleros junto a Sergio Hernández en el Maunaloa de Santo Domingo. Allí interpretó «Niña de Fuego», «Para Olvidarme de Ti», «Una Lágrima Mía», «Silencio», «Quien Después de Mi» y «Te Perdono». En 2015 compartió cartel con "},{"type":"artistReference","attrs":{"artistId":"081c1484-bf1c-4b11-ba01-d68446b7b111","displayText":"Anthony Ríos","occurrenceId":"eb049b8b-f3e1-452b-aeaf-14ae5e57870a"}},{"type":"text","text":", Jackelyn Estévez y "},{"type":"artistReference","attrs":{"artistId":"20610d35-0190-4733-90c0-8c7db5cbe7e0","displayText":"Vickiana","occurrenceId":"a645bc06-97c0-458a-89c4-5189597c01d0"}},{"type":"text","text":" en el espectáculo «Baladas de Oro»."}]},{"type":"paragraph","content":[{"type":"text","text":"El repertorio en formato digital","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2012 apareció la recopilación «20 Grandes Exitos», publicada a nombre de Hansel (Cantante Dominicano) por «Ciudad Corazon Baladistas Dominicanos». Incluyó grabaciones de «Quien Después de Mi», «Niña de Fuego» y «Te Perdono», junto a otros títulos de su repertorio. Su perfil público de Facebook documenta que seguía activo en 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La trayectoria de Hansel enlaza una etapa como vocalista de merengue con la balada dominicana de los años ochenta. Sus presentaciones posteriores y la circulación digital de sus canciones han mantenido ese repertorio al alcance de nuevas audiencias."}]}]}'::jsonb,2);
  UPDATE public.artists SET
    facebook='hansel.cantantedominicano',
    spotify='3Jo9urwUevcDVto6jIBaGC',
    aliases=ARRAY['Hansel Núñez']::text[],
    birth_place=NULL,
    province=NULL,
    bio_en='Hansel is a Dominican romantic-ballad singer whose work gained attention in the 1980s. Before his solo career, he sang with Jossie Esteban y La Patrulla 15. «Te Perdono», «Niña de Fuego» and «Quien Después de Mi» are among the songs most closely associated with his voice.

**From orchestra to ballads**

His time with Jossie Esteban y La Patrulla 15 first connected him with merengue. He later recorded ballads for «Bronco», whose LP from that period includes «Te Perdono» and «Niña de Fuego». A 1986 television performance on «El Show del Mediodía» also documents «Niña de Fuego» in his repertoire.

**On stage**

In July 2011 he joined Sergio Hernández for an evening of ballads and boleros at Santo Domingo''s Maunaloa. He performed «Niña de Fuego», «Para Olvidarme de Ti», «Una Lágrima Mía», «Silencio», «Quien Después de Mi» and «Te Perdono». In 2015 he shared the bill with Anthony Ríos, Jackelyn Estévez and Vickiana at «Baladas de Oro».

**The repertoire in digital form**

The 2012 compilation «20 Grandes Exitos» appeared under the name Hansel (Cantante Dominicano) on «Ciudad Corazon Baladistas Dominicanos». It includes «Quien Después de Mi», «Niña de Fuego», «Te Perdono» and other songs from his repertoire. His public Facebook profile shows continued activity in 2026.

**Legacy**

Hansel''s career links an early period singing merengue with the Dominican romantic ballads of the 1980s. His later appearances and the digital circulation of his songs have kept that repertoire available to new listeners.',
    bio_es='Hansel es un cantante dominicano de balada romántica que alcanzó difusión en la década de 1980. Antes de su carrera como solista cantó con Jossie Esteban y La Patrulla 15. «Te Perdono», «Niña de Fuego» y «Quien Después de Mi» figuran entre las canciones más asociadas con su voz.

**De la orquesta a la balada**

Su paso por Jossie Esteban y La Patrulla 15 lo vinculó primero al merengue. Después grabó baladas para el sello «Bronco»: un LP de la época reúne «Te Perdono» y «Niña de Fuego». Esta última también quedó documentada en una presentación televisiva de 1986 en «El Show del Mediodía».

**En los escenarios**

En julio de 2011 participó en una noche de baladas y boleros junto a Sergio Hernández en el Maunaloa de Santo Domingo. Allí interpretó «Niña de Fuego», «Para Olvidarme de Ti», «Una Lágrima Mía», «Silencio», «Quien Después de Mi» y «Te Perdono». En 2015 compartió cartel con Anthony Ríos, Jackelyn Estévez y Vickiana en el espectáculo «Baladas de Oro».

**El repertorio en formato digital**

En 2012 apareció la recopilación «20 Grandes Exitos», publicada a nombre de Hansel (Cantante Dominicano) por «Ciudad Corazon Baladistas Dominicanos». Incluyó grabaciones de «Quien Después de Mi», «Niña de Fuego» y «Te Perdono», junto a otros títulos de su repertorio. Su perfil público de Facebook documenta que seguía activo en 2026.

**Legado**

La trayectoria de Hansel enlaza una etapa como vocalista de merengue con la balada dominicana de los años ochenta. Sus presentaciones posteriores y la circulación digital de sus canciones han mantenido ese repertorio al alcance de nuevas audiencias.'
  WHERE id='5ac3a5ea-c385-4db3-97cf-be8610ad2e91'::uuid
    AND facebook='hansel.cantantedominicanoJhensen'
    AND spotify IS NULL
    AND aliases=ARRAY['Hansel Núñez','Hansel Jhensen']::text[]
    AND birth_place='Santo Domingo'
    AND province='Santo Domingo';
  GET DIAGNOSTICS v_rows = ROW_COUNT;
  IF v_rows <> 1 THEN RAISE EXCEPTION 'Hansel artist update did not match baseline'; END IF;
END $hansel$;
