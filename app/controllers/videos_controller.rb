# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :set_video

  def index
    new_feed_cmd = Videos::GetAll.call(user: current_user, filter_params: params)

    unless new_feed_cmd.success?
      @videos = []
      return
    end

    @videos = new_feed_cmd.result
    @videos = @videos.includes(:user).page(params[:page]).per(PER_PAGE_PAGING)
  end

  def show
    redirect_to root_path unless @video
  end

  def vote
    cmd_vote = Users::Video::Vote.call(user: current_user, video: @video, direction: params[:direction])

    unless cmd_vote.success?
      respond_to do |format|
        format.js { render json: { error: 'You must login to vote' }, status: 500 }
      end
      return
    end

    respond_to do |format|
      format.js { render json: { success: true }, status: 200 }
    end
  end

  private

  def set_video
    @video = Video.find_by(id: params[:id])
  end
end
