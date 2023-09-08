class MessagesController < ApplicationController
  before_action :set_user, only: %i[index new edit]

  def new
    @micropost = Micropost.find(params[:micropost_id])
    @message = Message.new
  end

  def edit
    @message = Message.find(params[:id])
  end


  def index
    @micropost = Micropost.find(params[:micropost_id])
    @messages = Message.where(micropost_id: params[:micropost_id])
    @message = Message.new
  end

  def create
    @message = Message.new(user_id:current_user.id, micropost_id:params[:micropost_id], content: params[:message][:content])
    if @message.save
      flash[:info] = "message created!"
      redirect_to micropost_messages_path(@message.micropost)
    else
      @micropost = @message.micropost
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(content: params[:message][:content])
      flash[:info] = "message updated!"
      redirect_to micropost_messages_path(@message.micropost)
    else
      @micropost = @message.micropost
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.destroy
      flash[:success] = "Message deleted"
    end
    redirect_to request.referrer, status: :see_other
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
