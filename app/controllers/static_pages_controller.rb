class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost = current_user.microposts.build(deleted_flag: false)
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def deleted_post_index
    if logged_in?
      @microposts = current_user.microposts.build(deleted_flag: true)
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
  def help
  end

  def about
  end

  def contact
  end
end
