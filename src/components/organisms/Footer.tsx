"use client";

import { Fragment } from "react";
import Image from "next/image";
import { Link, usePathname, useRouter } from "@/i18n/navigation";
import { useTranslations, useLocale } from "next-intl";
import { FaFacebook, FaInstagram, FaYoutube, FaTiktok } from "react-icons/fa6";
import { type AppLocale } from "@/i18n/pathname";

export default function Footer() {
  const t = useTranslations("footer");
  const nav = useTranslations("navigation");
  const a11y = useTranslations("a11y");
  const router = useRouter();
  const pathname = usePathname();
  const locale = useLocale() as AppLocale;
  const alternateLocale = locale === "en" ? "es" : "en";

  const handleLanguageSwitch = () => {
    const search = typeof window !== "undefined" ? window.location.search : "";
    const params = new URLSearchParams(search);
    const query = Object.fromEntries(params.entries());

    router.replace(
      Object.keys(query).length > 0 ? { pathname, query } : pathname,
      { locale: alternateLocale },
    );
  };

  const SOCIAL_LINKS = [
    { icon: FaFacebook, key: "facebook", href: "https://facebook.com/MangulinaDo" },
    { icon: FaInstagram, key: "instagram", href: "https://instagram.com/MangulinaDo" },
    { icon: FaYoutube, key: "youtube", href: "https://youtube.com/@MangulinaDo" },
    { icon: FaTiktok, key: "tiktok", href: "https://tiktok.com/@MangulinaDo" },
  ];

  const desktopLinks = [
    { href: "/discover", label: nav("discover") },
    { href: "/about", label: nav("about") },
    { href: "/contact", label: nav("contact") },
    { href: "/contributors", label: nav("contributors") },
    { href: "/privacy-policy", label: nav("privacyPolicy") },
    { href: "/terms-of-use", label: nav("termsOfUse") },
    { href: "/dmca", label: nav("copyrights") },
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
                className="flex h-10 w-10 items-center justify-center rounded-full border border-black/10 bg-white/70 text-gray-600 transition-colors hover:border-black/20 hover:text-[#002D62]"
              >
                <Icon className="h-5 w-5" />
              </a>
            ))}
          </div>

          {/* Mobile Discover */}
          <div className="flex justify-center sm:hidden">
            <Link
              href="/discover"
              className="inline-flex items-center gap-2 text-[1.2em] font-medium text-[#002D62] transition-colors hover:text-[#8B0000]"
            >
              <span aria-hidden="true" className="text-[#8B0000]">
                ✦
              </span>
              {nav("discover")}
              <span aria-hidden="true" className="text-[#8B0000]">
                ✦
              </span>
            </Link>
          </div>

          {/* Navigation */}
          <nav aria-label={a11y("footerNav")} className="text-sm font-normal text-gray-600 sm:text-base">
            <div className="grid grid-cols-2 gap-x-18 sm:hidden">
              <div className="flex flex-col gap-3 justify-self-end text-right">
                <Link href="/about" className="transition-colors hover:text-[#002D62]">
                  {nav("about")}
                </Link>
                <Link href="/contact" className="transition-colors hover:text-[#002D62]">
                  {nav("contact")}
                </Link>
                <Link href="/contributors" className="transition-colors hover:text-[#002D62]">
                  {nav("contributors")}
                </Link>
              </div>

              <div className="flex flex-col gap-3 justify-self-start text-left">
                <Link href="/terms-of-use" className="transition-colors hover:text-[#002D62]">
                  {nav("termsOfUse")}
                </Link>
                <Link href="/privacy-policy" className="transition-colors hover:text-[#002D62]">
                  {nav("privacyPolicy")}
                </Link>
                <Link href="/dmca" className="transition-colors hover:text-[#002D62]">
                  {nav("copyrights")}
                </Link>
              </div>
            </div>

            {/* Mobile Language Switch */}
            <div className="mt-5 flex justify-center sm:hidden">
              <button
                type="button"
                onClick={handleLanguageSwitch}
                className="inline-flex items-center gap-2 text-[1.2em] font-medium text-[#8B0000] transition-colors hover:text-[#002D62]"
              >
                <span aria-hidden="true" className="text-[#002D62]">
                  ✦
                </span>
                {locale === "en" ? t("languageSwitchToSpanish") : t("languageSwitchToEnglish")}
                <span aria-hidden="true" className="text-[#002D62]">
                  ✦
                </span>
              </button>
            </div>

            {/* Desktop Navigation */}
            <div className="hidden flex-wrap items-center justify-center gap-y-2 sm:flex">
              {desktopLinks.map((item, index) => (
                <Fragment key={item.href}>
                  {index > 0 && (
                    <span aria-hidden="true" className="mx-2 select-none text-gray-300">
                      ·
                    </span>
                  )}
                  <Link href={item.href} className="transition-colors hover:text-[#002D62]">
                    {item.label}
                  </Link>
                </Fragment>
              ))}
            </div>
          </nav>

          {/* Bottom Bar */}
          <div className="flex flex-col items-center gap-0 border-t border-black/10 pt-6 text-center">
            <div className="flex flex-col items-center gap-0">
              <div className="flex items-center gap-2">
                <Image src="/icon.svg" alt={t("logo")} width={28} height={28} className="w-auto" />
                <span className="text-lg font-medium tracking-tight text-[#002D62]">
                  Mangulina<span className="tm-fix">&trade;</span>
                </span>
              </div>
              <span className="max-w-88 whitespace-nowrap text-sm leading-relaxed text-gray-600 sm:max-w-none">
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