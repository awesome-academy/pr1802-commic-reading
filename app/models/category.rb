class Category < ApplicationRecord
  has_many :comic_categories
  has_many :comics, through: :comic_categories
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true
end
