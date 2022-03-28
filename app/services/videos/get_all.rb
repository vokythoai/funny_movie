# frozen_string_literal: true

# Videos::GetAll.call
module Videos
  class GetAll
    prepend SimpleCommand

    def initialize(user: nil, filter_params: {})
      @user = user
      @filter_params = filter_params
    end

    def call
      videos
    end

    private

    attr_reader :user, :filter_params

    # We using newest_videos and trending_videos for using cached videos, reduce load all videos
    def videos
      return all if filter_params[:type] == 'all'
      return newest_videos if filter_params[:type] == 'newest'
      return trending_videos if filter_params[:type] == 'trending'

      trending_videos
    end

    def all
      Video.active_video.order(created_at: :desc)
    end

    def newest_videos
      Videos::Repository::NewestVideo.new.get
    end

    def trending_videos
      Videos::Repository::TrendingVideo.new.get
    end

    # TODO Need service to get what user like
    def user_interested_videos
      Videos::Repository::TrendingVideo.new.get
    end
  end
end
