require 'rails_helper'

RSpec.describe 'UsersSignups', type: :system do
  # 無効なデータを登録できないこと
  it "Don't create new data when user submits invalid information" do
    visit signup_path
    fill_in 'form-name', with: ' '
    fill_in 'form-name_kana', with: 'kana'
    fill_in 'form-email', with: 'user@invalid'
    fill_in 'password', with: 'foo'
    fill_in 'password_confirmation', with: 'bar'
    click_on '保存する'
    expect(current_path).to eq users_path
    expect(page).to have_content '必須項目です'
  end

  # フラッシュメッセージ（success）が表示されること
  it 'Create new data when user submits valid information' do
    visit signup_path
    fill_in 'form-name', with: 'example user'
    fill_in 'form-name_kana', with: 'イグザンプル　ユーザー'
    fill_in 'form-email', with: 'user@example.com'
    fill_in 'password', with: 'password'
    fill_in 'password_confirmation', with: 'password'
    click_on '保存する'
    aggregate_failures do
      expect(current_path).to eq user_path(User.last)
      expect(has_css?('.alert-success')).to be_truthy
      visit current_path
      expect(has_css?('.alert-success')).to be_falsy
    end
  end
end
