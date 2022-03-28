# frozen_string_literal: true

# Videos::Process::TiktokProcess.call
module Videos
  module Process
    class TiktokProcess < Videos::Process::Base
      include HttpHelper
      prepend SimpleCommand

      def generate_thumnail
        return unless video.video_url

        tiktok_get_embed_info
        @embed_info['thumbnail_url']
      end

      private

      attr_reader :embed_info

      def tiktok_get_embed_info
        path = "https://www.tiktok.com/oembed?url=#{video.video_url}"
        response = make_request(method: :get, path: path)
        return @embed_info = {} if response.code.to_i == 500

        begin
          @embed_info = JSON.parse(response.body)
        rescue JSON::ParserError
          errors.add(:base, 'Get thumbnail fail')
          {}
        end
      end

      def generate_metadata
        { input_html: @embed_info['html'] }
      end
    end
  end
end
