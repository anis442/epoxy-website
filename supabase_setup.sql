-- Run this entire script in Supabase Dashboard > SQL Editor > New query.
create extension if not exists pgcrypto;
create table if not exists public.designs (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  category text not null,
  price numeric(12,2) not null default 0 check (price >= 0),
  image_url text not null default '',
  created_at timestamptz not null default now()
);
create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);
alter table public.designs enable row level security;
alter table public.admin_users enable row level security;
drop policy if exists "Public can read designs" on public.designs;
create policy "Public can read designs" on public.designs for select to anon, authenticated using (true);
drop policy if exists "Admins can insert designs" on public.designs;
create policy "Admins can insert designs" on public.designs for insert to authenticated with check (exists(select 1 from public.admin_users a where a.user_id = auth.uid()));
drop policy if exists "Admins can update designs" on public.designs;
create policy "Admins can update designs" on public.designs for update to authenticated using (exists(select 1 from public.admin_users a where a.user_id = auth.uid())) with check (exists(select 1 from public.admin_users a where a.user_id = auth.uid()));
drop policy if exists "Admins can delete designs" on public.designs;
create policy "Admins can delete designs" on public.designs for delete to authenticated using (exists(select 1 from public.admin_users a where a.user_id = auth.uid()));
drop policy if exists "Admins can read admin list" on public.admin_users;
create policy "Admins can read own admin record" on public.admin_users for select to authenticated using (user_id = auth.uid());
-- Storage bucket for public design photos
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('epoxy-designs','epoxy-designs',true,8388608,array['image/jpeg','image/png','image/webp','image/gif'])
on conflict (id) do update set public=true,file_size_limit=8388608,allowed_mime_types=array['image/jpeg','image/png','image/webp','image/gif'];
drop policy if exists "Public can view epoxy photos" on storage.objects;
create policy "Public can view epoxy photos" on storage.objects for select to anon, authenticated using (bucket_id = 'epoxy-designs');
drop policy if exists "Admins can upload epoxy photos" on storage.objects;
create policy "Admins can upload epoxy photos" on storage.objects for insert to authenticated with check (bucket_id = 'epoxy-designs' and exists(select 1 from public.admin_users a where a.user_id = auth.uid()));
drop policy if exists "Admins can update epoxy photos" on storage.objects;
create policy "Admins can update epoxy photos" on storage.objects for update to authenticated using (bucket_id = 'epoxy-designs' and exists(select 1 from public.admin_users a where a.user_id = auth.uid())) with check (bucket_id = 'epoxy-designs' and exists(select 1 from public.admin_users a where a.user_id = auth.uid()));
drop policy if exists "Admins can delete epoxy photos" on storage.objects;
create policy "Admins can delete epoxy photos" on storage.objects for delete to authenticated using (bucket_id = 'epoxy-designs' and exists(select 1 from public.admin_users a where a.user_id = auth.uid()));
