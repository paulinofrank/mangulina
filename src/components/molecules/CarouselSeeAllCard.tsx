import { Link } from "@/i18n/navigation";

export default function CarouselSeeAllCard({ href, label }: { href: string; label: string }) {
  return (
    <Link href={href} prefetch={false} className="group block w-28 shrink-0 rounded-lg focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-[#002D62] sm:w-32 lg:w-36">
      <div className="flex aspect-square w-full items-center justify-center rounded-lg border border-[#002D62]/20 bg-[#002D62]/5 text-[#002D62] transition-colors group-hover:bg-[#002D62] group-hover:text-white">
        <svg aria-hidden="true" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5">
          <path strokeLinecap="round" strokeLinejoin="round" d="M4 12h16m-6-6 6 6-6 6" />
        </svg>
      </div>
      <div className="mt-3 truncate text-base font-normal leading-snug text-[#002D62]">{label}</div>
    </Link>
  );
}
