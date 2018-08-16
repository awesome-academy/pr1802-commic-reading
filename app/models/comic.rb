class Comic < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  belongs_to :author
  has_many :follows
  has_many :rates
  has_many :chapters
  has_many :comic_categories
  has_many :categories, through: :comic_categories

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :author_id, presence: true
  validate  :picture_size

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
