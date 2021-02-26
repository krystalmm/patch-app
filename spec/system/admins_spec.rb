require 'rails_helper'

RSpec.describe 'Admins', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:admin_user) }

  describe 'GET /admin' do
    it 'fails show admin page when logged in not admin user' do
      login_as(user)
      visit rails_admin_path
      fill_in 'admin-login-email', with: user.email
      fill_in 'admin-login-password', with: user.password
      click_on 'ログインする'
      aggregate_failures do
        expect(current_path).to eq new_admin_user_session_path
        expect(page).to have_content '管理者ログイン'
      end
    end

    it 'success show admin page when logged in admin user' do
      login_as(admin_user)
      visit rails_admin_path
      fill_in 'admin-login-email', with: admin_user.email
      fill_in 'admin-login-password', with: admin_user.password
      click_on 'ログインする'
      aggregate_failures do
        expect(current_path).to eq '/admin/'
        expect(has_css?('.alert-info')).to be_truthy
      end
    end
  end
end
