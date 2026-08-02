import dynamic from "next/dynamic";

const SeedContent = dynamic(() => import("./seed-content"), { ssr: false });

export default function SeedPage() {
  return <SeedContent />;
}
