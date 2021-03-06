require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:product) { FactoryBot.create(:product) }

  describe '#index' do
    it 'responds successfully' do
      get products_path
      expect(response).to have_http_status(:success)
    end

    it 'responds successfully when params[:option] hp' do
      get '/products/?option=hp'
      expect(response).to have_http_status(:success)
    end

    it 'responds successfully when params[:option] cp' do
      get '/products/?option=cp'
      expect(response).to have_http_status(:success)
    end
  end

  describe '#show' do
    it 'responds  successfully' do
      get product_path(product)
      expect(response).to have_http_status(:success)
    end
  end
end
