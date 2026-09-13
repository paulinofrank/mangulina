BEGIN;

-- Reverts 20260908006900_rewrite_joe_veras_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Joe Veras',
       sort_name = 'Veras, Joe',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1964-05-01',
       birth_year = 1964,
       date_of_death = NULL,
       birth_place = 'Cotuí',
       province = 'Sánchez Ramírez',
       first_name = 'Joe',
       middle_name = NULL,
       last_name = 'Veras',
       second_last_name = NULL,
       stage_name = 'Joe Veras',
       aliases = ARRAY['El Hombre de Tu Vida']::text[],
       occupations = '["musician","composer","producer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@JoeVeras',
       facebook = 'JoeVerasMusic',
       instagram = 'joeverasoficial',
       disambiguation = NULL,
       bio_en = 'Joe Veras is one of the most distinctive and enduring voices in Dominican bachata and tropical music. Born in 1964 in Cotuí, the capital of Sánchez Ramírez province in the heart of the country, he developed a passion for music early in life and eventually made his way into the professional music world as bachata was undergoing its slow but steady transformation from a marginalized folk form into a nationally embraced popular genre.

Veras built his reputation on the strength of an expressive, soulful voice capable of conveying deep tenderness and romantic longing. His interpretive style drew from the classic bachata tradition while incorporating elements of tropical and bolero that gave his recordings a broad appeal. Over the course of his career he released numerous albums and singles that earned him a loyal following both in the Dominican Republic and among Dominican communities abroad.

He is known for collaborating with a range of musicians and for maintaining a prolific output across decades, adapting to changing tastes without abandoning the emotional core that defines bachata at its best. Songs from his catalog have been celebrated at family gatherings, on radio stations, and in the diaspora communities of New York, Boston, and beyond, where Dominican music serves as a vital cultural connection to the homeland.

Veras represents the generation of bachata artists who helped normalize and popularize the genre before its global explosion in the early 2000s, and his recordings stand as important documents of Dominican popular music history.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'joe-veras';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joe-veras')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Joe Veras is one of the most distinctive and enduring voices in Dominican bachata and tropical music. Born in 1964 in Cotuí, the capital of Sánchez Ramírez province in the heart of the country, he developed a passion for music early in life and eventually made his way into the professional music world as bachata was undergoing its slow but steady transformation from a marginalized folk form into a nationally embraced popular genre.","type":"text"}]},{"type":"paragraph","content":[{"text":"Veras built his reputation on the strength of an expressive, soulful voice capable of conveying deep tenderness and romantic longing. His interpretive style drew from the classic bachata tradition while incorporating elements of tropical and bolero that gave his recordings a broad appeal. Over the course of his career he released numerous albums and singles that earned him a loyal following both in the Dominican Republic and among Dominican communities abroad.","type":"text"}]},{"type":"paragraph","content":[{"text":"He is known for collaborating with a range of musicians and for maintaining a prolific output across decades, adapting to changing tastes without abandoning the emotional core that defines bachata at its best. Songs from his catalog have been celebrated at family gatherings, on radio stations, and in the diaspora communities of New York, Boston, and beyond, where Dominican music serves as a vital cultural connection to the homeland.","type":"text"}]},{"type":"paragraph","content":[{"text":"Veras represents the generation of bachata artists who helped normalize and popularize the genre before its global explosion in the early 2000s, and his recordings stand as important documents of Dominican popular music history.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'joe-veras'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
