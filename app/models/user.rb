class User < ApplicationRecord
  has_many :comics
  has_many :follows
  has_many :comments
  has_many :chapters
  has_many :rates
end
