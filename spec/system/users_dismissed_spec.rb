require 'rails_helper'

RSpec.describe 'UsersDismissed', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
    click_on '退会をご希望の方はこちらから'
    click_link '退会する'
  end

  it 'succeeds dismissed with correct_user' do
    aggregate_failures do
      expect(current_path).to eq root_path
      expect(has_css?('.alert-primary')).to be_truthy
      expect(page).to have_content 'またのご利用を心よりお待ちしております'
    end
  end

  it 'fails login with dismissed user' do
    click_link 'ログイン', match: :first
    fill_in 'login-email', with: user.email
    fill_in 'login-password', with: user.password
    click_on 'ログインする'
    aggregate_failures do
      expect(current_path).to eq signup_path
      expect(has_css?('.alert-danger')).to be_truthy
      expect(page).to have_content '退会済みです'
    end
  end
end
