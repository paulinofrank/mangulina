BEGIN;

-- Canonical roles needed by the original Colegiala recording and its Karen LP.
INSERT INTO public.credit_roles (id,code,display_name_en,display_name_es,description,role_family,normal_scope,display_order)
VALUES
 ('822a4626-647e-4c90-9302-d4e6aa5d45d3','backing_vocalist','Backing vocalist','Corista','Performs backing vocals on a Recording.','performance','recording',75),
 ('8c96f182-2b6c-4908-8e8b-331927dbb427','graphic_designer','Graphic designer','Diseñador gráfico','Creates graphic design for a Release.','production','release',160),
 ('e090e43c-45fb-4c56-a14d-22d1d8c7c919','art_director','Art director','Director de arte','Directs the visual presentation of a Release.','direction','release',161)
ON CONFLICT (code) DO NOTHING;

INSERT INTO public.credit_role_scopes(role_id,scope)
SELECT id,normal_scope FROM public.credit_roles WHERE code IN ('backing_vocalist','graphic_designer','art_director')
ON CONFLICT DO NOTHING;
INSERT INTO public.credit_role_scopes(role_id,scope)
SELECT id,'release' FROM public.credit_roles WHERE code='recording_engineer'
ON CONFLICT DO NOTHING;

-- Release Credits are separate from Recording Credits: these people are
-- credited across the Karen LP, not asserted independently for every track.
CREATE TABLE IF NOT EXISTS public.release_credits (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 release_id uuid NOT NULL REFERENCES public.releases(id) ON DELETE RESTRICT,
 artist_id uuid REFERENCES public.artists(id) ON DELETE RESTRICT,
 external_contributor_id uuid REFERENCES public.external_contributors(id) ON DELETE RESTRICT,
 role_id uuid NOT NULL REFERENCES public.credit_roles(id) ON DELETE RESTRICT,
 credited_as text,
 display_order integer NOT NULL DEFAULT 0 CHECK(display_order>=0),
 verification_status text NOT NULL DEFAULT 'unverified' CHECK(verification_status IN ('unverified','verified','disputed','superseded')),
 source_name text,
 source_reference text,
 metadata jsonb NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(metadata)='object'),
 created_at timestamptz NOT NULL DEFAULT now(),
 updated_at timestamptz NOT NULL DEFAULT now(),
 CONSTRAINT release_credits_exactly_one_contributor CHECK(num_nonnulls(artist_id,external_contributor_id)=1)
);
CREATE UNIQUE INDEX IF NOT EXISTS release_credits_artist_role_uidx ON public.release_credits(release_id,artist_id,role_id) WHERE artist_id IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS release_credits_external_role_uidx ON public.release_credits(release_id,external_contributor_id,role_id) WHERE external_contributor_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS release_credits_release_idx ON public.release_credits(release_id,display_order);
ALTER TABLE public.release_credits ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON public.release_credits FROM PUBLIC,anon,authenticated;
GRANT ALL ON public.release_credits TO service_role;

INSERT INTO public.external_contributors(id,preferred_name,sort_name,entity_type,country_code,occupations,status,metadata)
VALUES
 ('f258755d-8ac2-4def-9668-3a92b0e73f10','Ramón Orlando Valoy','Valoy, Ramón Orlando','person','DO',ARRAY['vocalist'],'verified',jsonb_build_object('source','User-supplied original-release credit; corroborated album identity research')),
 ('643b5d20-889e-4572-8b33-2340c444e11e','Bienvenido Rodríguez','Rodríguez, Bienvenido','person','DO',ARRAY['executive producer'],'verified',jsonb_build_object('source','Original Karen LP credit')),
 ('c9764756-26f8-4ee1-9594-0720268ce44b','July Ruiz','Ruiz, July','person','DO',ARRAY['recording engineer'],'verified',jsonb_build_object('source','Original Karen LP credit')),
 ('a6793e60-d826-4432-8cf0-7e52234d31c2','Salvador Morales','Morales, Salvador','person','DO',ARRAY['recording engineer'],'verified',jsonb_build_object('source','Original Karen LP credit')),
 ('a127be5f-d6c1-4166-9e95-1e51b6c4711d','Susie Gadea','Gadea, Susie','person','DO',ARRAY['graphic designer','art director'],'verified',jsonb_build_object('source','Original Karen LP credit'))
ON CONFLICT (id) DO NOTHING;

