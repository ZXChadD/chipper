# frozen_string_literal: true

class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @tweet = Tweet.new
  end

  def new
    @user = User.new
  end

  def update
    @user = User.new(avatar_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render 'show'
    end
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'following'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'following'
  end

  private

  def avatar_params
    params.require(:user).permit(:avatar)
  end

end
