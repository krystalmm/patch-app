require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }

  describe '#new' do
    it 'responds successfully when user logged in and has line_items' do
      log_in_as(user)
      cart = FactoryBot.create(:cart)
      line_item = FactoryBot.create(:line_item, cart_id: cart.id, product_id: product.id)
      get new_order_path
      expect(response).to redirect_to cart_path(cart)
    end

    it 'fails responds when user not logged in' do
      get new_order_path
      expect(response).to redirect_to login_url
    end
  end
end
