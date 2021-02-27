class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def self.create_items(order, line_items)
    line_items.each do |item|
      OrderDetail.create!(
        order_id: order.id, product_id: item[:product_id], quantity: item[:quantity]
      )
      LineItem.find(item[:id]).delete
    end
  end
end
