require 'rails_helper'

RSpec.describe 'Cards', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe '#new' do
    it 'responds successfully when user logged in' do
      log_in_as(user)
      get new_card_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    before do
      payjp_customer = double('Payjp::Customer')
      payjp_list = double('Payjp::ListObject')
      payjp_card = double('Payjp::Card')
      allow(Payjp::Customer).to receive(:create).and_return(payjp_customer)
      allow(payjp_customer).to receive(:cards).and_return(payjp_list)
      allow(payjp_list).to receive(:create).and_return(payjp_card)
      allow(payjp_customer).to receive(:id).and_return('cus_xxxxxxxxxxxxx')
      allow(payjp_customer).to receive(:default_card).and_return('car_xxxxxxxxxxxxx')
    end

    it 'succeeds create a card when user logged in' do
      log_in_as(user)
      post cards_path, params: { payjpToken: 'tok_xxxxxxxx' }
      card = FactoryBot.create(:card, user_id: user.id, customer_id: 'cus_xxxxxxxxxxxxx', card_id: 'car_xxxxxxxxxxxxx')
      expect(assigns(:card).customer_id).to eq(card.customer_id)
      expect(response).to redirect_to card_path(user.id)
    end
  end
end
