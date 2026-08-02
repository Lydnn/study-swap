import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

export const runtime = "nodejs";

interface GenerateDeckRequest {
  text: string;
  subject: string;
  cardCount?: number;
}

interface GeneratedCard {
  front: string;
  back: string;
}

function extractJson(text: string): GeneratedCard[] | null {
  const fenced = text.match(/```(?:json)?\s*([\s\S]*?)```/);
  const raw = fenced ? fenced[1] : text;
  try {
    const parsed = JSON.parse(raw);
    const cards = Array.isArray(parsed) ? parsed : parsed.cards;
    if (!Array.isArray(cards)) return null;
    return cards
      .map((c) => ({ front: String(c.front ?? "").trim(), back: String(c.back ?? "").trim() }))
      .filter((c) => c.front && c.back);
  } catch {
    return null;
  }
}

export async function POST(request: Request) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
  }

  const apiKey = process.env.OPENROUTER_API_KEY;
  if (!apiKey) {
    return NextResponse.json(
      { error: "OPENROUTER_API_KEY is not configured on the server." },
      { status: 500 }
    );
  }

  let body: GenerateDeckRequest;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: "Invalid JSON body" }, { status: 400 });
  }

  const text = (body.text ?? "").trim();
  const subject = (body.subject ?? "").trim() || "general";
  if (!text) {
    return NextResponse.json({ error: "No text provided." }, { status: 400 });
  }
  const cardCount = Math.min(Math.max(body.cardCount ?? 20, 5), 30);

  const prompt = `You are a flashcard generator for UK school students (Key Stage 3, GCSE, and A-Level).
From the notes below, create exactly ${cardCount} concise question-and-answer flashcards.
The subject is: ${subject}.
- Front = a short question or term. Back = a clear, accurate answer or definition (1-2 sentences).
- Cover the most important concepts in the notes. Do not invent facts that are not in the notes.
- Return ONLY valid JSON, no commentary, in this exact shape:
{"cards":[{"front":"...","back":"..."}]}

Notes:
${text.slice(0, 6000)}`;

  try {
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 60000);

    let res: Response | null = null;
    let lastError = "";

    for (let attempt = 0; attempt < 3; attempt++) {
      res = await fetch(
        "https://openrouter.ai/api/v1/chat/completions",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${apiKey}`,
            "X-Title": "StudySwap",
          },
          body: JSON.stringify({
            model: process.env.OPENROUTER_MODEL ?? "openrouter/free",
            messages: [{ role: "user", content: prompt }],
            temperature: 0.4,
          }),
          signal: controller.signal,
        }
      );

      if (res.status === 429) {
        lastError = await res.text();
        await new Promise((r) => setTimeout(r, 2000 * (attempt + 1)));
        continue;
      }

      break;
    }

    clearTimeout(timeout);

    if (!res || !res.ok) {
      const detail = lastError || (await res!.text());
      return NextResponse.json(
        { error: `OpenRouter API error (${res!.status}): ${detail.slice(0, 300)}` },
        { status: 502 }
      );
    }

    const data = await res.json();
    const modelText: string = data?.choices?.[0]?.message?.content ?? "";

    const cards = extractJson(modelText);
    if (!cards || cards.length === 0) {
      return NextResponse.json(
        { error: "The model did not return valid flashcards. Try again or shorten your notes." },
        { status: 502 }
      );
    }

    return NextResponse.json({ cards });
  } catch (err) {
    const message = err instanceof Error ? err.message : "Unknown error";
    if (message.includes("abort")) {
      return NextResponse.json({ error: "The request timed out. Try shorter notes." }, { status: 504 });
    }
    return NextResponse.json({ error: `Failed to reach OpenRouter: ${message}` }, { status: 502 });
  }
}
