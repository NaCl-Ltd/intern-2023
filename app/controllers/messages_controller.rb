class MessagesController < ApplicationController
  def index
    @micropost = Micropost.find(params[:micropost_id])
    @messages = Message.where(micropost_id: params[:micropost_id])
  end

  def new

  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
