class OrdersController < ApplicationController
  before_action :set_cart
  before_action :user_logged_in
  before_action :set_user
  before_action :set_card

  require 'payjp'

  def new; end

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
