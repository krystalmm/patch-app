require 'rails_helper'

RSpec.describe 'UsersLogins', type: :system do
  # フラッシュメッセージ（エラー）の残留がないかどうかのテスト
  it "don't login when user submits invalid information" do
    visit login_path
    fill_in 'login-email', with: ' '
    fill_in 'login-password', with: ' '
    click_button 'ログインする'
    aggregate_failures do
      expect(current_path).to eq login_path
      expect(has_css?('.alert-danger')).to be_truthy
      visit current_path
      expect(has_css?('.alert-danger')).to be_falsy
    end
  end
end
