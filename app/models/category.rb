class Category < ApplicationRecord
  has_many :comic_categories
  has_many :comics, through: :comic_categories
  validates :name, presence: true
end
