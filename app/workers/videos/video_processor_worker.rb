# frozen_string_literal: true

# Videos::VideoProcessorWorker
module Videos
  class VideoProcessorWorker
    include Sidekiq::Worker
    sidekiq_options queue: :video_process,
                    unique: :until_and_while_executing

    def perform(video_id)
      video = Video.find_by(id: video_id)
      return unless video

      process_video(video)
    end

    private

    def process_video(video)
      client = Videos::Process::VideoProcessFactory.get_process_client(video)
      client.call
    end
  end
end
