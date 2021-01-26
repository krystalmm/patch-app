require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET /signup' do
    it 'responds successfully' do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /users/id' do
    it 'responds successfully' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /users' do
    # attributes_forを使うのは、ハッシュとなるから、パラメータに値を渡すことができるから！
    let(:user) { FactoryBot.attributes_for(:user) }
    it 'adds new user with correct signup information' do
      aggregate_failures do
        expect do
          post users_path, params: { user: user }
        end.to change(User, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_path(User.last)
      end
    end
  end
end
