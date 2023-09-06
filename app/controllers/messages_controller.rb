class MessagesController < ApplicationController

  def index
    @micropost = Micropost.find(params[:micropost_id])
    @messages = Message.where(micropost_id: params[:micropost_id])
    @message = Message.new
  end

  def new
    
  end

  def edit
  end

  def create
    @message = Message.new(user_id:current_user.id, micropost_id:params[:micropost_id], content: params[:message][:content])
    
    if @message.save
      flash[:success] = "messages created!"
    end
    redirect_to request.referrer
  end

  def update
  end

  def destroy
  end

  private

end
