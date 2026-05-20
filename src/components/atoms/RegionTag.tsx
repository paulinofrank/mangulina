interface RegionTagProps {
  region: string;
  count: number;
}

export default function RegionTag({ region, count }: RegionTagProps) {
  return (
    <div className="flex items-center justify-between">
      <span className="font-medium text-[#002D62]">{region}</span>
      <span className="ml-2 rounded-md bg-[#002D62]/10 px-2 py-0.5 text-xs font-mono text-[#002D62]">
        {count}
      </span>
    </div>
  );
}
