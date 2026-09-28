-- Registro Zaccaria · schema Supabase
-- Incolla tutto nel Supabase SQL Editor ed esegui una sola volta.
-- Questo schema usa Supabase Auth e RLS: non usare policy pubbliche anon.

create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null default '',
  class_name text not null default '',
  school_year text not null default '2025-26',
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.subjects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  teacher text,
  color text not null default '#287c86',
  created_at timestamptz not null default now(),
  unique (user_id, name)
);

create table if not exists public.grades (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  subject_id uuid references public.subjects(id) on delete set null,
  subject_name text not null,
  value numeric(3,1) not null check (value >= 0 and value <= 10),
  assessment_type text not null default 'Verifica',
  teacher text,
  graded_on date not null default current_date,
  note text,
  created_at timestamptz not null default now()
);

create table if not exists public.lessons (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  subject_id uuid references public.subjects(id) on delete set null,
  subject_name text not null,
  teacher text,
  starts_at timestamptz not null,
  ends_at timestamptz,
  classroom text,
  lesson_note text,
  created_at timestamptz not null default now()
);

create table if not exists public.notes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  subject_id uuid references public.subjects(id) on delete set null,
  title text not null,
  description text,
  storage_path text,
  file_name text,
  mime_type text,
  file_size bigint check (file_size is null or file_size >= 0),
  created_at timestamptz not null default now()
);

create table if not exists public.announcements (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  body text not null,
  author text not null default 'Istituto Zaccaria',
  is_read boolean not null default false,
  published_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table if not exists public.reminders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  subject_name text,
  due_at timestamptz,
  details text,
  completed boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists public.attendance (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  lesson_date date not null,
  status text not null check (status in ('present','absent','late','excused')),
  minutes_late integer not null default 0 check (minutes_late >= 0),
  note text,
  created_at timestamptz not null default now(),
  unique (user_id, lesson_date)
);

create index if not exists grades_user_date_idx on public.grades(user_id, graded_on desc);
create index if not exists lessons_user_start_idx on public.lessons(user_id, starts_at);
create index if not exists notes_user_created_idx on public.notes(user_id, created_at desc);
create index if not exists announcements_user_published_idx on public.announcements(user_id, published_at desc);
create index if not exists reminders_user_due_idx on public.reminders(user_id, due_at);
create index if not exists attendance_user_date_idx on public.attendance(user_id, lesson_date desc);

create or replace function public.set_updated_at()
returns trigger language plpgsql security invoker set search_path = public
as $$ begin new.updated_at = now(); return new; end $$;

drop trigger if exists profiles_updated_at on public.profiles;
create trigger profiles_updated_at before update on public.profiles
for each row execute function public.set_updated_at();

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public
as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name', split_part(new.email, '@', 1)))
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users
for each row execute function public.handle_new_user();

alter table public.profiles enable row level security;
alter table public.subjects enable row level security;
alter table public.grades enable row level security;
alter table public.lessons enable row level security;
alter table public.notes enable row level security;
alter table public.announcements enable row level security;
alter table public.reminders enable row level security;
alter table public.attendance enable row level security;

do $$
declare t text;
begin
  foreach t in array array['profiles','subjects','grades','lessons','notes','announcements','reminders','attendance'] loop
    execute format('drop policy if exists "owner_select" on public.%I', t);
    execute format('drop policy if exists "owner_insert" on public.%I', t);
    execute format('drop policy if exists "owner_update" on public.%I', t);
    execute format('drop policy if exists "owner_delete" on public.%I', t);
    execute format('create policy "owner_select" on public.%I for select using (auth.uid() = user_id)', t);
    execute format('create policy "owner_insert" on public.%I for insert with check (auth.uid() = user_id)', t);
    execute format('create policy "owner_update" on public.%I for update using (auth.uid() = user_id) with check (auth.uid() = user_id)', t);
    execute format('create policy "owner_delete" on public.%I for delete using (auth.uid() = user_id)', t);
  end loop;
end $$;

-- profiles usa id invece di user_id
 drop policy if exists "profile_select" on public.profiles;
 drop policy if exists "profile_insert" on public.profiles;
 drop policy if exists "profile_update" on public.profiles;
 drop policy if exists "profile_delete" on public.profiles;
 create policy "profile_select" on public.profiles for select using (auth.uid() = id);
 create policy "profile_insert" on public.profiles for insert with check (auth.uid() = id);
 create policy "profile_update" on public.profiles for update using (auth.uid() = id) with check (auth.uid() = id);
 create policy "profile_delete" on public.profiles for delete using (auth.uid() = id);

insert into storage.buckets (id, name, public)
values ('appunti', 'appunti', false)
on conflict (id) do update set public = false;

drop policy if exists "notes_select" on storage.objects;
drop policy if exists "notes_insert" on storage.objects;
drop policy if exists "notes_update" on storage.objects;
drop policy if exists "notes_delete" on storage.objects;
create policy "notes_select" on storage.objects for select to authenticated
using (bucket_id = 'appunti' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "notes_insert" on storage.objects for insert to authenticated
with check (bucket_id = 'appunti' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "notes_update" on storage.objects for update to authenticated
using (bucket_id = 'appunti' and (storage.foldername(name))[1] = auth.uid()::text)
with check (bucket_id = 'appunti' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "notes_delete" on storage.objects for delete to authenticated
using (bucket_id = 'appunti' and (storage.foldername(name))[1] = auth.uid()::text);

-- Dati demo opzionali: eseguili dopo aver creato un account e sostituisci USER_UUID.
-- insert into public.subjects (user_id, name, teacher, color) values ('USER_UUID','Matematica','Prof.ssa Riva','#ef7651');
