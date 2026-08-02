"use client";

import { useState, useEffect } from "react";
import Link from "next/link";
import { useAuth } from "@/lib/auth-context";
import { createClient } from "@/lib/supabase/client";
import {
  BookOpen,
  Plus,
  Search,
  Sparkles,
  ArrowRight,
  Brain,
  FlaskConical,
  Calculator,
  Globe,
  History,
  Monitor,
  GraduationCap,
  Atom,
} from "lucide-react";
import type { Deck } from "@/types";

const SUBJECT_CARDS: {
  name: string;
  icon: React.ElementType;
  color: string;
  bg: string;
}[] = [
  { name: "Mathematics", icon: Calculator, color: "text-blue-600", bg: "bg-blue-50" },
  { name: "Science", icon: FlaskConical, color: "text-green-600", bg: "bg-green-50" },
  { name: "Biology", icon: Atom, color: "text-emerald-600", bg: "bg-emerald-50" },
  { name: "Chemistry", icon: FlaskConical, color: "text-amber-600", bg: "bg-amber-50" },
  { name: "Physics", icon: GraduationCap, color: "text-purple-600", bg: "bg-purple-50" },
  { name: "English", icon: Monitor, color: "text-rose-600", bg: "bg-rose-50" },
  { name: "History", icon: History, color: "text-orange-600", bg: "bg-orange-50" },
  { name: "Geography", icon: Globe, color: "text-teal-600", bg: "bg-teal-50" },
  { name: "Computer Science", icon: Monitor, color: "text-indigo-600", bg: "bg-indigo-50" },
  { name: "Psychology", icon: Brain, color: "text-violet-600", bg: "bg-violet-50" },
];

