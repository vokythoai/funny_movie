# frozen_string_literal: true

module Videos
  module Process
    # Videos::Process::VideoProcessFactory
    class VideoProcessFactory
      YOUTUBE_VIDEO        = :youtube
      TIKTOK_VIDEO         = :tiktok
      MANNUAL_UPLOAD_VIDEO = :mannual_upload

      VIDEO_PROCESSOR_FACTORIES_MAP = {
        YOUTUBE_VIDEO => Videos::Process::YoutubeProcess,
        TIKTOK_VIDEO => Videos::Process::TiktokProcess,
        MANNUAL_UPLOAD_VIDEO => nil
      }.freeze

      class << self
        def get_process_client(video)
          VIDEO_PROCESSOR_FACTORIES_MAP[video.platform.to_sym].new(video: video)
        end
      end
    end
  end
end
