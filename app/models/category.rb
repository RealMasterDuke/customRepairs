class Category < ActiveRecord::Base
  mount_uploader :image, PictureUploader

  has_many :products
end
