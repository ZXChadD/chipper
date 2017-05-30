class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:home, :index, :show]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def home
  end

  def index
    @tweets = Tweet.all
  end


  private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end
