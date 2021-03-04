class OrderMailer < ApplicationMailer
  helper ApplicationHelper

  def send_when_order(user, order, items)
    @user = user
    @order = order
    @items = items
    mail to: user.email, subject: 'ご注文内容の詳細'
  end
end
