-- شغّل الملف ده كله مرة واحدة في Supabase > SQL Editor
create table if not exists projects (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  title_ar text,
  category text not null default 'b',
  year text,
  description text,
  image_url text not null,
  image_path text,
  created_at timestamptz default now()
);
alter table projects enable row level security;
create policy "public read" on projects for select using (true);
create policy "owner write" on projects for all to authenticated using (true) with check (true);

insert into storage.buckets (id, name, public) values ('works','works',true) on conflict do nothing;
create policy "public read works" on storage.objects for select using (bucket_id = 'works');
create policy "owner upload works" on storage.objects for insert to authenticated with check (bucket_id = 'works');
create policy "owner delete works" on storage.objects for delete to authenticated using (bucket_id = 'works');
