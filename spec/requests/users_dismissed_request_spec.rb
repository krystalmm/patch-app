require 'rails_helper'

RSpec.describe 'UsersDismissed', type: :request do
  describe '#unsubscribe' do
    let(:user) { FactoryBot.create(:user) }
    before { log_in_as(user) }

    it 'responds successfully' do
      get confirm_unsubscribe_path(user)
      expect(response).to be_successful
    end
  end

  describe '#withdraw' do
    let(:user) { FactoryBot.create(:user) }
    before { log_in_as(user) }

    it 'succeeds dismissed' do
      patch withdraw_user_path(user)
      expect(response).to redirect_to root_url
    end
  end

  describe 'before_action: :logged_in_user' do
    let(:user) { FactoryBot.create(:user) }
    it 'redirects unsubscribe when not logged in' do
      get confirm_unsubscribe_path(user)
      expect(response).to redirect_to login_url
    end

    it 'redirects withdraw when not logged in' do
      patch withdraw_user_path(user)
      expect(response).to redirect_to login_url
    end
  end

  describe 'before_action: :correct_user' do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    before { log_in_as(other_user) }

    it 'redirects unsubscribe when logged in as wrong user' do
      get confirm_unsubscribe_path(user)
      expect(response).to redirect_to user_path(other_user)
    end

    it 'redirects withdraw when logged in as wrong user' do
      patch withdraw_user_path(user)
      expect(response).to redirect_to user_path(other_user)
    end
  end

  describe 'before_action: :not_dismissed_user' do
    let(:dissmissed_user) { FactoryBot.create(:user, :dismissed) }

    it 'redirects password_resets when dismissed user' do
      post password_resets_path, params: { password_reset: { email: dissmissed_user.email } }
      expect(response).to redirect_to signup_path
    end
  end
end





