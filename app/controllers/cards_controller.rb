class CardsController < ApplicationController
  before_action :set_card, only: [:new, :show, :destroy]
  before_action :set_payjp_secret_key, except: :new
  before_action :set_cart
  before_action :set_user

  require 'payjp'

  def new
    redirect_to card_path(current_user.id) if @card.present?
    @card = Card.new
    gon.payjpPublicKey = Rails.application.credentials[:payjp][:PAYJP_PUBLIC_KEY]
  end

  def create
    render action: :new if params['payjpToken'].blank?
    customer = Payjp::Customer.create(
      card: params['payjpToken']
    )
    @card = Card.new(
      card_id: customer.default_card,
      user_id: current_user.id,
      customer_id: customer.id
    )
    if @card.save
      flash[:success] = 'クレジットカードの登録が完了致しました'
      redirect_to card_path(current_user.id)
    else
      flash[:danger] = 'クレジットカードの登録に失敗しました'
      redirect_to new_card_path
    end
  end

  def show
    redirect_to new_card_path if @card.blank?
    customer = Payjp::Customer.retrieve(@card.customer_id)
    default_card_information = customer.cards.retrieve(@card.card_id)
    @card_info = customer.cards.retrieve(@card.card_id)
    @exp_month = default_card_information.exp_month.to_s
    @exp_year = default_card_information.exp_year.to_s.slice(2, 3)
    @card_brand = default_card_information.brand
  end

  def destroy
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @card.destroy
    customer.delete
    flash[:info] = 'クレジットカードが削除されました'
    redirect_to user_path(current_user)
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first
  end

  def set_payjp_secret_key
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
  end
end
