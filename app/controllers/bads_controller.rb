class BadsController < ApplicationController
  def create
    Bad.create(user_id: current_user.id, micropost_id: params[:id])
    redirect_to request.referrer
  end

  def destroy
    if Bad.find_by(user_id: current_user.id, micropost_id: params[:id])
      Bad.find_by(user_id: current_user.id, micropost_id: params[:id]).destroy
    end
    redirect_to request.referrer
  end
end
