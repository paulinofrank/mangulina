BEGIN;
DO $$
DECLARE
  item record;
  instrument_uuid uuid;
  credit_uuid uuid;
  inserted_count integer;
BEGIN
  LOCK TABLE public.instruments IN SHARE ROW EXCLUSIVE MODE;
  PERFORM 1 FROM public.recording_credits WHERE id IN (
    'b3fda856-d1a3-4403-8522-7d99419e2041','b9315a6a-aa4d-4374-ad1b-30042a38fac7',
    'e4fc33d6-9122-48fc-b42c-cf407e990328','dda7fcd6-a49c-48d8-bab2-bda679ee469e') FOR UPDATE;
  IF (SELECT count(*) FROM public.recording_credits WHERE recording_id='bb2ecc6a-e88a-4fd2-aa72-205119032c0a'
    AND ((id='b3fda856-d1a3-4403-8522-7d99419e2041' AND artist_id='e2eeafa3-ba85-484e-93aa-dc6220918c57' AND role='instrumentalist' AND metadata->>'instrument'='saxophone')
      OR (id='b9315a6a-aa4d-4374-ad1b-30042a38fac7' AND artist_id='a94c360e-c512-42c6-9fcf-e271667f71d8' AND role='instrumentalist' AND metadata->>'instrument'='congas')
      OR (id='e4fc33d6-9122-48fc-b42c-cf407e990328' AND artist_id='adf84825-ee0c-4a37-86ae-24c2d20b3a23' AND role='instrumentalist' AND metadata->>'instrument'='guira')
      OR (id='dda7fcd6-a49c-48d8-bab2-bda679ee469e' AND artist_id='d1990163-8c44-4fcf-9a50-f85d0701b239' AND role='pianist' AND metadata->>'instrument'='piano'))) <> 4 THEN
    RAISE EXCEPTION 'Credit manifest changed; abort';
  END IF;
  IF EXISTS (SELECT 1 FROM public.recording_credit_instruments WHERE recording_credit_id IN (
    'b3fda856-d1a3-4403-8522-7d99419e2041','b9315a6a-aa4d-4374-ad1b-30042a38fac7',
    'e4fc33d6-9122-48fc-b42c-cf407e990328','dda7fcd6-a49c-48d8-bab2-bda679ee469e')) THEN
    RAISE EXCEPTION 'Instrument links changed; abort';
  END IF;
  IF EXISTS (SELECT 1 FROM public.instruments WHERE code IN ('saxophone','congas','guira')) THEN
    RAISE EXCEPTION 'Instrument inventory changed; abort';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM public.instruments WHERE id='0301bddf-5017-4ccf-9d4b-acce9ae6f937' AND code='piano' AND status='active') THEN
    RAISE EXCEPTION 'Piano identity changed; abort';
  END IF;
  FOR item IN SELECT * FROM (VALUES ('saxophone','Saxophone','Saxofón'),('congas','Congas','Congas'),('guira','Güira','Güira')) AS v(code,en,es) LOOP
    INSERT INTO public.instruments(code,display_name_en,display_name_es)
      VALUES(item.code,item.en,item.es) RETURNING id INTO instrument_uuid;
    INSERT INTO public.editorial_audit_events(event_type,actor_type,table_name,row_id,before_state,after_state,reason)
      SELECT 'instrument.created','service_process','instruments',i.id,NULL,to_jsonb(i),
        'Editor explicitly approved three instruments and four existing Cómo quisiera credit links in Codex chat, 2026-10-31; mapping preserves recording credit metadata.'
      FROM public.instruments i WHERE i.id=instrument_uuid;
  END LOOP;
  FOR item IN SELECT * FROM (VALUES
    ('b3fda856-d1a3-4403-8522-7d99419e2041','saxophone'),
    ('b9315a6a-aa4d-4374-ad1b-30042a38fac7','congas'),
    ('e4fc33d6-9122-48fc-b42c-cf407e990328','guira'),
    ('dda7fcd6-a49c-48d8-bab2-bda679ee469e','piano')) AS v(credit_id,code) LOOP
    credit_uuid:=item.credit_id::uuid;
    SELECT id INTO STRICT instrument_uuid FROM public.instruments WHERE code=item.code AND status='active';
    INSERT INTO public.recording_credit_instruments(recording_credit_id,instrument_id,sequence)
      VALUES(credit_uuid,instrument_uuid,0);
    INSERT INTO public.editorial_audit_events(event_type,actor_type,table_name,row_id,before_state,after_state,reason)
      VALUES('recording_credit.instrument_linked','service_process','recording_credit_instruments',credit_uuid,
        jsonb_build_object('instruments','[]'::jsonb),
        jsonb_build_object('recording_credit_id',credit_uuid,'instrument_id',instrument_uuid,'instrument_code',item.code,'sequence',0),
        'Editor-approved mapping from existing metadata.instrument for Cómo quisiera (recording bb2ecc6a-e88a-4fd2-aa72-205119032c0a), 2026-10-31; canonical credit and provenance preserved.');
  END LOOP;
END $$;
COMMIT;
SELECT jsonb_build_object('instruments',(SELECT jsonb_agg(to_jsonb(i)) FROM public.instruments i WHERE code IN ('saxophone','congas','guira','piano')),
 'links',(SELECT jsonb_agg(jsonb_build_object('credit_id',c.id,'role',c.role,'metadata',c.metadata,'instrument_id',i.id,'code',i.code,'en',i.display_name_en,'es',i.display_name_es)) FROM public.recording_credits c JOIN public.recording_credit_instruments ci ON ci.recording_credit_id=c.id JOIN public.instruments i ON i.id=ci.instrument_id WHERE c.recording_id='bb2ecc6a-e88a-4fd2-aa72-205119032c0a'));
