"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { useAuth } from "@/lib/auth-context";
import Link from "next/link";
import { Deck, StudyGuide } from "@/types";
import { BookOpen, FileText, Plus, Trash2, Trophy, Heart } from "lucide-react";

interface TestResult {
  id: string;
  score: number;
  total: number;
  deck_ids: string[];
  created_at: string;
}

interface FavoriteDeck {
  id: string;
  deck: Deck | null;
}

export default function DashboardPage() {
  const { user, loading: authLoading } = useAuth();
  const router = useRouter();
  const supabase = createClient();
  const [decks, setDecks] = useState<Deck[]>([]);
  const [guides, setGuides] = useState<StudyGuide[]>([]);
  const [testResults, setTestResults] = useState<TestResult[]>([]);
  const [savedDecks, setSavedDecks] = useState<FavoriteDeck[]>([]);
  const [loading, setLoading] = useState(true);
  const [activeTab, setActiveTab] = useState<"decks" | "guides" | "tests" | "saved">("decks");

  useEffect(() => {
    if (!authLoading && !user) {
      router.push("/login");
    }
  }, [user, authLoading, router]);

  useEffect(() => {
    if (!user) return;

    const fetchData = async () => {
      const [decksRes, guidesRes, testsRes, favsRes] = await Promise.all([
        supabase
          .from("decks")
          .select("*")
          .eq("user_id", user.id)
          .order("created_at", { ascending: false }),
        supabase
          .from("study_guides")
          .select("*")
          .eq("user_id", user.id)
          .order("created_at", { ascending: false }),
        supabase
          .from("test_results")
          .select("*")
          .eq("user_id", user.id)
          .order("created_at", { ascending: false })
          .limit(20),
        supabase
          .from("favorites")
          .select("id, deck:decks(*)")
          .eq("user_id", user.id)
          .order("created_at", { ascending: false }),
      ]);

      if (decksRes.data) setDecks(decksRes.data);
      if (guidesRes.data) setGuides(guidesRes.data);
      if (testsRes.data) setTestResults(testsRes.data);
      if (favsRes.data) setSavedDecks(favsRes.data as unknown as FavoriteDeck[]);
      setLoading(false);
    };

    fetchData();
  }, [user, supabase]);

  const deleteDeck = async (id: string) => {
    if (!confirm("Delete this deck?")) return;
    await supabase.from("cards").delete().eq("deck_id", id);
    await supabase.from("decks").delete().eq("id", id);
    setDecks(decks.filter((d) => d.id !== id));
  };

  const deleteGuide = async (id: string) => {
    if (!confirm("Delete this study guide?")) return;
    await supabase.from("study_guides").delete().eq("id", id);
    setGuides(guides.filter((g) => g.id !== id));
  };

  if (authLoading || loading) {
    return (
      <div className="flex min-h-[50vh] items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent" />
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-5xl px-4 py-8 sm:px-6 lg:px-8">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Dashboard</h1>
          <p className="mt-1 text-sm text-gray-500">
            Manage your decks and study guides
          </p>
        </div>
        <Link
          href="/create"
          className="inline-flex items-center gap-2 rounded-lg bg-primary px-4 py-2.5 text-sm font-medium text-white hover:bg-primary-hover transition-colors"
        >
          <Plus className="h-4 w-4" />
          Create New
        </Link>
      </div>

      <div className="mt-8 flex gap-1 rounded-lg border border-gray-200 bg-white p-1 w-fit">
        <button
          onClick={() => setActiveTab("decks")}
          className={`rounded-md px-4 py-2 text-sm font-medium transition-colors ${
            activeTab === "decks"
              ? "bg-primary text-white"
              : "text-gray-600 hover:bg-gray-100"
          }`}
        >
          Flashcard Decks ({decks.length})
        </button>
        <button
          onClick={() => setActiveTab("guides")}
          className={`rounded-md px-4 py-2 text-sm font-medium transition-colors ${
            activeTab === "guides"
              ? "bg-primary text-white"
              : "text-gray-600 hover:bg-gray-100"
          }`}
        >
          Study Guides ({guides.length})
        </button>
        <button
          onClick={() => setActiveTab("tests")}
          className={`rounded-md px-4 py-2 text-sm font-medium transition-colors ${
            activeTab === "tests"
              ? "bg-primary text-white"
              : "text-gray-600 hover:bg-gray-100"
          }`}
        >
          Test History ({testResults.length})
        </button>
        <button
          onClick={() => setActiveTab("saved")}
          className={`rounded-md px-4 py-2 text-sm font-medium transition-colors ${
            activeTab === "saved"
              ? "bg-primary text-white"
              : "text-gray-600 hover:bg-gray-100"
          }`}
        >
          Saved ({savedDecks.length})
        </button>
      </div>

      <div className="mt-6">
        {activeTab === "decks" && (
          <div className="space-y-3">
            {decks.length === 0 ? (
              <EmptyState
                icon={<BookOpen className="h-8 w-8" />}
                title="No decks yet"
                description="Create your first flashcard deck to get started."
                actionLabel="Create a Deck"
                actionHref="/create"
              />
            ) : (
              decks.map((deck) => (
                <div
                  key={deck.id}
                  className="flex items-center justify-between rounded-xl border border-gray-200 bg-white p-4 shadow-sm hover:shadow-md transition-shadow"
                >
                  <div className="flex items-center gap-4">
                    <div className="flex h-12 w-12 items-center justify-center rounded-lg bg-primary/10 text-primary">
                      <BookOpen className="h-5 w-5" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-gray-900">
                        {deck.title}
                      </h3>
                      <p className="text-sm text-gray-500">
                        {deck.subject} &middot; {deck.card_count} cards &middot;{" "}
                        {deck.upvotes} upvotes
                      </p>
                    </div>
                  </div>
                  <div className="flex items-center gap-2">
                    <Link
                      href={`/study/${deck.id}`}
                      className="rounded-lg bg-gray-100 px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-200 transition-colors"
                    >
                      Study
                    </Link>
                    <button
                      onClick={() => deleteDeck(deck.id)}
                      className="rounded-lg p-1.5 text-gray-400 hover:bg-red-50 hover:text-red-500 transition-colors"
                    >
                      <Trash2 className="h-4 w-4" />
                    </button>
                  </div>
                </div>
              ))
            )}
          </div>
        )}

        {activeTab === "guides" && (
          <div className="space-y-3">
            {guides.length === 0 ? (
              <EmptyState
                icon={<FileText className="h-8 w-8" />}
                title="No study guides yet"
                description="Upload your first study guide to get started."
                actionLabel="Create a Guide"
                actionHref="/create"
              />
            ) : (
              guides.map((guide) => (
                <div
                  key={guide.id}
                  className="flex items-center justify-between rounded-xl border border-gray-200 bg-white p-4 shadow-sm hover:shadow-md transition-shadow"
                >
                  <div className="flex items-center gap-4">
                    <div className="flex h-12 w-12 items-center justify-center rounded-lg bg-accent/10 text-accent">
                      <FileText className="h-5 w-5" />
                    </div>
                    <div>
                      <Link
                        href={`/guide/${guide.id}`}
                        className="font-semibold text-gray-900 hover:text-accent"
                      >
                        {guide.title}
                      </Link>
                      <p className="text-sm text-gray-500">
                        {guide.subject} &middot; {guide.content.length} chars
                        &middot; {guide.upvotes} upvotes
                      </p>
                    </div>
                  </div>
                  <div className="flex items-center gap-2">
                    <Link
                      href={`/guide/${guide.id}`}
                      className="rounded-lg bg-gray-100 px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-200 transition-colors"
                    >
                      Read
                    </Link>
                    <button
                      onClick={() => deleteGuide(guide.id)}
                      className="rounded-lg p-1.5 text-gray-400 hover:bg-red-50 hover:text-red-500 transition-colors"
                    >
                      <Trash2 className="h-4 w-4" />
                    </button>
                  </div>
                </div>
              ))
            )}
          </div>
        )}

        {activeTab === "tests" && (
          <div className="space-y-3">
            {testResults.length === 0 ? (
              <EmptyState
                icon={<Trophy className="h-8 w-8" />}
                title="No tests taken yet"
                description="Complete a test to see your history here."
                actionLabel="Take a Test"
                actionHref="/test"
              />
            ) : (
              testResults.map((result) => {
                const pct = Math.round((result.score / result.total) * 100);
                return (
                  <div
                    key={result.id}
                    className="flex items-center justify-between rounded-xl border border-gray-200 bg-white p-4 shadow-sm hover:shadow-md transition-shadow"
                  >
                    <div className="flex items-center gap-4">
                    <div
                      className={`flex h-12 w-12 items-center justify-center rounded-lg ${
                        pct >= 80
                          ? "bg-green-50 text-green-600"
                          : pct >= 50
                          ? "bg-amber-50 text-amber-600"
                          : "bg-red-50 text-red-600"
                        }`}
                      >
                        <Trophy className="h-5 w-5" />
                      </div>
                      <div>
                        <p className="font-semibold text-gray-900">
                          {result.score}/{result.total} correct
                        </p>
                        <p className="text-sm text-gray-500">
                          {pct}% &middot;{" "}
                          {new Date(result.created_at).toLocaleDateString()}
                          {result.deck_ids.length > 0 &&
                            ` · ${result.deck_ids.length} deck${result.deck_ids.length > 1 ? "s" : ""}`}
                        </p>
                      </div>
                    </div>
                    <div
                      className={`text-2xl font-bold ${
                        pct >= 80
                          ? "text-green-600"
                          : pct >= 50
                          ? "text-amber-600"
                          : "text-red-600"
                      }`}
                    >
                      {pct}%
                    </div>
                  </div>
                );
              })
            )}
          </div>
        )}

        {activeTab === "saved" && (
          <div className="space-y-3">
            {savedDecks.length === 0 ? (
              <EmptyState
                icon={<Heart className="h-8 w-8" />}
                title="No saved decks"
                description="Bookmark decks from Explore to find them here later."
                actionLabel="Explore Decks"
                actionHref="/explore"
              />
            ) : (
              savedDecks
                .filter((f) => f.deck)
                .map((f) => {
                  const d = f.deck!;
                  return (
                    <div
                      key={f.id}
                      className="flex items-center justify-between rounded-xl border border-gray-200 bg-white p-4 shadow-sm hover:shadow-md transition-shadow"
                    >
                      <div className="flex items-center gap-4">
                        <div className="flex h-12 w-12 items-center justify-center rounded-lg bg-primary/10 text-primary">
                          <BookOpen className="h-5 w-5" />
                        </div>
                        <div>
                          <Link
                            href={`/study/${d.id}`}
                            className="font-semibold text-gray-900 hover:text-primary"
                          >
                            {d.title}
                          </Link>
                          <p className="text-sm text-gray-500">
                            {d.subject} &middot; {d.card_count} cards
                          </p>
                        </div>
                      </div>
                      <div className="flex items-center gap-2">
                        <Link
                          href={`/study/${d.id}`}
                      className="rounded-lg bg-gray-100 px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-200 transition-colors"
                        >
                          Study
                        </Link>
                        <button
                          onClick={async () => {
                            await supabase
                              .from("favorites")
                              .delete()
                              .eq("id", f.id);
                            setSavedDecks(savedDecks.filter((s) => s.id !== f.id));
                          }}
                          className="rounded-lg p-1.5 text-gray-400 hover:bg-red-50 hover:text-red-500 transition-colors"
                        >
                          <Trash2 className="h-4 w-4" />
                        </button>
                      </div>
                    </div>
                  );
                })
            )}
          </div>
        )}
      </div>
    </div>
  );
}

function EmptyState({
  icon,
  title,
  description,
  actionLabel,
  actionHref,
}: {
  icon: React.ReactNode;
  title: string;
  description: string;
  actionLabel: string;
  actionHref: string;
}) {
  return (
    <div className="rounded-2xl border-2 border-dashed border-gray-300 p-12 text-center">
      <div className="mx-auto flex h-16 w-16 items-center justify-center rounded-full bg-gray-100 text-gray-400">
        {icon}
      </div>
      <h3 className="mt-4 text-lg font-semibold text-gray-900">{title}</h3>
      <p className="mt-1 text-sm text-gray-500">{description}</p>
      <Link
        href={actionHref}
        className="mt-6 inline-flex items-center gap-2 rounded-lg bg-primary px-4 py-2.5 text-sm font-medium text-white hover:bg-primary-hover transition-colors"
      >
        <Plus className="h-4 w-4" />
        {actionLabel}
      </Link>
    </div>
  );
}
