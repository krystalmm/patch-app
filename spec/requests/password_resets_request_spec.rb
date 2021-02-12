require 'rails_helper'

RSpec.describe 'PasswordResets', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { user.create_reset_digest }

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

  describe '#edit' do
    # メールアドレスが無効な時
    context 'when user sends correct token and wrong email' do
      before { get edit_password_reset_path(user.reset_token, email: '') }

      it 'fails' do
        expect(response).to redirect_to root_url
      end
    end

    # 退会済みのユーザーのとき
    context 'when dismissed user sends correct token and email' do
      before do
        user.toggle!(:is_valid)
        get edit_password_reset_path(user.reset_token, email: user.email)
      end

      it 'fails' do
        expect(response).to redirect_to root_url
      end
    end

    # メールアドレスが有効で、トークンが無効な時
    context 'when user sends wrong token and correct email' do
      before { get edit_password_reset_path('wrong', email: user.email) }

      it 'fails' do
        expect(response).to redirect_to root_url
      end
    end

    # メールアドレスもトークンも有効な時
    context 'when user sends correct token and correct email' do
      before { get edit_password_reset_path(user.reset_token, email: user.email) }

      it 'succeeds' do
        aggregate_failures do
          expect(response).to have_http_status(200)
          expect(response.body).to include 'パスワード再設定'
        end
      end
    end
  end

  describe '#update' do
    # 無効なパスワードとパスワード確認
    context 'when user sends wrong password' do
      before do
        patch password_reset_path(user.reset_token),
              params: {
                email: user.email,
                user: { password: 'foobarbaz', password_confirmation: 'bazbarfoo' }
              }
      end

      it 'fails' do
        aggregate_failures do
          expect(response).to have_http_status(200)
          expect(response.body).to include 'パスワード再設定'
        end
      end
    end

    # パスワードが空
    context 'when user sends blank password' do
      before do
        patch password_reset_path(user.reset_token),
              params: {
                email: user.email,
                user: { password: ' ', password_confirmation: ' ' }
              }
      end

      it 'fails' do
        aggregate_failures do
          expect(response).to have_http_status(200)
          expect(response.body).to include 'パスワード再設定'
        end
      end
    end

    # 有効なパスワードとパスワード確認
    context 'when user sends correct password' do
      before do
        patch password_reset_path(user.reset_token),
              params: {
                email: user.email,
                user: { password: 'foobarbaz', password_confirmation: 'foobarbaz' }
              }
      end

      it 'succeeds' do
        aggregate_failures do
          expect(response).to redirect_to user
          expect(is_logged_in?).to be_truthy
          # パスワード再設定が成功したらダイジェストをnilにする
          expect(user.reload.reset_digest).to eq nil
        end
      end
    end
  end

  describe 'check_expiration' do
    # パスワード再設定の期限切れ
    context 'when user updates after 25hours' do
      before do
        user.update_attribute(:reset_sent_at, 25.hours.ago)
        patch password_reset_path(user.reset_token),
              params: {
                email: user.email,
                user: { password: 'foobarbaz', password_confirmation: 'foobarbaz' }
              }
      end

      it 'fails' do
        expect(response).to redirect_to new_password_reset_url
      end
    end
  end
end
