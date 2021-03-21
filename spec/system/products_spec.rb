require 'rails_helper'

RSpec.describe 'Products', type: :system do
  describe '#show' do
    let(:product) { FactoryBot.create(:product) }
    let(:stock1) { FactoryBot.create(:product, :stock_1) }
    let(:stock0) { FactoryBot.create(:product, :stock_0) }

    it 'correct stock_quantity' do
      visit product_path(product)
      expect(page).to have_content "在庫 : 10"
      visit product_path(stock1)
      expect(page).to have_content "在庫 : 残り1つ"
      visit product_path(stock0)
      expect(page).to have_content "在庫 : なし"
    end
  end
end
