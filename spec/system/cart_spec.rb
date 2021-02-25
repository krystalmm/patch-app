require 'rails_helper'

RSpec.describe 'Cart', type: :system, js:true do
  let(:cart) { FactoryBot.create(:cart) }
  let(:product) { FactoryBot.create(:product) }
  let(:line_item) { FactoryBot.create(:line_item, cart_id: cart.id, product_id: product.id) }

  it 'succeeds add item in cart' do
    visit product_path(product)
    click_on "カートに入れる"
    aggregate_failures do
      expect(page).to have_content 'ショッピングカート'
      expect(has_css?('.alert-success')).to be_truthy
      expect(page).to have_content product.name
    end
  end

  it 'succeeds update item quantity in cart' do
    visit product_path(product)
    click_on "カートに入れる"
    fill_in 'quantity', with: 3
    click_on '更新'
    expect(page).to have_xpath("//input[@value='3']")
  end

  it 'succeeds delete item' do
    visit product_path(product)
    click_on "カートに入れる"
    click_on "削除する"
    expect(has_css?('.alert-info')).to be_truthy
    expect(page).to have_content '現在カートに商品はありません'
  end
end
