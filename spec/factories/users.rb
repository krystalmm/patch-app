FactoryBot.define do
  factory :user do
    name { 'Test User' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'foobarbaz' }
    name_kana { 'テスト　ユーザー' }
  end
end
