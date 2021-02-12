require 'rails_helper'

RSpec.describe 'UsersEdit', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
    click_link '会員情報変更'
  end

  it 'fails edit with wrong information' do
    fill_in 'edit-name', with: ' '
    fill_in 'edit-name_kana', with: ' '
    fill_in 'edit-email', with: 'user@invalid'
    fill_in 'edit-user_postcode', with: '00000000'
    find('#edit-user_prefecture_code').find("option[value='1']").select_option
    fill_in 'edit-user_address_city', with: ' '
    fill_in 'edit-user_address_street', with: ' '
    fill_in 'edit-user_address_building', with: ' '
    click_button '保存する'

    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(has_css?('.alert-danger')).to be_truthy
    end
  end

  it 'succeeds edit with correct information' do
    fill_in 'edit-name', with: 'test user'
    fill_in 'edit-name_kana', with: 'テスト　ユーザー'
    fill_in 'edit-email', with: 'test@example.com'
    fill_in 'edit-user_postcode', with: '5300001'
    find('#edit-user_prefecture_code').find("option[value='27']").select_option
    fill_in 'edit-user_address_city', with: '大阪市北区'
    fill_in 'edit-user_address_street', with: '梅田'
    fill_in 'edit-user_address_building', with: ' '
    click_button '保存する'

    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(has_css?('.alert-success')).to be_truthy
    end
  end
end
