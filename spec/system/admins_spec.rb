require 'rails_helper'

RSpec.describe "Admins", type: :system, js:true do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /admin" do
    it 'fails show admin page when logged in not admin user' do
      login_as(user)
      visit rails_admin_path
      expect(current_path).to eq root_path
    end
  end
end
