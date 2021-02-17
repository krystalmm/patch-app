require 'rails_helper'

RSpec.describe 'Admins::Pages', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:user, :admin) }

  describe 'GET /admin' do
    it 'responds successfully as admin_user' do
      log_in_as(admin_user)
      get rails_admin_path
      expect(response).to have_http_status(:success)
    end
  end
end
