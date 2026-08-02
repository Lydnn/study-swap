"use client";

import { useState, useEffect } from "react";
import { useRouter, useParams } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { useAuth } from "@/lib/auth-context";
import { SUBJECTS, Subject } from "@/types";
import { Plus, Trash2, ArrowLeft, Save, Globe, Lock } from "lucide-react";
import Link from "next/link";

interface CardInput {
  id?: string;
  front: string;
  back: string;
}

export default function EditDeckPage() {
  const { id } = useParams<{ id: string }>();
  const { user, loading: authLoading } = useAuth();
  const router = useRouter();
  const supabase = createClient();

  const [title, setTitle] = useState("");
  const [subject, setSubject] = useState<Subject>(SUBJECTS[0]);
  const [description, setDescription] = useState("");
  const [isPublic, setIsPublic] = useState(true);
  const [cards, setCards] = useState<CardInput[]>([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    if (!authLoading && !user) {
      router.push("/login");
      return;
    }

    const fetchDeck = async () => {
      const { data: deck } = await supabase
        .from("decks")
        .select("*")
        .eq("id", id)
        .single();

      if (!deck || deck.user_id !== user?.id) {
        router.push("/dashboard");
        return;
      }

      setTitle(deck.title);
      setSubject(deck.subject as Subject);
      setDescription(deck.description ?? "");
      setIsPublic(deck.is_public);

      const { data: cardData } = await supabase
        .from("cards")
        .select("*")
        .eq("deck_id", id)
        .order("position");

      if (cardData) {
        setCards(cardData.map((c) => ({ id: c.id, front: c.front, back: c.back })));
      }

      setLoading(false);
    };

    if (user) fetchDeck();
  }, [id, user, authLoading, router, supabase]);

  const addCard = () => setCards([...cards, { front: "", back: "" }]);

  const removeCard = (index: number) => {
    if (cards.length <= 2) return;
    setCards(cards.filter((_, i) => i !== index));
  };

  const updateCard = (index: number, field: "front" | "back", value: string) => {
    const updated = [...cards];
    updated[index][field] = value;
    setCards(updated);
  };

  const handleSave = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) return;
    setSaving(true);
    setError("");

    const validCards = cards.filter((c) => c.front.trim() && c.back.trim());
    if (validCards.length === 0) {
      setError("Add at least 2 cards with content.");
      setSaving(false);
      return;
    }

    const { error: deckError } = await supabase
      .from("decks")
      .update({
        title,
        description: description || null,
        subject,
        is_public: isPublic,
        card_count: validCards.length,
        updated_at: new Date().toISOString(),
      })
      .eq("id", id);

    if (deckError) {
      setError(deckError.message);
      setSaving(false);
      return;
    }

    await supabase.from("cards").delete().eq("deck_id", id);

    const cardInserts = validCards.map((card, i) => ({
      deck_id: id,
      front: card.front,
      back: card.back,
      position: i,
    }));

    const { error: cardsError } = await supabase.from("cards").insert(cardInserts);

    if (cardsError) {
      setError(cardsError.message);
      setSaving(false);
      return;
    }

    router.push(`/study/${id}`);
  };

  if (authLoading || loading) {
    return (
      <div className="flex min-h-[50vh] items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent" />
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-3xl px-4 py-8 sm:px-6 lg:px-8">
      <Link
        href={`/study/${id}`}
        className="inline-flex items-center gap-1.5 text-sm text-gray-500 hover:text-gray-700 mb-6"
      >
        <ArrowLeft className="h-4 w-4" />
        Back to Deck
      </Link>

      <h1 className="text-2xl font-bold text-gray-900 mb-6">Edit Deck</h1>

      {error && (
        <div className="mb-4 rounded-lg bg-red-50 p-3 text-sm text-red-600">
          {error}
        </div>
      )}

      <form onSubmit={handleSave} className="space-y-6">
        <div className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">Title</label>
            <input
              type="text"
              required
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              className="mt-1 block w-full rounded-lg border border-gray-300 px-3 py-2.5 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">Subject</label>
            <select
              value={subject}
              onChange={(e) => setSubject(e.target.value as Subject)}
              className="mt-1 block w-full rounded-lg border border-gray-300 px-3 py-2.5 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
            >
              {SUBJECTS.map((s) => (
                <option key={s} value={s}>{s}</option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">Description (optional)</label>
            <input
              type="text"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              className="mt-1 block w-full rounded-lg border border-gray-300 px-3 py-2.5 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">Visibility</label>
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

        <div className="space-y-3">
          <div className="flex items-center justify-between">
            <h2 className="text-lg font-semibold text-gray-900">Cards ({cards.length})</h2>
            <button
              type="button"
              onClick={addCard}
              className="flex items-center gap-1 rounded-lg border border-gray-300 bg-white px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
            >
              <Plus className="h-4 w-4" />
              Add Card
            </button>
          </div>

          {cards.map((card, i) => (
            <div
              key={i}
              className="rounded-xl border border-gray-200 bg-white p-4 shadow-sm"
            >
              <div className="flex items-center justify-between mb-2">
                <span className="text-xs font-medium text-gray-400">Card {i + 1}</span>
                <button
                  type="button"
                  onClick={() => removeCard(i)}
                  disabled={cards.length <= 2}
                  className="text-gray-400 hover:text-red-500 disabled:opacity-30 transition-colors"
                >
                  <Trash2 className="h-4 w-4" />
                </button>
              </div>
              <div className="grid grid-cols-2 gap-3">
                <input
                  type="text"
                  placeholder="Front (question)"
                  value={card.front}
                  onChange={(e) => updateCard(i, "front", e.target.value)}
                  className="rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
                />
                <input
                  type="text"
                  placeholder="Back (answer)"
                  value={card.back}
                  onChange={(e) => updateCard(i, "back", e.target.value)}
                  className="rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
                />
              </div>
            </div>
          ))}
        </div>

        <button
          type="submit"
          disabled={saving}
          className="w-full flex items-center justify-center gap-2 rounded-xl bg-primary px-4 py-3 text-base font-semibold text-white hover:bg-primary-hover disabled:opacity-50 transition-colors"
        >
          <Save className="h-5 w-5" />
          {saving ? "Saving..." : "Save Changes"}
        </button>
      </form>
    </div>
  );
}
