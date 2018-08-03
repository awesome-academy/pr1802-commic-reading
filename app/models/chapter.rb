class Chapter < ApplicationRecord
  belongs_to :comic
  belongs_to :user
  has_many :comments
end
