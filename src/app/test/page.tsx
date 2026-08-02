"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { useAuth } from "@/lib/auth-context";
import { createClient } from "@/lib/supabase/client";
import { Card } from "@/types";
import { User } from "@supabase/supabase-js";
import Link from "next/link";
import {
  Zap,
  BookOpen,
  Trophy,
  RotateCcw,
  ChevronRight,
  Target,
  Flame,
  X,
  Check,
} from "lucide-react";

interface DeckCards {
  deckId: string;
  deckTitle: string;
  subject: string;
  cards: Card[];
}

export default function TestPage() {
  const { user, loading: authLoading } = useAuth();
  const router = useRouter();
  const supabase = createClient();

  const [decks, setDecks] = useState<DeckCards[]>([]);
  const [selectedDeckIds, setSelectedDeckIds] = useState<Set<string>>(new Set());
  const [allCards, setAllCards] = useState<Card[]>([]);
  const [loading, setLoading] = useState(true);
  const [questionCount, setQuestionCount] = useState(10);
  const [started, setStarted] = useState(false);
  const [testCards, setTestCards] = useState<Card[]>([]);

  useEffect(() => {
    if (!authLoading && !user) {
      router.push("/login");
    }
  }, [user, authLoading, router]);

  useEffect(() => {
    if (!user) return;

    const fetchDecks = async () => {
      const { data: recent } = await supabase
        .from("recently_studied")
        .select("deck_id, decks(id, title, subject)")
        .eq("user_id", user.id)
        .order("studied_at", { ascending: false });

      if (!recent || recent.length === 0) {
        setLoading(false);
        return;
      }

      const deckIds = recent.map((r) => r.deck_id).filter(Boolean);

      const { data: cards } = await supabase
        .from("cards")
        .select("*")
        .in("deck_id", deckIds)
        .order("position");

      if (!cards) {
        setLoading(false);
        return;
      }

      const grouped: DeckCards[] = [];
      const allIds = new Set<string>();
      for (const r of recent) {
        const deck = r.decks as unknown as { id: string; title: string; subject: string } | null;
        if (!deck) continue;
        const deckCardList = cards.filter((c) => c.deck_id === deck.id);
        if (deckCardList.length > 0) {
          grouped.push({
            deckId: deck.id,
            deckTitle: deck.title,
            subject: deck.subject,
            cards: deckCardList,
          });
          allIds.add(deck.id);
        }
      }

      setDecks(grouped);
      setAllCards(cards);
      setSelectedDeckIds(allIds);
      setLoading(false);
    };

    fetchDecks();
  }, [user, supabase]);

  const toggleDeck = (deckId: string) => {
    setSelectedDeckIds((prev) => {
      const next = new Set(prev);
      if (next.has(deckId)) {
        next.delete(deckId);
      } else {
        next.add(deckId);
      }
      return next;
    });
  };

  const selectAll = () => {
    setSelectedDeckIds(new Set(decks.map((d) => d.deckId)));
  };

  const selectNone = () => {
    setSelectedDeckIds(new Set());
  };

  const selectedCards = allCards.filter((c) => selectedDeckIds.has(c.deck_id));
  const totalCards = selectedCards.length;

  const startTest = async () => {
    // Fetch study progress to prioritise weak cards
    const cardScores: Record<string, number> = {};
    if (user) {
      const cardIds = selectedCards.map((c) => c.id);
      const { data: progress } = await supabase
        .from("study_progress")
        .select("card_id, score")
        .eq("user_id", user.id)
        .in("card_id", cardIds);

      if (progress) {
        for (const p of progress) {
          cardScores[p.card_id] = p.score;
        }
      }
    }

    // Sort: weak cards (score 0 or low) come first, then untested, then strong
    const sorted = [...selectedCards].sort((a, b) => {
      const sa = cardScores[a.id] ?? -1;
      const sb = cardScores[b.id] ?? -1;
      return sa - sb;
    });

    setTestCards(sorted.slice(0, Math.min(questionCount, sorted.length)));
    setStarted(true);
  };

  if (authLoading || loading) {
    return (
      <div className="flex min-h-[50vh] items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent" />
      </div>
    );
  }

  if (started) {
    return (
      <TestRunner
        cards={testCards}
        allCards={selectedCards}
        decks={decks.filter((d) => selectedDeckIds.has(d.deckId))}
        user={user}
        onExit={() => setStarted(false)}
      />
    );
  }

  return (
    <div className="mx-auto max-w-3xl px-4 py-8 sm:px-6 lg:px-8">
      <div className="text-center mb-8">
        <div className="mx-auto flex h-16 w-16 items-center justify-center rounded-2xl bg-primary/10 text-primary">
          <Zap className="h-8 w-8" />
        </div>
        <h1 className="mt-4 text-3xl font-bold text-gray-900">Quick Test</h1>
        <p className="mt-2 text-gray-500">
          Pick your decks, then test yourself
        </p>
      </div>

      {decks.length === 0 ? (
        <div className="rounded-2xl border-2 border-dashed border-gray-300 p-12 text-center">
          <Target className="mx-auto h-10 w-10 text-gray-400" />
          <h3 className="mt-4 text-lg font-semibold text-gray-900">
            No decks studied yet
          </h3>
          <p className="mt-1 text-sm text-gray-500">
            Study some flashcard decks first, then come back for a test.
          </p>
          <Link
            href="/explore"
            className="mt-6 inline-flex items-center gap-2 rounded-lg bg-primary px-4 py-2.5 text-sm font-medium text-white hover:bg-primary-hover transition-colors"
          >
            <BookOpen className="h-4 w-4" />
            Explore Decks
          </Link>
        </div>
      ) : (
        <>
          {/* Deck picker */}
          <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm mb-6">
            <div className="flex items-center justify-between mb-3">
              <h2 className="font-semibold text-gray-900">
                Choose decks ({selectedDeckIds.size}/{decks.length})
              </h2>
              <div className="flex gap-2">
                <button
                  onClick={selectAll}
                  className="text-xs font-medium text-primary hover:text-primary-hover"
                >
                  All
                </button>
                <span className="text-gray-300">|</span>
                <button
                  onClick={selectNone}
                  className="text-xs font-medium text-gray-400 hover:text-gray-600"
                >
                  None
                </button>
              </div>
            </div>
            <div className="space-y-2">
              {decks.map((d) => {
                const isSelected = selectedDeckIds.has(d.deckId);
                return (
                  <button
                    key={d.deckId}
                    onClick={() => toggleDeck(d.deckId)}
                    className={`w-full flex items-center justify-between rounded-lg px-4 py-3 text-left transition-all ${
                      isSelected
                        ? "bg-primary/5 border border-primary/30"
                        : "bg-gray-50 border border-transparent hover:bg-gray-100"
                    }`}
                  >
                    <div className="flex items-center gap-3">
                      <div
                        className={`flex h-5 w-5 items-center justify-center rounded border-2 transition-colors ${
                          isSelected
                            ? "border-primary bg-primary text-white"
                            : "border-gray-300 bg-white"
                        }`}
                      >
                        {isSelected && <Check className="h-3 w-3" />}
                      </div>
                      <div>
                        <span className="text-sm font-medium text-gray-800">
                          {d.deckTitle}
                        </span>
                        <span className="ml-2 text-xs text-gray-400">
                          {d.subject}
                        </span>
                      </div>
                    </div>
                    <span className="text-xs font-medium text-gray-500">
                      {d.cards.length} cards
                    </span>
                  </button>
                );
              })}
            </div>
          </div>

          {/* Question count picker */}
          {totalCards > 0 && (
            <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm mb-6">
              <h2 className="font-semibold text-gray-900 mb-3">
                How many questions?
              </h2>
              <div className="flex flex-wrap gap-2">
                {[10, 20, 30, 50].map((n) => (
                  <button
                    key={n}
                    onClick={() => setQuestionCount(n)}
                    disabled={n > totalCards}
                    className={`rounded-xl border px-5 py-3 text-sm font-semibold transition-all ${
                      questionCount === n
                        ? "border-primary bg-primary text-white"
                        : "border-gray-200 bg-white text-gray-600 hover:bg-gray-50"
                    } ${n > totalCards ? "opacity-30 cursor-not-allowed" : ""}`}
                  >
                    {n}
                  </button>
                ))}
                <button
                  onClick={() => setQuestionCount(totalCards)}
                  className={`rounded-xl border px-5 py-3 text-sm font-semibold transition-all ${
                    questionCount === totalCards
                      ? "border-primary bg-primary text-white"
                      : "border-gray-200 bg-white text-gray-600 hover:bg-gray-50"
                  }`}
                >
                  All ({totalCards})
                </button>
              </div>
            </div>
          )}

          {/* Start button */}
          <button
            onClick={startTest}
            disabled={totalCards < 2}
            className="w-full flex items-center justify-center gap-2 rounded-2xl bg-primary px-6 py-4 text-lg font-bold text-white shadow-lg shadow-primary/25 hover:bg-primary-hover disabled:opacity-40 disabled:cursor-not-allowed transition-all"
          >
            <Zap className="h-5 w-5" />
            {totalCards < 2
              ? "Select at least 2 cards"
              : `Start Test (${Math.min(questionCount, totalCards)} questions)`}
            <ChevronRight className="h-5 w-5" />
          </button>
        </>
      )}
    </div>
  );
}

