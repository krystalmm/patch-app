class Order < ApplicationRecord
  belongs_to :user
  belongs_to :card
  has_many :products, through: :order_details
  has_many :order_details, dependent: :destroy

  enum postage: { burden: 0, free: 1 }
  enum status: { 支払い済み: 0, 配送準備中: 1, 配送済み: 2 }

  def add_items(cart)
    cart.line_items.target.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