-- User supplied these two track-level backing-vocal credits from the original
-- release. They remain distinct rows so both names render under the same role.
INSERT INTO public.recording_credits(id,recording_id,artist_id,external_contributor_id,role,role_id,credited_as,display_order,position,metadata)
VALUES
 ('34fc11e6-8f08-4644-bc09-4a2b02e03a7f','a313df5d-479b-4f7e-b980-87d5d6abfedd','6c3e0d74-23b7-4d80-969f-9d5319ee5127',NULL,'lead_performer',(SELECT id FROM public.credit_roles WHERE code='lead_performer'),'Alex Bueno',0,NULL,jsonb_build_object('evidence_basis','Qobuz main-artist credit and original release billing','observed_at','2026-09-20')),
 ('8a5d94d1-00d3-4163-b689-cac0a158a7ae','a313df5d-479b-4f7e-b980-87d5d6abfedd','6c3e0d74-23b7-4d80-969f-9d5319ee5127',NULL,'backing_vocalist',(SELECT id FROM public.credit_roles WHERE code='backing_vocalist'),'Alex Bueno',10,NULL,jsonb_build_object('evidence_basis','user-supplied original-release credit','observed_at','2026-09-20')),
 ('e9d4c195-7f4d-453c-8810-adae82ee38c4','a313df5d-479b-4f7e-b980-87d5d6abfedd',NULL,'f258755d-8ac2-4def-9668-3a92b0e73f10','backing_vocalist',(SELECT id FROM public.credit_roles WHERE code='backing_vocalist'),'Ramón Orlando Valoy',11,NULL,jsonb_build_object('evidence_basis','user-supplied original-release credit','observed_at','2026-09-20'))
ON CONFLICT DO NOTHING;

-- KLP-89 is the documented 1985 Dominican Karen issue of the original album.
UPDATE public.releases
SET label='Karen Records', catalog_number='KLP-89',
    metadata=coalesce(metadata,'{}'::jsonb)||jsonb_build_object(
      'recorded_at','EMCA Studio',
      'phonographic_copyright','Karen Records',
      'phonographic_copyright_catalog_number','KLP-89',
      'credit_source','https://alex-buenouv.bandcamp.com/album/alex-orquesta-liberaci-n'
    ), updated_at=now()
WHERE id='b8d7126a-6277-4b5c-939e-8398bc51460f';

INSERT INTO public.release_credits(id,release_id,external_contributor_id,role_id,credited_as,display_order,verification_status,source_name,source_reference)
VALUES
 ('2f329810-e9e5-406d-af87-816c77ab590e','b8d7126a-6277-4b5c-939e-8398bc51460f','643b5d20-889e-4572-8b33-2340c444e11e',(SELECT id FROM public.credit_roles WHERE code='executive_producer'),'Bienvenido Rodríguez',0,'verified','Original release credit transcription','https://alex-buenouv.bandcamp.com/album/alex-orquesta-liberaci-n'),
 ('3d4b3bfb-c237-453f-a40a-0e15aaf6ef28','b8d7126a-6277-4b5c-939e-8398bc51460f','c9764756-26f8-4ee1-9594-0720268ce44b',(SELECT id FROM public.credit_roles WHERE code='recording_engineer'),'July Ruiz',1,'verified','Original release credit transcription','https://alex-buenouv.bandcamp.com/album/alex-orquesta-liberaci-n'),
 ('2de0d4e7-f793-46de-91d6-fe70307deead','b8d7126a-6277-4b5c-939e-8398bc51460f','a6793e60-d826-4432-8cf0-7e52234d31c2',(SELECT id FROM public.credit_roles WHERE code='recording_engineer'),'Salvador Morales',2,'verified','Original release credit transcription','https://alex-buenouv.bandcamp.com/album/alex-orquesta-liberaci-n'),
 ('10cebadb-0093-4a6b-820d-ca22599eabe9','b8d7126a-6277-4b5c-939e-8398bc51460f','a127be5f-d6c1-4166-9e95-1e51b6c4711d',(SELECT id FROM public.credit_roles WHERE code='graphic_designer'),'Susie Gadea',3,'verified','Original release credit transcription','https://alex-buenouv.bandcamp.com/album/alex-orquesta-liberaci-n'),
 ('3cb759f7-ac73-46c6-b659-5de70e81d98e','b8d7126a-6277-4b5c-939e-8398bc51460f','a127be5f-d6c1-4166-9e95-1e51b6c4711d',(SELECT id FROM public.credit_roles WHERE code='art_director'),'Susie Gadea',4,'verified','User-supplied original-release credit','user-provided liner-note transcription')
ON CONFLICT DO NOTHING;

COMMIT;
