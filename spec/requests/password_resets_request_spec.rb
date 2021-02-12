require 'rails_helper'

RSpec.describe 'PasswordResets', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe '#new' do
    it 'responds successfully' do
      get new_password_reset_path
      aggregate_failures do
        expect(response).to have_http_status(:success)
        expect(response.body).to include 'パスワードリセット'
      end
    end
  end

  describe '#create' do
    it 'fails create with invalid email' do
      post password_resets_path, params: { password_reset: { email: '' } }
      aggregate_failures do
        expect(response).to have_http_status(200)
        expect(response.body).to include 'パスワードリセット'
      end
    end

    it 'succeeds create with valid email' do
      post password_resets_path, params: { password_reset: { email: user.email } }
      aggregate_failures do
        expect(response).to redirect_to root_url
        expect(user.reset_digest).to_not eq user.reload.reset_digest
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end
    end
  end
end