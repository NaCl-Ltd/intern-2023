class LikesController < ApplicationController
  def create
    Like.create(user_id: current_user.id, micropost_id: params[:id])
    Logger.new("log/create.txt").debug(params[:id])
    redirect_to request.referrer
  end

  def delete
    if Like.find_by(user_id: current_user.id, micropost_id: params[:id])
      Like.find_by(user_id: current_user.id, micropost_id: params[:id]).destroy
    end
    redirect_to request.referrer
  end
  def sort_likes 
    @sort_likes = Like.where(micropost_id: params[:micropost_id]).count.sort
    p sort_likes
  end
end
