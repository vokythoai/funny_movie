# frozen_string_literal: true

# Videos::Get
module Videos
  class Get
    prepend SimpleCommand

    def initialize(user:)
      @user = user
    end

    def call
      videos
    end

    private

    attr_reader :user

    def videos
      Video.joins(:user_videos).where(user_videos: { user_id: user.id })
    end
  end
end
