BEGIN;

-- Regla 4b en títulos de sección: nombres de obras y de entidades sin ficha
-- (bandas, sellos, programas, instituciones) entre « ». Siete fichas escritas hoy.

UPDATE editorial_documents SET document = jsonb_set(document, '{content,3,content,0,text}', '"The voice of «Los Virtuosos»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'henry-garcia') AND locale = 'en' AND document_type = 'artist_biography';
UPDATE artists SET bio_en = replace(bio_en, '**The voice of Los Virtuosos**', '**The voice of «Los Virtuosos»**') WHERE slug = 'henry-garcia';
UPDATE editorial_documents SET revision = revision + 1 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'henry-garcia') AND locale = 'en' AND document_type = 'artist_biography';

UPDATE editorial_documents SET document = jsonb_set(document, '{content,3,content,0,text}', '"La voz de «Los Virtuosos»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'henry-garcia') AND locale = 'es' AND document_type = 'artist_biography';
UPDATE artists SET bio_es = replace(bio_es, '**La voz de Los Virtuosos**', '**La voz de «Los Virtuosos»**') WHERE slug = 'henry-garcia';
UPDATE editorial_documents SET revision = revision + 1 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'henry-garcia') AND locale = 'es' AND document_type = 'artist_biography';

UPDATE editorial_documents SET document = jsonb_set(document, '{content,5,content,0,text}', '"«La Voz Dominicana» and the «Combo Show»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'vinicio-franco') AND locale = 'en' AND document_type = 'artist_biography';
UPDATE artists SET bio_en = replace(bio_en, '**La Voz Dominicana and the Combo Show**', '**«La Voz Dominicana» and the «Combo Show»**') WHERE slug = 'vinicio-franco';
UPDATE editorial_documents SET revision = revision + 1 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'vinicio-franco') AND locale = 'en' AND document_type = 'artist_biography';

UPDATE editorial_documents SET document = jsonb_set(document, '{content,5,content,0,text}', '"«La Voz Dominicana» y el «Combo Show»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'vinicio-franco') AND locale = 'es' AND document_type = 'artist_biography';
UPDATE artists SET bio_es = replace(bio_es, '**La Voz Dominicana y el Combo Show**', '**«La Voz Dominicana» y el «Combo Show»**') WHERE slug = 'vinicio-franco';
UPDATE editorial_documents SET revision = revision + 1 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'vinicio-franco') AND locale = 'es' AND document_type = 'artist_biography';

UPDATE editorial_documents SET document = jsonb_set(document, '{content,1,content,0,text}', '"Nagua y la «Escuela de Ciegos»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'teodoro-reyes') AND locale = 'es' AND document_type = 'artist_biography';
UPDATE artists SET bio_es = replace(bio_es, '**Nagua y la Escuela de Ciegos**', '**Nagua y la «Escuela de Ciegos»**') WHERE slug = 'teodoro-reyes';
UPDATE editorial_documents SET revision = revision + 1 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'teodoro-reyes') AND locale = 'es' AND document_type = 'artist_biography';

