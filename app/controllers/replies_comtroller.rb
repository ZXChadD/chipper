class RepliesController < ApplicationController
  before_action :authenticatr_user!

  def create
    @reply = @Tweet.replies.new(replies_params)
    @reply.user = current_user
    if @reply.save!
      redirect_to tweet_path(@tweet)
    end
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:topic_id])
  end

end
