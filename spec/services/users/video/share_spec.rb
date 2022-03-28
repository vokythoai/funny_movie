# frozen_string_literal: true

require 'rails_helper'

describe Users::Video::Share, aggregate_failures: true do

  let(:user) { create :user }
  let(:params) { { video_url: 'https://www.youtube.com/watch?v=oj8_wufhE28' } }

  subject(:share) { described_class.call(user: user, params: params) }

  it 'creates new video with right value' do
    cmd = share
    video = cmd.result

    expect(cmd.success?).to be_truthy
    expect(cmd.result).to be_a Video
    expect(video.video_url).to eq(params[:video_url])
  end

  it 'increases Video count to 1' do
    expect{ share }.to change { Video.count }.by(1)
  end

  it 'calls Videos::VideoProcessorWorker' do
    expect(Videos::VideoProcessorWorker).to receive(:perform_async)

    share
  end

  context 'When missing required field' do
    let(:params) { {} }

    it 'returns nil and has errors' do
      cmd = share

      expect(cmd.success?).to be_falsy
      expect(cmd.result).to be_nil
      expect(cmd.errors).not_to be_nil
    end

    it 'does not call Videos::VideoProcessorWorker' do
      expect(Videos::VideoProcessorWorker).not_to receive(:perform_async)

      share
    end
  end
end
