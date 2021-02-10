require 'rails_helper'

RSpec.describe 'UsersDismissed', type: :request do
  let(:user) { FactoryBot.create(:user) }
  describe '#unsubscribe' do
    it 'responds successfully' do
      get confirm_unsubscribe_path(user)
      expect(response).to be_successful
    end
  end

  describe '#withdraw' do
    let(:user) { FactoryBot.create(:user) }
    it 'succeeds dismissed' do
      
    end
  end
end





