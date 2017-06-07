class LikesController < ApplicationController

  def create
    @like = Like.new(tweet_id = like_params[:tweet], user_id = like_params[:current_user])

    if @like.save
      redirect_to tweets_path
    end
  end


private
  def like_params
     params.require(:likes).permit(:current_user, :tweet)
  end
end
