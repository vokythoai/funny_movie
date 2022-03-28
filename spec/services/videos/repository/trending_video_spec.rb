# frozen_string_literal: true

require 'rails_helper'

describe Videos::Repository::TrendingVideo, aggregate_failures: true do
  describe '#get' do
    let(:user) { create :user }
    let!(:video) { create :video, user: user, created_at: 5.minutes.ago, total_likes: 10 }
    let!(:video2) { create :video, user: user, created_at: 20.minutes.ago, total_likes: 1 }
    let!(:video3) { create :video, user: user, created_at: 10.minutes.ago, total_likes: 9 }

    subject(:get_trending) { described_class.new.get }

    context 'When does not have cache' do
      before do
        allow(VideoCache).to receive(:get).with('trending_videos_ids').and_return([])
      end

      it 'fetchs video with order total like desc' do
        expect(get_trending.pluck(:id)).to eq([video.id, video3.id, video2.id])
      end

      it 'set cache for trending video' do
        expect(VideoCache).to receive(:set).with('trending_videos_ids', [video.id, video3.id, video2.id])
        expect(VideoCache).to receive(:set).with('trending_likes_lowest', video2.total_likes)

        get_trending
      end
    end

    context 'When already have cache' do
      before do
        allow(VideoCache).to receive(:get).with('trending_videos_ids').and_return([video.id, video2.id])
      end

      it 'fetchs video with video_ids in cache' do
        expect(get_trending.pluck(:id)).to eq([video.id, video2.id])
      end
    end
  end

  describe '#add' do
    let(:user) { create :user }
    let!(:video) { create :video, user: user, created_at: 5.minutes.ago, total_likes: 6 }

    subject(:add_trending) { described_class.new.add(video) }

    before do
      allow(VideoCache).to receive(:get).with('trending_likes_lowest').and_return(5)
      allow(VideoCache).to receive(:get).with('trending_videos_ids').and_return([5, 4])
    end

    context 'When video total like is greater than trending_likes_lowest' do
      it 'adds trending_likes_lowest to cache' do
        expect(VideoCache).to receive(:set).with('trending_likes_lowest', 6)
        expect(VideoCache).to receive(:set).with('trending_videos_ids', [5, 4, video.id])

        add_trending
      end
    end
  end
end
