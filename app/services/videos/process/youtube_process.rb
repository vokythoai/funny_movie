# frozen_string_literal: true

# Videos::Process::YoutubeProcess.call
module Videos
  module Process
    class YoutubeProcess < Videos::Process::Base
      prepend SimpleCommand

      private

      attr_reader :video_id

      def generate_thumnail
        return unless video.video_url

        @video_id = video.video_url[/(v=\S+)/]
        @video_id = video_id.split('&')[0]
        @video_id = video_id.gsub('v=', '')
        "https://img.youtube.com/vi/#{video_id}/mqdefault.jpg"
      end

      def generate_metadata
        { embed_link: "https://www.youtube.com/embed/#{video_id}" }
      end
    end
  end
end
