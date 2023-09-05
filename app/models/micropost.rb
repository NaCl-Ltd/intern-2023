class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  had_many :bads, dependent: :destroy
  has_many :like_users, through: :likes,source: :user
  has_many :bad_users, through: :bads, source: :bad
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [300, 300]
  end
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 5.megabytes,
                                      message:   "should be less than 5MB" }

  def is_like(current_user_id)
    @status = Like.find_by(user_id: current_user_id, micropost_id: id).nil?
  end


  def users_like_count
    @likes = Like.where(micropost_id: id)
    # @likesの中からuser_idを取得して配列にし、ユニークな値だけを取得して@usersに代入
    @users = User.where(id: @likes.pluck(:user_id).uniq)
    @users.count
  end
end

