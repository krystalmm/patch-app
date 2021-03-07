require 'rails_helper'

RSpec.describe 'Favorites', type: :system, js: true do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }

  it 'succeeds create favorites when logged in' do
    login_as(user)
    visit product_path(product)
    find('.favorites-button').click
    aggregate_failures do
      expect(page).to have_css '.fas'
      expect(page).to have_css "div#favorite-button-#{product.id}", text: '1'
    end
  end

  it 'succeeds create and destroy favorites when logged in' do
    login_as(user)
    visit product_path(product)
    find('.favorites-button').click
    find('.favorites-button').click
    expect(page).to have_css '.far'
    expect(page).to have_css "div#favorite-button-#{product.id}", text: '0'
  end
end
