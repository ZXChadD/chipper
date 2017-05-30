class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:home, :index, :show]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def home
  end

  def index
    @tweets = Tweet.all.order('created_at DESC')
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user

    if @tweet.save!
    redirect_to tweets_path(@tweet)
    else render 'new'
    end
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweets_path(@tweet)
    else render 'edit'
    end
  end

  def show
    redirect_to tweets_path
  end

  def destroy
    @tweet.destroy!
    redirect_to tweets_path
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:body)
  end

end
