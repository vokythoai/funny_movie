require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe UsersController, type: :request do
  describe 'GET share_movie' do
    let!(:user) { create :user }

    it 'returns a successful response' do
      login_as(user, scope: :user)
      get share_movie_user_path(id: user.id)

      expect(response).to be_successful
    end
  end

  describe 'POST share' do
    let!(:user) { create :user }
    let(:params) do
      {
        video_url: 'https://www.youtube.com/watch?v=fLsZanqzeCo',
        title: 'ABC',
        description: 'ABC'
      }
    end

    before do
      login_as(user, scope: :user)
    end

    it 'returns a successful response and redirect to root_path' do
      post share_user_path(user), params: params

      expect(response).to redirect_to root_path
    end

    it 'creates new video' do
      post share_user_path(user), params: params

      expect(Video.count).to eq(1)
    end

    context 'When invalid params' do
      let(:params) do
        {
          video_url: nil,
          title: 'ABC',
          description: 'ABC'
        }
      end

      it 'returns a render share_movie with errors' do
        post share_user_path(user), params: params

        expect(response).to render_template('users/share_movie')
      end
    end
  end
end
