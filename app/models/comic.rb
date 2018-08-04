class Comic < ApplicationRecord
  belongs_to :user
  belongs_to :author
  has_many :follows
  has_many :rates
  has_many :chapters
  has_many :comic_categories
  has_many :categories, through: :comic_categories

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
end