export default function HomePage() {
  const { user } = useAuth();
  const supabase = createClient();
  const [recentDecks, setRecentDecks] = useState<Deck[]>([]);
  const [deckCount, setDeckCount] = useState(0);

  useEffect(() => {
    const fetchData = async () => {
      const { count } = await supabase
        .from("decks")
        .select("*", { count: "exact", head: true })
        .eq("is_public", true);
      setDeckCount(count ?? 0);

      const { data } = await supabase
        .from("decks")
        .select("*")
        .eq("is_public", true)
        .order("created_at", { ascending: false })
        .limit(6);
      if (data) setRecentDecks(data);
    };
    fetchData();
  }, [supabase]);

  return (
    <div className="flex flex-col">
      {/* Hero */}
      <section className="bg-gradient-to-br from-primary/5 via-white to-accent/5 px-4 py-14 sm:py-20 sm:px-6 lg:px-8">
        <div className="mx-auto max-w-4xl text-center">
          {user ? (
            <>
              <h1 className="text-3xl font-bold tracking-tight text-gray-900 sm:text-5xl">
                Welcome back! <span className="text-primary">Ready to study?</span>
              </h1>
              <p className="mx-auto mt-4 max-w-xl text-lg text-gray-600">
                You have {deckCount} public decks to explore. Pick a subject below
                or jump straight into creating.
              </p>
            </>
          ) : (
            <>
              <h1 className="text-3xl font-bold tracking-tight text-gray-900 sm:text-5xl">
                Your <span className="text-primary">study hub</span> starts here
              </h1>
              <p className="mx-auto mt-4 max-w-xl text-lg text-gray-600">
                Browse {deckCount} flashcard decks by subject, generate cards
                with AI, and track your progress.
              </p>
            </>
          )}

          {/* Quick actions */}
          <div className="mt-8 flex flex-col items-center gap-3 sm:flex-row sm:justify-center">
            <Link
              href="/explore"
              className="inline-flex items-center gap-2 rounded-xl bg-primary px-6 py-3 text-base font-semibold text-white shadow-lg shadow-primary/25 hover:bg-primary-hover transition-all"
            >
              <Search className="h-5 w-5" />
              Explore Decks
            </Link>
            <Link
              href="/create"
              className="inline-flex items-center gap-2 rounded-xl border border-gray-300 bg-white px-6 py-3 text-base font-semibold text-gray-700 shadow-sm hover:bg-gray-50 transition-all"
            >
              <Plus className="h-5 w-5" />
              Create a Deck
            </Link>
            <Link
              href="/create"
              className="inline-flex items-center gap-2 rounded-xl border border-primary/30 bg-primary/5 px-6 py-3 text-base font-semibold text-primary hover:bg-primary/10 transition-all"
            >
              <Sparkles className="h-5 w-5" />
              AI Generator
            </Link>
          </div>
        </div>
      </section>

      {/* Subjects */}
      <section className="px-4 py-14 sm:px-6 lg:px-8">
        <div className="mx-auto max-w-6xl">
          <h2 className="text-2xl font-bold text-gray-900">Browse by Subject</h2>
          <p className="mt-1 text-sm text-gray-500">
            Find flashcard decks and guides for your subjects
          </p>
          <div className="mt-6 grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-4">
            {SUBJECT_CARDS.map((s) => {
              const Icon = s.icon;
              return (
                <Link
                  key={s.name}
                  href={`/explore?subject=${encodeURIComponent(s.name)}`}
                  className="group flex items-center gap-3 rounded-xl border border-gray-200 bg-white p-4 shadow-sm transition-all hover:shadow-md hover:border-primary/30"
                >
                  <div className={`flex h-10 w-10 items-center justify-center rounded-lg ${s.bg} ${s.color}`}>
                    <Icon className="h-5 w-5" />
                  </div>
                  <span className="text-sm font-semibold text-gray-800 group-hover:text-primary transition-colors">
                    {s.name}
                  </span>
                </Link>
              );
            })}
          </div>
        </div>
      </section>

      {/* Recent Decks */}
      {recentDecks.length > 0 && (
        <section className="px-4 py-14 sm:px-6 lg:px-8">
          <div className="mx-auto max-w-6xl">
            <div className="flex items-center justify-between">
              <div>
                <h2 className="text-2xl font-bold text-gray-900">Recently Added</h2>
                <p className="mt-1 text-sm text-gray-500">
                  Fresh flashcard decks from the community
                </p>
              </div>
              <Link
                href="/explore"
                className="flex items-center gap-1 text-sm font-medium text-primary hover:text-primary-hover transition-colors"
              >
                View all <ArrowRight className="h-4 w-4" />
              </Link>
            </div>
            <div className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
              {recentDecks.map((deck) => (
                <Link
                  key={deck.id}
                  href={`/study/${deck.id}`}
                  className="group rounded-xl border border-gray-200 bg-white p-5 shadow-sm transition-all hover:shadow-md hover:border-primary/30"
                >
                  <div className="flex items-center gap-2 text-xs font-medium text-gray-400">
                    <BookOpen className="h-3.5 w-3.5" />
                    {deck.subject}
                  </div>
                  <h3 className="mt-2 text-base font-semibold text-gray-900 group-hover:text-primary transition-colors line-clamp-2">
                    {deck.title}
                  </h3>
                  {deck.description && (
                    <p className="mt-1 text-sm text-gray-500 line-clamp-2">
                      {deck.description}
                    </p>
                  )}
                  <div className="mt-3 flex items-center gap-3 text-xs text-gray-400">
                    <span>{deck.card_count} cards</span>
                    <span>{deck.upvotes} upvotes</span>
                  </div>
                </Link>
              ))}
            </div>
          </div>
        </section>
      )}

      {/* Bottom CTA */}
      {!user && (
        <section className="bg-gray-900 px-4 py-14 sm:px-6 lg:px-8">
          <div className="mx-auto max-w-4xl text-center">
            <h2 className="text-2xl font-bold text-white">
              Ready to start studying?
            </h2>
            <p className="mt-3 text-lg text-gray-400">
              Create your free account and start building flashcard decks today.
            </p>
            <Link
              href="/signup"
              className="mt-6 inline-flex rounded-xl bg-primary px-8 py-3.5 text-base font-semibold text-white shadow-lg shadow-primary/25 hover:bg-primary-hover transition-all"
            >
              Sign Up Free
            </Link>
          </div>
        </section>
      )}
    </div>
  );
}
