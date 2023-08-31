class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def new
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.where("created_at >= ?", Settings.about.new.time.hours.ago).paginate(page: params[:page],per_page: Settings.about.new.num)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
