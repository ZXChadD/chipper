# frozen_string_literal: true

class AdminController < ApplicationController

  before_action :authenticate_user!
  before_action :is_admin?
  before_action :find_user, only: [:destroy]

  def index
    @users = User.all
    @tweets = Tweet.find_by(params[:user_id])
  end

  def is_admin?
    redirect_to new_user_session_path unless current_user.is_admin
  end

  def destroy
    @user.destroy!
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
