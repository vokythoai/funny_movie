# frozen_string_literal: true

# Videos::Repository::NewestVideo.new.get
module Videos
  module Repository
    class NewestVideo
      LIMIT_VIDEO_SHOWING = 50

      def initialize; end

      def get
        collection
      end

      def add(video)
        cached_video_ids = VideoCache.get('newest_videos_ids') || []
        cached_video_ids.pop if cached_video_ids.size >= LIMIT_VIDEO_SHOWING
        cached_video_ids.unshift(video.id)

        VideoCache.set('newest_videos_ids', cached_video_ids)
      end

      private

      def collection
        cached_video_ids = VideoCache.get('newest_videos_ids')
        return Video.where(id: cached_video_ids).includes(:user).order(created_at: :desc) if cached_video_ids.present?

        fetch_newest_videos
      end

      def fetch_newest_videos
        videos = Video.active_video.order(created_at: :desc).limit(LIMIT_VIDEO_SHOWING)
        VideoCache.set('newest_videos_ids', videos.map(&:id))

        videos
      end
    end
  end
end
