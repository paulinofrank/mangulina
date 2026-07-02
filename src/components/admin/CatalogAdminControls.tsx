"use client";

import { useEffect, useMemo, useState } from "react";

export type PickerOption = {
  id: string;
  title?: string | null;
  name?: string | null;
  subtitle?: string | null;
};

export function AdminField({
  label,
  children,
}: {
  label: string;
  children: React.ReactNode;
}) {
  return (
    <label className="block">
      <span className="mb-1 block text-[10px] font-normal uppercase tracking-[0.18em] text-gray-400">
        {label}
      </span>
      {children}
    </label>
  );
}

export function AdminStatusMessage({ message }: { message: string }) {
  if (!message) return null;
  return (
    <div className="mb-6 rounded-lg border border-gray-200 bg-white px-4 py-3 text-sm text-gray-700 shadow-sm">
      {message}
    </div>
  );
}

export const adminInputClass =
  "w-full rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm font-normal text-gray-800 outline-none transition focus:border-(--color-flagblue)";

export const adminButtonClass =
  "rounded-lg bg-(--color-flagblue) px-5 py-3 text-xs uppercase tracking-[0.18em] text-white transition disabled:cursor-not-allowed disabled:opacity-40";

async function readAdminJson(response: Response) {
  const contentType = response.headers.get("content-type") ?? "";

  if (contentType.includes("application/json")) {
    return response.json() as Promise<Record<string, unknown>>;
  }

  return {
    ok: false,
    error: `Admin endpoint did not return JSON (${response.status} ${response.statusText})`,
  };
}

type AdminSearchPickerProps = {
  label: string;
  value: string;
  displayValue: string;
  placeholder: string;
  endpoint: string;
  extraParams?: Record<string, string>;
  resultKey: "artists" | "releases" | "recordings";
  onSelect: (option: PickerOption) => void;
  onClear: () => void;
};

export function AdminSearchPicker({
  label,
  value,
  displayValue,
  placeholder,
  endpoint,
  extraParams,
  resultKey,
  onSelect,
  onClear,
}: AdminSearchPickerProps) {
  const [query, setQuery] = useState(displayValue);
  const [options, setOptions] = useState<PickerOption[]>([]);
  const [open, setOpen] = useState(false);
  const extraParamsKey = JSON.stringify(extraParams ?? {});

  useEffect(() => {
    setQuery(displayValue);
  }, [displayValue]);

  useEffect(() => {
    if (!open) return;

    const controller = new AbortController();
    const timeout = window.setTimeout(() => {
      const params = new URLSearchParams({
        q: query.trim(),
        limit: "25",
      });
      const parsedExtraParams = JSON.parse(extraParamsKey) as Record<string, string>;
      for (const [key, value] of Object.entries(parsedExtraParams)) {
        if (value) params.set(key, value);
      }
      void fetch(`${endpoint}?${params.toString()}`, {
        signal: controller.signal,
      })
        .then((response) => response.json())
        .then((result) => {
          if (!controller.signal.aborted) {
            setOptions((result?.[resultKey] ?? []) as PickerOption[]);
          }
        })
        .catch((error) => {
          if (error instanceof DOMException && error.name === "AbortError") {
            return;
          }

          console.error("Admin search picker failed:", error);
          setOptions([]);
        });
    }, 180);

    return () => {
      window.clearTimeout(timeout);
      controller.abort();
    };
  }, [endpoint, extraParamsKey, open, query, resultKey]);

  return (
    <AdminField label={label}>
      <div className="relative">
        <input
          value={query}
          onChange={(event) => {
            setQuery(event.target.value);
            setOpen(true);
            if (value) onClear();
          }}
          onFocus={() => setOpen(true)}
          onBlur={() => window.setTimeout(() => setOpen(false), 130)}
          placeholder={placeholder}
          className={adminInputClass}
        />
        {value && (
          <button
            type="button"
            onMouseDown={(event) => event.preventDefault()}
            onClick={() => {
              setQuery("");
              onClear();
            }}
            className="absolute right-2 top-1/2 -translate-y-1/2 text-xs text-(--color-wikicrimson)"
          >
            Clear
          </button>
        )}

        {open && (
          <div className="absolute left-0 right-0 top-[calc(100%+0.35rem)] z-30 max-h-64 overflow-y-auto rounded-lg border border-gray-200 bg-white shadow-lg">
            {options.length ? (
              options.map((option) => {
                const title = option.name ?? option.title ?? "Untitled";
                return (
                  <button
                    key={option.id}
                    type="button"
                    onMouseDown={(event) => event.preventDefault()}
                    onClick={() => {
                      setQuery(title);
                      onSelect(option);
                      setOpen(false);
                    }}
                    className="block w-full border-b border-gray-100 px-3 py-2 text-left text-sm text-gray-700 transition last:border-none hover:bg-(--color-flagblue)/5"
                  >
                    <span className="block truncate font-medium">{title}</span>
                    {option.subtitle && (
                      <span className="mt-0.5 block truncate text-[10px] uppercase tracking-[0.14em] text-gray-400">
                        {option.subtitle}
                      </span>
                    )}
                  </button>
                );
              })
            ) : (
              <p className="px-3 py-2 text-sm text-gray-400">No matches found.</p>
            )}
          </div>
        )}
      </div>
    </AdminField>
  );
}

type GenreRow = {
  id: string | number;
  name: string;
  parent_id?: string | number | null;
  genre_id?: string | number | null;
  level?: number | null;
};

export function AdminGenrePicker({
  genreId,
  subgenreId,
  onGenreChange,
  onSubgenreChange,
}: {
  genreId: string;
  subgenreId: string;
  onGenreChange: (value: string) => void;
  onSubgenreChange: (value: string) => void;
}) {
  const [genres, setGenres] = useState<GenreRow[]>([]);
  const [subgenres, setSubgenres] = useState<GenreRow[]>([]);

  useEffect(() => {
    void Promise.all([
      fetch("/api/admin/genres").then(readAdminJson),
      fetch("/api/admin/subgenres?all=1").then(readAdminJson),
    ]).then(([genreResult, subgenreResult]) => {
      setGenres((genreResult.genres ?? []) as GenreRow[]);
      setSubgenres((subgenreResult.subgenres ?? []) as GenreRow[]);
    });
  }, []);

  const childOptions = useMemo(
    () =>
      subgenres.filter(
        (subgenre) => String(subgenre.parent_id ?? subgenre.genre_id ?? "") === String(genreId),
      ),
    [genreId, subgenres],
  );

  return (
    <div className="grid gap-4 md:grid-cols-2">
      <AdminField label="Genre">
        <select
          value={genreId}
          onChange={(event) => {
            onGenreChange(event.target.value);
            onSubgenreChange("");
          }}
          className={adminInputClass}
        >
          <option value="">-- Select Genre --</option>
          {genres.map((genre) => (
            <option key={genre.id} value={genre.id}>
              {genre.name}
            </option>
          ))}
        </select>
      </AdminField>

      <AdminField label="Subgenre">
        <select
          value={subgenreId}
          onChange={(event) => onSubgenreChange(event.target.value)}
          className={adminInputClass}
          disabled={!genreId}
        >
          <option value="">-- Select Subgenre --</option>
          {childOptions.map((subgenre) => (
            <option key={subgenre.id} value={subgenre.id}>
              {subgenre.name}
            </option>
          ))}
        </select>
      </AdminField>
    </div>
  );
}
