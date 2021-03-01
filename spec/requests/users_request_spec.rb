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
    before { log_in_as(user) }
    it 'responds successfully' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    let(:user) { FactoryBot.attributes_for(:user) }
    it 'adds new user with correct signup information' do
      aggregate_failures do
        expect do
          post users_path, params: { user: user }
        end.to change(User, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_path(User.last)
        expect(is_logged_in?).to be_truthy
      end
    end
  end

  describe '#update' do
    let(:user) { FactoryBot.create(:user) }
    before { log_in_as(user) }

    it 'fails edit with wrong information' do
      patch user_path(user), params: { user: {
        neme: ' ', name_kana: ' ', email: 'test@invalid'
      } }
      expect(response).to have_http_status(200)
    end

    it 'succeeds edit user with correct information' do
      patch user_path(user), params: { user: {
        name: 'test user', name_kana: 'テスト　ユーザー', email: 'test@example.com'
      } }
      expect(response).to redirect_to user_path(user)
    end
  end

  describe 'before_action: :logged_in_user' do
    let(:user) { FactoryBot.create(:user) }

    it 'redirects edit when not logged in' do
      get edit_user_path(user)
      expect(response).to redirect_to login_url
    end

    it 'redirects update when not logged in' do
      patch user_path(user),  params: { user: {
        name: user.name, name_kana: user.name_kana, email: user.email
      } }
      expect(response).to redirect_to login_url
    end

    it 'redirects show when not logged in' do
      get user_path(user)
      expect(response).to redirect_to login_url
    end
  end

  describe 'before_action: :correct_user' do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    before { log_in_as(other_user) }

    it 'redirects edit when logged in as wrong user' do
      get edit_user_path(user)
      expect(response).to redirect_to user_path(other_user)
    end

    it 'redirects update when logged in as wrong user' do
      patch user_path(user), params: { user: {
        name: user.name, name_kana: user.name_kana, email: user.email
      } }
      expect(response).to redirect_to user_path(other_user)
    end

    it 'redirects show when logged in as wrong user' do
      get user_path(user)
      expect(response).to redirect_to user_path(other_user)
    end
  end
end
