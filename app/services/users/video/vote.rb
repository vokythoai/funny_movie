# frozen_string_literal: true

# Users::Video::Vote.call
module Users
  module Video
    class Vote
      prepend SimpleCommand
      include ActiveModel::Validations

      validates_presence_of :user, :video, :direction

      def initialize(user:, video:, direction:)
        @user = user
        @video = video
        @direction = direction.to_i
      end

      def call
        return if invalid?

        process_vote
      end

      private

      attr_reader :user, :video, :direction, :video_update_params

      def process_vote
        ActiveRecord::Base.transaction do
          create_or_update_user_vote_video
          recalculate_video_vote
        end

        add_to_cache
      end

      def create_or_update_user_vote_video
        vote = UserVoteVideo.find_or_initialize_by(
          user_id: user.id,
          video_id: video.id
        )

        if vote.persisted? && UserVoteVideo.directions[vote.direction] == direction
          errors.add(:base, 'You already voted')
          raise ActiveRecord::Rollback
        end

        vote.direction = direction
        build_video_update_params(vote)
        vote.save
      end

      def recalculate_video_vote
        video.with_lock do
          video.update(video_update_params)
        end
      end

      def build_video_update_params(vote)
        direction_column = need_update_column(direction)

        @video_update_params = if vote.persisted?
                                 change_vote_params(direction_column)
                               else
                                 first_vote_params(direction_column)
                               end
      end

      def first_vote_params(direction_column)
        { direction_column => video.attributes[direction_column.to_s] + 1 }
      end

      def change_vote_params(direction_column)
        update_params = {
          total_likes: video.total_likes - 1,
          total_dislikes: video.total_dislikes - 1
        }

        update_params[direction_column] = update_params[direction_column] + 2
        update_params.select { |key, value| update_params[key] = [value, 0].max }
        update_params
      end

      def need_update_column(direction)
        direction == UserVoteVideo.directions[:up_vote] ? :total_likes : :total_dislikes
      end

      def add_to_cache
        Videos::Repository::TrendingVideo.new.add(video)
      end
    end
  end
end
