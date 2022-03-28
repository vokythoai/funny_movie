# frozen_string_literal: true

require 'rails_helper'

describe Users::Video::Vote, aggregate_failures: true do
  let(:user) { create :user }
  let(:video) { create :video, user: user, created_at: 5.minutes.ago, total_likes: 1, total_dislikes: 1 }
  let(:direction) { UserVoteVideo.directions[:up_vote] }

  subject(:vote) { described_class.call(user: user, video: video, direction: direction) }

  before do
    allow_any_instance_of(Videos::Repository::TrendingVideo).to receive(:add)
  end

  context 'When upvote' do
    it 'increases video total like' do
      vote

      video.reload
      expect(video.total_likes).to eq(2)
      expect(video.total_dislikes).to eq(1)
    end

    it 'creates new UserVoteVideo' do
      expect{ vote }.to change{ UserVoteVideo.count}.by(1)
    end

    it 'calls Videos::Repository::TrendingVideo to update cache for trending video' do
      expect_any_instance_of(Videos::Repository::TrendingVideo).to receive(:add)

      vote
    end

    context 'When user already with different direction' do
      let!(:user_vote_video) { create :user_vote_video, user: user, video: video, direction: :down_vote }

      it 'updates Video votes' do
        vote

        video.reload
        expect(video.total_likes).to eq(2)
        expect(video.total_dislikes).to eq(0)
      end
    end

    context 'When user already voted for video with same direction' do
      let!(:user_vote_video) { create :user_vote_video, user: user, video: video, direction: direction }

      it 'return nil and has error' do
        cmd = vote

        expect(cmd.success?).to be_falsy
        expect(cmd.errors).not_to be_nil
      end

      it 'does not increase video total like' do
        vote

        video.reload
        expect(video.total_likes).to eq(1)
        expect(video.total_dislikes ).to eq(1)
      end

      it 'does not create new UserVoteVideo' do
        expect{ vote }.to change{ UserVoteVideo.count}.by(0)
      end
    end
  end
end
