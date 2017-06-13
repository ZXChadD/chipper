class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def new
    @reply = Reply.new
  end

  def create
    @reply = @tweet.replies.new(reply_params)
    @reply.user = current_user
    if @reply.save!
    create_notification
    redirect_to tweets_path
    end
  end



  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def reply_params
    params.require(:reply).permit(:body, :tweet_id)
  end

  def create_notification
    @users = User.all
    (@users.uniq - [current_user]).each do |user|
    Notification.create(recipient: user, actor: current_user, action: "posted", notifiable: @reply)
    end
  end

end
