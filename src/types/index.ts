export interface Profile {
  id: string;
  username: string;
  full_name: string | null;
  age: number | null;
  year_group: number | null;
  preferred_subjects: string[] | null;
  avatar_url: string | null;
  created_at: string;
}

export interface Deck {
  id: string;
  user_id: string;
  title: string;
  description: string | null;
  subject: string;
  year_group: number | null;
  card_count: number;
  upvotes: number;
  downvotes: number;
  is_public: boolean;
  created_at: string;
  updated_at: string;
  profiles?: Profile;
}

export interface Card {
  id: string;
  deck_id: string;
  front: string;
  back: string;
  position: number;
  created_at: string;
}

export interface StudyGuide {
  id: string;
  user_id: string;
  title: string;
  subject: string;
  year_group: number | null;
  content: string;
  upvotes: number;
  downvotes: number;
  is_public: boolean;
  created_at: string;
  updated_at: string;
  profiles?: Profile;
}

export interface Favorite {
  id: string;
  user_id: string;
  deck_id: string | null;
  guide_id: string | null;
  created_at: string;
}

export interface Vote {
  id: string;
  user_id: string;
  deck_id: string | null;
  guide_id: string | null;
  value: -1 | 1;
  created_at: string;
}

export interface StudyProgress {
  id: string;
  user_id: string;
  deck_id: string;
  card_id: string;
  score: number;
  streak: number;
  next_review: string | null;
  updated_at: string;
}

export const SUBJECTS = [
  "Mathematics",
  "Science",
  "Biology",
  "Chemistry",
  "Physics",
  "English",
  "History",
  "Geography",
  "Computer Science",
  "Psychology",
] as const;

export type Subject = (typeof SUBJECTS)[number];

export const YEAR_GROUPS = [7, 8, 9, 10, 11, 12, 13] as const;

export type YearGroup = (typeof YEAR_GROUPS)[number];

export const YEAR_LABELS: Record<number, string> = {
  7: "Year 7 (Age 11-12)",
  8: "Year 8 (Age 12-13)",
  9: "Year 9 (Age 13-14)",
  10: "Year 10 (Age 14-15) - GCSE",
  11: "Year 11 (Age 15-16) - GCSE",
  12: "Year 12 (Age 16-17) - A-Level",
  13: "Year 13 (Age 17-18) - A-Level",
};
