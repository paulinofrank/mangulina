BEGIN;

-- Reverts 20260908002300_rewrite_martha_heredia_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Martha Heredia',
       sort_name = 'Heredia, Martha',
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue-calle',
       date_of_birth = '1991-02-01',
       birth_year = 1991,
       date_of_death = NULL,
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Martha',
       middle_name = 'Roseli',
       last_name = 'Heredia',
       second_last_name = 'Rivas',
       stage_name = 'Martha Heredia',
       aliases = ARRAY['Martha Heredia', 'La Baby']::text[],
       occupations = '["songwriter"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['urban-reggaeton']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@MarthaHerediaTv',
       facebook = '100091398427409',
       instagram = 'marthaheredia',
       disambiguation = NULL,
       bio_en = 'Martha Heredia became a household name across the Dominican Republic and much of Latin America after winning the eighth season of La Academia, the popular Mexican television singing competition, in 2009 — a victory that made her the first Dominican artist to claim that title. Born in 1991 in Santiago de los Caballeros, she showed exceptional vocal ability from a very young age, and her performances on La Academia revealed a voice of striking maturity and emotional intelligence for someone still in her teens.

Her triumph on the show generated enormous excitement in the Dominican Republic, where she was celebrated as a national talent on the world stage. Following her win, she released a debut album that earned her a Latin Grammy Award for Best New Artist in 2010, an achievement that confirmed her as one of the most promising young voices in Latin pop.

Her music draws on Latin pop, R&B, and urban influences, and her recordings have demonstrated a range that suggests an artist with ambitions well beyond the competition-show origins that first brought her to fame. Though the pressures of early stardom and the challenge of sustaining momentum in a competitive industry have shaped her subsequent career, Martha Heredia remains one of the most celebrated young talents to emerge from the Dominican Republic in the twenty-first century.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'martha-heredia';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martha-heredia')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'martha-heredia')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Martha Heredia became a household name across the Dominican Republic and much of Latin America after winning the eighth season of La Academia, the popular Mexican television singing competition, in 2009 — a victory that made her the first Dominican artist to claim that title. Born in 1991 in Santiago de los Caballeros, she showed exceptional vocal ability from a very young age, and her performances on La Academia revealed a voice of striking maturity and emotional intelligence for someone still in her teens.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her triumph on the show generated enormous excitement in the Dominican Republic, where she was celebrated as a national talent on the world stage. Following her win, she released a debut album that earned her a Latin Grammy Award for Best New Artist in 2010, an achievement that confirmed her as one of the most promising young voices in Latin pop.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her music draws on Latin pop, R&B, and urban influences, and her recordings have demonstrated a range that suggests an artist with ambitions well beyond the competition-show origins that first brought her to fame. Though the pressures of early stardom and the challenge of sustaining momentum in a competitive industry have shaped her subsequent career, Martha Heredia remains one of the most celebrated young talents to emerge from the Dominican Republic in the twenty-first century.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'martha-heredia'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
