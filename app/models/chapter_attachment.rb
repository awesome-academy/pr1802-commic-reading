class ChapterAttachment < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :chapter
end
