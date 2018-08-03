class ComicCategory < ApplicationRecord
  belongs_to :category
  belongs_to :comic
end
