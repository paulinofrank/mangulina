create table if not exists public.artist_media (
  id uuid primary key default gen_random_uuid(),
  artist_id uuid not null references public.artists(id) on delete cascade,
  media_type text not null default 'interview',
  title text not null,
  url text not null,
  platform text not null default 'other',
  external_id text,
  thumbnail_url text,
  published_date date,
  is_official boolean not null default false,
  is_featured boolean not null default false,
  display_order integer not null default 0,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists artist_media_artist_id_idx
  on public.artist_media(artist_id);

create index if not exists artist_media_artist_display_idx
  on public.artist_media(artist_id, display_order, created_at);

create unique index if not exists artist_media_artist_url_idx
  on public.artist_media(artist_id, url);

insert into public.artist_media (
  artist_id,
  media_type,
  title,
  url,
  platform,
  external_id,
  is_featured,
  display_order,
  notes
)
select
  artists.id,
  seed.media_type,
  seed.title,
  seed.url,
  seed.platform,
  seed.external_id,
  seed.is_featured,
  seed.display_order,
  seed.notes
from public.artists
cross join (
  values
    (
      'interview',
      'Entrevista a Luis Vargas "El Rey Supremo", Artista Musical | Extremo a Extremo',
      'https://www.youtube.com/watch?v=FM9Zc2fElXE',
      'youtube',
      'FM9Zc2fElXE',
      true,
      1,
      'Extremo a Extremo Telemicro.'
    ),
    (
      'interview',
      '1 PARTE - EL INTERROGATORIO CON JANEIRO MATOS, ENTREVISTA A LUIS VARGAS',
      'https://www.youtube.com/watch?v=ji4EgXS3MD8&list=PLozguVeXjQtyExcBVuxuODB32FmtfF-pm&index=2',
      'youtube',
      'ji4EgXS3MD8',
      true,
      2,
      'INNOVATION MEDIA NEW YORK.'
    ),
    (
      'interview',
      'BACHATEROS: LUIS VARGAS revela la verdad En MEGA',
      'https://www.youtube.com/watch?v=ibjhu92ItNA',
      'youtube',
      'ibjhu92ItNA',
      true,
      3,
      'Mega 97.9 NYC.'
    )
) as seed(media_type, title, url, platform, external_id, is_featured, display_order, notes)
where artists.slug = 'luis-vargas'
on conflict (artist_id, url) do nothing;
