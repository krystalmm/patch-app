require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe '#new' do
    it 'responds successfully' do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end
end
