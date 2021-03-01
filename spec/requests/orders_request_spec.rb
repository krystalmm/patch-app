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

  describe '#create' do
    let(:order) { FactoryBot.attributes_for(:order) }

    before do
      payjp_customer = double('Payjp::Customer')
      payjp_list = double('Payjp::ListObject')
      payjp_card = double('Payjp::Card')
      charge_mock = double(:charge_mock)
      allow(Payjp::Customer).to receive(:create).and_return(payjp_customer)
      allow(payjp_customer).to receive(:cards).and_return(payjp_list)
      allow(payjp_list).to receive(:create).and_return(payjp_card)
      allow(payjp_customer).to receive(:id).and_return('cus_xxxxxxxxxxxxx')
      allow(payjp_customer).to receive(:default_card).and_return('car_xxxxxxxxxxxxx')
      allow(Payjp::Charge).to receive(:create).and_return(charge_mock)
      allow(charge_mock).to receive(:save).and_return(charge_mock)
      allow(charge_mock).to receive(:price).and_return(10000)
    end

    it 'succeeds create order when user logged in' do
      log_in_as(user)
      post cards_path, params: { payjpToken: 'tok_xxxxxxxx' }
      card = FactoryBot.create(:card, user_id: user.id, customer_id: 'cus_xxxxxxxxxxxxx', card_id: 'car_xxxxxxxxxxxxx')
      aggregate_failures do
        expect do
          post orders_path, params: { order: order }
        end.to change(Order, :count).by(1)
        expect(response).to redirect_to user_path(user)
      end
    end

    it 'redirects login page when user not logged in' do
      post orders_path, params: { order: order }
      expect(response).to redirect_to login_url
    end
  end

  describe '#index' do
    let(:order) { FactoryBot.create(:order) }

    it 'responds successfully when user logged in' do
      log_in_as(user)
      get orders_path
      expect(response).to have_http_status(:success)
    end

    it 'redirects login page when user not logged in' do
      get orders_path
      expect(response).to redirect_to login_url
    end
  end
end
