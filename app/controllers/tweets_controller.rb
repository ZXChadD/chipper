class TweetsController < ApplicationController
  before_action :authenticate_user!, except: %i[home index show]
  before_action :set_tweet, only: %i[show edit update destroy upvote retweet]

  def feed
  end

  def home
    redirect_to tweets_path if user_signed_in?
  end

  def index
    @reply = Reply.new
    @tweet = Tweet.new
    @tweets = Tweet.all.order('created_at DESC')
    @user = current_user
    if params[:tag]
      @tweets = Tweet.tagged_with(params[:tag])
    else
      @tweets = Tweet.all.order('created_at DESC')
    end
    # if params[:search]
    #   @tweets = Tweet.search(params[:search]).order('created_at DESC')
    # else
    #   @tweets = Tweet.all.order('created_at DESC')
    # end
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

    @reply = Reply.new
    @tweets = Tweet.all.order('created_at DESC')
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

  def retweet
    if @tweet
      @retweet = current_user.tweets.build(body: @tweet.body, user_id: @tweet.user_id)
        if @retweet.save
          redirect_to tweet_path(@retweet)
          flash[:success] = "Retweet Successful!"
        else
          redirect_to user_path(current_user), notice: @retweet.errors.full_messages
        end
    else
      redirect_back_or current_user
      flash[:error] = "Retweet error!"
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
