# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id             :bigint           not null, primary key
#  description    :string
#  meta_data      :jsonb
#  platform       :integer          default("youtube")
#  status         :integer          default("processing")
#  thumbnail      :string
#  title          :string
#  total_dislikes :integer          default(0)
#  total_likes    :integer          default(0)
#  total_view     :integer          default(0)
#  video_url      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  upload_user_id :integer
#
# Indexes
#
#  index_videos_on_meta_data       (meta_data) USING gin
#  index_videos_on_upload_user_id  (upload_user_id)
#
require 'rails_helper'

RSpec.describe Video, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:user_videos) }
    it { is_expected.to have_many(:user_vote_videos) }
  end

  describe '#enum' do
    it do
      expect(described_class.statuses).to eq(
        {
          'processing' => 0,
          'completed' => 1,
          'failed' => 2
        }
      )
    end

    it do
      expect(described_class.platforms).to eq(
        {
          'youtube' => 0,
          'tiktok' => 1,
          'mannual_upload' => 2
        }
      )
    end
  end

  describe '#detect_platform' do
    let(:url) { 'https://www.youtube.com/watch?v=nS5Se6PgAQo&list=RDdMtMx_dYk-w&index=2'}

    context 'When url from youtube' do
      it 'returns :youtube' do
        expect(Video.detect_platform(url)).to eq(:youtube)
      end
    end

    context 'When url from tiktok' do
      let(:url) { 'https://www.tiktok.com/@xheoinek__10/video/7074869454227655962?is_copy_url=1&is_from_webapp=v1' }

      it 'returns :tiktok' do
        expect(Video.detect_platform(url)).to eq(:tiktok)
      end
    end

    context 'When unknown url' do
      let(:url) { 'abc' }

      it 'returns nil' do
        expect(Video.detect_platform(url)).to be_nil
      end
    end
  end

  describe '#validate_video_url' do
    let(:user) { create :user }
    let(:video) { Video.new(title: 'abc', description: 'abc', upload_user_id: user.id, platform: 1, video_url: 'https://www.youtube.com/watch?v=nS5Se6PgAQo&list=RDdMtMx_dYk-w&index=2') }

    it 'video valid is true' do
      expect(video.valid?).to be_truthy
    end

    context 'When video is not valid url' do
      let(:video) { Video.new(title: 'abc', description: 'abc', upload_user_id: user.id, platform: 1, video_url: 'Wrong video') }

      it 'video valid is false' do
        expect(video.valid?).to be_falsy
      end
    end
  end

  describe '#user_vote_info' do
    let(:user) { create :user }
    let(:video) { create :video, user: user }
    let!(:user_vote_video) { create :user_vote_video, user: user, video: video }

    it 'video valid is true' do
      expect(video.user_vote_info(user)).to eq(user_vote_video)
    end
  end
end
