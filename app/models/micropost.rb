class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many_attached :images do |attachable|
    attachable.variant :display, resize_to_limit: [300, 300]
  end
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :validate_images
  
  # 最大4つの画像を添付できるようにする
  MAX_IMAGES = 4

  def validate_images
    if images.attached?
      if images.count > MAX_IMAGES
        errors.add(:images, "は最大#{MAX_IMAGES}枚まで添付できます")
      end

      images.each do |image|
        if !image.content_type.in?(%w[image/jpeg image/gif image/png])
          errors.add(:images, "のフォーマットはJPEG、GIF、PNGのいずれかである必要があります")
        end

        if image.byte_size > 5.megabytes
          errors.add(:images, "は5MB以下である必要があります")
        end
      end
    end
  end

end
