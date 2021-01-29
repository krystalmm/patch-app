require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /login' do
    it 'responds successfully' do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
end
