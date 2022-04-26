# frozen_string_literal: true

module Videos
  module Repository
    # Videos::Repository::TrendingVideo.new.get
    class TrendingVideo
      LIMIT_VIDEO_SHOWING = 50

      def initialize; end

      def get
        collection
      end

      def add(video)
        trending_likes_lowest = VideoCache.get('trending_likes_lowest')
        return if trending_likes_lowest.to_i > video.total_likes

        cached_video_ids = VideoCache.get('trending_videos_ids') || []
        return if cached_video_ids.include?(video.id)

        cached_video_ids.pop if cached_video_ids.size >= LIMIT_VIDEO_SHOWING
        cached_video_ids << video.id

        VideoCache.set('trending_likes_lowest', video.total_likes)
        VideoCache.set('trending_videos_ids', cached_video_ids)
      end

      private

      def collection
        cached_video_ids = VideoCache.get('trending_videos_ids')
        return Video.where(id: cached_video_ids).includes(:user).order(total_likes: :desc) if cached_video_ids.present?

        fetch_trending_videos
      end

      def fetch_trending_videos
        videos = Video.active_video.order(total_likes: :desc).limit(LIMIT_VIDEO_SHOWING)
        VideoCache.set('trending_videos_ids', videos.map(&:id))
        VideoCache.set('trending_likes_lowest', videos.last&.total_likes.to_i)

        videos
      end
    end
  end
end
