class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    
    # 画像が複数添付されている場合の処理
    # if params[:micropost][:images].present?
    #   p params[:micropost][:images].count
    #   params[:micropost][:images].each do |image|
    #     @micropost.images.attach(image)
    #   end
    # end
  
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    @micropost.deleted_flag = true
    if @micropost.save
      flash[:success] = "Micropost deleted"
    else
      flash[:alert] = "Revive Failed."
    end
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  def revive
    @micropost.deleted_flag = false
    if @micropost.save
      flash[:success] = "Micropost revived"
    else
      flash[:alert] = "Revive Failed."
    end
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end



  def deleted_post_index
    @microposts = current_user.microposts.where(deleted_flag: true)
  end
  
  def show_user
    @likes = Like.where(micropost_id: params[:id])
    # @likesの中からuser_idを取得して配列にし、ユニークな値だけを取得して@usersに代入
    @users = User.where(id: @likes.pluck(:user_id).uniq)
  end

  def bad_user
    @bads = Bad.where(micropost_id: params[:id])
    @bad_users = User.where(id: @bads.pluck(:user_id).uniq)
  end


  private

  def micropost_params
    params.require(:micropost).permit(:content, ,images:[])
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