function TestRunner({
  cards,
  allCards,
  decks,
  user,
  onExit,
}: {
  cards: Card[];
  allCards: Card[];
  decks: DeckCards[];
  user: User | null;
  onExit: () => void;
}) {
  const supabase = createClient();
  const [currentIndex, setCurrentIndex] = useState(0);
  const [score, setScore] = useState(0);
  const [selected, setSelected] = useState<string | null>(null);
  const [answered, setAnswered] = useState(false);
  const [completed, setCompleted] = useState(false);
  const [wrongCards, setWrongCards] = useState<Card[]>([]);
  const [streak, setStreak] = useState(0);
  const [bestStreak, setBestStreak] = useState(0);
  const [saved, setSaved] = useState(false);

  const currentCard = cards[currentIndex];

  const getDeckTitle = (deckId: string) => {
    const deck = decks.find((d) => d.deckId === deckId);
    return deck?.deckTitle ?? "Unknown Deck";
  };

  const generateOptions = (card: Card): string[] => {
    const otherCards = allCards.filter((c) => c.id !== card.id);
    const shuffled = [...otherCards].sort(() => Math.random() - 0.5);
    const distractors: string[] = [];
    for (const c of shuffled) {
      if (distractors.length >= 3) break;
      if (c.back !== card.back && !distractors.includes(c.back)) {
        distractors.push(c.back);
      }
    }
    return [...distractors, card.back].sort(() => Math.random() - 0.5);
  };

  const [options, setOptions] = useState<string[]>(() =>
    generateOptions(currentCard)
  );

  const handleAnswer = (answer: string) => {
    if (answered) return;
    setSelected(answer);
    setAnswered(true);
    if (answer === currentCard.back) {
      setScore(score + 1);
      const newStreak = streak + 1;
      setStreak(newStreak);
      if (newStreak > bestStreak) setBestStreak(newStreak);
      // Update progress: increment score
      if (user) {
        supabase.from("study_progress").upsert(
          {
            user_id: user.id,
            deck_id: currentCard.deck_id,
            card_id: currentCard.id,
            score: 1,
            updated_at: new Date().toISOString(),
          },
          { onConflict: "user_id,card_id" }
        );
      }
    } else {
      setWrongCards([...wrongCards, currentCard]);
      setStreak(0);
      // Update progress: reset score for weak cards
      if (user) {
        const nextReview = new Date();
        nextReview.setDate(nextReview.getDate() + 1);
        supabase.from("study_progress").upsert(
          {
            user_id: user.id,
            deck_id: currentCard.deck_id,
            card_id: currentCard.id,
            score: 0,
            next_review: nextReview.toISOString(),
            updated_at: new Date().toISOString(),
          },
          { onConflict: "user_id,card_id" }
        );
      }
    }
  };

  const handleNext = () => {
    if (currentIndex < cards.length - 1) {
      const nextIndex = currentIndex + 1;
      setCurrentIndex(nextIndex);
      setSelected(null);
      setAnswered(false);
      setOptions(generateOptions(cards[nextIndex]));
    } else {
      setCompleted(true);
    }
  };

  // Keyboard shortcuts: 1-4 = pick answer, Enter/Space = next question
  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      if (completed) return;
      if (!answered) {
        const num = parseInt(e.key);
        if (num >= 1 && num <= options.length) {
          handleAnswer(options[num - 1]);
        }
      } else if (e.key === "Enter" || e.key === " ") {
        e.preventDefault();
        handleNext();
      }
    };
    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  });

  if (completed) {
    const percentage = Math.round((score / cards.length) * 100);

    if (user && !saved) {
      supabase.from("test_results").insert({
        user_id: user.id,
        score,
        total: cards.length,
        deck_ids: decks.map((d) => d.deckId),
      });
      setSaved(true);
    }

    return (
      <div className="mx-auto max-w-2xl px-4 py-8 sm:px-6 lg:px-8">
        <div className="rounded-2xl border border-gray-200 bg-white p-8 shadow-sm text-center">
          <div className="mx-auto flex h-16 w-16 items-center justify-center rounded-2xl bg-primary/10 text-primary">
            <Trophy className="h-8 w-8" />
          </div>
          <h2 className="mt-4 text-2xl font-bold text-gray-900">
            Test Complete!
          </h2>

          <div className="mt-6 text-6xl font-bold text-primary">
            {percentage}%
          </div>
          <p className="mt-2 text-lg text-gray-500">
            {score} of {cards.length} correct
          </p>

          <div className="mt-6 flex items-center justify-center gap-6">
            <div className="text-center">
              <div className="flex items-center gap-1 text-amber-500">
                <Flame className="h-5 w-5" />
                <span className="text-lg font-bold">{bestStreak}</span>
              </div>
              <p className="text-xs text-gray-400">Best streak</p>
            </div>
            <div className="text-center">
              <div className="text-lg font-bold text-gray-700">
                {cards.length}
              </div>
              <p className="text-xs text-gray-400">Questions</p>
            </div>
          </div>

          {wrongCards.length > 0 && (
            <div className="mt-8 text-left">
              <h3 className="font-semibold text-gray-900 mb-3">
                Review missed cards ({wrongCards.length})
              </h3>
              <div className="space-y-2 max-h-60 overflow-y-auto">
                {wrongCards.map((card) => (
                  <div
                    key={card.id}
                    className="rounded-lg border border-red-200 bg-red-50 p-3"
                  >
                    <p className="text-sm font-medium text-gray-800">
                      {card.front}
                    </p>
                    <p className="mt-1 text-sm text-accent font-medium">
                      {card.back}
                    </p>
                    <p className="mt-1 text-xs text-gray-400">
                      {getDeckTitle(card.deck_id)}
                    </p>
                  </div>
                ))}
              </div>
            </div>
          )}

          <div className="mt-8 flex flex-col sm:flex-row justify-center gap-3">
            <button
              onClick={onExit}
              className="rounded-xl border border-gray-300 bg-white px-5 py-2.5 text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
            >
              Back to Setup
            </button>
            <button
              onClick={() => window.location.reload()}
              className="rounded-xl bg-primary px-5 py-2.5 text-sm font-medium text-white hover:bg-primary-hover transition-colors"
            >
              <RotateCcw className="mr-1 inline h-4 w-4" />
              Try Again
            </button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-2xl px-4 py-8 sm:px-6 lg:px-8">
      <div className="mb-4 flex items-center justify-between">
        <button
          onClick={onExit}
          className="flex items-center gap-1 text-sm text-gray-500 hover:text-gray-700"
        >
          <X className="h-4 w-4" />
          Exit
        </button>
        <span className="text-sm text-gray-500">
          {currentIndex + 1} / {cards.length}
        </span>
        <div className="flex items-center gap-3">
          {streak >= 3 && (
            <span className="flex items-center gap-1 text-sm font-medium text-amber-500">
              <Flame className="h-4 w-4" />
              {streak}
            </span>
          )}
          <span className="text-sm font-medium text-accent">
            Score: {score}
          </span>
        </div>
      </div>

      <div className="mb-2 h-2 w-full overflow-hidden rounded-full bg-gray-200">
        <div
          className="h-full rounded-full bg-primary transition-all duration-300"
          style={{
            width: `${((currentIndex + 1) / cards.length) * 100}%`,
          }}
        />
      </div>

      <p className="mb-1 text-xs text-gray-400 text-center">
        {getDeckTitle(currentCard.deck_id)}
      </p>

      <div className="mt-4 rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
        <p className="mb-6 text-center text-lg font-medium text-gray-900">
          {currentCard.front}
        </p>

        <div className="space-y-3">
          {options.map((option) => {
            let bgClass = "border-gray-200 bg-white hover:bg-gray-50";
            if (answered && option === currentCard.back) {
              bgClass = "border-accent bg-accent/10 text-accent";
            } else if (answered && option === selected) {
              bgClass = "border-red-300 bg-red-50 text-red-600";
            }

            return (
              <button
                key={option}
                onClick={() => handleAnswer(option)}
                disabled={answered}
                className={`w-full rounded-xl border p-3 text-left text-sm font-medium transition-all ${bgClass}`}
              >
                {option}
              </button>
            );
          })}
        </div>

        {answered && (
          <button
            onClick={handleNext}
            className="mt-6 w-full rounded-xl bg-primary px-4 py-2.5 text-sm font-semibold text-white hover:bg-primary-hover transition-colors"
          >
            {currentIndex < cards.length - 1 ? "Next Question" : "See Results"}
          </button>
        )}
      </div>
    </div>
  );
}
