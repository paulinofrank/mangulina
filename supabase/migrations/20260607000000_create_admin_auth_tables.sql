create table if not exists public.admin_members (
  id uuid primary key default gen_random_uuid(),
  user_id uuid unique references auth.users(id) on delete cascade,
  email text not null,
  role text not null default 'editor'
    check (role in ('owner', 'admin', 'editor')),
  status text not null default 'active'
    check (status in ('active', 'disabled')),
  invited_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create unique index if not exists admin_members_email_unique_idx
  on public.admin_members (lower(email));

create index if not exists admin_members_status_idx
  on public.admin_members(status);

create table if not exists public.admin_invites (
  id uuid primary key default gen_random_uuid(),
  email text not null,
  role text not null default 'editor'
    check (role in ('owner', 'admin', 'editor')),
  token_hash text not null unique,
  expires_at timestamptz not null default now() + interval '7 days',
  accepted_at timestamptz,
  created_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now()
);

create index if not exists admin_invites_email_idx
  on public.admin_invites(lower(email));

create index if not exists admin_invites_active_idx
  on public.admin_invites(accepted_at, expires_at);
