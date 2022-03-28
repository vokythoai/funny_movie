# frozen_string_literal: true

# == Schema Information
#
# Table name: user_videos
#
#  id         :bigint           not null, primary key
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  video_id   :integer
#
# Indexes
#
#  index_user_videos_on_status    (status)
#  index_user_videos_on_user_id   (user_id)
#  index_user_videos_on_video_id  (video_id)
#
require 'rails_helper'

RSpec.describe UserVideo, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:video) }
  end
end
