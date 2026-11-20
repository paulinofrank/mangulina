"""Build (do not execute) the editor-approved atomic biography save."""
from pathlib import Path
import json,hashlib
r=Path(__file__).parent
p=r/'440-biography-change-manifest-2026-11-04.json'
assert hashlib.sha256(p.read_bytes()).hexdigest()=='f216a8e1f435cad7e6e3192c8d9ec6f951214c8e79832da96987b77f851f748e'
m=json.loads(p.read_text(encoding='utf-8'))
assert len(m['changes'])==22
payload=[{k:c[k] for k in ['owner_id','document_id','locale','expected_revision','before','after','status_before','status_after','mirror_before','mirror_after']} for c in m['changes']]
data=json.dumps(payload,ensure_ascii=False,separators=(',',':'))
assert '$approved440$' not in data
sql="""BEGIN;
DO $save440$
DECLARE
  batch jsonb := $approved440$PAYLOAD$approved440$::jsonb;
  item jsonb;
  existing public.editorial_documents%ROWTYPE;
  prior_artists jsonb;
  after_artists jsonb;
  saved record;
BEGIN
  PERFORM 1 FROM public.artists a WHERE a.id IN (SELECT (x->>'owner_id')::uuid FROM jsonb_array_elements(batch) x) ORDER BY a.id FOR UPDATE;
  PERFORM 1 FROM public.editorial_documents d WHERE d.id IN (SELECT (x->>'document_id')::uuid FROM jsonb_array_elements(batch) x) ORDER BY d.id FOR UPDATE;
  SELECT jsonb_object_agg(a.id::text,to_jsonb(a)-'bio_en'-'bio_es'-'updated_at') INTO prior_artists FROM public.artists a WHERE a.id IN (SELECT (x->>'owner_id')::uuid FROM jsonb_array_elements(batch) x);
  FOR item IN SELECT value FROM jsonb_array_elements(batch) LOOP
    SELECT * INTO STRICT existing FROM public.editorial_documents d WHERE d.id=(item->>'document_id')::uuid;
    IF existing.owner_artist_id IS DISTINCT FROM (item->>'owner_id')::uuid OR existing.document_type<>'artist_biography' OR existing.locale<>item->>'locale' OR existing.revision<>(item->>'expected_revision')::integer OR existing.document IS DISTINCT FROM item->'before' OR existing.status<>item->>'status_before' THEN
      RAISE EXCEPTION 'Approved biography precondition changed: % %',item->>'document_id',item->>'locale';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM public.artists a WHERE a.id=existing.owner_artist_id AND a.status='published' AND (CASE existing.locale WHEN 'en' THEN a.bio_en ELSE a.bio_es END) IS NOT DISTINCT FROM item->>'mirror_before') THEN
      RAISE EXCEPTION 'Artist status/mirror precondition changed: %',existing.owner_artist_id;
    END IF;
    IF EXISTS (SELECT 1 FROM public.editorial_document_v1_references(item->'after') n LEFT JOIN public.artists a ON a.id=(n.inline_node->'attrs'->>'artistId')::uuid WHERE a.id IS NULL OR a.status<>'published' OR a.name IS DISTINCT FROM n.inline_node->'attrs'->>'displayText') THEN
      RAISE EXCEPTION 'Reference target precondition changed: %',existing.id;
    END IF;
    SELECT * INTO STRICT saved FROM public.upsert_editorial_document('artist_biography',existing.owner_artist_id,existing.locale,1,item->>'status_after',item->'after',existing.revision);
    IF saved.id<>existing.id OR saved.revision<>existing.revision+1 THEN RAISE EXCEPTION 'Unexpected save result'; END IF;
    UPDATE public.artists SET bio_en=CASE WHEN existing.locale='en' THEN item->>'mirror_after' ELSE bio_en END,bio_es=CASE WHEN existing.locale='es' THEN item->>'mirror_after' ELSE bio_es END WHERE artists.id=existing.owner_artist_id;
    IF NOT EXISTS (SELECT 1 FROM public.editorial_documents d WHERE d.id=existing.id AND d.document=item->'after' AND d.status=item->>'status_after' AND d.revision=existing.revision+1) THEN RAISE EXCEPTION 'Saved document mismatch'; END IF;
    IF (SELECT count(*) FROM public.editorial_entity_references z WHERE z.editorial_document_id=existing.id)<>(SELECT count(*) FROM public.editorial_document_v1_references(item->'after')) OR EXISTS (SELECT 1 FROM public.editorial_document_v1_references(item->'after') n LEFT JOIN public.editorial_entity_references z ON z.editorial_document_id=existing.id AND z.occurrence_id=(n.inline_node->'attrs'->>'occurrenceId')::uuid AND z.target_artist_id=(n.inline_node->'attrs'->>'artistId')::uuid AND z.entity_type='artist' WHERE z.id IS NULL) THEN RAISE EXCEPTION 'Saved reference mismatch'; END IF;
  END LOOP;
  SELECT jsonb_object_agg(a.id::text,to_jsonb(a)-'bio_en'-'bio_es'-'updated_at') INTO after_artists FROM public.artists a WHERE a.id IN (SELECT (x->>'owner_id')::uuid FROM jsonb_array_elements(batch) x);
  IF after_artists IS DISTINCT FROM prior_artists THEN RAISE EXCEPTION 'Unexpected non-biography artist change'; END IF;
END $save440$;
COMMIT;
""".replace('PAYLOAD',data)
(r/'440-approved-save-2026-11-04.sql').write_text(sql,encoding='utf-8')
print(json.dumps({'state':'prepared only','documents':22,'sql_characters':len(sql)}))
