class Product < ApplicationRecord
  mount_uploader :product_image, ProductImageUploader

  has_many :orders, through: :order_details
  has_many :order_details

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :stock_quantity, presence: true

end
