class MessagesController < ApplicationController
  before_action :set_user, only: %i[index]


  def index
    @micropost = Micropost.find(params[:micropost_id])
    @messages = Message.where(micropost_id: params[:micropost_id])
    @message = Message.new
  end

  def create
    @message = Message.new(user_id:current_user.id, micropost_id:params[:micropost_id], content: params[:message][:content])
    
    if @message.save
      flash[:success] = "message created!"
    end
    redirect_to request.referrer
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(content: params[:message][:content])
      flash[:success] = "message updated!"
    end
    redirect_to request.referrer
  end

  def destroy
    Message.find(params[:id]).destroy
    flash[:success] = "Message deleted"
    redirect_to request.referrer
  end

  private

  def set_user
    if current_user
      @new_micropost = current_user.feed.where("created_at >= ?", Settings.about.new.time.hours.ago).count
      @new_micropost = current_user.feed.where("created_at >= ?", Settings.about.new.time.hours.ago).limit(Settings.about.new.num)
      @new_microposts_count = @new_micropost.count
    end
  end

end
