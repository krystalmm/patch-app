FactoryBot.define do
  factory :card do
    sequence(:customer_id) { |n| n }
    sequence(:card_id) { |n| n }
    sequence(:user_id) { |n| n }
  end
end
