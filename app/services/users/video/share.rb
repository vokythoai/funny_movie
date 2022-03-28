# frozen_string_literal: true

# Users::Video::Share.call(user:, params:)
module Users
  module Video
    class Share
      prepend SimpleCommand

      def initialize(user:, params: {})
        @user = user
        @params = params
      end

      def call
        create_video
      end

      private

      attr_reader :user, :params

      def create_video
        video = ::Video.new(
          title: params[:title] || 'Title',
          description: params[:description] || 'Description',
          upload_user_id: user.id,
          video_url: params[:video_url],
          platform: ::Video.detect_platform(params[:video_url])
        )

        unless video.valid?
          errors.add_multiple_errors({ base: video.errors.full_messages })
          return
        end

        video.save
        process_extra_info(video)
        video
      end

      def process_extra_info(video)
        Videos::VideoProcessorWorker.perform_async(video.id)
      end
    end
  end
end
