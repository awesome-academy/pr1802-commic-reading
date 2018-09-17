class Comic < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  belongs_to :author
  has_many :follows, dependent: :destroy
  has_many :followers, through: :follows, source: :user, dependent: :destroy
  has_many :rates
  has_many :raters, through: :rates, source: :user, dependent: :destroy
  has_many :chapters
  has_many :comic_categories
  has_many :categories, through: :comic_categories
  enum status: [ :ongoing, :completed ]

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :author_id, presence: true
  validate  :picture_size

  scope :search, ->(params_search) { where('title LIKE ?', "%#{params_search}%")}
  
  scope :rate_dsc, -> {order average_ratings: :desc}

  scope :most_recent, -> {order created_at: :desc}

  scope :updated, -> {order updated_at: :desc}

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add :picture, I18n.t('model.comic.should')
    end
  end
end
