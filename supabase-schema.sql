-- Colorado Boys Trip 2026 planner: shared state table
-- Run this once in your Supabase project's SQL editor (Supabase dashboard -> SQL Editor -> New query)

create table if not exists trip_state (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

-- Row Level Security: this is a casual shared trip planner, not a security-sensitive app.
-- We allow anyone with the public anon key (i.e. anyone with your site link) to read and write.
-- This is fine for a small friend group; it is NOT appropriate for sensitive data.
alter table trip_state enable row level security;

create policy "public can read trip_state"
  on trip_state for select
  using (true);

create policy "public can insert trip_state"
  on trip_state for insert
  with check (true);

create policy "public can update trip_state"
  on trip_state for update
  using (true);

-- Enable realtime updates on this table so edits sync live between everyone's browsers.
-- In the Supabase dashboard: Database -> Replication -> toggle "trip_state" on.
-- (Or run this, if your project supports it:)
alter publication supabase_realtime add table trip_state;
