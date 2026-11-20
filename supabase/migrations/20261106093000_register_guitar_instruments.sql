BEGIN;

-- Register standard guitar instruments in the catalog
INSERT INTO public.instruments (code, display_name_en, display_name_es, status)
VALUES 
  ('electric_guitar', 'Electric Guitar', 'Guitarra eléctrica', 'active'),
  ('acoustic_guitar', 'Acoustic Guitar', 'Guitarra acústica', 'active')
ON CONFLICT (code) DO UPDATE 
  SET display_name_en = EXCLUDED.display_name_en,
      display_name_es = EXCLUDED.display_name_es,
      status = 'active';

COMMIT;
