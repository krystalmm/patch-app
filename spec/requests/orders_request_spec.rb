require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:order) { FactoryBot.create(:order) }
  let(:product) { FactoryBot.create(:product) }

  describe '#new' do
    it 'responds successfully when user logged in and has line_items' do
      log_in_as(user)
      post add_item_path, params: { product_id: product.id, quantity: 1 }
      get new_order_path
      expect(response).to have_http_status(:success)
    end

    it 'fails responds when user logged in and not has line_items' do
      log_in_as(user)
      get new_order_path
      expect(response).to have_http_status(302)
    end

    it 'redirects login page when user not logged in' do
      get new_order_path
      expect(response).to redirect_to login_url
    end
  end
end
