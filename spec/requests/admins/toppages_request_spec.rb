require 'rails_helper'

RSpec.describe "Admins::Toppages", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:user, :admin) }

  describe "GET /index" do
    it "responds successfully as admin_user" do
      log_in_as(admin_user)
      get admins_root_path
      expect(response).to have_http_status(:success)
    end

    it 'redirects admins when user not admin' do
      log_in_as(user)
      get admins_root_path
      expect(response).to redirect_to root_path
    end
  end

end
