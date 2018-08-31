class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :comic
  validates :rate, presence: true
  validates :user_id, uniqueness: { scope: :comic_id }

  after_save :update_average_ratings

  private
  def update_average_ratings
    average_ratings = comic.rates.collect(&:rate).sum / comic.rates.count.to_f
    comic.update_attributes average_ratings: average_ratings
  end
end
