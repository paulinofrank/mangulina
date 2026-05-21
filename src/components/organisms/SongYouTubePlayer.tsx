"use client";

import { useEffect, useRef, useState } from "react";

type Props = {
  videoId: string;
  coverArtUrl: string;
};


export default function SongYouTubePlayer({ videoId, coverArtUrl }: Props) {
  const containerRef = useRef<HTMLDivElement>(null);
  const playerRef = useRef<any>(null);

  const [isReady, setIsReady] = useState(false);
  const [embedError, setEmbedError] = useState(false);

  useEffect(() => {
    function createPlayer() {
      if (!window.YT || !window.YT.Player) return;
      if (!containerRef.current) return;

      // Reuse existing player
      if (playerRef.current) {
        playerRef.current.loadVideoById(videoId);
        return;
      }

      playerRef.current = new window.YT.Player(containerRef.current as any, {
        height: "360",
        width: "640",
        videoId,
        playerVars: {
          playsinline: 1,
          rel: 0,
          modestbranding: 1,
        },
events: {
  onReady: () => setIsReady(true),
  onStateChange: (event: any) => {
    // Detect embed restriction
    if (event.data === -1 || event.data === 5) {
      console.log("YouTube embed blocked");
      setEmbedError(true);
    }
  },
},
    });
    }

    if (window.YT && window.YT.Player) {
      createPlayer();
    } else {
      const tag = document.createElement("script");
      tag.src = "https://www.youtube.com/iframe_api";
      document.body.appendChild(tag);
      window.onYouTubeIframeAPIReady = createPlayer;
    }

    return () => {
      if (playerRef.current?.destroy) {
        playerRef.current.destroy();
      }
    };
  }, [videoId]);

  // ⭐ If YouTube blocks embedding → show fallback
if (embedError) {
  return (
    <div
      className="w-full max-w-3xl mx-auto my-8 rounded-xl overflow-hidden shadow-md relative aspect-video bg-black"
style={{
  backgroundImage: `url(${coverArtUrl})`,
  backgroundSize: "cover",
  backgroundPosition: "center",
}}

    >
      {/* Dark overlay */}
      <div className="absolute inset-0 bg-black/60 backdrop-blur-sm" />

      {/* Centered button */}
      <div className="absolute inset-0 flex items-center justify-center">
        <a
          href={`https://www.youtube.com/watch?v=${videoId}`}
          target="_blank"
          rel="noopener noreferrer"
          className="px-6 py-3 bg-red-600 text-white font-semibold rounded-lg shadow-lg hover:bg-red-700 transition text-lg"
        >
          ▶ Watch on YouTube
        </a>
      </div>
    </div>
  );
}


  return (
    <div className="w-full max-w-3xl mx-auto my-8">
      <div className="aspect-video w-full rounded-xl overflow-hidden shadow-md bg-black">
        <div ref={containerRef} className="w-full h-full" />
      </div>

      {!isReady && (
        <p className="text-gray-500 text-sm mt-2 text-center">
          Loading video…
        </p>
      )}
    </div>
  );
}
