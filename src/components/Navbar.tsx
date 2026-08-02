"use client";

import Link from "next/link";
import { useAuth } from "@/lib/auth-context";
import { BookOpen, Plus, Search, LogOut, LayoutDashboard, Home, User, Zap } from "lucide-react";

export default function Navbar() {
  const { user, signOut } = useAuth();

  return (
    <nav className="border-b border-gray-200 bg-white">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="flex h-16 items-center justify-between">
          <Link href="/" className="flex items-center gap-2">
            <BookOpen className="h-7 w-7 text-primary" />
            <span className="text-xl font-bold text-gray-900">
              Study<span className="text-primary">Swap</span>
            </span>
          </Link>

          <div className="hidden sm:flex items-center gap-4">
            <Link
              href={user ? "/home" : "/"}
              className="flex items-center gap-1.5 rounded-lg px-3 py-2 text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors"
            >
              <Home className="h-4 w-4" />
              Home
            </Link>
            <Link
              href="/explore"
              className="flex items-center gap-1.5 rounded-lg px-3 py-2 text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors"
            >
              <Search className="h-4 w-4" />
              Explore
            </Link>

            {user ? (
              <>
                <Link
                  href="/dashboard"
                  className="flex items-center gap-1.5 rounded-lg px-3 py-2 text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors"
                >
                  <LayoutDashboard className="h-4 w-4" />
                  Dashboard
                </Link>
                <Link
                  href="/test"
                  className="flex items-center gap-1.5 rounded-lg px-3 py-2 text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors"
                >
                  <Zap className="h-4 w-4" />
                  Test
                </Link>
                <Link
                  href="/create"
                  className="flex items-center gap-1.5 rounded-lg bg-primary px-3 py-2 text-sm font-medium text-white hover:bg-primary-hover transition-colors"
                >
                  <Plus className="h-4 w-4" />
                  Create
                </Link>
                <Link
                  href="/profile"
                  className="flex items-center gap-1.5 rounded-lg px-3 py-2 text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors"
                >
                  <User className="h-4 w-4" />
                </Link>
                <button
                  onClick={signOut}
                  className="flex items-center gap-1.5 rounded-lg px-3 py-2 text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors"
                >
                  <LogOut className="h-4 w-4" />
                </button>
              </>
            ) : (
              <>
                <Link
                  href="/login"
                  className="rounded-lg px-3 py-2 text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors"
                >
                  Log in
                </Link>
                <Link
                  href="/signup"
                  className="rounded-lg bg-primary px-4 py-2 text-sm font-medium text-white hover:bg-primary-hover transition-colors"
                >
                  Sign up
                </Link>
              </>
            )}
          </div>

          {/* Mobile menu */}
          <div className="flex sm:hidden items-center gap-2">
            {user ? (
              <>
                <Link href="/home" className="rounded-lg p-2 text-gray-600 hover:bg-gray-100">
                  <Home className="h-5 w-5" />
                </Link>
                <Link href="/dashboard" className="rounded-lg p-2 text-gray-600 hover:bg-gray-100">
                  <LayoutDashboard className="h-5 w-5" />
                </Link>
                <Link href="/test" className="rounded-lg p-2 text-gray-600 hover:bg-gray-100">
                  <Zap className="h-5 w-5" />
                </Link>
                <Link href="/create" className="rounded-lg bg-primary p-2 text-white hover:bg-primary-hover">
                  <Plus className="h-5 w-5" />
                </Link>
                <Link href="/profile" className="rounded-lg p-2 text-gray-600 hover:bg-gray-100">
                  <User className="h-5 w-5" />
                </Link>
                <button onClick={signOut} className="rounded-lg p-2 text-gray-600 hover:bg-gray-100">
                  <LogOut className="h-5 w-5" />
                </button>
              </>
            ) : (
              <>
                <Link href="/login" className="rounded-lg px-3 py-1.5 text-sm font-medium text-gray-600 hover:bg-gray-100">
                  Login
                </Link>
                <Link href="/signup" className="rounded-lg bg-primary px-3 py-1.5 text-sm font-medium text-white hover:bg-primary-hover">
                  Sign up
                </Link>
              </>
            )}
          </div>
        </div>
      </div>
    </nav>
  );
}
