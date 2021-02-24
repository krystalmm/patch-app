require 'rails_helper'

RSpec.describe "Carts", type: :request do
  describe 'POST /add_item' do
    let(:product) { FactoryBot.create(:product) }
    it 'succeeds add item' do
      aggregate_failures do
        expect do
          post add_item_path, params: { product_id: product.id, quantity: 1 }
        end.to change(LineItem, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to cart_path(Cart.last)
      end
    end
  end

  describe 'GET /carts/:id' do
    let(:cart) { FactoryBot.create(:cart) }
    it 'responds successfully' do
      get cart_path(cart)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /update_item' do
    let(:product) { FactoryBot.create(:product) }
    let(:line_item) { FactoryBot.create(:line_item, product_id: product.id) }
    it 'succeeds update item quantity' do
      expect(line_item.quantity).to eq 1
      post update_item_path, params: { quantity: 3 }
      expect(line_item.quantity).to eq 3
    end
  end
end
