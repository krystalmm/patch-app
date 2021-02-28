module OrdersHelper
  def has_card
    Card.find_by(user_id: current_user.id)
  end

  def order_quantity(product)
    order = OrderDetail.find_by(product_id: product.id, order_id: @order.id)
    order.quantity
  end
end
