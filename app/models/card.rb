class Card < ApplicationRecord
  belongs_to :user
  # has_one :order, dependent: :nullify

  require 'payjp'
  Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)

  def self.create_card_to_payjp(params)
    token = Payjp::Token.create({
      card: {
        number:    params['number'],
        cvc:       params['cvc'],
        exp_month: params['valid_month'],
        exp_year:  params['valid_year']
      }},
      {'X-Payjp-Direct-Token-Generate': 'true'}
    )
    Payjp::Customer.create(card: token.id)
  end
end
