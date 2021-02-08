require 'rails_helper'

RSpec.describe 'UsersEdit', type: :system do
  let(:user) { FactoryBot.create(:user) }

  it 'fails edit with wrong information' do
    login_as(user)

    click_link '会員情報変更'
    fill_in 'edit-name', with: ' '
    fill_in 'edit-name_kana', with: ' '
    fill_in 'edit-email', with: 'user@invalid'
    fill_in 'edit-user_postcode', with: '00000000'
    find("#edit-user_prefecture_code").find("option[value='1']").select_option
    fill_in 'edit-user_address_city', with: ' '
    fill_in 'edit-user_address_street', with: ' '
    fill_in 'edit-user_address_building', with: ' '
    click_button '保存する'

    expect(current_path).to eq user_path(user)
  end
end
