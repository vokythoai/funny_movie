# frozen_string_literal: true

require 'rails_helper'

describe Videos::Process::YoutubeProcess, aggregate_failures: true do
  describe '#call' do
    let(:user) { create :user }
    let!(:video) { create :video, user: user, platform: :youtube, video_url: 'https://www.youtube.com/watch?v=jH1RNk8954Q' }

    subject(:process) { described_class.call(video: video) }

    it 'updates thumbnail and generate meta_data' do
      process

      video.reload
      expect(video.thumbnail).to eq('https://img.youtube.com/vi/jH1RNk8954Q/mqdefault.jpg')
      expect(video.meta_data).to eq({ 'embed_link' => "https://www.youtube.com/embed/jH1RNk8954Q" })
      expect(video.status).to eq('completed')
    end
  end
end