UPDATE editorial_documents SET document = jsonb_set(document, '{content,3,content,0,text}', '"«Herrera Family» and «J-Musicólogo»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'musicologo-the-libro') AND locale = 'en' AND document_type = 'artist_biography';
UPDATE artists SET bio_en = replace(bio_en, '**Herrera Family and J-Musicólogo**', '**«Herrera Family» and «J-Musicólogo»**') WHERE slug = 'musicologo-the-libro';
UPDATE editorial_documents SET document = jsonb_set(document, '{content,7,content,0,text}', '"«The Voice Dominicana»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'musicologo-the-libro') AND locale = 'en' AND document_type = 'artist_biography';
UPDATE artists SET bio_en = replace(bio_en, '**The Voice Dominicana**', '**«The Voice Dominicana»**') WHERE slug = 'musicologo-the-libro';
UPDATE editorial_documents SET document = jsonb_set(document, '{content,9,content,0,text}', '"«El Jaguar»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'musicologo-the-libro') AND locale = 'en' AND document_type = 'artist_biography';
UPDATE artists SET bio_en = replace(bio_en, '**El Jaguar**', '**«El Jaguar»**') WHERE slug = 'musicologo-the-libro';
UPDATE editorial_documents SET revision = revision + 1 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'musicologo-the-libro') AND locale = 'en' AND document_type = 'artist_biography';

UPDATE editorial_documents SET document = jsonb_set(document, '{content,3,content,0,text}', '"«Herrera Family» y «J-Musicólogo»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'musicologo-the-libro') AND locale = 'es' AND document_type = 'artist_biography';
UPDATE artists SET bio_es = replace(bio_es, '**Herrera Family y J-Musicólogo**', '**«Herrera Family» y «J-Musicólogo»**') WHERE slug = 'musicologo-the-libro';
UPDATE editorial_documents SET document = jsonb_set(document, '{content,7,content,0,text}', '"«The Voice Dominicana»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'musicologo-the-libro') AND locale = 'es' AND document_type = 'artist_biography';
UPDATE artists SET bio_es = replace(bio_es, '**The Voice Dominicana**', '**«The Voice Dominicana»**') WHERE slug = 'musicologo-the-libro';
UPDATE editorial_documents SET document = jsonb_set(document, '{content,9,content,0,text}', '"«El Jaguar»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'musicologo-the-libro') AND locale = 'es' AND document_type = 'artist_biography';
UPDATE artists SET bio_es = replace(bio_es, '**El Jaguar**', '**«El Jaguar»**') WHERE slug = 'musicologo-the-libro';
UPDATE editorial_documents SET revision = revision + 1 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'musicologo-the-libro') AND locale = 'es' AND document_type = 'artist_biography';

UPDATE editorial_documents SET document = jsonb_set(document, '{content,3,content,0,text}', '"«Tali & Messiah»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'messiah') AND locale = 'en' AND document_type = 'artist_biography';
UPDATE artists SET bio_en = replace(bio_en, '**Tali & Messiah**', '**«Tali & Messiah»**') WHERE slug = 'messiah';
UPDATE editorial_documents SET revision = revision + 1 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'messiah') AND locale = 'en' AND document_type = 'artist_biography';

UPDATE editorial_documents SET document = jsonb_set(document, '{content,3,content,0,text}', '"«Tali & Messiah»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'messiah') AND locale = 'es' AND document_type = 'artist_biography';
UPDATE artists SET bio_es = replace(bio_es, '**Tali & Messiah**', '**«Tali & Messiah»**') WHERE slug = 'messiah';
UPDATE editorial_documents SET revision = revision + 1 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'messiah') AND locale = 'es' AND document_type = 'artist_biography';

UPDATE editorial_documents SET document = jsonb_set(document, '{content,3,content,0,text}', '"«Yakuza Records»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'secreto-el-famoso-biberon') AND locale = 'en' AND document_type = 'artist_biography';
UPDATE artists SET bio_en = replace(bio_en, '**Yakuza Records**', '**«Yakuza Records»**') WHERE slug = 'secreto-el-famoso-biberon';
UPDATE editorial_documents SET revision = revision + 1 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'secreto-el-famoso-biberon') AND locale = 'en' AND document_type = 'artist_biography';

UPDATE editorial_documents SET document = jsonb_set(document, '{content,3,content,0,text}', '"«Yakuza Records»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'secreto-el-famoso-biberon') AND locale = 'es' AND document_type = 'artist_biography';
UPDATE artists SET bio_es = replace(bio_es, '**Yakuza Records**', '**«Yakuza Records»**') WHERE slug = 'secreto-el-famoso-biberon';
UPDATE editorial_documents SET revision = revision + 1 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'secreto-el-famoso-biberon') AND locale = 'es' AND document_type = 'artist_biography';

UPDATE editorial_documents SET document = jsonb_set(document, '{content,3,content,0,text}', '"«Las chapas que vibran»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'la-materialista') AND locale = 'en' AND document_type = 'artist_biography';
UPDATE artists SET bio_en = replace(bio_en, '**Las chapas que vibran**', '**«Las chapas que vibran»**') WHERE slug = 'la-materialista';
UPDATE editorial_documents SET document = jsonb_set(document, '{content,7,content,0,text}', '"«Universal» and after"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'la-materialista') AND locale = 'en' AND document_type = 'artist_biography';
UPDATE artists SET bio_en = replace(bio_en, '**Universal and after**', '**«Universal» and after**') WHERE slug = 'la-materialista';
UPDATE editorial_documents SET revision = revision + 1 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'la-materialista') AND locale = 'en' AND document_type = 'artist_biography';

UPDATE editorial_documents SET document = jsonb_set(document, '{content,3,content,0,text}', '"«Las chapas que vibran»"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'la-materialista') AND locale = 'es' AND document_type = 'artist_biography';
UPDATE artists SET bio_es = replace(bio_es, '**Las chapas que vibran**', '**«Las chapas que vibran»**') WHERE slug = 'la-materialista';
UPDATE editorial_documents SET document = jsonb_set(document, '{content,7,content,0,text}', '"«Universal» y después"'::jsonb), updated_at = now() WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'la-materialista') AND locale = 'es' AND document_type = 'artist_biography';
UPDATE artists SET bio_es = replace(bio_es, '**Universal y después**', '**«Universal» y después**') WHERE slug = 'la-materialista';
UPDATE editorial_documents SET revision = revision + 1 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'la-materialista') AND locale = 'es' AND document_type = 'artist_biography';

COMMIT;
