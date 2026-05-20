'use client';

import { useEffect, useRef, useState } from 'react';

type YTPlayerInstance = {
  playVideo: () => void;
  pauseVideo: () => void;
};

type YTStateChangeEvent = { data: number };

declare global {
  interface Window {
    YT?: {
      Player: new (
        elementId: string,
        options: {
          height: string;
          width: string;
          videoId: string;
          playerVars?: Record<string, number>;
          events?: {
            onReady?: () => void;
            onStateChange?: (event: YTStateChangeEvent) => void;
          };
        }
      ) => YTPlayerInstance;
      PlayerState: { PLAYING: number };
    };
    onYouTubeIframeAPIReady?: () => void;
  }
}

export default function MusicPlayer({ videoId }: { videoId: string }) {
  const playerRef = useRef<YTPlayerInstance | null>(null);
  const [isPlaying, setIsPlaying] = useState(false);
  const [isReady, setIsReady] = useState(false);

  useEffect(() => {
    if (!window.YT) {
      const tag = document.createElement('script');
      tag.src = "https://www.youtube.com/iframe_api";
      const firstScriptTag = document.getElementsByTagName('script')[0];
      firstScriptTag.parentNode?.insertBefore(tag, firstScriptTag);
    }

    window.onYouTubeIframeAPIReady = () => {
      const YT = window.YT;
      if (!YT) return;
      playerRef.current = new YT.Player('youtube-hidden-player', {
        height: '0',
        width: '0',
        videoId: videoId,
        playerVars: {
          playsinline: 1,
          controls: 0,
        },
        events: {
          onReady: () => setIsReady(true),
          onStateChange: (event: YTStateChangeEvent) => {
            setIsPlaying(event.data === YT.PlayerState.PLAYING);
          },
        },
      });
    };

    if (window.YT && window.YT.Player) {
      window.onYouTubeIframeAPIReady?.();
    }
  }, [videoId]);

  const togglePlay = () => {
    if (!playerRef.current || typeof playerRef.current.playVideo !== 'function') {
      return;
    }

    if (isPlaying) {
      playerRef.current.pauseVideo();
    } else {
      playerRef.current.playVideo();
    }
  };

  return (
    <section className="p-5 rounded-xl border border-white/5 bg-white/2">
      <div id="youtube-hidden-player" className="hidden"></div>
      
      <div className="flex items-center justify-between mb-4">
        <div className="text-[9px] font-normal uppercase tracking-wider text-white/30">
          {isReady ? 'Ready' : 'Loading...'}
        </div>
        <div className="flex gap-0.5 h-3 items-end">
          <span className={`w-0.5 bg-[#8B0000]/60 transition-all ${isPlaying ? 'animate-bounce h-2' : 'h-0.5 opacity-20'}`} />
          <span className={`w-0.5 bg-[#8B0000]/60 transition-all ${isPlaying ? 'animate-bounce h-3 [animation-delay:0.2s]' : 'h-0.5 opacity-20'}`} />
          <span className={`w-0.5 bg-[#8B0000]/60 transition-all ${isPlaying ? 'animate-bounce h-1.5 [animation-delay:0.4s]' : 'h-0.5 opacity-20'}`} />
        </div>
      </div>

      <button 
        onClick={togglePlay}
        disabled={!isReady}
        className={`aspect-video w-full bg-black/20 rounded-lg flex items-center justify-center border border-white/5 group transition-all duration-300 ${isReady ? 'cursor-pointer hover:border-white/10' : 'cursor-wait opacity-50'}`}
      >
        <div className={`w-12 h-12 rounded-full flex items-center justify-center transition-transform group-hover:scale-105 ${isPlaying ? 'bg-white/5 border border-white/10' : 'bg-[#8B0000]/80'}`}>
          {isPlaying ? (
            <div className="flex gap-1">
              <div className="w-1 h-4 bg-white rounded-full" />
              <div className="w-1 h-4 bg-white rounded-full" />
            </div>
          ) : (
            <div className="w-0 h-0 border-t-8 border-t-transparent border-l-12 border-l-white border-b-8 border-b-transparent ml-0.5" />
          )}
        </div>
      </button>

      <p className="text-[8px] text-center mt-4 text-white/20 uppercase tracking-wider">
        Archive Playback
      </p>
    </section>
  );
}
