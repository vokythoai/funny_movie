# frozen_string_literal: true

require 'rails_helper'

describe Videos::GetAll, aggregate_failures: true do
  include ActiveSupport::Testing::TimeHelpers

  let(:user_param) { nil }
  let(:params) { {} }

  subject(:get_new_feed) { described_class.call(user: user_param, filter_params: params) }

  context 'When there is no user provided and no filter params' do
    it 'returns video with order trending' do
      expect_any_instance_of(Videos::Repository::TrendingVideo).to receive(:get)

      get_new_feed
    end
  end

  context 'When has params newest' do
    let(:params) do
      {
        type: 'newest'
      }
    end

    it 'returns video with order newest' do
      expect_any_instance_of(Videos::Repository::NewestVideo).to receive(:get)

      get_new_feed
    end
  end

  context 'When has params trending' do
    let(:params) do
      {
        type: 'trending'
      }
    end

    it 'returns video with order newest' do
      expect_any_instance_of(Videos::Repository::TrendingVideo).to receive(:get)

      get_new_feed
    end
  end

  context 'When has params all' do
    let(:params) do
      {
        type: 'all'
      }
    end
    let(:user) { create :user }
    let!(:video) { create :video, user: user }
    let!(:video2) { create :video, user: user }

    it 'returns all videos' do
      cmd = get_new_feed

      expect(cmd.result.pluck(:id).sort).to eq([video.id, video2.id].sort)
    end
  end
end
