-- Run this in the same Supabase SQL Editor you used before (New query -> paste -> Run).
-- This creates a storage bucket for day photos and opens it up the same way
-- trip_state is open: anyone with your site link can upload/view, no login required.

insert into storage.buckets (id, name, public)
values ('trip-photos', 'trip-photos', true)
on conflict (id) do nothing;

create policy "public can upload trip photos"
  on storage.objects for insert
  to public
  with check (bucket_id = 'trip-photos');

create policy "public can view trip photos"
  on storage.objects for select
  to public
  using (bucket_id = 'trip-photos');

create policy "public can update trip photos"
  on storage.objects for update
  to public
  using (bucket_id = 'trip-photos');

create policy "public can delete trip photos"
  on storage.objects for delete
  to public
  using (bucket_id = 'trip-photos');
