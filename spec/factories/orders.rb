FactoryBot.define do
  factory :order do
    sequence(:user_id) { |n| n }
    sequence(:card_id) { |n| n }
    sequence(:product_id) { |n| n }
    quantity { 1 }
    status { 0 }
    postage { 1111111 }
    price { 10000 }
  end
end
