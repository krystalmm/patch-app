class OrdersController < ApplicationController
  before_action :set_cart
  before_action :user_logged_in
  before_action :set_user
  before_action :set_card
  before_action :logged_in_user, only: [:create]

  require 'payjp'

  def new
    @line_items = current_cart.line_items
    if @cart.line_items.empty?
      flash[:info] = 'カートは空です'
      redirect_to current_cart
      return
    end

    if @card.present?
      customer = Payjp::Customer.retrieve(@card.customer_id)
      default_card_information = customer.cards.retrieve(@card.card_id)
      @card_info = customer.cards.retrieve(@card.card_id)
      @exp_month = default_card_information.exp_month.to_s
      @exp_year = default_card_information.exp_year.to_s.slice(2, 3)
      @card_brand = default_card_information.brand
    else
      @card = Card.new
      gon.payjpPublicKey = Rails.application.credentials[:payjp][:PAYJP_PUBLIC_KEY]
      store_location
    end
    @order = Order.new
  end

  def create
    @purchase_by_card = Payjp::Charge.create(
      amount: @cart.total_price,
      customer: @card.customer_id,
      currency: 'jpy',
      card: params['payjpToken']
    )
    @order = Order.new(order_params)
    @order.add_items(current_cart)
    if @purchase_by_card.save && @order.save!
      OrderDetail.create_items(@order, @cart.line_items)
      OrderMailer.send_when_order(current_user, @order, @order.products).deliver
      flash[:success] = '注文が完了致しました <br> マイページにて購入履歴の確認ができます'
      redirect_to current_user
    else
      flash[:danger] = '注文の登録ができませんでした'
      redirect_to new_order_path
    end
  end

  def index
    @orders = Order.where(user_id: current_user.id).page(params[:page]).per(5).order(id: 'desc')
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :card_id, :quantity, :price, :postcode, :prefecture_code, :address_city,
                                  :address_street, :address_building)
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
