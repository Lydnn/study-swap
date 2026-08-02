"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { useAuth } from "@/lib/auth-context";
import { createClient } from "@/lib/supabase/client";
import { YEAR_GROUPS, YEAR_LABELS, SUBJECTS } from "@/types";
import { Mail, Save, ArrowLeft, Check } from "lucide-react";

export default function ProfilePage() {
  const { user, signOut } = useAuth();
  const router = useRouter();
  const supabase = createClient();
  const [fullName, setFullName] = useState("");
  const [username, setUsername] = useState("");
  const [age, setAge] = useState("");
  const [yearGroup, setYearGroup] = useState<number>(7);
  const [selectedSubjects, setSelectedSubjects] = useState<string[]>([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState("");
  const [saved, setSaved] = useState(false);

  useEffect(() => {
    if (!user) return;
    const fetchProfile = async () => {
      const { data } = await supabase
        .from("profiles")
        .select("*")
        .eq("id", user.id)
        .single();
      if (data) {
        setFullName(data.full_name ?? "");
        setUsername(data.username ?? "");
        setAge(data.age?.toString() ?? "");
        setYearGroup(data.year_group ?? 7);
        setSelectedSubjects(data.preferred_subjects ?? []);
      }
      setLoading(false);
    };
    fetchProfile();
  }, [user, supabase]);

  const toggleSubject = (subject: string) => {
    setSelectedSubjects((prev) =>
      prev.includes(subject)
        ? prev.filter((s) => s !== subject)
        : [...prev, subject]
    );
  };

  const handleSave = async () => {
    if (!user) return;
    setSaving(true);
    setError("");
    setSaved(false);

    const { error: updateError } = await supabase
      .from("profiles")
      .upsert({
        id: user.id,
        full_name: fullName || null,
        username,
        age: parseInt(age) || null,
        year_group: yearGroup,
        preferred_subjects: selectedSubjects,
      }, { onConflict: "id" });

    if (updateError) {
      setError(updateError.message);
    } else {
      setSaved(true);
      setTimeout(() => setSaved(false), 3000);
    }
    setSaving(false);
  };

  if (!user) {
    return (
      <div className="flex min-h-[50vh] items-center justify-center">
        <p className="text-gray-500">Please log in to view your profile.</p>
      </div>
    );
  }

  if (loading) {
    return (
      <div className="flex min-h-[50vh] items-center justify-center">
        <p className="text-gray-500">Loading profile...</p>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-2xl px-4 py-8 sm:px-6 lg:px-8">
      <button
        onClick={() => router.back()}
        className="flex items-center gap-1 text-sm font-medium text-gray-500 hover:text-gray-900 transition-colors mb-6"
      >
        <ArrowLeft className="h-4 w-4" />
        Back
      </button>

      <h1 className="text-2xl font-bold text-gray-900">Your Profile</h1>
      <p className="mt-1 text-sm text-gray-500">
        Manage your account details and study preferences
      </p>

      {error && (
        <div className="mt-4 rounded-lg bg-red-50 p-3 text-sm text-red-600">
          {error}
        </div>
      )}

      {saved && (
        <div className="mt-4 rounded-lg bg-green-50 p-3 text-sm text-green-600">
          Profile saved successfully!
        </div>
      )}

      <div className="mt-6 space-y-6">
        {/* Account Info */}
        <div className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">
            Account Details
          </h2>

          <div className="space-y-4">
            <div className="flex items-center gap-3 rounded-lg bg-gray-50 px-4 py-3">
              <Mail className="h-5 w-5 text-gray-400" />
              <div>
                <p className="text-xs text-gray-400">Email</p>
                <p className="text-sm font-medium text-gray-700">
                  {user.email}
                </p>
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700">
                Full Name
              </label>
              <input
                type="text"
                value={fullName}
                onChange={(e) => setFullName(e.target.value)}
                className="mt-1 block w-full rounded-lg border border-gray-300 bg-white px-3 py-2.5 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
                placeholder="John Smith"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700">
                Username
              </label>
              <input
                type="text"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                className="mt-1 block w-full rounded-lg border border-gray-300 bg-white px-3 py-2.5 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
                placeholder="johnsmith42"
              />
            </div>
          </div>
        </div>

        {/* School Details */}
        <div className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">
            School Details
          </h2>

          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700">
                Age
              </label>
              <input
                type="number"
                min={10}
                max={20}
                value={age}
                onChange={(e) => setAge(e.target.value)}
                className="mt-1 block w-full rounded-lg border border-gray-300 bg-white px-3 py-2.5 text-sm shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
                placeholder="e.g. 14"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Year Group
              </label>
              <div className="grid grid-cols-2 gap-2">
                {YEAR_GROUPS.map((yr) => (
                  <button
                    key={yr}
                    type="button"
                    onClick={() => setYearGroup(yr)}
                    className={`rounded-lg border p-3 text-left text-sm transition-all ${
                      yearGroup === yr
                        ? "border-primary bg-primary/5 text-primary font-medium"
                        : "border-gray-200 bg-white text-gray-600 hover:bg-gray-50"
                    }`}
                  >
                    {YEAR_LABELS[yr]}
                  </button>
                ))}
              </div>
            </div>
          </div>
        </div>

        {/* Subjects */}
        <div className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm">
          <h2 className="text-lg font-semibold text-gray-900 mb-2">
            Preferred Subjects
          </h2>
          <p className="text-sm text-gray-500 mb-4">
            These help personalise your experience
          </p>

          <div className="flex flex-wrap gap-2">
            {SUBJECTS.map((subject) => (
              <button
                key={subject}
                type="button"
                onClick={() => toggleSubject(subject)}
                className={`rounded-full border px-3.5 py-1.5 text-sm font-medium transition-all ${
                  selectedSubjects.includes(subject)
                    ? "border-primary bg-primary text-white"
                    : "border-gray-200 bg-white text-gray-600 hover:bg-gray-50"
                }`}
              >
                {subject}
              </button>
            ))}
          </div>
        </div>

        {/* Save */}
        <div className="flex items-center gap-4">
          <button
            onClick={handleSave}
            disabled={saving}
            className="flex items-center gap-2 rounded-xl bg-primary px-6 py-3 text-base font-semibold text-white hover:bg-primary-hover disabled:opacity-50 transition-colors"
          >
            {saving ? "Saving..." : saved ? (
              <>
                <Check className="h-5 w-5" />
                Saved!
              </>
            ) : (
              <>
                <Save className="h-5 w-5" />
                Save Changes
              </>
            )}
          </button>

          <button
            onClick={signOut}
            className="rounded-xl border border-gray-300 px-6 py-3 text-base font-medium text-gray-600 hover:bg-gray-50 transition-colors"
          >
            Sign Out
          </button>
        </div>
      </div>
    </div>
  );
}
