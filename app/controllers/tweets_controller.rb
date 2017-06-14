class TweetsController < ApplicationController
  before_action :authenticate_user!, except: %i[home index show]
  before_action :set_tweet, only: %i[show edit update destroy upvote]

  def feed
  end

  def home
    redirect_to tweets_path if user_signed_in?
  end

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.order('created_at DESC')
    @user = current_user
    if params[:id]
      @tweets = Tweet.tagged_with(params[:tag])
    else
      @tweets = Tweet.all.order('created_at DESC')
    end
    if params[:search]
      @tweets = Tweet.search(params[:search]).order('created_at DESC')
    else
      @tweets = Tweet.all.order('created_at DESC')
    end
  end

  # def new
  #   @tweet = Tweet.new
  # end

  def create
    @tweets = Tweet.all.order('created_at DESC')
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user

    respond_to do |format|
      if @tweet.save
        format.js
      else
        format.js
      end
    end
 end

  def edit; end

  def update
    if @tweet.update_attributes(tweet_params)
      redirect_to tweets_path
    else
      render :edit
    end
  end

  def show
    redirect_to tweets_path
  end

  def destroy
    @tweet.destroy!
    redirect_to tweets_path
  end

  def upvote
    @tweet = Tweet.find(params[:id])
    @like = @tweet.likes.create(user_id: current_user.id)

    respond_to do |format|
      if @like.save
        format.js
      else
        format.js { render action: 'index' }
      end
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:body, :all_tags)
  end

end
