-- Run this in Supabase SQL Editor to upgrade your existing database
-- This adds year_group support and the full UK curriculum

-- Add new columns to profiles
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS full_name text;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS age smallint;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS year_group smallint;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS preferred_subjects text[] DEFAULT '{}';

-- Add year_group to decks and study_guides
ALTER TABLE decks ADD COLUMN IF NOT EXISTS year_group smallint;
ALTER TABLE study_guides ADD COLUMN IF NOT EXISTS year_group smallint;

-- Add indexes for year filtering
CREATE INDEX IF NOT EXISTS idx_decks_year_group ON decks(year_group);
CREATE INDEX IF NOT EXISTS idx_study_guides_year_group ON study_guides(year_group);
