"use client";

import { useEffect, useState } from "react";
import { useParams } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { useAuth } from "@/lib/auth-context";
import { Deck, Card } from "@/types";
import StudyPlayer from "@/components/StudyPlayer";
import { ArrowLeft, BookOpen, Pencil, Share2 } from "lucide-react";
import Link from "next/link";

export default function StudyPage() {
  const { id } = useParams<{ id: string }>();
  const { user } = useAuth();
  const supabase = createClient();
  const [deck, setDeck] = useState<Deck | null>(null);
  const [cards, setCards] = useState<Card[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchDeck = async () => {
      const [deckRes, cardsRes] = await Promise.all([
        supabase.from("decks").select("*").eq("id", id).single(),
        supabase
          .from("cards")
          .select("*")
          .eq("deck_id", id)
          .order("position"),
      ]);

      if (deckRes.data) setDeck(deckRes.data);
      if (cardsRes.data) setCards(cardsRes.data);
      setLoading(false);

      if (user && cardsRes.data && cardsRes.data.length > 0) {
        await supabase.from("recently_studied").upsert(
          {
            user_id: user.id,
            deck_id: id,
            total_cards: cardsRes.data.length,
            studied_at: new Date().toISOString(),
          },
          { onConflict: "user_id,deck_id" }
        );
      }
    };

    fetchDeck();
  }, [id, supabase, user]);

  if (loading) {
    return (
      <div className="flex min-h-[50vh] items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent" />
      </div>
    );
  }

  if (!deck) {
    return (
      <div className="flex min-h-[50vh] flex-col items-center justify-center gap-4">
        <p className="text-gray-500">Deck not found.</p>
        <Link href="/explore" className="text-sm text-primary hover:underline">
          Browse decks
        </Link>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-3xl px-4 py-8 sm:px-6 lg:px-8">
      <Link
        href="/explore"
        className="inline-flex items-center gap-1.5 text-sm text-gray-500 hover:text-gray-700 mb-6"
      >
        <ArrowLeft className="h-4 w-4" />
        Back to Explore
      </Link>

      <div className="mb-8 flex items-start gap-4">
        <div className="flex h-14 w-14 shrink-0 items-center justify-center rounded-xl bg-primary/10 text-primary">
          <BookOpen className="h-6 w-6" />
        </div>
        <div className="flex-1">
          <div className="flex items-start justify-between">
            <div>
              <h1 className="text-2xl font-bold text-gray-900">{deck.title}</h1>
              <p className="text-sm text-gray-500">
                {deck.subject} &middot; {deck.card_count} cards &middot;{" "}
                {deck.upvotes} upvotes
              </p>
            </div>
            <div className="flex items-center gap-2">
              {user?.id === deck.user_id && (
                <Link
                  href={`/deck/${id}/edit`}
                  className="flex items-center gap-1.5 rounded-lg border border-gray-300 bg-white px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
                >
                  <Pencil className="h-3.5 w-3.5" />
                  Edit
                </Link>
              )}
              <button
                onClick={() => {
                  navigator.clipboard.writeText(window.location.href);
                }}
                className="flex items-center gap-1.5 rounded-lg border border-gray-300 bg-white px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
              >
                <Share2 className="h-3.5 w-3.5" />
                Share
              </button>
            </div>
          </div>
          {deck.description && (
            <p className="mt-2 text-sm text-gray-600">{deck.description}</p>
          )}
        </div>
      </div>

      {cards.length === 0 ? (
        <div className="rounded-2xl border-2 border-dashed border-gray-300 p-12 text-center">
          <p className="text-gray-500">This deck has no cards yet.</p>
        </div>
      ) : (
        <StudyPlayer cards={cards} deckId={id} user={user ?? null} />
      )}
    </div>
  );
}
