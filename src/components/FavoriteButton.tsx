"use client";

import { useState, useEffect } from "react";
import { createClient } from "@/lib/supabase/client";
import { User } from "@supabase/supabase-js";
import { Heart } from "lucide-react";

export default function FavoriteButton({
  deckId,
  user,
}: {
  deckId: string;
  user: User | null;
}) {
  const supabase = createClient();
  const [isFav, setIsFav] = useState(false);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!user) return;
    const check = async () => {
      const { data } = await supabase
        .from("favorites")
        .select("id")
        .eq("user_id", user.id)
        .eq("deck_id", deckId)
        .maybeSingle();
      if (data) setIsFav(true);
    };
    check();
  }, [user, deckId, supabase]);

  const toggle = async () => {
    if (!user || loading) return;
    setLoading(true);
    if (isFav) {
      await supabase
        .from("favorites")
        .delete()
        .eq("user_id", user.id)
        .eq("deck_id", deckId);
      setIsFav(false);
    } else {
      await supabase.from("favorites").insert({
        user_id: user.id,
        deck_id: deckId,
      });
      setIsFav(true);
    }
    setLoading(false);
  };

  if (!user) return null;

  return (
    <button
      onClick={(e) => {
        e.preventDefault();
        e.stopPropagation();
        toggle();
      }}
      disabled={loading}
      className={`rounded-lg p-1.5 transition-colors ${
        isFav
          ? "text-red-500 hover:bg-red-50"
          : "text-gray-400 hover:bg-gray-100 hover:text-red-400"
      }`}
      title={isFav ? "Remove from saved" : "Save deck"}
    >
      <Heart className={`h-4 w-4 ${isFav ? "fill-current" : ""}`} />
    </button>
  );
}
