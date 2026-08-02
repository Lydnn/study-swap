import Link from "next/link";
import { Search, BookOpen, Users, Brain, Home } from "lucide-react";

export default function HomePage() {
  return (
    <div className="flex flex-col">
      {/* Hero Section */}
      <section className="relative overflow-hidden bg-gradient-to-br from-primary/5 via-white to-accent/5 px-4 py-20 sm:px-6 lg:px-8">
        <div className="mx-auto max-w-4xl text-center">
          <h1 className="text-4xl font-bold tracking-tight text-gray-900 sm:text-6xl">
            Share. Study.{" "}
            <span className="text-primary">Succeed.</span>
          </h1>
          <p className="mx-auto mt-6 max-w-2xl text-lg text-gray-600">
            StudySwap is a peer-to-peer academic collaboration platform.
            Upload your flashcards, discover study guides, and ace your exams
            together.
          </p>

          <div className="mt-10 flex flex-col items-center gap-4 sm:flex-row sm:justify-center">
            <Link
              href="/home"
              className="inline-flex items-center gap-2 rounded-xl bg-primary px-6 py-3 text-base font-semibold text-white shadow-lg shadow-primary/25 hover:bg-primary-hover transition-all"
            >
              <Home className="h-5 w-5" />
              Go to Home
            </Link>
            <Link
              href="/explore"
              className="inline-flex items-center gap-2 rounded-xl border border-gray-300 bg-white px-6 py-3 text-base font-semibold text-gray-700 shadow-sm hover:bg-gray-50 transition-all"
            >
              <Search className="h-5 w-5" />
              Explore Decks
            </Link>
            <Link
              href="/signup"
              className="inline-flex items-center gap-2 rounded-xl border border-gray-300 bg-white px-6 py-3 text-base font-semibold text-gray-700 shadow-sm hover:bg-gray-50 transition-all"
            >
              Get Started Free
            </Link>
          </div>
        </div>
      </section>

      {/* Features */}
      <section className="px-4 py-20 sm:px-6 lg:px-8">
        <div className="mx-auto max-w-6xl">
          <h2 className="text-center text-3xl font-bold text-gray-900">
            Everything you need to study smarter
          </h2>
          <div className="mt-12 grid gap-8 sm:grid-cols-2 lg:grid-cols-3">
            <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10 text-primary">
                <BookOpen className="h-6 w-6" />
              </div>
              <h3 className="mt-4 text-lg font-semibold text-gray-900">
                Flashcard Decks
              </h3>
              <p className="mt-2 text-sm text-gray-600">
                Create and share flashcard decks on any subject. Flip through
                cards in Study Mode or test yourself with Quiz Mode.
              </p>
            </div>

            <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-accent/10 text-accent">
                <Brain className="h-6 w-6" />
              </div>
              <h3 className="mt-4 text-lg font-semibold text-gray-900">
                Study Guides
              </h3>
              <p className="mt-2 text-sm text-gray-600">
                Upload organized, chapter-by-chapter notes and study guides.
                Browse guides by subject to find exactly what you need.
              </p>
            </div>

            <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-purple-100 text-purple-600">
                <Users className="h-6 w-6" />
              </div>
              <h3 className="mt-4 text-lg font-semibold text-gray-900">
                Community Driven
              </h3>
              <p className="mt-2 text-sm text-gray-600">
                Upvote the best content. Search by subject, keyword, or tag to
                find high-quality study materials from fellow students.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="bg-gray-900 px-4 py-16 sm:px-6 lg:px-8">
        <div className="mx-auto max-w-4xl text-center">
          <h2 className="text-3xl font-bold text-white">
            Ready to level up your studying?
          </h2>
          <p className="mt-4 text-lg text-gray-400">
            Join students who are already using StudySwap to ace their exams.
          </p>
          <Link
            href="/signup"
            className="mt-8 inline-flex rounded-xl bg-primary px-8 py-3.5 text-base font-semibold text-white shadow-lg shadow-primary/25 hover:bg-primary-hover transition-all"
          >
            Start for Free
          </Link>
        </div>
      </section>
    </div>
  );
}
