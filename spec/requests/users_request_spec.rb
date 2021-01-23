require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe '#new' do
    it 'responds successfully' do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#show' do
    it 'responds successfully' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end
end
