class Chapter < ApplicationRecord
  belongs_to :comic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :chapter_attachments
  accepts_nested_attributes_for :chapter_attachments

  scope :title_asc,->{order title: :asc}

  def previous
    comic.chapters.where("title < ?", title).order(title: :desc).first
  end

  def next
    comic.chapters.where("title > ?", title).order(title: :asc).first
  end

  after_save :update_comic
  def update_comic
    comic.update_attributes updated_at: Time.now
  end
end
