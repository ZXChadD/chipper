class LikesController < ApplicationController

  def create
    @like = Like.new(params[:id])

    @like.count += 1
    redirect_to tweets_path
  end


  private

  def like_params
     params.require(:tweet_id).permit(:user_id)
  end

end
