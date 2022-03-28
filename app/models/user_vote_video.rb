# frozen_string_literal: true

# == Schema Information
#
# Table name: user_vote_videos
#
#  id         :bigint           not null, primary key
#  direction  :integer          default("no_react")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  video_id   :integer
#
# Indexes
#
#  index_user_vote_videos_on_direction  (direction)
#  index_user_vote_videos_on_user_id    (user_id)
#  index_user_vote_videos_on_video_id   (video_id)
#
class UserVoteVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  enum direction: { no_react: 0, up_vote: 1, down_vote: 2 }
end
