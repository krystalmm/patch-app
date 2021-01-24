require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(user).to be_valid
  end

  # 名前がなければ無効であること
  it 'is invalid without name' do
    user.name = ' '
    expect(user).to be_invalid
  end

  # メールアドレスがなければ無効であること
  it 'is invalid without email' do
    user.email = ' '
    expect(user).to be_invalid
  end

  # ユーザーの名前は長すぎないこと
  it 'does not have too long name' do
    user.name = 'a' * 31
    expect(user).to be_invalid
  end

  # ユーザーのメールアドレスは長すぎないこと
  it 'does not have too long email' do
    long_email = 'a' * 244
    user.email = "#{long_email}@example.com"
    expect(user).to be_invalid
  end

  # メールアドレスのフォーマットが無効であること
  it 'has invalid email addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com
                           foo@bar..com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to be_invalid, "#{invalid_address.inspect} should be invalid"
    end
  end

  # 重複したメールアドレスなら無効な状態であること
  it 'is invalid with a duplicate email address' do
    FactoryBot.create(:user, email: 'duplicate@example.com')
    user = FactoryBot.build(:user, email: 'duplicate@example.com')
    expect(user).to be_invalid
  end

  # メールアドレスは大文字小文字を区別しないこと
  it 'is invalid with a duplicate email address upcase and downcase' do
    FactoryBot.create(:user, email: 'duplicate@example.com')
    user = FactoryBot.build(:user, email: 'DUPLICATE@example.com')
    expect(user).to be_invalid
  end

  # メールアドレスは保存される前に小文字になること
  it 'email should be saved as downcase' do
    mixed_case_email = 'Foo@ExAMPle.cOm'
    case_user = FactoryBot.create(:user, email: mixed_case_email)
    expect(case_user.reload.email).to eq mixed_case_email.downcase
  end

  # パスワードがなければ無効であること
  it "is invalid without password" do
    user.password = " " * 8
    expect(user).to be_invalid
  end

  # 長さが８文字以上のパスワードでなければ無効であること
  it "is invalid without passwords more than 8 characters" do
    user.password = 'a' * 7
    expect(user).to be_invalid
  end

  # 郵便番号のフォーマットが無効であること
  it "is invalid with a wrong format postcode" do
    invalid_postcodes = %w[1111-111 00-12341 0-244533 123-43281]
    invalid_postcodes.each do |invalid_postcode|
      user.postcode = invalid_postcode
      expect(user).to be_invalid, "#{invalid_postcode.inspect} should be invalid"
    end
  end

  # フリガナがなければ無効であること
  it "is invalid without name_kana" do
    user.name_kana = " "
    expect(user).to be_invalid
  end

  # フリガナはカタカナ(+ー)以外無効であること
  it "is invalid except for Katakana to name_kana" do
    invalid_name_kanas = %w[furigana フリガナ+ /jカナ]
    invalid_name_kanas.each do |kana|
      user.name_kana = kana
      expect(user).to be_invalid, "#{kana.inspect} should be invalid"
    end
  end

  # フリガナはひらがなだった場合カタカナに変換されること
  it "is conversion to katakana" do
    name_hiragana = 'てすとーふりがな'
    hiragana_user = FactoryBot.create(:user, name_kana: name_hiragana)
    expect(hiragana_user.reload.name_kana).to eq name_hiragana.tr('あ-ん', 'ア-ン')
  end

  # 都道府県コードで都道府県名を参照できる
  it "is conversion to jp_prefecture" do
    prefecture_user = FactoryBot.create(:user, prefecture_code: 1)
    expect(prefecture_user.prefecture_name).to eq '北海道'
  end
end

