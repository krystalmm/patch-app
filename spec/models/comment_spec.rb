require 'rails_helper'

RSpec.describe 'Comment', type: :model do
  let(:comment) { FactoryBot.create(:comment) }

  it 'has a valid factory' do
    expect(comment).to be_valid
  end

  it 'is invalid without comment' do
    comment.comment = ' '
    expect(comment).to be_invalid
  end

  it 'does not have too long comment' do
    comment.comment = 'a' * 801
    expect(comment).to be_invalid
  end

  it 'is invalid without user' do
    comment.user_id = nil
    expect(comment).to be_invalid
  end

  it 'is invalid without product' do
    comment.product_id = nil
    expect(comment).to be_invalid
  end
end
