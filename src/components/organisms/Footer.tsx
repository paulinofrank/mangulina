"use client";

import Image from "next/image";
import Link from "next/link";
import { useTranslations } from "next-intl";
import { usePathname } from "next/navigation";
import { FaFacebook, FaInstagram, FaYoutube, FaTiktok } from "react-icons/fa6";
import {
  addSpanishPrefix,
  getAlternateLocalePath,
  getLocaleFromPathname,
} from "@/i18n/pathname";
import { saveLocalePreference } from "@/i18n/preference";

export default function Footer() {
  const t = useTranslations("footer");
  const nav = useTranslations("navigation");
  const pathname = usePathname();
  const locale = getLocaleFromPathname(pathname);
  const alternateLocale = locale === "en" ? "es" : "en";
  const alternateLocalePath = getAlternateLocalePath(pathname);
  const localizeHref = (href: string) =>
    locale === "es" ? addSpanishPrefix(href) : href;

  const SOCIAL_LINKS = [
    { icon: FaFacebook, key: "facebook", href: "https://facebook.com/MangulinaDo" },
    { icon: FaInstagram, key: "instagram", href: "https://instagram.com/MangulinaDo" },
    { icon: FaYoutube, key: "youtube", href: "https://youtube.com/@MangulinaDo" },
    { icon: FaTiktok, key: "tiktok", href: "https://tiktok.com/@MangulinaDo" },
  ];

  return (
    <footer className="mt-2 border-t border-black/10 bg-white/50">
      <div className="mx-5 pb-32 pt-8 sm:mx-8 sm:pb-28 sm:pt-10 lg:mx-12">
        <div className="flex flex-col gap-7 sm:gap-6">

          {/* Social Icons */}
          <div className="flex items-center justify-center gap-3">
            {SOCIAL_LINKS.map(({ icon: Icon, key, href }) => (
              <a
                key={key}
                href={href}
                target="_blank"
                rel="noopener noreferrer"
                aria-label={t(`social.${key}`)}
                className="flex h-10 w-10 items-center justify-center rounded-full border border-black/10 bg-white/70 text-gray-600 transition-colors hover:text-[#002D62] hover:border-black/20"
              >
                <Icon className="h-5 w-5" />
              </a>
            ))}
          </div>

          {/* Navigation */}
          <nav aria-label="Footer navigation" className="text-sm font-normal text-gray-600 sm:text-base">
            <div className="grid grid-cols-2 gap-x-6 sm:hidden">
              <div className="flex flex-col gap-3 pl-[5ch]">
                <Link href={localizeHref("/discover")} className="transition-colors hover:text-[#002D62]">{nav("discover")}</Link>
                <Link
                  href={alternateLocalePath}
                  onClick={() => saveLocalePreference(alternateLocale)}
                  className="text-left transition-colors hover:text-[#002D62]"
                >
                  {locale === "en" ? t("languageSwitchToSpanish") : t("languageSwitchToEnglish")}
                </Link>
                <Link href={localizeHref("/about")} className="transition-colors hover:text-[#002D62]">{nav("about")}</Link>
                <Link href={localizeHref("/contact")} className="transition-colors hover:text-[#002D62]">{nav("contact")}</Link>
              </div>
              <div className="flex flex-col gap-3">
                <Link href={localizeHref("/contributors")} className="transition-colors hover:text-[#002D62]">{nav("contributors")}</Link>
                <Link href={localizeHref("/terms-of-use")} className="transition-colors hover:text-[#002D62]">{nav("termsOfUse")}</Link>
                <Link href={localizeHref("/privacy-policy")} className="transition-colors hover:text-[#002D62]">{nav("privacyPolicy")}</Link>
                <Link href={localizeHref("/dmca")} className="transition-colors hover:text-[#002D62]">{nav("copyrights")}</Link>
              </div>
            </div>

            <div className="hidden sm:flex flex-wrap justify-center gap-x-6 gap-y-2">
              <Link href={localizeHref("/discover")} className="transition-colors hover:text-[#002D62]">{nav("discover")}</Link>
              <Link href={localizeHref("/releases")} className="transition-colors hover:text-[#002D62]">{nav("releases")}</Link>
              <Link href={localizeHref("/about")} className="transition-colors hover:text-[#002D62]">{nav("about")}</Link>
              <Link href={localizeHref("/contact")} className="transition-colors hover:text-[#002D62]">{nav("contact")}</Link>
              <Link href={localizeHref("/contributors")} className="transition-colors hover:text-[#002D62]">{nav("contributors")}</Link>
              <Link href={localizeHref("/privacy-policy")} className="transition-colors hover:text-[#002D62]">{nav("privacyPolicy")}</Link>
              <Link href={localizeHref("/terms-of-use")} className="transition-colors hover:text-[#002D62]">{nav("termsOfUse")}</Link>
              <Link href={localizeHref("/dmca")} className="transition-colors hover:text-[#002D62]">{nav("copyrights")}</Link>
            </div>
          </nav>

          {/* Bottom Bar */}
          <div className="flex flex-col items-center gap-0 border-t border-black/10 pt-6 text-center">
            <div className="flex flex-col items-center gap-0">
              <div className="flex items-center gap-2">
                <Image src="/icon.svg" alt={t("logo")} width={28} height={28} />
                <span className="text-lg font-medium tracking-tight text-[#002D62]">
                  Mangulina<span className="tm-fix">&trade;</span>
                </span>
              </div>
              <span className="max-w-56 text-sm leading-relaxed text-gray-600 sm:max-w-none">
                {t("tagline")}
              </span>
            </div>
            <p className="text-sm leading-relaxed text-gray-600">
              {t("copyright")}
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
}
