class OrdersController < ApplicationController
  before_action :set_cart
  before_action :user_logged_in
  before_action :set_user
  before_action :set_card

  require 'payjp'

  def new
    @line_items = current_cart.line_items
    return unless @cart.line_items.empty?

    flash[:info] = 'カートは空です'
    redirect_to current_cart
    if @card.present?
      customer = Payjp::Customer.retrieve(@card.customer_id)
      default_card_information = customer.cards.retrieve(@card.card_id)
      @card_info = customer.cards.retrieve(@card.card_id)
      @exp_month = default_card_information.exp_month.to_s
      @exp_year = default_card_information.exp_year.to_s.slice(2,3)
      @card_brand = default_card_information.brand
    else
      @card = Card.new
      gon.payjpPublicKey = Rails.application.credentials[:payjp][:PAYJP_PUBLIC_KEY]
    end
    @order = Order.new
  end

  def create; end

  private

  def order_params
    params.permit(:user_id, :card_id, :quantity, :price)
  end

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  def user_logged_in
    return if logged_in?

    store_location
    flash[:danger] = '購入画面に進むにはログインが必要です'
    redirect_to login_url
  end
end
