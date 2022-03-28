# frozen_string_literal: true

require 'rails_helper'

describe Videos::Repository::NewestVideo, aggregate_failures: true do
  describe '#get' do
    let(:user) { create :user }
    let!(:video) { create :video, user: user, created_at: 5.minutes.ago }
    let!(:video2) { create :video, user: user, created_at: 20.minutes.ago }
    let!(:video3) { create :video, user: user, created_at: 10.minutes.ago }

    subject(:get_newest) { described_class.new.get }

    context 'When does not have cache' do
      before do
        allow(VideoCache).to receive(:get).with('newest_videos_ids').and_return([])
      end

      it 'fetchs video with order created at desc' do
        expect(get_newest.pluck(:id)).to eq([video.id, video3.id, video2.id])
      end

      it 'set cache for trending video' do
        expect(VideoCache).to receive(:set).with('newest_videos_ids', [video.id, video3.id, video2.id])

        get_newest
      end
    end

    context 'When already have cache' do
      before do
        allow(VideoCache).to receive(:get).with('newest_videos_ids').and_return([video.id, video2.id])
      end

      it 'fetchs video with video_ids in cache' do
        expect(get_newest.pluck(:id)).to eq([video.id, video2.id])
      end
    end
  end

  describe '#add' do
    let(:user) { create :user }
    let!(:video) { create :video, user: user, created_at: 5.minutes.ago }

    subject(:add_newest) { described_class.new.add(video) }

    before do
      allow(VideoCache).to receive(:get).with('newest_videos_ids').and_return([2])
    end

    it 'add video to first of array cache' do
      expect(VideoCache).to receive(:set).with('newest_videos_ids', [video.id, 2])

      add_newest
    end
  end
end
