class Image < ActiveRecord::Base
  mount_uploader :file, FileUploader
  validates :file, presence: true
end
