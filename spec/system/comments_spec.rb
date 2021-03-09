require 'rails_helper'

RSpec.describe 'Comment', type: :system, js: true do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }
  let(:comment) { FactoryBot.create(:comment) }

  before do
    login_as(user)
    visit product_path(product)
  end

  it 'succeeds create comments with valid comment' do
    visit product_path(product)
    fill_in 'comment_comment', with: 'good!!'
    click_on '投稿する'
    expect(page).to have_content 'good!!'
    expect(page).to have_content 'レビュー件数: 1'
  end

  it 'fails create comments with invalid comment' do
    fill_in 'comment_comment', with: ' '
    click_on '投稿する'
    expect(has_css?('.alert-danger')).to be_truthy
    expect(page).to have_content 'この商品についてのレビューはまだありません。'
    expect(page).to have_content 'レビュー件数: 0'
  end

  it 'succeeds destroy comments when correct user' do
    fill_in 'comment_comment', with: 'good!!'
    click_on '投稿する'
    click_on 'レビューを削除する'
    expect(page).to have_content 'この商品についてのレビューはまだありません。'
    expect(page).to have_content 'レビュー件数: 0'
  end

  it 'does not destroy comments when not correct user' do
    other_user = FactoryBot.create(:user)
    fill_in 'comment_comment', with: 'good!!'
    click_on '投稿する'
    click_on 'マイページ'
    click_on 'ログアウト'
    login_as(other_user)
    visit product_path(product)
    expect(page).to_not have_content 'レビューを削除する'
    expect(page).to have_content 'レビュー件数: 1'
    expect(page).to have_content 'good!!'
  end
end
