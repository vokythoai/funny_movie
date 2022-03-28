# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :user

  def share_movie; end

  def share
    cmd_share = Users::Video::Share.call(user: current_user, params: params)
    if cmd_share.success?
      flash.now[:success] = 'Share video successfully!'
      redirect_to root_path
    else
      flash.now[:alert] = cmd_share.errors.full_messages.to_sentence
      render :share_movie
    end
  end

  private

  def user
    @user ||= current_user
  end
end
