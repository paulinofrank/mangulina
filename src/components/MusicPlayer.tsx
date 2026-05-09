'use client';

import { useEffect, useRef, useState } from 'react';

export default function MusicPlayer({ videoId }: { videoId: string }) {
  const playerRef = useRef<any>(null);
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
      playerRef.current = new window.YT.Player('youtube-hidden-player', {
        height: '0',
        width: '0',
        videoId: videoId,
        playerVars: {
          playsinline: 1,
          controls: 0,
        },
        events: {
          onReady: () => setIsReady(true),
          onStateChange: (event: any) => {
            setIsPlaying(event.data === window.YT.PlayerState.PLAYING);
          },
        },
      });
    };

    if (window.YT && window.YT.Player) {
      window.onYouTubeIframeAPIReady();
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
    <section className="p-8 rounded-3xl border border-white/10 bg-white/5 backdrop-blur-md">
      <div id="youtube-hidden-player" className="hidden"></div>
      
      <div className="flex items-center justify-between mb-8">
        <div className="text-[10px] font-bold uppercase tracking-widest opacity-40">
          {isReady ? 'Live Feed' : 'Connecting...'}
        </div>
        <div className="flex gap-1 h-4 items-end">
          <span className={`w-1 bg-wikicrimson transition-all ${isPlaying ? 'animate-bounce h-3' : 'h-1 opacity-20'}`} />
          <span className={`w-1 bg-wikicrimson transition-all ${isPlaying ? 'animate-bounce h-5 [animation-delay:0.2s]' : 'h-1 opacity-20'}`} />
          <span className={`w-1 bg-wikicrimson transition-all ${isPlaying ? 'animate-bounce h-2 [animation-delay:0.4s]' : 'h-1 opacity-20'}`} />
        </div>
      </div>

      <button 
        onClick={togglePlay}
        disabled={!isReady}
        className={`aspect-video w-full bg-black/40 rounded-2xl flex items-center justify-center border border-white/5 group transition-all duration-500 ${isReady ? 'cursor-pointer hover:border-wikicrimson/50' : 'cursor-wait opacity-50'}`}
      >
        <div className={`w-16 h-16 rounded-full bg-wikicrimson flex items-center justify-center transition-transform group-hover:scale-110 ${isPlaying ? 'bg-white/10 border border-white/20' : 'shadow-xl shadow-wikicrimson/20'}`}>
          {isPlaying ? (
            <div className="flex gap-1.5">
              <div className="w-1.5 h-6 bg-white rounded-full" />
              <div className="w-1.5 h-6 bg-white rounded-full" />
            </div>
          ) : (
            <div className="w-0 h-0 border-t-10 border-t-transparent border-l-18 border-l-white border-b-10 border-b-transparent ml-1" />
          )}
        </div>
      </button>

      <p className="text-[9px] text-center mt-6 opacity-30 uppercase tracking-[0.2em]">
        Dominican Music Database — Verified Archive
      </p>
    </section>
  );
}

declare global {
  interface Window {
    YT: any;
    onYouTubeIframeAPIReady: any;
  }
}