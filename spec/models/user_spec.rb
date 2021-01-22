require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(user).to be_valid
  end

  # 名前がなければ無効であること
  it "is invalid without name" do
    user.name = " "
    expect(user).to be_invalid
  end

  # メールアドレスがなければ無効であること
  it "is invalid without email" do
    user.email = " "
    expect(user).to be_invalid
  end

  # ユーザーの名前は長すぎないこと
  it "does not have too long name" do
    user.name = "a"*31
    expect(user).to be_invalid
  end

  # ユーザーのメールアドレスは長すぎないこと
  it "does not have too long email" do
    user.email = "a"*244+"@example.com"
    expect(user).to be_invalid
  end

  # メールアドレスのフォーマットが無効であること
  it "has invalid email addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to be_invalid, "#{invalid_address.inspect} should be invalid"
    end
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: "duplicate@example.com")
    user = FactoryBot.build(:user, email: "duplicate@example.com")
    expect(user).to be_invalid
  end

  # メールアドレスは大文字小文字を区別しないこと
  it "is invalid with a duplicate email address upcase and downcase" do
    FactoryBot.create(:user, email: "duplicate@example.com")
    user = FactoryBot.build(:user, email: "DUPLICATE@example.com")
    expect(user).to be_invalid
  end

  # メールアドレスは保存される前に小文字になること
  it "email should be saved as downcase" do
    mixed_case_email = "Foo@ExAMPle.cOm"
    case_user = FactoryBot.create(:user, email: mixed_case_email)
    expect(case_user.reload.email).to eq mixed_case_email.downcase
  end
end
