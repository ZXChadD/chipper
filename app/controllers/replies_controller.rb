class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def new
    byebug
    @reply = Reply.new
  end

  def create
    @reply = @tweet.replies.new(reply_params)
    @reply.user = current_user
    if @reply.save!
      redirect_to tweet_path(@tweet)
    end
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
  def reply_params
    params.require(:reply).permit(:body,:tweet_id)
  end

end
