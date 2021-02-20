require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryBot.create(:product) }

  it 'has a valid factory' do
    expect(product).to be_valid
  end

  it 'is invalid without name' do
    product.name = ' '
    expect(product).to be_invalid
  end

  it 'is invalid with a duplicate name' do
    FactoryBot.create(:product, name: 'duplicate')
    product = FactoryBot.build(:product, name: 'duplicate')
    expect(product).to be_invalid
  end

  it 'is invalid without price' do
    product.price = nil
    expect(product).to be_invalid
  end

  it 'is invalid with a not numerical price' do
    product.price = '一万'
    expect(product).to be_invalid
  end

  it 'is invalid without description' do
    product.description = ' '
    expect(product).to be_invalid
  end

  it 'does not have too long description' do
    product.description = 'a' * 1001
    expect(product).to be_invalid
  end

  it 'is invalid without stock_quantity' do
    product.stock_quantity = nil
    expect(product).to be_invalid
  end
end
