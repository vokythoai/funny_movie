# frozen_string_literal: true

require 'rails_helper'

describe Videos::Process::VideoProcessFactory, aggregate_failures: true do
  describe '#get_process_client' do
    let(:user) { create :user }
    let(:video) { create :video, user: user, platform: :youtube }

    subject(:get) { described_class.get_process_client(video) }

    context 'When platform is youtube' do
      it 'returns Videos::Process::YoutubeProcess' do
        expect(get).to be_a(Videos::Process::YoutubeProcess)
      end
    end

    context 'When platform is tiktok' do
      let(:video) { create :video, user: user, platform: :tiktok }

      it 'returns Videos::Process::TiktokProcess' do
        expect(get).to be_a(Videos::Process::TiktokProcess)
      end
    end
  end
end
