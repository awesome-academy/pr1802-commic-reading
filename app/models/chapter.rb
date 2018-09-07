class Chapter < ApplicationRecord
  belongs_to :comic
  belongs_to :user
  has_many :comments
  has_many :chapter_attachments
  accepts_nested_attributes_for :chapter_attachments
end
