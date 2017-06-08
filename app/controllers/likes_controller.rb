class LikesController < ApplicationController

  def create
    @like = Like.create(user_id: params[current_user], tweet_id: params[tweet_id])

    if @like.save
      redirect_to tweets_path
    end
  end


private
  def like_params
     params.require(:likes).permit(:current_user, :tweet)
  end
end
