-- Run this in your Supabase SQL Editor: https://app.supabase.com/project/sqdxnaybsmfyxncdnqae/sql/new

create table if not exists test_results (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references profiles(id) on delete cascade not null,
  score integer not null,
  total integer not null,
  deck_ids text[] not null default '{}',
  created_at timestamp with time zone default now() not null
);

alter table test_results enable row level security;

create policy "Users can view own test results" on test_results for select using (auth.uid() = user_id);
create policy "Users can insert own test results" on test_results for insert with check (auth.uid() = user_id);
create policy "Users can delete own test results" on test_results for delete using (auth.uid() = user_id);
