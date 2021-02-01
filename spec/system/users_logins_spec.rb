require 'rails_helper'

RSpec.describe 'UsersLogins', type: :system, js: true do
  let(:user) { FactoryBot.create(:user) }

  # フラッシュメッセージ（エラー）の残留がないかどうかのテスト
  it "don't login when user submits invalid information" do
    visit login_path
    fill_in 'login-email', with: 'testinvalid@example.com' #js trueにしてるから空文字だとjqueryのほうがうごいてしまう！
    fill_in 'login-password', with: 'password'
    click_button 'ログインする'
    aggregate_failures do
      expect(current_path).to eq login_path
      expect(has_css?('.alert-danger')).to be_truthy
      visit current_path
      expect(has_css?('.alert-danger')).to be_falsy
    end
  end

  # 有効な値の時ユーザーはログイン・ログアウトできること
  it "login succeeds when user submits valid information followed by logout" do
    visit login_path
    fill_in 'login-email', with: user.email
    fill_in 'login-password', with: user.password
    click_button 'ログインする'
    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(page).to_not have_link 'ログイン'
      expect(page).to have_link 'マイページ', href: user_path(user)
    end

    click_link 'ログアウト'
    aggregate_failures do
      expect(current_path).to eq root_path
      expect(page).to have_link 'ログイン', href: login_path
      expect(page).to_not have_link 'マイページ'
    end
  end
end
