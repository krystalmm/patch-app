FactoryBot.define do
  factory :user do
    name { 'Test User' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'foobarbaz' }
    name_kana { 'テスト　ユーザー' }
    postcode { '1000000' }
    prefecture_code { 13 }
    address_city { '千代田区' }
  end
end
