class Order < ActiveRecord::Base
  has_many :product
  belongs_to :user
end
