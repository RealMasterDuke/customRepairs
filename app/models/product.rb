class Product < ActiveRecord::Base
  mount_uploader :image, PictureUploader

  belongs_to :category

  before_save :default_values
  def default_values
    self.category_id ||= 1
  end
end
