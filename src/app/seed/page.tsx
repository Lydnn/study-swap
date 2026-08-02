export const dynamic = "force-dynamic";

import NextDynamic from "next/dynamic";

const SeedContent = NextDynamic(() => import("./seed-content"), { ssr: false });

export default function SeedPage() {
  return <SeedContent />;
}
