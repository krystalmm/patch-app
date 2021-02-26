require 'rails_helper'

RSpec.describe 'Products', type: :system do
  describe '#show' do
    it 'stock_judg-icon is correct when stock_quantity is 0' do
      product = FactoryBot.create(:product, stock_quantity: 0)
      visit product_path(product)
      expect(page).to have_content '在庫 : ×'
    end

    it 'stock_judg-icon is correct when stock_quantity is 1~3' do
      product = FactoryBot.create(:product, stock_quantity: 1)
      other_product = FactoryBot.create(:product, stock_quantity: 3)
      visit product_path(product)
      expect(page).to have_content '在庫 : △'
      visit product_path(other_product)
      expect(page).to have_content '在庫 : △'
    end

    it 'stock_judg-icon is correct when stock_quantity is 4 or more' do
      product = FactoryBot.create(:product, stock_quantity: 4)
      other_product = FactoryBot.create(:product, stock_quantity: 10)
      visit product_path(product)
      expect(page).to have_content '在庫 : ○'
      visit product_path(other_product)
      expect(page).to have_content '在庫 : ○'
    end
  end
end
