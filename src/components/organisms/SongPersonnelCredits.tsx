import { useTranslations } from "next-intl";
import SongCreditsSection, { type CreditItem } from "@/components/organisms/SongCreditsSection";

type Props = {
  workCredits: CreditItem[];
  recordingCredits: CreditItem[];
  labelName?: string;
  releaseInfo?: string;
};

export default function SongPersonnelCredits({
  workCredits,
  recordingCredits,
  labelName,
  releaseInfo,
}: Props) {
  const t = useTranslations("songCatalog.fullCredits");
  const credits = [...workCredits, ...recordingCredits];
  if (!credits.length && !labelName && !releaseInfo) {
    return null;
  }
  return (
    <SongCreditsSection
      credits={credits}
      title={t("eyebrow")}
      labelName={labelName}
      releaseInfo={releaseInfo}
    />
  );
}
