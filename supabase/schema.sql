create table profiles (
  id uuid references auth.users on delete cascade primary key,
  username text unique not null,
  avatar_url text,
  created_at timestamp with time zone default now() not null
);

create table decks (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references profiles(id) on delete cascade not null,
  title text not null,
  description text,
  subject text not null,
  card_count integer default 0 not null,
  upvotes integer default 0 not null,
  downvotes integer default 0 not null,
  is_public boolean default true not null,
  created_at timestamp with time zone default now() not null,
  updated_at timestamp with time zone default now() not null
);

create table cards (
  id uuid default gen_random_uuid() primary key,
  deck_id uuid references decks(id) on delete cascade not null,
  front text not null,
  back text not null,
  position integer not null,
  created_at timestamp with time zone default now() not null
);

create table study_guides (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references profiles(id) on delete cascade not null,
  title text not null,
  subject text not null,
  content text not null,
  upvotes integer default 0 not null,
  downvotes integer default 0 not null,
  is_public boolean default true not null,
  created_at timestamp with time zone default now() not null,
  updated_at timestamp with time zone default now() not null
);

create table favorites (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references profiles(id) on delete cascade not null,
  deck_id uuid references decks(id) on delete cascade,
  guide_id uuid references study_guides(id) on delete cascade,
  created_at timestamp with time zone default now() not null,
  unique(user_id, deck_id),
  unique(user_id, guide_id)
);

create table votes (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references profiles(id) on delete cascade not null,
  deck_id uuid references decks(id) on delete cascade,
  guide_id uuid references study_guides(id) on delete cascade,
  value smallint not null check (value in (-1, 1)),
  created_at timestamp with time zone default now() not null,
  unique(user_id, deck_id),
  unique(user_id, guide_id)
);

create table study_progress (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references profiles(id) on delete cascade not null,
  deck_id uuid references decks(id) on delete cascade not null,
  card_id uuid references cards(id) on delete cascade not null,
  score integer default 0 not null,
  streak integer default 0 not null,
  next_review timestamp with time zone,
  updated_at timestamp with time zone default now() not null,
  unique(user_id, card_id)
);

alter table profiles enable row level security;
alter table decks enable row level security;
alter table cards enable row level security;
alter table study_guides enable row level security;
alter table favorites enable row level security;
alter table votes enable row level security;
create table recently_studied (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references profiles(id) on delete cascade not null,
  deck_id uuid references decks(id) on delete cascade not null,
  last_score integer,
  total_cards integer,
  studied_at timestamp with time zone default now() not null,
  unique(user_id, deck_id)
);

alter table profiles enable row level security;
alter table study_progress enable row level security;
alter table recently_studied enable row level security;

create policy "Public profiles are viewable by everyone" on profiles for select using (true);
create policy "Users can update own profile" on profiles for update using (auth.uid() = id);
create policy "Users can insert own profile" on profiles for insert with check (auth.uid() = id);

create policy "Public decks are viewable by everyone" on decks for select using (is_public = true or user_id = auth.uid());
create policy "Users can insert own decks" on decks for insert with check (auth.uid() = user_id);
create policy "Users can update own decks" on decks for update using (auth.uid() = user_id);
create policy "Users can delete own decks" on decks for delete using (auth.uid() = user_id);

create policy "Cards of public decks are viewable" on cards for select using (
  exists (select 1 from decks where decks.id = cards.deck_id and (decks.is_public = true or decks.user_id = auth.uid()))
);
create policy "Users can manage cards in own decks" on cards for all using (
  exists (select 1 from decks where decks.id = cards.deck_id and decks.user_id = auth.uid())
);

create policy "Public guides are viewable by everyone" on study_guides for select using (is_public = true or user_id = auth.uid());
create policy "Users can insert own guides" on study_guides for insert with check (auth.uid() = user_id);
create policy "Users can update own guides" on study_guides for update using (auth.uid() = user_id);
create policy "Users can delete own guides" on study_guides for delete using (auth.uid() = user_id);

create policy "Users can view own favorites" on favorites for select using (auth.uid() = user_id);
create policy "Users can manage own favorites" on favorites for all using (auth.uid() = user_id);

create policy "Users can view votes" on votes for select using (true);
create policy "Users can manage own votes" on votes for all using (auth.uid() = user_id);

create policy "Users can view own progress" on study_progress for select using (auth.uid() = user_id);
create policy "Users can manage own progress" on study_progress for all using (auth.uid() = user_id);

create policy "Users can view own recently studied" on recently_studied for select using (auth.uid() = user_id);
create policy "Users can manage own recently studied" on recently_studied for all using (auth.uid() = user_id);

create index idx_decks_subject on decks(subject);
create index idx_decks_user_id on decks(user_id);
create index idx_cards_deck_id on cards(deck_id);
create index idx_study_guides_subject on study_guides(subject);
create index idx_study_progress_next_review on study_progress(next_review);
