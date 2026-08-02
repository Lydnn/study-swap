"use client";

import { useState, useEffect } from "react";
import { Card } from "@/types";
import { User } from "@supabase/supabase-js";
import { createClient } from "@/lib/supabase/client";
import Link from "next/link";
import { ChevronLeft, ChevronRight, RotateCcw, Save, LogIn, CheckCircle, Zap } from "lucide-react";

interface StudyPlayerProps {
  cards: Card[];
  deckId: string;
  user: User | null;
}

export default function StudyPlayer({ cards, deckId, user }: StudyPlayerProps) {
  const supabase = createClient();
  const [currentIndex, setCurrentIndex] = useState(0);
  const [flipped, setFlipped] = useState(false);
  const [showQuiz, setShowQuiz] = useState(false);
  const [completed, setCompleted] = useState(false);
  const [saved, setSaved] = useState(false);

  const currentCard = cards[currentIndex];

  const goNext = () => {
    if (currentIndex < cards.length - 1) {
      setFlipped(false);
      setCurrentIndex(currentIndex + 1);
    } else {
      setCompleted(true);
    }
  };

  const goPrev = () => {
    if (currentIndex > 0) {
      setFlipped(false);
      setCurrentIndex(currentIndex - 1);
    }
  };

  const restart = () => {
    setFlipped(false);
    setCurrentIndex(0);
    setCompleted(false);
  };

  const markComplete = async () => {
    if (!user || saved) return;
    await supabase.from("recently_studied").upsert(
      {
        user_id: user.id,
        deck_id: deckId,
        total_cards: cards.length,
        studied_at: new Date().toISOString(),
      },
      { onConflict: "user_id,deck_id" }
    );
    setSaved(true);
  };

  // Keyboard shortcuts: Space/Enter = flip, Arrow keys = navigate
  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      if (showQuiz || completed) return;
      if (e.key === " " || e.key === "Enter") {
        e.preventDefault();
        setFlipped((f) => !f);
      } else if (e.key === "ArrowRight") {
        goNext();
      } else if (e.key === "ArrowLeft") {
        goPrev();
      }
    };
    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  });

  if (showQuiz) {
    return (
      <QuizMode
        cards={cards}
        deckId={deckId}
        user={user}
        onExit={() => setShowQuiz(false)}
      />
    );
  }

  if (completed) {
    if (user && !saved) {
      markComplete();
    }

    return (
      <div className="flex flex-col items-center text-center">
        <div className="rounded-2xl border border-gray-200 bg-white p-8 shadow-sm w-full max-w-lg">
          <div className="mx-auto flex h-16 w-16 items-center justify-center rounded-2xl bg-accent/10 text-accent">
            <CheckCircle className="h-8 w-8" />
          </div>
          <h2 className="mt-4 text-2xl font-bold text-gray-900">
            Deck Complete!
          </h2>
          <p className="mt-2 text-gray-500">
            You went through all {cards.length} cards
          </p>

          {user ? (
            <div className="mt-4 flex items-center justify-center gap-2 text-sm text-accent">
              <Save className="h-4 w-4" />
              {saved ? "Saved to your study history" : "Saving..."}
            </div>
          ) : (
            <div className="mt-4 rounded-xl border border-amber-200 bg-amber-50 p-4">
              <p className="text-sm text-amber-700">
                Sign up to track your progress and use the Test feature
              </p>
            </div>
          )}

          <div className="mt-6 flex flex-col gap-3">
            <button
              onClick={() => setShowQuiz(true)}
              className="flex items-center justify-center gap-2 rounded-xl bg-accent px-5 py-3 text-sm font-semibold text-white hover:bg-emerald-600 transition-colors"
            >
              <Zap className="h-4 w-4" />
              Quiz Yourself
            </button>
            <div className="flex gap-3">
              <button
                onClick={restart}
                className="flex-1 flex items-center justify-center gap-2 rounded-xl border border-gray-300 bg-white px-4 py-2.5 text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
              >
                <RotateCcw className="h-4 w-4" />
                Study Again
              </button>
              <Link
                href="/test"
                className="flex-1 flex items-center justify-center gap-2 rounded-xl bg-primary px-4 py-2.5 text-sm font-medium text-white hover:bg-primary-hover transition-colors"
              >
                <Zap className="h-4 w-4" />
                Take a Test
              </Link>
            </div>
            <Link
              href="/explore"
              className="text-sm text-gray-500 hover:text-gray-700"
            >
              Back to Explore
            </Link>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="flex flex-col items-center">
      <div className="mb-4 text-sm text-gray-500">
        Card {currentIndex + 1} of {cards.length}
      </div>

      <div className="mb-6 h-2 w-full max-w-md overflow-hidden rounded-full bg-gray-200">
        <div
          className="h-full rounded-full bg-primary transition-all duration-300"
          style={{
            width: `${((currentIndex + 1) / cards.length) * 100}%`,
          }}
        />
      </div>

      <div
        className="flashcard-flip mb-8 h-64 w-full max-w-lg cursor-pointer"
        onClick={() => setFlipped(!flipped)}
      >
        <div
          className={`flashcard-inner relative h-full w-full ${flipped ? "flipped" : ""}`}
        >
          <div className="flashcard-front absolute inset-0 flex items-center justify-center rounded-2xl border-2 border-gray-200 bg-white p-8 shadow-lg">
            <p className="text-center text-lg font-medium text-gray-900">
              {currentCard.front}
            </p>
            <span className="absolute bottom-3 text-xs text-gray-400">
              Click to reveal answer
            </span>
          </div>
          <div className="flashcard-back absolute inset-0 flex items-center justify-center rounded-2xl border-2 border-primary/30 bg-primary/5 p-8 shadow-lg">
            <p className="text-center text-lg text-gray-900">
              {currentCard.back}
            </p>
            <span className="absolute bottom-3 text-xs text-gray-400">
              Click to see question
            </span>
          </div>
        </div>
      </div>

      <div className="flex items-center gap-4">
        <button
          onClick={goPrev}
          disabled={currentIndex === 0}
          className="rounded-xl border border-gray-300 bg-white p-3 text-gray-600 hover:bg-gray-50 disabled:opacity-30 transition-colors"
        >
          <ChevronLeft className="h-5 w-5" />
        </button>
        <button
          onClick={restart}
          className="rounded-xl border border-gray-300 bg-white p-3 text-gray-600 hover:bg-gray-50 transition-colors"
        >
          <RotateCcw className="h-5 w-5" />
        </button>
        <button
          onClick={goNext}
          className={`rounded-xl p-3 transition-colors ${
            currentIndex === cards.length - 1
              ? "bg-accent text-white hover:bg-emerald-600"
              : "border border-gray-300 bg-white text-gray-600 hover:bg-gray-50"
          }`}
        >
          {currentIndex === cards.length - 1 ? (
            <CheckCircle className="h-5 w-5" />
          ) : (
            <ChevronRight className="h-5 w-5" />
          )}
        </button>
      </div>

      <button
        onClick={() => setShowQuiz(true)}
        className="mt-6 rounded-xl bg-accent px-6 py-2.5 text-sm font-semibold text-white hover:bg-emerald-600 transition-colors"
      >
        Switch to Quiz Mode
      </button>

      {!user && (
        <div className="mt-6 rounded-xl border border-amber-200 bg-amber-50 px-4 py-3 text-center text-sm text-amber-700">
          <LogIn className="mb-1 inline h-4 w-4" />{" "}
          <Link href="/signup" className="font-medium underline hover:text-amber-800">
            Sign up
          </Link>{" "}
          or{" "}
          <Link href="/login" className="font-medium underline hover:text-amber-800">
            log in
          </Link>{" "}
          to save your progress and track study streaks
        </div>
      )}
    </div>
  );
}

