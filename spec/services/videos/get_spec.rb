# frozen_string_literal: true

require 'rails_helper'

describe Videos::Get, aggregate_failures: true do
  include ActiveSupport::Testing::TimeHelpers

  let(:user) { create :user }
  let(:user2) { create :user }
  let!(:video) { create :video, user: user }
  let!(:video1) { create :video, user: user }
  let!(:video2) { create :video, user: user2 }
  let!(:video3) { create :video, user: user2 }
  let!(:user_video) { create :user_video, user_id: user.id, video_id: video.id }
  let!(:user_video1) { create :user_video, user_id: user.id, video_id: video1.id }

  subject(:get_video) { described_class.call(user: user) }

  it 'returns videos user saved' do
    cmd = get_video

    expect(cmd.success?).to be_truthy
    expect(cmd.result.pluck(:id).sort).to eq([video.id, video1.id].sort)
  end
end
