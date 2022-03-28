require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe VideosController, type: :request do
  describe 'GET index' do
    let!(:user) { create :user }

    it 'returns a successful response' do
      get videos_path

      expect(response).to be_successful
    end

    context 'When user login' do
      it 'returns a successful response' do
        login_as(user, scope: :user)
        get videos_path

        expect(response).to be_successful
      end
    end
  end

  describe 'GET show' do
    let(:user) { create :user }
    let(:video) { create :video, user: user }

    it 'returns a successful response' do
      get video_path(video)

      expect(response).to be_successful
    end

    context 'When video id does not exist' do
      it 'redirect to root path' do
        get video_path(id: 'wrong')

        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PUT vote' do
    let(:user) { create :user }
    let(:video) { create :video, user: user }

    context 'When user not login' do
      it 'returns a error response' do
        put vote_video_path(video), params: { direction: 1, format: :js }

        expect(response.body).to eq("{\"error\":\"You must login to vote\"}")
        expect(response.code).to eq("500")
      end
    end

    context 'When user login' do
      before do
        login_as(user, scope: :user)
      end

      it 'returns a error response' do
        put vote_video_path(video), params: { direction: 1, format: :js }

        expect(response.body).to eq("{\"success\":true}")
        expect(response.code).to eq("200")
      end

      it 'votes like for video' do
        put vote_video_path(video), params: { direction: 1, format: :js }

        video.reload
        expect(video.total_likes).to eq(1)
        expect(video.total_dislikes).to eq(0)
      end

      context 'When user dislike video' do
        it 'votes dislike for video' do
          put vote_video_path(video), params: { direction: 2, format: :js }

          video.reload
          expect(video.total_likes).to eq(0)
          expect(video.total_dislikes).to eq(1)
        end
      end
    end
  end
end
