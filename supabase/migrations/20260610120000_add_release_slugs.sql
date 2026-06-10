create extension if not exists unaccent;

alter table public.releases
  add column if not exists slug text;

with release_sources as (
  select
    r.id,
    lower(
      trim(
        both '-' from regexp_replace(
          regexp_replace(
            unaccent(coalesce(r.title, 'release') || ' ' || coalesce(a.name, '')),
            '[^a-zA-Z0-9]+',
            '-',
            'g'
          ),
          '-+',
          '-',
          'g'
        )
      )
    ) as base_slug
  from public.releases r
  left join public.artists a on a.id = r.release_artist_id
  where r.slug is null or r.slug = ''
),
numbered as (
  select
    id,
    coalesce(nullif(base_slug, ''), 'release') as base_slug,
    row_number() over (
      partition by coalesce(nullif(base_slug, ''), 'release')
      order by id
    ) as duplicate_index
  from release_sources
)
update public.releases r
set slug = case
  when n.duplicate_index = 1 then n.base_slug
  else n.base_slug || '-' || n.duplicate_index::text
end
from numbered n
where r.id = n.id;

create unique index if not exists releases_slug_key
  on public.releases (slug)
  where slug is not null;
