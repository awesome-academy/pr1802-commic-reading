class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :chapter
  validates :content, presence: true

  scope :order_created_desc, -> {order created_at: :desc}
end
