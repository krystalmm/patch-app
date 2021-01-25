require 'rails_helper'

RSpec.describe "UsersSignups", type: :system do
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

end
