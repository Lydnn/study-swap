"use client";

import { Suspense, useEffect, useState } from "react";
import { useSearchParams } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { Deck, StudyGuide, SUBJECTS, YEAR_GROUPS } from "@/types";
import Link from "next/link";
import { useAuth } from "@/lib/auth-context";
import FavoriteButton from "@/components/FavoriteButton";
import {
  Search,
  BookOpen,
  FileText,
  ChevronUp,
  ChevronDown,
} from "lucide-react";

export default function ExplorePage() {
  return (
    <Suspense
      fallback={
        <div className="flex min-h-[50vh] items-center justify-center">
          <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent" />
        </div>
      }
    >
      <ExploreContent />
    </Suspense>
  );
}

function ExploreContent() {
  const { user } = useAuth();
  const searchParams = useSearchParams();
  const supabase = createClient();
  const [decks, setDecks] = useState<Deck[]>([]);
  const [guides, setGuides] = useState<StudyGuide[]>([]);
  const [query, setQuery] = useState("");
  const [subject, setSubject] = useState(searchParams.get("subject") ?? "All");
  const [yearGroup, setYearGroup] = useState<string>("All");
  const [tab, setTab] = useState<"decks" | "guides">("decks");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchContent = async () => {
      setLoading(true);

      let deckQuery = supabase
        .from("decks")
        .select("*")
        .eq("is_public", true);

      let guideQuery = supabase
        .from("study_guides")
        .select("*")
        .eq("is_public", true);

      if (subject !== "All") {
        deckQuery = deckQuery.eq("subject", subject);
        guideQuery = guideQuery.eq("subject", subject);
      }

      if (yearGroup !== "All") {
        deckQuery = deckQuery.eq("year_group", parseInt(yearGroup));
        guideQuery = guideQuery.eq("year_group", parseInt(yearGroup));
      }

      if (query.trim()) {
        deckQuery = deckQuery.ilike("title", `%${query}%`);
        guideQuery = guideQuery.ilike("title", `%${query}%`);
      }

      const [decksRes, guidesRes] = await Promise.all([
        deckQuery.order("upvotes", { ascending: false }).limit(50),
        guideQuery.order("upvotes", { ascending: false }).limit(50),
      ]);

      if (decksRes.data) setDecks(decksRes.data);
      if (guidesRes.data) setGuides(guidesRes.data);
      setLoading(false);
    };

    fetchContent();
  }, [query, subject, yearGroup, supabase]);

  const handleVote = async (
    type: "deck" | "guide",
    id: string,
    value: -1 | 1
  ) => {
    const table = type === "deck" ? "decks" : "study_guides";
    const column: "upvotes" | "downvotes" = value === 1 ? "upvotes" : "downvotes";

    const { data: current } = await supabase
      .from(table)
      .select(column)
      .eq("id", id)
      .single();

    if (current) {
      await supabase
        .from(table)
        .update({ [column]: (current as Record<string, number>)[column] + 1 })
        .eq("id", id);

      if (type === "deck") {
        setDecks(
          decks.map((d) =>
            d.id === id ? { ...d, [column]: d[column] + 1 } : d
          )
        );
      } else {
        setGuides(
          guides.map((g) =>
            g.id === id ? { ...g, [column]: g[column] + 1 } : g
          )
        );
      }
    }
  };

  return (
    <div className="mx-auto max-w-5xl px-4 py-8 sm:px-6 lg:px-8">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-gray-900">Explore</h1>
        <p className="mt-1 text-sm text-gray-500">
          Discover flashcard decks and study guides for every year
        </p>
      </div>

      {/* Search */}
      <div className="relative">
        <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400" />
        <input
          type="text"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="Search decks and guides..."
          className="w-full rounded-xl border border-gray-300 bg-white py-2.5 pl-10 pr-4 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
        />
      </div>

      {/* Year group pills */}
      <div className="mt-4 flex flex-wrap gap-2">
        <span className="mr-1 self-center text-xs font-medium text-gray-400">
          Year:
        </span>
        <button
          onClick={() => setYearGroup("All")}
          className={`rounded-full px-3 py-1 text-xs font-medium transition-colors ${
            yearGroup === "All"
              ? "bg-primary text-white"
              : "bg-gray-100 text-gray-600 hover:bg-gray-200"
          }`}
        >
          All
        </button>
        {YEAR_GROUPS.map((yr) => (
          <button
            key={yr}
            onClick={() => setYearGroup(String(yr))}
            className={`rounded-full px-3 py-1 text-xs font-medium transition-colors ${
              yearGroup === String(yr)
                ? "bg-primary text-white"
                : "bg-gray-100 text-gray-600 hover:bg-gray-200"
            }`}
          >
            Year {yr}
          </button>
        ))}
      </div>

      {/* Subject pills */}
      <div className="mt-2 flex flex-wrap gap-2">
        <span className="mr-1 self-center text-xs font-medium text-gray-400">
          Subject:
        </span>
        <button
          onClick={() => setSubject("All")}
          className={`rounded-full px-3 py-1 text-xs font-medium transition-colors ${
            subject === "All"
              ? "bg-primary text-white"
              : "bg-gray-100 text-gray-600 hover:bg-gray-200"
          }`}
        >
          All
        </button>
        {SUBJECTS.map((s) => (
          <button
            key={s}
            onClick={() => setSubject(s)}
            className={`rounded-full px-3 py-1 text-xs font-medium transition-colors ${
              subject === s
                ? "bg-primary text-white"
                : "bg-gray-100 text-gray-600 hover:bg-gray-200"
            }`}
          >
            {s}
          </button>
        ))}
      </div>

      {/* Tabs */}
      <div className="mt-6 flex gap-1 rounded-lg border border-gray-200 bg-white p-1 w-fit">
        <button
          onClick={() => setTab("decks")}
          className={`flex items-center gap-1.5 rounded-md px-4 py-2 text-sm font-medium transition-colors ${
            tab === "decks"
              ? "bg-primary text-white"
              : "text-gray-600 hover:bg-gray-100"
          }`}
        >
          <BookOpen className="h-4 w-4" />
          Decks ({decks.length})
        </button>
        <button
          onClick={() => setTab("guides")}
          className={`flex items-center gap-1.5 rounded-md px-4 py-2 text-sm font-medium transition-colors ${
            tab === "guides"
              ? "bg-primary text-white"
              : "text-gray-600 hover:bg-gray-100"
          }`}
        >
          <FileText className="h-4 w-4" />
          Guides ({guides.length})
        </button>
      </div>

      {/* Content */}
      <div className="mt-6 space-y-3">
        {loading ? (
          <div className="flex min-h-[30vh] items-center justify-center">
            <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent" />
          </div>
        ) : tab === "decks" ? (
          decks.length === 0 ? (
            <EmptyResult />
          ) : (
            decks.map((deck) => (
              <div
                key={deck.id}
                className="flex items-center gap-4 rounded-xl border border-gray-200 bg-white p-4 shadow-sm hover:shadow-md transition-shadow"
              >
                <div className="flex flex-col items-center gap-1">
                  <button
                    onClick={() => handleVote("deck", deck.id, 1)}
                    className="rounded p-1 text-gray-400 hover:bg-gray-100 hover:text-primary"
                  >
                    <ChevronUp className="h-5 w-5" />
                  </button>
                  <span className="text-sm font-semibold text-gray-700">
                    {deck.upvotes - deck.downvotes}
                  </span>
                  <button
                    onClick={() => handleVote("deck", deck.id, -1)}
                    className="rounded p-1 text-gray-400 hover:bg-gray-100 hover:text-red-500"
                  >
                    <ChevronDown className="h-5 w-5" />
                  </button>
                </div>
                <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg bg-primary/10 text-primary">
                  <BookOpen className="h-5 w-5" />
                </div>
                <div className="flex-1 min-w-0">
                  <Link
                    href={`/study/${deck.id}`}
                    className="font-semibold text-gray-900 hover:text-primary truncate block"
                  >
                    {deck.title}
                  </Link>
                  <p className="text-sm text-gray-500 truncate">
                    {deck.description || "No description"} &middot;{" "}
                    {deck.subject} &middot; {deck.card_count} cards
                    {deck.year_group && (
                      <> &middot; Year {deck.year_group}</>
                    )}
                  </p>
                </div>
                <FavoriteButton deckId={deck.id} user={user} />
                <Link
                  href={`/study/${deck.id}`}
                  className="shrink-0 rounded-lg bg-primary/10 px-3 py-1.5 text-xs font-medium text-primary hover:bg-primary/20 transition-colors"
                >
                  Study
                </Link>
              </div>
            ))
          )
        ) : guides.length === 0 ? (
          <EmptyResult />
        ) : (
          guides.map((guide) => (
            <div
              key={guide.id}
                className="flex items-center gap-4 rounded-xl border border-gray-200 bg-white p-4 shadow-sm hover:shadow-md transition-shadow"
            >
              <div className="flex flex-col items-center gap-1">
                <button
                  onClick={() => handleVote("guide", guide.id, 1)}
                  className="rounded p-1 text-gray-400 hover:bg-gray-100 hover:text-primary"
                >
                  <ChevronUp className="h-5 w-5" />
                </button>
                  <span className="text-sm font-semibold text-gray-700">
                    {guide.upvotes - guide.downvotes}
                  </span>
                  <button
                    onClick={() => handleVote("guide", guide.id, -1)}
                    className="rounded p-1 text-gray-400 hover:bg-gray-100 hover:text-red-500"
                >
                  <ChevronDown className="h-5 w-5" />
                </button>
              </div>
              <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg bg-accent/10 text-accent">
                <FileText className="h-5 w-5" />
              </div>
              <div className="flex-1 min-w-0">
                <Link
                  href={`/guide/${guide.id}`}
                  className="font-semibold text-gray-900 hover:text-accent truncate block"
                >
                  {guide.title}
                </Link>
                  <p className="text-sm text-gray-500 truncate">
                  {guide.subject} &middot;{" "}
                  {guide.content.substring(0, 100)}...
                  {guide.year_group && (
                    <> &middot; Year {guide.year_group}</>
                  )}
                </p>
              </div>
              <Link
                href={`/guide/${guide.id}`}
                className="shrink-0 rounded-lg bg-accent/10 px-3 py-1.5 text-xs font-medium text-accent hover:bg-accent/20 transition-colors"
              >
                Read
              </Link>
            </div>
          ))
        )}
      </div>
    </div>
  );
}

function EmptyResult() {
  return (
    <div className="rounded-2xl border-2 border-dashed border-gray-300 p-12 text-center">
      <Search className="mx-auto h-8 w-8 text-gray-400" />
      <h3 className="mt-4 text-lg font-semibold text-gray-900">
        Nothing found
      </h3>
      <p className="mt-1 text-sm text-gray-500">
        Try a different search or filter. Or be the first to create content for
        this subject!
      </p>
    </div>
  );
}
