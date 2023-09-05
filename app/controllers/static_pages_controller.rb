class StaticPagesController < ApplicationController

  before_action :set_user, only: %i[home new help about contact]

  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @fixed_item= current_user.microposts.where(fixed: :true)
    end
  end

  def new
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.where("created_at >= ?", Settings.about.new.time.hours.ago).limit(Settings.about.new.num)
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  private 

  def set_user
    if logged_in?
      @new_micropost = current_user.feed.where("created_at >= ?", Settings.about.new.time.hours.ago).limit(Settings.about.new.num)
      @new_microposts_count = @new_micropost.count
    end
  end

end
