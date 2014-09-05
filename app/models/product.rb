class Product < ActiveRecord::Base
  mount_uploader :image, PictureUploader

  belongs_to :category
end