function QuizMode({
  cards,
  deckId,
  user,
  onExit,
}: {
  cards: Card[];
  deckId: string;
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
  const [saved, setSaved] = useState(false);

  const currentCard = cards[currentIndex];

  const generateOptions = (card: Card): string[] => {
    const otherCards = cards.filter((c) => c.id !== card.id);
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
    } else {
      setWrongCards([...wrongCards, currentCard]);
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

  const saveProgress = async () => {
    if (!user || saved) return;

    await supabase.from("recently_studied").upsert(
      {
        user_id: user.id,
        deck_id: deckId,
        last_score: score,
        total_cards: cards.length,
        studied_at: new Date().toISOString(),
      },
      { onConflict: "user_id,deck_id" }
    );

    setSaved(true);
  };

  if (completed) {
    const percentage = Math.round((score / cards.length) * 100);

    if (user && !saved) {
      saveProgress();
    }

    return (
      <div className="text-center">
        <div className="rounded-2xl border border-gray-200 bg-white p-8 shadow-sm">
          <h2 className="text-2xl font-bold text-gray-900">Quiz Complete!</h2>
          <div className="mt-6 text-5xl font-bold text-primary">
            {percentage}%
          </div>
          <p className="mt-2 text-gray-500">
            {score} of {cards.length} correct
          </p>
          {wrongCards.length > 0 && (
            <p className="mt-4 text-sm text-amber-600">
              Review these {wrongCards.length} cards you missed
            </p>
          )}

          {user ? (
            <div className="mt-4 flex items-center justify-center gap-2 text-sm text-accent">
              <Save className="h-4 w-4" />
              Progress saved to your dashboard
            </div>
          ) : (
            <div className="mt-6 rounded-xl border border-amber-200 bg-amber-50 p-4">
              <p className="text-sm text-amber-700">
                Want to save this score and track your progress?
              </p>
              <div className="mt-3 flex justify-center gap-3">
                <Link
                  href="/signup"
                  className="rounded-lg bg-primary px-4 py-2 text-sm font-medium text-white hover:bg-primary-hover transition-colors"
                >
                  Sign up free
                </Link>
                <Link
                  href="/login"
                  className="rounded-lg border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
                >
                  Log in
                </Link>
              </div>
            </div>
          )}

          <div className="mt-8 flex justify-center gap-3">
            <button
              onClick={onExit}
              className="rounded-xl border border-gray-300 bg-white px-5 py-2.5 text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
            >
              Back to Flashcards
            </button>
            <button
              onClick={() => {
                setCurrentIndex(0);
                setScore(0);
                setSelected(null);
                setAnswered(false);
                setCompleted(false);
                setWrongCards([]);
                setSaved(false);
                setOptions(generateOptions(cards[0]));
              }}
              className="rounded-xl bg-primary px-5 py-2.5 text-sm font-medium text-white hover:bg-primary-hover transition-colors"
            >
              Try Again
            </button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-lg">
      <div className="mb-4 flex items-center justify-between">
        <span className="text-sm text-gray-500">
          Question {currentIndex + 1} of {cards.length}
        </span>
        <span className="text-sm font-medium text-accent">Score: {score}</span>
      </div>

      <div className="mb-2 h-2 w-full overflow-hidden rounded-full bg-gray-200">
        <div
          className="h-full rounded-full bg-primary transition-all duration-300"
          style={{
            width: `${((currentIndex + 1) / cards.length) * 100}%`,
          }}
        />
      </div>

      <div className="mt-6 rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
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

      <button
        onClick={onExit}
        className="mt-4 text-sm text-gray-500 hover:text-gray-700"
      >
        Exit Quiz Mode
      </button>
    </div>
  );
}
