import { NextResponse } from "next/server";
import {
  fetchTopArtistViews,
  fetchTopRecordingViews,
  fetchTopGenreViews,
  fetchSearchesWithNoResults,
  fetchPlatformClicks,
  fetchArtistViewTrends,
  fetchRecordingViewTrends,
  fetchSearchTrends,
  fetchArtistsByIds,
  fetchRecordingsByIds,
} from "@/lib/analyticsQueries";

/**
 * Returns all analytics data as JSON
 * Called by client component to refresh analytics
 */
export async function GET() {
  try {
    const [
      artistViewsData,
      recordingViewsData,
      genreViewsData,
      searchesData,
      clicksData,
      artistTrendsData,
      recordingTrendsData,
      searchTrendsData,
    ] = await Promise.all([
      fetchTopArtistViews(20),
      fetchTopRecordingViews(20),
      fetchTopGenreViews(15),
      fetchSearchesWithNoResults(30),
      fetchPlatformClicks(),
      fetchArtistViewTrends(7),
      fetchRecordingViewTrends(7),
      fetchSearchTrends(7),
    ]);

    const [artists, recordings] = await Promise.all([
      fetchArtistsByIds(artistViewsData.map((row: { artist_id: string }) => row.artist_id)),
      fetchRecordingsByIds(recordingViewsData.map((row: { recording_id: string }) => row.recording_id)),
    ]);

    return NextResponse.json({
      artistViewsData,
      recordingViewsData,
      genreViewsData,
      searchesData,
      clicksData,
      artistTrendsData,
      recordingTrendsData,
      searchTrendsData,
      artists,
      recordings,
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    console.error("Analytics API error:", error);
    return NextResponse.json(
      { error: "Failed to fetch analytics data" },
      { status: 500 }
    );
  }
}
