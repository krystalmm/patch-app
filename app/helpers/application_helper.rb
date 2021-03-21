module ApplicationHelper
  def card_src(card_brand)
    case card_brand
    when 'Visa'
      card_src = 'icon_visa.png'
    when 'JCB'
      card_src = 'icon_jcb.png'
    when 'MasterCard'
      card_src = 'icon_mastercard.png'
    when 'American Express'
      card_src = 'icon_amex.png'
    when 'Diners Club'
      card_src = 'icon_diners.png'
    when 'Discover'
      card_src = 'icon_discover.png'
    end
    card_src
  end

  def order_quantity(product, order)
    order = OrderDetail.find_by(product_id: product.id, order_id: order.id)
    order.quantity
  end

  def change_consumption_tax(price)
    tax = 1.1
    (price * tax).round(2).ceil
  end

  def subtotal(price, quantity)
    price * quantity
  end
end
