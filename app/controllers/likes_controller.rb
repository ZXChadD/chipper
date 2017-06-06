class LikesController < ApplicationController

  def create
    byebug
    @tweet = Tweet.find(params[:id])

    @like = @tweet.likes.new(like_params)
    @like.user = current_user

    if @like.save
      redirect_to tweets_path
    end
  end


private
  def like_params
     params.require(:likes).permit(:user_id, :tweet_id)
  end
end
