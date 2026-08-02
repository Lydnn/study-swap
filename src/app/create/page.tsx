"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { useAuth } from "@/lib/auth-context";
import { SUBJECTS } from "@/types";
import { Plus, Trash2, BookOpen, FileText, Sparkles, Globe, Lock } from "lucide-react";
import { Subject } from "@/types";

interface CardInput {
  front: string;
  back: string;
}

export default function CreatePage() {
  const { user } = useAuth();
  const router = useRouter();
  const supabase = createClient();
  const [mode, setMode] = useState<"deck" | "guide" | "ai">("deck");
  const [title, setTitle] = useState("");
  const [subject, setSubject] = useState<Subject>(SUBJECTS[0]);
  const [description, setDescription] = useState("");
  const [cards, setCards] = useState<CardInput[]>([
    { front: "", back: "" },
    { front: "", back: "" },
  ]);
  const [guideContent, setGuideContent] = useState("");
  const [aiNotes, setAiNotes] = useState("");
  const [aiCardCount, setAiCardCount] = useState(20);
  const [aiLoading, setAiLoading] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [isPublic, setIsPublic] = useState(true);

  const handleGenerate = async () => {
    if (!aiNotes.trim()) {
      setError("Paste some notes first.");
      return;
    }
    setAiLoading(true);
    setError("");
    try {
      const res = await fetch("/api/generate-deck", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          text: aiNotes,
          subject,
          cardCount: aiCardCount,
        }),
      });
      const data = await res.json();
      if (!res.ok) {
        setError(data.error || "Generation failed.");
        return;
      }
      if (!title.trim()) {
        setTitle(`AI Deck - ${subject}`);
      }
      setCards(data.cards);
      setMode("deck");
    } catch {
      setError("Network error. Please try again.");
    } finally {
      setAiLoading(false);
    }
  };

  const addCard = () => {
    setCards([...cards, { front: "", back: "" }]);
  };

  const removeCard = (index: number) => {
    if (cards.length <= 2) return;
    setCards(cards.filter((_, i) => i !== index));
  };

  const updateCard = (
    index: number,
    field: "front" | "back",
    value: string
  ) => {
    const updated = [...cards];
    updated[index][field] = value;
    setCards(updated);
  };

  const handleCreateDeck = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) return;
    setLoading(true);
    setError("");

    const { data: existingProfile } = await supabase
      .from("profiles")
      .select("id")
      .eq("id", user.id)
      .single();

    if (!existingProfile) {
      const { error: profileError } = await supabase.from("profiles").insert({
        id: user.id,
        username: user.email?.split("@")[0] ?? "user",
        full_name: user.user_metadata?.full_name ?? null,
        age: user.user_metadata?.age ?? null,
        year_group: user.user_metadata?.year_group ?? null,
        preferred_subjects: user.user_metadata?.preferred_subjects ?? [],
      });
      if (profileError) {
        setError(profileError.message);
        setLoading(false);
        return;
      }
    }

    const validCards = cards.filter((c) => c.front.trim() && c.back.trim());
    if (validCards.length === 0) {
      setError("Add at least 2 cards with content.");
      setLoading(false);
      return;
    }

    const { data: deck, error: deckError } = await supabase
      .from("decks")
      .insert({
        user_id: user.id,
        title,
        description: description || null,
        subject,
        card_count: validCards.length,
        is_public: isPublic,
      })
      .select()
      .single();

    if (deckError) {
      setError(deckError.message);
      setLoading(false);
      return;
    }

    const cardInserts = validCards.map((card, i) => ({
      deck_id: deck.id,
      front: card.front,
      back: card.back,
      position: i,
    }));

    const { error: cardsError } = await supabase.from("cards").insert(cardInserts);

    if (cardsError) {
      setError(cardsError.message);
      setLoading(false);
      return;
    }

    router.push(`/study/${deck.id}`);
  };

  const handleCreateGuide = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) return;
    setLoading(true);
    setError("");

    const { data: existingProfile } = await supabase
      .from("profiles")
      .select("id")
      .eq("id", user.id)
      .single();

    if (!existingProfile) {
      const { error: profileError } = await supabase.from("profiles").insert({
        id: user.id,
        username: user.email?.split("@")[0] ?? "user",
        full_name: user.user_metadata?.full_name ?? null,
        age: user.user_metadata?.age ?? null,
        year_group: user.user_metadata?.year_group ?? null,
        preferred_subjects: user.user_metadata?.preferred_subjects ?? [],
      });
      if (profileError) {
        setError(profileError.message);
        setLoading(false);
        return;
      }
    }

    if (!guideContent.trim()) {
      setError("Please add some content to your study guide.");
      setLoading(false);
      return;
    }

    const { error: guideError } = await supabase.from("study_guides").insert({
      user_id: user.id,
      title,
      subject,
      content: guideContent,
      is_public: isPublic,
    });

    if (guideError) {
      setError(guideError.message);
      setLoading(false);
      return;
    }

    router.push("/dashboard");
  };

  if (!user) {
    return (
      <div className="flex min-h-[50vh] items-center justify-center">
        <p className="text-gray-500">Please log in to create content.</p>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-3xl px-4 py-8 sm:px-6 lg:px-8">
      <h1 className="text-2xl font-bold text-gray-900">Create New</h1>
      <p className="mt-1 text-sm text-gray-500">
        Build a flashcard deck or upload a study guide
      </p>

      <div className="mt-6 flex gap-1 rounded-lg border border-gray-200 bg-white p-1 w-fit">
        <button
          onClick={() => setMode("deck")}
          className={`flex items-center gap-1.5 rounded-md px-4 py-2 text-sm font-medium transition-colors ${
            mode === "deck"
              ? "bg-primary text-white"
              : "text-gray-600 hover:bg-gray-100"
          }`}
        >
          <BookOpen className="h-4 w-4" />
          Flashcard Deck
        </button>
        <button
          onClick={() => setMode("guide")}
          className={`flex items-center gap-1.5 rounded-md px-4 py-2 text-sm font-medium transition-colors ${
            mode === "guide"
              ? "bg-primary text-white"
              : "text-gray-600 hover:bg-gray-100"
          }`}
        >
          <FileText className="h-4 w-4" />
          Study Guide
        </button>
        <button
          onClick={() => setMode("ai")}
          className={`flex items-center gap-1.5 rounded-md px-4 py-2 text-sm font-medium transition-colors ${
            mode === "ai"
              ? "bg-primary text-white"
              : "text-gray-600 hover:bg-gray-100"
          }`}
        >
          <Sparkles className="h-4 w-4" />
          AI Deck Generator
        </button>
      </div>

      {mode === "ai" && (
        <div className="mt-6 rounded-xl border border-gray-200 bg-white p-6 shadow-sm space-y-4">
          <div>
            <h2 className="text-lg font-semibold text-gray-900">
              Generate Flashcards from Notes
            </h2>
            <p className="mt-1 text-sm text-gray-500">
              Paste your study notes below and AI will turn them into flashcards
              for you to review before saving.
            </p>
          </div>

          {error && (
            <div className="rounded-lg bg-red-50 p-3 text-sm text-red-600">
              {error}
            </div>
          )}

          <div>
            <label className="block text-sm font-medium text-gray-700">
              Your Notes
            </label>
            <textarea
              value={aiNotes}
              onChange={(e) => setAiNotes(e.target.value)}
              rows={12}
              className="mt-1 block w-full rounded-lg border border-gray-300 bg-white px-3 py-2 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary resize-none font-mono"
              placeholder="Paste your notes here - a chapter, a Wikipedia page, your revision notes..."
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">
              Number of Cards
            </label>
            <input
              type="number"
              min={5}
              max={30}
              value={aiCardCount}
              onChange={(e) => setAiCardCount(Number(e.target.value))}
              className="mt-1 block w-32 rounded-lg border border-gray-300 bg-white px-3 py-2 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
            />
          </div>

          <button
            type="button"
            onClick={handleGenerate}
            disabled={aiLoading}
            className="flex items-center justify-center gap-2 w-full rounded-xl bg-primary px-4 py-3 text-base font-semibold text-white hover:bg-primary-hover disabled:opacity-50 transition-colors"
          >
            <Sparkles className="h-5 w-5" />
            {aiLoading ? "Generating..." : `Generate ${aiCardCount} Cards`}
          </button>
        </div>
      )}

      {mode !== "ai" && (
        <form
          onSubmit={mode === "deck" ? handleCreateDeck : handleCreateGuide}
        className="mt-6 space-y-6"
      >
        {error && (
          <div className="rounded-lg bg-red-50 p-3 text-sm text-red-600">
            {error}
          </div>
        )}

        <div className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">
              Title
            </label>
            <input
              type="text"
              required
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              className="mt-1 block w-full rounded-lg border border-gray-300 bg-white px-3 py-2.5 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
              placeholder={mode === "deck" ? "Biology 101 - Chapter 5" : "My History Notes"}
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">
              Subject
            </label>
            <select
              value={subject}
              onChange={(e) => setSubject(e.target.value as Subject)}
              className="mt-1 block w-full rounded-lg border border-gray-300 bg-white px-3 py-2.5 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
            >
              {SUBJECTS.map((s) => (
                <option key={s} value={s}>
                  {s}
                </option>
              ))}
            </select>
          </div>

          {mode === "deck" && (
            <div>
              <label className="block text-sm font-medium text-gray-700">
                Description (optional)
              </label>
              <input
                type="text"
                value={description}
                onChange={(e) => setDescription(e.target.value)}
                className="mt-1 block w-full rounded-lg border border-gray-300 bg-white px-3 py-2.5 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
                placeholder="A brief description of this deck"
              />
            </div>
          )}

          {/* Visibility */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Visibility
            </label>
            <div className="flex gap-3">
              <button
                type="button"
                onClick={() => setIsPublic(true)}
                className={`flex-1 flex items-center gap-2 rounded-lg border p-3 text-left text-sm transition-all ${
                  isPublic
                    ? "border-primary bg-primary/5 text-primary font-medium"
                    : "border-gray-200 bg-white text-gray-600 hover:bg-gray-50"
                }`}
              >
                <Globe className="h-4 w-4" />
                <div>
                  <span className="block font-medium">Public</span>
                  <span className="text-xs text-gray-400">Everyone can see</span>
                </div>
              </button>
              <button
                type="button"
                onClick={() => setIsPublic(false)}
                className={`flex-1 flex items-center gap-2 rounded-lg border p-3 text-left text-sm transition-all ${
                  !isPublic
                    ? "border-primary bg-primary/5 text-primary font-medium"
                    : "border-gray-200 bg-white text-gray-600 hover:bg-gray-50"
                }`}
              >
                <Lock className="h-4 w-4" />
                <div>
                  <span className="block font-medium">Private</span>
                  <span className="text-xs text-gray-400">Only you can see</span>
                </div>
              </button>
            </div>
          </div>
        </div>

        {mode === "deck" && (
          <div className="space-y-3">
            <div className="flex items-center justify-between">
              <h2 className="text-lg font-semibold text-gray-900">
                Cards ({cards.length})
              </h2>
              <button
                type="button"
                onClick={addCard}
                className="flex items-center gap-1 rounded-lg border border-gray-300 bg-white px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
              >
                <Plus className="h-4 w-4" />
                Add Card
              </button>
            </div>

            {cards.map((card, index) => (
              <div
                key={index}
                className="rounded-xl border border-gray-200 bg-white p-4 shadow-sm"
              >
                <div className="flex items-center justify-between mb-2">
                  <span className="text-sm font-medium text-gray-500">
                    Card {index + 1}
                  </span>
                  {cards.length > 2 && (
                    <button
                      type="button"
                      onClick={() => removeCard(index)}
                      className="rounded p-1 text-gray-400 hover:bg-red-50 hover:text-red-500"
                    >
                      <Trash2 className="h-4 w-4" />
                    </button>
                  )}
                </div>
                <div className="grid gap-3 sm:grid-cols-2">
                  <div>
                    <label className="block text-xs font-medium text-gray-500 mb-1">
                      Front (Question/Term)
                    </label>
                    <textarea
                      value={card.front}
                      onChange={(e) =>
                        updateCard(index, "front", e.target.value)
                      }
                      rows={2}
                      className="block w-full rounded-lg border border-gray-300 bg-white px-3 py-2 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary resize-none"
                      placeholder="What is photosynthesis?"
                    />
                  </div>
                  <div>
                    <label className="block text-xs font-medium text-gray-500 mb-1">
                      Back (Answer/Definition)
                    </label>
                    <textarea
                      value={card.back}
                      onChange={(e) =>
                        updateCard(index, "back", e.target.value)
                      }
                      rows={2}
                      className="block w-full rounded-lg border border-gray-300 bg-white px-3 py-2 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary resize-none"
                      placeholder="The process by which plants convert sunlight into energy"
                    />
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}

        {mode === "guide" && (
          <div className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Guide Content
            </label>
            <textarea
              value={guideContent}
              onChange={(e) => setGuideContent(e.target.value)}
              rows={16}
              className="block w-full rounded-lg border border-gray-300 bg-white px-3 py-2 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary resize-none font-mono"
              placeholder="Chapter 1: Introduction&#10;&#10;Key Concepts:&#10;- Concept 1: Description...&#10;- Concept 2: Description...&#10;&#10;Important Formulas:&#10;- Formula 1..."
            />
            <p className="mt-2 text-xs text-gray-400">
              Use markdown-style formatting. Each section can represent a chapter
              or topic.
            </p>
          </div>
        )}

        <button
          type="submit"
          disabled={loading}
          className="w-full rounded-xl bg-primary px-4 py-3 text-base font-semibold text-white hover:bg-primary-hover disabled:opacity-50 transition-colors"
        >
          {loading
            ? "Creating..."
            : mode === "deck"
            ? "Create Deck"
            : "Publish Study Guide"}
        </button>
        </form>
      )}
    </div>
  );
}
