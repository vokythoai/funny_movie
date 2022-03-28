# frozen_string_literal: true

require 'rails_helper'

describe Videos::Process::TiktokProcess, aggregate_failures: true do
  describe '#call' do
    let(:user) { create :user }
    let!(:video) { create :video, user: user, platform: :youtube, video_url: 'https://www.tiktok.com/@meichocopie6/video/7070894004035931418?is_copy_url=1&is_from_webapp=v1' }

    subject(:process) { described_class.call(video: video) }

    context 'When call tiktok success' do
      before do
        allow_any_instance_of(HttpHelper).to receive(:make_request).and_return(double(code: 200, body: { 'thumbnail_url' => 'abc', 'html' => 'bcd'}.to_json))
      end

      it 'updates thumbnail and generate meta_data' do
        process

        video.reload
        expect(video.thumbnail).to eq('abc')
        expect(video.meta_data).to eq({ 'input_html' => "bcd" })
        expect(video.status).to eq('completed')
      end
    end

    context 'When call tiktok failed' do
      before do
        allow_any_instance_of(HttpHelper).to receive(:make_request).and_return(double(code: 500, body: { 'thumbnail_url' => 'abc', 'html' => 'bcd'}.to_json))
      end

      it 'updates video status to failed' do
        process

        video.reload
        expect(video.status).to eq('failed')
      end
    end
  end
end
