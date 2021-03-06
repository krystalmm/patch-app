require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { FactoryBot.create(:user) }
  describe '#new' do
    it 'responds successfully' do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    it 'login with valid information' do
      post login_path, params: { session: { email: user.email, password: user.password } }
      aggregate_failures do
        expect(response).to redirect_to user_path(user)
        expect(is_logged_in?).to be_truthy
      end
    end

    it 'does not login with a dismissed user' do
      dismissed_user = FactoryBot.create(:user, :dismissed)
      post login_path, params: { session: { email: dismissed_user.email, password: dismissed_user.password } }
      expect(response).to redirect_to signup_path
    end
  end

  describe '#destroy' do
    it 'redirects to root_path' do
      post login_path, params: { session: { email: user.email, password: user.password } }

      delete logout_path
      aggregate_failures do
        expect(response).to redirect_to root_path
        expect(is_logged_in?).to be_falsy
      end
    end

    it 'succeeds logout when user logs out on multiple tabs' do
      delete logout_path
      aggregate_failures do
        expect(response).to redirect_to root_path
        expect(is_logged_in?).to be_falsy
      end
    end
  end

  describe 'remember me' do
    it 'remembers the cookie when user checks the Remember me box' do
      log_in_as(user)
      expect(cookies[:remember_token]).to_not eq nil
    end

    it 'does not remembers the cookie when user does not checks the Remember me box' do
      log_in_as(user, remember_me: '0')
      expect(cookies[:remember_token]).to eq nil
    end
  end

  describe 'friendly forwarding' do
    let(:user) { FactoryBot.create(:user) }

    it 'succeeds redirect to users/edit' do
      get edit_user_path(user)
      log_in_as(user)
      expect(response).to redirect_to edit_user_url(user)
    end
  end
end
