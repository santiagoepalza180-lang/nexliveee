create table if not exists public.profiles (
 id uuid primary key references auth.users(id) on delete cascade,
 username text unique,
 display_name text,
 avatar_url text,
 created_at timestamptz not null default now()
);
create table if not exists public.follows (
 follower_id uuid references auth.users(id) on delete cascade,
 followed_id uuid references auth.users(id) on delete cascade,
 created_at timestamptz not null default now(),
 primary key (follower_id, followed_id),
 check (follower_id <> followed_id)
);
create table if not exists public.streams (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 title text not null default 'En directo',
 category text,
 is_live boolean not null default false,
 created_at timestamptz not null default now()
);
alter table public.profiles enable row level security;
alter table public.follows enable row level security;
alter table public.streams enable row level security;
create policy "Profiles are viewable by everyone" on public.profiles for select using (true);
create policy "Users update own profile" on public.profiles for update using (auth.uid() = id);
create policy "Users insert own profile" on public.profiles for insert with check (auth.uid() = id);
create policy "Follows viewable by everyone" on public.follows for select using (true);
create policy "Users follow as themselves" on public.follows for insert with check (auth.uid() = follower_id);
create policy "Users unfollow as themselves" on public.follows for delete using (auth.uid() = follower_id);
create policy "Streams viewable by everyone" on public.streams for select using (true);
create policy "Users manage own streams" on public.streams for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create or replace function public.handle_new_user() returns trigger language plpgsql security definer set search_path = public as $$
begin
 insert into public.profiles (id, display_name) values (new.id, coalesce(new.raw_user_meta_data->>'display_name', split_part(new.email,'@',1)));
 return new;
end; $$;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users for each row execute procedure public.handle_new_user();