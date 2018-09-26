class Chapter < ApplicationRecord
  belongs_to :comic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :chapter_attachments
  accepts_nested_attributes_for :chapter_attachments

  scope :title_asc,->{order title: :asc}

  after_save :update_comic
  def update_comic
    self.comic.update_attributes updated_at: Time.now
  end
end
