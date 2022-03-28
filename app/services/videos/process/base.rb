# frozen_string_literal: true

# Videos::Process::Base
module Videos
  module Process
    class Base
      prepend SimpleCommand
      include ActiveModel::Validations

      validates_presence_of :video

      def initialize(video:)
        @video = video
      end

      def call
        return if invalid?

        process_video
        add_to_cache
      end

      private

      attr_reader :video

      def process_video
        video.thumbnail = generate_thumnail
        video.meta_data = generate_metadata

        if video.thumbnail && video.meta_data.present?
          video.status = :completed
        else
          errors.add(:base, 'Generating thumbnail failed')
          video.status = :failed
        end

        video.save
        video
      end

      def add_to_cache
        Videos::Repository::NewestVideo.new.add(video)
      end

      def generate_thumnail
        raise 'Not Implemented'
      end

      def generate_metadata
        raise 'Not Implemented'
      end
    end
  end
end
