# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def send_when_order
    user = User.first
    order = Order.first
    items = order.products
    OrderMailer.send_when_order(user, order, items)
  end
end
