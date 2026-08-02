"use client";

import { useEffect, useState } from "react";
import { useParams } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { StudyGuide } from "@/types";
import Link from "next/link";
import { ArrowLeft, FileText, Printer, ChevronUp, ChevronDown } from "lucide-react";
import ReactMarkdown from "react-markdown";

export default function GuidePage() {
  const { id } = useParams<{ id: string }>();
  const supabase = createClient();
  const [guide, setGuide] = useState<StudyGuide | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchGuide = async () => {
      const { data } = await supabase
        .from("study_guides")
        .select("*")
        .eq("id", id)
        .single();
      if (data) setGuide(data);
      setLoading(false);
    };
    fetchGuide();
  }, [id, supabase]);

  const handleVote = async (value: -1 | 1) => {
    if (!guide) return;
    const column = value === 1 ? "upvotes" : "downvotes";
    await supabase
      .from("study_guides")
      .update({ [column]: guide[column] + 1 })
      .eq("id", guide.id);
    setGuide({ ...guide, [column]: guide[column] + 1 });
  };

  if (loading) {
    return (
      <div className="flex min-h-[50vh] items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent" />
      </div>
    );
  }

  if (!guide) {
    return (
      <div className="flex min-h-[50vh] flex-col items-center justify-center gap-4">
        <p className="text-gray-500">Study guide not found.</p>
        <Link href="/explore" className="text-sm text-primary hover:underline">
          Browse guides
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

      <div className="flex items-start gap-4 mb-8 no-print">
        <div className="flex h-14 w-14 shrink-0 items-center justify-center rounded-xl bg-accent/10 text-accent">
          <FileText className="h-6 w-6" />
        </div>
        <div className="flex-1">
          <h1 className="text-2xl font-bold text-gray-900">{guide.title}</h1>
          <p className="text-sm text-gray-500">
            {guide.subject}
            {guide.year_group && <> &middot; Year {guide.year_group}</>} &middot;{" "}
            {guide.upvotes - guide.downvotes} score
          </p>
        </div>
        <button
          onClick={() => window.print()}
          className="flex shrink-0 items-center gap-2 rounded-lg bg-primary px-4 py-2 text-sm font-medium text-white hover:bg-primary-hover transition-colors no-print"
        >
          <Printer className="h-4 w-4" />
          Download PDF
        </button>
      </div>

      <div className="mb-6 flex items-center gap-3 no-print">
        <div className="flex items-center gap-1">
          <button
            onClick={() => handleVote(1)}
            className="rounded p-1 text-gray-400 hover:bg-gray-100 hover:text-primary"
          >
            <ChevronUp className="h-5 w-5" />
          </button>
          <span className="text-sm font-semibold text-gray-700">
            {guide.upvotes - guide.downvotes}
          </span>
          <button
            onClick={() => handleVote(-1)}
            className="rounded p-1 text-gray-400 hover:bg-gray-100 hover:text-red-500"
          >
            <ChevronDown className="h-5 w-5" />
          </button>
        </div>
      </div>

      <article className="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm sm:p-8">
        <div className="prose prose-sm sm:prose-base max-w-none">
          <ReactMarkdown
            components={{
              h1: ({ children }) => (
                <h1 className="mt-8 mb-4 text-2xl font-bold text-gray-900 first:mt-0">
                  {children}
                </h1>
              ),
              h2: ({ children }) => (
                <h2 className="mt-8 mb-3 text-xl font-semibold text-gray-900">
                  {children}
                </h2>
              ),
              h3: ({ children }) => (
                <h3 className="mt-6 mb-2 text-lg font-semibold text-gray-800">
                  {children}
                </h3>
              ),
              p: ({ children }) => (
                <p className="mb-4 leading-relaxed text-gray-700">{children}</p>
              ),
              ul: ({ children }) => (
                <ul className="mb-4 list-disc space-y-1 pl-5 text-gray-700">
                  {children}
                </ul>
              ),
              ol: ({ children }) => (
                <ol className="mb-4 list-decimal space-y-1 pl-5 text-gray-700">
                  {children}
                </ol>
              ),
              li: ({ children }) => <li className="leading-relaxed">{children}</li>,
              strong: ({ children }) => (
                <strong className="font-semibold text-gray-900">{children}</strong>
              ),
              hr: () => <hr className="my-6 border-gray-200" />,
              table: ({ children }) => (
                <div className="my-4 overflow-x-auto">
                  <table className="w-full border-collapse text-sm">
                    {children}
                  </table>
                </div>
              ),
              th: ({ children }) => (
                <th className="border border-gray-200 bg-gray-50 px-3 py-2 text-left font-semibold">
                  {children}
                </th>
              ),
              td: ({ children }) => (
                <td className="border border-gray-200 px-3 py-2">{children}</td>
              ),
            }}
          >
            {guide.content}
          </ReactMarkdown>
        </div>
      </article>

      <div className="mt-8 no-print">
        <Link
          href="/explore"
          className="inline-flex items-center gap-1.5 text-sm text-gray-500 hover:text-gray-700"
        >
          <ArrowLeft className="h-4 w-4" />
          Back to Explore
        </Link>
      </div>
    </div>
  );
}
