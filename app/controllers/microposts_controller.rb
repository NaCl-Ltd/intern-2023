class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy,:fixed]
  before_action :correct_user,   only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  def show_user
    @likes = Like.where(micropost_id: params[:id])
    # @likesの中からuser_idを取得して配列にし、ユニークな値だけを取得して@usersに代入
    @users = User.where(id: @likes.pluck(:user_id).uniq)
  end
  def fixed
    current_user.microposts.update_all(fixed: false)
    @micropost = current_user.microposts.find_by(id: params[:id])
    if @micropost
      @micropost.update(fixed: true)
      @fixed_item = @micropost
      flash[:success] = "固定しました"
      redirect_to root_url
    else
      flash[:error] = "Micropost not found."
      redirect_to root_url
    end
  end


  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @micropost.nil?
  end

  def count_like
    @count = Like.where(micropost_id: params[:micropost_id]).count
  end

  def is_like
    @status = Like.find_by(user_id: current_user.id, micropost_id: params[:micropost_id]).nil?
  end

end
